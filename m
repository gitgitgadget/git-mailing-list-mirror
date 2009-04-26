From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Update Russian translation of git gui
Date: Sun, 26 Apr 2009 15:21:40 +0200
Message-ID: <20090426132139.GA30825@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 26 16:29:08 2009
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly4Kb-0000Ni-PH
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 15:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752944AbZDZNVz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2009 09:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191AbZDZNVy
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 09:21:54 -0400
Received: from mout3.freenet.de ([195.4.92.93]:38080 "EHLO mout3.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511AbZDZNVv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Apr 2009 09:21:51 -0400
Received: from [195.4.92.22] (helo=12.mx.freenet.de)
	by mout3.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #88)
	id 1Ly4Il-0007Mh-NW; Sun, 26 Apr 2009 15:21:47 +0200
Received: from x548b.x.pppool.de ([89.59.84.139]:54144 helo=tigra.home)
	by 12.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #79)
	id 1Ly4Ii-0007wj-8Z; Sun, 26 Apr 2009 15:21:47 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id A62D8277D8;
	Sun, 26 Apr 2009 15:21:40 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 2E83F36D28; Sun, 26 Apr 2009 15:21:40 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117591>

I also changed translation of the word 'tag': the old term was just a
transliteration. There is a russian word with a fitting meaning and
it is even used.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

A review of this translation would be nice: my russian is slowly
getting rusty. I was even called "strange" once.

 po/ru.po | 1284 +++++++++++++++++++++++++++++++++++++++++++++---------=
--------
 1 files changed, 931 insertions(+), 353 deletions(-)

diff --git a/po/ru.po b/po/ru.po
index 04df2aa..75dfc81 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -7,7 +7,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-03-14 07:18+0100\n"
+"POT-Creation-Date: 2008-12-08 08:31-0800\n"
 "PO-Revision-Date: 2009-04-26 10:00+0200\n"
 "Last-Translator: Alex Riesen <raa.lkml@gmail.com>\n"
 "Language-Team: Russian Translation <git@vger.kernel.org>\n"
@@ -15,33 +15,33 @@ msgstr ""
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
-#: git-gui.sh:41 git-gui.sh:634 git-gui.sh:648 git-gui.sh:661 git-gui.=
sh:744
-#: git-gui.sh:763
+#: git-gui.sh:41 git-gui.sh:737 git-gui.sh:751 git-gui.sh:764 git-gui.=
sh:847
+#: git-gui.sh:866
 msgid "git-gui: fatal error"
 msgstr "git-gui: =D0=BA=D1=80=D0=B8=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=
=D0=B0=D1=8F =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=B0"
=20
-#: git-gui.sh:593
+#: git-gui.sh:689
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr "=D0=92 %s =D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=
=D0=BD =D0=BD=D0=B5=D0=B2=D0=B5=D1=80=D0=BD=D1=8B=D0=B9 =D1=88=D1=80=D0=
=B8=D1=84=D1=82:"
=20
-#: git-gui.sh:620
+#: git-gui.sh:723
 msgid "Main Font"
 msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82 =D0=B8=D0=BD=D1=82=D0=B5=D1=80=D1=
=84=D0=B5=D0=B9=D1=81=D0=B0"
=20
-#: git-gui.sh:621
+#: git-gui.sh:724
 msgid "Diff/Console Font"
 msgstr "=D0=A8=D1=80=D0=B8=D1=84=D1=82 =D0=BA=D0=BE=D0=BD=D1=81=D0=BE=D0=
=BB=D0=B8 =D0=B8 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9=
 (diff)"
=20
-#: git-gui.sh:635
+#: git-gui.sh:738
 msgid "Cannot find git in PATH."
 msgstr "git =D0=BD=D0=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD =D0=B2 P=
ATH."
=20
-#: git-gui.sh:662
+#: git-gui.sh:765
 msgid "Cannot parse Git version string:"
 msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D1=
=80=D0=B0=D1=81=D0=BF=D0=BE=D0=B7=D0=BD=D0=B0=D1=82=D1=8C =D1=81=D1=82=D1=
=80=D0=BE=D0=BA=D1=83 =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D0=B8 Git: "
=20
-#: git-gui.sh:680
+#: git-gui.sh:783
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -53,384 +53,451 @@ msgid ""
 "Assume '%s' is version 1.5.0?\n"
 msgstr ""
 "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=BE=D0=
=BF=D1=80=D0=B5=D0=B4=D0=B5=D0=BB=D0=B8=D1=82=D1=8C =D0=B2=D0=B5=D1=80=D1=
=81=D0=B8=D1=8E Git\n"
+"\n"
 "%s =D1=83=D0=BA=D0=B0=D0=B7=D1=8B=D0=B2=D0=B0=D0=B5=D1=82 =D0=BD=D0=B0=
 =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8E '%s'.\n"
 "\n"
 "=D0=B4=D0=BB=D1=8F %s =D1=82=D1=80=D0=B5=D0=B1=D1=83=D0=B5=D1=82=D1=81=
=D1=8F =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8F Git, =D0=BD=D0=B0=D1=87=D0=B8=
=D0=BD=D0=B0=D1=8F =D1=81 1.5.0\n"
 "\n"
 "=D0=9F=D1=80=D0=B8=D0=BD=D1=8F=D1=82=D1=8C '%s' =D0=BA=D0=B0=D0=BA =D0=
=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8E 1.5.0?\n"
=20
-#: git-gui.sh:918
+#: git-gui.sh:1062
 msgid "Git directory not found:"
 msgstr "=D0=9A=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 Git =D0=BD=D0=B5 =D0=
=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD:"
=20
-#: git-gui.sh:925
+#: git-gui.sh:1069
 msgid "Cannot move to top of working directory:"
 msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=
=BF=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=BA=D0=BE=D1=80=D0=BD=
=D1=8E =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=B3=D0=BE =D0=BA=D0=B0=D1=
=82=D0=B0=D0=BB=D0=BE=D0=B3=D0=B0 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=
=82=D0=BE=D1=80=D0=B8=D1=8F: "
=20
-#: git-gui.sh:932
+#: git-gui.sh:1076
 msgid "Cannot use funny .git directory:"
 msgstr "=D0=9A=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3.git =D0=B8=D1=81=D0=
=BF=D0=BE=D1=80=D1=87=D0=B5=D0=BD: "
=20
-#: git-gui.sh:937
+#: git-gui.sh:1081
 msgid "No working directory"
 msgstr "=D0=9E=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=
=82 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B8=D0=B9 =D0=BA=D0=B0=D1=82=D0=B0=
=D0=BB=D0=BE=D0=B3"
=20
-#: git-gui.sh:1084 lib/checkout_op.tcl:283
+#: git-gui.sh:1247 lib/checkout_op.tcl:305
 msgid "Refreshing file status..."
 msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D0=B8 =D0=BE =D1=81=
=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=
=D0=BE=D0=B2..."
=20
-#: git-gui.sh:1149
+#: git-gui.sh:1303
 msgid "Scanning for modified files ..."
 msgstr "=D0=9F=D0=BE=D0=B8=D1=81=D0=BA =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=
=B5=D0=BD=D0=BD=D1=8B=D1=85 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2..."
=20
-#: git-gui.sh:1324 lib/browser.tcl:246
+#: git-gui.sh:1367
+msgid "Calling prepare-commit-msg hook..."
+msgstr "=D0=92=D1=8B=D0=B7=D0=BE=D0=B2 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=
=B0=D0=BC=D0=BC=D1=8B =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=BA=D0=
=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F =
prepare-commit-msg..."
+
+#: git-gui.sh:1384
+msgid "Commit declined by prepare-commit-msg hook."
+msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BF=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D0=BD=D0=BE =D0=BF=D1=80=D0=BE=D0=B3=D1=
=80=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9 =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=
=B6=D0=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=
=B8=D1=8F prepare-commit-msg"
+
+#: git-gui.sh:1542 lib/browser.tcl:246
 msgid "Ready."
 msgstr "=D0=93=D0=BE=D1=82=D0=BE=D0=B2=D0=BE."
=20
-#: git-gui.sh:1590
+#: git-gui.sh:1819
 msgid "Unmodified"
 msgstr "=D0=9D=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BE"
=20
-#: git-gui.sh:1592
+#: git-gui.sh:1821
 msgid "Modified, not staged"
 msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BE, =D0=BD=D0=B5=
 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE=
"
=20
-#: git-gui.sh:1593 git-gui.sh:1598
+#: git-gui.sh:1822 git-gui.sh:1830
 msgid "Staged for commit"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=
=D0=BD=D0=B8=D1=8F"
=20
-#: git-gui.sh:1594 git-gui.sh:1599
+#: git-gui.sh:1823 git-gui.sh:1831
 msgid "Portions staged for commit"
 msgstr "=D0=A7=D0=B0=D1=81=D1=82=D0=B8, =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=
=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=B4=D0=BB=D1=8F=
 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
-#: git-gui.sh:1595 git-gui.sh:1600
+#: git-gui.sh:1824 git-gui.sh:1832
 msgid "Staged for commit, missing"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=
=D0=BD=D0=B8=D1=8F, =D0=BE=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=
=83=D0=B5=D1=82"
=20
-#: git-gui.sh:1597
+#: git-gui.sh:1826
+msgid "File type changed, not staged"
+msgstr "=D0=A2=D0=B8=D0=BF =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=B8=D0=B7=
=D0=BC=D0=B5=D0=BD=D1=91=D0=BD, =D0=BD=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B3=D0=
=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE"
+
+#: git-gui.sh:1827
+msgid "File type changed, staged"
+msgstr "=D0=A2=D0=B8=D0=BF =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=B8=D0=B7=
=D0=BC=D0=B5=D0=BD=D1=91=D0=BD, =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=
=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE"
+
+#: git-gui.sh:1829
 msgid "Untracked, not staged"
 msgstr "=D0=9D=D0=B5 =D0=BE=D1=82=D1=81=D0=BB=D0=B5=D0=B6=D0=B8=D0=B2=D0=
=B0=D0=B5=D1=82=D1=81=D1=8F, =D0=BD=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=
=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE"
=20
-#: git-gui.sh:1602
+#: git-gui.sh:1834
 msgid "Missing"
 msgstr "=D0=9E=D1=82=D1=81=D1=83=D1=82=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=
=82"
=20
-#: git-gui.sh:1603
+#: git-gui.sh:1835
 msgid "Staged for removal"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=
=D1=8F"
=20
-#: git-gui.sh:1604
+#: git-gui.sh:1836
 msgid "Staged for removal, still present"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=
=D1=8F, =D0=B5=D1=89=D0=B5 =D0=BD=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=B5=D0=
=BD=D0=BE"
=20
-#: git-gui.sh:1606 git-gui.sh:1607 git-gui.sh:1608 git-gui.sh:1609
+#: git-gui.sh:1838 git-gui.sh:1839 git-gui.sh:1840 git-gui.sh:1841
+#: git-gui.sh:1842 git-gui.sh:1843
 msgid "Requires merge resolution"
 msgstr "=D0=A2=D1=80=D0=B5=D0=B1=D1=83=D0=B5=D1=82=D1=81=D1=8F =D1=80=D0=
=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BA=D0=BE=D0=BD=D1=
=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B0 =D0=BF=D1=80=D0=B8 =D0=BE=D0=B1=D1=8A=
=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B8"
=20
-#: git-gui.sh:1644
+#: git-gui.sh:1878
 msgid "Starting gitk... please wait..."
 msgstr "=D0=97=D0=B0=D0=BF=D1=83=D1=81=D0=BA=D0=B0=D0=B5=D1=82=D1=81=D1=
=8F gitk... =D0=BF=D0=BE=D0=B6=D0=B0=D0=BB=D1=83=D0=B9=D1=81=D1=82=D0=B0=
, =D0=B6=D0=B4=D0=B8=D1=82=D0=B5..."
=20
-#: git-gui.sh:1653
-#, tcl-format
-msgid ""
-"Unable to start gitk:\n"
-"\n"
-"%s does not exist"
-msgstr ""
-"=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=B7=D0=B0=D0=
=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=8C gitk:\n"
-"\n"
-"%s =D0=BD=D0=B5 =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=
=D1=82"
+#: git-gui.sh:1887
+msgid "Couldn't find gitk in PATH"
+msgstr "gitk =D0=BD=D0=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD =D0=B2 =
PATH."
=20
-#: git-gui.sh:1860 lib/choose_repository.tcl:36
+#: git-gui.sh:2280 lib/choose_repository.tcl:36
 msgid "Repository"
 msgstr "=D0=A0=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9"
=20
-#: git-gui.sh:1861
+#: git-gui.sh:2281
 msgid "Edit"
 msgstr "=D0=A0=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=B8=D1=80=D0=BE=D0=B2=D0=
=B0=D1=82=D1=8C"
=20
-#: git-gui.sh:1863 lib/choose_rev.tcl:561
+#: git-gui.sh:2283 lib/choose_rev.tcl:561
 msgid "Branch"
 msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C"
=20
-#: git-gui.sh:1866 lib/choose_rev.tcl:548
+#: git-gui.sh:2286 lib/choose_rev.tcl:548
 msgid "Commit@@noun"
 msgstr "=D0=A1=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5"
=20
-#: git-gui.sh:1869 lib/merge.tcl:120 lib/merge.tcl:149 lib/merge.tcl:1=
67
+#: git-gui.sh:2289 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
 msgid "Merge"
 msgstr "=D0=9E=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B8=D1=82=D1=8C"
=20
-#: git-gui.sh:1870 lib/choose_rev.tcl:557
+#: git-gui.sh:2290 lib/choose_rev.tcl:557
 msgid "Remote"
 msgstr "=D0=92=D0=BD=D0=B5=D1=88=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B8"
=20
-#: git-gui.sh:1879
+#: git-gui.sh:2293
+msgid "Tools"
+msgstr "=D0=92=D1=81=D0=BF=D0=BE=D0=BC=D0=BE=D0=B3=D0=B0=D1=82=D0=B5=D0=
=BB=D1=8C=D0=BD=D1=8B=D0=B5 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=
=BC=D1=8B"
+
+#: git-gui.sh:2302
+msgid "Explore Working Copy"
+msgstr "=D0=9F=D1=80=D0=BE=D1=81=D0=BC=D0=BE=D1=82=D1=80 =D1=80=D0=B0=D0=
=B1=D0=BE=D1=87=D0=B5=D0=B3=D0=BE =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=
=B3=D0=B0"
+
+#: git-gui.sh:2307
 msgid "Browse Current Branch's Files"
 msgstr "=D0=9F=D1=80=D0=BE=D1=81=D0=BC=D0=BE=D1=82=D1=80=D0=B5=D1=82=D1=
=8C =D1=84=D0=B0=D0=B9=D0=BB=D1=8B =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=
=D0=B9 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
=20
-#: git-gui.sh:1883
+#: git-gui.sh:2311
 msgid "Browse Branch Files..."
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D1=84=D0=B0=D0=
=B9=D0=BB=D1=8B =D0=B2=D0=B5=D1=82=D0=B2=D0=B8..."
=20
-#: git-gui.sh:1888
+#: git-gui.sh:2316
 msgid "Visualize Current Branch's History"
 msgstr "=D0=98=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F =D1=82=D0=B5=D0=BA=D1=
=83=D1=89=D0=B5=D0=B9 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 =D0=BD=D0=B0=D0=B3=
=D0=BB=D1=8F=D0=B4=D0=BD=D0=BE"
=20
-#: git-gui.sh:1892
+#: git-gui.sh:2320
 msgid "Visualize All Branch History"
 msgstr "=D0=98=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F =D0=B2=D1=81=D0=B5=D1=
=85 =D0=B2=D0=B5=D1=82=D0=B2=D0=B5=D0=B9 =D0=BD=D0=B0=D0=B3=D0=BB=D1=8F=
=D0=B4=D0=BD=D0=BE"
=20
-#: git-gui.sh:1899
+#: git-gui.sh:2327
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D1=84=D0=B0=D0=
=B9=D0=BB=D1=8B =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 %s"
=20
-#: git-gui.sh:1901
+#: git-gui.sh:2329
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "=D0=98=D1=81=D1=82=D0=BE=D1=80=D0=B8=D1=8F =D0=B2=D0=B5=D1=82=D0=
=B2=D0=B8 %s =D0=BD=D0=B0=D0=B3=D0=BB=D1=8F=D0=B4=D0=BD=D0=BE"
=20
-#: git-gui.sh:1906 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:2334 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "=D0=A1=D1=82=D0=B0=D1=82=D0=B8=D1=81=D1=82=D0=B8=D0=BA=D0=B0 =D0=
=B1=D0=B0=D0=B7=D1=8B =D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D1=85"
=20
-#: git-gui.sh:1909 lib/database.tcl:34
+#: git-gui.sh:2337 lib/database.tcl:34
 msgid "Compress Database"
 msgstr "=D0=A1=D0=B6=D0=B0=D1=82=D1=8C =D0=B1=D0=B0=D0=B7=D1=83 =D0=B4=
=D0=B0=D0=BD=D0=BD=D1=8B=D1=85"
=20
-#: git-gui.sh:1912
+#: git-gui.sh:2340
 msgid "Verify Database"
 msgstr "=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=B8=D1=82=D1=8C =D0=B1=D0=
=B0=D0=B7=D1=83 =D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D1=85"
=20
-#: git-gui.sh:1919 git-gui.sh:1923 git-gui.sh:1927 lib/shortcut.tcl:7
+#: git-gui.sh:2347 git-gui.sh:2351 git-gui.sh:2355 lib/shortcut.tcl:7
 #: lib/shortcut.tcl:39 lib/shortcut.tcl:71
 msgid "Create Desktop Icon"
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D1=8F=D1=80=D0=BB=D1=
=8B=D0=BA =D0=BD=D0=B0 =D1=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=BC =D1=81=
=D1=82=D0=BE=D0=BB=D0=B5"
=20
-#: git-gui.sh:1932 lib/choose_repository.tcl:177 lib/choose_repository=
=2Etcl:185
+#: git-gui.sh:2363 lib/choose_repository.tcl:183 lib/choose_repository=
=2Etcl:191
 msgid "Quit"
 msgstr "=D0=92=D1=8B=D1=85=D0=BE=D0=B4"
=20
-#: git-gui.sh:1939
+#: git-gui.sh:2371
 msgid "Undo"
 msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C"
=20
-#: git-gui.sh:1942
+#: git-gui.sh:2374
 msgid "Redo"
 msgstr "=D0=9F=D0=BE=D0=B2=D1=82=D0=BE=D1=80=D0=B8=D1=82=D1=8C"
=20
-#: git-gui.sh:1946 git-gui.sh:2443
+#: git-gui.sh:2378 git-gui.sh:2937
 msgid "Cut"
 msgstr "=D0=92=D1=8B=D1=80=D0=B5=D0=B7=D0=B0=D1=82=D1=8C"
=20
-#: git-gui.sh:1949 git-gui.sh:2446 git-gui.sh:2520 git-gui.sh:2614
+#: git-gui.sh:2381 git-gui.sh:2940 git-gui.sh:3014 git-gui.sh:3096
 #: lib/console.tcl:69
 msgid "Copy"
 msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C"
=20
-#: git-gui.sh:1952 git-gui.sh:2449
+#: git-gui.sh:2384 git-gui.sh:2943
 msgid "Paste"
 msgstr "=D0=92=D1=81=D1=82=D0=B0=D0=B2=D0=B8=D1=82=D1=8C"
=20
-#: git-gui.sh:1955 git-gui.sh:2452 lib/branch_delete.tcl:26
+#: git-gui.sh:2387 git-gui.sh:2946 lib/branch_delete.tcl:26
 #: lib/remote_branch_delete.tcl:38
 msgid "Delete"
 msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C"
=20
-#: git-gui.sh:1959 git-gui.sh:2456 git-gui.sh:2618 lib/console.tcl:71
+#: git-gui.sh:2391 git-gui.sh:2950 git-gui.sh:3100 lib/console.tcl:71
 msgid "Select All"
 msgstr "=D0=92=D1=8B=D0=B4=D0=B5=D0=BB=D0=B8=D1=82=D1=8C =D0=B2=D1=81=D0=
=B5"
=20
-#: git-gui.sh:1968
+#: git-gui.sh:2400
 msgid "Create..."
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C..."
=20
-#: git-gui.sh:1974
+#: git-gui.sh:2406
 msgid "Checkout..."
 msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8..."
=20
-#: git-gui.sh:1980
+#: git-gui.sh:2412
 msgid "Rename..."
 msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B8=D0=BC=D0=B5=D0=BD=D0=BE=D0=B2=D0=
=B0=D1=82=D1=8C..."
=20
-#: git-gui.sh:1985 git-gui.sh:2085
+#: git-gui.sh:2417
 msgid "Delete..."
 msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C..."
=20
-#: git-gui.sh:1990
+#: git-gui.sh:2422
 msgid "Reset..."
 msgstr "=D0=A1=D0=B1=D1=80=D0=BE=D1=81=D0=B8=D1=82=D1=8C..."
=20
-#: git-gui.sh:2002 git-gui.sh:2389
+#: git-gui.sh:2432
+msgid "Done"
+msgstr "=D0=97=D0=B2=D0=B5=D1=80=D1=88=D0=B5=D0=BD=D0=BE"
+
+#: git-gui.sh:2434
+msgid "Commit@@verb"
+msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D1=8C"
+
+#: git-gui.sh:2443 git-gui.sh:2878
 msgid "New Commit"
 msgstr "=D0=9D=D0=BE=D0=B2=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=
=8F=D0=BD=D0=B8=D0=B5"
=20
-#: git-gui.sh:2010 git-gui.sh:2396
+#: git-gui.sh:2451 git-gui.sh:2885
 msgid "Amend Last Commit"
 msgstr "=D0=98=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=BF=D0=
=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=
=BE=D1=8F=D0=BD=D0=B8=D0=B5"
=20
-#: git-gui.sh:2019 git-gui.sh:2356 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:2461 git-gui.sh:2839 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
 msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D0=B0=D1=82=D1=8C"
=20
-#: git-gui.sh:2025
+#: git-gui.sh:2467
 msgid "Stage To Commit"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=
=D0=B8=D1=8F"
=20
-#: git-gui.sh:2031
+#: git-gui.sh:2473
 msgid "Stage Changed Files To Commit"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D1=84=
=D0=B0=D0=B9=D0=BB=D1=8B =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=
=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
-#: git-gui.sh:2037
+#: git-gui.sh:2479
 msgid "Unstage From Commit"
 msgstr "=D0=A3=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D0=B8=D0=B7 =D0=BF=D0=BE=
=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=
=D0=BE"
=20
-#: git-gui.sh:2042 lib/index.tcl:395
+#: git-gui.sh:2484 lib/index.tcl:410
 msgid "Revert Changes"
 msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
-#: git-gui.sh:2049 git-gui.sh:2368 git-gui.sh:2467
-msgid "Sign Off"
-msgstr "=D0=9F=D0=BE=D0=B4=D0=BF=D0=B8=D1=81=D0=B0=D1=82=D1=8C"
+#: git-gui.sh:2491 git-gui.sh:3083
+msgid "Show Less Context"
+msgstr "=D0=9C=D0=B5=D0=BD=D1=8C=D1=88=D0=B5 =D0=BA=D0=BE=D0=BD=D1=82=D0=
=B5=D0=BA=D1=81=D1=82=D0=B0"
=20
-#: git-gui.sh:2053 git-gui.sh:2372
-msgid "Commit@@verb"
-msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D1=8C"
+#: git-gui.sh:2495 git-gui.sh:3087
+msgid "Show More Context"
+msgstr "=D0=91=D0=BE=D0=BB=D1=8C=D1=88=D0=B5 =D0=BA=D0=BE=D0=BD=D1=82=D0=
=B5=D0=BA=D1=81=D1=82=D0=B0"
+
+#: git-gui.sh:2502 git-gui.sh:2852 git-gui.sh:2961
+msgid "Sign Off"
+msgstr "=D0=92=D1=81=D1=82=D0=B0=D0=B2=D0=B8=D1=82=D1=8C Signed-off-by=
"
=20
-#: git-gui.sh:2064
+#: git-gui.sh:2518
 msgid "Local Merge..."
 msgstr "=D0=9B=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B5 =D0=BE=D0=
=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5..."
=20
-#: git-gui.sh:2069
+#: git-gui.sh:2523
 msgid "Abort Merge..."
 msgstr "=D0=9F=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D1=82=D1=8C =D0=BE=D0=B1=D1=
=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5..."
=20
-#: git-gui.sh:2081
+#: git-gui.sh:2535 git-gui.sh:2575
+msgid "Add..."
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C..."
+
+#: git-gui.sh:2539
 msgid "Push..."
 msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C..."
=20
-#: git-gui.sh:2092 lib/choose_repository.tcl:41
-msgid "Apple"
-msgstr ""
+#: git-gui.sh:2543
+msgid "Delete Branch..."
+msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C =D0=B2=D0=B5=D1=82=D0=
=B2=D1=8C..."
=20
-#: git-gui.sh:2095 git-gui.sh:2117 lib/about.tcl:14
-#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:50
+#: git-gui.sh:2553 git-gui.sh:2589 lib/about.tcl:14
+#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
 #, tcl-format
 msgid "About %s"
 msgstr "=D0=9E %s"
=20
-#: git-gui.sh:2099
+#: git-gui.sh:2557
 msgid "Preferences..."
 msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8..."
=20
-#: git-gui.sh:2107 git-gui.sh:2639
+#: git-gui.sh:2565 git-gui.sh:3129
 msgid "Options..."
 msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8..."
=20
-#: git-gui.sh:2113 lib/choose_repository.tcl:47
+#: git-gui.sh:2576
+msgid "Remove..."
+msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C..."
+
+#: git-gui.sh:2585 lib/choose_repository.tcl:50
 msgid "Help"
 msgstr "=D0=9F=D0=BE=D0=BC=D0=BE=D1=89=D1=8C"
=20
-#: git-gui.sh:2154
+#: git-gui.sh:2611
 msgid "Online Documentation"
 msgstr "=D0=94=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=86=D0=
=B8=D1=8F =D0=B2 =D0=B8=D0=BD=D1=82=D0=B5=D1=80=D0=BD=D0=B5=D1=82=D0=B5=
"
=20
-#: git-gui.sh:2238
+#: git-gui.sh:2614 lib/choose_repository.tcl:47 lib/choose_repository.=
tcl:56
+msgid "Show SSH Key"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=BA=D0=BB=D1=
=8E=D1=87 SSH"
+
+#: git-gui.sh:2721
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr "=D0=BA=D1=80=D0=B8=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B0=D1=
=8F =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=B0: %s: =D0=BD=D0=B5=D1=82 =D1=82=
=D0=B0=D0=BA=D0=BE=D0=B3=D0=BE =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=B8=D0=
=BB=D0=B8 =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3=D0=B0"
=20
-#: git-gui.sh:2271
+#: git-gui.sh:2754
 msgid "Current Branch:"
 msgstr "=D0=A2=D0=B5=D0=BA=D1=83=D1=89=D0=B0=D1=8F =D0=B2=D0=B5=D1=82=D0=
=B2=D1=8C:"
=20
-#: git-gui.sh:2292
+#: git-gui.sh:2775
 msgid "Staged Changes (Will Commit)"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE (=D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=BE=D1=85=D1=80=D0=B0=
=D0=BD=D0=B5=D0=BD=D0=BE)"
=20
-#: git-gui.sh:2312
+#: git-gui.sh:2795
 msgid "Unstaged Changes"
 msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=BE (=D0=BD=D0=B5=
 =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=
=B5=D0=BD=D0=BE)"
=20
-#: git-gui.sh:2362
+#: git-gui.sh:2845
 msgid "Stage Changed"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D0=B2=D1=81=D0=B5"
=20
-#: git-gui.sh:2378 lib/transport.tcl:93 lib/transport.tcl:182
+#: git-gui.sh:2864 lib/transport.tcl:104 lib/transport.tcl:193
 msgid "Push"
 msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C"
=20
-#: git-gui.sh:2408
+#: git-gui.sh:2899
 msgid "Initial Commit Message:"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=BF=D0=B5=D1=80=D0=B2=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=
=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E:"
=20
-#: git-gui.sh:2409
+#: git-gui.sh:2900
 msgid "Amended Commit Message:"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E=
:"
=20
-#: git-gui.sh:2410
+#: git-gui.sh:2901
 msgid "Amended Initial Commit Message:"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=BC=D1=83 =D0=BF=D0=B5=D1=80=D0=B2=D0=BE=D0=BD=D0=B0=D1=87=D0=B0=
=D0=BB=D1=8C=D0=BD=D0=BE=D0=BC=D1=83 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=
=D0=BD=D0=B8=D1=8E:"
=20
-#: git-gui.sh:2411
+#: git-gui.sh:2902
 msgid "Amended Merge Commit Message:"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=BC=D1=83 =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=
=D0=B8=D1=8E:"
=20
-#: git-gui.sh:2412
+#: git-gui.sh:2903
 msgid "Merge Commit Message:"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=
=D1=8E:"
=20
-#: git-gui.sh:2413
+#: git-gui.sh:2904
 msgid "Commit Message:"
 msgstr "=D0=9A=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=
=B9 =D0=BA =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E:"
=20
-#: git-gui.sh:2459 git-gui.sh:2622 lib/console.tcl:73
+#: git-gui.sh:2953 git-gui.sh:3104 lib/console.tcl:73
 msgid "Copy All"
 msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D0=
=B2=D1=81=D0=B5"
=20
-#: git-gui.sh:2483 lib/blame.tcl:107
+#: git-gui.sh:2977 lib/blame.tcl:104
 msgid "File:"
 msgstr "=D0=A4=D0=B0=D0=B9=D0=BB:"
=20
-#: git-gui.sh:2589
-msgid "Apply/Reverse Hunk"
-msgstr "=D0=9F=D1=80=D0=B8=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C/=D0=A3=D0=
=B1=D1=80=D0=B0=D1=82=D1=8C =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=
=B8=D0=B5"
-
-#: git-gui.sh:2595
-msgid "Show Less Context"
-msgstr "=D0=9C=D0=B5=D0=BD=D1=8C=D1=88=D0=B5 =D0=BA=D0=BE=D0=BD=D1=82=D0=
=B5=D0=BA=D1=81=D1=82=D0=B0"
-
-#: git-gui.sh:2602
-msgid "Show More Context"
-msgstr "=D0=91=D0=BE=D0=BB=D1=8C=D1=88=D0=B5 =D0=BA=D0=BE=D0=BD=D1=82=D0=
=B5=D0=BA=D1=81=D1=82=D0=B0"
-
-#: git-gui.sh:2610
+#: git-gui.sh:3092
 msgid "Refresh"
 msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C"
=20
-#: git-gui.sh:2631
+#: git-gui.sh:3113
 msgid "Decrease Font Size"
 msgstr "=D0=A3=D0=BC=D0=B5=D0=BD=D1=8C=D1=88=D0=B8=D1=82=D1=8C =D1=80=D0=
=B0=D0=B7=D0=BC=D0=B5=D1=80 =D1=88=D1=80=D0=B8=D1=84=D1=82=D0=B0"
=20
-#: git-gui.sh:2635
+#: git-gui.sh:3117
 msgid "Increase Font Size"
 msgstr "=D0=A3=D0=B2=D0=B5=D0=BB=D0=B8=D1=87=D0=B8=D1=82=D1=8C =D1=80=D0=
=B0=D0=B7=D0=BC=D0=B5=D1=80 =D1=88=D1=80=D0=B8=D1=84=D1=82=D0=B0"
=20
-#: git-gui.sh:2646
+#: git-gui.sh:3125 lib/blame.tcl:281
+msgid "Encoding"
+msgstr "=D0=9A=D0=BE=D0=B4=D0=B8=D1=80=D0=BE=D0=B2=D0=BA=D0=B0"
+
+#: git-gui.sh:3136
+msgid "Apply/Reverse Hunk"
+msgstr "=D0=9F=D1=80=D0=B8=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C/=D0=A3=D0=
=B1=D1=80=D0=B0=D1=82=D1=8C =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=
=B8=D0=B5"
+
+#: git-gui.sh:3141
+msgid "Apply/Reverse Line"
+msgstr "=D0=9F=D1=80=D0=B8=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C/=D0=A3=D0=
=B1=D1=80=D0=B0=D1=82=D1=8C =D1=81=D1=82=D1=80=D0=BE=D0=BA=D1=83"
+
+#: git-gui.sh:3151
+msgid "Run Merge Tool"
+msgstr "=D0=97=D0=B0=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=8C =D0=BF=D1=
=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D1=83 =D0=BE=D0=B1=D1=8A=D0=B5=D0=
=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
+
+#: git-gui.sh:3156
+msgid "Use Remote Version"
+msgstr "=D0=92=D0=B7=D1=8F=D1=82=D1=8C =D0=B2=D0=BD=D0=B5=D1=88=D0=BD=D1=
=8E=D1=8E =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8E"
+
+#: git-gui.sh:3160
+msgid "Use Local Version"
+msgstr "=D0=92=D0=B7=D1=8F=D1=82=D1=8C =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D1=
=8C=D0=BD=D1=83=D1=8E =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8E"
+
+#: git-gui.sh:3164
+msgid "Revert To Base"
+msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
+
+#: git-gui.sh:3183
 msgid "Unstage Hunk From Commit"
 msgstr "=D0=9D=D0=B5 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D1=8F=D1=82=D1=
=8C =D1=87=D0=B0=D1=81=D1=82=D1=8C"
=20
-#: git-gui.sh:2648
+#: git-gui.sh:3184
+msgid "Unstage Line From Commit"
+msgstr "=D0=A3=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D1=81=D1=82=D1=80=D0=BE=D0=
=BA=D1=83 =D0=B8=D0=B7 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=
=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE"
+
+#: git-gui.sh:3186
 msgid "Stage Hunk For Commit"
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D1=87=D0=B0=D1=81=D1=82=D1=8C =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=
=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
-#: git-gui.sh:2667
+#: git-gui.sh:3187
+msgid "Stage Line For Commit"
+msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=
=8C =D1=81=D1=82=D1=80=D0=BE=D0=BA=D1=83 =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=
=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
+
+#: git-gui.sh:3210
 msgid "Initializing..."
 msgstr "=D0=98=D0=BD=D0=B8=D1=86=D0=B8=D0=B0=D0=BB=D0=B8=D0=B7=D0=B0=D1=
=86=D0=B8=D1=8F..."
=20
-#: git-gui.sh:2762
+#: git-gui.sh:3315
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -447,7 +514,7 @@ msgstr ""
 "=D0=B7=D0=B0=D0=BF=D1=83=D1=89=D0=B5=D0=BD=D0=BD=D1=8B=D0=BC=D0=B8 =D0=
=B8=D0=B7 %s\n"
 "\n"
=20
-#: git-gui.sh:2792
+#: git-gui.sh:3345
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
@@ -457,7 +524,7 @@ msgstr ""
 "=D0=AD=D1=82=D0=BE =D0=B8=D0=B7=D0=B2=D0=B5=D1=81=D1=82=D0=BD=D0=B0=D1=
=8F =D0=BF=D1=80=D0=BE=D0=B1=D0=BB=D0=B5=D0=BC=D0=B0 =D1=81 Tcl,\n"
 "=D1=80=D0=B0=D1=81=D0=BF=D1=80=D0=BE=D1=81=D1=82=D1=80=D0=B0=D0=BD=D1=
=8F=D0=B5=D0=BC=D1=8B=D0=BC Cygwin."
=20
-#: git-gui.sh:2797
+#: git-gui.sh:3350
 #, tcl-format
 msgid ""
 "\n"
@@ -478,64 +545,108 @@ msgstr ""
 msgid "git-gui - a graphical user interface for Git."
 msgstr "git-gui - =D0=B3=D1=80=D0=B0=D1=84=D0=B8=D1=87=D0=B5=D1=81=D0=BA=
=D0=B8=D0=B9 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=
=D0=BB=D1=8C=D1=81=D0=BA=D0=B8=D0=B9 =D0=B8=D0=BD=D1=82=D0=B5=D1=80=D1=84=
=D0=B5=D0=B9=D1=81 =D0=BA Git."
=20
-#: lib/blame.tcl:77
+#: lib/blame.tcl:72
 msgid "File Viewer"
 msgstr "=D0=9F=D1=80=D0=BE=D1=81=D0=BC=D0=BE=D1=82=D1=80 =D1=84=D0=B0=D0=
=B9=D0=BB=D0=B0"
=20
-#: lib/blame.tcl:81
+#: lib/blame.tcl:78
 msgid "Commit:"
 msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D0=BE=D0=
=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5:"
=20
-#: lib/blame.tcl:264
+#: lib/blame.tcl:271
 msgid "Copy Commit"
 msgstr "=D0=A1=D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=
=8C SHA-1"
=20
-#: lib/blame.tcl:384
+#: lib/blame.tcl:275
+msgid "Find Text..."
+msgstr "=D0=9D=D0=B0=D0=B9=D1=82=D0=B8 =D1=82=D0=B5=D0=BA=D1=81=D1=82.=
=2E."
+
+#: lib/blame.tcl:284
+msgid "Do Full Copy Detection"
+msgstr "=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=81=D1=82=D0=B8 =D0=BF=D0=BE=D0=
=BB=D0=BD=D1=8B=D0=B9 =D0=BF=D0=BE=D0=B8=D1=81=D0=BA =D0=BA=D0=BE=D0=BF=
=D0=B8=D0=B9"
+
+#: lib/blame.tcl:288
+msgid "Show History Context"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=BA=D0=BE=D0=
=BD=D1=82=D0=B5=D0=BA=D1=81=D1=82 =D0=B8=D1=81=D1=82=D0=BE=D1=80=D0=B8=D0=
=B8"
+
+#: lib/blame.tcl:291
+msgid "Blame Parent Commit"
+msgstr "=D0=A0=D0=B0=D1=81=D1=81=D0=BC=D0=BE=D1=82=D1=80=D0=B5=D1=82=D1=
=8C =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D0=BF=D1=80=
=D0=B5=D0=B4=D0=BA=D0=B0"
+
+#: lib/blame.tcl:450
 #, tcl-format
 msgid "Reading %s..."
 msgstr "=D0=A7=D1=82=D0=B5=D0=BD=D0=B8=D0=B5 %s..."
=20
-#: lib/blame.tcl:488
+#: lib/blame.tcl:557
 msgid "Loading copy/move tracking annotations..."
 msgstr "=D0=97=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B0 =D0=B0=D0=BD=D0=
=BD=D0=BE=D1=82=D0=B0=D1=86=D0=B8=D0=B8 =D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=
=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=B9/=D0=BF=D0=B5=D1=80=D0=B5=D0=B8=D0=BC=D0=
=B5=D0=BD=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=B9..."
=20
-#: lib/blame.tcl:508
+#: lib/blame.tcl:577
 msgid "lines annotated"
 msgstr "=D1=81=D1=82=D1=80=D0=BE=D0=BA =D0=BF=D1=80=D0=BE=D0=BA=D0=BE=D0=
=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=BE"
=20
-#: lib/blame.tcl:689
+#: lib/blame.tcl:769
 msgid "Loading original location annotations..."
 msgstr "=D0=97=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B0 =D0=B0=D0=BD=D0=
=BD=D0=BE=D1=82=D0=B0=D1=86=D0=B8=D0=B9 =D0=BF=D0=B5=D1=80=D0=B2=D0=BE=D0=
=BD=D0=B0=D1=87=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B3=D0=BE =D0=BF=D0=BE=D0=
=BB=D0=BE=D0=B6=D0=B5=D0=BD=D0=B8=D1=8F =D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=
=82=D0=B0..."
=20
-#: lib/blame.tcl:692
+#: lib/blame.tcl:772
 msgid "Annotation complete."
 msgstr "=D0=90=D0=BD=D0=BD=D0=BE=D1=82=D0=B0=D1=86=D0=B8=D1=8F =D0=B7=D0=
=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B5=D0=BD=D0=B0."
=20
-#: lib/blame.tcl:746
+#: lib/blame.tcl:802
+msgid "Busy"
+msgstr "=D0=97=D0=B0=D0=BD=D1=8F=D1=82"
+
+#: lib/blame.tcl:803
+msgid "Annotation process is already running."
+msgstr "=D0=90=D0=BD=D0=BD=D0=BE=D1=82=D0=B0=D1=86=D0=B8=D1=8F =D1=83=D0=
=B6=D0=B5 =D0=B7=D0=B0=D0=BF=D1=83=D1=89=D0=B5=D0=BD=D0=B0"
+
+#: lib/blame.tcl:842
+msgid "Running thorough copy detection..."
+msgstr "=D0=92=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BF=D0=BE=D0=BB=D0=BD=D0=BE=D0=B3=D0=BE =D0=BF=D0=BE=D0=B8=D1=81=D0=BA=D0=
=B0 =D0=BA=D0=BE=D0=BF=D0=B8=D0=B9..."
+
+#: lib/blame.tcl:910
 msgid "Loading annotation..."
 msgstr "=D0=97=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B0 =D0=B0=D0=BD=D0=
=BD=D0=BE=D1=82=D0=B0=D1=86=D0=B8=D0=B8..."
=20
-#: lib/blame.tcl:802
+#: lib/blame.tcl:963
 msgid "Author:"
 msgstr "=D0=90=D0=B2=D1=82=D0=BE=D1=80:"
=20
-#: lib/blame.tcl:806
+#: lib/blame.tcl:967
 msgid "Committer:"
 msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB:"
=20
-#: lib/blame.tcl:811
+#: lib/blame.tcl:972
 msgid "Original File:"
 msgstr "=D0=98=D1=81=D1=85=D0=BE=D0=B4=D0=BD=D1=8B=D0=B9 =D1=84=D0=B0=D0=
=B9=D0=BB:"
=20
-#: lib/blame.tcl:925
+#: lib/blame.tcl:1020
+msgid "Cannot find HEAD commit:"
+msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=
=BD=D0=B0=D0=B9=D1=82=D0=B8 =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B5 =
=D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5:"
+
+#: lib/blame.tcl:1075
+msgid "Cannot find parent commit:"
+msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=
=BD=D0=B0=D0=B9=D1=82=D0=B8 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=
=B8=D0=B5 =D0=BF=D1=80=D0=B5=D0=B4=D0=BA=D0=B0:"
+
+#: lib/blame.tcl:1090
+msgid "Unable to display parent"
+msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BF=D0=BE=D0=BA=D0=B0=
=D0=B7=D0=B0=D1=82=D1=8C =D0=BF=D1=80=D0=B5=D0=B4=D0=BA=D0=B0"
+
+#: lib/blame.tcl:1091 lib/diff.tcl:297
+msgid "Error loading diff:"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B7=D0=B0=D0=B3=D1=80=D1=
=83=D0=B7=D0=BA=D0=B8 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=
=B9:"
+
+#: lib/blame.tcl:1231
 msgid "Originally By:"
 msgstr "=D0=98=D1=81=D1=82=D0=BE=D1=87=D0=BD=D0=B8=D0=BA:"
=20
-#: lib/blame.tcl:931
+#: lib/blame.tcl:1237
 msgid "In File:"
 msgstr "=D0=A4=D0=B0=D0=B9=D0=BB:"
=20
-#: lib/blame.tcl:936
+#: lib/blame.tcl:1242
 msgid "Copied Or Moved Here By:"
 msgstr "=D0=A1=D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=
=BE/=D0=BF=D0=B5=D1=80=D0=B5=D0=BC=D0=B5=D1=89=D0=B5=D0=BD=D0=BE =D0=B2=
:"
=20
@@ -549,16 +660,18 @@ msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8=
"
=20
 #: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
 #: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:2=
82
-#: lib/checkout_op.tcl:522 lib/choose_font.tcl:43 lib/merge.tcl:171
-#: lib/option.tcl:103 lib/remote_branch_delete.tcl:42 lib/transport.tc=
l:97
+#: lib/checkout_op.tcl:544 lib/choose_font.tcl:43 lib/merge.tcl:172
+#: lib/option.tcl:125 lib/remote_add.tcl:32 lib/remote_branch_delete.t=
cl:42
+#: lib/tools_dlg.tcl:40 lib/tools_dlg.tcl:204 lib/tools_dlg.tcl:352
+#: lib/transport.tcl:108
 msgid "Cancel"
-msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C"
+msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B0"
=20
-#: lib/branch_checkout.tcl:32 lib/browser.tcl:287
+#: lib/branch_checkout.tcl:32 lib/browser.tcl:287 lib/tools_dlg.tcl:32=
8
 msgid "Revision"
 msgstr "=D0=92=D0=B5=D1=80=D1=81=D0=B8=D1=8F"
=20
-#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:=
242
+#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:=
280
 msgid "Options"
 msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8"
=20
@@ -578,7 +691,7 @@ msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=B8=D0=
=B5 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
 msgid "Create New Branch"
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D0=BD=D0=BE=D0=B2=D1=
=83=D1=8E =D0=B2=D0=B5=D1=82=D0=B2=D1=8C"
=20
-#: lib/branch_create.tcl:31 lib/choose_repository.tcl:371
+#: lib/branch_create.tcl:31 lib/choose_repository.tcl:377
 msgid "Create"
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C"
=20
@@ -586,7 +699,7 @@ msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C"
 msgid "Branch Name"
 msgstr "=D0=9D=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D0=B2=D0=B5=D1=
=82=D0=B2=D0=B8"
=20
-#: lib/branch_create.tcl:43
+#: lib/branch_create.tcl:43 lib/remote_add.tcl:39 lib/tools_dlg.tcl:50
 msgid "Name:"
 msgstr "=D0=9D=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5:"
=20
@@ -610,7 +723,7 @@ msgstr "=D0=9D=D0=B5=D1=82"
 msgid "Fast Forward Only"
 msgstr "=D0=A2=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE Fast Forward"
=20
-#: lib/branch_create.tcl:85 lib/checkout_op.tcl:514
+#: lib/branch_create.tcl:85 lib/checkout_op.tcl:536
 msgid "Reset"
 msgstr "=D0=A1=D0=B1=D1=80=D0=BE=D1=81"
=20
@@ -690,7 +803,7 @@ msgstr "=D0=9D=D0=BE=D0=B2=D0=BE=D0=B5 =D0=BD=D0=B0=
=D0=B7=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5:"
 msgid "Please select a branch to rename."
 msgstr "=D0=A3=D0=BA=D0=B0=D0=B6=D0=B8=D1=82=D0=B5 =D0=B2=D0=B5=D1=82=D0=
=B2=D1=8C =D0=B4=D0=BB=D1=8F =D0=BF=D0=B5=D1=80=D0=B5=D0=B8=D0=BC=D0=B5=
=D0=BD=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F."
=20
-#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:179
+#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:201
 #, tcl-format
 msgid "Branch '%s' already exists."
 msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C '%s' =D1=83=D0=B6=D0=B5 =D1=81=D1=
=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82."
@@ -721,32 +834,38 @@ msgstr "[=D0=9D=D0=B0 =D1=83=D1=80=D0=BE=D0=B2=D0=
=B5=D0=BD=D1=8C =D0=B2=D1=8B=D1=88=D0=B5]"
 msgid "Browse Branch Files"
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D1=84=D0=B0=D0=
=B9=D0=BB=D1=8B =D0=B2=D0=B5=D1=82=D0=B2=D0=B8"
=20
-#: lib/browser.tcl:278 lib/choose_repository.tcl:387
-#: lib/choose_repository.tcl:474 lib/choose_repository.tcl:484
-#: lib/choose_repository.tcl:987
+#: lib/browser.tcl:278 lib/choose_repository.tcl:394
+#: lib/choose_repository.tcl:480 lib/choose_repository.tcl:491
+#: lib/choose_repository.tcl:995
 msgid "Browse"
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C"
=20
-#: lib/checkout_op.tcl:79
+#: lib/checkout_op.tcl:84
 #, tcl-format
 msgid "Fetching %s from %s"
 msgstr "=D0=9F=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 %s =D0=B8=
