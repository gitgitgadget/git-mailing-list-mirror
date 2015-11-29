From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [RFC] OS X El Capitan + Xcode ships without SSL header?!
Date: Sun, 29 Nov 2015 18:04:54 +0100
Message-ID: <565B3036.8000604@web.de>
References: <BBD3F9B1-9FCA-4207-B374-3ADCF19F1431@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Lars Schneider <larsxschneider@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Nov 29 18:05:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a35PO-0002ax-9P
	for gcvg-git-2@plane.gmane.org; Sun, 29 Nov 2015 18:05:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbbK2RFG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Nov 2015 12:05:06 -0500
Received: from mout.web.de ([212.227.15.3]:64561 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935AbbK2RFF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2015 12:05:05 -0500
Received: from macce11.local ([213.66.56.100]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MeNUV-1ZfEMF2Mff-00QAFN; Sun, 29 Nov 2015 18:05:00
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <BBD3F9B1-9FCA-4207-B374-3ADCF19F1431@gmail.com>
X-Provags-ID: V03:K0:UqDnOB51BQXVv9jsD+bx/e9OpTGsnCKRNHVwNy+IqZ8fHLebdV/
 LXjycrLoHYjZ89UwgS03EFr84p+/JlZb+prj7lOK/Cm0DiGpXEy6SngfNHK8Ivb1o/IrtOq
 4yzxMeKrZJSeacjQuE9vp11JS5GjrxrdEmtb5G4odyNq9hF1zJ6E+Z5vB0lG3CEuw2fV4RS
 Llv1mqdyR4RkJk3PrzNsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2jTIYPgJ1b4=:OklV0PRABhMZpl76fwnB5y
 a1oGpVWhF6HYARedIjG4yRbUJd3xq/xOH3DpwJA6Jh1hfGAAEK+OW+epyRhtcLQBEm+A2xFrU
 3LdbIhXGFCIoXKp8HhqiHpwZjstE0kpH3Mml//BUjrvlUzfeO2D5CaY0veBZZC3hhocNXFsYj
 /lsYsAh4zsdH2C0lJ+ax6CFCOLwyu7H5NJKuPLSu9N7IXA9WzgY+5Cn7Gc+ZNpQB0pIOQPEUz
 BRBfLqMkr+TYqs8plFs7dXQHmlN3aBUoJ8FXNe+q7HkQpqrRl+/sRo2wCcY674Qcn8arCCNVw
 PqLC4KQXbpuc5qRpCb68aot7M0H7U8iX53uOPvyqomk+XeX3JW8KR1tCDcb4jVBIQlZM7/aUB
 WqZnyCK0DrcKDhoCO45dLqBFBUpEJnmPOjV5ka2Mx1Ax6FRE3OmRU516yvyWbqK0SsCsfAfOn
 vx6nWpFPI/WBWK44cCWVFTrmYu+ltt0p/yiCtwtJ479feyRKCHpPOBDcHW7auW7wQnvO9e0ej
 w/D/y+b0/JEC/knA23IQswNhJoX9ZEFFSrwO0US8OwjfpcWdkD5WT9qlT2v+c3uSegD/46ofB
 Wej6jPcZ7gwWVeWDmBRH1/ruCvjh/zD/fl57qkcvBxYB0yyaondtH+rG/W2u2l8tJoZEz4ev3
 xTbtF4jbYxSBE4IHgOsUGEe7JCN6QunyAcJxfljo4r6OoqZJ6dvFsggJ/j/dioA+00hMaOADC
 mfeJmbtNfWLZUKHOr54hdfBrbxpaL55SL+YlbfnZcyjT19iI64lKopaZEf+OjGQG90iiwSd6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281799>

On 21/11/15 19:58, Lars Schneider wrote:
> Hi,
>=20
> I cannot build Git on a clean machine with OS X El Capitan 10.11, Xco=
de 7.1.1 and Xcode command line tools because of missing OpenSSL header=
s.
>=20
> It looks like as there are no OpenSSL headers at all. I only found th=
is weird non working version:
> /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xc=
toolchain/usr/lib/swift-migrator/sdk/MacOSX.sdk/usr/include/openssl/ssl=
=2Eh
>=20
> I installed OpenSSL with brew, added the include path and it works.
>=20
> Can anyone confirm?
>=20
> Thanks,
> Lars
>=20
(Does it make sense that you send a patch which auto-detects brew simil=
ar to fink or mac ports?)

After some proper updating of one test machine I ran into the same prob=
lem.
A possible patch may look like this:


commit 5e7c16f3350e8e62bfdb181b0b5da7352945d046
Author: Torsten B=F6gershausen <tboegi@web.de>
Date:   Sun Nov 29 17:29:22 2015 +0100

    Mac OS X 10.11: set NO_OPENSSL
   =20
    There is no openssl/ directory any more in Mac OS X 10.11,
    openssl is depracated since Mac OS X 10.7
   =20
    Set NO_OPENSSL to YesPlease as default under Mac OS X, and make it
    possible to override this and use openssl by defining DARWIN_OPENSS=
L

diff --git a/config.mak.uname b/config.mak.uname
index f34dcaa..a8a8b07 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -105,6 +105,12 @@ ifeq ($(uname_S),Darwin)
        ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" =
-ge 11 && echo 1),1)
                HAVE_GETDELIM =3D YesPlease
        endif
+       # MacOS 10.11  and higher
+       ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" =
-ge 15 && echo 1),1)
+               ifndef DARWIN_OPENSSL
+                       NO_OPENSSL =3D YesPlease
+               endif
+       endif
        NO_MEMMEM =3D YesPlease
        USE_ST_TIMESPEC =3D YesPlease
        HAVE_DEV_TTY =3D YesPlease
