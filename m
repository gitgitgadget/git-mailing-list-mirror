From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [ANNOUNCE] qgit-2.0rc1
Date: Sun, 10 Jun 2007 15:40:59 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200706101541.03336.ismail@pardus.org.tr>
References: <e5bfff550706100447g5d34adf2j92389cd193658738@mail.gmail.com> <200706101514.58422.ismail@pardus.org.tr> <e5bfff550706100529xaeac76erc1dff124c1fac470@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2388623.Gj95bn4vD8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Pavel Roskin" <proski@gnu.org>,
	"Andy Parkins" <andyparkins@gmail.com>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 14:41:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxMjU-0002hX-13
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 14:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbXFJMlX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 08:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753291AbXFJMlX
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 08:41:23 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:47751 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753111AbXFJMlW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 08:41:22 -0400
Received: from southpark.local (unknown [85.96.17.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 7C6276011CC1;
	Sun, 10 Jun 2007 15:41:15 +0300 (EEST)
User-Agent: KMail/1.9.7
In-Reply-To: <e5bfff550706100529xaeac76erc1dff124c1fac470@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49723>

--nextPart2388623.Gj95bn4vD8
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 10 June 2007 15:29:58 Marco Costalba wrote:
> On 6/10/07, Ismail D=C3=B6nmez <ismail@pardus.org.tr> wrote:
> > Doesn't seem to compile here. make output is at
> > http://cekirdek.pardus.org.tr/~ismail/tmp/qgit4-error.txt . Qt is built
> > with no exceptions (as suggested by Trolltech), might that be the
> > problem?
>
> Could be, exceptions (try-catch clause) are used in qgit.
>
> Please, could you post the g++ command list args, i.e. what you see
> from console after typing make, as example I have something like this
> for annotate.cpp file.
>
> g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long
> -pedantic -Wconversion -Wall -W -D_REENTRANT  -DQT_NO_DEBUG
> -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED
> -I/usr/lib/qt4/mkspecs/linux-g++ -I. -I/usr/lib/qt4/include/QtCore
> -I/usr/lib/qt4/include/QtCore -I/usr/lib/qt4/include/QtGui
> -I/usr/lib/qt4/include/QtGui -I/usr/lib/qt4/include -I../src
> -I../build -I../build -o ../build/annotate.o annotate.cpp

g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W=20
=2DD_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/usr/=
qt/4/mkspecs/linux-g++ -I.=20
=2DI/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtCore -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=20
=2DI../src -I../build -I../build -o ../build/annotate.o annotate.cpp

>
>
> Also your build environment could be useful, please type
>
> $qmake -v
>
> and
>
> $ g++ -v

I use qmake-qt4 ,


[~]> qmake-qt4 -v
QMake version 2.01a
Using Qt version 4.3.0 in /usr/qt/4/lib

[~]> g++ -v
Using built-in specs.
Target: i686-pc-linux-gnu
Configured=20
with: ../configure --prefix=3D/usr --bindir=3D/usr/i686-pc-linux-gnu/gcc/4.=
2.0 --includedir=3D/usr/lib/gcc/i686-pc-linux-gnu/4.2.0/include=20
=2D-datadir=3D/usr/share/gcc/i686-pc-linux-gnu/4.2.0 --mandir=3D/usr/share/=
gcc/i686-pc-linux-gnu/4.2.0/man --infodir=3D/usr/share/gcc/i686-pc-linux-gn=
u/4.2.0/info=20
=2D-with-gxx-include-dir=3D/usr/lib/gcc/i686-pc-linux-gnu/4.2.0/include/g++=
=2Dv3 --host=3Di686-pc-linux-gnu --build=3Di686-pc-linux-gnu --disable-libg=
cj --disable-libssp=20
=2D-disable-multilib --disable-nls --disable-werror --enable-clocale=3Dgnu =
=2D-enable-__cxa_atexit --enable-languages=3Dc,c++,objc,fortran --enable-li=
bstdcxx-allocator=3Dnew=20
=2D-enable-shared --enable-ssp --enable-threads=3Dposix --enable-version-sp=
ecific-runtime-libs --without-included-gettext --without-system-libunwind -=
=2Dwith-system-zlib
Thread model: posix


Regards,
ismail

=2D-=20
Perfect is the enemy of good

--nextPart2388623.Gj95bn4vD8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)

iQIVAwUARmvxX0e9qviWcMsnAQKmGQ/+O3XE+R75i7JqbjOA7BoAWXlQwqx2rEjO
lWjYV/wfRKMKwUZoMIFc+F+nZdRy8r/yizRG3e7kQRf5jHlcBjCxviqEeN92Oy5X
v7MaQ9P7H7fKFuJF9qJP95DbZLz7IRIORHy9P9rN8uwMDPjms/Cn5gMw8Ye2b3Gh
Y/d7gZPAHsJdcn2Y+QnsgjI87i1KrlHSXc18d9ZH1EbU5tRaHLoKamTYYKFtslEY
3e8ctWQS4vWrLZQfb8mzhp3VWDZ/M6rk2ICe558hKcjYoqhef+QcdLtZVAsXkgzU
AeICNtUuO+7yaoUdFef0zS1vFuPQpFKSD4AbLdywIrQVKn04AtXsaoe++CR7Bq9c
aC3Ye+Az0lcLN9rbLFpBZRpdSfJzDUj2H+eqBwxoT6hbND9c9cxuPrRbUwk1+ark
9cjcLmsohhe3EDS55gz/8/jkDGiTbZhVHdET7U8LP1se17YU/RQG9ZrN1HPI4I5b
JDwrjo1071PFpcKbYG/JW+0xWksomDGyVjULtq1qB1yzrVkl52bMHD0BW7yw3r9Z
sJD4ShC63yQ9NtsAj/7VaY+BGpFxsyiGIm9mKHNiN5tYVGT1qYQWMx64+qyhZ4al
iX8ma5AcE/MMxsqXB7xGnyue4KCPEVuN8XaI5nDBS1yHbF07vDNJ43i0stTgdda2
JAhaPMMxq5E=
=8Icg
-----END PGP SIGNATURE-----

--nextPart2388623.Gj95bn4vD8--
