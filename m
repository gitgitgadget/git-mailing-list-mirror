From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] More updates and corrections to the russian translation of
	git-gui
Date: Mon, 22 Oct 2007 22:28:48 +0200
Message-ID: <20071022202848.GB23714@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Kirill <kirillathome@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 22:29:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik3tt-0004La-4U
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 22:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbXJVU3H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Oct 2007 16:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbXJVU3G
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 16:29:06 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:62256 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbXJVU3C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 16:29:02 -0400
Received: from tigra.home (Fab70.f.strato-dslnet.de [195.4.171.112])
	by post.webmailer.de (fruni mo26) (RZmta 13.6)
	with ESMTP id t0398fj9MJF6hL ; Mon, 22 Oct 2007 22:28:53 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A0B85277AE;
	Mon, 22 Oct 2007 22:28:50 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 4952256D22; Mon, 22 Oct 2007 22:28:48 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJKf+sU=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62044>

In particular many screw-ups after po regeneration were fixed.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 po/ru.po |  362 ++++++++++++++++++++++--------------------------------=
--------
 1 files changed, 127 insertions(+), 235 deletions(-)

diff --git a/po/ru.po b/po/ru.po
index ed5b67a..b8e9447 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -8,8 +8,8 @@ msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2007-10-10 04:04-0400\n"
-"PO-Revision-Date: 2007-10-20 14:29-0500\n"
-"Last-Translator: Kirill <kirillathome@gmail.com>\n"
+"PO-Revision-Date: 2007-10-22 22:30-0200\n"
+"Last-Translator: Alex Riesen <raa.lkml@gmail.com>\n"
 "Language-Team: Russian Translation <git@vger.kernel.org>\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
@@ -21,9 +21,9 @@ msgid "git-gui: fatal error"
 msgstr "git-gui: =D0=BA=D1=80=D0=B8=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=
=D0=B0=D1=8F =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=B0"
=20
 #: git-gui.sh:595
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Invalid font specified in %s:"
-msgstr "=D0=92 =D0=BE=D0=B1=D0=BE=D0=BB=D0=BE=D1=87=D0=BA=D0=B5 =D1=83=
=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD =D0=BD=D0=B5=D0=B2=
=D0=B5=D1=80=D0=BD=D1=8B=D0=B9 =D1=88=D1=80=D0=B8=D1=84=D1=82.%s:"
+msgstr "=D0=92 %s =D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=
=D0=BD =D0=BD=D0=B5=D0=B2=D0=B5=D1=80=D0=BD=D1=8B=D0=B9 =D1=88=D1=80=D0=
=B8=D1=84=D1=82:"
=20
 #: git-gui.sh:620
 msgid "Main Font"
@@ -31,7 +31,7 @@ msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82 =D0=B8=D0=BD=D1=
=82=D0=B5=D1=80=D1=84=D0=B5=D0=B9=D1=81=D0=B0"
=20
 #: git-gui.sh:621
 msgid "Diff/Console Font"
-msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82 =D0=B2 =D0=BA=D0=BE=D0=BD=D1=81=
=D0=BE=D0=BB=D0=B8 diff"
+msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82 =D0=BA=D0=BE=D0=BD=D1=81=D0=BE=D0=
=BB=D0=B8 =D0=B8 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9=
 (diff)"
=20
 #: git-gui.sh:635
 msgid "Cannot find git in PATH."
@@ -64,9 +64,8 @@ msgid "Git directory not found:"
 msgstr "=D0=9A=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 Git =D0=BD=D0=B5 =D0=
=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD:"
=20
 #: git-gui.sh:860
-#, fuzzy
 msgid "Cannot move to top of working directory:"
-msgstr "=D0=9A=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3.git =D0=B8=D1=81=D0=
=BF=D0=BE=D1=80=D1=87=D0=B5=D0=BD: "
+msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=
=BF=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=BA=D0=BE=D1=80=D0=BD=
=D1=8E =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=B3=D0=BE =D0=BA=D0=B0=D1=
=82=D0=B0=D0=BB=D0=BE=D0=B3=D0=B0 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=
=82=D0=BE=D1=80=D0=B8=D1=8F: "
=20
 #: git-gui.sh:867
 msgid "Cannot use funny .git directory:"
@@ -78,7 +77,7 @@ msgstr "=D0=9E=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=
=B2=D1=83=D0=B5=D1=82 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =D0=BA=
=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3"
=20
 #: git-gui.sh:1019
 msgid "Refreshing file status..."
-msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D1=
=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8F =D1=84=D0=B0=D0=B9=D0=
=BB=D0=BE=D0=B2 =D0=BF=D1=80=D0=BE=D0=B5=D0=BA=D1=82=D0=B0..."
+msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D0=B8 =D0=BE =D1=81=
=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=
=D0=BE=D0=B2..."
=20
 #: git-gui.sh:1084
 msgid "Scanning for modified files ..."
@@ -94,7 +93,7 @@ msgstr "=D0=9D=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=
=B5=D0=BD=D0=BE"
=20
 #: git-gui.sh:1527
 msgid "Modified, not staged"
-msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BE, =D0=BD=D0=BE=
 =D0=BD=D0=B5 =D0=B2=D0=BA=D0=BB=D1=8E=D1=87=D0=B5=D0=BD=D0=BE"
+msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BE, =D0=BD=D0=B5=
 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE=
"
=20
 #: git-gui.sh:1528 git-gui.sh:1533
 msgid "Staged for commit"
@@ -105,7 +104,6 @@ msgid "Portions staged for commit"
 msgstr "=D0=A7=D0=B0=D1=81=D1=82=D0=B8, =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=
=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=B4=D0=BB=D1=8F=
 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
 #: git-gui.sh:1530 git-gui.sh:1535
-#, fuzzy
 msgid "Staged for commit, missing"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=
=D0=BD=D0=B8=D1=8F, =D0=BE=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=
=83=D0=B5=D1=82"
=20
@@ -123,7 +121,7 @@ msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=
=B2=D0=BB=D0=B5=D0=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=83=D0=B4=D0=B0=D0=BB=
=D0=B5=D0=BD=D0=B8=D1=8F"
=20
 #: git-gui.sh:1539
 msgid "Staged for removal, still present"
-msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=
=D1=8F, =D0=BD=D0=BE =D0=B5=D1=89=D0=B5 =D0=BD=D0=B5 =D1=83=D0=B4=D0=B0=
=D0=BB=D0=B5=D0=BD=D0=BE"
+msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=
=D1=8F, =D0=B5=D1=89=D0=B5 =D0=BD=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=
=BD=D0=BE"
=20
 #: git-gui.sh:1541 git-gui.sh:1542 git-gui.sh:1543 git-gui.sh:1544
 msgid "Requires merge resolution"
@@ -157,7 +155,6 @@ msgid "Branch"
 msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C"
=20
 #: git-gui.sh:1794 lib/choose_rev.tcl:547
-#, fuzzy
 msgid "Commit@@noun"
 msgstr "=D0=A1=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5"
=20
@@ -166,18 +163,16 @@ msgid "Merge"
 msgstr "=D0=9E=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B8=D1=82=D1=8C"
=20
 #: git-gui.sh:1798 lib/choose_rev.tcl:556
-#, fuzzy
 msgid "Remote"
-msgstr "=D0=B2=D0=BD=D0=B5=D1=88=D0=BD=D0=B8=D0=B9:"
+msgstr "=D0=92=D0=BD=D0=B5=D1=88=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B8"
=20
 #: git-gui.sh:1807
 msgid "Browse Current Branch's Files"
 msgstr "=D0=9F=D1=80=D0=BE=D1=81=D0=BC=D0=BE=D1=82=D1=80=D0=B5=D1=82=D1=
=8C =D1=84=D0=B0=D0=B9=D0=BB=D1=8B =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=
=D0=B9 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
=20
 #: git-gui.sh:1811
-#, fuzzy
 msgid "Browse Branch Files..."
-msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D1=84=D0=B0=D0=
=B9=D0=BB=D1=8B =D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D1=84=D0=B0=D0=
=B9=D0=BB=D1=8B =D0=B2=D0=B5=D1=82=D0=B2=D0=B8..."
=20
 #: git-gui.sh:1816
 msgid "Visualize Current Branch's History"
@@ -188,9 +183,9 @@ msgid "Visualize All Branch History"
 msgstr "=D0=98=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F =D0=B2=D1=81=D0=B5=D1=
=85 =D0=B2=D0=B5=D1=82=D0=B2=D0=B5=D0=B9 =D0=BD=D0=B0=D0=B3=D0=BB=D1=8F=
=D0=B4=D0=BD=D0=BE"
=20
 #: git-gui.sh:1827
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Browse %s's Files"
-msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D1=84=D0=B0=D0=
=B9=D0=BB=D1=8B =D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D1=84=D0=B0=D0=
=B9=D0=BB=D1=8B =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 %s"
=20
 #: git-gui.sh:1829
 #, tcl-format
@@ -281,12 +276,10 @@ msgid "Rescan"
 msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C"
=20
 #: git-gui.sh:1953
-#, fuzzy
 msgid "Stage To Commit"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=
=D0=B8=D1=8F"
=20
 #: git-gui.sh:1958
-#, fuzzy
 msgid "Stage Changed Files To Commit"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D1=84=
=D0=B0=D0=B9=D0=BB=D1=8B =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=
=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
@@ -303,7 +296,6 @@ msgid "Sign Off"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=BF=D0=B8=D1=81=D0=B0=D1=82=D1=8C"
=20
 #: git-gui.sh:1980 git-gui.sh:2296
-#, fuzzy
 msgid "Commit@@verb"
 msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D1=8C"
=20
@@ -319,11 +311,10 @@ msgstr "=D0=9F=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D1=82=
=D1=8C =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5=
=2E.."
 msgid "Push..."
 msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C..."
=20
-# carbon copy
 #: git-gui.sh:2019 lib/choose_repository.tcl:41
 #, fuzzy
 msgid "Apple"
-msgstr "Apple"
+msgstr ""
=20
 #: git-gui.sh:2022 git-gui.sh:2044 lib/about.tcl:13
 #: lib/choose_repository.tcl:44 lib/choose_repository.tcl:50
@@ -347,9 +338,8 @@ msgstr "=D0=9F=D0=BE=D0=BC=D0=BE=D1=89=D1=8C"
 msgid "Online Documentation"
 msgstr "=D0=94=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=86=D0=