=D0=B7 %s "
=20
-#: lib/checkout_op.tcl:127
+#: lib/checkout_op.tcl:132
 #, tcl-format
 msgid "fatal: Cannot resolve %s"
 msgstr "=D0=BA=D1=80=D0=B8=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B0=D1=
=8F =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=B0: =D0=BD=D0=B5=D0=B2=D0=BE=D0=B7=
=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D1=80=D0=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B8=
=D1=82=D1=8C %s"
=20
-#: lib/checkout_op.tcl:140 lib/console.tcl:81 lib/database.tcl:31
+#: lib/checkout_op.tcl:145 lib/console.tcl:81 lib/database.tcl:31
+#: lib/sshkey.tcl:53
 msgid "Close"
 msgstr "=D0=97=D0=B0=D0=BA=D1=80=D1=8B=D1=82=D1=8C"
=20
-#: lib/checkout_op.tcl:169
+#: lib/checkout_op.tcl:174
 #, tcl-format
 msgid "Branch '%s' does not exist."
 msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C '%s' =D0=BD=D0=B5 =D1=81=D1=83=D1=
=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82 "
=20
-#: lib/checkout_op.tcl:206
+#: lib/checkout_op.tcl:193
+#, tcl-format
+msgid "Failed to configure simplified git-pull for '%s'."
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D1=81=D0=BE=D0=B7=D0=B4=D0=
=B0=D0=BD=D0=B8=D1=8F =D1=83=D0=BF=D1=80=D0=BE=D1=89=D1=91=D0=BD=D0=BD=D0=
=BE=D0=B9 =D0=BA=D0=BE=D0=BD=D1=84=D0=B8=D0=B3=D1=83=D1=80=D0=B0=D1=86=D0=
=B8=D0=B8 git pull =D0=B4=D0=BB=D1=8F '%s'."
+
+#: lib/checkout_op.tcl:228
 #, tcl-format
 msgid ""
 "Branch '%s' already exists.\n"
