# CIE Standard white-points
# -------------------------

const WP_A   = XYZ(1.09850, 1.00000, 0.35585)
const WP_B   = XYZ(0.99072, 1.00000, 0.85223)
const WP_C   = XYZ(0.98074, 1.00000, 1.18232)
const WP_D50 = XYZ(0.96422, 1.00000, 0.82521)
const WP_D55 = XYZ(0.95682, 1.00000, 0.92149)
const WP_D65 = XYZ(0.95047, 1.00000, 1.08883)
const WP_D75 = XYZ(0.94972, 1.00000, 1.22638)
const WP_E   = XYZ(1.00000, 1.00000, 1.00000)
const WP_F2  = XYZ(0.99186, 1.00000, 0.67393)
const WP_F7  = XYZ(0.95041, 1.00000, 1.08747)
const WP_F11 = XYZ(1.00962, 1.00000, 0.64350)
const WP_DEFAULT = WP_D65


# CIE Color Matching
# ------------------

# Evaluate the CIE standard observer color match function.
#
# Args:
#   wavelen: Wavelength of stimulus in nanometers.
#
# Returns:
#   XYZ value of perceived color.
#
function cie_color_match(wavelen::Real)
    a = floor(wavelen)
    ac = 380 <= a <= 780 ? cie_color_match_table[a - 380 + 1,:] : [0 0 0]

    if wavelen != a
        b = ceil(wavelen)
        bc = 380 <= b <= 780 ? cie_color_match_table[b - 380 + 1,:] : [0 0 0]
        p = wavelen - a
        ac = p * bc + (1.0 - p) * ac
    end
    XYZ(ac[1], ac[2], ac[3])
end