=B8=D1=8F =D0=B2 =D0=B8=D0=BD=D1=82=D0=B5=D1=80=D0=BD=D0=B5=D1=82=D0=B5=
"
=20
-# TOVERIFY
 #: git-gui.sh:2165
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr "=D0=BA=D1=80=D0=B8=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B0=D1=
=8F =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=B0: %s: =D0=BD=D0=B5=D1=82 =D1=82=
=D0=B0=D0=BA=D0=BE=D0=B3=D0=BE =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=B8=D0=
=BB=D0=B8 =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3=D0=B0"
=20
@@ -358,43 +348,34 @@ msgid "Current Branch:"
 msgstr "=D0=A2=D0=B5=D0=BA=D1=83=D1=89=D0=B0=D1=8F =D0=B2=D0=B5=D1=82=D0=
=B2=D1=8C:"
=20
 #: git-gui.sh:2219
-#, fuzzy
 msgid "Staged Changes (Will Commit)"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE (=D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=BE=D1=85=D1=80=D0=B0=
=D0=BD=D0=B5=D0=BD=D0=BE)"
=20
-# TOVERIFY
 #: git-gui.sh:2239
-#, fuzzy
 msgid "Unstaged Changes"
-msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BE"
+msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BE (=D0=BD=D0=B5=
 =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=
=B5=D0=BD=D0=BE)"
=20
-# carbon copy
 #: git-gui.sh:2286
-#, fuzzy
 msgid "Stage Changed"
-msgstr "Stage Changed"
+msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D0=B2=D1=81=D0=B5"
=20
 #: git-gui.sh:2302 lib/transport.tcl:93 lib/transport.tcl:182
 msgid "Push"
 msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C"
=20
 #: git-gui.sh:2332
-#, fuzzy
 msgid "Initial Commit Message:"
-msgstr "=D0=9F=D0=B5=D1=80=D0=B2=D0=BE=D0=BD=D0=B0=D1=87=D0=B0=D0=BB=D1=
=8C=D0=BD=D1=8B=D0=B9 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=
=80=D0=B8=D0=B9 =D0=BA =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=
=D1=8E:"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=BF=D0=B5=D1=80=D0=B2=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=
=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E:"
=20
 #: git-gui.sh:2333
-#, fuzzy
 msgid "Amended Commit Message:"
-msgstr "=D0=98=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D1=
=8B=D0=B9 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E:"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E=
:"
=20
 #: git-gui.sh:2334
-#, fuzzy
 msgid "Amended Initial Commit Message:"
-msgstr "=D0=9F=D0=B5=D1=80=D0=B2=D0=BE=D0=BD=D0=B0=D1=87=D0=B0=D0=BB=D1=
=8C=D0=BD=D1=8B=D0=B9 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=
=80=D0=B8=D0=B9 =D0=BA =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=
=D0=BD=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=
=D0=B8=D1=8E:"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=BC=D1=83 =D0=BF=D0=B5=D1=80=D0=B2=D0=BE=D0=BD=D0=B0=D1=87=D0=B0=
=D0=BB=D1=8C=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=
=D0=BD=D0=B8=D1=8E:"
=20
 #: git-gui.sh:2335
-#, fuzzy
 msgid "Amended Merge Commit Message:"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=BC=D1=83 =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=
=D0=B8=D1=8E:"
=20
@@ -467,9 +448,7 @@ msgstr ""
 "=D0=B7=D0=B0=D0=BF=D1=83=D1=89=D0=B5=D0=BD=D0=BD=D1=8B=D0=BC=D0=B8 =D0=
=B8=D0=B7 %s\n"
 "\n"
=20
-# TOVERIFY
 #: git-gui.sh:2707
-#, fuzzy
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
@@ -491,10 +470,10 @@ msgid ""
 msgstr ""
 "\n"
 "\n"
-"=D0=A5=D0=BE=D1=80=D0=BE=D1=88=D0=B0=D1=8F =D0=B7=D0=B0=D0=BC=D0=B5=D0=
=BD=D0=B0 =D0=B4=D0=BB=D1=8F %s\n"
-"=D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D1=8F=D0=B5=D1=82 =D0=B7=D0=BD=D0=
=B0=D1=87=D0=B5=D0=BD=D0=B8=D1=8F =D0=B4=D0=BB=D1=8F user.name =D0=B8\n=
"
-"user.email =D0=B2 =D0=92=D0=B0=D1=88 =D0=BF=D0=B5=D1=80=D1=81=D0=BE=D0=
=BD=D0=B0=D0=BB=D1=8C=D0=BD=D1=8B=D0=B9\n"
-"~/.gitconfig =D1=84=D0=B0=D0=B9=D0=BB.\n"
+"=D0=92=D0=BC=D0=B5=D1=81=D1=82=D0=BE =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=
=8C=D0=B7=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F %s =D0=BC=D0=BE=D0=B6=D0=BD=
=D0=BE\n"
+"=D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D1=8C =D0=B7=D0=BD=D0=
=B0=D1=87=D0=B5=D0=BD=D0=B8=D1=8F user.name =D0=B8\n"
+"user.email =D0=B2 =D0=92=D0=B0=D1=88=D0=B5=D0=BC =D0=BF=D0=B5=D1=80=D1=
=81=D0=BE=D0=BD=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=BC\n"
+"=D1=84=D0=B0=D0=B9=D0=BB=D0=B5 ~/.gitconfig.\n"
=20
 #: lib/about.tcl:25
 msgid "git-gui - a graphical user interface for Git."
@@ -510,69 +489,56 @@ msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=
=D0=BD=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=
=D0=B5:"
=20
 #: lib/blame.tcl:249
 msgid "Copy Commit"
-msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D1=
=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D0=BE=D0=B5 =D1=81=D0=
=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5"
+msgstr "=D0=A1=D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=
=8C SHA-1"
=20
 #: lib/blame.tcl:369
 #, tcl-format
 msgid "Reading %s..."
 msgstr "=D0=A7=D1=82=D0=B5=D0=BD=D0=B8=D0=B5 %s..."
=20
-# carbon copy
 #: lib/blame.tcl:473
-#, fuzzy
 msgid "Loading copy/move tracking annotations..."
-msgstr "Loading copy/move tracking annotations..."
+msgstr "=D0=97=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B0 =D0=B0=D0=BD=D0=
=BD=D0=BE=D1=82=D0=B0=D1=86=D0=B8=D0=B8 =D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=
=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=B9/=D0=BF=D0=B5=D1=80=D0=B5=D0=B8=D0=BC=D0=
=B5=D0=BD=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=B9..."
=20
-# TOVERIFY
 #: lib/blame.tcl:493
-#, fuzzy
 msgid "lines annotated"
-msgstr "=D1=81=D1=82=D1=80=D0=BE=D0=BA =D0=BF=D1=80=D0=BE=D0=BA=D0=BE=D0=
=BC=D0=B5=D0=BD=D1=82=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=BE"
+msgstr "=D1=81=D1=82=D1=80=D0=BE=D0=BA =D0=BF=D1=80=D0=BE=D0=BA=D0=BE=D0=
=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=BE"
=20
-# carbon copy
 #: lib/blame.tcl:674
-#, fuzzy
 msgid "Loading original location annotations..."
-msgstr "Loading original location annotations..."
+msgstr "=D0=97=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B0 =D0=B0=D0=BD=D0=
=BD=D0=BE=D1=82=D0=B0=D1=86=D0=B8=D0=B9 =D0=BF=D0=B5=D1=80=D0=B2=D0=BE=D0=
=BD=D0=B0=D1=87=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B3=D0=BE =D0=BF=D0=BE=D0=
=BB=D0=BE=D0=B6=D0=B5=D0=BD=D0=B8=D1=8F =D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=
=82=D0=B0..."
=20
-# carbon copy
 #: lib/blame.tcl:677
-#, fuzzy
 msgid "Annotation complete."
-msgstr "Annotation complete."
+msgstr "=D0=90=D0=BD=D0=BD=D0=BE=D1=82=D0=B0=D1=86=D0=B8=D1=8F =D0=B7=D0=
=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B5=D0=BD=D0=B0."
=20
 #: lib/blame.tcl:731
-#, fuzzy
 msgid "Loading annotation..."
-msgstr "=D0=97=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B0 %s..."
+msgstr "=D0=97=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B0 =D0=B0=D0=BD=D0=
=BD=D0=BE=D1=82=D0=B0=D1=86=D0=B8=D0=B8..."
=20
 #: lib/blame.tcl:787
 msgid "Author:"
 msgstr "=D0=90=D0=B2=D1=82=D0=BE=D1=80:"
=20
 #: lib/blame.tcl:791
-#, fuzzy
 msgid "Committer:"
-msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D0=BE=D0=
=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5:"
+msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB:"
=20
 #: lib/blame.tcl:796
 msgid "Original File:"
 msgstr "=D0=98=D1=81=D1=85=D0=BE=D0=B4=D0=BD=D1=8B=D0=B9 =D1=84=D0=B0=D0=
=B9=D0=BB:"
=20
-# carbon copy
 #: lib/blame.tcl:910
-#, fuzzy
 msgid "Originally By:"
-msgstr "Originally By:"
+msgstr "=D0=98=D1=81=D1=82=D0=BE=D1=87=D0=BD=D0=B8=D0=BA:"
=20
 #: lib/blame.tcl:916
-#, fuzzy
 msgid "In File:"
 msgstr "=D0=A4=D0=B0=D0=B9=D0=BB:"
=20
 #: lib/blame.tcl:921
 msgid "Copied Or Moved Here By:"
-msgstr "=D0=9A=D1=82=D0=BE =D1=81=D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=
=B2=D0=B0=D0=BB/=D0=BF=D0=B5=D1=80=D0=B5=D0=BC=D0=B5=D1=81=D1=82=D0=B8=D0=
=BB =D1=81=D1=8E=D0=B4=D0=B0:"
+msgstr "=D0=A1=D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=
=BE/=D0=BF=D0=B5=D1=80=D0=B5=D0=BC=D0=B5=D1=89=D0=B5=D0=BD=D0=BE =D0=B2=
:"
=20
 #: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
 msgid "Checkout Branch"
@@ -702,7 +668,7 @@ msgid ""
 "\n"
 " Delete the selected branches?"
 msgstr ""
-"=D0=92=D0=BE=D1=81=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=BD=D1=83=D1=8E =D0=B2=D0=B5=
=D1=82=D0=B2=D1=8C =D1=81=D0=BB=D0=BE=D0=B6=D0=BD=D0=BE. \n"
+"=D0=92=D0=BE=D1=81=D1=81=D1=82=D0=B0=D0=BD=D0=B0=D0=B2=D0=BB=D0=B8=D0=
=B2=D0=B0=D1=82=D1=8C =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=
=B5 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 =D1=81=D0=BB=D0=BE=D0=B6=D0=BD=D0=BE=
=2E \n"
 "\n"
 " =D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C =D0=B2=D1=8B=D0=B1=D1=80=D0=
