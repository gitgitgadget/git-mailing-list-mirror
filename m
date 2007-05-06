From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: FFmpeg considering GIT
Date: Sun, 6 May 2007 13:14:11 +0200
Message-ID: <20070506111411.GC17498@diana.vm.bytemark.co.uk>
References: <loom.20070502T111026-882@post.gmane.org> <20070503180016.GB21333@informatik.uni-freiburg.de> <20070503200013.GG4489@pasky.or.cz> <loom.20070504T143538-533@post.gmane.org> <87y7k4lahq.wl%cworth@cworth.org> <20070505133543.GC3379@diana.vm.bytemark.co.uk> <e5bfff550705060115o60fdd637h6c7393d06f75c55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 13:14:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkeh9-0003gU-Q3
	for gcvg-git@gmane.org; Sun, 06 May 2007 13:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933606AbXEFLOW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 6 May 2007 07:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933617AbXEFLOW
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 07:14:22 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2033 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933606AbXEFLOV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 07:14:21 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Hkegt-0004kk-00; Sun, 06 May 2007 12:14:11 +0100
Content-Disposition: inline
In-Reply-To: <e5bfff550705060115o60fdd637h6c7393d06f75c55@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46325>

On 2007-05-06 10:15:16 +0200, Marco Costalba wrote:

> Use qgit ;-)

Do I have to use any particular autoconf version? With

  kha@yoghurt:~/qgit> autoreconf --version
  autoreconf (GNU Autoconf) 2.60

I get a few warnings and errors when I run "autoreconf -i", and the
generated configure script has bugs that prevent it from finishing
successfully. (I'm trying to build qgit
4facdd5fc1731662ff9cdf096a576d40b938885c.)

Output follows:

kha@yoghurt:~/qgit> autoreconf -i
configure.ac: 9: `automake requires `AM_CONFIG_HEADER', not `AC_CONFIG_=
HEADER'
automake: configure.ac: installing `config/install-sh'
automake: configure.ac: installing `config/mkinstalldirs'
automake: configure.ac: installing `config/missing'
automake: configure.ac: installing `config/config.guess'
automake: configure.ac: installing `config/config.sub'
automake: Makefile.am: installing `./INSTALL'
automake: Makefile.am: required file `./NEWS' not found
automake: Makefile.am: required file `./AUTHORS' not found
configure.ac: 9: required file `./[config.h].in' not found
src/Makefile.am:30: invalid unused variable name: `nodist_qgit_SOURCES'
autoreconf: automake failed with exit status: 1

kha@yoghurt:~/qgit> ./configure --prefix=3D/usr/local/stow/qgit
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking whether make sets $(MAKE)... yes
=2E/configure: line 1874: 1.8: command not found
checking for working aclocal-1.4... found
checking for working autoconf... found
checking for working automake-1.4... found
checking for working autoheader... found
checking for working makeinfo... found
checking for g++... g++
checking for C++ compiler default output file name... a.out
checking whether the C++ compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...=20
checking for suffix of object files... o
checking whether we are using the GNU C++ compiler... yes
checking whether g++ accepts -g... yes
checking for a BSD-compatible install... /usr/bin/install -c
checking how to run the C++ preprocessor... g++ -E
checking for X... libraries , headers=20
checking for gethostbyname... yes
checking for connect... yes
checking for remove... yes
checking for shmat... yes
checking for IceConnectionNumber in -lICE... yes
checking for Qt includes... /usr/share/qt3/include
checking Qt version... 3.3.6
checking for moc... /usr/share/qt3/bin/moc
checking for uic... /usr/share/qt3/bin/uic
checking for pthread_exit in -lpthread... yes
checking for XftFontOpen in -lXft... yes
checking for main in -lqt-mt... yes
configure: QT_CPPFLAGS =3D -I/usr/share/qt3/include -D_REENTRANT -DQT_T=
HREAD_SUPPORT
configure: QT_LDFLAGS =3D  -L/usr/share/qt3/lib
configure: QT_LIBS =3D -lqt-mt -lpthread  -lXft  -lSM -lICE -lX11=20
configure: creating ./config.status
config.status: creating Makefile
config.status: WARNING:  Makefile.in seems to ignore the --datarootdir =
setting
config.status: creating src/Makefile
config.status: WARNING:  src/Makefile.in seems to ignore the --dataroot=
dir setting
config.status: creating config.h
kha@yoghurt:~/qgit> make
make[1]: Entering directory `/home/kha/qgit'
cd . && autoheader
make[1]: Leaving directory `/home/kha/qgit'
cd . \
          && CONFIG_FILES=3D CONFIG_HEADERS=3D[config.h] \
             /bin/bash ./config.status
config.status: error: cannot find input file: [config.h].in
make: *** [stamp-h] Error 1

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