# CIE standard observer, giving the response in XYZ to wavelengths in nanometer
# increments starting at 380nm.
const cie_color_match_table =
    [1.368000e-03  3.900000e-05  6.450001e-03;
     1.502050e-03  4.282640e-05  7.083216e-03;
     1.642328e-03  4.691460e-05  7.745488e-03;
     1.802382e-03  5.158960e-05  8.501152e-03;
     1.995757e-03  5.717640e-05  9.414544e-03;
     2.236000e-03  6.400000e-05  1.054999e-02;
     2.535385e-03  7.234421e-05  1.196580e-02;
     2.892603e-03  8.221224e-05  1.365587e-02;
     3.300829e-03  9.350816e-05  1.558805e-02;
     3.753236e-03  1.061361e-04  1.773015e-02;
     4.243000e-03  1.200000e-04  2.005001e-02;
     4.762389e-03  1.349840e-04  2.251136e-02;
     5.330048e-03  1.514920e-04  2.520288e-02;
     5.978712e-03  1.702080e-04  2.827972e-02;
     6.741117e-03  1.918160e-04  3.189704e-02;
     7.650000e-03  2.170000e-04  3.621000e-02;
     8.751373e-03  2.469067e-04  4.143771e-02;
     1.002888e-02  2.812400e-04  4.750372e-02;
     1.142170e-02  3.185200e-04  5.411988e-02;
     1.286901e-02  3.572667e-04  6.099803e-02;
     1.431000e-02  3.960000e-04  6.785001e-02;
     1.570443e-02  4.337147e-04  7.448632e-02;
     1.714744e-02  4.730240e-04  8.136156e-02;
     1.878122e-02  5.178760e-04  8.915364e-02;
     2.074801e-02  5.722187e-04  9.854048e-02;
     2.319000e-02  6.400000e-04  1.102000e-01;
     2.620736e-02  7.245600e-04  1.246133e-01;
     2.978248e-02  8.255000e-04  1.417017e-01;
     3.388092e-02  9.411600e-04  1.613035e-01;
     3.846824e-02  1.069880e-03  1.832568e-01;
     4.351000e-02  1.210000e-03  2.074000e-01;
     4.899560e-02  1.362091e-03  2.336921e-01;
     5.502260e-02  1.530752e-03  2.626114e-01;
     6.171880e-02  1.720368e-03  2.947746e-01;
     6.921200e-02  1.935323e-03  3.307985e-01;
     7.763000e-02  2.180000e-03  3.713000e-01;
     8.695811e-02  2.454800e-03  4.162091e-01;
     9.717672e-02  2.764000e-03  4.654642e-01;
     1.084063e-01  3.117800e-03  5.196948e-01;
     1.207672e-01  3.526400e-03  5.795303e-01;
     1.343800e-01  4.000000e-03  6.456000e-01;
     1.493582e-01  4.546240e-03  7.184838e-01;
     1.653957e-01  5.159320e-03  7.967133e-01;
     1.819831e-01  5.829280e-03  8.778459e-01;
     1.986110e-01  6.546160e-03  9.594390e-01;
     2.147700e-01  7.300000e-03  1.039050e+00;
     2.301868e-01  8.086507e-03  1.115367e+00;
     2.448797e-01  8.908720e-03  1.188497e+00;
     2.587773e-01  9.767680e-03  1.258123e+00;
     2.718079e-01  1.066443e-02  1.323930e+00;
     2.839000e-01  1.160000e-02  1.385600e+00;
     2.949438e-01  1.257317e-02  1.442635e+00;
     3.048965e-01  1.358272e-02  1.494803e+00;
     3.137873e-01  1.462968e-02  1.542190e+00;
     3.216454e-01  1.571509e-02  1.584881e+00;
     3.285000e-01  1.684000e-02  1.622960e+00;
     3.343513e-01  1.800736e-02  1.656405e+00;
     3.392101e-01  1.921448e-02  1.685296e+00;
     3.431213e-01  2.045392e-02  1.709874e+00;
     3.461296e-01  2.171824e-02  1.730382e+00;
     3.482800e-01  2.300000e-02  1.747060e+00;
     3.495999e-01  2.429461e-02  1.760045e+00;
     3.501474e-01  2.561024e-02  1.769623e+00;
     3.500130e-01  2.695857e-02  1.776264e+00;
     3.492870e-01  2.835125e-02  1.780433e+00;
     3.480600e-01  2.980000e-02  1.782600e+00;
     3.463733e-01  3.131083e-02  1.782968e+00;
     3.442624e-01  3.288368e-02  1.781700e+00;
     3.418088e-01  3.452112e-02  1.779198e+00;
     3.390941e-01  3.622571e-02  1.775867e+00;
     3.362000e-01  3.800000e-02  1.772110e+00;
     3.331977e-01  3.984667e-02  1.768259e+00;
     3.300411e-01  4.176800e-02  1.764039e+00;
     3.266357e-01  4.376600e-02  1.758944e+00;
     3.228868e-01  4.584267e-02  1.752466e+00;
     3.187000e-01  4.800000e-02  1.744100e+00;
     3.140251e-01  5.024368e-02  1.733559e+00;
     3.088840e-01  5.257304e-02  1.720858e+00;
     3.032904e-01  5.498056e-02  1.705937e+00;
     2.972579e-01  5.745872e-02  1.688737e+00;
     2.908000e-01  6.000000e-02  1.669200e+00;
     2.839701e-01  6.260197e-02  1.647529e+00;
     2.767214e-01  6.527752e-02  1.623413e+00;
     2.689178e-01  6.804208e-02  1.596022e+00;
     2.604227e-01  7.091109e-02  1.564528e+00;
     2.511000e-01  7.390000e-02  1.528100e+00;
     2.408475e-01  7.701600e-02  1.486111e+00;
     2.298512e-01  8.026640e-02  1.439521e+00;
     2.184072e-01  8.366680e-02  1.389880e+00;
     2.068115e-01  8.723280e-02  1.338736e+00;
     1.953600e-01  9.098000e-02  1.287640e+00;
     1.842136e-01  9.491755e-02  1.237422e+00;
     1.733273e-01  9.904584e-02  1.187824e+00;
     1.626881e-01  1.033674e-01  1.138761e+00;
     1.522833e-01  1.078846e-01  1.090148e+00;
     1.421000e-01  1.126000e-01  1.041900e+00;
     1.321786e-01  1.175320e-01  9.941976e-01;
     1.225696e-01  1.226744e-01  9.473473e-01;
     1.132752e-01  1.279928e-01  9.014531e-01;
     1.042979e-01  1.334528e-01  8.566193e-01;
     9.564000e-02  1.390200e-01  8.129501e-01;
     8.729955e-02  1.446764e-01  7.705173e-01;
     7.930804e-02  1.504693e-01  7.294448e-01;
     7.171776e-02  1.564619e-01  6.899136e-01;
     6.458099e-02  1.627177e-01  6.521049e-01;
     5.795001e-02  1.693000e-01  6.162000e-01;
     5.186211e-02  1.762431e-01  5.823286e-01;
     4.628152e-02  1.835581e-01  5.504162e-01;
     4.115088e-02  1.912735e-01  5.203376e-01;
     3.641283e-02  1.994180e-01  4.919673e-01;
     3.201000e-02  2.080200e-01  4.651800e-01;
     2.791720e-02  2.171199e-01  4.399246e-01;
     2.414440e-02  2.267345e-01  4.161836e-01;
     2.068700e-02  2.368571e-01  3.938822e-01;
     1.754040e-02  2.474812e-01  3.729459e-01;
     1.470000e-02  2.586000e-01  3.533000e-01;
     1.216179e-02  2.701849e-01  3.348578e-01;
     9.919960e-03  2.822939e-01  3.175521e-01;
     7.967240e-03  2.950505e-01  3.013375e-01;
     6.296346e-03  3.085780e-01  2.861686e-01;
     4.900000e-03  3.230000e-01  2.720000e-01;
     3.777173e-03  3.384021e-01  2.588171e-01;
     2.945320e-03  3.546858e-01  2.464838e-01;
     2.424880e-03  3.716986e-01  2.347718e-01;
     2.236293e-03  3.892875e-01  2.234533e-01;
     2.400000e-03  4.073000e-01  2.123000e-01;
     2.925520e-03  4.256299e-01  2.011692e-01;
     3.836560e-03  4.443096e-01  1.901196e-01;
     5.174840e-03  4.633944e-01  1.792254e-01;
     6.982080e-03  4.829395e-01  1.685608e-01;
     9.300000e-03  5.030000e-01  1.582000e-01;
     1.214949e-02  5.235693e-01  1.481383e-01;
     1.553588e-02  5.445120e-01  1.383758e-01;
     1.947752e-02  5.656900e-01  1.289942e-01;
     2.399277e-02  5.869653e-01  1.200751e-01;
     2.910000e-02  6.082000e-01  1.117000e-01;
     3.481485e-02  6.293456e-01  1.039048e-01;
     4.112016e-02  6.503068e-01  9.666748e-02;
     4.798504e-02  6.708752e-01  8.998272e-02;
     5.537861e-02  6.908424e-01  8.384531e-02;
     6.327000e-02  7.100000e-01  7.824999e-02;
     7.163501e-02  7.281852e-01  7.320899e-02;
     8.046224e-02  7.454636e-01  6.867816e-02;
     8.973996e-02  7.619694e-01  6.456784e-02;
     9.945645e-02  7.778368e-01  6.078835e-02;
     1.096000e-01  7.932000e-01  5.725001e-02;
     1.201674e-01  8.081104e-01  5.390435e-02;
     1.311145e-01  8.224962e-01  5.074664e-02;
     1.423679e-01  8.363068e-01  4.775276e-02;
     1.538542e-01  8.494916e-01  4.489859e-02;
     1.655000e-01  8.620000e-01  4.216000e-02;
     1.772571e-01  8.738108e-01  3.950728e-02;
     1.891400e-01  8.849624e-01  3.693564e-02;
     2.011694e-01  8.954936e-01  3.445836e-02;
     2.133658e-01  9.054432e-01  3.208872e-02;
     2.257499e-01  9.148501e-01  2.984000e-02;
     2.383209e-01  9.237348e-01  2.771181e-02;
     2.510668e-01  9.320924e-01  2.569444e-02;
     2.639922e-01  9.399226e-01  2.378716e-02;
     2.771017e-01  9.472252e-01  2.198925e-02;
     2.904000e-01  9.540000e-01  2.030000e-02;
     3.038912e-01  9.602561e-01  1.871805e-02;
     3.175726e-01  9.660074e-01  1.724036e-02;
     3.314384e-01  9.712606e-01  1.586364e-02;
     3.454828e-01  9.760225e-01  1.458461e-02;
     3.597000e-01  9.803000e-01  1.340000e-02;
     3.740839e-01  9.840924e-01  1.230723e-02;
     3.886396e-01  9.874182e-01  1.130188e-02;
     4.033784e-01  9.903128e-01  1.037792e-02;
     4.183115e-01  9.928116e-01  9.529306e-03;
     4.334499e-01  9.949501e-01  8.749999e-03;
     4.487953e-01  9.967108e-01  8.035200e-03;
     4.643360e-01  9.980983e-01  7.381600e-03;
     4.800640e-01  9.991120e-01  6.785400e-03;
     4.959713e-01  9.997482e-01  6.242800e-03;
     5.120501e-01  1.000000e+00  5.749999e-03;
     5.282959e-01  9.998567e-01  5.303600e-03;
     5.446916e-01  9.993046e-01  4.899800e-03;
     5.612094e-01  9.983255e-01  4.534200e-03;
     5.778215e-01  9.968987e-01  4.202400e-03;
     5.945000e-01  9.950000e-01  3.900000e-03;
     6.112209e-01  9.926005e-01  3.623200e-03;
     6.279758e-01  9.897426e-01  3.370600e-03;
     6.447602e-01  9.864444e-01  3.141400e-03;
     6.615697e-01  9.827241e-01  2.934800e-03;
     6.784000e-01  9.786000e-01  2.749999e-03;
     6.952392e-01  9.740837e-01  2.585200e-03;
     7.120586e-01  9.691712e-01  2.438600e-03;
     7.288284e-01  9.638568e-01  2.309400e-03;
     7.455188e-01  9.581349e-01  2.196800e-03;
     7.621000e-01  9.520000e-01  2.100000e-03;
     7.785432e-01  9.454504e-01  2.017733e-03;
     7.948256e-01  9.384992e-01  1.948200e-03;
     8.109264e-01  9.311628e-01  1.889800e-03;
     8.268248e-01  9.234576e-01  1.840933e-03;
     8.425000e-01  9.154000e-01  1.800000e-03;
     8.579325e-01  9.070064e-01  1.766267e-03;
     8.730816e-01  8.982772e-01  1.737800e-03;
     8.878944e-01  8.892048e-01  1.711200e-03;
     9.023181e-01  8.797816e-01  1.683067e-03;
     9.163000e-01  8.700000e-01  1.650001e-03;
     9.297995e-01  8.598613e-01  1.610133e-03;
     9.427984e-01  8.493920e-01  1.564400e-03;
     9.552776e-01  8.386220e-01  1.513600e-03;
     9.672179e-01  8.275813e-01  1.458533e-03;
     9.786000e-01  8.163000e-01  1.400000e-03;
     9.893856e-01  8.047947e-01  1.336667e-03;
     9.995488e-01  7.930820e-01  1.270000e-03;
     1.009089e+00  7.811920e-01  1.205000e-03;
     1.018006e+00  7.691547e-01  1.146667e-03;
     1.026300e+00  7.570000e-01  1.100000e-03;
     1.033983e+00  7.447541e-01  1.068800e-03;
     1.040986e+00  7.324224e-01  1.049400e-03;
     1.047188e+00  7.200036e-01  1.035600e-03;
     1.052467e+00  7.074965e-01  1.021200e-03;
     1.056700e+00  6.949000e-01  1.000000e-03;
     1.059794e+00  6.822192e-01  9.686400e-04;
     1.061799e+00  6.694716e-01  9.299200e-04;
     1.062807e+00  6.566744e-01  8.868800e-04;
     1.062910e+00  6.438448e-01  8.425600e-04;
     1.062200e+00  6.310000e-01  8.000000e-04;
     1.060735e+00  6.181555e-01  7.609600e-04;
     1.058444e+00  6.053144e-01  7.236800e-04;
     1.055224e+00  5.924756e-01  6.859200e-04;
     1.050977e+00  5.796379e-01  6.454400e-04;
     1.045600e+00  5.668000e-01  6.000000e-04;
     1.039037e+00  5.539611e-01  5.478667e-04;
     1.031361e+00  5.411372e-01  4.916000e-04;
     1.022666e+00  5.283528e-01  4.354000e-04;
     1.013048e+00  5.156323e-01  3.834667e-04;
     1.002600e+00  5.030000e-01  3.400000e-04;
     9.913675e-01  4.904688e-01  3.072533e-04;
     9.793314e-01  4.780304e-01  2.831600e-04;
     9.664916e-01  4.656776e-01  2.654400e-04;
     9.528479e-01  4.534032e-01  2.518133e-04;
     9.384000e-01  4.412000e-01  2.400000e-04;
     9.231940e-01  4.290800e-01  2.295467e-04;
     9.072440e-01  4.170360e-01  2.206400e-04;
     8.905020e-01  4.050320e-01  2.119600e-04;
     8.729200e-01  3.930320e-01  2.021867e-04;
     8.544499e-01  3.810000e-01  1.900000e-04;
     8.350840e-01  3.689184e-01  1.742133e-04;
     8.149460e-01  3.568272e-01  1.556400e-04;
     7.941860e-01  3.447768e-01  1.359600e-04;
     7.729540e-01  3.328176e-01  1.168533e-04;
     7.514000e-01  3.210000e-01  1.000000e-04;
     7.295836e-01  3.093381e-01  8.613333e-05;
     7.075888e-01  2.978504e-01  7.460000e-05;
     6.856022e-01  2.865936e-01  6.500000e-05;
     6.638104e-01  2.756245e-01  5.693333e-05;
     6.424000e-01  2.650000e-01  4.999999e-05;
     6.215149e-01  2.547632e-01  4.416000e-05;
     6.011138e-01  2.448896e-01  3.948000e-05;
     5.811052e-01  2.353344e-01  3.572000e-05;
     5.613977e-01  2.260528e-01  3.264000e-05;
     5.419000e-01  2.170000e-01  3.000000e-05;
     5.225995e-01  2.081616e-01  2.765333e-05;
     5.035464e-01  1.995488e-01  2.556000e-05;
     4.847436e-01  1.911552e-01  2.364000e-05;
     4.661939e-01  1.829744e-01  2.181333e-05;
     4.479000e-01  1.750000e-01  2.000000e-05;
     4.298613e-01  1.672235e-01  1.813333e-05;
     4.120980e-01  1.596464e-01  1.620000e-05;
     3.946440e-01  1.522776e-01  1.420000e-05;
     3.775333e-01  1.451259e-01  1.213333e-05;
     3.608000e-01  1.382000e-01  1.000000e-05;
     3.444563e-01  1.315003e-01  7.733333e-06;
     3.285168e-01  1.250248e-01  5.400000e-06;
     3.130192e-01  1.187792e-01  3.200000e-06;
     2.980011e-01  1.127691e-01  1.333333e-06;
     2.835000e-01  1.070000e-01  0.000000e+00;
     2.695448e-01  1.014762e-01  0.000000e+00;
     2.561184e-01  9.618864e-02  0.000000e+00;
     2.431896e-01  9.112296e-02  0.000000e+00;
     2.307272e-01  8.626485e-02  0.000000e+00;
     2.187000e-01  8.160000e-02  0.000000e+00;
     2.070971e-01  7.712064e-02  0.000000e+00;
     1.959232e-01  7.282552e-02  0.000000e+00;
     1.851708e-01  6.871008e-02  0.000000e+00;
     1.748323e-01  6.476976e-02  0.000000e+00;
     1.649000e-01  6.100000e-02  0.000000e+00;
     1.553667e-01  5.739621e-02  0.000000e+00;
     1.462300e-01  5.395504e-02  0.000000e+00;
     1.374900e-01  5.067376e-02  0.000000e+00;
     1.291467e-01  4.754965e-02  0.000000e+00;
     1.212000e-01  4.458000e-02  0.000000e+00;
     1.136397e-01  4.175872e-02  0.000000e+00;
     1.064650e-01  3.908496e-02  0.000000e+00;
     9.969044e-02  3.656384e-02  0.000000e+00;
     9.333061e-02  3.420048e-02  0.000000e+00;
     8.740000e-02  3.200000e-02  0.000000e+00;
     8.190096e-02  2.996261e-02  0.000000e+00;
     7.680428e-02  2.807664e-02  0.000000e+00;
     7.207712e-02  2.632936e-02  0.000000e+00;
     6.768664e-02  2.470805e-02  0.000000e+00;
     6.360000e-02  2.320000e-02  0.000000e+00;
     5.980685e-02  2.180077e-02  0.000000e+00;
     5.628216e-02  2.050112e-02  0.000000e+00;
     5.297104e-02  1.928108e-02  0.000000e+00;
     4.981861e-02  1.812069e-02  0.000000e+00;
     4.677000e-02  1.700000e-02  0.000000e+00;
     4.378405e-02  1.590379e-02  0.000000e+00;
     4.087536e-02  1.483718e-02  0.000000e+00;
     3.807264e-02  1.381068e-02  0.000000e+00;
     3.540461e-02  1.283478e-02  0.000000e+00;
     3.290000e-02  1.192000e-02  0.000000e+00;
     3.056419e-02  1.106831e-02  0.000000e+00;
     2.838056e-02  1.027339e-02  0.000000e+00;
     2.634484e-02  9.533311e-03  0.000000e+00;
     2.445275e-02  8.846157e-03  0.000000e+00;
     2.270000e-02  8.210000e-03  0.000000e+00;
     2.108429e-02  7.623781e-03  0.000000e+00;
     1.959988e-02  7.085424e-03  0.000000e+00;
     1.823732e-02  6.591476e-03  0.000000e+00;
     1.698717e-02  6.138485e-03  0.000000e+00;
     1.584000e-02  5.723000e-03  0.000000e+00;
     1.479064e-02  5.343059e-03  0.000000e+00;
     1.383132e-02  4.995796e-03  0.000000e+00;
     1.294868e-02  4.676404e-03  0.000000e+00;
     1.212920e-02  4.380075e-03  0.000000e+00;
     1.135916e-02  4.102000e-03  0.000000e+00;
     1.062935e-02  3.838453e-03  0.000000e+00;
     9.938846e-03  3.589099e-03  0.000000e+00;
     9.288422e-03  3.354219e-03  0.000000e+00;
     8.678854e-03  3.134093e-03  0.000000e+00;
     8.110916e-03  2.929000e-03  0.000000e+00;
     7.582388e-03  2.738139e-03  0.000000e+00;
     7.088746e-03  2.559876e-03  0.000000e+00;
     6.627313e-03  2.393244e-03  0.000000e+00;
     6.195408e-03  2.237275e-03  0.000000e+00;
     5.790346e-03  2.091000e-03  0.000000e+00;
     5.409826e-03  1.953587e-03  0.000000e+00;
     5.052583e-03  1.824580e-03  0.000000e+00;
     4.717512e-03  1.703580e-03  0.000000e+00;
     4.403507e-03  1.590187e-03  0.000000e+00;
     4.109457e-03  1.484000e-03  0.000000e+00;
     3.833913e-03  1.384496e-03  0.000000e+00;
     3.575748e-03  1.291268e-03  0.000000e+00;
     3.334342e-03  1.204092e-03  0.000000e+00;
     3.109075e-03  1.122744e-03  0.000000e+00;
     2.899327e-03  1.047000e-03  0.000000e+00;
     2.704348e-03  9.765896e-04  0.000000e+00;
     2.523020e-03  9.111088e-04  0.000000e+00;
     2.354168e-03  8.501332e-04  0.000000e+00;
     2.196616e-03  7.932384e-04  0.000000e+00;
     2.049190e-03  7.400000e-04  0.000000e+00;
     1.910960e-03  6.900827e-04  0.000000e+00;
     1.781438e-03  6.433100e-04  0.000000e+00;
     1.660110e-03  5.994960e-04  0.000000e+00;
     1.546459e-03  5.584547e-04  0.000000e+00;
     1.439971e-03  5.200000e-04  0.000000e+00;
     1.340042e-03  4.839136e-04  0.000000e+00;
     1.246275e-03  4.500528e-04  0.000000e+00;
     1.158471e-03  4.183452e-04  0.000000e+00;
     1.076430e-03  3.887184e-04  0.000000e+00;
     9.999493e-04  3.611000e-04  0.000000e+00;
     9.287358e-04  3.353835e-04  0.000000e+00;
     8.624332e-04  3.114404e-04  0.000000e+00;
     8.007503e-04  2.891656e-04  0.000000e+00;
     7.433960e-04  2.684539e-04  0.000000e+00;
     6.900786e-04  2.492000e-04  0.000000e+00;
     6.405156e-04  2.313019e-04  0.000000e+00;
     5.945021e-04  2.146856e-04  0.000000e+00;
     5.518646e-04  1.992884e-04  0.000000e+00;
     5.124290e-04  1.850475e-04  0.000000e+00;
     4.760213e-04  1.719000e-04  0.000000e+00;
     4.424536e-04  1.597781e-04  0.000000e+00;
     4.115117e-04  1.486044e-04  0.000000e+00;
     3.829814e-04  1.383016e-04  0.000000e+00;
     3.566491e-04  1.287925e-04  0.000000e+00;
     3.323011e-04  1.200000e-04  0.000000e+00;
     3.097586e-04  1.118595e-04  0.000000e+00;
     2.888871e-04  1.043224e-04  0.000000e+00;
     2.695394e-04  9.733560e-05  0.000000e+00;
     2.515682e-04  9.084587e-05  0.000000e+00;
     2.348261e-04  8.480000e-05  0.000000e+00;
     2.191710e-04  7.914667e-05  0.000000e+00;
     2.045258e-04  7.385800e-05  0.000000e+00;
     1.908405e-04  6.891600e-05  0.000000e+00;
     1.780654e-04  6.430267e-05  0.000000e+00;
     1.661505e-04  6.000000e-05  0.000000e+00;
     1.550236e-04  5.598187e-05  0.000000e+00;
     1.446219e-04  5.222560e-05  0.000000e+00;
     1.349098e-04  4.871840e-05  0.000000e+00;
     1.258520e-04  4.544747e-05  0.000000e+00;
     1.174130e-04  4.240000e-05  0.000000e+00;
     1.095515e-04  3.956104e-05  0.000000e+00;
     1.022245e-04  3.691512e-05  0.000000e+00;
     9.539445e-05  3.444868e-05  0.000000e+00;
     8.902390e-05  3.214816e-05  0.000000e+00;
     8.307527e-05  3.000000e-05  0.000000e+00;
     7.751269e-05  2.799125e-05  0.000000e+00;
     7.231304e-05  2.611356e-05  0.000000e+00;
     6.745778e-05  2.436024e-05  0.000000e+00;
     6.292844e-05  2.272461e-05  0.000000e+00;
     5.870652e-05  2.120000e-05  0.000000e+00;
     5.477028e-05  1.977855e-05  0.000000e+00;
     5.109918e-05  1.845285e-05  0.000000e+00;
     4.767654e-05  1.721687e-05  0.000000e+00;
     4.448567e-05  1.606459e-05  0.000000e+00;
     4.150994e-05  1.499000e-05  0.000000e+00]