=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8?"
=20
@@ -773,14 +739,14 @@ msgid "Browse"
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C"
=20
 #: lib/checkout_op.tcl:79
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Fetching %s from %s"
-msgstr "=D0=9F=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B8=D0=
=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=B8=D0=B7 %s "
+msgstr "=D0=9F=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 %s =D0=B8=
=D0=B7 %s "
=20
 #: lib/checkout_op.tcl:127
 #, tcl-format
 msgid "fatal: Cannot resolve %s"
-msgstr "=D0=BA=D1=80=D0=B8=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B0=D1=
=8F =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=B0: =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B3=
=D1=83 =D1=80=D0=B0=D1=81=D0=BF=D0=BE=D0=B7=D0=BD=D0=B0=D1=82=D1=8C %s"
+msgstr "=D0=BA=D1=80=D0=B8=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B0=D1=
=8F =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=B0: =D0=BD=D0=B5=D0=B2=D0=BE=D0=B7=
=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D1=80=D0=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B8=
=D1=82=D1=8C %s"
=20
 #: lib/checkout_op.tcl:140 lib/console.tcl:79 lib/database.tcl:31
 msgid "Close"
@@ -807,7 +773,7 @@ msgstr ""
 #: lib/checkout_op.tcl:220
 #, tcl-format
 msgid "Merge strategy '%s' not supported."
-msgstr "=D0=9E=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=8F =D0=BE=D0=B1=D1=
=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F '%s' =D0=BD=D0=B5 =D0=
=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D0=B2=D0=B0=D0=B5=D1=82=D1=
=81=D1=8F."
+msgstr "=D0=A1=D1=82=D1=80=D0=B0=D1=82=D0=B5=D0=B3=D0=B8=D1=8F =D0=BE=D0=
=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F '%s' =D0=BD=D0=
=B5 =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D0=B2=D0=B0=D0=B5=D1=
=82=D1=81=D1=8F."
=20
 #: lib/checkout_op.tcl:239
 #, tcl-format
@@ -815,9 +781,8 @@ msgid "Failed to update '%s'."
 msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BE=
=D0=B1=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C '%s'."
=20
 #: lib/checkout_op.tcl:251
-#, fuzzy
 msgid "Staging area (index) is already locked."
-msgstr "=D0=98=D0=BD=D0=B4=D0=B5=D0=BA=D1=81 =D0=B7=D0=B0=D0=B1=D0=BB=D0=
=BE=D0=BA=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD."
+msgstr "=D0=A0=D0=B0=D0=B1=D0=BE=D1=87=D0=B0=D1=8F =D0=BE=D0=B1=D0=BB=D0=
=B0=D1=81=D1=82=D1=8C =D0=B7=D0=B0=D0=B1=D0=BB=D0=BE=D0=BA=D0=B8=D1=80=D0=
=BE=D0=B2=D0=B0=D0=BD=D0=B0 =D0=B4=D1=80=D1=83=D0=B3=D0=B8=D0=BC =D0=BF=
=D1=80=D0=BE=D1=86=D0=B5=D1=81=D1=81=D0=BE=D0=BC."
=20
 #: lib/checkout_op.tcl:266
 msgid ""
@@ -829,14 +794,15 @@ msgid ""
 msgstr ""
 "=D0=9F=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B5 =D0=BF=D1=80=D0=
=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=
=82=D0=BE=D1=80=D0=B8=D1=8F =D0=BD=D0=B5 =D1=81=D0=BE=D0=BE=D1=82=D0=B2=
=D0=B5=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82 =D1=82=D0=B5=D0=BA=D1=83=
=D1=89=D0=B5=D0=BC=D1=83.\n"
 "\n"
-"=D0=A1 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D0=BF=D0=BE=D1=81=D0=
=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B9 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=
=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9 =D0=B1=D1=8B=D0=BB =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD =D0=B4=
=D1=80=D1=83=D0=B3=D0=BE=D0=B9 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=
=D0=BC=D0=BE=D0=B9 Git.=D0=9D=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=
=D0=BC=D0=BE =D0=BF=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C=
 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9, =D0=
=BF=D1=80=D0=B5=D0=B6=D0=B4=D0=B5 =D1=87=D0=B5=D0=BC =D0=B8=D0=B7=D0=BC=
=D0=B5=D0=BD=D1=8F=D1=82=D1=8C =D1=82=D0=B5=D0=BA=D1=83=D1=89=D1=83=D1=8E=
 =D0=B2=D0=B5=D1=82=D0=B2=D1=8C. \n"
+"=D0=A1 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D0=BF=D0=BE=D1=81=D0=
=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B9 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=
=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9 =D0=B1=D1=8B=D0=BB =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD =D0=B4=
=D1=80=D1=83=D0=B3=D0=BE=D0=B9 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=
=D0=BC=D0=BE=D0=B9 Git. "
+"=D0=9D=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D0=BE =D0=BF=D0=
=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9, =D0=BF=D1=80=D0=B5=D0=B6=
=D0=B4=D0=B5 =D1=87=D0=B5=D0=BC =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D1=8F=D1=
=82=D1=8C =D1=82=D0=B5=D0=BA=D1=83=D1=89=D1=83=D1=8E =D0=B2=D0=B5=D1=82=
=D0=B2=D1=8C.\n"
 "\n"
 "=D0=AD=D1=82=D0=BE =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=B4=D0=B5=D0=
=BB=D0=B0=D0=BD=D0=BE =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B0=D0=B2=
=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8.\n"
=20
 #: lib/checkout_op.tcl:322
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Updating working directory to '%s'..."
-msgstr "=D0=9E=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=
=82 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =D0=BA=D0=B0=D1=82=D0=B0=
=D0=BB=D0=BE=D0=B3"
+msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D1=
=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=B3=D0=BE =D0=BA=D0=B0=D1=82=D0=B0=D0=
=BB=D0=BE=D0=B3=D0=B0 =D0=B8=D0=B7 '%s'..."
=20
 #: lib/checkout_op.tcl:353
 #, tcl-format
@@ -863,9 +829,9 @@ msgstr ""
 "=D0=95=D1=81=D0=BB=D0=B8 =D0=B2=D1=8B =D1=85=D0=BE=D1=82=D0=B8=D1=82=D0=
=B5 =D1=81=D0=BD=D0=BE=D0=B2=D0=B0 =D0=B2=D0=B5=D1=80=D0=BD=D1=83=D1=82=
=D1=8C=D1=81=D1=8F =D0=BA =D0=BA=D0=B0=D0=BA=D0=BE=D0=B9-=D0=BD=D0=B8=D0=
=B1=D1=83=D0=B4=D1=8C =D0=B2=D0=B5=D1=82=D0=B2=D0=B8, =D1=81=D0=BE=D0=B7=
=D0=B4=D0=B0=D0=B9=D1=82=D0=B5 =D0=B5=D0=B5 =D1=81=D0=B5=D0=B9=D1=87=D0=
=B0=D1=81, =D0=BD=D0=B0=D1=87=D0=B8=D0=BD=D0=B0=D1=8F =D1=81 '=D0=A2=D0=
=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B3=D0=BE =D0=BE=D1=82=D1=81=D0=BE=D0=B5=D0=
=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE =D1=81=D0=BE=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8F'."
=20
 #: lib/checkout_op.tcl:446
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Checked out '%s'."
-msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8..."
+msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C '%s' =D1=81=D0=B4=D0=B5=D0=BB=D0=
=B0=D0=BD=D0=B0 =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B9."
=20
 #: lib/checkout_op.tcl:478
 #, tcl-format
@@ -901,7 +867,6 @@ msgstr ""
 "=D0=AD=D1=82=D0=BE=D0=B3=D0=BE =D0=BD=D0=B5 =D0=B4=D0=BE=D0=BB=D0=B6=D0=
=BD=D0=BE =D0=B1=D1=8B=D0=BB=D0=BE =D0=BF=D1=80=D0=BE=D0=B8=D0=B7=D0=BE=
=D0=B9=D1=82=D0=B8. %s =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B0=D0=B5=
=D1=82=D1=81=D1=8F."
=20
 #: lib/choose_font.tcl:39
-#, fuzzy
 msgid "Select"
 msgstr "=D0=92=D1=8B=D0=B4=D0=B5=D0=BB=D0=B8=D1=82=D1=8C =D0=B2=D1=81=D0=
=B5"
=20
@@ -910,15 +875,13 @@ msgid "Font Family"
 msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82"
=20
 #: lib/choose_font.tcl:73
-#, fuzzy
 msgid "Font Size"
-msgstr "=D0=A3=D0=BC=D0=B5=D0=BD=D1=8C=D1=88=D0=B8=D1=82=D1=8C =D1=80=D0=
=B0=D0=B7=D0=BC=D0=B5=D1=80 =D1=88=D1=80=D0=B8=D1=84=D1=82=D0=B0"
+msgstr "=D0=A0=D0=B0=D0=B7=D0=BC=D0=B5=D1=80 =D1=88=D1=80=D0=B8=D1=84=D1=
=82=D0=B0"
=20
 #: lib/choose_font.tcl:90
 msgid "Font Example"
 msgstr "=D0=9F=D1=80=D0=B8=D0=BC=D0=B5=D1=80 =D1=82=D0=B5=D0=BA=D1=81=D1=
=82=D0=B0"
=20
-# TOVERIFY: what's the Russian version of the font sample (see Windows=
 Fonts).
 #: lib/choose_font.tcl:101
 msgid ""
 "This is example text.\n"
@@ -929,39 +892,34 @@ msgstr ""
=20
 #: lib/choose_repository.tcl:25
 msgid "Git Gui"
-msgstr "Git Gui"
+msgstr ""
=20
 #: lib/choose_repository.tcl:69 lib/choose_repository.tcl:204
-#, fuzzy
 msgid "Create New Repository"
-msgstr "=D0=98=D0=B7 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=
=80=D0=B8=D1=8F"
+msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D0=BD=D0=BE=D0=B2=D1=
=8B=D0=B9 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9"
=20
 #: lib/choose_repository.tcl:74 lib/choose_repository.tcl:291
-#, fuzzy
 msgid "Clone Existing Repository"
-msgstr "=D0=A0=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9 =D0=BD=D0=B0=D0=B7=D0=BD=D0=B0=D1=87=D0=B5=D0=BD=D0=B8=D1=8F"
+msgstr "=D0=A1=D0=BA=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D1=8E=D1=89=D0=
=B8=D0=B9 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9"
=20
 #: lib/choose_repository.tcl:79 lib/choose_repository.tcl:800
