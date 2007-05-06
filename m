From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: FFmpeg considering GIT
Date: Sun, 6 May 2007 14:19:55 +0200
Message-ID: <e5bfff550705060519s2c1abd7cl7ecedeb497e10e3b@mail.gmail.com>
References: <loom.20070502T111026-882@post.gmane.org>
	 <20070503180016.GB21333@informatik.uni-freiburg.de>
	 <20070503200013.GG4489@pasky.or.cz>
	 <loom.20070504T143538-533@post.gmane.org>
	 <87y7k4lahq.wl%cworth@cworth.org>
	 <20070505133543.GC3379@diana.vm.bytemark.co.uk>
	 <e5bfff550705060115o60fdd637h6c7393d06f75c55@mail.gmail.com>
	 <20070506111411.GC17498@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Carl Worth" <cworth@cworth.org>,
	"Michael Niedermayer" <michaelni@gmx.at>, git@vger.kernel.org,
	"Pavel Roskin" <proski@gnu.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun May 06 14:20:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkfih-0003vU-MI
	for gcvg-git@gmane.org; Sun, 06 May 2007 14:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbXEFMT5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 6 May 2007 08:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbXEFMT5
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 08:19:57 -0400
Received: from nz-out-0506.google.com ([64.233.162.237]:60157 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbXEFMT4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 08:19:56 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1287081nzf
        for <git@vger.kernel.org>; Sun, 06 May 2007 05:19:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=onpA41KtYr0Ms4lZT7SENpCHHYg9lGGUqHy+QVeTa4zr37fu7XmWEqNWPbtQRfyCuOdPvhokvQkBU4wDUTeSuBk4w/kA3bG3gJXi4FnIAtrJNLe2Hqzf76pYqprywkD654QBJV+7pBzgMmotwwR0+aVKUB8qr6k0hjJN+BScdmY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F4m8fjcaAPVk2v5jgxGKkR/soTjah/AhRAsRtbgdh9VlHRHJbCuipQOiAAD3QcqOXWhQmu4c4bRhKwJVntVWUCo/rGElnLjoVPLP4ygR3mkRpXwW4brx3X6z7rKF8WGLzxyti83ZLBwvlPOweOIXxMmzC4LbDZ284uoTjGOBk68=
Received: by 10.114.24.1 with SMTP id 1mr1767456wax.1178453995581;
        Sun, 06 May 2007 05:19:55 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sun, 6 May 2007 05:19:55 -0700 (PDT)
In-Reply-To: <20070506111411.GC17498@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46326>

On 5/6/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-05-06 10:15:16 +0200, Marco Costalba wrote:
>
> > Use qgit ;-)
>
> Do I have to use any particular autoconf version? With
>

Sorry but I cannot reproduce the misbehaviour, my logs are below.

The only difference is that my autoreconf is 2.61 instead of 2.60

Pavel, some ideas?


In the mean time you can download the released tarball from
http://prdownloads.sourceforge.net/qgit/qgit-1.5.5.tar.bz2?download

You don't need autoreconf in that case and can go directly with

        configure/make/make install-strip



My log:

bash-3.1$ git clone git://git.kernel.org/pub/scm/qgit/qgit.git
Initialized empty Git repository in /home/marco/tmp/qgit/.git/
remote: Generating pack...
remote: Done counting 5723 objects.
remote: Deltifying 5723 objects.
remote:  100% (5723/5723) done
Indexing 5723 objects...
remote: Total 5723 (delta 4541), reused 5612 (delta 4461)
 100% (5723/5723) done
Resolving 4541 deltas...
 100% (4541/4541) done

bash-3.1$ cd qgit
bash-3.1$ autoreconf --version
autoreconf (GNU Autoconf) 2.61
Copyright (C) 2006 Free Software Foundation, Inc.
This is free software.  You may redistribute copies of it under the ter=
ms of
the GNU General Public License <http://www.gnu.org/licenses/gpl.html>.
There is NO WARRANTY, to the extent permitted by law.