@@ -759,21 +878,21 @@ msgstr ""
 "=D0=9E=D0=BD=D0=B0 =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5=D1=82 =D0=B1=
=D1=8B=D1=82=D1=8C =D0=BF=D1=80=D0=BE=D0=BA=D1=80=D1=83=D1=87=D0=B5=D0=BD=
=D0=B0(fast-forward) =D0=BA %s.\n"
 "=D0=A2=D1=80=D0=B5=D0=B1=D1=83=D0=B5=D1=82=D1=81=D1=8F =D0=BE=D0=B1=D1=
=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5."
=20
-#: lib/checkout_op.tcl:220
+#: lib/checkout_op.tcl:242
 #, tcl-format
 msgid "Merge strategy '%s' not supported."
 msgstr "=D0=A1=D1=82=D1=80=D0=B0=D1=82=D0=B5=D0=B3=D0=B8=D1=8F =D0=BE=D0=
=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F '%s' =D0=BD=D0=
=B5 =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D0=B2=D0=B0=D0=B5=D1=
=82=D1=81=D1=8F."
=20
-#: lib/checkout_op.tcl:239
+#: lib/checkout_op.tcl:261
 #, tcl-format
 msgid "Failed to update '%s'."
 msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BE=
=D0=B1=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C '%s'."
=20
-#: lib/checkout_op.tcl:251
+#: lib/checkout_op.tcl:273
 msgid "Staging area (index) is already locked."
 msgstr "=D0=A0=D0=B0=D0=B1=D0=BE=D1=87=D0=B0=D1=8F =D0=BE=D0=B1=D0=BB=D0=
=B0=D1=81=D1=82=D1=8C =D0=B7=D0=B0=D0=B1=D0=BB=D0=BE=D0=BA=D0=B8=D1=80=D0=
=BE=D0=B2=D0=B0=D0=BD=D0=B0 =D0=B4=D1=80=D1=83=D0=B3=D0=B8=D0=BC =D0=BF=
=D1=80=D0=BE=D1=86=D0=B5=D1=81=D1=81=D0=BE=D0=BC."
=20
-#: lib/checkout_op.tcl:266
+#: lib/checkout_op.tcl:288
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
@@ -789,30 +908,30 @@ msgstr ""
 "\n"
 "=D0=AD=D1=82=D0=BE =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=B4=D0=B5=D0=
=BB=D0=B0=D0=BD=D0=BE =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B0=D0=B2=
=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8.\n"
=20
-#: lib/checkout_op.tcl:322
+#: lib/checkout_op.tcl:344
 #, tcl-format
 msgid "Updating working directory to '%s'..."
 msgstr "=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D1=
=80=D0=B0=D0=B1=D0=BE=D1=87=D0=B5=D0=B3=D0=BE =D0=BA=D0=B0=D1=82=D0=B0=D0=
=BB=D0=BE=D0=B3=D0=B0 =D0=B8=D0=B7 '%s'..."
=20
-#: lib/checkout_op.tcl:323
+#: lib/checkout_op.tcl:345
 msgid "files checked out"
 msgstr "=D1=84=D0=B0=D0=B9=D0=BB=D1=8B =D0=B8=D0=B7=D0=B2=D0=BB=D0=B5=D1=
=87=D0=B5=D0=BD=D1=8B"
=20
-#: lib/checkout_op.tcl:353
+#: lib/checkout_op.tcl:375
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
 msgstr "=D0=9F=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D0=BD =D0=BF=D0=B5=D1=80=D0=
=B5=D1=85=D0=BE=D0=B4 =D0=BD=D0=B0 '%s' (=D1=82=D1=80=D0=B5=D0=B1=D1=83=
=D0=B5=D1=82=D1=81=D1=8F =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=
=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B0 =D1=83=D1=80=D0=BE=D0=B2=D0=BD=D0=B5 =D1=
=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2)"
=20
-#: lib/checkout_op.tcl:354
+#: lib/checkout_op.tcl:376
 msgid "File level merge required."
 msgstr "=D0=A2=D1=80=D0=B5=D0=B1=D1=83=D0=B5=D1=82=D1=81=D1=8F =D0=BE=D0=
=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B0 =
=D1=83=D1=80=D0=BE=D0=B2=D0=BD=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2=
=2E"
=20
-#: lib/checkout_op.tcl:358
+#: lib/checkout_op.tcl:380
 #, tcl-format
 msgid "Staying on branch '%s'."
 msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C '%s' =D0=BE=D1=81=D1=82=D0=B0=D0=
=B5=D1=82=D1=81=D1=8F =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B9."
=20
-#: lib/checkout_op.tcl:429
+#: lib/checkout_op.tcl:451
 msgid ""
 "You are no longer on a local branch.\n"
 "\n"
@@ -824,30 +943,30 @@ msgstr ""
 "=D0=95=D1=81=D0=BB=D0=B8 =D0=B2=D1=8B =D1=85=D0=BE=D1=82=D0=B8=D1=82=D0=
=B5 =D1=81=D0=BD=D0=BE=D0=B2=D0=B0 =D0=B2=D0=B5=D1=80=D0=BD=D1=83=D1=82=
=D1=8C=D1=81=D1=8F =D0=BA =D0=BA=D0=B0=D0=BA=D0=BE=D0=B9-=D0=BD=D0=B8=D0=
=B1=D1=83=D0=B4=D1=8C =D0=B2=D0=B5=D1=82=D0=B2=D0=B8, =D1=81=D0=BE=D0=B7=
=D0=B4=D0=B0=D0=B9=D1=82=D0=B5 =D0=B5=D0=B5 =D1=81=D0=B5=D0=B9=D1=87=D0=
=B0=D1=81, "
 "=D0=BD=D0=B0=D1=87=D0=B8=D0=BD=D0=B0=D1=8F =D1=81 '=D0=A2=D0=B5=D0=BA=
=D1=83=D1=89=D0=B5=D0=B3=D0=BE =D0=BE=D1=82=D1=81=D0=BE=D0=B5=D0=B4=D0=B8=
=D0=BD=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=
=D1=8F=D0=BD=D0=B8=D1=8F'."
=20
-#: lib/checkout_op.tcl:446 lib/checkout_op.tcl:450
+#: lib/checkout_op.tcl:468 lib/checkout_op.tcl:472
 #, tcl-format
 msgid "Checked out '%s'."
 msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C '%s' =D1=81=D0=B4=D0=B5=D0=BB=D0=
=B0=D0=BD=D0=B0 =D1=82=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B9."
=20
-#: lib/checkout_op.tcl:478
+#: lib/checkout_op.tcl:500
 #, tcl-format
 msgid "Resetting '%s' to '%s' will lose the following commits:"
 msgstr "=D0=A1=D0=B1=D1=80=D0=BE=D1=81 '%s' =D0=B2 '%s' =D0=BF=D1=80=D0=
=B8=D0=B2=D0=B5=D0=B4=D0=B5=D1=82 =D0=BA =D0=BF=D0=BE=D1=82=D0=B5=D1=80=
=D0=B5 =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B8=D1=85 =D1=81=D0=
=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D1=8B=D1=85 =D1=81=D0=BE=D1=
=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B9: "
=20
-#: lib/checkout_op.tcl:500
+#: lib/checkout_op.tcl:522
 msgid "Recovering lost commits may not be easy."
 msgstr "=D0=92=D0=BE=D1=81=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=
=82=D1=8C =D0=BF=D0=BE=D1=82=D0=B5=D1=80=D1=8F=D0=BD=D0=BD=D1=8B=D0=B5 =
=D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D1=81=
=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8F =D0=B1=D1=83=D0=B4=D0=B5=
=D1=82 =D1=81=D0=BB=D0=BE=D0=B6=D0=BD=D0=BE."
=20
-#: lib/checkout_op.tcl:505
+#: lib/checkout_op.tcl:527
 #, tcl-format
 msgid "Reset '%s'?"
 msgstr "=D0=A1=D0=B1=D1=80=D0=BE=D1=81=D0=B8=D1=82=D1=8C '%s'?"
=20
-#: lib/checkout_op.tcl:510 lib/merge.tcl:163
+#: lib/checkout_op.tcl:532 lib/merge.tcl:164 lib/tools_dlg.tcl:343
 msgid "Visualize"
 msgstr "=D0=9D=D0=B0=D0=B3=D0=BB=D1=8F=D0=B4=D0=BD=D0=BE"
=20
-#: lib/checkout_op.tcl:578
+#: lib/checkout_op.tcl:600
 #, tcl-format
 msgid ""
 "Failed to set current branch.\n"
@@ -890,224 +1009,228 @@ msgstr ""
=20
 #: lib/choose_repository.tcl:28
 msgid "Git Gui"
-msgstr ""
+msgstr "Git Gui"
=20
-#: lib/choose_repository.tcl:81 lib/choose_repository.tcl:376
+#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:382
 msgid "Create New Repository"
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D0=BD=D0=BE=D0=B2=D1=
=8B=D0=B9 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9"
=20
-#: lib/choose_repository.tcl:87
+#: lib/choose_repository.tcl:93
 msgid "New..."
 msgstr "=D0=9D=D0=BE=D0=B2=D1=8B=D0=B9..."