-#, fuzzy
 msgid "Open Existing Repository"
-msgstr "=D0=A0=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9 =D0=BD=D0=B0=D0=B7=D0=BD=D0=B0=D1=87=D0=B5=D0=BD=D0=B8=D1=8F"
+msgstr "=D0=92=D1=8B=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D1=81=D1=83=D1=89=D0=
=B5=D1=81=D1=82=D0=B2=D1=83=D1=8E=D1=89=D0=B8=D0=B9 =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9"
=20
-# TOVERIFY
 #: lib/choose_repository.tcl:91
-#, fuzzy
 msgid "Next >"
 msgstr "=D0=94=D0=B0=D0=BB=D1=8C=D1=88=D0=B5 >"
=20
 #: lib/choose_repository.tcl:152
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Location %s already exists."
-msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C '%s' =D1=83=D0=B6=D0=B5 =D1=81=D1=
=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82."
+msgstr "=D0=9F=D1=83=D1=82=D1=8C '%s' =D1=83=D0=B6=D0=B5 =D1=81=D1=83=D1=
=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82."
=20
 #: lib/choose_repository.tcl:158 lib/choose_repository.tcl:165
 #: lib/choose_repository.tcl:172
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Failed to create repository %s:"
-msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=
=D0=BE=D0=BB=D0=BD=D0=BE=D1=81=D1=82=D1=8C=D1=8E =D1=81=D0=BE=D1=85=D1=80=
=D0=B0=D0=BD=D0=B8=D1=82=D1=8C =D0=BD=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=
=D0=BA=D0=B8:"
+msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D1=81=
=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=
=D1=82=D0=BE=D1=80=D0=B8=D0=B9 %s:"
=20
 #: lib/choose_repository.tcl:209 lib/choose_repository.tcl:309
 msgid "Directory:"
@@ -969,121 +927,98 @@ msgstr "=D0=9A=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3=
:"
=20
 #: lib/choose_repository.tcl:238 lib/choose_repository.tcl:363
 #: lib/choose_repository.tcl:834
-#, fuzzy
 msgid "Git Repository"
 msgstr "=D0=A0=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9"
=20
 #: lib/choose_repository.tcl:253 lib/choose_repository.tcl:260
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Directory %s already exists."
-msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C '%s' =D1=83=D0=B6=D0=B5 =D1=81=D1=
=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82."
+msgstr "=D0=9A=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 '%s' =D1=83=D0=B6=D0=
=B5 =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82."
=20
 #: lib/choose_repository.tcl:265
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "File %s already exists."
-msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C '%s' =D1=83=D0=B6=D0=B5 =D1=81=D1=
=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82."
+msgstr "=D0=A4=D0=B0=D0=B9=D0=BB '%s' =D1=83=D0=B6=D0=B5 =D1=81=D1=83=D1=
=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82."
=20
 #: lib/choose_repository.tcl:286
-#, fuzzy
 msgid "Clone"
-msgstr "=D0=97=D0=B0=D0=BA=D1=80=D1=8B=D1=82=D1=8C"
+msgstr "=D0=A1=D0=BA=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C"
=20
 #: lib/choose_repository.tcl:299
 msgid "URL:"
 msgstr "=D0=A1=D1=81=D1=8B=D0=BB=D0=BA=D0=B0:"
=20
-# TOVERIFY
 #: lib/choose_repository.tcl:319
-#, fuzzy
 msgid "Clone Type:"
 msgstr "=D0=A2=D0=B8=D0=BF =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0:"
=20
-# TOVERIFY
 #: lib/choose_repository.tcl:325
-#, fuzzy
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
 msgstr "=D0=A1=D1=82=D0=B0=D0=BD=D0=B4=D0=B0=D1=80=D1=82=D0=BD=D1=8B=D0=
=B9 (=D0=91=D1=8B=D1=81=D1=82=D1=80=D1=8B=D0=B9, =D0=BF=D0=BE=D0=BB=D1=83=
=D0=B8=D0=B7=D0=B1=D1=8B=D1=82=D0=BE=D1=87=D0=BD=D1=8B=D0=B9, \"=D0=B6=D0=
=B5=D1=81=D1=82=D0=BA=D0=B8=D0=B5\" =D1=81=D1=81=D1=8B=D0=BB=D0=BA=D0=B8=
)"
=20
-# TOVERIFY
 #: lib/choose_repository.tcl:331
-#, fuzzy
 msgid "Full Copy (Slower, Redundant Backup)"
-msgstr "=D0=9F=D0=BE=D0=BB=D0=BD=D0=B0=D1=8F =D0=BA=D0=BE=D0=BF=D0=B8=D1=
=8F (=D0=9C=D0=B5=D0=B4=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B9, =D0=B8=D0=B7=
=D0=B1=D1=8B=D1=82=D0=BE=D1=87=D0=BD=D0=B0=D1=8F =D1=80=D0=B5=D0=B7=D0=B5=
=D1=80=D0=B2=D0=BD=D0=B0=D1=8F =D0=BA=D0=BE=D0=BF=D0=B8=D1=8F)"
+msgstr "=D0=9F=D0=BE=D0=BB=D0=BD=D0=B0=D1=8F =D0=BA=D0=BE=D0=BF=D0=B8=D1=
=8F (=D0=9C=D0=B5=D0=B4=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B9, =D1=81=D0=BE=
=D0=B7=D0=B4=D0=B0=D0=B5=D1=82 =D1=80=D0=B5=D0=B7=D0=B5=D1=80=D0=B2=D0=BD=
=D1=83=D1=8E =D0=BA=D0=BE=D0=BF=D0=B8=D1=8E)"
=20
-# TOVERIFY
 #: lib/choose_repository.tcl:337
-#, fuzzy
 msgid "Shared (Fastest, Not Recommended, No Backup)"
 msgstr "=D0=9E=D0=B1=D1=89=D0=B8=D0=B9 (=D0=A1=D0=B0=D0=BC=D1=8B=D0=B9=
 =D0=B1=D1=8B=D1=81=D1=82=D1=80=D1=8B=D0=B9, =D0=BD=D0=B5 =D1=80=D0=B5=D0=
=BA=D0=BE=D0=BC=D0=B5=D0=BD=D0=B4=D1=83=D0=B5=D1=82=D1=81=D1=8F, =D0=B1=
=D0=B5=D0=B7 =D1=80=D0=B5=D0=B7=D0=B5=D1=80=D0=B2=D0=BD=D0=BE=D0=B9 =D0=
=BA=D0=BE=D0=BF=D0=B8=D0=B8)"
=20
 #: lib/choose_repository.tcl:369 lib/choose_repository.tcl:418
 #: lib/choose_repository.tcl:560 lib/choose_repository.tcl:630
 #: lib/choose_repository.tcl:840 lib/choose_repository.tcl:848
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Not a Git repository: %s"
-msgstr "=D0=9D=D0=B5 =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD =D1=80=D0=B5=
=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9"
+msgstr "=D0=9A=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 =D0=BD=D0=B5 =D1=8F=
=D0=B2=D0=BB=D1=8F=D0=B5=D1=82=D1=81=D1=8F =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=
=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B5=D0=BC: %s"
=20
-# TOVERIFY
 #: lib/choose_repository.tcl:405
-#, fuzzy
 msgid "Standard only available for local repository."
 msgstr "=D0=A1=D1=82=D0=B0=D0=BD=D0=B4=D0=B0=D1=80=D1=82=D0=BD=D1=8B=D0=
=B9 =D0=BA=D0=BB=D0=BE=D0=BD =D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=B5=
=D0=BD =D1=82=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE =D0=B4=D0=BB=D1=8F =D0=BB=D0=
=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B3=D0=BE =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F."
=20
-# TOVERIFY
 #: lib/choose_repository.tcl:409
-#, fuzzy
 msgid "Shared only available for local repository."
 msgstr "=D0=9E=D0=B1=D1=89=D0=B8=D0=B9 =D0=BA=D0=BB=D0=BE=D0=BD =D0=B2=
=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=B5=D0=BD =D1=82=D0=BE=D0=BB=D1=8C=D0=BA=
=D0=BE =D0=B4=D0=BB=D1=8F =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D0=
=BE=D0=B3=D0=BE =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=
=B8=D1=8F."
=20
-# TOVERIFY
 #: lib/choose_repository.tcl:439
-#, fuzzy
 msgid "Failed to configure origin"
-msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D1=81=D0=BA=D0=BE=D0=BD=
=D1=84=D0=B8=D0=B3=D1=83=D1=80=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C=
 =D0=B8=D1=81=D0=BA=D1=85=D0=BE=D0=B4=D0=BD=D0=B8=D0=BA."
+msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D1=81=D0=BA=D0=BE=D0=BD=
=D1=84=D0=B8=D0=B3=D1=83=D1=80=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C=
 =D0=B8=D1=81=D1=85=D0=BE=D0=B4=D0=BD=D1=8B=D0=B9 =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9."
=20
 #: lib/choose_repository.tcl:451
 msgid "Counting objects"
 msgstr "=D0=A1=D1=87=D0=B8=D1=82=D0=B0=D1=8E =D0=BE=D0=B1=D1=8A=D0=B5=D0=
=BA=D1=82=D1=8B"
=20
-# carbon copy
 #: lib/choose_repository.tcl:452
 #, fuzzy
 msgid "buckets"
-msgstr "buckets"
+msgstr ""
=20
-# TOVERIFY
 #: lib/choose_repository.tcl:476
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
-msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D1=81=D0=BA=D0=BE=D0=BF=
=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=
=D1=82=D1=8B/=D0=B8=D0=BD=D1=84=D0=BE/=D0=B0=D0=BB=D1=8C=D1=82=D0=B5=D1=
=80=D0=BD=D0=B0=D1=82=D0=B8=D0=B2=D1=8B: %s"
+msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D1=81=D0=BA=D0=BE=D0=BF=
=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C objects/info/alternates: %s"
=20
 #: lib/choose_repository.tcl:512
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Nothing to clone from %s."
-msgstr "=D0=9F=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B8=D0=
=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=B8=D0=B7 %s "
+msgstr "=D0=9D=D0=B5=D1=87=D0=B5=D0=B3=D0=BE =D0=BA=D0=BB=D0=BE=D0=BD=D0=
=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D1=81 %s."
=20
-# TOVERIFY
 #: lib/choose_repository.tcl:514 lib/choose_repository.tcl:728
 #: lib/choose_repository.tcl:740
-#, fuzzy
 msgid "The 'master' branch has not been initialized."
 msgstr "=D0=9D=D0=B5 =D0=B8=D0=BD=D0=B8=D1=86=D0=B8=D0=B0=D0=BB=D0=B8=D0=
