From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [ANNOUNCE] qgit-2.0rc1
Date: Sun, 10 Jun 2007 15:56:16 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200706101556.25110.ismail@pardus.org.tr>
References: <e5bfff550706100447g5d34adf2j92389cd193658738@mail.gmail.com> <200706101541.03336.ismail@pardus.org.tr> <e5bfff550706100549y199dcce6o2989744ff55ac8d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2432646.0mOjU7zxQt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Pavel Roskin" <proski@gnu.org>,
	"Andy Parkins" <andyparkins@gmail.com>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 14:56:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxMyQ-0004YY-KR
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 14:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914AbXFJM4t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 08:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753845AbXFJM4t
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 08:56:49 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:36802 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753291AbXFJM4r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 08:56:47 -0400
Received: from southpark.local (unknown [85.96.17.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id EE90B602EDD5;
	Sun, 10 Jun 2007 15:56:36 +0300 (EEST)
User-Agent: KMail/1.9.7
In-Reply-To: <e5bfff550706100549y199dcce6o2989744ff55ac8d7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49725>

--nextPart2432646.0mOjU7zxQt
Content-Type: multipart/mixed;
  boundary="Boundary-01=_wT/aG8ThJeMZiCr"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_wT/aG8ThJeMZiCr
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 10 June 2007 15:49:29 you wrote:
> On 6/10/07, Ismail D=C3=B6nmez <ismail@pardus.org.tr> wrote:
> > On Sunday 10 June 2007 15:29:58 Marco Costalba wrote:
> > > On 6/10/07, Ismail D=C3=B6nmez <ismail@pardus.org.tr> wrote:
> > > > Doesn't seem to compile here. make output is at
> > > > http://cekirdek.pardus.org.tr/~ismail/tmp/qgit4-error.txt . Qt is
> > > > built with no exceptions (as suggested by Trolltech), might that be
> > > > the problem?
>
> Ok. Should be a linker problem with some Qt library. I don't have
> Qt4.3, I still have Qt4.2 but the library should be source and binary
> compatible according to Trolltech.
>
> Please could you post _whole_ the make output?

Attached.

Regards,
ismail

=2D-=20
Perfect is the enemy of good

--Boundary-01=_wT/aG8ThJeMZiCr
Content-Type: text/plain;
  charset="utf-8";
  name="qgit4-make-output.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="qgit4-make-output.txt"

cd src/ && make -f Makefile=20
make[1]: Entering directory `/home/cartman/qgit4/src'
make -f Makefile.Release
make[2]: Entering directory `/home/cartman/qgit4/src'
/usr/qt/4/bin/uic commit.ui -o ../build/ui_commit.h
/usr/qt/4/bin/uic console.ui -o ../build/ui_console.h
/usr/qt/4/bin/uic customaction.ui -o ../build/ui_customaction.h
/usr/qt/4/bin/uic fileview.ui -o ../build/ui_fileview.h
/usr/qt/4/bin/uic help.ui -o ../build/ui_help.h
/usr/qt/4/bin/uic mainview.ui -o ../build/ui_mainview.h
/usr/qt/4/bin/uic patchview.ui -o ../build/ui_patchview.h
/usr/qt/4/bin/uic rangeselect.ui -o ../build/ui_rangeselect.h
/usr/qt/4/bin/uic revsview.ui -o ../build/ui_revsview.h
/usr/qt/4/bin/uic settings.ui -o ../build/ui_settings.h
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/annot=
ate.o annotate.cpp
annotate.cpp: In member function 'void Annotate::setAnnotation(const QStrin=
g&, const QString&, const QLinkedList<QString>&, QLinkedList<QString>&, int=
)':
annotate.cpp:384: warning: empty body in an else-statement

*** 0 errors, 1 warnings
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/cache=
=2Eo cache.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/commi=
timpl.o commitimpl.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/conso=
leimpl.o consoleimpl.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/custo=
mactionimpl.o customactionimpl.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/datal=
oader.o dataloader.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/domai=
n.o domain.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/excep=
tionmanager.o exceptionmanager.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/filec=
ontent.o filecontent.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/filel=
ist.o filelist.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/filev=
iew.o fileview.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/git.o=
 git.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/git_s=
tartup.o git_startup.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/lanes=
=2Eo lanes.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/listv=
iew.o listview.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/maini=
mpl.o mainimpl.cpp
mainimpl.cpp:922: warning: unused parameter 'delta'

*** 0 errors, 1 warnings
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/mypro=
cess.o myprocess.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/names=
pace_def.o namespace_def.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/patch=
content.o patchcontent.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/patch=
view.o patchview.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/qgit.=
o qgit.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/range=
selectimpl.o rangeselectimpl.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/revde=
sc.o revdesc.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/revsv=
iew.o revsview.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/setti=
ngsimpl.o settingsimpl.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/smart=
browse.o smartbrowse.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/treev=
iew.o treeview.cpp
treeview.cpp: In member function 'void TreeView::updateTree()':
treeview.cpp:284: warning: empty body in an else-statement

*** 0 errors, 1 warnings
/usr/qt/4/bin/moc -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/u=
sr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCore -I/usr/qt/4/includ=
e/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include/QtGui -I/usr/qt/4/in=
clude -I../src -I../build -I../build annotate.h -o ../build/moc_annotate.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/moc_a=
nnotate.o ../build/moc_annotate.cpp
/usr/qt/4/bin/moc -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/u=
sr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCore -I/usr/qt/4/includ=
e/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include/QtGui -I/usr/qt/4/in=
clude -I../src -I../build -I../build cache.h -o ../build/moc_cache.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/moc_c=
ache.o ../build/moc_cache.cpp
/usr/qt/4/bin/moc -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/u=
sr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCore -I/usr/qt/4/includ=
e/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include/QtGui -I/usr/qt/4/in=
clude -I../src -I../build -I../build commitimpl.h -o ../build/moc_commitimp=
l.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/moc_c=
ommitimpl.o ../build/moc_commitimpl.cpp
/usr/qt/4/bin/moc -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/u=
sr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCore -I/usr/qt/4/includ=
e/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include/QtGui -I/usr/qt/4/in=
clude -I../src -I../build -I../build consoleimpl.h -o ../build/moc_consolei=
mpl.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/moc_c=
onsoleimpl.o ../build/moc_consoleimpl.cpp
/usr/qt/4/bin/moc -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/u=
sr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCore -I/usr/qt/4/includ=
e/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include/QtGui -I/usr/qt/4/in=
clude -I../src -I../build -I../build customactionimpl.h -o ../build/moc_cus=
tomactionimpl.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/moc_c=
ustomactionimpl.o ../build/moc_customactionimpl.cpp
/usr/qt/4/bin/moc -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/u=
sr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCore -I/usr/qt/4/includ=
e/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include/QtGui -I/usr/qt/4/in=
clude -I../src -I../build -I../build dataloader.h -o ../build/moc_dataloade=
r.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/moc_d=
ataloader.o ../build/moc_dataloader.cpp
/usr/qt/4/bin/moc -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/u=
sr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCore -I/usr/qt/4/includ=
e/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include/QtGui -I/usr/qt/4/in=
clude -I../src -I../build -I../build domain.h -o ../build/moc_domain.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/moc_d=
omain.o ../build/moc_domain.cpp
/usr/qt/4/bin/moc -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/u=
sr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCore -I/usr/qt/4/includ=
e/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include/QtGui -I/usr/qt/4/in=
clude -I../src -I../build -I../build filecontent.h -o ../build/moc_filecont=
ent.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/moc_f=
ilecontent.o ../build/moc_filecontent.cpp
/usr/qt/4/bin/moc -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/u=
sr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCore -I/usr/qt/4/includ=
e/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include/QtGui -I/usr/qt/4/in=
clude -I../src -I../build -I../build filelist.h -o ../build/moc_filelist.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/moc_f=
ilelist.o ../build/moc_filelist.cpp
/usr/qt/4/bin/moc -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/u=
sr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCore -I/usr/qt/4/includ=
e/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include/QtGui -I/usr/qt/4/in=
clude -I../src -I../build -I../build fileview.h -o ../build/moc_fileview.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/moc_f=
ileview.o ../build/moc_fileview.cpp
/usr/qt/4/bin/moc -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/u=
sr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCore -I/usr/qt/4/includ=
e/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include/QtGui -I/usr/qt/4/in=
clude -I../src -I../build -I../build git.h -o ../build/moc_git.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/moc_g=
it.o ../build/moc_git.cpp
/usr/qt/4/bin/moc -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/u=
sr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCore -I/usr/qt/4/includ=
e/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include/QtGui -I/usr/qt/4/in=
clude -I../src -I../build -I../build listview.h -o ../build/moc_listview.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/moc_l=
istview.o ../build/moc_listview.cpp
/usr/qt/4/bin/moc -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/u=
sr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCore -I/usr/qt/4/includ=
e/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include/QtGui -I/usr/qt/4/in=
clude -I../src -I../build -I../build mainimpl.h -o ../build/moc_mainimpl.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/moc_m=
ainimpl.o ../build/moc_mainimpl.cpp
/usr/qt/4/bin/moc -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/u=
sr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCore -I/usr/qt/4/includ=
e/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include/QtGui -I/usr/qt/4/in=
clude -I../src -I../build -I../build myprocess.h -o ../build/moc_myprocess.=
cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/moc_m=
yprocess.o ../build/moc_myprocess.cpp
/usr/qt/4/bin/moc -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/u=
sr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCore -I/usr/qt/4/includ=
e/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include/QtGui -I/usr/qt/4/in=
clude -I../src -I../build -I../build patchcontent.h -o ../build/moc_patchco=
ntent.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/moc_p=
atchcontent.o ../build/moc_patchcontent.cpp
/usr/qt/4/bin/moc -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/u=
sr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCore -I/usr/qt/4/includ=
e/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include/QtGui -I/usr/qt/4/in=
clude -I../src -I../build -I../build patchview.h -o ../build/moc_patchview.=
cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/moc_p=
atchview.o ../build/moc_patchview.cpp
/usr/qt/4/bin/moc -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/u=
sr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCore -I/usr/qt/4/includ=
e/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include/QtGui -I/usr/qt/4/in=
clude -I../src -I../build -I../build rangeselectimpl.h -o ../build/moc_rang=
eselectimpl.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/moc_r=
angeselectimpl.o ../build/moc_rangeselectimpl.cpp
/usr/qt/4/bin/moc -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/u=
sr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCore -I/usr/qt/4/includ=
e/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include/QtGui -I/usr/qt/4/in=
clude -I../src -I../build -I../build revdesc.h -o ../build/moc_revdesc.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/moc_r=
evdesc.o ../build/moc_revdesc.cpp
/usr/qt/4/bin/moc -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/u=
sr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCore -I/usr/qt/4/includ=
e/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include/QtGui -I/usr/qt/4/in=
clude -I../src -I../build -I../build revsview.h -o ../build/moc_revsview.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/moc_r=
evsview.o ../build/moc_revsview.cpp
/usr/qt/4/bin/moc -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/u=
sr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCore -I/usr/qt/4/includ=
e/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include/QtGui -I/usr/qt/4/in=
clude -I../src -I../build -I../build settingsimpl.h -o ../build/moc_setting=
simpl.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/moc_s=
ettingsimpl.o ../build/moc_settingsimpl.cpp
/usr/qt/4/bin/moc -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/u=
sr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCore -I/usr/qt/4/includ=
e/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include/QtGui -I/usr/qt/4/in=
clude -I../src -I../build -I../build smartbrowse.h -o ../build/moc_smartbro=
wse.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/moc_s=
martbrowse.o ../build/moc_smartbrowse.cpp
/usr/qt/4/bin/moc -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED -I/u=
sr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCore -I/usr/qt/4/includ=
e/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include/QtGui -I/usr/qt/4/in=
clude -I../src -I../build -I../build treeview.h -o ../build/moc_treeview.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/moc_t=
reeview.o ../build/moc_treeview.cpp
/usr/qt/4/bin/rcc -name icons icons.qrc -o ../build/qrc_icons.cpp
g++ -c -pipe -O2 -g3 -O2 -Wno-non-virtual-dtor -frepo -Wno-long-long -pedan=
tic -Wconversion -Wall -W -D_REENTRANT -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_CORE=
_LIB -DQT_SHARED -I/usr/qt/4/mkspecs/linux-g++ -I. -I/usr/qt/4/include/QtCo=
re -I/usr/qt/4/include/QtCore -I/usr/qt/4/include/QtGui -I/usr/qt/4/include=
/QtGui -I/usr/qt/4/include -I../src -I../build -I../build -o ../build/qrc_i=
cons.o ../build/qrc_icons.cpp
g++ -Wl,-rpath,/usr/qt/4/lib -o ../bin/qgit ../build/annotate.o ../build/ca=
che.o ../build/commitimpl.o ../build/consoleimpl.o ../build/customactionimp=
l.o ../build/dataloader.o ../build/domain.o ../build/exceptionmanager.o ../=
build/filecontent.o ../build/filelist.o ../build/fileview.o ../build/git.o =
=2E./build/git_startup.o ../build/lanes.o ../build/listview.o ../build/main=
impl.o ../build/myprocess.o ../build/namespace_def.o ../build/patchcontent.=
o ../build/patchview.o ../build/qgit.o ../build/rangeselectimpl.o ../build/=
revdesc.o ../build/revsview.o ../build/settingsimpl.o ../build/smartbrowse.=
o ../build/treeview.o ../build/moc_annotate.o ../build/moc_cache.o ../build=
/moc_commitimpl.o ../build/moc_consoleimpl.o ../build/moc_customactionimpl.=
o ../build/moc_dataloader.o ../build/moc_domain.o ../build/moc_filecontent.=
o ../build/moc_filelist.o ../build/moc_fileview.o ../build/moc_git.o ../bui=
ld/moc_listview.o ../build/moc_mainimpl.o ../build/moc_myprocess.o ../build=
/moc_patchcontent.o ../build/moc_patchview.o ../build/moc_rangeselectimpl.o=
 ../build/moc_revdesc.o ../build/moc_revsview.o ../build/moc_settingsimpl.o=
 ../build/moc_smartbrowse.o ../build/moc_treeview.o ../build/qrc_icons.o   =
 -L/usr/qt/4/lib -lQtGui -L/usr/qt/4/lib -L/usr/X11R6/lib -lpng -lSM -lICE =
=2DlXi -lXrender -lXrandr -lXfixes -lXcursor -lXinerama -lfreetype -lfontco=
nfig -lXext -lX11 -lQtCore -lz -lm -lrt -ldl -lpthread
=2E./build/annotate.o: In function `QMap<QString, RangeInfo>::operator[](QS=
tring const&)':
/usr/qt/4/include/QtCore/qmap.h:450: undefined reference to `QMap<QString, =
RangeInfo>::mutableFindNode(QMapData::Node**, QString const&) const'
=2E./build/annotate.o: In function `QMap<QString, RangeInfo>::detach()':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QString, =
RangeInfo>::detach_helper()'
=2E./build/annotate.o: In function `~QMap':
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QString, =
RangeInfo>::freeData(QMapData*)'
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QPair<QSt=
ring, unsigned int>, QString>::freeData(QMapData*)'
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QString, =
=46ileAnnotation>::freeData(QMapData*)'
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QString, =
RangeInfo>::freeData(QMapData*)'
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QPair<QSt=
ring, unsigned int>, QString>::freeData(QMapData*)'
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QString, =
=46ileAnnotation>::freeData(QMapData*)'
=2E./build/annotate.o: In function `QLinkedList<QString>::detach()':
/usr/qt/4/include/QtCore/qlinkedlist.h:73: undefined reference to `QLinkedL=
ist<QString>::detach_helper()'
/usr/qt/4/include/QtCore/qlinkedlist.h:73: undefined reference to `QLinkedL=
ist<QString>::detach_helper()'
=2E./build/annotate.o: In function `QMap<QString, FileAnnotation>::detach()=
':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QString, =
=46ileAnnotation>::detach_helper()'
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QString, =
=46ileAnnotation>::detach_helper()'
=2E./build/annotate.o: In function `Annotate::setAnnotation(QString const&,=
 QString const&, QLinkedList<QString> const&, QLinkedList<QString>&, int)':
/home/cartman/qgit4/src/annotate.cpp:319: undefined reference to `QLinkedLi=
st<QString>::operator=3D(QLinkedList<QString> const&)'
/home/cartman/qgit4/src/annotate.cpp:354: undefined reference to `QLinkedLi=
st<QString>::insert(QLinkedList<QString>::iterator, QString const&)'
/home/cartman/qgit4/src/annotate.cpp:364: undefined reference to `QLinkedLi=
st<QString>::erase(QLinkedList<QString>::iterator)'
/home/cartman/qgit4/src/annotate.cpp:357: undefined reference to `QLinkedLi=
st<QString>::append(QString const&)'
=2E./build/annotate.o: In function `QLinkedList<QString>::detach()':
/usr/qt/4/include/QtCore/qlinkedlist.h:73: undefined reference to `QLinkedL=
ist<QString>::detach_helper()'
/usr/qt/4/include/QtCore/qlinkedlist.h:73: undefined reference to `QLinkedL=
ist<QString>::detach_helper()'
/usr/qt/4/include/QtCore/qlinkedlist.h:73: undefined reference to `QLinkedL=
ist<QString>::detach_helper()'
/usr/qt/4/include/QtCore/qlinkedlist.h:73: undefined reference to `QLinkedL=
ist<QString>::detach_helper()'
/usr/qt/4/include/QtCore/qlinkedlist.h:73: undefined reference to `QLinkedL=
ist<QString>::detach_helper()'
=2E./build/annotate.o: In function `Annotate::setAnnotation(QString const&,=
 QString const&, QLinkedList<QString> const&, QLinkedList<QString>&, int)':
/home/cartman/qgit4/src/annotate.cpp:345: undefined reference to `QLinkedLi=
st<QString>::clear()'
=2E./build/annotate.o: In function `Annotate::updateCrossRanges(QString con=
st&, bool, int, int, RangeInfo*)':
/home/cartman/qgit4/src/annotate.cpp:499: undefined reference to `QLinkedLi=
st<QString>::append(QString const&)'
=2E./build/annotate.o: In function `QLinkedList<QString>::detach()':
/usr/qt/4/include/QtCore/qlinkedlist.h:73: undefined reference to `QLinkedL=
ist<QString>::detach_helper()'
/usr/qt/4/include/QtCore/qlinkedlist.h:73: undefined reference to `QLinkedL=
ist<QString>::detach_helper()'
/usr/qt/4/include/QtCore/qlinkedlist.h:73: undefined reference to `QLinkedL=
ist<QString>::detach_helper()'
=2E./build/annotate.o: In function `QMap<QString, FileAnnotation>::operator=
[](QString const&)':
/usr/qt/4/include/QtCore/qmap.h:450: undefined reference to `QMap<QString, =
=46ileAnnotation>::mutableFindNode(QMapData::Node**, QString const&) const'
=2E./build/annotate.o: In function `Annotate::setInitialAnnotation(QString =
const&, QString const&, FileAnnotation*)':
/home/cartman/qgit4/src/annotate.cpp:283: undefined reference to `QLinkedLi=
st<QString>::append(QString const&)'
=2E./build/annotate.o: In function `QMap<QString, FileAnnotation>::detach()=
':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QString, =
=46ileAnnotation>::detach_helper()'
=2E./build/annotate.o: In function `QLinkedList<QString>::detach()':
/usr/qt/4/include/QtCore/qlinkedlist.h:73: undefined reference to `QLinkedL=
ist<QString>::detach_helper()'
=2E./build/annotate.o: In function `QMap<QString, FileAnnotation>::detach()=
':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QString, =
=46ileAnnotation>::detach_helper()'
=2E./build/annotate.o: In function `QMap<QString, FileAnnotation>::operator=
[](QString const&)':
/usr/qt/4/include/QtCore/qmap.h:450: undefined reference to `QMap<QString, =
=46ileAnnotation>::mutableFindNode(QMapData::Node**, QString const&) const'
=2E./build/annotate.o: In function `QLinkedList<QString>::detach()':
/usr/qt/4/include/QtCore/qlinkedlist.h:73: undefined reference to `QLinkedL=
ist<QString>::detach_helper()'
=2E./build/annotate.o: In function `QMap<QString, RangeInfo>::detach()':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QString, =
RangeInfo>::detach_helper()'
=2E./build/annotate.o: In function `QMap<QString, RangeInfo>::insert(QStrin=
g const&, RangeInfo const&)':
/usr/qt/4/include/QtCore/qmap.h:483: undefined reference to `QMap<QString, =
RangeInfo>::mutableFindNode(QMapData::Node**, QString const&) const'
=2E./build/annotate.o: In function `QMap<QString, RangeInfo>::detach()':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QString, =
RangeInfo>::detach_helper()'
=2E./build/annotate.o: In function `QMap<QString, RangeInfo>::operator[](QS=
tring const&)':
/usr/qt/4/include/QtCore/qmap.h:450: undefined reference to `QMap<QString, =
RangeInfo>::mutableFindNode(QMapData::Node**, QString const&) const'
=2E./build/annotate.o: In function `QMap<QPair<QString, unsigned int>, QStr=
ing>::detach()':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QPair<QSt=
ring, unsigned int>, QString>::detach_helper()'
=2E./build/annotate.o: In function `QMap<QPair<QString, unsigned int>, QStr=
ing>::operator[](QPair<QString, unsigned int> const&)':
/usr/qt/4/include/QtCore/qmap.h:450: undefined reference to `QMap<QPair<QSt=
ring, unsigned int>, QString>::mutableFindNode(QMapData::Node**, QPair<QStr=
ing, unsigned int> const&) const'
=2E./build/annotate.o: In function `QMap<QString, RangeInfo>::detach()':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QString, =
RangeInfo>::detach_helper()'
=2E./build/annotate.o: In function `QMap<QString, RangeInfo>::operator[](QS=
tring const&)':
/usr/qt/4/include/QtCore/qmap.h:450: undefined reference to `QMap<QString, =
RangeInfo>::mutableFindNode(QMapData::Node**, QString const&) const'
=2E./build/annotate.o: In function `QMap<QString, RangeInfo>::detach()':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QString, =
RangeInfo>::detach_helper()'
=2E./build/annotate.o: In function `QMap<QString, RangeInfo>::insert(QStrin=
g const&, RangeInfo const&)':
/usr/qt/4/include/QtCore/qmap.h:483: undefined reference to `QMap<QString, =
RangeInfo>::mutableFindNode(QMapData::Node**, QString const&) const'
=2E./build/annotate.o: In function `QMap<QString, RangeInfo>::operator=3D(Q=
Map<QString, RangeInfo> const&)':
/usr/qt/4/include/QtCore/qmap.h:376: undefined reference to `QMap<QString, =
RangeInfo>::detach_helper()'
/usr/qt/4/include/QtCore/qmap.h:374: undefined reference to `QMap<QString, =
RangeInfo>::freeData(QMapData*)'
=2E./build/annotate.o: In function `~QMap':
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QString, =
RangeInfo>::freeData(QMapData*)'
=2E./build/annotate.o: In function `QMap<QString, RangeInfo>::detach()':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QString, =
RangeInfo>::detach_helper()'
=2E./build/annotate.o: In function `QMap<QString, RangeInfo>::insert(QStrin=
g const&, RangeInfo const&)':
/usr/qt/4/include/QtCore/qmap.h:483: undefined reference to `QMap<QString, =
RangeInfo>::mutableFindNode(QMapData::Node**, QString const&) const'
=2E./build/annotate.o: In function `QMap<QString, RangeInfo>::detach()':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QString, =
RangeInfo>::detach_helper()'
=2E./build/annotate.o: In function `QMap<QString, RangeInfo>::operator[](QS=
tring const&)':
/usr/qt/4/include/QtCore/qmap.h:450: undefined reference to `QMap<QString, =
RangeInfo>::mutableFindNode(QMapData::Node**, QString const&) const'
=2E./build/annotate.o: In function `QMap<QPair<QString, unsigned int>, QStr=
ing>::detach()':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QPair<QSt=
ring, unsigned int>, QString>::detach_helper()'
=2E./build/annotate.o: In function `QMap<QPair<QString, unsigned int>, QStr=
ing>::operator[](QPair<QString, unsigned int> const&)':
/usr/qt/4/include/QtCore/qmap.h:450: undefined reference to `QMap<QPair<QSt=
ring, unsigned int>, QString>::mutableFindNode(QMapData::Node**, QPair<QStr=
ing, unsigned int> const&) const'
=2E./build/annotate.o: In function `QMap<QString, RangeInfo>::detach()':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QString, =
RangeInfo>::detach_helper()'
=2E./build/annotate.o: In function `QMap<QString, RangeInfo>::insert(QStrin=
g const&, RangeInfo const&)':
/usr/qt/4/include/QtCore/qmap.h:483: undefined reference to `QMap<QString, =
RangeInfo>::mutableFindNode(QMapData::Node**, QString const&) const'
=2E./build/annotate.o: In function `~QMap':
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QString, =
RangeInfo>::freeData(QMapData*)'
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QString, =
RangeInfo>::freeData(QMapData*)'
=2E./build/annotate.o: In function `QMap<QString, RangeInfo>::detach()':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QString, =
RangeInfo>::detach_helper()'
=2E./build/annotate.o: In function `QMap<QString, RangeInfo>::operator[](QS=
tring const&)':
/usr/qt/4/include/QtCore/qmap.h:450: undefined reference to `QMap<QString, =
RangeInfo>::mutableFindNode(QMapData::Node**, QString const&) const'
=2E./build/annotate.o: In function `QMap<QString, RangeInfo>::detach()':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QString, =
RangeInfo>::detach_helper()'
=2E./build/annotate.o: In function `QMap<QString, RangeInfo>::operator[](QS=
tring const&)':
/usr/qt/4/include/QtCore/qmap.h:450: undefined reference to `QMap<QString, =
RangeInfo>::mutableFindNode(QMapData::Node**, QString const&) const'
=2E./build/annotate.o: In function `QMap<QString, RangeInfo>::operator=3D(Q=
Map<QString, RangeInfo> const&)':
/usr/qt/4/include/QtCore/qmap.h:376: undefined reference to `QMap<QString, =
RangeInfo>::detach_helper()'
/usr/qt/4/include/QtCore/qmap.h:374: undefined reference to `QMap<QString, =
RangeInfo>::freeData(QMapData*)'
/usr/qt/4/include/QtCore/qmap.h:376: undefined reference to `QMap<QString, =
RangeInfo>::detach_helper()'
/usr/qt/4/include/QtCore/qmap.h:374: undefined reference to `QMap<QString, =
RangeInfo>::freeData(QMapData*)'
/usr/qt/4/include/QtCore/qmap.h:374: undefined reference to `QMap<QString, =
RangeInfo>::freeData(QMapData*)'
/usr/qt/4/include/QtCore/qmap.h:376: undefined reference to `QMap<QString, =
RangeInfo>::detach_helper()'
=2E./build/annotate.o: In function `~QMap':
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QString, =
RangeInfo>::freeData(QMapData*)'
=2E./build/annotate.o: In function `QMap<QString, FileAnnotation>::detach()=
':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QString, =
=46ileAnnotation>::detach_helper()'
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QString, =
=46ileAnnotation>::detach_helper()'
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QString, =
=46ileAnnotation>::detach_helper()'
=2E./build/annotate.o: In function `QMap<QString, FileAnnotation>::operator=
[](QString const&)':
/usr/qt/4/include/QtCore/qmap.h:450: undefined reference to `QMap<QString, =
=46ileAnnotation>::mutableFindNode(QMapData::Node**, QString const&) const'
=2E./build/annotate.o: In function `QMap<QPair<QString, unsigned int>, QStr=
ing>::detach()':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QPair<QSt=
ring, unsigned int>, QString>::detach_helper()'
=2E./build/annotate.o: In function `QMap<QPair<QString, unsigned int>, QStr=
ing>::insert(QPair<QString, unsigned int> const&, QString const&)':
/usr/qt/4/include/QtCore/qmap.h:483: undefined reference to `QMap<QPair<QSt=
ring, unsigned int>, QString>::mutableFindNode(QMapData::Node**, QPair<QStr=
ing, unsigned int> const&) const'
=2E./build/annotate.o: In function `QLinkedList<QString>::detach()':
/usr/qt/4/include/QtCore/qlinkedlist.h:73: undefined reference to `QLinkedL=
ist<QString>::detach_helper()'
=2E./build/annotate.o: In function `Annotate::doAnnotate(QString const&, QS=
tring const&, bool)':
/home/cartman/qgit4/src/annotate.cpp:246: undefined reference to `QLinkedLi=
st<QString>::operator=3D(QLinkedList<QString> const&)'
=2E./build/annotate.o: In function `QMap<QString, FileAnnotation>::detach()=
':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QString, =
=46ileAnnotation>::detach_helper()'
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QString, =
=46ileAnnotation>::detach_helper()'
=2E./build/annotate.o: In function `QMap<QPair<QString, unsigned int>, QStr=
ing>::clear()':
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QPair<QSt=
ring, unsigned int>, QString>::freeData(QMapData*)'
/usr/qt/4/include/QtCore/qmap.h:374: undefined reference to `QMap<QPair<QSt=
ring, unsigned int>, QString>::freeData(QMapData*)'
/usr/qt/4/include/QtCore/qmap.h:376: undefined reference to `QMap<QPair<QSt=
ring, unsigned int>, QString>::detach_helper()'
=2E./build/annotate.o: In function `~QMap':
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QPair<QSt=
ring, unsigned int>, QString>::freeData(QMapData*)'
=2E./build/annotate.o: In function `QMap<QString, FileAnnotation>::detach()=
':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QString, =
=46ileAnnotation>::detach_helper()'
=2E./build/annotate.o: In function `QMap<QString, FileAnnotation>::insert(Q=
String const&, FileAnnotation const&)':
/usr/qt/4/include/QtCore/qmap.h:483: undefined reference to `QMap<QString, =
=46ileAnnotation>::mutableFindNode(QMapData::Node**, QString const&) const'
=2E./build/annotate.o: In function `operator=3D':
/home/cartman/qgit4/src/common.h:376: undefined reference to `QLinkedList<Q=
String>::operator=3D(QLinkedList<QString> const&)'
=2E./build/annotate.o: In function `QLinkedList<QString>::detach()':
/usr/qt/4/include/QtCore/qlinkedlist.h:73: undefined reference to `QLinkedL=
ist<QString>::detach_helper()'
=2E./build/cache.o: In function `Cache::load(QString const&, QHash<QString,=
 RevFile const*>&, QVector<QString>&, QVector<QString>&)':
/home/cartman/qgit4/src/cache.cpp:144: undefined reference to `QVector<QStr=
ing>::resize(int)'
/home/cartman/qgit4/src/cache.cpp:149: undefined reference to `QVector<QStr=
ing>::resize(int)'
/home/cartman/qgit4/src/cache.cpp:180: undefined reference to `QDataStream&=
 operator>><QString>(QDataStream&, QVector<QString>&)'
=2E./build/cache.o: In function `Cache::save(QString const&, QHash<QString,=
 RevFile const*> const&, QVector<QString> const&, QVector<QString> const&)':
/home/cartman/qgit4/src/cache.cpp:101: undefined reference to `QDataStream&=
 operator<< <QString>(QDataStream&, QVector<QString> const&)'
=2E./build/commitimpl.o: In function `CommitImpl::closeEvent(QCloseEvent*)':
/home/cartman/qgit4/src/commitimpl.cpp:108: undefined reference to `QVector=
<QSplitter*>::QVector(int, QSplitter* const&)'
=2E./build/commitimpl.o: In function `~QVector':
/usr/qt/4/include/QtCore/qvector.h:78: undefined reference to `QVector<QSpl=
itter*>::free(QVectorTypedData<QSplitter*>*)'
/usr/qt/4/include/QtCore/qvector.h:78: undefined reference to `QVector<QSpl=
itter*>::free(QVectorTypedData<QSplitter*>*)'
=2E./build/commitimpl.o: In function `CommitImpl':
/home/cartman/qgit4/src/commitimpl.cpp:32: undefined reference to `QVector<=
QSplitter*>::QVector(int, QSplitter* const&)'
=2E./build/commitimpl.o: In function `~QVector':
/usr/qt/4/include/QtCore/qvector.h:78: undefined reference to `QVector<QSpl=
itter*>::free(QVectorTypedData<QSplitter*>*)'
/usr/qt/4/include/QtCore/qvector.h:78: undefined reference to `QVector<QSpl=
itter*>::free(QVectorTypedData<QSplitter*>*)'
=2E./build/commitimpl.o: In function `CommitImpl':
/home/cartman/qgit4/src/commitimpl.cpp:32: undefined reference to `QVector<=
QSplitter*>::QVector(int, QSplitter* const&)'
=2E./build/commitimpl.o: In function `~QVector':
/usr/qt/4/include/QtCore/qvector.h:78: undefined reference to `QVector<QSpl=
itter*>::free(QVectorTypedData<QSplitter*>*)'
/usr/qt/4/include/QtCore/qvector.h:78: undefined reference to `QVector<QSpl=
itter*>::free(QVectorTypedData<QSplitter*>*)'
=2E./build/dataloader.o: In function `DataLoader::parseSingleBuffer(QByteAr=
ray const&)':
/home/cartman/qgit4/src/dataloader.cpp:136: undefined reference to `QList<Q=
ByteArray*>::append(QByteArray* const&)'
=2E./build/dataloader.o: In function `DataLoader::readNewData(bool)':
/home/cartman/qgit4/src/dataloader.cpp:238: undefined reference to `QList<Q=
ByteArray*>::append(QByteArray* const&)'
=2E./build/exceptionmanager.o: In function `QList<ExceptionManager::Excepti=
on>::detach()':
/usr/qt/4/include/QtCore/qlist.h:99: undefined reference to `QList<Exceptio=
nManager::Exception>::detach_helper()'
/usr/qt/4/include/QtCore/qlist.h:99: undefined reference to `QList<Exceptio=
nManager::Exception>::detach_helper()'
/usr/qt/4/include/QtCore/qlist.h:99: undefined reference to `QList<Exceptio=
nManager::Exception>::detach_helper()'
=2E./build/exceptionmanager.o: In function `QMap<int, QList<ExceptionManage=
r::Exception> >::detach()':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<int, QLis=
t<ExceptionManager::Exception> >::detach_helper()'
=2E./build/exceptionmanager.o: In function `QList<ExceptionManager::Excepti=
on>::detach()':
/usr/qt/4/include/QtCore/qlist.h:99: undefined reference to `QList<Exceptio=
nManager::Exception>::detach_helper()'
/usr/qt/4/include/QtCore/qlist.h:99: undefined reference to `QList<Exceptio=
nManager::Exception>::detach_helper()'
=2E./build/exceptionmanager.o: In function `QMap<int, QList<ExceptionManage=
r::Exception> >::detach()':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<int, QLis=
t<ExceptionManager::Exception> >::detach_helper()'
=2E./build/exceptionmanager.o: In function `QList<ExceptionManager::Excepti=
on>::detach()':
/usr/qt/4/include/QtCore/qlist.h:99: undefined reference to `QList<Exceptio=
nManager::Exception>::detach_helper()'
/usr/qt/4/include/QtCore/qlist.h:99: undefined reference to `QList<Exceptio=
nManager::Exception>::detach_helper()'
=2E./build/exceptionmanager.o: In function `QMap<int, QList<ExceptionManage=
r::Exception> >::operator[](int const&)':
/usr/qt/4/include/QtCore/qmap.h:450: undefined reference to `QMap<int, QLis=
t<ExceptionManager::Exception> >::mutableFindNode(QMapData::Node**, int con=
st&) const'
=2E./build/exceptionmanager.o: In function `QList<ExceptionManager::Excepti=
on>::operator=3D(QList<ExceptionManager::Exception> const&)':
/usr/qt/4/include/QtCore/qlist.h:357: undefined reference to `QList<Excepti=
onManager::Exception>::detach_helper()'
=2E./build/exceptionmanager.o: In function `ExceptionManager::restoreThrowa=
bleSet(int)':
/home/cartman/qgit4/src/exceptionmanager.cpp:143: undefined reference to `Q=
Map<int, QList<ExceptionManager::Exception> >::remove(int const&)'
=2E./build/exceptionmanager.o: In function `QMap<int, QList<ExceptionManage=
r::Exception> >::detach()':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<int, QLis=
t<ExceptionManager::Exception> >::detach_helper()'
=2E./build/exceptionmanager.o: In function `QMap<int, QList<ExceptionManage=
r::Exception> >::node_create(QMapData*, QMapData::Node**, int const&, QList=
<ExceptionManager::Exception> const&)':
/usr/qt/4/include/QtCore/qlist.h:91: undefined reference to `QList<Exceptio=
nManager::Exception>::detach_helper()'
=2E./build/exceptionmanager.o: In function `QMap<int, QList<ExceptionManage=
r::Exception> >::insert(int const&, QList<ExceptionManager::Exception> cons=
t&)':
/usr/qt/4/include/QtCore/qmap.h:483: undefined reference to `QMap<int, QLis=
t<ExceptionManager::Exception> >::mutableFindNode(QMapData::Node**, int con=
st&) const'
=2E./build/exceptionmanager.o: In function `ExceptionManager::saveThrowable=
Set()':
/home/cartman/qgit4/src/exceptionmanager.cpp:131: undefined reference to `Q=
List<ExceptionManager::Exception>::clear()'
=2E./build/exceptionmanager.o: In function `QList<ExceptionManager::Excepti=
on>::operator=3D(QList<ExceptionManager::Exception> const&)':
/usr/qt/4/include/QtCore/qlist.h:357: undefined reference to `QList<Excepti=
onManager::Exception>::detach_helper()'
=2E./build/exceptionmanager.o: In function `QMap<int, QList<ExceptionManage=
r::Exception> >::detach()':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<int, QLis=
t<ExceptionManager::Exception> >::detach_helper()'
=2E./build/exceptionmanager.o: In function `QList':
/usr/qt/4/include/QtCore/qlist.h:91: undefined reference to `QList<Exceptio=
nManager::Exception>::detach_helper()'
=2E./build/exceptionmanager.o: In function `QList<ExceptionManager::Excepti=
on>::detach()':
/usr/qt/4/include/QtCore/qlist.h:99: undefined reference to `QList<Exceptio=
nManager::Exception>::detach_helper()'
/usr/qt/4/include/QtCore/qlist.h:99: undefined reference to `QList<Exceptio=
nManager::Exception>::detach_helper()'
=2E./build/git_startup.o: In function `qDeleteAll<RevFileMap>':
/usr/qt/4/include/QtCore/qalgorithms.h:338: undefined reference to `void qD=
eleteAll<QHash<QString, RevFile const*>::const_iterator>(QHash<QString, Rev=
=46ile const*>::const_iterator, QHash<QString, RevFile const*>::const_itera=
tor)'
=2E./build/git_startup.o: In function `Git::stop(bool)':
/home/cartman/qgit4/src/git_startup.cpp:498: undefined reference to `QHash<=
QString, RevFile const*>::remove(QString const&)'
=2E./build/git_startup.o: In function `Git::mergeNearTags(bool, Rev*, Rev c=
onst*, QMap<QPair<unsigned int, unsigned int>, bool> const&)':
/home/cartman/qgit4/src/git_startup.cpp:1051: undefined reference to `QPair=
<unsigned int, unsigned int> qMakePair<unsigned int, unsigned int>(unsigned=
 int const&, unsigned int const&)'
=2E./build/git_startup.o: In function `QMap<unsigned int, QVector<int> >::d=
etach()':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<unsigned =
int, QVector<int> >::detach_helper()'
=2E./build/git_startup.o: In function `QMap<unsigned int, QVector<int> >::o=
perator[](unsigned int const&)':
/usr/qt/4/include/QtCore/qmap.h:450: undefined reference to `QMap<unsigned =
int, QVector<int> >::mutableFindNode(QMapData::Node**, unsigned int const&)=
 const'
=2E./build/git_startup.o: In function `Git::updateDescMap(Rev const*, unsig=
ned int, QMap<QPair<unsigned int, unsigned int>, bool>&, QMap<unsigned int,=
 QVector<int> >&)':
/home/cartman/qgit4/src/git_startup.cpp:986: undefined reference to `QPair<=
unsigned int, unsigned int> qMakePair<unsigned int, unsigned int>(unsigned =
int const&, unsigned int const&)'
/home/cartman/qgit4/src/git_startup.cpp:987: undefined reference to `QPair<=
unsigned int, unsigned int> qMakePair<unsigned int, unsigned int>(unsigned =
int const&, unsigned int const&)'
=2E./build/git_startup.o: In function `QMap<QPair<unsigned int, unsigned in=
t>, bool>::detach()':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QPair<uns=
igned int, unsigned int>, bool>::detach_helper()'
=2E./build/git_startup.o: In function `QMap<QPair<unsigned int, unsigned in=
t>, bool>::insert(QPair<unsigned int, unsigned int> const&, bool const&)':
/usr/qt/4/include/QtCore/qmap.h:483: undefined reference to `QMap<QPair<uns=
igned int, unsigned int>, bool>::mutableFindNode(QMapData::Node**, QPair<un=
signed int, unsigned int> const&) const'
=2E./build/git_startup.o: In function `QMap<QPair<unsigned int, unsigned in=
t>, bool>::detach()':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<QPair<uns=
igned int, unsigned int>, bool>::detach_helper()'
=2E./build/git_startup.o: In function `QMap<QPair<unsigned int, unsigned in=
t>, bool>::insert(QPair<unsigned int, unsigned int> const&, bool const&)':
/usr/qt/4/include/QtCore/qmap.h:483: undefined reference to `QMap<QPair<uns=
igned int, unsigned int>, bool>::mutableFindNode(QMapData::Node**, QPair<un=
signed int, unsigned int> const&) const'
=2E./build/git_startup.o: In function `QMap<unsigned int, QVector<int> >::d=
etach()':
/usr/qt/4/include/QtCore/qmap.h:146: undefined reference to `QMap<unsigned =
int, QVector<int> >::detach_helper()'
=2E./build/git_startup.o: In function `QMap<unsigned int, QVector<int> >::i=
nsert(unsigned int const&, QVector<int> const&)':
/usr/qt/4/include/QtCore/qmap.h:483: undefined reference to `QMap<unsigned =
int, QVector<int> >::mutableFindNode(QMapData::Node**, unsigned int const&)=
 const'
=2E./build/git_startup.o: In function `~QMap':
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QPair<uns=
igned int, unsigned int>, bool>::freeData(QMapData*)'
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<unsigned =
int, QVector<int> >::freeData(QMapData*)'
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QPair<uns=
igned int, unsigned int>, bool>::freeData(QMapData*)'
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<unsigned =
int, QVector<int> >::freeData(QMapData*)'
=2E./build/git_startup.o: In function `Git::clearRevs()':
/home/cartman/qgit4/src/git_startup.cpp:515: undefined reference to `QHash<=
QString, RevFile const*>::remove(QString const&)'
=2E./build/git_startup.o: In function `Git::setExtStatus(RevFile&, QString =
const&, int)':
/home/cartman/qgit4/src/git_startup.cpp:396: undefined reference to `QVecto=
r<QString>::resize(int)'
/home/cartman/qgit4/src/git_startup.cpp:404: undefined reference to `QVecto=
r<QString>::resize(int)'
=2E./build/git_startup.o: In function `Git::lookupReference(QString const&,=
 bool)':
/home/cartman/qgit4/src/git_startup.cpp:87: undefined reference to `QMap<QS=
tring, Git::Reference>::insert(QString const&, Git::Reference const&)'
=2E./build/git_startup.o: In function `Git::getRefs()':
/home/cartman/qgit4/src/git_startup.cpp:162: undefined reference to `QMap<Q=
String, Git::Reference>::remove(QString const&)'
=2E./build/git_startup.o: In function `Git::fakeWorkDirRev(QString const&, =
QString const&, QString const&, int, FileHistory*)':
/home/cartman/qgit4/src/git_startup.cpp:259: undefined reference to `QList<=
QByteArray*>::append(QByteArray* const&)'
=2E./build/mainimpl.o: In function `MainImpl::updateGlobalActions(bool)':
/home/cartman/qgit4/src/mainimpl.cpp:337: undefined reference to `PatchView=
* MainImpl::firstTab<PatchView>(QWidget*)'
=2E./build/mainimpl.o: In function `MainImpl::updateContextActions(QString =
const&, QString const&, bool, bool)':
/home/cartman/qgit4/src/mainimpl.cpp:352: undefined reference to `FileView*=
 MainImpl::firstTab<FileView>(QWidget*)'
=2E./build/mainimpl.o: In function `MainImpl::saveCurrentGeometry()':
/home/cartman/qgit4/src/mainimpl.cpp:157: undefined reference to `QVector<Q=
Splitter*>::QVector(int, QSplitter* const&)'
=2E./build/mainimpl.o: In function `~QVector':
/usr/qt/4/include/QtCore/qvector.h:78: undefined reference to `QVector<QSpl=
itter*>::free(QVectorTypedData<QSplitter*>*)'
/usr/qt/4/include/QtCore/qvector.h:78: undefined reference to `QVector<QSpl=
itter*>::free(QVectorTypedData<QSplitter*>*)'
=2E./build/mainimpl.o: In function `MainImpl::closeEvent(QCloseEvent*)':
/home/cartman/qgit4/src/mainimpl.cpp:1707: undefined reference to `QList<QP=
rocess*>::~QList()'
=2E./build/mainimpl.o: In function `findChildren<QProcess*>':
/usr/qt/4/include/QtCore/qobject.h:389: undefined reference to `QList<QProc=
ess*>::~QList()'
=2E./build/mainimpl.o: In function `MainImpl::currentTabType(Domain**)':
/home/cartman/qgit4/src/mainimpl.cpp:744: undefined reference to `QList<Pat=
chView*>* MainImpl::getTabs<PatchView>(QWidget*)'
/home/cartman/qgit4/src/mainimpl.cpp:747: undefined reference to `QList<Pat=
chView*>::~QList()'
=2E./build/mainimpl.o: In function `QList<PatchView*>::detach()':
/usr/qt/4/include/QtCore/qlist.h:99: undefined reference to `QList<PatchVie=
w*>::detach_helper()'
=2E./build/mainimpl.o: In function `MainImpl::currentTabType(Domain**)':
/home/cartman/qgit4/src/mainimpl.cpp:750: undefined reference to `QList<Pat=
chView*>::~QList()'
/home/cartman/qgit4/src/mainimpl.cpp:751: undefined reference to `QList<Fil=
eView*>* MainImpl::getTabs<FileView>(QWidget*)'
/home/cartman/qgit4/src/mainimpl.cpp:754: undefined reference to `QList<Fil=
eView*>::~QList()'
=2E./build/mainimpl.o: In function `QList<FileView*>::detach()':
/usr/qt/4/include/QtCore/qlist.h:99: undefined reference to `QList<FileView=
*>::detach_helper()'
=2E./build/mainimpl.o: In function `MainImpl::currentTabType(Domain**)':
/home/cartman/qgit4/src/mainimpl.cpp:760: undefined reference to `QList<Fil=
eView*>::~QList()'
=2E./build/mainimpl.o: In function `MainImpl::ActViewFile_activated()':
/home/cartman/qgit4/src/mainimpl.cpp:438: undefined reference to `FileView*=
 MainImpl::firstTab<FileView>(QWidget*)'
=2E./build/mainimpl.o: In function `MainImpl::pushButtonCloseTab_clicked()':
/home/cartman/qgit4/src/mainimpl.cpp:418: undefined reference to `FileView*=
 MainImpl::firstTab<FileView>(QWidget*)'
/home/cartman/qgit4/src/mainimpl.cpp:414: undefined reference to `PatchView=
* MainImpl::firstTab<PatchView>(QWidget*)'
=2E./build/mainimpl.o: In function `MainImpl::shortCutActivated()':
/home/cartman/qgit4/src/mainimpl.cpp:915: undefined reference to `PatchView=
* MainImpl::firstTab<PatchView>(QWidget*)'
/home/cartman/qgit4/src/mainimpl.cpp:915: undefined reference to `FileView*=
 MainImpl::firstTab<FileView>(QWidget*)'
=2E./build/mainimpl.o: In function `MainImpl':
/home/cartman/qgit4/src/mainimpl.cpp:106: undefined reference to `QVector<Q=
Splitter*>::QVector(int, QSplitter* const&)'
=2E./build/mainimpl.o: In function `~QVector':
/usr/qt/4/include/QtCore/qvector.h:78: undefined reference to `QVector<QSpl=
itter*>::free(QVectorTypedData<QSplitter*>*)'
/usr/qt/4/include/QtCore/qvector.h:78: undefined reference to `QVector<QSpl=
itter*>::free(QVectorTypedData<QSplitter*>*)'
=2E./build/mainimpl.o: In function `MainImpl':
/home/cartman/qgit4/src/mainimpl.cpp:106: undefined reference to `QVector<Q=
Splitter*>::QVector(int, QSplitter* const&)'
=2E./build/mainimpl.o: In function `~QVector':
/usr/qt/4/include/QtCore/qvector.h:78: undefined reference to `QVector<QSpl=
itter*>::free(QVectorTypedData<QSplitter*>*)'
/usr/qt/4/include/QtCore/qvector.h:78: undefined reference to `QVector<QSpl=
itter*>::free(QVectorTypedData<QSplitter*>*)'
=2E./build/namespace_def.o: In function `~QHash':
/usr/qt/4/include/QtCore/qhash.h:238: undefined reference to `QHash<QString=
, QPixmap const*>::freeData(QHashData*)'
=2E./build/namespace_def.o: In function `qDeleteAll<QHash<QString, const QP=
ixmap*> >':
/usr/qt/4/include/QtCore/qalgorithms.h:338: undefined reference to `void qD=
eleteAll<QHash<QString, QPixmap const*>::const_iterator>(QHash<QString, QPi=
xmap const*>::const_iterator, QHash<QString, QPixmap const*>::const_iterato=
r)'
=2E./build/namespace_def.o: In function `QHash<QString, QPixmap const*>::co=
ntains(QString const&) const':
/usr/qt/4/include/QtCore/qhash.h:814: undefined reference to `QHash<QString=
, QPixmap const*>::findNode(QString const&, unsigned int*) const'
=2E./build/namespace_def.o: In function `QHash<QString, QPixmap const*>::va=
lue(QString const&) const':
/usr/qt/4/include/QtCore/qhash.h:560: undefined reference to `QHash<QString=
, QPixmap const*>::findNode(QString const&, unsigned int*) const'
/usr/qt/4/include/QtCore/qhash.h:560: undefined reference to `QHash<QString=
, QPixmap const*>::findNode(QString const&, unsigned int*) const'
=2E./build/namespace_def.o: In function `QHash<QString, QPixmap const*>::in=
sert(QString const&, QPixmap const* const&)':
/usr/qt/4/include/QtCore/qhash.h:706: undefined reference to `QHash<QString=
, QPixmap const*>::findNode(QString const&, unsigned int*) const'
/usr/qt/4/include/QtCore/qhash.h:706: undefined reference to `QHash<QString=
, QPixmap const*>::findNode(QString const&, unsigned int*) const'
=2E./build/namespace_def.o:/usr/qt/4/include/QtCore/qhash.h:706: more undef=
ined references to `QHash<QString, QPixmap const*>::findNode(QString const&=
, unsigned int*) const' follow
=2E./build/namespace_def.o: In function `QHash<QString, QPixmap const*>::de=
tach()':
/usr/qt/4/include/QtCore/qhash.h:253: undefined reference to `QHash<QString=
, QPixmap const*>::detach_helper()'
/usr/qt/4/include/QtCore/qhash.h:253: undefined reference to `QHash<QString=
, QPixmap const*>::detach_helper()'
/usr/qt/4/include/QtCore/qhash.h:253: undefined reference to `QHash<QString=
, QPixmap const*>::detach_helper()'
/usr/qt/4/include/QtCore/qhash.h:253: undefined reference to `QHash<QString=
, QPixmap const*>::detach_helper()'
/usr/qt/4/include/QtCore/qhash.h:253: undefined reference to `QHash<QString=
, QPixmap const*>::detach_helper()'
=2E./build/namespace_def.o:/usr/qt/4/include/QtCore/qhash.h:253: more undef=
ined references to `QHash<QString, QPixmap const*>::detach_helper()' follow
=2E./build/revsview.o: In function `QVector<QSplitter*>::operator<<(QSplitt=
er* const&)':
/usr/qt/4/include/QtCore/qvector.h:246: undefined reference to `QVector<QSp=
litter*>::append(QSplitter* const&)'
=2E./build/revsview.o: In function `QVector<QSplitter*>::operator<<(QSplitt=
er* const&)':
/home/cartman/qgit4/src/revsview.cpp:84: undefined reference to `QVector<QS=
plitter*>::append(QSplitter* const&)'
=2E./build/revsview.o: In function `~QVector':
/usr/qt/4/include/QtCore/qvector.h:78: undefined reference to `QVector<QSpl=
itter*>::free(QVectorTypedData<QSplitter*>*)'
/usr/qt/4/include/QtCore/qvector.h:78: undefined reference to `QVector<QSpl=
itter*>::free(QVectorTypedData<QSplitter*>*)'
=2E./build/revsview.o: In function `QVector<QSplitter*>::operator<<(QSplitt=
er* const&)':
/usr/qt/4/include/QtCore/qvector.h:246: undefined reference to `QVector<QSp=
litter*>::append(QSplitter* const&)'
=2E./build/revsview.o: In function `QVector<QSplitter*>::operator<<(QSplitt=
er* const&)':
/home/cartman/qgit4/src/revsview.cpp:84: undefined reference to `QVector<QS=
plitter*>::append(QSplitter* const&)'
=2E./build/revsview.o: In function `~QVector':
/usr/qt/4/include/QtCore/qvector.h:78: undefined reference to `QVector<QSpl=
itter*>::free(QVectorTypedData<QSplitter*>*)'
/usr/qt/4/include/QtCore/qvector.h:78: undefined reference to `QVector<QSpl=
itter*>::free(QVectorTypedData<QSplitter*>*)'
=2E./build/revsview.o: In function `QVector<QSplitter*>::operator<<(QSplitt=
er* const&)':
/usr/qt/4/include/QtCore/qvector.h:246: undefined reference to `QVector<QSp=
litter*>::append(QSplitter* const&)'
=2E./build/revsview.o: In function `QVector<QSplitter*>::operator<<(QSplitt=
er* const&)':
/home/cartman/qgit4/src/revsview.cpp:84: undefined reference to `QVector<QS=
plitter*>::append(QSplitter* const&)'
=2E./build/revsview.o: In function `~QVector':
/usr/qt/4/include/QtCore/qvector.h:78: undefined reference to `QVector<QSpl=
itter*>::free(QVectorTypedData<QSplitter*>*)'
/usr/qt/4/include/QtCore/qvector.h:78: undefined reference to `QVector<QSpl=
itter*>::free(QVectorTypedData<QSplitter*>*)'
=2E./build/revsview.o: In function `QVector<QSplitter*>::operator<<(QSplitt=
er* const&)':
/usr/qt/4/include/QtCore/qvector.h:246: undefined reference to `QVector<QSp=
litter*>::append(QSplitter* const&)'
=2E./build/revsview.o: In function `QVector<QSplitter*>::operator<<(QSplitt=
er* const&)':
/home/cartman/qgit4/src/revsview.cpp:41: undefined reference to `QVector<QS=
plitter*>::append(QSplitter* const&)'
=2E./build/revsview.o: In function `~QVector':
/usr/qt/4/include/QtCore/qvector.h:78: undefined reference to `QVector<QSpl=
itter*>::free(QVectorTypedData<QSplitter*>*)'
/usr/qt/4/include/QtCore/qvector.h:78: undefined reference to `QVector<QSpl=
itter*>::free(QVectorTypedData<QSplitter*>*)'
=2E./build/revsview.o: In function `QVector<QSplitter*>::operator<<(QSplitt=
er* const&)':
/usr/qt/4/include/QtCore/qvector.h:246: undefined reference to `QVector<QSp=
litter*>::append(QSplitter* const&)'
=2E./build/revsview.o: In function `QVector<QSplitter*>::operator<<(QSplitt=
er* const&)':
/home/cartman/qgit4/src/revsview.cpp:41: undefined reference to `QVector<QS=
plitter*>::append(QSplitter* const&)'
=2E./build/revsview.o: In function `~QVector':
/usr/qt/4/include/QtCore/qvector.h:78: undefined reference to `QVector<QSpl=
itter*>::free(QVectorTypedData<QSplitter*>*)'
/usr/qt/4/include/QtCore/qvector.h:78: undefined reference to `QVector<QSpl=
itter*>::free(QVectorTypedData<QSplitter*>*)'
=2E./build/moc_annotate.o: In function `~QMap':
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QPair<QSt=
ring, unsigned int>, QString>::freeData(QMapData*)'
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QString, =
=46ileAnnotation>::freeData(QMapData*)'
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QString, =
RangeInfo>::freeData(QMapData*)'
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QString, =
=46ileAnnotation>::freeData(QMapData*)'
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QPair<QSt=
ring, unsigned int>, QString>::freeData(QMapData*)'
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QPair<QSt=
ring, unsigned int>, QString>::freeData(QMapData*)'
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QString, =
=46ileAnnotation>::freeData(QMapData*)'
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QString, =
RangeInfo>::freeData(QMapData*)'
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QString, =
=46ileAnnotation>::freeData(QMapData*)'
/usr/qt/4/include/QtCore/qmap.h:131: undefined reference to `QMap<QPair<QSt=
ring, unsigned int>, QString>::freeData(QMapData*)'
collect2: ld returned 1 exit status
make[2]: *** [../bin/qgit] Error 1
make[2]: Leaving directory `/home/cartman/qgit4/src'
make[1]: *** [release] Error 2
make[1]: Leaving directory `/home/cartman/qgit4/src'
make: *** [sub-src-make_default] Error 2

--Boundary-01=_wT/aG8ThJeMZiCr--

--nextPart2432646.0mOjU7zxQt
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)