=20
-#: lib/choose_repository.tcl:94 lib/choose_repository.tcl:460
+#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:465
 msgid "Clone Existing Repository"
 msgstr "=D0=A1=D0=BA=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D1=8E=D1=89=D0=
=B8=D0=B9 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9"
=20
-#: lib/choose_repository.tcl:100
+#: lib/choose_repository.tcl:106
 msgid "Clone..."
 msgstr "=D0=A1=D0=BA=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C..."
=20
-#: lib/choose_repository.tcl:107 lib/choose_repository.tcl:976
+#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:983
 msgid "Open Existing Repository"
 msgstr "=D0=92=D1=8B=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D1=81=D1=83=D1=89=D0=
=B5=D1=81=D1=82=D0=B2=D1=83=D1=8E=D1=89=D0=B8=D0=B9 =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9"
=20
-#: lib/choose_repository.tcl:113
+#: lib/choose_repository.tcl:119
 msgid "Open..."
 msgstr "=D0=9E=D1=82=D0=BA=D1=80=D1=8B=D1=82=D1=8C..."
=20
-#: lib/choose_repository.tcl:126
+#: lib/choose_repository.tcl:132
 msgid "Recent Repositories"
 msgstr "=D0=9D=D0=B5=D0=B4=D0=B0=D0=B2=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=
=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B8"
=20
-#: lib/choose_repository.tcl:132
+#: lib/choose_repository.tcl:138
 msgid "Open Recent Repository:"
 msgstr "=D0=9E=D1=82=D0=BA=D1=80=D1=8B=D1=82=D1=8C =D0=BF=D0=BE=D1=81=D0=
=BB=D0=B5=D0=B4=D0=BD=D0=B8=D0=B9 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=
=82=D0=BE=D1=80=D0=B8=D0=B9"
=20
-#: lib/choose_repository.tcl:296 lib/choose_repository.tcl:303
-#: lib/choose_repository.tcl:310
+#: lib/choose_repository.tcl:302 lib/choose_repository.tcl:309
+#: lib/choose_repository.tcl:316
 #, tcl-format
 msgid "Failed to create repository %s:"
 msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D1=81=
=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=
=D1=82=D0=BE=D1=80=D0=B8=D0=B9 %s:"
=20
-#: lib/choose_repository.tcl:381 lib/choose_repository.tcl:478
+#: lib/choose_repository.tcl:387
 msgid "Directory:"
 msgstr "=D0=9A=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3:"
=20
-#: lib/choose_repository.tcl:412 lib/choose_repository.tcl:537
-#: lib/choose_repository.tcl:1011
+#: lib/choose_repository.tcl:417 lib/choose_repository.tcl:544
+#: lib/choose_repository.tcl:1017
 msgid "Git Repository"
 msgstr "=D0=A0=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9"
=20
-#: lib/choose_repository.tcl:437
+#: lib/choose_repository.tcl:442
 #, tcl-format
 msgid "Directory %s already exists."
 msgstr "=D0=9A=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 '%s' =D1=83=D0=B6=D0=
=B5 =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82."
=20
-#: lib/choose_repository.tcl:441
+#: lib/choose_repository.tcl:446
 #, tcl-format
 msgid "File %s already exists."
 msgstr "=D0=A4=D0=B0=D0=B9=D0=BB '%s' =D1=83=D0=B6=D0=B5 =D1=81=D1=83=D1=
=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82."
=20
-#: lib/choose_repository.tcl:455
+#: lib/choose_repository.tcl:460
 msgid "Clone"
 msgstr "=D0=A1=D0=BA=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C"
=20
-#: lib/choose_repository.tcl:468
-msgid "URL:"
-msgstr "=D0=A1=D1=81=D1=8B=D0=BB=D0=BA=D0=B0:"
+#: lib/choose_repository.tcl:473
+msgid "Source Location:"
+msgstr "=D0=98=D1=81=D1=85=D0=BE=D0=B4=D0=BD=D0=BE=D0=B5 =D0=BF=D0=BE=D0=
=BB=D0=BE=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5:"
=20
-#: lib/choose_repository.tcl:489
+#: lib/choose_repository.tcl:484
+msgid "Target Directory:"
+msgstr "=D0=9A=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 =D0=BD=D0=B0=D0=B7=D0=
=BD=D0=B0=D1=87=D0=B5=D0=BD=D0=B8=D1=8F:"
+
+#: lib/choose_repository.tcl:496
 msgid "Clone Type:"
 msgstr "=D0=A2=D0=B8=D0=BF =D0=BA=D0=BB=D0=BE=D0=BD=D0=B0:"
=20
-#: lib/choose_repository.tcl:495
+#: lib/choose_repository.tcl:502
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
 msgstr "=D0=A1=D1=82=D0=B0=D0=BD=D0=B4=D0=B0=D1=80=D1=82=D0=BD=D1=8B=D0=
=B9 (=D0=91=D1=8B=D1=81=D1=82=D1=80=D1=8B=D0=B9, =D0=BF=D0=BE=D0=BB=D1=83=
=D0=B8=D0=B7=D0=B1=D1=8B=D1=82=D0=BE=D1=87=D0=BD=D1=8B=D0=B9, \"=D0=B6=D0=
=B5=D1=81=D1=82=D0=BA=D0=B8=D0=B5\" =D1=81=D1=81=D1=8B=D0=BB=D0=BA=D0=B8=
)"
=20
-#: lib/choose_repository.tcl:501
+#: lib/choose_repository.tcl:508
 msgid "Full Copy (Slower, Redundant Backup)"
 msgstr "=D0=9F=D0=BE=D0=BB=D0=BD=D0=B0=D1=8F =D0=BA=D0=BE=D0=BF=D0=B8=D1=
=8F (=D0=9C=D0=B5=D0=B4=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B9, =D1=81=D0=BE=
=D0=B7=D0=B4=D0=B0=D0=B5=D1=82 =D1=80=D0=B5=D0=B7=D0=B5=D1=80=D0=B2=D0=BD=
=D1=83=D1=8E =D0=BA=D0=BE=D0=BF=D0=B8=D1=8E)"
=20
-#: lib/choose_repository.tcl:507
+#: lib/choose_repository.tcl:514
 msgid "Shared (Fastest, Not Recommended, No Backup)"
 msgstr "=D0=9E=D0=B1=D1=89=D0=B8=D0=B9 (=D0=A1=D0=B0=D0=BC=D1=8B=D0=B9=
 =D0=B1=D1=8B=D1=81=D1=82=D1=80=D1=8B=D0=B9, =D0=BD=D0=B5 =D1=80=D0=B5=D0=
=BA=D0=BE=D0=BC=D0=B5=D0=BD=D0=B4=D1=83=D0=B5=D1=82=D1=81=D1=8F, =D0=B1=
=D0=B5=D0=B7 =D1=80=D0=B5=D0=B7=D0=B5=D1=80=D0=B2=D0=BD=D0=BE=D0=B9 =D0=
=BA=D0=BE=D0=BF=D0=B8=D0=B8)"
=20
-#: lib/choose_repository.tcl:543 lib/choose_repository.tcl:590
-#: lib/choose_repository.tcl:736 lib/choose_repository.tcl:806
-#: lib/choose_repository.tcl:1017 lib/choose_repository.tcl:1025
+#: lib/choose_repository.tcl:550 lib/choose_repository.tcl:597
+#: lib/choose_repository.tcl:743 lib/choose_repository.tcl:813
+#: lib/choose_repository.tcl:1023 lib/choose_repository.tcl:1031
 #, tcl-format
 msgid "Not a Git repository: %s"
 msgstr "=D0=9A=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3 =D0=BD=D0=B5 =D1=8F=
=D0=B2=D0=BB=D1=8F=D0=B5=D1=82=D1=81=D1=8F =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=
=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B5=D0=BC: %s"
=20
-#: lib/choose_repository.tcl:579
+#: lib/choose_repository.tcl:586
 msgid "Standard only available for local repository."
 msgstr "=D0=A1=D1=82=D0=B0=D0=BD=D0=B4=D0=B0=D1=80=D1=82=D0=BD=D1=8B=D0=
=B9 =D0=BA=D0=BB=D0=BE=D0=BD =D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=B5=
=D0=BD =D1=82=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE =D0=B4=D0=BB=D1=8F =D0=BB=D0=
=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B3=D0=BE =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F."
=20
-#: lib/choose_repository.tcl:583
+#: lib/choose_repository.tcl:590
 msgid "Shared only available for local repository."
 msgstr "=D0=9E=D0=B1=D1=89=D0=B8=D0=B9 =D0=BA=D0=BB=D0=BE=D0=BD =D0=B2=
=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=B5=D0=BD =D1=82=D0=BE=D0=BB=D1=8C=D0=BA=
=D0=BE =D0=B4=D0=BB=D1=8F =D0=BB=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D0=
=BE=D0=B3=D0=BE =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=
=B8=D1=8F."
=20
-#: lib/choose_repository.tcl:604
+#: lib/choose_repository.tcl:611
 #, tcl-format
 msgid "Location %s already exists."
 msgstr "=D0=9F=D1=83=D1=82=D1=8C '%s' =D1=83=D0=B6=D0=B5 =D1=81=D1=83=D1=
=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82."
=20
-#: lib/choose_repository.tcl:615
+#: lib/choose_repository.tcl:622
 msgid "Failed to configure origin"
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D1=81=D0=BA=D0=BE=D0=BD=
=D1=84=D0=B8=D0=B3=D1=83=D1=80=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C=
 =D0=B8=D1=81=D1=85=D0=BE=D0=B4=D0=BD=D1=8B=D0=B9 =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9."
=20
-#: lib/choose_repository.tcl:627
+#: lib/choose_repository.tcl:634
 msgid "Counting objects"
 msgstr "=D0=A1=D1=87=D0=B8=D1=82=D0=B0=D1=8E =D0=BE=D0=B1=D1=8A=D0=B5=D0=
=BA=D1=82=D1=8B"
=20
-#: lib/choose_repository.tcl:628
+#: lib/choose_repository.tcl:635
 msgid "buckets"
 msgstr ""
=20
-#: lib/choose_repository.tcl:652
+#: lib/choose_repository.tcl:659
 #, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D1=81=D0=BA=D0=BE=D0=BF=
=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C objects/info/alternates: %s"
=20
-#: lib/choose_repository.tcl:688
+#: lib/choose_repository.tcl:695
 #, tcl-format
 msgid "Nothing to clone from %s."
 msgstr "=D0=9D=D0=B5=D1=87=D0=B5=D0=B3=D0=BE =D0=BA=D0=BB=D0=BE=D0=BD=D0=
=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D1=81 %s."
=20
-#: lib/choose_repository.tcl:690 lib/choose_repository.tcl:904
-#: lib/choose_repository.tcl:916
+#: lib/choose_repository.tcl:697 lib/choose_repository.tcl:911
+#: lib/choose_repository.tcl:923
 msgid "The 'master' branch has not been initialized."
 msgstr "=D0=9D=D0=B5 =D0=B8=D0=BD=D0=B8=D1=86=D0=B8=D0=B0=D0=BB=D0=B8=D0=
=B7=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B0 =D0=B2=D0=B5=D1=82=D0=B2=D1=
=8C 'master'."
=20
-#: lib/choose_repository.tcl:703
+#: lib/choose_repository.tcl:710
 msgid "Hardlinks are unavailable.  Falling back to copying."
-msgstr "\"=D0=96=D0=B5=D1=81=D1=82=D0=BA=D0=B8=D0=B5 =D1=81=D1=81=D1=8B=
=D0=BB=D0=BA=D0=B8\" =D0=BD=D0=B5 =D0=B4=D0=BE=D1=81=D1=82=D1=83=D0=BF=D0=
=BD=D1=8B. =D0=91=D1=83=D0=B4=D1=83 =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=
=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=
=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5."
+msgstr "\"=D0=96=D0=B5=D1=81=D1=82=D0=BA=D0=B8=D0=B5 =D1=81=D1=81=D1=8B=
=D0=BB=D0=BA=D0=B8\" =D0=BD=D0=B5=D0=B4=D0=BE=D1=81=D1=82=D1=83=D0=BF=D0=
=BD=D1=8B. =D0=91=D1=83=D0=B4=D0=B5=D1=82 =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=
=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D0=BD=D0=BE =D0=BA=D0=BE=D0=BF=D0=B8=D1=80=
=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5."
=20
-#: lib/choose_repository.tcl:715
+#: lib/choose_repository.tcl:722
 #, tcl-format
 msgid "Cloning from %s"
 msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=
=B8=D0=B5 %s"
=20
-#: lib/choose_repository.tcl:746
+#: lib/choose_repository.tcl:753
 msgid "Copying objects"
 msgstr "=D0=9A=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=
=B5 objects"
=20
-#: lib/choose_repository.tcl:747
+#: lib/choose_repository.tcl:754
 msgid "KiB"
 msgstr "=D0=9A=D0=91"
=20
-#: lib/choose_repository.tcl:771
+#: lib/choose_repository.tcl:778
 #, tcl-format
 msgid "Unable to copy object: %s"
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D1=81=D0=BA=D0=BE=D0=BF=
=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=
=D1=82: %s"
=20
-#: lib/choose_repository.tcl:781
+#: lib/choose_repository.tcl:788
 msgid "Linking objects"
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=B8=D0=B5 =D1=81=D1=81=D1=
=8B=D0=BB=D0=BE=D0=BA =D0=BD=D0=B0 objects"
=20
-#: lib/choose_repository.tcl:782
+#: lib/choose_repository.tcl:789
 msgid "objects"
 msgstr "=D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=D1=8B"
=20
-#: lib/choose_repository.tcl:790
+#: lib/choose_repository.tcl:797
 #, tcl-format
 msgid "Unable to hardlink object: %s"
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 \"=D0=B6=D0=B5=D1=81=D1=82=
=D0=BA=D0=BE =D1=81=D0=B2=D1=8F=D0=B7=D0=B0=D1=82=D1=8C\" =D0=BE=D0=B1=D1=
=8A=D0=B5=D0=BA=D1=82: %s"
=20
-#: lib/choose_repository.tcl:845
+#: lib/choose_repository.tcl:852
 msgid "Cannot fetch branches and objects.  See console output for deta=
ils."
 msgstr ""
 "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=
=B8=D1=82=D1=8C =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 =D0=B8 =D0=BE=D0=B1=D1=8A=
=D0=B5=D0=BA=D1=82=D1=8B. =D0=94=D0=BE=D0=BF=D0=BE=D0=BB=D0=BD=D0=B8=D1=
=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=B8=D0=BD=D1=84=D0=BE=D1=80=D0=
=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BD=D1=81=D0=BE=
=D0=BB=D0=B8."
=20
-#: lib/choose_repository.tcl:856
+#: lib/choose_repository.tcl:863
 msgid "Cannot fetch tags.  See console output for details."
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BF=D0=BE=D0=BB=D1=83=
=D1=87=D0=B8=D1=82=D1=8C =D0=BC=D0=B5=D1=82=D0=BA=D0=B8. =D0=94=D0=BE=D0=
=BF=D0=BE=D0=BB=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=
=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=BD=D0=B0 =
=D0=BA=D0=BE=D0=BD=D1=81=D0=BE=D0=BB=D0=B8."
=20
-#: lib/choose_repository.tcl:880
+#: lib/choose_repository.tcl:887
 msgid "Cannot determine HEAD.  See console output for details."
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BE=D0=BF=D1=80=D0=B5=
=D0=B4=D0=B5=D0=BB=D0=B8=D1=82=D1=8C HEAD. =D0=94=D0=BE=D0=BF=D0=BE=D0=BB=
=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=B8=D0=BD=D1=84=
=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=BD=D0=B0 =D0=BA=D0=BE=D0=
=BD=D1=81=D0=BE=D0=BB=D0=B8."
=20
-#: lib/choose_repository.tcl:889
+#: lib/choose_repository.tcl:896
 #, tcl-format
 msgid "Unable to cleanup %s"
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BE=D1=87=D0=B8=D1=81=
=D1=82=D0=B8=D1=82=D1=8C %s"
=20
-#: lib/choose_repository.tcl:895
+#: lib/choose_repository.tcl:902
 msgid "Clone failed."
 msgstr "=D0=9A=D0=BB=D0=BE=D0=BD=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=
=B8=D0=B5 =D0=BD=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C."
=20
-#: lib/choose_repository.tcl:902
+#: lib/choose_repository.tcl:909
 msgid "No default branch obtained."
 msgstr "=D0=9D=D0=B5 =D0=B1=D1=8B=D0=BB=D0=BE =D0=BF=D0=BE=D0=BB=D1=83=
=D1=87=D0=B5=D0=BD=D0=BE =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 =D0=BF=D0=BE =D1=
=83=D0=BC=D0=BE=D0=BB=D1=87=D0=B0=D0=BD=D0=B8=D1=8E."
=20
-#: lib/choose_repository.tcl:913
+#: lib/choose_repository.tcl:920
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D1=80=D0=B0=D1=81=D0=BF=
=D0=BE=D0=B7=D0=BD=D0=B0=D1=82=D1=8C %s =D0=BA=D0=B0=D0=BA =D1=81=D0=BE=
=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5."
=20
-#: lib/choose_repository.tcl:925
+#: lib/choose_repository.tcl:932
 msgid "Creating working directory"
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=8E =D1=80=D0=B0=D0=B1=D0=BE=D1=
=87=D0=B8=D0=B9 =D0=BA=D0=B0=D1=82=D0=B0=D0=BB=D0=BE=D0=B3"
=20
-#: lib/choose_repository.tcl:926 lib/index.tcl:65 lib/index.tcl:127
-#: lib/index.tcl:193
+#: lib/choose_repository.tcl:933 lib/index.tcl:65 lib/index.tcl:128
+#: lib/index.tcl:196
 msgid "files"
 msgstr "=D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2"
=20
-#: lib/choose_repository.tcl:955
+#: lib/choose_repository.tcl:962
 msgid "Initial file checkout failed."
 msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=
=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D1=82=D1=8C =D0=BD=D0=B0=D1=87=D0=B0=D0=BB=
=D1=8C=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=
=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2 =D1=80=D0=B5=D0=BF=D0=BE=D0=
=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F."
=20
-#: lib/choose_repository.tcl:971
+#: lib/choose_repository.tcl:978
 msgid "Open"
 msgstr "=D0=9E=D1=82=D0=BA=D1=80=D1=8B=D1=82=D1=8C"
=20
-#: lib/choose_repository.tcl:981
+#: lib/choose_repository.tcl:988
 msgid "Repository:"
 msgstr "=D0=A0=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9:"
=20
-#: lib/choose_repository.tcl:1031
+#: lib/choose_repository.tcl:1037
 #, tcl-format
 msgid "Failed to open repository %s:"
 msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BE=
=D1=82=D0=BA=D1=80=D1=8B=D1=82=D1=8C =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=
=D1=82=D0=BE=D1=80=D0=B8=D0=B9 %s:"
@@ -1130,7 +1253,7 @@ msgstr "=D0=92=D0=B5=D1=82=D0=B2=D1=8C =D1=81=D0=BB=
=D0=B5=D0=B6=D0=B5=D0=BD=D0=B8=D1=8F"
=20
 #: lib/choose_rev.tcl:84 lib/choose_rev.tcl:538
 msgid "Tag"
-msgstr "=D0=A2=D0=B0=D0=B3"
+msgstr "=D0=9C=D0=B5=D1=82=D0=BA=D0=B0"
=20
 #: lib/choose_rev.tcl:317
 #, tcl-format
@@ -1177,19 +1300,19 @@ msgstr ""
 "=D0=A2=D0=B5=D0=BA=D1=83=D1=89=D0=B5=D0=B5 =D0=BE=D0=B1=D1=8A=D0=B5=D0=