=B7=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B0 =D0=B2=D0=B5=D1=82=D0=B2=D1=
=8C 'master'."
=20
-# TOVERIFY
 #: lib/choose_repository.tcl:527
-#, fuzzy
 msgid "Hardlinks are unavailable.  Falling back to copying."
 msgstr "\"=D0=96=D0=B5=D1=81=D1=82=D0=BA=D0=B8=D0=B5 =D1=81=D1=81=D1=8B=
=D0=BB=D0=BA=D0=B8\" =D0=BD=D0=B5 =D0=B4=D0=BE=D1=81=D1=82=D1=83=D0=BF=D0=
=BD=D1=8B. =D0=91=D1=83=D0=B4=D1=83 =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=
=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=
=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5."
=20
 #: lib/choose_repository.tcl:539
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Cloning from %s"
-msgstr "=D0=9F=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B8=D0=
=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=B8=D0=B7 %s "
+msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=
=B8=D0=B5 %s"
=20
 #: lib/choose_repository.tcl:570
-#, fuzzy
 msgid "Copying objects"
-msgstr "=D0=A1=D0=B6=D0=B0=D1=82=D0=B8=D0=B5 =D0=B1=D0=B0=D0=B7=D1=8B =
=D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=D0=BE=D0=B2"
+msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=
=B5 objects"
=20
 #: lib/choose_repository.tcl:571
 msgid "KiB"
@@ -1096,42 +1031,33 @@ msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D1=
=81=D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D0=BE=D0=
=B1=D1=8A=D0=B5=D0=BA=D1=82: %s"
=20
 #: lib/choose_repository.tcl:605
 msgid "Linking objects"
-msgstr "=D0=A1=D0=B2=D1=8F=D0=B7=D1=8B=D0=B2=D0=B0=D1=8E =D0=BE=D0=B1=D1=
=8A=D0=B5=D0=BA=D1=82=D1=8B"
+msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=B8=D0=B5 =D1=81=D1=81=D1=
=8B=D0=BB=D0=BE=D0=BA =D0=BD=D0=B0 objects"
=20
-# TOVERIFY
 #: lib/choose_repository.tcl:606
-#, fuzzy
 msgid "objects"
-msgstr "=D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=D0=BE=D0=B2"
+msgstr "=D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=D1=8B"
=20
-# TOVERIFY
 #: lib/choose_repository.tcl:614
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Unable to hardlink object: %s"
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 \"=D0=B6=D0=B5=D1=81=D1=82=
=D0=BA=D0=BE =D1=81=D0=B2=D1=8F=D0=B7=D0=B0=D1=82=D1=8C\" =D0=BE=D0=B1=D1=
=8A=D0=B5=D0=BA=D1=82: %s"
=20
-# TOVERIFY
 #: lib/choose_repository.tcl:669
-#, fuzzy
 msgid "Cannot fetch branches and objects.  See console output for deta=
ils."
-msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BF=D0=BE=D0=BB=D1=83=
=D1=87=D0=B8=D1=82=D1=8C =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 =D0=B8 =D0=BE=D0=
=B1=D1=8A=D0=B5=D0=BA=D1=82=D1=8B. =D0=94=D0=B5=D1=82=D0=B0=D0=BB=D0=B8=
 - =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BD=D1=81=D0=BE=D0=BB=D0=B5."
+msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BF=D0=BE=D0=BB=D1=83=
=D1=87=D0=B8=D1=82=D1=8C =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 =D0=B8 =D0=BE=D0=
=B1=D1=8A=D0=B5=D0=BA=D1=82=D1=8B. =D0=94=D0=BE=D0=BF=D0=BE=D0=BB=D0=BD=
=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=B8=D0=BD=D1=84=D0=BE=
=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BD=D1=
=81=D0=BE=D0=BB=D0=B8."
=20
-# TOVERIFY
 #: lib/choose_repository.tcl:680
-#, fuzzy
 msgid "Cannot fetch tags.  See console output for details."
-msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BF=D0=BE=D0=BB=D1=83=
=D1=87=D0=B8=D1=82=D1=8C =D1=82=D0=B0=D0=B3=D0=B8. =D0=94=D0=B5=D1=82=D0=
=B0=D0=BB=D0=B8 - =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BD=D1=81=D0=BE=D0=BB=D0=B5=
=2E"
+msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BF=D0=BE=D0=BB=D1=83=
=D1=87=D0=B8=D1=82=D1=8C =D0=BC=D0=B5=D1=82=D0=BA=D0=B8. =D0=94=D0=BE=D0=
=BF=D0=BE=D0=BB=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=
=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=BD=D0=B0 =
=D0=BA=D0=BE=D0=BD=D1=81=D0=BE=D0=BB=D0=B8."
=20
-# TOVERIFY
 #: lib/choose_repository.tcl:704
-#, fuzzy
 msgid "Cannot determine HEAD.  See console output for details."
-msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BE=D0=BF=D1=80=D0=B5=
=D0=B4=D0=B5=D0=BB=D0=B8=D1=82=D1=8C =D0=B3=D0=BB=D0=B0=D0=B2=D0=BD=D1=83=
=D1=8E =D0=B2=D0=B5=D1=82=D0=B2=D1=8C. =D0=94=D0=B5=D1=82=D0=B0=D0=BB=D0=
=B8 - =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BD=D1=81=D0=BE=D0=BB=D0=B5."
+msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BE=D0=BF=D1=80=D0=B5=
=D0=B4=D0=B5=D0=BB=D0=B8=D1=82=D1=8C HEAD. =D0=94=D0=BE=D0=BF=D0=BE=D0=BB=
=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=B8=D0=BD=D1=84=
=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=BD=D0=B0 =D0=BA=D0=BE=D0=
=BD=D1=81=D0=BE=D0=BB=D0=B8."
=20
 #: lib/choose_repository.tcl:713
 #, tcl-format
 msgid "Unable to cleanup %s"
-msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BF=D0=BE=D1=87=D0=B8=
=D1=81=D1=82=D0=B8=D1=82=D1=8C %s"
+msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BE=D1=87=D0=B8=D1=81=
=D1=82=D0=B8=D1=82=D1=8C %s"
=20
 #: lib/choose_repository.tcl:719
 msgid "Clone failed."
@@ -1139,7 +1065,7 @@ msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=BE=
=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=
=BE=D1=81=D1=8C."
=20
 #: lib/choose_repository.tcl:726
 msgid "No default branch obtained."
-msgstr "=D0=9D=D0=B5 =D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =
=D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D1=82=D1=8C =D0=B2=D0=B5=D1=82=D0=B2=
=D1=8C =D0=BF=D0=BE =D1=83=D0=BC=D0=BE=D0=BB=D1=87=D0=B0=D0=BD=D0=B8=D1=
=8E."
+msgstr "=D0=9D=D0=B5 =D0=B1=D1=8B=D0=BB=D0=BE =D0=BF=D0=BE=D0=BB=D1=83=
=D1=87=D0=B5=D0=BD=D0=BE =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 =D0=BF=D0=BE =D1=
=83=D0=BC=D0=BE=D0=BB=D1=87=D0=B0=D0=BD=D0=B8=D1=8E."
=20
 #: lib/choose_repository.tcl:737
 #, tcl-format
@@ -1147,9 +1073,8 @@ msgid "Cannot resolve %s as a commit."
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D1=80=D0=B0=D1=81=D0=BF=
=D0=BE=D0=B7=D0=BD=D0=B0=D1=82=D1=8C %s =D0=BA=D0=B0=D0=BA =D1=81=D0=BE=
=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5."
=20
 #: lib/choose_repository.tcl:749
-#, fuzzy
 msgid "Creating working directory"
-msgstr "=D0=9E=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=
=82 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =D0=BA=D0=B0=D1=82=D0=B0=
=D0=BB=D0=BE=D0=B3"
+msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=8E =D1=80=D0=B0=D0=B1=D0=BE=D1=
=87=D0=B8=D0=B9 =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3"
=20
 #: lib/choose_repository.tcl:750 lib/index.tcl:15 lib/index.tcl:80
 #: lib/index.tcl:149
@@ -1158,21 +1083,20 @@ msgstr "=D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2"
=20
 #: lib/choose_repository.tcl:779
 msgid "Initial file checkout failed."
-msgstr "=D0=9F=D0=B5=D1=80=D0=B2=D0=BE=D0=B5 =D0=BF=D0=BE=D0=BB=D1=83=D1=
=87=D0=B5=D0=BD=D0=B8=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=BD=D0=B5=
 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C."
+msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=
=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D1=82=D1=8C =D0=BD=D0=B0=D1=87=D0=B0=D0=BB=
=D1=8C=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=
=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2 =D1=80=D0=B5=D0=BF=D0=BE=D0=
=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F."
=20
 #: lib/choose_repository.tcl:795
 msgid "Open"
 msgstr "=D0=9E=D1=82=D0=BA=D1=80=D1=8B=D1=82=D1=8C"
=20
 #: lib/choose_repository.tcl:805
-#, fuzzy
 msgid "Repository:"
-msgstr "=D0=A0=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9"
+msgstr "=D0=A0=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9:"
=20
 #: lib/choose_repository.tcl:854
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Failed to open repository %s:"
-msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=
=D0=BE=D0=BB=D0=BD=D0=BE=D1=81=D1=82=D1=8C=D1=8E =D1=81=D0=BE=D1=85=D1=80=
=D0=B0=D0=BD=D0=B8=D1=82=D1=8C =D0=BD=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=
=D0=BA=D0=B8:"
+msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BE=
=D1=82=D0=BA=D1=80=D1=8B=D1=82=D1=8C =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=
=D1=82=D0=BE=D1=80=D0=B8=D0=B9 %s:"
=20
 #: lib/choose_rev.tcl:53
 msgid "This Detached Checkout"
@@ -1205,7 +1129,7 @@ msgstr "=D0=92=D0=B5=D1=80=D1=81=D0=B8=D1=8F =D0=BD=
=D0=B5 =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=B0."
=20
 #: lib/choose_rev.tcl:346
 msgid "Revision expression is empty."
-msgstr "=D0=9F=D1=83=D1=81=D1=82=D0=BE=D0=B5 =D0=B2=D1=8B=D1=80=D0=B0=D0=
=B6=D0=B5=D0=BD=D0=B8=D1=8F =D0=B4=D0=BB=D1=8F =D0=BE=D0=BF=D1=80=D0=B5=
=D0=B4=D0=B5=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2=D0=B5=D1=80=D1=81=D0=B8=
=D0=B8."
+msgstr "=D0=9F=D1=83=D1=81=D1=82=D0=BE=D0=B5 =D0=B2=D1=8B=D1=80=D0=B0=D0=
=B6=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B4=D0=BB=D1=8F =D0=BE=D0=BF=D1=80=D0=B5=
=D0=B4=D0=B5=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2=D0=B5=D1=80=D1=81=D0=B8=
=D0=B8."
=20
 #: lib/choose_rev.tcl:530
 msgid "Updated"
