module Data.WavefrontObjSpec (spec) where

import Linear
import Linear.Affine
import Test.Hspec

import Data.WavefrontObj

genFace :: [((Double, Double, Double), (Double, Double), (Double, Double, Double))] -> WavefrontFace
genFace xs = WavefrontFace $ fmap genFace' xs
    where 
        genFace' ((vx, vy, vz), (tx, ty), (nx, ny, nz)) = WavefrontVertex (P (V3 vx vy vz)) (Just $ P (V2 tx ty)) (Just $ V3 nx ny nz)

firstTenFaces :: [WavefrontFace]
firstTenFaces = fmap genFace [
      [((0.134781, -0.14723, 0.48805), (0.532, 0.923), (-0.485, 0.523, -0.701)), ((0.131261, -0.132153, 0.49872), (0.535, 0.917), (-0.121, 0.869, -0.48)), ((0.14749, -0.135105, 0.489565), (0.542, 0.923), (-0.215, 0.93, -0.298))]
    , [((0.134781, -0.14723, 0.48805), (0.532, 0.923), (-0.485, 0.523, -0.701)), ((0.14749, -0.135105, 0.489565), (0.542, 0.923), (-0.215, 0.93, -0.298)), ((0.153371, -0.140519, 0.477416), (0.541, 0.929), (-0.574, 0.744, -0.343))]
    , [((7.5062e-2, -4.73306e-2, 0.49955), (0.521, 0.984), (-0.277, -0.779, -0.562)), ((6.95841e-2, -9.97942e-2, 0.550277), (0.521, 0.996), (-0.258, -0.731, -0.632)), ((3.02569e-2, -9.71868e-2, 0.55389), (0.505, 0.998), (-4.6e-2, -0.809, -0.586))]
    , [((7.5062e-2, -4.73306e-2, 0.49955), (0.521, 0.984), (-0.277, -0.779, -0.562)), ((3.02569e-2, -9.71868e-2, 0.55389), (0.505, 0.998), (-4.6e-2, -0.809, -0.586)), ((6.86924e-4, -5.34984e-2, 0.505694), (0.5, 0.985), (0.0, -0.806, -0.591))]
    , [((3.54892e-2, -0.12785, 0.535159), (0.504, 0.917), (-9.4e-2, 0.624, -0.775)), ((3.89268e-2, -0.109557, 0.550558), (0.507, 0.91), (1.5e-2, 0.952, -0.307)), ((7.34835e-2, -0.11538, 0.538029), (0.516, 0.91), (4.5e-2, 0.919, -0.392))]
    , [((3.54892e-2, -0.12785, 0.535159), (0.504, 0.917), (-9.4e-2, 0.624, -0.775)), ((7.34835e-2, -0.11538, 0.538029), (0.516, 0.91), (4.5e-2, 0.919, -0.392)), ((7.45124e-2, -0.135953, 0.523215), (0.515, 0.918), (-0.21, 0.565, -0.798))]
    , [((0.107415, -0.144295, 0.5047), (0.523, 0.921), (-0.379, 0.493, -0.783)), ((7.45124e-2, -0.135953, 0.523215), (0.515, 0.918), (-0.21, 0.565, -0.798)), ((7.34835e-2, -0.11538, 0.538029), (0.516, 0.91), (4.5e-2, 0.919, -0.392))]
    , [((0.107415, -0.144295, 0.5047), (0.523, 0.921), (-0.379, 0.493, -0.783)), ((7.34835e-2, -0.11538, 0.538029), (0.516, 0.91), (4.5e-2, 0.919, -0.392)), ((0.106386, -0.125623, 0.51513), (0.525, 0.913), (-9.9e-2, 0.857, -0.505))]
    , [((0.107415, -0.144295, 0.5047), (0.523, 0.921), (-0.379, 0.493, -0.783)), ((0.106386, -0.125623, 0.51513), (0.525, 0.913), (-9.9e-2, 0.857, -0.505)), ((0.131261, -0.132153, 0.49872), (0.535, 0.917), (-0.121, 0.869, -0.48))]
    , [((0.107415, -0.144295, 0.5047), (0.523, 0.921), (-0.379, 0.493, -0.783)), ((0.131261, -0.132153, 0.49872), (0.535, 0.917), (-0.121, 0.869, -0.48)), ((0.134781, -0.14723, 0.48805), (0.532, 0.923), (-0.485, 0.523, -0.701))]
    ]

spec :: Spec
spec = do
    describe "model loader" $ do
        it "loads the first ten faces of the model correctly" $ do
            Right (WavefrontModel faces) <- loadWavefrontObj "test/african_head.obj"
            take 10 faces `shouldBe` firstTenFaces