=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B5 =D0=B7=D0=B0=D0=B2=
=D0=B5=D1=80=D1=88=D0=B5=D0=BD=D0=BE. =D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=
=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=
=82=D1=8C =D0=BF=D1=80=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=B5 =
"
 "=D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D0=BE=D0=B5 =D1=
=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B5 =D0=BF=
=D1=80=D0=B5=D1=80=D1=8B=D0=B2=D0=B0=D1=8F =D1=82=D0=B5=D0=BA=D1=83=D1=89=
=D0=B5=D0=B5 =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=
=D0=B5.\n"
=20
-#: lib/commit.tcl:49
+#: lib/commit.tcl:48
 msgid "Error loading commit data for amend:"
 msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=BF=D1=80=D0=B8 =D0=B7=
=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B5 =D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=
=D1=85 =D0=B4=D0=BB=D1=8F =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=
=B5=D0=BD=D0=B8=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=
=BD=D0=BE=D0=B3=D0=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=
=8F:"
=20
-#: lib/commit.tcl:76
+#: lib/commit.tcl:75
 msgid "Unable to obtain your identity:"
 msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=
=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B8=D1=82=D1=8C =D0=B8=D0=BD=D1=84=D0=BE=D1=
=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8E =D0=BE=D0=B1 =D0=B0=D0=B2=D1=82=D0=BE=
=D1=80=D1=81=D1=82=D0=B2=D0=B5:"
=20
-#: lib/commit.tcl:81
+#: lib/commit.tcl:80
 msgid "Invalid GIT_COMMITTER_IDENT:"
 msgstr "=D0=9D=D0=B5=D0=B2=D0=B5=D1=80=D0=BD=D1=8B=D0=B9 GIT_COMMITTER=
_IDENT:"
=20
-#: lib/commit.tcl:133
+#: lib/commit.tcl:132
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
@@ -1205,7 +1328,7 @@ msgstr ""
 "\n"
 "=D0=AD=D1=82=D0=BE =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=B4=D0=B5=D0=
=BB=D0=B0=D0=BD=D0=BE =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B0=D0=B2=
=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8.\n"
=20
-#: lib/commit.tcl:154
+#: lib/commit.tcl:155
 #, tcl-format
 msgid ""
 "Unmerged files cannot be committed.\n"
@@ -1218,7 +1341,7 @@ msgstr ""
 "=D0=94=D0=BB=D1=8F =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 %s =D0=B2=D0=BE=D0=B7=
=D0=BD=D0=B8=D0=BA =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82 =D0=
=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F. =D0=A0=
=D0=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B8=D1=82=D0=B5 =D0=BA=D0=BE=D0=BD=D1=84=
=D0=BB=D0=B8=D0=BA=D1=82 =D0=B8 =D0=B4=D0=BE=D0=B1=D0=B0=D0=B2=D1=8C=D1=
=82=D0=B5 =D0=BA "
 "=D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=
=BD=D1=8B=D0=BC =D1=84=D0=B0=D0=B9=D0=BB=D0=B0=D0=BC =D0=BF=D0=B5=D1=80=
=D0=B5=D0=B4 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5=
=D0=BC.\n"
=20
-#: lib/commit.tcl:162
+#: lib/commit.tcl:163
 #, tcl-format
 msgid ""
 "Unknown file state %s detected.\n"
@@ -1229,7 +1352,7 @@ msgstr ""
 "\n"
 "=D0=A4=D0=B0=D0=B9=D0=BB %s =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5=D1=82=
 =D0=B1=D1=8B=D1=82=D1=8C =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=
=BD =D0=B4=D0=B0=D0=BD=D0=BD=D0=BE=D0=B9 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=
=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9.\n"
=20
-#: lib/commit.tcl:170
+#: lib/commit.tcl:171
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1239,7 +1362,7 @@ msgstr ""
 "\n"
 "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D1=8C=D1=82=D0=B5 =D1=
=85=D0=BE=D1=82=D1=8F =D0=B1=D1=8B =D0=BE=D0=B4=D0=B8=D0=BD =D1=84=D0=B0=
=D0=B9=D0=BB =D0=B4=D0=BE =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=B8=D1=
=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=BD=D0=BE=D0=B3=D0=
=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8F.\n"
=20
-#: lib/commit.tcl:183
+#: lib/commit.tcl:186
 msgid ""
 "Please supply a commit message.\n"
 "\n"
@@ -1257,45 +1380,45 @@ msgstr ""
 "- =D0=B2=D1=82=D0=BE=D1=80=D0=B0=D1=8F =D1=81=D1=82=D1=80=D0=BE=D0=BA=
=D0=B0 =D0=BF=D1=83=D1=81=D1=82=D0=B0=D1=8F\n"
 "- =D0=BE=D1=81=D1=82=D0=B0=D0=B2=D1=88=D0=B8=D0=B5=D1=81=D1=8F =D1=81=
=D1=82=D1=80=D0=BE=D0=BA=D0=B8: =D0=BE=D0=BF=D0=B8=D1=88=D0=B8=D1=82=D0=
=B5, =D1=87=D1=82=D0=BE =D0=B4=D0=B0=D1=8E=D1=82 =D0=B2=D0=B0=D1=88=D0=B8=
 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F.\n"
=20
-#: lib/commit.tcl:207
+#: lib/commit.tcl:210
 #, tcl-format
 msgid "warning: Tcl does not support encoding '%s'."
 msgstr "=D0=BF=D1=80=D0=B5=D0=B4=D1=83=D0=BF=D1=80=D0=B5=D0=B6=D0=B4=D0=
=B5=D0=BD=D0=B8=D0=B5: Tcl =D0=BD=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=
=80=D0=B6=D0=B8=D0=B2=D0=B0=D0=B5=D1=82 =D0=BA=D0=BE=D0=B4=D0=B8=D1=80=D0=
=BE=D0=B2=D0=BA=D1=83 '%s'."
=20
-#: lib/commit.tcl:221
+#: lib/commit.tcl:226
 msgid "Calling pre-commit hook..."
 msgstr "=D0=92=D1=8B=D0=B7=D0=BE=D0=B2 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=
=B0=D0=BC=D0=BC=D1=8B =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=BA=D0=
=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F =
pre-commit..."
=20
-#: lib/commit.tcl:236
+#: lib/commit.tcl:241
 msgid "Commit declined by pre-commit hook."
 msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BF=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D0=BD=D0=BE =D0=BF=D1=80=D0=BE=D0=B3=D1=
=80=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9 =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=
=B6=D0=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=
=B8=D1=8F pre-commit"
=20
-#: lib/commit.tcl:259
+#: lib/commit.tcl:264
 msgid "Calling commit-msg hook..."
 msgstr "=D0=92=D1=8B=D0=B7=D0=BE=D0=B2 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=
=B0=D0=BC=D0=BC=D1=8B =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=B6=D0=BA=D0=
=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F =
commit-msg..."
=20
-#: lib/commit.tcl:274
+#: lib/commit.tcl:279
 msgid "Commit declined by commit-msg hook."
 msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=BF=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D0=BD=D0=BE =D0=BF=D1=80=D0=BE=D0=B3=D1=
=80=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9 =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=
=B6=D0=BA=D0=B8 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=
=B8=D1=8F commit-msg"
=20
-#: lib/commit.tcl:287
+#: lib/commit.tcl:292
 msgid "Committing changes..."
 msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5 =D0=
=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9..."
=20
-#: lib/commit.tcl:303
+#: lib/commit.tcl:308
 msgid "write-tree failed:"
 msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 write-t=
ree =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D0=BB=D0=B0=D1=81=D1=8C =
=D1=81 =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=BE=D0=B9:"
=20
-#: lib/commit.tcl:304 lib/commit.tcl:348 lib/commit.tcl:368
+#: lib/commit.tcl:309 lib/commit.tcl:353 lib/commit.tcl:373
 msgid "Commit failed."
 msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D1=8C =D1=81=D0=
=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 =D0=BD=D0=B5 =D1=83=D0=B4=
=D0=B0=D0=BB=D0=BE=D1=81=D1=8C."
=20
-#: lib/commit.tcl:321
+#: lib/commit.tcl:326
 #, tcl-format
 msgid "Commit %s appears to be corrupt"
 msgstr "=D0=A1=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 %s =D0=B2=
=D1=8B=D0=B3=D0=BB=D1=8F=D0=B4=D0=B8=D1=82 =D0=BF=D0=BE=D0=B2=D1=80=D0=B5=
=D0=B6=D0=B4=D0=B5=D0=BD=D0=BD=D1=8B=D0=BC"
=20
-#: lib/commit.tcl:326
+#: lib/commit.tcl:331
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1309,19 +1432,19 @@ msgstr ""
 "\n"
 "=D0=A1=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B0=D0=B2=D1=82=D0=BE=D0=BC=D0=
=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8 =D0=B7=D0=B0=D0=BF=D1=83=D1=
=81=D1=82=D0=B8=D1=82=D1=81=D1=8F =D0=BF=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=
=82=D1=8B=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=
=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F.\n"
=20
-#: lib/commit.tcl:333
+#: lib/commit.tcl:338
 msgid "No changes to commit."
 msgstr "=D0=9E=D1=82=D1=83=D1=81=D1=82=D0=B2=D1=83=D1=8E=D1=82 =D0=B8=D0=
=B7=D0=BC=D0=B5=D0=BD=D0=B8=D1=8F =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=
=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F."
=20
-#: lib/commit.tcl:347
+#: lib/commit.tcl:352
 msgid "commit-tree failed:"
 msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 commit-=
tree =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D0=BB=D0=B0=D1=81=D1=8C=
 =D1=81 =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=BE=D0=B9:"
=20
-#: lib/commit.tcl:367
+#: lib/commit.tcl:372
 msgid "update-ref failed:"
 msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 update-=
ref =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D0=BB=D0=B0=D1=81=D1=8C =
=D1=81 =D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=BE=D0=B9:"
=20
-#: lib/commit.tcl:454
+#: lib/commit.tcl:460
 #, tcl-format
 msgid "Created commit %s: %s"
 msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=BE =D1=81=D0=BE=D1=81=D1=
=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=B5 %s: %s "
@@ -1396,7 +1519,7 @@ msgstr ""
 msgid "Invalid date from Git: %s"
 msgstr "=D0=9D=D0=B5=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D0=BB=D1=8C=D0=BD=D0=
=B0=D1=8F =D0=B4=D0=B0=D1=82=D0=B0 =D0=B2 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=
=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B8: %s"
=20
-#: lib/diff.tcl:42
+#: lib/diff.tcl:59
 #, tcl-format
 msgid ""
 "No differences detected.\n"
@@ -1418,40 +1541,101 @@ msgstr ""
 "\n"
 "=D0=A1=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D0=
=B7=D0=B0=D0=BF=D1=83=D1=89=D0=B5=D0=BD=D0=BE =D0=BF=D0=B5=D1=80=D0=B5=D1=
=87=D0=B8=D1=82=D1=8B=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D1=80=D0=B5=D0=BF=D0=
=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F, =D1=87=D1=82=D0=BE=D0=B1=
=D1=8B =D0=BD=D0=B0=D0=B9=D1=82=D0=B8 =D0=BF=D0=BE=D0=B4=D0=BE=D0=B1=D0=
=BD=D1=8B=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB=D1=8B."
=20
-#: lib/diff.tcl:81
+#: lib/diff.tcl:99
 #, tcl-format
 msgid "Loading diff of %s..."
 msgstr "=D0=97=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=BA=D0=B0 =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=B2 %s..."
=20
-#: lib/diff.tcl:114 lib/diff.tcl:184
+#: lib/diff.tcl:120
+msgid ""
+"LOCAL: deleted\n"
+"REMOTE:\n"
+msgstr ""
+"=D0=9B=D0=9E=D0=9A=D0=90=D0=9B=D0=AC=D0=9D=D0=9E: =D1=83=D0=B4=D0=B0=D0=
=BB=D1=91=D0=BD\n"
+"=D0=92=D0=9D=D0=95=D0=A8=D0=9D=D0=98=D0=99:\n"
+
+#: lib/diff.tcl:125
+msgid ""
+"REMOTE: deleted\n"
+"LOCAL:\n"
+msgstr ""
+"=D0=92=D0=9D=D0=95=D0=A8=D0=9D=D0=98=D0=99: =D1=83=D0=B4=D0=B0=D0=BB=D1=
=91=D0=BD\n"
+"=D0=9B=D0=9E=D0=9A=D0=90=D0=9B=D0=AC=D0=9D=D0=9E:\n"
+
+#: lib/diff.tcl:132
+msgid "LOCAL:\n"
+msgstr "=D0=9B=D0=9E=D0=9A=D0=90=D0=9B=D0=AC=D0=9D=D0=9E:\n"
+
+#: lib/diff.tcl:135
+msgid "REMOTE:\n"
+msgstr "=D0=92=D0=9D=D0=95=D0=A8=D0=9D=D0=98=D0=99:\n"
+
+#: lib/diff.tcl:197 lib/diff.tcl:296
 #, tcl-format
 msgid "Unable to display %s"
 msgstr "=D0=9D=D0=B5 =D0=BC=D0=BE=D0=B3=D1=83 =D0=BF=D0=BE=D0=BA=D0=B0=
=D0=B7=D0=B0=D1=82=D1=8C %s"
=20
-#: lib/diff.tcl:115
+#: lib/diff.tcl:198
 msgid "Error loading file:"
 msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B7=D0=B0=D0=B3=D1=80=D1=
=83=D0=B7=D0=BA=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0:"
=20
-#: lib/diff.tcl:122
+#: lib/diff.tcl:205
 msgid "Git Repository (subproject)"
 msgstr "=D0=A0=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9 Git (=D0=BF=D0=BE=D0=B4=D0=BF=D1=80=D0=BE=D0=B5=D0=BA=D1=82)"
=20
-#: lib/diff.tcl:134
+#: lib/diff.tcl:217
 msgid "* Binary file (not showing content)."
 msgstr "* =D0=94=D0=B2=D0=BE=D0=B8=D1=87=D0=BD=D1=8B=D0=B9 =D1=84=D0=B0=
=D0=B9=D0=BB (=D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D0=BC=D0=BE=D0=
=B5 =D0=BD=D0=B5 =D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=BE)"
=20
-#: lib/diff.tcl:185
-msgid "Error loading diff:"
-msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B7=D0=B0=D0=B3=D1=80=D1=
=83=D0=B7=D0=BA=D0=B8 diff:"
+#: lib/diff.tcl:222
+#, tcl-format
+msgid ""
+"* Untracked file is %d bytes.\n"
+"* Showing only first %d bytes.\n"
+msgstr ""
+"* =D0=A0=D0=B0=D0=B7=D0=BC=D0=B5=D1=80 =D0=BD=D0=B5=D0=BF=D0=BE=D0=B4=
=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE=D0=B3=D0=BE =D1=84=
=D0=B0=D0=B9=D0=BB=D0=B0 %d =D0=B1=D0=B0=D0=B9=D1=82.\n"
+"* =D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=BE =D0=BF=D0=B5=D1=80=
=D0=B2=D1=8B=D1=85 %d =D0=B1=D0=B0=D0=B9=D1=82.\n"
=20
-#: lib/diff.tcl:303
+#: lib/diff.tcl:228
+#, tcl-format
+msgid ""
+"\n"
+"* Untracked file clipped here by %s.\n"
+"* To see the entire file, use an external editor.\n"
+msgstr ""
+"\n"
+"* =D0=9D=D0=B5=D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=
=B5=D0=BD=D1=8B=D0=B9 =D1=84=D0=B0=D0=B9=D0=BB =D0=BE=D0=B1=D1=80=D0=B5=
=D0=B7=D0=B0=D0=BD: %s.\n"
+"* =D0=A7=D1=82=D0=BE=D0=B1=D1=8B =D1=83=D0=B2=D0=B8=D0=B4=D0=B5=D1=82=
=D1=8C =D0=B2=D0=B5=D1=81=D1=8C =D1=84=D0=B0=D0=B9=D0=BB, =D0=B8=D1=81=D0=
=BF=D0=BE=D0=BB=D1=8C=D0=B7=D1=83=D0=B9=D1=82=D0=B5 =D0=BF=D1=80=D0=BE=D0=
=B3=D1=80=D0=B0=D0=BC=D0=BC=D1=83-=D1=80=D0=B5=D0=B4=D0=B0=D0=BA=D1=82=D0=
=BE=D1=80.\n"
+
+#: lib/diff.tcl:436
 msgid "Failed to unstage selected hunk."
 msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=B8=
=D1=81=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=82=D1=8C =D0=B2=D1=8B=D0=B1=D1=80=
=D0=B0=D0=BD=D0=BD=D1=83=D1=8E =D1=87=D0=B0=D1=81=D1=82=D1=8C."
=20
-#: lib/diff.tcl:310
+#: lib/diff.tcl:443
 msgid "Failed to stage selected hunk."
 msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=
=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D0=BA =D1=
=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8E =D0=B2=D1=8B=D0=
=B1=D1=80=D0=B0=D0=BD=D0=BD=D1=83=D1=8E =D1=87=D0=B0=D1=81=D1=82=D1=8C.=
"
=20
+#: lib/diff.tcl:509
+msgid "Failed to unstage selected line."
+msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=B8=
=D1=81=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=82=D1=8C =D0=B2=D1=8B=D0=B1=D1=80=
=D0=B0=D0=BD=D0=BD=D1=83=D1=8E =D1=81=D1=82=D1=80=D0=BE=D0=BA=D1=83."
+
+#: lib/diff.tcl:517
+msgid "Failed to stage selected line."
+msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=
=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D0=BA =D1=
=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8E =D0=B2=D1=8B=D0=
=B1=D1=80=D0=B0=D0=BD=D0=BD=D1=83=D1=8E =D1=81=D1=82=D1=80=D0=BE=D0=BA=D1=
=83."
+
+#: lib/encoding.tcl:443
+msgid "Default"
+msgstr "=D0=9F=D0=BE =D1=83=D0=BC=D0=BE=D0=BB=D1=87=D0=B0=D0=BD=D0=B8=D1=
=8E"
+
+#: lib/encoding.tcl:448
+#, tcl-format
+msgid "System (%s)"
+msgstr "=D0=A1=D0=B8=D1=81=D1=82=D0=B5=D0=BC=D0=BD=D0=B0=D1=8F (%s)"
+
+#: lib/encoding.tcl:459 lib/encoding.tcl:465
+msgid "Other"
+msgstr "=D0=94=D1=80=D1=83=D0=B3=D0=B0=D1=8F"
+
 #: lib/error.tcl:20 lib/error.tcl:114
 msgid "error"
 msgstr "=D0=BE=D1=88=D0=B8=D0=B1=D0=BA=D0=B0"
@@ -1470,7 +1654,7 @@ msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=
=D1=81=D1=8C =D1=80=D0=B0=D0=B7=D0=B1=D0=BB=D0=BE=D0=BA=D0=B8=D1=80=D0=BE=
=D0=B2=D0=B0=D1=82=D1=8C =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81"
=20
 #: lib/index.tcl:15
 msgid "Index Error"
-msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B8=D0=BD=D0=B4=D0=B5=D0=
=BA=D1=81=D0=B0"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2 =D0=B8=D0=BD=D0=B4=
=D0=B5=D0=BA=D1=81=D0=B5"
=20
 #: lib/index.tcl:21
 msgid ""
@@ -1488,40 +1672,49 @@ msgstr "=D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=
=B6=D0=B8=D1=82=D1=8C"
 msgid "Unlock Index"
 msgstr "=D0=A0=D0=B0=D0=B7=D0=B1=D0=BB=D0=BE=D0=BA=D0=B8=D1=80=D0=BE=D0=