@@ -1223,7 +1147,7 @@ msgid ""
 msgstr ""
 "=D0=9E=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82 =D1=
=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D0=B4=D0=BB=D1=8F =
=D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F.\n"
 "\n"
-"=D0=92=D1=8B =D0=BC=D0=BE=D0=B6=D0=B5=D1=82=D0=B5 =D1=81=D0=BE=D0=B7=D0=
=B4=D0=B0=D1=82=D1=8C =D0=BD=D0=B0=D1=87=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=
=B5 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D0=BE=D0=B5 =
=D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5. =D0=94=D1=80=D1=
=83=D0=B3=D0=B8=D1=85 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=
=B9 =D0=B4=D0=BB=D1=8F =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=
=D0=BD=D0=B8=D1=8F =D0=BD=D0=B5=D1=82.\n"
+"=D0=92=D1=8B =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D0=B5=D1=82=D0=B5 =D0=BF=D0=
=B5=D1=80=D0=B2=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=
=B8=D0=B5 =D0=B2 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=
=D0=B8=D0=B8, =D0=B7=D0=B4=D0=B5=D1=81=D1=8C =D0=B5=D1=89=D0=B5 =D0=BD=D0=
=B5=D1=87=D0=B5=D0=B3=D0=BE =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D1=
=8F=D1=82=D1=8C.\n"
=20
 #: lib/commit.tcl:18
 msgid ""
@@ -1257,12 +1181,12 @@ msgid ""
 msgstr ""
 "=D0=9F=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B5 =D0=BF=D1=80=D0=
=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=
=82=D0=BE=D1=80=D0=B8=D1=8F =D0=BD=D0=B5 =D1=81=D0=BE=D0=BE=D1=82=D0=B2=
=D0=B5=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82 =D1=82=D0=B5=D0=BA=D1=83=
=D1=89=D0=B5=D0=BC=D1=83.\n"
 "\n"
-"=D0=A1 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D0=BF=D0=BE=D1=81=D0=
=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B9 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=
=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9 =D0=B1=D1=8B=D0=BB =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD =D0=B4=
=D1=80=D1=83=D0=B3=D0=BE=D0=B9 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=
=D0=BC=D0=BE=D0=B9 Git.=D0=9D=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=
=D0=BC=D0=BE =D0=BF=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C=
 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9, =D0=
=BF=D1=80=D0=B5=D0=B6=D0=B4=D0=B5 =D1=87=D0=B5=D0=BC =D0=B8=D0=B7=D0=BC=
=D0=B5=D0=BD=D1=8F=D1=82=D1=8C =D1=82=D0=B5=D0=BA=D1=83=D1=89=D1=83=D1=8E=
 =D0=B2=D0=B5=D1=82=D0=B2=D1=8C. \n"
+"=D0=A1 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D0=BF=D0=BE=D1=81=D0=
=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B9 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=
=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9 =D0=B1=D1=8B=D0=BB =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD =D0=B4=
=D1=80=D1=83=D0=B3=D0=BE=D0=B9 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=
=D0=BC=D0=BE=D0=B9 Git. =D0=9D=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=
=D0=BC=D0=BE =D0=BF=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C=
 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9, =D0=
=BF=D1=80=D0=B5=D0=B6=D0=B4=D0=B5 =D1=87=D0=B5=D0=BC =D0=B8=D0=B7=D0=BC=
=D0=B5=D0=BD=D1=8F=D1=82=D1=8C =D1=82=D0=B5=D0=BA=D1=83=D1=89=D1=83=D1=8E=
 =D0=B2=D0=B5=D1=82=D0=B2=D1=8C. \n"
 "\n"
 "=D0=AD=D1=82=D0=BE =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=B4=D0=B5=D0=
=BB=D0=B0=D0=BD=D0=BE =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B0=D0=B2=
=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8.\n"
=20
 #: lib/commit.tcl:154
-#, fuzzy, tcl-format
+#, tcl-format
 msgid ""
 "Unmerged files cannot be committed.\n"
 "\n"
@@ -1284,7 +1208,6 @@ msgstr ""
 "=D0=A4=D0=B0=D0=B9=D0=BB %s =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5=D1=82=
 =D0=B1=D1=8B=D1=82=D1=8C =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=
=BD =D0=B4=D0=B0=D0=BD=D0=BD=D0=BE=D0=B9 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=
=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9.\n"
=20
 #: lib/commit.tcl:170
-#, fuzzy
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1416,14 +1339,14 @@ msgid ""
 msgstr ""
 "=D0=AD=D1=82=D0=BE=D1=82 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=
=BE=D1=80=D0=B8=D0=B9 =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D1=81=D0=BE=
=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =D0=BF=D1=80=D0=B8=D0=BC=D0=B5=D1=80=
=D0=BD=D0=BE %i =D1=81=D0=B2=D0=BE=D0=B1=D0=BE=D0=B4=D0=BD=D1=8B=D1=85 =
=D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=D0=BE=D0=B2\n"
 "\n"
-"=D0=94=D0=BB=D1=8F =D0=BB=D1=83=D1=87=D1=88=D0=B5=D0=B9 =D0=BF=D1=80=D0=
=BE=D0=B8=D0=B7=D0=B2=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=
=BE=D1=81=D1=82=D0=B8 =D1=80=D0=B5=D0=BA=D0=BE=D0=BC=D0=B5=D0=BD=D0=B4=D1=
=83=D0=B5=D1=82=D1=81=D1=8F =D1=81=D0=B6=D0=B0=D1=82=D1=8C =D0=B1=D0=B0=
=D0=B7=D1=83 =D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D1=85, =D0=BA=D0=BE=D0=B3=D0=
=B4=D0=B0 =D0=B5=D1=81=D1=82=D1=8C =D0=B1=D0=BE=D0=BB=D0=B5=D0=B5 %i =D1=
=81=D0=B2=D0=BE=D0=B1=D0=BE=D0=B4=D0=BD=D1=8B=D1=85 =D0=BE=D0=B1=D1=8A=D0=
=B5=D0=BA=D1=82=D0=BE=D0=B2.\n"
+"=D0=94=D0=BB=D1=8F =D0=BB=D1=83=D1=87=D1=88=D0=B5=D0=B9 =D0=BF=D1=80=D0=
=BE=D0=B8=D0=B7=D0=B2=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=
=BE=D1=81=D1=82=D0=B8 =D1=80=D0=B5=D0=BA=D0=BE=D0=BC=D0=B5=D0=BD=D0=B4=D1=
=83=D0=B5=D1=82=D1=81=D1=8F =D1=81=D0=B6=D0=B0=D1=82=D1=8C =D0=B1=D0=B0=
=D0=B7=D1=83 =D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D1=85, =D0=BA=D0=BE=D0=B3=D0=
=B4=D0=B0 =D0=B5=D1=81=D1=82=D1=8C =D0=B1=D0=BE=D0=BB=D0=B5=D0=B5 %i =D0=
=BD=D0=B5=D1=81=D0=B2=D1=8F=D0=B7=D0=B0=D0=BD=D0=BD=D1=8B=D1=85 =D0=BE=D0=
=B1=D1=8A=D0=B5=D0=BA=D1=82=D0=BE=D0=B2.\n"
 "\n"
 "=D0=A1=D0=B6=D0=B0=D1=82=D1=8C =D0=B1=D0=B0=D0=B7=D1=83 =D0=B4=D0=B0=D0=
=BD=D0=BD=D1=8B=D1=85 =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81?"
=20
 #: lib/date.tcl:25
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Invalid date from Git: %s"
-msgstr "=D0=9D=D0=B5=D0=B2=D0=B5=D1=80=D0=BD=D0=B0=D1=8F =D0=B2=D0=B5=D1=
=80=D1=81=D0=B8=D1=8F: %s"
+msgstr "=D0=9D=D0=B5=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D0=BB=D1=8C=D0=BD=D0=
=B0=D1=8F =D0=B4=D0=B0=D1=82=D0=B0 =D0=B2 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=
=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B8: %s"
=20
 #: lib/diff.tcl:42
 #, tcl-format
@@ -1445,9 +1368,9 @@ msgstr ""
 "=D0=A1=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D0=
=B7=D0=B0=D0=BF=D1=83=D1=89=D0=B5=D0=BD=D0=BE =D0=BF=D0=B5=D1=80=D0=B5=D1=
=87=D0=B8=D1=82=D1=8B=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F, =D1=87=D1=82=D0=BE=D0=B1=
=D1=8B =D0=BD=D0=B0=D0=B9=D1=82=D0=B8 =D0=BF=D0=BE=D0=B4=D0=BE=D0=B1=D0=
=BD=D1=8B=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB=D1=8B."
=20
 #: lib/diff.tcl:81
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Loading diff of %s..."
-msgstr "=D0=97=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B0 %s..."
+msgstr "=D0=97=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B0 =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=B2 %s..."
=20
 #: lib/diff.tcl:114 lib/diff.tcl:184
 #, tcl-format
@@ -1460,7 +1383,7 @@ msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B7=
=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0=
:"
=20
 #: lib/diff.tcl:122
 msgid "Git Repository (subproject)"
-msgstr "=D0=A0=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9 Git (=D0=BF=D0=BE=D0=B4-=D0=BF=D1=80=D0=BE=D0=B5=D0=BA=D1=82)"
+msgstr "=D0=A0=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9 Git (=D0=BF=D0=BE=D0=B4=D0=BF=D1=80=D0=BE=D0=B5=D0=BA=D1=82)"
=20
 #: lib/diff.tcl:134
 msgid "* Binary file (not showing content)."
@@ -1472,11 +1395,11 @@ msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=
=B7=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B8 diff:"
=20
 #: lib/diff.tcl:302
 msgid "Failed to unstage selected hunk."
-msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=B8=
=D1=81=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=82=D1=8C =D0=B2=D1=8B=D0=B1=D1=80=
=D0=B0=D0=BD=D0=BD=D1=83=D1=8E =D1=87=D0=B0=D1=81=D1=82=D1=8C"
+msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=B8=
=D1=81=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=82=D1=8C =D0=B2=D1=8B=D0=B1=D1=80=
=D0=B0=D0=BD=D0=BD=D1=83=D1=8E =D1=87=D0=B0=D1=81=D1=82=D1=8C."
=20
 #: lib/diff.tcl:309
 msgid "Failed to stage selected hunk."
-msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=
=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D0=BA =D1=
=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8E =D0=B2=D1=8B=D0=
=B1=D1=80=D0=B0=D0=BD=D0=BD=D1=83=D1=8E =D1=87=D0=B0=D1=81=D1=82=D1=8C"
+msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=
=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D0=BA =D1=
=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8E =D0=B2=D1=8B=D0=
=B1=D1=80=D0=B0=D0=BD=D0=BD=D1=83=D1=8E =D1=87=D0=B0=D1=81=D1=82=D1=8C.=
"
=20
 #: lib/error.tcl:12 lib/error.tcl:102
 msgid "error"
@@ -1491,19 +1414,19 @@ msgid "You must correct the above errors before=
 committing."
 msgstr "=D0=9F=D1=80=D0=B5=D0=B6=D0=B4=D0=B5 =D1=87=D0=B5=D0=BC =D1=81=
=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D1=8C, =D0=B8=D1=81=D0=BF=D1=
=80=D0=B0=D0=B2=D1=8C=D1=82=D0=B5 =D0=B2=D1=8B=D1=88=D0=B5=D1=83=D0=BA=D0=
=B0=D0=B7=D0=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=
=B8."
=20
 #: lib/index.tcl:241
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Unstaging %s from commit"
-msgstr "=D0=A3=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D0=B8=D0=B7 =D0=BF=D0=BE=
=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=
=D0=BE"
+msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 %s =D0=B8=D0=B7=
 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=B3=D0=BE"
=20
 #: lib/index.tcl:285
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Adding %s"
-msgstr "=D0=A7=D1=82=D0=B5=D0=BD=D0=B8=D0=B5 %s..."
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 %=
s..."
=20
 #: lib/index.tcl:340
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "Revert changes in file %s?"
-msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
+msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2 =D1=84=D0=B0=D0=B9=D0=BB=
=D0=B5 %s?"
=20
 #: lib/index.tcl:342
 #, tcl-format
@@ -1511,11 +1434,8 @@ msgid "Revert changes in these %i files?"
 msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2 %i =D1=84=D0=B0=D0=B9=D0=
=BB=D0=B5(-=D0=B0=D1=85)?"
=20
 #: lib/index.tcl:348
-#, fuzzy
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
-"=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C =D0=B8=D0=B7=D0=BC=D0=
=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2 %s?\n"
-"\n"
 "=D0=9B=D1=8E=D0=B1=D1=8B=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=
=BD=D0=B8=D1=8F, =D0=BD=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=
=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BA =D1=81=D0=BE=D1=85=D1=
=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8E, =D0=B1=D1=83=D0=B4=D1=83=D1=82=
 =D0=BF=D0=BE=D1=82=D0=B5=D1=80=D1=8F=D0=BD=D1=8B =D0=BF=D1=80=D0=B8 =D0=
=B4=D0=B0=D0=BD=D0=BD=D0=BE=D0=B9 =D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=
=B8=D0=B8."
=20
 #: lib/index.tcl:351
@@ -1542,12 +1462,12 @@ msgid ""
 msgstr ""
 "=D0=9F=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B5 =D0=BF=D1=80=D0=
=BE=D1=87=D0=B8=D1=82=D0=B0=D0=BD=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=
=82=D0=BE=D1=80=D0=B8=D1=8F =D0=BD=D0=B5 =D1=81=D0=BE=D0=BE=D1=82=D0=B2=
=D0=B5=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82 =D1=82=D0=B5=D0=BA=D1=83=
=D1=89=D0=B5=D0=BC=D1=83.\n"
 "\n"
-"=D0=A1 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D0=BF=D0=BE=D1=81=D0=
=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B9 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=
=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9 =D0=B1=D1=8B=D0=BB =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD =D0=B4=
=D1=80=D1=83=D0=B3=D0=BE=D0=B9 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=
=D0=BC=D0=BE=D0=B9 Git.=D0=9D=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=
=D0=BC=D0=BE =D0=BF=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C=
 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9, =D0=
=BF=D1=80=D0=B5=D0=B6=D0=B4=D0=B5 =D1=87=D0=B5=D0=BC =D0=B8=D0=B7=D0=BC=
=D0=B5=D0=BD=D1=8F=D1=82=D1=8C =D1=82=D0=B5=D0=BA=D1=83=D1=89=D1=83=D1=8E=
 =D0=B2=D0=B5=D1=82=D0=B2=D1=8C. \n"
+"=D0=A1 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D0=BF=D0=BE=D1=81=D0=
=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B9 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=
=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9 =D0=B1=D1=8B=D0=BB =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD =D0=B4=
=D1=80=D1=83=D0=B3=D0=BE=D0=B9 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=
=D0=BC=D0=BE=D0=B9 Git. =D0=9D=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=
=D0=BC=D0=BE =D0=BF=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C=
 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9, =D0=
=BF=D1=80=D0=B5=D0=B6=D0=B4=D0=B5 =D1=87=D0=B5=D0=BC =D0=B8=D0=B7=D0=BC=
=D0=B5=D0=BD=D1=8F=D1=82=D1=8C =D1=82=D0=B5=D0=BA=D1=83=D1=89=D1=83=D1=8E=
 =D0=B2=D0=B5=D1=82=D0=B2=D1=8C.\n"
 "\n"
 "=D0=AD=D1=82=D0=BE =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=B4=D0=B5=D0=
=BB=D0=B0=D0=BD=D0=BE =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B0=D0=B2=
=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8.\n"
=20
 #: lib/merge.tcl:44
-#, fuzzy, tcl-format
+#, tcl-format
 msgid ""
 "You are in the middle of a conflicted merge.\n"
 "\n"
@@ -1599,9 +1519,8 @@ msgid "Merge Into %s"
 msgstr "=D0=9E=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B8=D1=82=D1=8C =D1=
=81 %s"
=20
 #: lib/merge.tcl:177
-#, fuzzy
 msgid "Revision To Merge"
-msgstr "=D0=92=D0=B5=D1=80=D1=81=D0=B8=D1=8F"
+msgstr "=D0=92=D0=B5=D1=80=D1=81=D0=B8=D1=8F =D0=B4=D0=BB=D1=8F =D0=BE=
=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
 #: lib/merge.tcl:212
 msgid ""
@@ -1622,12 +1541,12 @@ msgid ""
 "Continue with aborting the current merge?"
 msgstr ""
 "=D0=9F=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D1=82=D1=8C =D0=BE=D0=B1=D1=8A=D0=
=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5?\n"
+"\n"
 "=D0=9F=D1=80=D0=B5=D1=80=D1=8B=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D0=BE=D0=
=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=BF=D1=80=D0=
=B8=D0=B2=D0=B5=D0=B4=D0=B5=D1=82 =D0=BA =D0=BF=D0=BE=D1=82=D0=B5=D1=80=
=D0=B5 *=D0=92=D0=A1=D0=95=D0=A5* =D0=BD=D0=B5=D1=81=D0=BE=D1=85=D1=80=D0=
=B0=D0=BD=D0=B5=D0=BD=D0=BD=D1=8B=D1=85 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=
=B5=D0=BD=D0=B8=D0=B9.\n"
 "\n"
 "=D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C?"
=20
 #: lib/merge.tcl:228
-#, fuzzy
 msgid ""
 "Reset changes?\n"
 "\n"
@@ -1636,6 +1555,7 @@ msgid ""
 "Continue with resetting the current changes?"
 msgstr ""
 "=D0=9F=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D1=82=D1=8C =D0=BE=D0=B1=D1=8A=D0=
=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5?\n"
+"\n"
 "=D0=9F=D1=80=D0=B5=D1=80=D1=8B=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D0=BE=D0=
=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=BF=D1=80=D0=
=B8=D0=B2=D0=B5=D0=B4=D0=B5=D1=82 =D0=BA =D0=BF=D0=BE=D1=82=D0=B5=D1=80=
=D0=B5 *=D0=92=D0=A1=D0=95=D0=A5* =D0=BD=D0=B5=D1=81=D0=BE=D1=85=D1=80=D0=
=B0=D0=BD=D0=B5=D0=BD=D0=BD=D1=8B=D1=85 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=
=B5=D0=BD=D0=B8=D0=B9.\n"
 "\n"
 "=D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C?"
@@ -1663,7 +1583,7 @@ msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=
=D1=82=D1=8C"
 #: lib/option.tcl:96
 #, tcl-format
 msgid "%s Repository"
-msgstr "=D0=B4=D0=BB=D1=8F =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=
=BE=D1=80=D0=B8=D1=8F %s "
+msgstr "=D0=B4=D0=BB=D1=8F =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=
=BE=D1=80=D0=B8=D1=8F %s"
=20
 #: lib/option.tcl:97
 msgid "Global (All Repositories)"
@@ -1710,7 +1630,6 @@ msgid "New Branch Name Template"
 msgstr "=D0=A8=D0=B0=D0=B1=D0=BB=D0=BE=D0=BD =D0=B4=D0=BB=D1=8F =D0=B8=
=D0=BC=D0=B5=D0=BD=D0=B8 =D0=BD=D0=BE=D0=B2=D0=BE=D0=B9 =D0=B2=D0=B5=D1=
=82=D0=B2=D0=B8"
=20
 #: lib/option.tcl:176
-#, fuzzy
 msgid "Change Font"
 msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82 =D0=B8=D0=BD=D1=82=D0=B5=D1=80=D1=
=84=D0=B5=D0=B9=D1=81=D0=B0"
=20
@@ -1723,7 +1642,7 @@ msgstr "=D0=92=D1=8B=D0=B1=D0=B5=D1=80=D0=B8=D1=82=
=D0=B5 %s"
 #: lib/option.tcl:186
 #, fuzzy
 msgid "pt."
-msgstr "pt."
+msgstr ""
=20
 #: lib/option.tcl:200
 msgid "Preferences"
@@ -1734,17 +1653,14 @@ msgid "Failed to completely save options:"
 msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=
=D0=BE=D0=BB=D0=BD=D0=BE=D1=81=D1=82=D1=8C=D1=8E =D1=81=D0=BE=D1=85=D1=80=
=D0=B0=D0=BD=D0=B8=D1=82=D1=8C =D0=BD=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=
=D0=BA=D0=B8:"
=20
 #: lib/remote.tcl:165
-#, fuzzy
 msgid "Prune from"
-msgstr "=D0=A7=D0=B8=D1=81=D1=82=D0=BA=D0=B0 %s... "
+msgstr "=D0=A7=D0=B8=D1=81=D1=82=D0=BA=D0=B0"
=20
 #: lib/remote.tcl:170
