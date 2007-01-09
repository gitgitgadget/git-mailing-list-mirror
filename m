From: Jeff Garzik <jeff@garzik.org>
Subject: git-am applies half of a patch
Date: Tue, 09 Jan 2007 05:24:43 -0500
Message-ID: <45A36D6B.4010303@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000201040604070001080709"
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Jan 09 11:25:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4EAN-0008J6-Kj
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 11:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbXAIKYr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 05:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbXAIKYq
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 05:24:46 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:33425 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286AbXAIKYp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 05:24:45 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1H4E9s-0003sZ-Df; Tue, 09 Jan 2007 10:24:45 +0000
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36339>

This is a multi-part message in MIME format.
--------------000201040604070001080709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I ran

	git-am --signoff --utf8 /g/tmp/mbox

on the attached file, to apply a patch to libata-dev.git#upstream, and 
it wound up only applying a portion of the patch:

> [jgarzik@pretzel libata-dev]$ git-am --signoff --utf8 /g/tmp/mbox 
> 
> Applying 'Add pci class code for SATA AHCI'
> 
> error: patch fragment without header at line 35: @@ -862,7 +862,7 @@
> error: patch fragment without header at line 50: @@ -15,6 +15,8 @@
> Wrote tree 5d6f3a93bea932c950ac880deca173dd3e84dfcc
> Committed: 317b180bad43133027dc07455f1600f4e8a47d76


It seems quite bad to apply a patch that git-am KNOWS is incomplete.

	Jeff



--------------000201040604070001080709
Content-Type: application/x-bzip;
 name="mbox.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="mbox.bz2"