=B2=D0=B0=D1=82=D1=8C =D0=B8=D0=BD=D0=B4=D0=B5=D0=BA=D1=81"
=20
-#: lib/index.tcl:282
+#: lib/index.tcl:287
 #, tcl-format
 msgid "Unstaging %s from commit"
 msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 %s =D0=B8=D0=B7=
 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=B3=D0=BE"
=20
-#: lib/index.tcl:313
+#: lib/index.tcl:326
 msgid "Ready to commit."
 msgstr "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BB=D0=B5=D0=
=BD=D0=BE =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=
=D0=BD=D0=B8=D1=8F"
=20
-#: lib/index.tcl:326
+#: lib/index.tcl:339
 #, tcl-format
 msgid "Adding %s"
 msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 %=
s..."
=20
-#: lib/index.tcl:381
+#: lib/index.tcl:396
 #, tcl-format
 msgid "Revert changes in file %s?"
 msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2 =D1=84=D0=B0=D0=B9=D0=BB=
=D0=B5 %s?"
=20
-#: lib/index.tcl:383
+#: lib/index.tcl:398
 #, tcl-format
 msgid "Revert changes in these %i files?"
 msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2 %i =D1=84=D0=B0=D0=B9=D0=
=BB=D0=B5(-=D0=B0=D1=85)?"
=20
-#: lib/index.tcl:391
+#: lib/index.tcl:406
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
 "=D0=9B=D1=8E=D0=B1=D1=8B=D0=B5 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=
=BD=D0=B8=D1=8F, =D0=BD=D0=B5 =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=
=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BA =D1=81=D0=BE=D1=85=D1=
=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8E, =D0=B1=D1=83=D0=B4=D1=83=D1=82=
 =D0=BF=D0=BE=D1=82=D0=B5=D1=80=D1=8F=D0=BD=D1=8B =D0=BF=D1=80=D0=B8 =D0=
=B4=D0=B0=D0=BD=D0=BD=D0=BE=D0=B9 "
 "=D0=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=B8."
=20
-#: lib/index.tcl:394
+#: lib/index.tcl:409
 msgid "Do Nothing"
 msgstr "=D0=9D=D0=B8=D1=87=D0=B5=D0=B3=D0=BE =D0=BD=D0=B5 =D0=B4=D0=B5=
=D0=BB=D0=B0=D1=82=D1=8C"
=20
+#: lib/index.tcl:427
+msgid "Reverting selected files"
+msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=B2 =D0=B2=D1=8B=D0=B1=D1=80=
=D0=B0=D0=BD=D1=8B=D1=85 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0=D1=85"
+
+#: lib/index.tcl:431
+#, tcl-format
+msgid "Reverting %s"
+msgstr "=D0=9E=D1=82=D0=BC=D0=B5=D0=BD=D0=B0 =D0=B8=D0=B7=D0=BC=D0=B5=D0=
=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=B2 %s"
+
 #: lib/merge.tcl:13
 msgid ""
 "Cannot merge while amending.\n"
@@ -1549,7 +1742,7 @@ msgstr ""
 "\n"
 "=D0=AD=D1=82=D0=BE =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D1=81=D0=B4=D0=B5=D0=
=BB=D0=B0=D0=BD=D0=BE =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D0=B0=D0=B2=
=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=D0=BA=D0=B8.\n"
=20
-#: lib/merge.tcl:44
+#: lib/merge.tcl:45
 #, tcl-format
 msgid ""
 "You are in the middle of a conflicted merge.\n"
@@ -1566,7 +1759,7 @@ msgstr ""
 "=D0=A0=D0=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B8=D1=82=D0=B5 =D0=BA=D0=BE=D0=
=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82, =D0=BF=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=
=D0=BE=D0=B2=D1=8C=D1=82=D0=B5 =D1=84=D0=B0=D0=B9=D0=BB =D0=B8 =D1=81=D0=
=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5. =D0=A2=D0=BE=D0=BB=D1=8C=
=D0=BA=D0=BE =D0=BF=D0=BE=D1=81=D0=BB=D0=B5 =D1=8D=D1=82=D0=BE=D0=B3=D0=
=BE =D0=BC=D0=BE=D0=B6=D0=BD=D0=BE "
 "=D0=BD=D0=B0=D1=87=D0=B0=D1=82=D1=8C =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=
=8E=D1=89=D0=B5=D0=B5 =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=
=BD=D0=B8=D0=B5.\n"
=20
-#: lib/merge.tcl:54
+#: lib/merge.tcl:55
 #, tcl-format
 msgid ""
 "You are in the middle of a change.\n"
@@ -1583,33 +1776,34 @@ msgstr ""
 "=D0=9F=D0=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D1=8C=D1=82=D0=B5 =D0=
=B8 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5 =D0=B8=D0=B7=
=D0=BC=D0=B5=D0=BD=D0=B8=D1=8F =D0=BF=D0=B5=D1=80=D0=B5=D0=B4 =D0=BD=D0=
=B0=D1=87=D0=B0=D0=BB=D0=BE=D0=BC =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=
=BD=D0=B5=D0=BD=D0=B8=D1=8F. =D0=92 =D1=81=D0=BB=D1=83=D1=87=D0=B0=D0=B5=
 "
 "=D0=BD=D0=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D0=BE=D1=81=D1=
=82=D0=B8 =D1=8D=D1=82=D0=BE =D0=BF=D0=BE=D0=B7=D0=B2=D0=BE=D0=BB=D0=B8=
=D1=82 =D0=BF=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D1=82=D1=8C =D0=BE=D0=BF=D0=
=B5=D1=80=D0=B0=D1=86=D0=B8=D1=8E =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=
=BD=D0=B5=D0=BD=D0=B8=D1=8F.\n"
=20
-#: lib/merge.tcl:106
+#: lib/merge.tcl:107
 #, tcl-format
 msgid "%s of %s"
 msgstr "%s =D0=B8=D0=B7 %s"
=20
-#: lib/merge.tcl:119
+#: lib/merge.tcl:120
+#, tcl-format
 msgid "Merging %s and %s..."
 msgstr "=D0=9E=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=
=B5 %s =D0=B8 %s..."
=20
-#: lib/merge.tcl:130
+#: lib/merge.tcl:131
 msgid "Merge completed successfully."
 msgstr "=D0=9E=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=
=B5 =D1=83=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=B7=D0=B0=D0=B2=D0=B5=
=D1=80=D1=88=D0=B5=D0=BD=D0=BE."
=20
-#: lib/merge.tcl:132
+#: lib/merge.tcl:133
 msgid "Merge failed.  Conflict resolution is required."
 msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=B7=
=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D1=82=D1=8C =D0=BE=D0=B1=D1=8A=D0=B5=
=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5. =D0=A2=D1=80=D0=B5=D0=B1=D1=
=83=D0=B5=D1=82=D1=81=D1=8F =D1=80=D0=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B5=D0=
=BD=D0=B8=D0=B5 =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B0.=
"
=20
-#: lib/merge.tcl:157
+#: lib/merge.tcl:158
 #, tcl-format
 msgid "Merge Into %s"
 msgstr "=D0=9E=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B8=D1=82=D1=8C =D1=
=81 %s"
=20
-#: lib/merge.tcl:176
+#: lib/merge.tcl:177
 msgid "Revision To Merge"
 msgstr "=D0=92=D0=B5=D1=80=D1=81=D0=B8=D1=8F =D0=B4=D0=BB=D1=8F =D0=BE=
=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
-#: lib/merge.tcl:211
+#: lib/merge.tcl:212
 msgid ""
 "Cannot abort while amending.\n"
 "\n"
@@ -1619,7 +1813,7 @@ msgstr ""
 "\n"
 "=D0=97=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D1=82=D0=B5 =D1=82=D0=B5=D0=
=BA=D1=83=D1=89=D0=B5=D0=B5 =D0=B8=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=
=B5=D0=BD=D0=B8=D0=B5 =D1=81=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=
=BD=D0=BE=D0=B3=D0=BE =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=
=8F.\n"
=20
-#: lib/merge.tcl:221
+#: lib/merge.tcl:222
 msgid ""
 "Abort merge?\n"
 "\n"
@@ -1633,7 +1827,7 @@ msgstr ""
 "\n"
 "=D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C?"
=20
-#: lib/merge.tcl:227
+#: lib/merge.tcl:228
 msgid ""
 "Reset changes?\n"
 "\n"
@@ -1647,124 +1841,340 @@ msgstr ""
 "\n"
 "=D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C?"
=20
-#: lib/merge.tcl:238
+#: lib/merge.tcl:239
 msgid "Aborting"
 msgstr "=D0=9F=D1=80=D0=B5=D1=80=D1=8B=D0=B2=D0=B0=D1=8E"
=20
-#: lib/merge.tcl:238
+#: lib/merge.tcl:239
 msgid "files reset"
 msgstr "=D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2 =
=D1=84=D0=B0=D0=B9=D0=BB=D0=B0=D1=85 =D0=BE=D1=82=D0=BC=D0=B5=D0=BD=D0=B5=
=D0=BD=D1=8B"
=20
-#: lib/merge.tcl:265
+#: lib/merge.tcl:267
 msgid "Abort failed."
 msgstr "=D0=9F=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D1=82=D1=8C =D0=BD=D0=B5 =
=D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C."
=20
-#: lib/merge.tcl:267
+#: lib/merge.tcl:269
 msgid "Abort completed.  Ready."
 msgstr "=D0=9F=D1=80=D0=B5=D1=80=D0=B2=D0=B0=D0=BD=D0=BE."
=20
-#: lib/option.tcl:95
+#: lib/mergetool.tcl:8
+msgid "Force resolution to the base version?"
+msgstr "=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C =D0=B1=D0=B0=D0=B7=D0=BE=D0=B2=D1=83=D1=8E =D0=B2=D0=B5=D1=80=
=D1=81=D0=B8=D1=8E =D0=B4=D0=BB=D1=8F =D1=80=D0=B0=D0=B7=D1=80=D0=B5=D1=
=88=D0=B5=D0=BD=D0=B8=D1=8F =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=
=82=D0=B0?"
+
+#: lib/mergetool.tcl:9
+msgid "Force resolution to this branch?"
+msgstr "=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8E =D1=8D=D1=82=D0=BE=D0=B9=
 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 =D0=B4=D0=BB=D1=8F =D1=80=D0=B0=D0=B7=D1=
=80=D0=B5=D1=88=D0=B5=D0=BD=D0=B8=D1=8F =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=
=B8=D0=BA=D1=82=D0=B0?"
+
+#: lib/mergetool.tcl:10
+msgid "Force resolution to the other branch?"
+msgstr "=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D1=8E =D0=B4=D1=80=D1=83=D0=B3=
=D0=BE=D0=B9 =D0=B2=D0=B5=D1=82=D0=B2=D0=B8 =D0=B4=D0=BB=D1=8F =D1=80=D0=
=B0=D0=B7=D1=80=D0=B5=D1=88=D0=B5=D0=BD=D0=B8=D1=8F =D0=BA=D0=BE=D0=BD=D1=
=84=D0=BB=D0=B8=D0=BA=D1=82=D0=B0?"
+
+#: lib/mergetool.tcl:14
+#, tcl-format
+msgid ""
+"Note that the diff shows only conflicting changes.\n"
+"\n"
+"%s will be overwritten.\n"
+"\n"
+"This operation can be undone only by restarting the merge."
+msgstr ""
+"=D0=92=D0=BD=D0=B8=D0=BC=D0=B0=D0=BD=D0=B8=D0=B5! =D0=A1=D0=BF=D0=B8=D1=
=81=D0=BE=D0=BA =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =
=D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D1=8B=D0=B2=D0=B0=D0=B5=D1=82 =D1=82=D0=BE=
=D0=BB=D1=8C=D0=BA=D0=BE =D0=BA=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=
=D1=83=D1=8E=D1=89=D0=B8=D0=B5 =D0=BE=D1=82=D0=BB=D0=B8=D1=87=D0=B8=D1=8F=
=2E\n"
+"\n"
+"%s =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D0=BF=D0=B5=D1=80=D0=B5=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BD.\n"
+"\n"
+"=D0=A0=D0=B5=D0=B7=D1=83=D0=BB=D1=8C=D1=82=D0=B0=D1=82 =D0=BC=D0=BE=D0=
=B6=D0=B5=D1=82 =D0=B1=D1=8B=D1=82=D1=8C =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=
=D1=91=D0=BD =D1=82=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE =D0=BF=D0=B5=D1=80=D0=
=B5=D0=B7=D0=B0=D0=BF=D1=83=D1=81=D0=BA=D0=BE=D0=BC =D0=BE=D0=BF=D0=B5=D1=
=80=D0=B0=D1=86=D0=B8=D0=B8 =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=
=B5=D0=BD=D0=B8=D1=8F."
+
+#: lib/mergetool.tcl:45
+#, tcl-format
+msgid "File %s seems to have unresolved conflicts, still stage?"
+msgstr ""
+"=D0=A4=D0=B0=D0=B9=D0=BB %s =D0=BA=D0=B0=D0=B6=D0=B5=D1=82=D1=81=D1=8F=
 =D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =D0=BD=D0=B5=D0=BE=D0=
=B1=D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=B0=D0=BD=D1=8B=D0=B5 =D0=BA=D0=BE=D0=
=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D1=8B. "
+"=D0=9F=D1=80=D0=BE=D0=B4=D0=BE=D0=BB=D0=B6=D0=B8=D1=82=D1=8C =D0=BF=D0=
=BE=D0=B4=D0=B3=D0=BE=D1=82=D0=BE=D0=B2=D0=BA=D1=83 =D0=BA =D1=81=D0=BE=
=D1=85=D1=80=D0=B0=D0=BD=D0=B5=D0=BD=D0=B8=D1=8E?"
+
+#: lib/mergetool.tcl:60
+#, tcl-format
+msgid "Adding resolution for %s"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=BB=D1=8F=D1=8E =D1=80=D0=B5=D0=
=B7=D1=83=D0=BB=D1=8C=D1=82=D0=B0=D1=82 =D1=80=D0=B0=D0=B7=D1=80=D0=B5=D1=
=88=D0=B5=D0=BD=D0=B8=D1=8F =D0=B4=D0=BB=D1=8F %s"
+
+#: lib/mergetool.tcl:141
+msgid "Cannot resolve deletion or link conflicts using a tool"
+msgstr ""
+"=D0=9A=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D1=8B =D1=83=D0=B4=D0=
=B0=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F =D0=B8=D0=BB=D0=B8 =D1=81=D0=B2=D1=8F=
=D0=B7=D1=8B=D0=B2=D0=B0=D0=BD=D0=B8=D1=8F =D0=BD=D0=B5 =D0=BC=D0=BE=D0=
=B3=D1=83=D1=82 =D0=B1=D1=8B=D1=82=D1=8C =D1=80=D0=B5=D1=88=D0=B5=D0=BD=
=D1=8B =D0=B0=D0=B2=D1=82=D0=BE=D0=BC=D0=B0=D1=82=D0=B8=D1=87=D0=B5=D1=81=
=D0=BA=D0=B8"
+
+#: lib/mergetool.tcl:146
+msgid "Conflict file does not exist"
+msgstr "=D0=9A=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=D1=82=D1=83=D1=8E=D1=
=89=D0=B8=D0=B9 =D1=84=D0=B0=D0=B9=D0=BB =D0=BD=D0=B5 =D1=81=D1=83=D1=89=
=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82"
+
+#: lib/mergetool.tcl:264
+#, tcl-format
+msgid "Not a GUI merge tool: '%s'"
+msgstr "'%s' =D0=BD=D0=B5 =D1=8F=D0=B2=D0=BB=D1=8F=D0=B5=D1=82=D1=81=D1=
=8F =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9 =D0=BE=
=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
+
+#: lib/mergetool.tcl:268
+#, tcl-format
+msgid "Unsupported merge tool '%s'"
+msgstr "=D0=9D=D0=B5=D0=B8=D0=B7=D0=B2=D0=B5=D1=81=D1=82=D0=BD=D0=B0=D1=
=8F =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=BE=D0=B1=
=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F '%s'"
+
+#: lib/mergetool.tcl:303
+msgid "Merge tool is already running, terminate it?"
+msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=BE=D0=
=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D1=83=D0=B6=D0=
=B5 =D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=B0=D0=B5=D1=82. =D0=9F=D1=80=D0=B5=
=D1=80=D0=B2=D0=B0=D1=82=D1=8C?"
+
+#: lib/mergetool.tcl:323
+#, tcl-format
+msgid ""
+"Error retrieving versions:\n"
+"%s"
+msgstr ""
+"=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=
=B5=D0=BD=D0=B8=D1=8F =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D0=B9:\n"
+"%s"
+
+#: lib/mergetool.tcl:343
+#, tcl-format
+msgid ""
+"Could not start the merge tool:\n"
+"\n"
+"%s"
+msgstr ""
+"=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B7=D0=B0=D0=BF=D1=83=D1=81=D0=
=BA=D0=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D1=8B =D0=BE=
=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F:\n"
+"\n"
+"%s"
+
+#: lib/mergetool.tcl:347
+msgid "Running merge tool..."
+msgstr "=D0=97=D0=B0=D0=BF=D1=83=D1=81=D0=BA =D0=BF=D1=80=D0=BE=D0=B3=D1=
=80=D0=B0=D0=BC=D0=BC=D1=8B =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=
=B5=D0=BD=D0=B8=D1=8F..."
+
+#: lib/mergetool.tcl:375 lib/mergetool.tcl:383
+msgid "Merge tool failed."
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2=D1=8B=D0=BF=D0=BE=D0=
=BB=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=
=BC=D0=BC=D1=8B =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=
=B8=D1=8F."
+
+#: lib/option.tcl:11
+#, tcl-format
+msgid "Invalid global encoding '%s'"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2 =D0=B3=D0=BB=D0=BE=
=D0=B1=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B9 =D1=83=D1=81=D1=82=D0=B0=D0=BD=
=D0=BE=D0=B2=D0=BA=D0=B5 =D0=BA=D0=BE=D0=B4=D0=B8=D1=80=D0=BE=D0=B2=D0=BA=
=D0=B8 '%s'"
+
+#: lib/option.tcl:19
+#, tcl-format
+msgid "Invalid repo encoding '%s'"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B5 =D0=B2 =D0=BA=D0=BE=D0=B4=
=D0=B8=D1=80=D0=BE=D0=B2=D0=BA=D0=B5 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=
=D1=82=D0=BE=D1=80=D0=B8=D1=8F: '%s'"
+
+#: lib/option.tcl:117
 msgid "Restore Defaults"
 msgstr "=D0=92=D0=BE=D1=81=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=
=82=D1=8C =D0=BD=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8 =D0=BF=
=D0=BE =D1=83=D0=BC=D0=BE=D0=BB=D1=87=D0=B0=D0=BD=D0=B8=D1=8E"
=20
-#: lib/option.tcl:99
+#: lib/option.tcl:121
 msgid "Save"
 msgstr "=D0=A1=D0=BE=D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D1=8C"
=20
-#: lib/option.tcl:109
+#: lib/option.tcl:131
 #, tcl-format
 msgid "%s Repository"
-msgstr "=D0=B4=D0=BB=D1=8F =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=
=BE=D1=80=D0=B8=D1=8F %s"
+msgstr "=D0=94=D0=BB=D1=8F =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=
=BE=D1=80=D0=B8=D1=8F %s"
=20
-#: lib/option.tcl:110
+#: lib/option.tcl:132
 msgid "Global (All Repositories)"
 msgstr "=D0=9E=D0=B1=D1=89=D0=B8=D0=B5 (=D0=B4=D0=BB=D1=8F =D0=B2=D1=81=