-#, fuzzy
 msgid "Fetch from"
-msgstr "=D0=A7=D0=B8=D1=81=D1=82=D0=BA=D0=B0 %s... "
+msgstr "=D0=9F=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B8=D0=
=B7"
=20
 #: lib/remote.tcl:213
-#, fuzzy
 msgid "Push to"
 msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C"
=20
@@ -1785,18 +1701,22 @@ msgid "A branch is required for 'Merged Into'."
 msgstr "=D0=94=D0=BB=D1=8F =D0=BE=D0=BF=D1=86=D0=B8=D0=B8 '=D0=9E=D0=B1=
=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=BE =D1=81' =D1=82=D1=80=D0=
=B5=D0=B1=D1=83=D0=B5=D1=82=D1=81=D1=8F =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D1=
=82=D1=8C =D0=B2=D0=B5=D1=82=D0=B2=D1=8C."
=20
 #: lib/remote_branch_delete.tcl:184
-#, fuzzy, tcl-format
+#, tcl-format
 msgid ""
 "The following branches are not completely merged into %s:\n"
 "\n"
 " - %s"
-msgstr "=D0=A1=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B8=D0=B5 =D0=B2=D0=
=B5=D1=82=D0=B2=D0=B8 =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=
=BD=D1=8B =D1=81 %s =D0=BD=D0=B5 =D0=BF=D0=BE=D0=BB=D0=BD=D0=BE=D1=81=D1=
=82=D1=8C=D1=8E:"
+msgstr ""
+"=D0=A1=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B8=D0=B5 =D0=B2=D0=B5=D1=
=82=D0=B2=D0=B8 =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D1=
=8B =D1=81 %s =D0=BD=D0=B5 =D0=BF=D0=BE=D0=BB=D0=BD=D0=BE=D1=81=D1=82=D1=
=8C=D1=8E:"
+"\n"
+" - %s"
=20
-# TOVERIFY
 #: lib/remote_branch_delete.tcl:189
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "One or more of the merge tests failed because you have not fetc=
hed the necessary commits.  Try fetching from %s first."
-msgstr "=D0=9E=D0=B4=D0=B8=D0=BD =D0=B8=D0=BB=D0=B8 =D0=BD=D0=B5=D1=81=
=D0=BA=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE =D1=82=D0=B5=D1=81=D1=82=D0=BE=D0=B2=
 =D0=BD=D0=B0 =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=
=B8=D0=B5 =D0=BD=D0=B5 =D0=BF=D1=80=D0=BE=D1=88=D0=BB=D0=B8, =D0=BF=D0=BE=
=D1=82=D0=BE=D0=BC=D1=83 =D1=87=D1=82=D0=BE =D0=92=D1=8B =D0=BD=D0=B5 =D0=
=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D0=BB=D0=B8 =D0=BD=D0=B5=D0=BE=D0=B1=D1=
=85=D0=BE=D0=B4=D0=B8=D0=BC=D1=8B=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=
=8F=D0=BD=D0=B8=D1=8F. =D0=9F=D0=BE=D0=BF=D1=80=D0=BE=D0=B1=D1=83=D0=B9=
=D1=82=D0=B5 =D1=81=D0=BD=D0=B0=D1=87=D0=B0=D0=BB=D0=B0 =D0=BF=D0=BE=D0=
=BB=D1=83=D1=87=D0=B8=D1=82=D1=8C =D0=B8=D0=B7 %s."
+msgstr ""
+"=D0=9E=D0=B4=D0=B8=D0=BD =D0=B8=D0=BB=D0=B8 =D0=BD=D0=B5=D1=81=D0=BA=D0=
=BE=D0=BB=D1=8C=D0=BA=D0=BE =D1=82=D0=B5=D1=81=D1=82=D0=BE=D0=B2 =D0=BD=
=D0=B0 =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5=
 =D0=BD=D0=B5 =D0=BF=D1=80=D0=BE=D1=88=D0=BB=D0=B8, =D0=BF=D0=BE=D1=82=D0=
=BE=D0=BC=D1=83 =D1=87=D1=82=D0=BE "
+"=D0=92=D1=8B =D0=BD=D0=B5 =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D0=BB=D0=
=B8 =D0=BD=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D1=8B=D0=B5 =
=D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8F. =D0=9F=D0=BE=D0=
=BF=D1=80=D0=BE=D0=B1=D1=83=D0=B9=D1=82=D0=B5 =D1=81=D0=BD=D0=B0=D1=87=D0=
=B0=D0=BB=D0=B0 =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D1=82=D1=8C =D0=B8=
=D1=85 =D0=B8=D0=B7 %s."
=20
 #: lib/remote_branch_delete.tcl:207
 msgid "Please select one or more branches to delete."
@@ -1819,7 +1739,7 @@ msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=
=D0=B5 =D0=B2=D0=B5=D1=82=D0=B2=D0=B5=D0=B9 =D0=B8=D0=B7 %s"
=20
 #: lib/remote_branch_delete.tcl:286
 msgid "No repository selected."
-msgstr "=D0=9D=D0=B5 =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD =D1=80=D0=B5=
=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9"
+msgstr "=D0=9D=D0=B5 =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD =D1=80=D0=B5=
=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9."
=20
 #: lib/remote_branch_delete.tcl:291
 #, tcl-format
@@ -1840,9 +1760,9 @@ msgid "%s ... %*i of %*i %s (%3i%%)"
 msgstr "%s ... %*i =D0=B8=D0=B7 %*i %s (%3i%%)"
=20
 #: lib/transport.tcl:6
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "fetch %s"
-msgstr "=D0=9F=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D1=82=D1=8C"
+msgstr "=D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 %s"
=20
 #: lib/transport.tcl:7
 #, tcl-format
@@ -1851,9 +1771,9 @@ msgstr "=D0=9F=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=
=D0=B8=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=
=B8=D0=B7 %s "
=20
 # carbon copy
 #: lib/transport.tcl:18
-#, fuzzy, tcl-format
+#, tcl-format
 msgid "remote prune %s"
-msgstr "remote prune %s"
+msgstr "=D1=87=D0=B8=D1=81=D1=82=D0=BA=D0=B0 =D0=B2=D0=BD=D0=B5=D1=88=D0=
=BD=D0=B5=D0=B3=D0=BE %s"
=20
 #: lib/transport.tcl:19
 #, tcl-format
@@ -1877,7 +1797,7 @@ msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BA=
=D0=B0 %s %s =D0=B2 %s"
=20
 #: lib/transport.tcl:89
 msgid "Push Branches"
-msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=B8=D0=
=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
+msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=B8=D0=
=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2 =D0=B2=D0=B5=D1=82=
=D0=B2=D1=8F=D1=85"
=20
 #: lib/transport.tcl:103
 msgid "Source Branches"
@@ -1889,7 +1809,7 @@ msgstr "=D0=A0=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=
=D0=BE=D1=80=D0=B8=D0=B9 =D0=BD=D0=B0=D0=B7=D0=BD=D0=B0=D1=87=D0=B5=D0=BD=
=D0=B8=D1=8F"
=20
 #: lib/transport.tcl:158
 msgid "Transfer Options"
-msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8 =D0=BF=D0=
=B5=D1=80=D0=B5=D0=B4=D0=B0=D1=87=D0=B8"
+msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8 =D0=BE=D1=
=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BA=D0=B8"
=20
 #: lib/transport.tcl:160
 msgid "Force overwrite existing branch (may discard changes)"
@@ -1903,31 +1823,3 @@ msgstr "=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=
=D0=BE=D0=B2=D0=B0=D1=82=D1=8C thin pack (=D0=B4=D0=BB=D1=8F =D0=BC=D0=B5=
=D0=B4=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D1=85 =D1=81=D0=B5=D1=82=D0=B5=D0=B2
 msgid "Include tags"
 msgstr "=D0=92=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=82=D1=8C =D0=BC=D0=B5=D1=
=82=D0=BA=D0=B8"
=20
-#~ msgid "Cannot find the git directory:"
-#~ msgstr "=D0=9A=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 Git =D0=BD=D0=B5=
 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD:"
-#~ msgid "Add To Commit"
-#~ msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=
=D1=8C =D0=BA =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=
=8E"
-#~ msgid "Add Existing To Commit"
-#~ msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=
=D1=8C =D0=B8=D0=BC=D0=B5=D1=8E=D1=89=D0=B8=D0=B5=D1=81=D1=8F =D1=84=D0=
=B0=D0=B9=D0=BB=D1=8B =D0=BA =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=
=D0=BD=D0=B8=D1=8E"
-#~ msgid "Unstaged Changes (Will Not Be Committed)"
-#~ msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BE (=D0=BD=D0=
=B5 =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=
=D0=B5=D0=BD=D0=BE)"
-#~ msgid "Add Existing"
-#~ msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=B8=D0=BC=
=D0=B5=D1=8E=D1=89=D0=B8=D0=B5=D1=81=D1=8F =D1=84=D0=B0=D0=B9=D0=BB=D1=8B=
"
-#~ msgid ""
-#~ "Abort commit?\n"
-#~ "\n"
-#~ "Aborting the current commit will cause *ALL* uncommitted changes t=
o be "
-#~ "lost.\n"
-#~ "\n"
-#~ "Continue with aborting the current commit?"
-#~ msgstr ""
-#~ "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C =D0=B8=D0=B7=D0=BC=
=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F?\n"
-#~ "\n"
-#~ "=D0=92=D1=8B=D0=B7=D0=B2=D0=B0=D0=BD=D0=BD=D0=B0=D1=8F =D0=BE=D0=BF=
=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=8F =D0=BF=D1=80=D0=B8=D0=B2=D0=B5=D0=B4=
=D0=B5=D1=82 =D0=BA =D0=BF=D0=BE=D1=82=D0=B5=D1=80=D0=B5 *=D0=92=D0=A1=D0=
=95=D0=A5* =D0=BD=D0=B5=D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=
=D0=BD=D1=8B=D1=85 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9=
=2E\n"
-#~ "\n"
-#~ "=D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C?"
-#~ msgid "Aborting... please wait..."
-#~ msgstr "=D0=9F=D1=80=D0=B5=D1=80=D1=8B=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5=
 =D0=B2=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F... =D0=9F=
=D0=BE=D0=B6=D0=B0=D0=BB=D1=83=D0=B9=D1=81=D1=82=D0=B0, =D0=B6=D0=B4=D0=
=B8=D1=82=D0=B5..."
-#~ msgid "Push to %s..."
-#~ msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BA=D0=B0 =D0=B2 %s.=
=2E."
-
--=20
1.5.3.4.245.g150b