iQIVAwUARmv0+Ee9qviWcMsnAQLq8hAAw7XQXE1Ej4ns8sUn+QqGOxZTESFwmtnI
o0ZuM8PNb480SnXNj8CADwN05rK1b7atw1Mq1/Rm59JUAU1qg9ucxTVCAR4UP5TF
eyM91/BSPTDVt36OjLvhzuOn7JS0cpdRNQBcCQaiTGXTVzGADmRebsMenTIpgGnq
mfSGWAp8tn6dsKZgqlm8QSHiw7kn/7lIGsCz63te6fp1rxlgrWZa5TfFX//s6zwL
W+nXne4dM9GViK8p54c29ZWSg3E9QowTU97cz8E5Mwwqw33ZzAO0F1rypyaIMaZ4
Rh+Dg0fecs0veH4z6M+OLYnC2bbXxspoGzgMlqx6/1aB5xKHQ68uTyyf7sGq/dkT
PIPLxvdM3wdCXgft0dIaCPQC5CgceQMtNcC+/lhBlScbLcrPiTz0oDUApUX+3QlI
3p2WPkNQq+yyu1Hy7shpsBzb5rOsqSPNBZsRe5GqXPgra5iRSlK1240oJ6YNEkhe
J6BKp7KUMkVL1I53dJtn+5UufmVpvyijWhKzy03h2ykUo8VIPbvRo70DUR6VFn0Y
DNIE5d5nYaN5sNej6kUUjnhvxZo+CtA0kYa1v44+52J2K//ItNtntqZmFUeQgUyo
kCHMZSK2DPqIeYliw23VVFUHoFmPwk3ThCkaaNOP6I1ceXrcsuZUDYLU/b/4iv+v
aJdUAta0nvs=
=0cmY
-----END PGP SIGNATURE-----

--nextPart2432646.0mOjU7zxQt--