=D0=B5=D1=85 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=
=D0=B5=D0=B2)"
=20
-#: lib/option.tcl:116
+#: lib/option.tcl:138
 msgid "User Name"
 msgstr "=D0=98=D0=BC=D1=8F =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=
=B0=D1=82=D0=B5=D0=BB=D1=8F"
=20
-#: lib/option.tcl:117
+#: lib/option.tcl:139
 msgid "Email Address"
 msgstr "=D0=90=D0=B4=D1=80=D0=B5=D1=81 =D1=8D=D0=BB=D0=B5=D0=BA=D1=82=D1=
=80=D0=BE=D0=BD=D0=BD=D0=BE=D0=B9 =D0=BF=D0=BE=D1=87=D1=82=D1=8B"
=20
-#: lib/option.tcl:119
+#: lib/option.tcl:141
 msgid "Summarize Merge Commits"
 msgstr "=D0=A1=D1=83=D0=BC=D0=BC=D0=B0=D1=80=D0=BD=D1=8B=D0=B9 =D0=BA=D0=
=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D0=B9 =D0=BF=D1=80=D0=
=B8 =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B8"
=20
-#: lib/option.tcl:120
+#: lib/option.tcl:142
 msgid "Merge Verbosity"
 msgstr "=D0=A3=D1=80=D0=BE=D0=B2=D0=B5=D0=BD=D1=8C =D0=B4=D0=B5=D1=82=D0=
=B0=D0=BB=D1=8C=D0=BD=D0=BE=D1=81=D1=82=D0=B8 =D1=81=D0=BE=D0=BE=D0=B1=D1=
=89=D0=B5=D0=BD=D0=B8=D0=B9 =D0=BF=D1=80=D0=B8 =D0=BE=D0=B1=D1=8A=D0=B5=
=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D0=B8"
=20
-#: lib/option.tcl:121
+#: lib/option.tcl:143
 msgid "Show Diffstat After Merge"
 msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=BE=D1=82=D1=
=87=D0=B5=D1=82 =D0=BE=D0=B1 =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=
=D0=B8=D1=8F=D1=85 =D0=BF=D0=BE=D1=81=D0=BB=D0=B5 =D0=BE=D0=B1=D1=8A=D0=
=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F"
=20
-#: lib/option.tcl:123
+#: lib/option.tcl:144
+msgid "Use Merge Tool"
+msgstr "=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C =D0=B4=D0=BB=D1=8F =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=
=D0=B5=D0=BD=D0=B8=D1=8F =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=
=D1=83"
+
+#: lib/option.tcl:146
 msgid "Trust File Modification Timestamps"
 msgstr "=D0=94=D0=BE=D0=B2=D0=B5=D1=80=D1=8F=D1=82=D1=8C =D0=B2=D1=80=D0=
=B5=D0=BC=D0=B5=D0=BD=D0=B8 =D0=BC=D0=BE=D0=B4=D0=B8=D1=84=D0=B8=D0=BA=D0=
=B0=D1=86=D0=B8=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0"
=20
-#: lib/option.tcl:124
+#: lib/option.tcl:147
 msgid "Prune Tracking Branches During Fetch"
 msgstr "=D0=A7=D0=B8=D1=81=D1=82=D0=BA=D0=B0 =D0=B2=D0=B5=D1=82=D0=B2=D0=
=B5=D0=B9 =D1=81=D0=BB=D0=B5=D0=B6=D0=B5=D0=BD=D0=B8=D1=8F =D0=BF=D1=80=
=D0=B8 =D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=D0=B8=D0=B8 =D0=B8=D0=
=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9"
=20
-#: lib/option.tcl:125
+#: lib/option.tcl:148
 msgid "Match Tracking Branches"
 msgstr "=D0=98=D0=BC=D1=8F =D0=BD=D0=BE=D0=B2=D0=BE=D0=B9 =D0=B2=D0=B5=
=D1=82=D0=B2=D0=B8 =D0=B2=D0=B7=D1=8F=D1=82=D1=8C =D0=B8=D0=B7 =D0=B8=D0=
=BC=D0=B5=D0=BD =D0=B2=D0=B5=D1=82=D0=B2=D0=B5=D0=B9 =D1=81=D0=BB=D0=B5=
=D0=B6=D0=B5=D0=BD=D0=B8=D1=8F"
=20
-#: lib/option.tcl:126
+#: lib/option.tcl:149
+msgid "Blame Copy Only On Changed Files"
+msgstr "=D0=9F=D0=BE=D0=B8=D1=81=D0=BA =D0=BA=D0=BE=D0=BF=D0=B8=D0=B9 =
=D1=82=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE =D0=B2 =D0=B8=D0=B7=D0=BC=D0=B5=D0=
=BD=D1=91=D0=BD=D0=BD=D1=8B=D1=85 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0=D1=85"
+
+#: lib/option.tcl:150
+msgid "Minimum Letters To Blame Copy On"
+msgstr "=D0=9C=D0=B8=D0=BD=D0=B8=D0=BC=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=
=B5 =D0=BA=D0=BE=D0=BB=D0=B8=D1=87=D0=B5=D1=81=D1=82=D0=B2=D0=BE =D1=81=
=D0=B8=D0=BC=D0=B2=D0=BE=D0=BB=D0=BE=D0=B2 =D0=B4=D0=BB=D1=8F =D0=BF=D0=
=BE=D0=B8=D1=81=D0=BA=D0=B0 =D0=BA=D0=BE=D0=BF=D0=B8=D0=B9"
+
+#: lib/option.tcl:151
+msgid "Blame History Context Radius (days)"
+msgstr "=D0=A0=D0=B0=D0=B7=D0=BC=D0=B5=D1=80 =D0=BA=D0=BE=D0=BD=D1=82=D0=
=B5=D0=BA=D1=81=D1=82=D0=B0 =D0=BF=D1=80=D0=B8 =D0=BF=D0=BE=D0=B8=D1=81=
=D0=BA=D0=B5 =D1=83=D1=87=D0=B0=D1=81=D1=82=D0=BD=D0=B8=D0=BA=D0=BE=D0=B2=
 =D0=BF=D1=80=D0=BE=D0=B5=D0=BA=D1=82=D0=B0 (=D0=B4=D0=BD=D0=B5=D0=B9)"
+
+#: lib/option.tcl:152
 msgid "Number of Diff Context Lines"
 msgstr "=D0=A7=D0=B8=D1=81=D0=BB=D0=BE =D1=81=D1=82=D1=80=D0=BE=D0=BA =
=D0=B2 =D0=BA=D0=BE=D0=BD=D1=82=D0=B5=D0=BA=D1=81=D1=82=D0=B5 diff"
=20
-#: lib/option.tcl:127
+#: lib/option.tcl:153
 msgid "Commit Message Text Width"
-msgstr "=D0=A8=D0=B8=D1=80=D0=B8=D0=BD=D0=B0 =D0=BA=D0=BE=D0=BC=D0=BC=D0=
=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D1=8F =D0=BA =D1=81=D0=BE=D1=81=D1=82=
=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E:"
+msgstr "=D0=A8=D0=B8=D1=80=D0=B8=D0=BD=D0=B0 =D1=82=D0=B5=D0=BA=D1=81=D1=
=82=D0=B0 =D0=BA=D0=BE=D0=BC=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=80=D0=B8=D1=
=8F"
=20
-#: lib/option.tcl:128
+#: lib/option.tcl:154
 msgid "New Branch Name Template"
 msgstr "=D0=A8=D0=B0=D0=B1=D0=BB=D0=BE=D0=BD =D0=B4=D0=BB=D1=8F =D0=B8=
=D0=BC=D0=B5=D0=BD=D0=B8 =D0=BD=D0=BE=D0=B2=D0=BE=D0=B9 =D0=B2=D0=B5=D1=
=82=D0=B2=D0=B8"
=20
-#: lib/option.tcl:192
+#: lib/option.tcl:155
+msgid "Default File Contents Encoding"
+msgstr "=D0=9A=D0=BE=D0=B4=D0=B8=D1=80=D0=BE=D0=B2=D0=BA=D0=B0 =D1=81=D0=
=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B0=D0=BD=D0=B8=D1=8F =D1=84=D0=B0=D0=B9=D0=
=BB=D0=B0 =D0=BF=D0=BE =D1=83=D0=BC=D0=BE=D0=BB=D1=87=D0=B0=D0=BD=D0=B8=
=D1=8E"
+
+#: lib/option.tcl:203
+msgid "Change"
+msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C"
+
+#: lib/option.tcl:230
 msgid "Spelling Dictionary:"
 msgstr "=D0=A1=D0=BB=D0=BE=D0=B2=D0=B0=D1=80=D1=8C =D0=B4=D0=BB=D1=8F =
=D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B8 =D0=BF=D1=80=D0=B0=D0=B2=
=D0=BE=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=D1=8F:"
=20
-#: lib/option.tcl:216
+#: lib/option.tcl:254
 msgid "Change Font"
-msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C =D1=88=D1=80=D0=
=B8=D1=84=D1=82"
+msgstr "=D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D0=B8=D1=82=D1=8C"
=20
-#: lib/option.tcl:220
+#: lib/option.tcl:258
 #, tcl-format
 msgid "Choose %s"
 msgstr "=D0=92=D1=8B=D0=B1=D0=B5=D1=80=D0=B8=D1=82=D0=B5 %s"
=20
 # carbon copy
-#: lib/option.tcl:226
+#: lib/option.tcl:264
 msgid "pt."
-msgstr ""
+msgstr "pt."
=20
-#: lib/option.tcl:240
+#: lib/option.tcl:278
 msgid "Preferences"
 msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8"
=20
-#: lib/option.tcl:275
+#: lib/option.tcl:314
 msgid "Failed to completely save options:"
 msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=BF=
=D0=BE=D0=BB=D0=BD=D0=BE=D1=81=D1=82=D1=8C=D1=8E =D1=81=D0=BE=D1=85=D1=80=
=D0=B0=D0=BD=D0=B8=D1=82=D1=8C =D0=BD=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=
=D0=BA=D0=B8:"
=20
+#: lib/remote.tcl:163
+msgid "Remove Remote"
+msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C =D1=81=D1=81=D1=8B=D0=
=BB=D0=BA=D1=83 =D0=BD=D0=B0 =D0=B2=D0=BD=D0=B5=D1=88=D0=BD=D0=B8=D0=B9=
 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9"
+
+#: lib/remote.tcl:168
+msgid "Prune from"
+msgstr "=D0=A7=D0=B8=D1=81=D1=82=D0=BA=D0=B0"
+
+#: lib/remote.tcl:173
+msgid "Fetch from"
+msgstr "=D0=9F=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B8=D0=
=B7"
+
+#: lib/remote.tcl:215
+msgid "Push to"
+msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C"
+
+#: lib/remote_add.tcl:19
+msgid "Add Remote"
+msgstr "=D0=97=D0=B0=D1=80=D0=B5=D0=B3=D0=B8=D1=81=D1=82=D1=80=D0=B8=D1=
=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D0=B2=D0=BD=D0=B5=D1=88=D0=BD=D0=B8=D0=
=B9 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9"
+
+#: lib/remote_add.tcl:24
+msgid "Add New Remote"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=B2=D0=BD=D0=
=B5=D1=88=D0=BD=D0=B8=D0=B9 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=
=BE=D1=80=D0=B8=D0=B9"
+
+#: lib/remote_add.tcl:28 lib/tools_dlg.tcl:36
+msgid "Add"
+msgstr ""
+
+#: lib/remote_add.tcl:37
+msgid "Remote Details"
+msgstr "=D0=98=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=
=BE =D0=B2=D0=BD=D0=B5=D1=88=D0=BD=D0=B5=D0=BC =D1=80=D0=B5=D0=BF=D0=BE=
=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B8"
+
+#: lib/remote_add.tcl:50
+msgid "Location:"
+msgstr "=D0=9F=D0=BE=D0=BB=D0=BE=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5:"
+
+#: lib/remote_add.tcl:62
+msgid "Further Action"
+msgstr "=D0=A1=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B0=D1=8F =D0=BE=D0=
=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D1=8F"
+
+#: lib/remote_add.tcl:65
+msgid "Fetch Immediately"
+msgstr "=D0=A1=D0=BA=D0=B0=D1=87=D0=B0=D1=82=D1=8C =D1=81=D1=80=D0=B0=D0=
=B7=D1=83"
+
+#: lib/remote_add.tcl:71
+msgid "Initialize Remote Repository and Push"
+msgstr "=D0=98=D0=BD=D0=B8=D1=86=D0=B8=D0=B0=D0=BB=D0=B8=D0=B7=D0=B8=D1=
=80=D0=BE=D0=B2=D0=B0=D1=82=D1=8C =D0=B2=D0=BD=D0=B5=D1=88=D0=BD=D0=B8=D0=
=B9 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B9 =
=D0=B8 =D0=BE=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C"
+
+#: lib/remote_add.tcl:77
+msgid "Do Nothing Else Now"
+msgstr "=D0=91=D0=BE=D0=BB=D1=8C=D1=88=D0=B5 =D0=BD=D0=B8=D1=87=D0=B5=D0=
=B3=D0=BE =D0=BD=D0=B5 =D0=B4=D0=B5=D0=BB=D0=B0=D1=82=D1=8C"
+
+#: lib/remote_add.tcl:101
+msgid "Please supply a remote name."
+msgstr "=D0=A3=D0=BA=D0=B0=D0=B6=D0=B8=D1=82=D0=B5 =D0=BD=D0=B0=D0=B7=D0=
=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D0=B2=D0=BD=D0=B5=D1=88=D0=BD=D0=B5=D0=B3=D0=
=BE =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F.=
"
+
+#: lib/remote_add.tcl:114
+#, tcl-format
+msgid "'%s' is not an acceptable remote name."
+msgstr "=D0=9D=D0=B5=D0=B4=D0=BE=D0=BF=D1=83=D1=81=D1=82=D0=B8=D0=BC=D0=
=BE=D0=B5 =D0=BD=D0=B0=D0=B7=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D0=B2=D0=BD=
=D0=B5=D1=88=D0=BD=D0=B5=D0=B3=D0=BE =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=
=D1=82=D0=BE=D1=80=D0=B8=D1=8F '%s'."
+
+#: lib/remote_add.tcl:125
+#, tcl-format
+msgid "Failed to add remote '%s' of location '%s'."
+msgstr "=D0=9D=D0=B5 =D1=83=D0=B4=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=B4=
=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C '%s' =D0=B8=D0=B7 '%s'. "
+
+#: lib/remote_add.tcl:133 lib/transport.tcl:6
+#, tcl-format
+msgid "fetch %s"
+msgstr "=D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 %s"
+
+#: lib/remote_add.tcl:134
+#, tcl-format
+msgid "Fetching the %s"
+msgstr "=D0=9F=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 %s"
+
+#: lib/remote_add.tcl:157
+#, tcl-format
+msgid "Do not know how to initialize repository at location '%s'."
+msgstr "=D0=9D=D0=B5=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D0=
=B8=D0=BD=D0=B8=D1=86=D0=B8=D0=B0=D0=BB=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9 =D0=B2 '%s'."
+
+#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:63
+#: lib/transport.tcl:81
+#, tcl-format
+msgid "push %s"
+msgstr "=D0=BE=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C %s"
+
+#: lib/remote_add.tcl:164
+#, tcl-format
+msgid "Setting up the %s (at %s)"
+msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B0 %s (=D0=
=B2 %s)"
+
 #: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
-msgid "Delete Remote Branch"
-msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C =D0=B2=D0=BD=D0=B5=D1=
=88=D0=BD=D1=8E=D1=8E =D0=B2=D0=B5=D1=82=D0=B2=D1=8C"
+msgid "Delete Branch Remotely"
+msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B2=D0=B5=D1=
=82=D0=B2=D0=B8 =D0=B2=D0=BE =D0=B2=D0=BD=D0=B5=D1=88=D0=BD=D0=B5=D0=BC=
 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=B8"
=20
 #: lib/remote_branch_delete.tcl:47
 msgid "From Repository"
 msgstr "=D0=98=D0=B7 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=
=80=D0=B8=D1=8F"
=20
-#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:123
+#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:134
 msgid "Remote:"
 msgstr "=D0=B2=D0=BD=D0=B5=D1=88=D0=BD=D0=B8=D0=B9:"
=20
-#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:138
-msgid "Arbitrary URL:"
-msgstr "=D0=BF=D0=BE =D1=83=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=BD=D0=BE=D0=
=BC=D1=83 URL:"
+#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:149
+msgid "Arbitrary Location:"
+msgstr "=D0=A3=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=BE=D0=B5 =D0=BF=D0=BE=D0=
=BB=D0=BE=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5:"
=20
 #: lib/remote_branch_delete.tcl:84
 msgid "Branches"
@@ -1794,6 +2204,7 @@ msgid ""
 " - %s"
 msgstr ""
 "=D0=A1=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B8=D0=B5 =D0=B2=D0=B5=D1=
=82=D0=B2=D0=B8 =D0=BE=D0=B1=D1=8A=D0=B5=D0=B4=D0=B8=D0=BD=D0=B5=D0=BD=D1=
=8B =D1=81 %s =D0=BD=D0=B5 =D0=BF=D0=BE=D0=BB=D0=BD=D0=BE=D1=81=D1=82=D1=
=8C=D1=8E:\n"
+"\n"
 " - %s"
=20
 #: lib/remote_branch_delete.tcl:189
@@ -1833,17 +2244,21 @@ msgstr "=D0=9D=D0=B5 =D1=83=D0=BA=D0=B0=D0=B7=D0=
=B0=D0=BD =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9."
 msgid "Scanning %s..."
 msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D1=87=D0=B8=D1=82=D1=8B=D0=B2=D0=B0=D0=
=BD=D0=B8=D0=B5 %s... "
=20
-#: lib/remote.tcl:165
-msgid "Prune from"
-msgstr "=D0=A7=D0=B8=D1=81=D1=82=D0=BA=D0=B0"
+#: lib/search.tcl:21
+msgid "Find:"
+msgstr "=D0=9F=D0=BE=D0=B8=D1=81=D0=BA:"
=20
-#: lib/remote.tcl:170
-msgid "Fetch from"
-msgstr "=D0=9F=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 =D0=B8=D0=
=B7"
+#: lib/search.tcl:23
+msgid "Next"
+msgstr "=D0=94=D0=B0=D0=BB=D1=8C=D1=88=D0=B5"
=20
-#: lib/remote.tcl:213
-msgid "Push to"
-msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C"
+#: lib/search.tcl:24
+msgid "Prev"
+msgstr "=D0=9E=D0=B1=D1=80=D0=B0=D1=82=D0=BD=D0=BE"
+
+#: lib/search.tcl:25
+msgid "Case-Sensitive"
+msgstr "=D0=98=D0=B3=D0=BD. =D0=B1=D0=BE=D0=BB=D1=8C=D1=88=D0=B8=D0=B5=
/=D0=BC=D0=B0=D0=BB=D0=B5=D0=BD=D1=8C=D0=BA=D0=B8=D0=B5"
=20
 #: lib/shortcut.tcl:20 lib/shortcut.tcl:61
 msgid "Cannot write shortcut:"
@@ -1878,27 +2293,192 @@ msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=
=BC=D0=BC=D0=B0 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B8 =D0=BF=
=D1=80=D0=B0=D0=B2=D0=BE=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=D1=8F =D0=BD=
=D0=B5 =D1=81=D0=BC=D0=BE
 msgid "Unrecognized spell checker"
 msgstr "=D0=9D=D0=B5=D1=80=D0=B0=D1=81=D0=BF=D0=BE=D0=B7=D0=BD=D0=B0=D0=