Written by David J. MacKenzie and Akim Demaille.
bash-3.1$ autoreconf -i
configure.ac: installing `config/install-sh'
configure.ac: installing `config/missing'
src/Makefile.am: installing `config/depcomp'
bash-3.1$ ./configure
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for g++... g++
checking for C++ compiler default output file name... a.out
checking whether the C++ compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C++ compiler... yes
checking whether g++ accepts -g... yes
checking for style of include used by make... GNU
checking dependency style of g++... gcc3
checking for a BSD-compatible install... /usr/bin/install -c
checking for prefix by checking for qgit... /home/marco/bin/qgit
checking how to run the C++ preprocessor... g++ -E
checking for X... libraries , headers
checking for gethostbyname... yes
checking for connect... yes
checking for remove... yes
checking for shmat... yes
checking for IceConnectionNumber in -lICE... yes
checking for Qt includes... /usr/lib/qt3//include
checking Qt version... 3.3.8
checking for moc... /usr/lib/qt3//bin/moc
checking for uic... /usr/lib/qt3//bin/uic
checking for pthread_exit in -lpthread... yes
checking for XftFontOpen in -lXft... yes
checking for main in -lqt-mt... yes
configure: QT_CPPFLAGS =3D -I/usr/lib/qt3//include -D_REENTRANT
-DQT_THREAD_SUPPORT
configure: QT_LDFLAGS =3D  -L/usr/lib/qt3//lib
configure: QT_LIBS =3D -lqt-mt -lpthread  -lXft  -lSM -lICE -lX11
configure: creating ./config.status
config.status: creating Makefile
config.status: creating src/Makefile
config.status: creating config.h
config.status: executing depfiles commands

bash-3.1$ make
make  all-recursive
make[1]: Entering directory `/home/marco/tmp/qgit'
Making all in src
make[2]: Entering directory `/home/marco/tmp/qgit/src'
/usr/lib/qt3//bin/uic -o commitbase.h commitbase.ui
/usr/lib/qt3//bin/uic -o consolebase.h consolebase.ui

-------------- cut ---------------------

if g++ -DHAVE_CONFIG_H -I. -I. -I..   -g -O2 -I/usr/lib/qt3//include
-D_REENTRANT -DQT_THREAD_SUPPORT  -g -O2 -Wall -Wno-non-virtual-dtor
-W -Wno-long-long -pedantic -frepo -MT settingsbase.uic.o -MD -MP -MF
".deps/settingsbase.uic.Tpo" -c -o settingsbase.uic.o
settingsbase.uic.cc; \
        then mv -f ".deps/settingsbase.uic.Tpo"
".deps/settingsbase.uic.Po"; else rm -f ".deps/settingsbase.uic.Tpo";
exit 1; fi
g++  -g -O2 -Wall -Wno-non-virtual-dtor -W -Wno-long-long -pedantic
-frepo  -L/usr/lib/qt3//lib -o qgit  annotate.o cache.o commitimpl.o
consoleimpl.o customactionimpl.o dataloader.o domain.o
exceptionmanager.o filecontent.o filelist.o fileview.o git.o
git_startup.o lanes.o listview.o mainimpl.o myprocess.o
namespace_def.o patchview.o qgit.o rangeselectimpl.o revdesc.o
revsview.o settingsimpl.o treeview.o   commitbase.moc.o
consolebase.moc.o customactionbase.moc.o filebase.moc.o helpbase.moc.o
mainbase.moc.o patchbase.moc.o rangeselectbase.moc.o revbase.moc.o
settingsbase.moc.o annotate.moc.o commitimpl.moc.o consoleimpl.moc.o
customactionimpl.moc.o dataloader.moc.o domain.moc.o filecontent.moc.o
filelist.moc.o fileview.moc.o git.moc.o listview.moc.o mainimpl.moc.o
myprocess.moc.o patchview.moc.o rangeselectimpl.moc.o revdesc.moc.o
revsview.moc.o settingsimpl.moc.o treeview.moc.o commitbase.uic.o
consolebase.uic.o customactionbase.uic.o filebase.uic.o helpbase.uic.o
mainbase.uic.o patchbase.uic.o rangeselectbase.uic.o revbase.uic.o
settingsbase.uic.o  -lqt-mt -lpthread  -lXft  -lSM -lICE -lX11
collect: recompiling patchview.cpp
collect: recompiling mainimpl.cpp
collect: recompiling git_startup.cpp
collect: recompiling git.cpp

-------------- cut ---------------------

collect: relinking
collect: recompiling mainimpl.cpp
collect: recompiling git_startup.cpp
collect: recompiling git.cpp
collect: recompiling annotate.cpp
collect: relinking
make[3]: Leaving directory `/home/marco/tmp/qgit/src'
make[2]: Leaving directory `/home/marco/tmp/qgit/src'
make[2]: Entering directory `/home/marco/tmp/qgit'
make[2]: Nothing to be done for `all-am'.
make[2]: Leaving directory `/home/marco/tmp/qgit'
make[1]: Leaving directory `/home/marco/tmp/qgit'

bash-3.1$ make install-strip
make  INSTALL_PROGRAM=3D"/bin/sh /home/marco/tmp/qgit/config/install-sh=
 -c -s" \
          install_sh_PROGRAM=3D"/bin/sh
/home/marco/tmp/qgit/config/install-sh -c -s" INSTALL_STRIP_FLAG=3D-s \
          `test -z '' || \
            echo "INSTALL_PROGRAM_ENV=3DSTRIPPROG=3D''"` install
make[1]: Entering directory `/home/marco/tmp/qgit'
Making install in src
make[2]: Entering directory `/home/marco/tmp/qgit/src'
make  install-am

-------------- cut ---------------------

make[2]: Leaving directory `/home/marco/tmp/qgit'
make[1]: Leaving directory `/home/marco/tmp/qgit'

bash-3.1$ qgit
=46ound GNU source-highlight 2.5
Saving cache. Please wait...
Compressing data...
Done.
bash-3.1$