QlpoOTFBWSZTWWRWXsEABGHfgFZwWf////////q////6YAk/e1at7ce7nXnvSq7zqraoNs8m
260Na69CSSaI9TJJ4DTRNJ4jTVP0p+TVPKfppHqnknkyTxPVPSPJDI2kGRITanoyJqT9NNTK
bTTTU00yDQxGBMaCMgNDEAlEBGKaDRTNNGkA9TJ6amnqGCNA0BpoNANGgYkJo0mJRmNJNNPF
HkwieoGgxqAABkAAHGhoGjTI00aZAYmCAAGgNAaZAYEyBIogmQyNFPCaaJ6DTQmT00TTJB6h
6m1GJptQAaephWP8CFKGLDz8mrs7JybJBEIcBYSeXdhVxnh722T2mCQnkJBxDM8PiQIBjvcW
ybUcQ8XaYevZ7XcUaVo0WOhMvi572kZy8GH6OTHx4CFKrMtPJwLcjkUWA3teofGxi/yiKS7W
1x7Ofc5mhph33OS4elKWZYZc2GVz77suzeFot+eciYgoEZHC7M9orxPR7XBPjKiNMlPDN/Vn
36J1dK1756hTHBHItYqiG6WtMHIuQoZSoEopbEY1gcES/MmUJghqIbaRMRUiSDkO9kn1cRN9
dRQljFVLPVgpdPnLhyb93ritjyDxiM5/uMPKXbabG9qH+UqktlebXykWUX4ldVvxgVSwR1mg
ZfyN4uVgnLoshTUPkM6gBk9M0Rtj+zbbkkvIWkrONu1xMm7Fmhmq1zPi1pu0YsLs+zSzswrI
SqZG/Wxqlu23x3Cng4vOOnm7J9qn3+HP+VHCdrGNI0DMjSj4QALMhrPxIqk01zDd/NZf43TM
e5bKebi6y0YUUJhkycJQ85dE3YWuWKa8j0T7emONFempNpRpvHXP2Mzr84p3AeLRB9+jWKQV
oWdOOloYATjwoPoUsFDr+9Gqa30+5ny8dNtUDEOlDPLwxRQSG3UAJpjtF+MAvlaEps8dR0hL
zsdo6YkCqAXbAyDxEcRK4xlvKoqrRJ31IopWjwtgYREiEPUwH14oxGNtlAtGOSTtPUdZ/20F
4LVIxj6aIRHeBkoXQzYQ3ukyoXe18GFtqENsFtKQRKlupk4RzLLTFoHQjIICGMGaQXqSMMjn
x4oJ1CUioiRVClCMQYNywYBK7iUyJBhMiUmCpKmcUq5HcKSSCCI0PjzhAsAH3YGpwsgAWNDP
OwRgqgLC0JMxynflN0UqNYRnoXOAqamg50+J4wQ4ZMOAPjqpcCZgC4kVg3fARTmhSjhsKMuO
UvxF9tmgyFpf2KBXAu3sLn7cMjZol0ocmlzlIqQWRuNSb7o1N8A/PUu9D5YYsjnzwPWGwxIb
kZum+BItaFt6iLN96WTBwCA4ZmWpmQqkJxekjANFv9klMwkDAuPRyRiDkqpu7Xr1p3FoqIKS
YiXxZTULq0x6G4KjF2qPmILrJCdFy5cb4RM8G2acwEEAsRUQoUaoqS9oURihkGs7809VebX1
sCrhH5H73Rp83NXKsYshKrj3G8X7iYk1UwgxUbjT2PTU2IhFA69M+CpXRf5z8UCcsGx4ISC5
nVc7xsXG7jRfOoSNy1SOpNp+tix0+UMfFk0VYixNh3P0GPxAqD6A2X0PHu2/Xm/Vx5uXxF27
QX33BmZy7gcH/cmxgTIMjyC4M6uy5KL1rnl8/SHw7ujkrfBQZMkF2yC76Fj5rdq29TCH+MPV
mZH/NSJavCeQ47WWdDW2L0nSpaoG/SnOVYDacVYQR5cm9o8VO/k7N2FdgwOCRlagoBXtuwsP
Cd2zwdxVBBNcFip2GIhTJuc4M5eqGm2U0Ehcd350G7ssujXB/UcRaZ+PBeD7d8i5ZXA68C4V
c3Z/ZGtdt22pYQFmEtzA5TLg3427LMWvm/2MoCWZVYkd1n7kBeMFqNi1G8NY0kxDttosvmtA
sKnBe7cBW7jfRApY4zqVWhF5kAW+s2ntpgNUPRg1hFtbEZLFt9XttW+KpuAe8O2M92ejYF3q
yYlPe9fr926qg1jEstXkEPYyRpTtVgo+BYaSH2IfKFrVJGM1i7Hzdh3PDuaQfNqb1tSW9Hwn
kEQuGpHELyOnKu/uSJiuR8B3llPtxisoRZQcJPGwK97bK44Cbx4dmkNwuffnm+1X0xh1DDZx
ecv+IGkV1vcBQ519sKdeeIaxfOP7ZQx/E25RDpvHAJpH5kVIDTLEsC4y4td4qLitPzJjWgjW
44pZHuMPOwJXXMTR2rscOpZw/hKe7NTiRzK0W+OzfrRTxAXwyhRPKZtZZFKONdcwRhqy3H61
55IQYWx7qXCgalU1WVXgV3BxaWkS/TPN0gF9afSIit1w2oKVbndX+cNcwrSVNBKkjVLyoj3M
V/NrnSjqTt7DOJUxi5s6SJN2pB8WX+Iy7jpC/aoraK7p8is4RMOBwYuuZUmeQlUJmKJ7C6op
ZOOJ2YFmGjXL4cFhM6N5m1FXQUHBEpDJk5YGbl30BLsHECVCs7WuNA3XGNbAOJvbmOYF5vqM
XBCABvImuA6ytES3l9QRiNmvQphbq1Hw/FK+kx7xppMMhHMGspSmvRLpmkexSAKkyN5xQ2c9
ExOzhwnQK0WakEgE2GGvo8umZPsrZ9sHPuoq1Urhv1uMJb4ZRJgpvhIHFDDcIzVEMQcCfnYC
kXca5KtBFJ8t3arCJ5Eklgt0hMuIJAvYY2iN79YxRUHPZ3uzkJxigfppiKWTwrxJ0uZbq8hk
y2yjZ1gq3yOjjrqOVUdzWk6Ig9WMVdHBNoOereDKQDwhIM35EEs6SKCXjChTJMK4WarNV0mK
AkQpyZ50SDXlx3rb7M7u33PgGPH1x1SFc4KazbkjhIxjDqqxIwW64BMtgxg1SubCTsNuxHdP
nSR1MU1+XTA65zEFzFAnL+TDA797pV612YTkA6Fypm56C706Z2aqISl7QSfLTNG0FtLUpEB5
mXO/Lqu4QVHINKm59NPo1XZTj6lQAo6CWItRMBOiMltpI2cQNwETsYkDGjGgZ819B6EyFvLn
qyheBgF5uqzB3PLC4FhvB6TBSjBktUmamK37RVhNlHtqxkVdRMuSEhQ11Vk/G+YT2MJupXAw
YvIZDSmh0GaaOZEMNQbaCNIoJqodyQUse1kT0wMV+vj0DkuTlNbOiX3FWOc+OAsW2HKkWC/o
25RZaxjtS/Ko2I6lQHjTeGaCSI2C8jewL5WNL0EzAqzwh2JpnAwha5gt8/Pe2p0QXMtctvfW
doF4AmP6qeAU5IC00oQrLKFVIoky+jLhkjFcFfncTWMm/02l8bX/i7kinChIMisvYIA=
--------------000201040604070001080709--