=BD=D0=B0=D1=8F =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =
=D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B8 =D0=BF=D1=80=D0=B0=D0=B2=
=D0=BE=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=D1=8F"
=20
-#: lib/spellcheck.tcl:180
+#: lib/spellcheck.tcl:186
 msgid "No Suggestions"
 msgstr "=D0=98=D1=81=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=
=B9 =D0=BD=D0=B5 =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=BD=D0=BE"
=20
-#: lib/spellcheck.tcl:381
+#: lib/spellcheck.tcl:388
 msgid "Unexpected EOF from spell checker"
 msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=BF=D1=
=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B8 =D0=BF=D1=80=D0=B0=D0=B2=D0=BE=D0=
=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B8=D1=8F =D0=BF=D1=80=D0=B5=D1=80=D0=B2=D0=
=B0=D0=BB=D0=B0 =D0=BF=D0=B5=D1=80=D0=B5=D0=B4=D0=B0=D1=87=D1=83 =D0=B4=
=D0=B0=D0=BD=D0=BD=D1=8B=D1=85"
=20
-#: lib/spellcheck.tcl:385
+#: lib/spellcheck.tcl:392
 msgid "Spell Checker Failed"
 msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=BF=D1=80=D0=BE=D0=B2=D0=
=B5=D1=80=D0=BA=D0=B8 =D0=BF=D1=80=D0=B0=D0=B2=D0=BE=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BD=D0=B8=D1=8F"
=20
+#: lib/sshkey.tcl:31
+msgid "No keys found."
+msgstr "=D0=9A=D0=BB=D1=8E=D1=87 =D0=BD=D0=B5 =D0=BD=D0=B0=D0=B9=D0=B4=
=D0=B5=D0=BD"
+
+#: lib/sshkey.tcl:34
+#, tcl-format
+msgid "Found a public key in: %s"
+msgstr "=D0=9F=D1=83=D0=B1=D0=BB=D0=B8=D1=87=D0=BD=D1=8B=D0=B9 =D0=BA=D0=
=BB=D1=8E=D1=87 =D0=B8=D0=B7 %s"
+
+#: lib/sshkey.tcl:40
+msgid "Generate Key"
+msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D0=BA=D0=BB=D1=8E=D1=
=87"
+
+#: lib/sshkey.tcl:56
+msgid "Copy To Clipboard"
+msgstr "=D0=A1=D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D0=BE=D0=B2=D0=B0=D1=82=D1=
=8C =D0=B2 =D0=B1=D1=83=D1=84=D0=B5=D1=80 =D0=BE=D0=B1=D0=BC=D0=B5=D0=BD=
=D0=B0"
+
+#: lib/sshkey.tcl:70
+msgid "Your OpenSSH Public Key"
+msgstr "=D0=92=D0=B0=D1=88 =D0=BF=D1=83=D0=B1=D0=BB=D0=B8=D1=87=D0=BD=D1=
=8B=D0=B9 =D0=BA=D0=BB=D1=8E=D1=87 OpenSSH"
+
+#: lib/sshkey.tcl:78
+msgid "Generating..."
+msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=B8=D0=B5..."
+
+#: lib/sshkey.tcl:84
+#, tcl-format
+msgid ""
+"Could not start ssh-keygen:\n"
+"\n"
+"%s"
+msgstr ""
+"=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B7=D0=B0=D0=BF=D1=83=D1=81=D0=
=BA=D0=B0 ssh-keygen:\n"
+"\n"
+"%s"
+
+#: lib/sshkey.tcl:111
+msgid "Generation failed."
+msgstr "=D0=9A=D0=BB=D1=8E=D1=87 =D0=BD=D0=B5 =D1=81=D0=BE=D0=B7=D0=B4=
=D0=B0=D0=BD."
+
+#: lib/sshkey.tcl:118
+msgid "Generation succeded, but no keys found."
+msgstr "=D0=A1=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=B8=D0=B5 =D0=BA=D0=BB=D1=
=8E=D1=87=D0=B0 =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=D0=B8=D0=BB=D0=BE=D1=
=81=D1=8C, =D0=BD=D0=BE =D1=80=D0=B5=D0=B7=D1=83=D0=BB=D1=8C=D1=82=D0=B0=
=D1=82 =D0=BD=D0=B5 =D0=B1=D1=8B=D0=BB =D0=BD=D0=B0=D0=B9=D0=B4=D0=B5=D0=
=BD"
+
+#: lib/sshkey.tcl:121
+#, tcl-format
+msgid "Your key is in: %s"
+msgstr "=D0=92=D0=B0=D1=88 =D0=BA=D0=BB=D1=8E=D1=87 =D0=BD=D0=B0=D1=85=
=D0=BE=D0=B4=D0=B8=D1=82=D1=81=D1=8F =D0=B2: %s"
+
 #: lib/status_bar.tcl:83
 #, tcl-format
 msgid "%s ... %*i of %*i %s (%3i%%)"
 msgstr "%s ... %*i =D0=B8=D0=B7 %*i %s (%3i%%)"
=20
-#: lib/transport.tcl:6
+#: lib/tools.tcl:75
 #, tcl-format
-msgid "fetch %s"
-msgstr "=D0=BF=D0=BE=D0=BB=D1=83=D1=87=D0=B5=D0=BD=D0=B8=D0=B5 %s"
+msgid "Running %s requires a selected file."
+msgstr "=D0=97=D0=B0=D0=BF=D1=83=D1=81=D0=BA %s =D1=82=D1=80=D0=B5=D0=B1=
=D1=83=D0=B5=D1=82 =D0=B2=D1=8B=D0=B1=D1=80=D0=B0=D0=BD=D0=BD=D0=BE=D0=B3=
=D0=BE =D1=84=D0=B0=D0=B9=D0=BB=D0=B0."
+
+#: lib/tools.tcl:90
+#, tcl-format
+msgid "Are you sure you want to run %s?"
+msgstr "=D0=94=D0=B5=D0=B9=D1=81=D1=82=D0=B2=D0=B8=D1=82=D0=B5=D0=BB=D1=
=8C=D0=BD=D0=BE =D0=B7=D0=B0=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=8C =
%s?"
+
+#: lib/tools.tcl:110
+#, tcl-format
+msgid "Tool: %s"
+msgstr "=D0=92=D1=81=D0=BF=D0=BE=D0=BC=D0=BE=D0=B3=D0=B0=D1=82=D0=B5=D0=
=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=
=BC=D0=B0: %s"
+
+#: lib/tools.tcl:111
+#, tcl-format
+msgid "Running: %s"
+msgstr "=D0=92=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=D0=B5=D0=BD=D0=B8=D0=B5: =
%s"
+
+#: lib/tools.tcl:149
+#, tcl-format
+msgid "Tool completed succesfully: %s"
+msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 %s =D1=83=
=D1=81=D0=BF=D0=B5=D1=88=D0=BD=D0=BE =D0=B7=D0=B0=D0=B2=D0=B5=D1=80=D1=88=
=D0=B8=D0=BB=D0=B0=D1=81=D1=8C."
+
+#: lib/tools.tcl:151
+#, tcl-format
+msgid "Tool failed: %s"
+msgstr "=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B2=D1=8B=D0=BF=D0=BE=D0=
=BB=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=
=BC=D0=BC=D1=8B: %s"
+
+#: lib/tools_dlg.tcl:22
+msgid "Add Tool"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=B2=D1=81=D0=
=BF=D0=BE=D0=BC=D0=BE=D0=B3=D0=B0=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D1=83=D1=
=8E =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D1=83"
+
+#: lib/tools_dlg.tcl:28
+msgid "Add New Tool Command"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=BD=D0=BE=D0=
=B2=D1=83=D1=8E =D0=B2=D1=81=D0=BF=D0=BE=D0=BC=D0=BE=D0=B3=D0=B0=D1=82=D0=
=B5=D0=BB=D1=8C=D0=BD=D1=83=D1=8E =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D1=
=83"
+
+#: lib/tools_dlg.tcl:33
+msgid "Add globally"
+msgstr "=D0=94=D0=BE=D0=B1=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=B4=D0=BB=D1=
=8F =D0=B2=D1=81=D0=B5=D1=85 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=
=D0=BE=D1=80=D0=B8=D0=B5=D0=B2"
+
+#: lib/tools_dlg.tcl:45
+msgid "Tool Details"
+msgstr "=D0=94=D0=B5=D1=82=D0=B0=D0=BB=D0=B8 =D0=B2=D1=81=D0=BF=D0=BE=D0=
=BC=D0=BE=D0=B3=D0=B0=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE=D0=B9 =D0=BF=D1=
=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D1=8B"
+
+#: lib/tools_dlg.tcl:48
+msgid "Use '/' separators to create a submenu tree:"
+msgstr "=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D1=83=D0=B9=D1=82=D0=B5 '=
/' =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=B8=D1=8F =
=D0=BF=D0=BE=D0=B4=D0=BC=D0=B5=D0=BD=D1=8E"
+
+#: lib/tools_dlg.tcl:61
+msgid "Command:"
+msgstr "=D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0:"
+
+#: lib/tools_dlg.tcl:74
+msgid "Show a dialog before running"
+msgstr "=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B4=D0=B8=D0=
=B0=D0=BB=D0=BE=D0=B3 =D0=BF=D0=B5=D1=80=D0=B5=D0=B4 =D0=B7=D0=B0=D0=BF=
=D1=83=D1=81=D0=BA=D0=BE=D0=BC"
+
+#: lib/tools_dlg.tcl:80
+msgid "Ask the user to select a revision (sets $REVISION)"
+msgstr "=D0=97=D0=B0=D0=BF=D1=80=D0=BE=D1=81 =D0=BD=D0=B0 =D0=B2=D1=8B=
=D0=B1=D0=BE=D1=80 =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D0=B8 (=D1=83=D1=81=D1=
=82=D0=B0=D0=BD=D0=B0=D0=B2=D0=BB=D0=B8=D0=B2=D0=B0=D0=B5=D1=82 $REVISI=
ON)"
+
+#: lib/tools_dlg.tcl:85
+msgid "Ask the user for additional arguments (sets $ARGS)"
+msgstr "=D0=97=D0=B0=D0=BF=D1=80=D0=BE=D1=81 =D0=B4=D0=BE=D0=BF=D0=BE=D0=
=BB=D0=BD=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D1=8B=D1=85 =D0=B0=D1=80=D0=
=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=BE=D0=B2 (=D1=83=D1=81=D1=82=D0=B0=
=D0=BD=D0=B0=D0=B2=D0=BB=D0=B8=D0=B2=D0=B0=D0=B5=D1=82 $ARGS)"
+
+#: lib/tools_dlg.tcl:92
+msgid "Don't show the command output window"
+msgstr "=D0=9D=D0=B5 =D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D1=8B=D0=B2=D0=B0=D1=
=82=D1=8C =D0=BE=D0=BA=D0=BD=D0=BE =D0=B2=D1=8B=D0=B2=D0=BE=D0=B4=D0=B0=
 =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D1=8B"
+
+#: lib/tools_dlg.tcl:97
+msgid "Run only if a diff is selected ($FILENAME not empty)"
+msgstr "=D0=97=D0=B0=D0=BF=D1=83=D1=81=D0=BA =D1=82=D0=BE=D0=BB=D1=8C=D0=
=BA=D0=BE =D0=B5=D1=81=D0=BB=D0=B8 =D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=
=D0=BD =D1=81=D0=BF=D0=B8=D1=81=D0=BE=D0=BA =D0=B8=D0=B7=D0=BC=D0=B5=D0=
=BD=D0=B5=D0=BD=D0=B8=D0=B9 ($FILENAME =D0=BD=D0=B5 =D0=BF=D1=83=D1=81=D1=
=82=D0=BE)"
+
+#: lib/tools_dlg.tcl:121
+msgid "Please supply a name for the tool."
+msgstr "=D0=A3=D0=BA=D0=B0=D0=B6=D0=B8=D1=82=D0=B5 =D0=BD=D0=B0=D0=B7=D0=
=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D0=B2=D1=81=D0=BF=D0=BE=D0=BC=D0=BE=D0=B3=D0=
=B0=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE=D0=B9 =D0=BF=D1=80=D0=BE=D0=B3=D1=
=80=D0=B0=D0=BC=D0=BC=D1=8B."
+
+#: lib/tools_dlg.tcl:129
+#, tcl-format
+msgid "Tool '%s' already exists."
+msgstr "=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 '%s' =D1=
=83=D0=B6=D0=B5 =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=
=82."
+
+#: lib/tools_dlg.tcl:151
+#, tcl-format
+msgid ""
+"Could not add tool:\n"
+"%s"
+msgstr ""
+"=D0=9E=D1=88=D0=B8=D0=B1=D0=BA=D0=B0 =D0=B4=D0=BE=D0=B1=D0=B0=D0=B2=D0=
=BB=D0=B5=D0=BD=D0=B8=D1=8F =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=
=BC=D1=8B:\n"
+"%s"
+
+#: lib/tools_dlg.tcl:190
+msgid "Remove Tool"
+msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C =D0=BF=D1=80=D0=BE=D0=
=B3=D1=80=D0=B0=D0=BC=D0=BC=D1=83"
+
+#: lib/tools_dlg.tcl:196
+msgid "Remove Tool Commands"
+msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C =D0=BA=D0=BE=D0=BC=D0=
=B0=D0=BD=D0=B4=D1=8B =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D1=
=8B"
+
+#: lib/tools_dlg.tcl:200
+msgid "Remove"
+msgstr "=D0=A3=D0=B4=D0=B0=D0=BB=D0=B8=D1=82=D1=8C"
+
+#: lib/tools_dlg.tcl:236
+msgid "(Blue denotes repository-local tools)"
+msgstr "(=D0=A1=D0=B8=D0=BD=D0=B8=D0=B9 =D1=83=D0=BA=D0=B0=D0=B7=D1=8B=
=D0=B2=D0=B0=D0=B5=D1=82 =D0=BD=D0=B0 =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=
=B0=D0=BC=D0=BC=D1=8B =D1=82=D0=BE=D0=BB=D1=8C=D0=BA=D0=BE =D1=80=D0=B5=
=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D1=8F)"
+
+#: lib/tools_dlg.tcl:297
+#, tcl-format
+msgid "Run Command: %s"
+msgstr "=D0=97=D0=B0=D0=BF=D1=83=D1=81=D0=BA =D0=BA=D0=BE=D0=BC=D0=B0=D0=
=BD=D0=B4=D1=8B: %s"
+
+#: lib/tools_dlg.tcl:311
+msgid "Arguments"
+msgstr "=D0=90=D1=80=D0=B3=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D1=8B"
+
+#: lib/tools_dlg.tcl:348
+msgid "OK"
+msgstr "OK"
=20
 #: lib/transport.tcl:7
 #, tcl-format
@@ -1916,48 +2496,46 @@ msgstr "=D1=87=D0=B8=D1=81=D1=82=D0=BA=D0=B0 =D0=
=B2=D0=BD=D0=B5=D1=88=D0=BD=D0=B5=D0=B3=D0=BE %s"
 msgid "Pruning tracking branches deleted from %s"
 msgstr "=D0=A7=D0=B8=D1=81=D1=82=D0=BA=D0=B0 =D0=B2=D0=B5=D1=82=D0=B2=D0=
=B5=D0=B9 =D1=81=D0=BB=D0=B5=D0=B6=D0=B5=D0=BD=D0=B8=D1=8F, =D1=83=D0=B4=
=D0=B0=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D1=85 =D0=B8=D0=B7 %s"
=20
-#: lib/transport.tcl:25 lib/transport.tcl:71
-#, tcl-format
-msgid "push %s"
-msgstr "=D0=BE=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C %s"
-
 #: lib/transport.tcl:26
 #, tcl-format
 msgid "Pushing changes to %s"
 msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BA=D0=B0 =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=B2 %s "
=20
-#: lib/transport.tcl:72
+#: lib/transport.tcl:64
+#, tcl-format
+msgid "Mirroring to %s"
+msgstr "=D0=A2=D0=BE=D1=87=D0=BD=D0=BE=D0=B5 =D0=BA=D0=BE=D0=BF=D0=B8=D1=
=80=D0=BE=D0=B2=D0=B0=D0=BD=D0=B8=D0=B5 =D0=B2 %s"
+
+#: lib/transport.tcl:82
 #, tcl-format
 msgid "Pushing %s %s to %s"
 msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BA=D0=B0 %s %s =D0=B2 =
%s"
=20
-#: lib/transport.tcl:89
+#: lib/transport.tcl:100
 msgid "Push Branches"
 msgstr "=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D1=82=D1=8C =D0=B8=D0=
=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D1=8F =D0=B2 =D0=B2=D0=B5=D1=82=
=D0=B2=D1=8F=D1=85"
=20
-#: lib/transport.tcl:103
+#: lib/transport.tcl:114
 msgid "Source Branches"
 msgstr "=D0=98=D1=81=D1=85=D0=BE=D0=B4=D0=BD=D1=8B=D0=B5 =D0=B2=D0=B5=D1=
=82=D0=B2=D0=B8"
=20
-#: lib/transport.tcl:120
+#: lib/transport.tcl:131
 msgid "Destination Repository"
 msgstr "=D0=A0=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=82=D0=BE=D1=80=D0=B8=D0=
=B9 =D0=BD=D0=B0=D0=B7=D0=BD=D0=B0=D1=87=D0=B5=D0=BD=D0=B8=D1=8F"
=20
-#: lib/transport.tcl:158
+#: lib/transport.tcl:169
 msgid "Transfer Options"
 msgstr "=D0=9D=D0=B0=D1=81=D1=82=D1=80=D0=BE=D0=B9=D0=BA=D0=B8 =D0=BE=D1=
=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BA=D0=B8"
=20
-#: lib/transport.tcl:160
+#: lib/transport.tcl:171
 msgid "Force overwrite existing branch (may discard changes)"
 msgstr "=D0=9D=D0=B0=D0=BC=D0=B5=D1=80=D0=B5=D0=BD=D0=BD=D0=BE =D0=BF=D0=
=B5=D1=80=D0=B5=D0=BF=D0=B8=D1=81=D0=B0=D1=82=D1=8C =D1=81=D1=83=D1=89=D0=
=B5=D1=81=D1=82=D0=B2=D1=83=D1=8E=D1=89=D1=83=D1=8E =D0=B2=D0=B5=D1=82=D0=
=B2=D1=8C (=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD=D0=B0 =D0=BF=D0=BE=
=D1=82=D0=B5=D1=80=D1=8F =D0=B8=D0=B7=D0=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=
=D0=B9)"
=20
-#: lib/transport.tcl:164
+#: lib/transport.tcl:175
 msgid "Use thin pack (for slow network connections)"
 msgstr "=D0=98=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=
=82=D1=8C thin pack (=D0=B4=D0=BB=D1=8F =D0=BC=D0=B5=D0=B4=D0=BB=D0=B5=D0=
=BD=D0=BD=D1=8B=D1=85 =D1=81=D0=B5=D1=82=D0=B5=D0=B2=D1=8B=D1=85 =D0=BF=
=D0=BE=D0=B4=D0=BA=D0=BB=D1=8E=D1=87=D0=B5=D0=BD=D0=B8=D0=B9)"
=20
-#: lib/transport.tcl:168
+#: lib/transport.tcl:179
 msgid "Include tags"
-msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B4=D0=B0=D1=82=D1=8C =D1=82=D0=B0=D0=
=B3=D0=B8"
+msgstr "=D0=9F=D0=B5=D1=80=D0=B5=D0=B4=D0=B0=D1=82=D1=8C =D0=BC=D0=B5=D1=
=82=D0=BA=D0=B8"
=20
-#~ msgid "Next >"
-#~ msgstr "=D0=94=D0=B0=D0=BB=D1=8C=D1=88=D0=B5 >"
--=20
1.6.3.rc1.74.g42ff
