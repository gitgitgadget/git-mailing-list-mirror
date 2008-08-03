From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@lavabit.com>
Subject: [PATCH] git-gui: update Japanese translation
Date: Sun, 3 Aug 2008 17:01:50 +0900
Message-ID: <20080803170150.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 03 10:03:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPYZ1-0005sn-4u
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 10:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756759AbYHCICZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Aug 2008 04:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756743AbYHCICZ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 04:02:25 -0400
Received: from karen.lavabit.com ([72.249.41.33]:48556 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754282AbYHCICU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 04:02:20 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 8CA3DC8406;
	Sun,  3 Aug 2008 03:02:10 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id MZIVUX7104HI; Sun, 03 Aug 2008 03:02:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=ZbFGF0euHx/vdP6LoCG/l1CbkwwKj3xO5DrcrtesE54aS830eVHU3WKCWyXyzIU4QAdL4InTx6FYk24xjpJL0U5b1u1MvScbbzCAxJv7WqwAugUzQg76d7ymLFpso0lD/QXceYBRI+aZQa0zBS/L5fTtCxiPu5Cy4PN2GBvKBw4=;
  h=From:Date:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91214>

This updates Japanese translation to match the updated git-gui.pot.

Signed-off-by: =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=
=81=93 <nanako3@lavabit.com>
---
 po/ja.po |  527 +++++++++++++++++++++++++++++++++---------------------=
--------
 1 files changed, 281 insertions(+), 246 deletions(-)

diff --git a/po/ja.po b/po/ja.po
index 28e6d62..5db44a4 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -8,41 +8,41 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-03-14 07:18+0100\n"
-"PO-Revision-Date: 2008-03-15 20:12+0900\n"
-"Last-Translator: =E3=81=97=E3=82=89=E3=81=84=E3=81=97 =E3=81=AA=E3=81=
=AA=E3=81=93 <nanako3@bluebottle.com>\n"
+"POT-Creation-Date: 2008-08-02 14:45-0700\n"
+"PO-Revision-Date: 2008-08-03 17:00+0900\n"
+"Last-Translator: =E3=81=97=E3=82=89=E3=81=84=E3=81=97 =E3=81=AA=E3=81=
=AA=E3=81=93 <nanako3@lavabit.com>\n"
 "Language-Team: Japanese\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
-#: git-gui.sh:41 git-gui.sh:634 git-gui.sh:648 git-gui.sh:661 git-gui.=
sh:744
-#: git-gui.sh:763
+#: git-gui.sh:41 git-gui.sh:688 git-gui.sh:702 git-gui.sh:715 git-gui.=
sh:798
+#: git-gui.sh:817
 msgid "git-gui: fatal error"
 msgstr "git-gui: =E8=87=B4=E5=91=BD=E7=9A=84=E3=81=AA=E3=82=A8=E3=83=A9=
=E3=83=BC"
=20
-#: git-gui.sh:593
+#: git-gui.sh:644
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr "%s =E3=81=AB=E7=84=A1=E5=8A=B9=E3=81=AA=E3=83=95=E3=82=A9=E3=83=
=B3=E3=83=88=E3=81=8C=E6=8C=87=E5=AE=9A=E3=81=95=E3=82=8C=E3=81=A6=E3=81=
=84=E3=81=BE=E3=81=99:"
=20
-#: git-gui.sh:620
+#: git-gui.sh:674
 msgid "Main Font"
 msgstr "=E4=B8=BB=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88"
=20
-#: git-gui.sh:621
+#: git-gui.sh:675
 msgid "Diff/Console Font"
 msgstr "diff/=E3=82=B3=E3=83=B3=E3=82=BD=E3=83=BC=E3=83=AB=E3=83=BB=E3=
=83=95=E3=82=A9=E3=83=B3=E3=83=88"
=20
-#: git-gui.sh:635
+#: git-gui.sh:689
 msgid "Cannot find git in PATH."
 msgstr "PATH =E4=B8=AD=E3=81=AB git =E3=81=8C=E8=A6=8B=E3=81=A4=E3=81=8B=
=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93"
=20
-#: git-gui.sh:662
+#: git-gui.sh:716
 msgid "Cannot parse Git version string:"
 msgstr "Git =E3=83=90=E3=83=BC=E3=82=B8=E3=83=A7=E3=83=B3=E5=90=8D=E3=81=
=8C=E7=90=86=E8=A7=A3=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93:"
=20
-#: git-gui.sh:680
+#: git-gui.sh:734
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -61,380 +61,381 @@ msgstr ""
 "\n"
 "'%s' =E3=81=AF=E3=83=90=E3=83=BC=E3=82=B8=E3=83=A7=E3=83=B3 1.5.0 =E3=
=81=A8=E6=80=9D=E3=81=A3=E3=81=A6=E8=89=AF=E3=81=84=E3=81=A7=E3=81=99=E3=
=81=8B=EF=BC=9F\n"
=20
-#: git-gui.sh:918
+#: git-gui.sh:972
 msgid "Git directory not found:"
 msgstr "Git =E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=E3=83=AA=E3=81=
=8C=E8=A6=8B=E3=81=A4=E3=81=8B=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93:"
=20
-#: git-gui.sh:925
+#: git-gui.sh:979
 msgid "Cannot move to top of working directory:"
 msgstr "=E4=BD=9C=E6=A5=AD=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=
=E3=83=AA=E3=81=AE=E6=9C=80=E4=B8=8A=E4=BD=8D=E3=81=AB=E7=A7=BB=E5=8B=95=
=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93"
=20
-#: git-gui.sh:932
+#: git-gui.sh:986
 msgid "Cannot use funny .git directory:"
 msgstr "=E5=A4=89=E3=81=AA .git =E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=
=83=88=E3=83=AA=E3=81=AF=E4=BD=BF=E3=81=88=E3=81=BE=E3=81=9B=E3=82=93"
=20
-#: git-gui.sh:937
+#: git-gui.sh:991
 msgid "No working directory"
 msgstr "=E4=BD=9C=E6=A5=AD=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=
=E3=83=AA=E3=81=8C=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93"
=20
-#: git-gui.sh:1084 lib/checkout_op.tcl:283
+#: git-gui.sh:1138 lib/checkout_op.tcl:305
 msgid "Refreshing file status..."
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E7=8A=B6=E6=85=8B=E3=82=92=
=E6=9B=B4=E6=96=B0=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99=E2=80=A6=
"
=20
-#: git-gui.sh:1149
+#: git-gui.sh:1194
 msgid "Scanning for modified files ..."
 msgstr "=E5=A4=89=E6=9B=B4=E3=81=95=E3=82=8C=E3=81=9F=E3=83=95=E3=82=A1=
=E3=82=A4=E3=83=AB=E3=82=92=E3=82=B9=E3=82=AD=E3=83=A3=E3=83=B3=E3=81=97=
=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99=E2=80=A6"
=20
-#: git-gui.sh:1324 lib/browser.tcl:246
+#: git-gui.sh:1369 lib/browser.tcl:246
 msgid "Ready."
 msgstr "=E6=BA=96=E5=82=99=E5=AE=8C=E4=BA=86"
=20
-#: git-gui.sh:1590
+#: git-gui.sh:1635
 msgid "Unmodified"
 msgstr "=E5=A4=89=E6=9B=B4=E7=84=A1=E3=81=97"
=20
-#: git-gui.sh:1592
+#: git-gui.sh:1637
 msgid "Modified, not staged"
 msgstr "=E5=A4=89=E6=9B=B4=E3=81=82=E3=82=8A=E3=80=81=E3=82=B3=E3=83=9F=
=E3=83=83=E3=83=88=E6=9C=AA=E4=BA=88=E5=AE=9A"
=20
-#: git-gui.sh:1593 git-gui.sh:1598
+#: git-gui.sh:1638 git-gui.sh:1643
 msgid "Staged for commit"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=E6=B8=88=
"
=20
-#: git-gui.sh:1594 git-gui.sh:1599
+#: git-gui.sh:1639 git-gui.sh:1644
 msgid "Portions staged for commit"
 msgstr "=E9=83=A8=E5=88=86=E7=9A=84=E3=81=AB=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E4=BA=88=E5=AE=9A=E6=B8=88"
=20
-#: git-gui.sh:1595 git-gui.sh:1600
+#: git-gui.sh:1640 git-gui.sh:1645
 msgid "Staged for commit, missing"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=E6=B8=88=
=E3=80=81=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E7=84=A1=E3=81=97"
=20
-#: git-gui.sh:1597
+#: git-gui.sh:1642
 msgid "Untracked, not staged"
 msgstr "=E7=AE=A1=E7=90=86=E5=A4=96=E3=80=81=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E6=9C=AA=E4=BA=88=E5=AE=9A"
=20
-#: git-gui.sh:1602
+#: git-gui.sh:1647
 msgid "Missing"
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E7=84=A1=E3=81=97"
=20
-#: git-gui.sh:1603
+#: git-gui.sh:1648
 msgid "Staged for removal"
 msgstr "=E5=89=8A=E9=99=A4=E4=BA=88=E5=AE=9A=E6=B8=88"
=20
-#: git-gui.sh:1604
+#: git-gui.sh:1649
 msgid "Staged for removal, still present"
 msgstr "=E5=89=8A=E9=99=A4=E4=BA=88=E5=AE=9A=E6=B8=88=E3=80=81=E3=83=95=
=E3=82=A1=E3=82=A4=E3=83=AB=E6=9C=AA=E5=89=8A=E9=99=A4"
=20
-#: git-gui.sh:1606 git-gui.sh:1607 git-gui.sh:1608 git-gui.sh:1609
+#: git-gui.sh:1651 git-gui.sh:1652 git-gui.sh:1653 git-gui.sh:1654
 msgid "Requires merge resolution"
 msgstr "=E8=A6=81=E3=83=9E=E3=83=BC=E3=82=B8=E8=A7=A3=E6=B1=BA"
=20
-#: git-gui.sh:1644
+#: git-gui.sh:1689
 msgid "Starting gitk... please wait..."
 msgstr "gitk =E3=82=92=E8=B5=B7=E5=8B=95=E4=B8=AD=E2=80=A6=E3=81=8A=E5=
=BE=85=E3=81=A1=E4=B8=8B=E3=81=95=E3=81=84=E2=80=A6"
=20
-#: git-gui.sh:1653
-#, tcl-format
-msgid ""
-"Unable to start gitk:\n"
-"\n"
-"%s does not exist"
-msgstr ""
-"gitk =E3=82=92=E8=B5=B7=E5=8B=95=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=
=82=93:\n"
-"\n"
-"%s =E3=81=8C=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93"
+#: git-gui.sh:1698
+msgid "Couldn't find gitk in PATH"
+msgstr "PATH =E4=B8=AD=E3=81=AB gitk =E3=81=8C=E8=A6=8B=E3=81=A4=E3=81=
=8B=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93"
=20
-#: git-gui.sh:1860 lib/choose_repository.tcl:36
+#: git-gui.sh:1948 lib/choose_repository.tcl:36
 msgid "Repository"
 msgstr "=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA"
=20
-#: git-gui.sh:1861
+#: git-gui.sh:1949
 msgid "Edit"
 msgstr "=E7=B7=A8=E9=9B=86"
=20
-#: git-gui.sh:1863 lib/choose_rev.tcl:561
+#: git-gui.sh:1951 lib/choose_rev.tcl:561
 msgid "Branch"
 msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81"
=20
-#: git-gui.sh:1866 lib/choose_rev.tcl:548
+#: git-gui.sh:1954 lib/choose_rev.tcl:548
 msgid "Commit@@noun"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88"
=20
-#: git-gui.sh:1869 lib/merge.tcl:120 lib/merge.tcl:149 lib/merge.tcl:1=
67
+#: git-gui.sh:1957 lib/merge.tcl:120 lib/merge.tcl:149 lib/merge.tcl:1=
67
 msgid "Merge"
 msgstr "=E3=83=9E=E3=83=BC=E3=82=B8"
=20
-#: git-gui.sh:1870 lib/choose_rev.tcl:557
+#: git-gui.sh:1958 lib/choose_rev.tcl:557
 msgid "Remote"
 msgstr "=E3=83=AA=E3=83=A2=E3=83=BC=E3=83=88"
=20
-#: git-gui.sh:1879
+#: git-gui.sh:1967
 msgid "Browse Current Branch's Files"
 msgstr "=E7=8F=BE=E5=9C=A8=E3=81=AE=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
=E3=81=AE=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=82=92=E8=A6=8B=E3=82=8B=
"
=20
-#: git-gui.sh:1883
+#: git-gui.sh:1971
 msgid "Browse Branch Files..."
 msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=81=AE=E3=83=95=E3=82=A1=
=E3=82=A4=E3=83=AB=E3=82=92=E8=A6=8B=E3=82=8B=E2=80=A6"
=20
-#: git-gui.sh:1888
+#: git-gui.sh:1976
 msgid "Visualize Current Branch's History"
 msgstr "=E7=8F=BE=E5=9C=A8=E3=81=AE=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
=E3=81=AE=E5=B1=A5=E6=AD=B4=E3=82=92=E8=A6=8B=E3=82=8B"
=20
-#: git-gui.sh:1892
+#: git-gui.sh:1980
 msgid "Visualize All Branch History"
 msgstr "=E5=85=A8=E3=81=A6=E3=81=AE=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
=E3=81=AE=E5=B1=A5=E6=AD=B4=E3=82=92=E8=A6=8B=E3=82=8B"
=20
-#: git-gui.sh:1899
+#: git-gui.sh:1987
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81 %s =E3=81=AE=E3=83=95=E3=82=
=A1=E3=82=A4=E3=83=AB=E3=82=92=E8=A6=8B=E3=82=8B"
=20
-#: git-gui.sh:1901
+#: git-gui.sh:1989
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81 %s =E3=81=AE=E5=B1=A5=E6=AD=
=B4=E3=82=92=E8=A6=8B=E3=82=8B"
=20
-#: git-gui.sh:1906 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:1994 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "=E3=83=87=E3=83=BC=E3=82=BF=E3=83=99=E3=83=BC=E3=82=B9=E7=B5=B1=
=E8=A8=88"
=20
-#: git-gui.sh:1909 lib/database.tcl:34
+#: git-gui.sh:1997 lib/database.tcl:34
 msgid "Compress Database"
 msgstr "=E3=83=87=E3=83=BC=E3=82=BF=E3=83=99=E3=83=BC=E3=82=B9=E5=9C=A7=
=E7=B8=AE"
=20
-#: git-gui.sh:1912
+#: git-gui.sh:2000
 msgid "Verify Database"
 msgstr "=E3=83=87=E3=83=BC=E3=82=BF=E3=83=99=E3=83=BC=E3=82=B9=E6=A4=9C=
=E8=A8=BC"
=20
-#: git-gui.sh:1919 git-gui.sh:1923 git-gui.sh:1927 lib/shortcut.tcl:7
+#: git-gui.sh:2007 git-gui.sh:2011 git-gui.sh:2015 lib/shortcut.tcl:7
 #: lib/shortcut.tcl:39 lib/shortcut.tcl:71
 msgid "Create Desktop Icon"
 msgstr "=E3=83=87=E3=82=B9=E3=82=AF=E3=83=88=E3=83=83=E3=83=97=E3=83=BB=
=E3=82=A2=E3=82=A4=E3=82=B3=E3=83=B3=E3=82=92=E4=BD=9C=E3=82=8B"
=20
-#: git-gui.sh:1932 lib/choose_repository.tcl:177 lib/choose_repository=
=2Etcl:185
+#: git-gui.sh:2023 lib/choose_repository.tcl:177 lib/choose_repository=
=2Etcl:185
 msgid "Quit"
 msgstr "=E7=B5=82=E4=BA=86"
=20
-#: git-gui.sh:1939
+#: git-gui.sh:2031
 msgid "Undo"
 msgstr "=E5=85=83=E3=81=AB=E6=88=BB=E3=81=99"
=20
-#: git-gui.sh:1942
+#: git-gui.sh:2034
 msgid "Redo"
 msgstr "=E3=82=84=E3=82=8A=E7=9B=B4=E3=81=97"
=20
-#: git-gui.sh:1946 git-gui.sh:2443
+#: git-gui.sh:2038 git-gui.sh:2545
 msgid "Cut"
 msgstr "=E5=88=87=E3=82=8A=E5=8F=96=E3=82=8A"
=20
-#: git-gui.sh:1949 git-gui.sh:2446 git-gui.sh:2520 git-gui.sh:2614
+#: git-gui.sh:2041 git-gui.sh:2548 git-gui.sh:2622 git-gui.sh:2715
 #: lib/console.tcl:69
 msgid "Copy"
 msgstr "=E3=82=B3=E3=83=94=E3=83=BC"
=20
-#: git-gui.sh:1952 git-gui.sh:2449
+#: git-gui.sh:2044 git-gui.sh:2551
 msgid "Paste"
 msgstr "=E8=B2=BC=E3=82=8A=E4=BB=98=E3=81=91"
=20
-#: git-gui.sh:1955 git-gui.sh:2452 lib/branch_delete.tcl:26
+#: git-gui.sh:2047 git-gui.sh:2554 lib/branch_delete.tcl:26
 #: lib/remote_branch_delete.tcl:38
 msgid "Delete"
 msgstr "=E5=89=8A=E9=99=A4"
=20
-#: git-gui.sh:1959 git-gui.sh:2456 git-gui.sh:2618 lib/console.tcl:71
+#: git-gui.sh:2051 git-gui.sh:2558 git-gui.sh:2719 lib/console.tcl:71
 msgid "Select All"
 msgstr "=E5=85=A8=E3=81=A6=E9=81=B8=E6=8A=9E"
=20
-#: git-gui.sh:1968
+#: git-gui.sh:2060
 msgid "Create..."
 msgstr "=E4=BD=9C=E6=88=90=E2=80=A6"
=20
-#: git-gui.sh:1974
+#: git-gui.sh:2066
 msgid "Checkout..."
 msgstr "=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=E3=82=A2=E3=82=A6=E3=83=88=
"
=20
-#: git-gui.sh:1980
+#: git-gui.sh:2072
 msgid "Rename..."
 msgstr "=E5=90=8D=E5=89=8D=E5=A4=89=E6=9B=B4=E2=80=A6"
=20
-#: git-gui.sh:1985 git-gui.sh:2085
+#: git-gui.sh:2077 git-gui.sh:2187
 msgid "Delete..."
 msgstr "=E5=89=8A=E9=99=A4=E2=80=A6"
=20
-#: git-gui.sh:1990
+#: git-gui.sh:2082
 msgid "Reset..."
 msgstr "=E3=83=AA=E3=82=BB=E3=83=83=E3=83=88=E2=80=A6"
=20
-#: git-gui.sh:2002 git-gui.sh:2389
+#: git-gui.sh:2094 git-gui.sh:2491
 msgid "New Commit"
 msgstr "=E6=96=B0=E8=A6=8F=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88"
=20
-#: git-gui.sh:2010 git-gui.sh:2396
+#: git-gui.sh:2102 git-gui.sh:2498
 msgid "Amend Last Commit"
 msgstr "=E6=9C=80=E6=96=B0=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=82=92=
=E8=A8=82=E6=AD=A3"
=20
-#: git-gui.sh:2019 git-gui.sh:2356 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:2111 git-gui.sh:2458 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
 msgstr "=E5=86=8D=E3=82=B9=E3=82=AD=E3=83=A3=E3=83=B3"
=20
-#: git-gui.sh:2025
+#: git-gui.sh:2117
 msgid "Stage To Commit"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=E3=81=99=
=E3=82=8B"
=20
-#: git-gui.sh:2031
+#: git-gui.sh:2123
 msgid "Stage Changed Files To Commit"
 msgstr "=E5=A4=89=E6=9B=B4=E3=81=95=E3=82=8C=E3=81=9F=E3=83=95=E3=82=A1=
=E3=82=A4=E3=83=AB=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=
=E5=AE=9A"
=20
-#: git-gui.sh:2037
+#: git-gui.sh:2129
 msgid "Unstage From Commit"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=8B=E3=82=89=E9=99=8D=
=E3=82=8D=E3=81=99"
=20
-#: git-gui.sh:2042 lib/index.tcl:395
+#: git-gui.sh:2134 lib/index.tcl:395
 msgid "Revert Changes"
 msgstr "=E5=A4=89=E6=9B=B4=E3=82=92=E5=85=83=E3=81=AB=E6=88=BB=E3=81=99=
"
=20
-#: git-gui.sh:2049 git-gui.sh:2368 git-gui.sh:2467
+#: git-gui.sh:2141 git-gui.sh:2702
+msgid "Show Less Context"
+msgstr "=E6=96=87=E8=84=88=E3=82=92=E5=B0=91=E3=81=AA=E3=81=8F"
+
+#: git-gui.sh:2145 git-gui.sh:2706
+msgid "Show More Context"
+msgstr "=E6=96=87=E8=84=88=E3=82=92=E5=A4=9A=E3=81=8F"
+
+#: git-gui.sh:2151 git-gui.sh:2470 git-gui.sh:2569
 msgid "Sign Off"
 msgstr "=E7=BD=B2=E5=90=8D"
=20
-#: git-gui.sh:2053 git-gui.sh:2372
+#: git-gui.sh:2155 git-gui.sh:2474
 msgid "Commit@@verb"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88"
=20
-#: git-gui.sh:2064
+#: git-gui.sh:2166
 msgid "Local Merge..."
 msgstr "=E3=83=AD=E3=83=BC=E3=82=AB=E3=83=AB=E3=83=BB=E3=83=9E=E3=83=BC=
=E3=82=B8=E2=80=A6"
=20
-#: git-gui.sh:2069
+#: git-gui.sh:2171
 msgid "Abort Merge..."
 msgstr "=E3=83=9E=E3=83=BC=E3=82=B8=E4=B8=AD=E6=AD=A2=E2=80=A6"
=20
-#: git-gui.sh:2081
+#: git-gui.sh:2183
 msgid "Push..."
 msgstr "=E3=83=97=E3=83=83=E3=82=B7=E3=83=A5=E2=80=A6"
=20
-#: git-gui.sh:2092 lib/choose_repository.tcl:41
-msgid "Apple"
-msgstr "=E3=82=8A=E3=82=93=E3=81=94"
-
-#: git-gui.sh:2095 git-gui.sh:2117 lib/about.tcl:14
+#: git-gui.sh:2197 git-gui.sh:2219 lib/about.tcl:14
 #: lib/choose_repository.tcl:44 lib/choose_repository.tcl:50
 #, tcl-format
 msgid "About %s"
 msgstr "%s =E3=81=AB=E3=81=A4=E3=81=84=E3=81=A6"
=20
-#: git-gui.sh:2099
+#: git-gui.sh:2201
 msgid "Preferences..."
 msgstr "=E8=A8=AD=E5=AE=9A=E2=80=A6"
=20
-#: git-gui.sh:2107 git-gui.sh:2639
+#: git-gui.sh:2209 git-gui.sh:2740
 msgid "Options..."
 msgstr "=E3=82=AA=E3=83=97=E3=82=B7=E3=83=A7=E3=83=B3=E2=80=A6"
=20
-#: git-gui.sh:2113 lib/choose_repository.tcl:47
+#: git-gui.sh:2215 lib/choose_repository.tcl:47
 msgid "Help"
 msgstr "=E3=83=98=E3=83=AB=E3=83=97"
=20
-#: git-gui.sh:2154
+#: git-gui.sh:2256
 msgid "Online Documentation"
 msgstr "=E3=82=AA=E3=83=B3=E3=83=A9=E3=82=A4=E3=83=B3=E3=83=BB=E3=83=89=
=E3=82=AD=E3=83=A5=E3=83=A1=E3=83=B3=E3=83=88"
=20
-#: git-gui.sh:2238
+#: git-gui.sh:2340
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr ""
 "=E8=87=B4=E5=91=BD=E7=9A=84: =E3=83=91=E3=82=B9 %s =E3=81=8C stat =E3=
=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82=E3=81=9D=E3=81=AE=E3=
=82=88=E3=81=86=E3=81=AA=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=82=84=E3=
=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=E3=83=AA=E3=81=AF=E3=81=82=E3=
=82=8A=E3=81=BE"
 "=E3=81=9B=E3=82=93"
=20
-#: git-gui.sh:2271
+#: git-gui.sh:2373
 msgid "Current Branch:"
 msgstr "=E7=8F=BE=E5=9C=A8=E3=81=AE=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
"
=20
-#: git-gui.sh:2292
+#: git-gui.sh:2394
 msgid "Staged Changes (Will Commit)"
 msgstr "=E3=82=B9=E3=83=86=E3=83=BC=E3=82=B8=E3=83=B3=E3=82=B0=E3=81=95=
=E3=82=8C=E3=81=9F=EF=BC=88=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=
=E5=AE=9A=E6=B8=88=E3=81=AE=EF=BC=89=E5=A4=89=E6=9B=B4"
=20
-#: git-gui.sh:2312
+#: git-gui.sh:2414
 msgid "Unstaged Changes"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=E3=81=AB=
=E5=85=A5=E3=81=A3=E3=81=A6=E3=81=84=E3=81=AA=E3=81=84=E5=A4=89=E6=9B=B4=
"
=20
-#: git-gui.sh:2362
+#: git-gui.sh:2464
 msgid "Stage Changed"
 msgstr "=E5=A4=89=E6=9B=B4=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=
=E4=BA=88=E5=AE=9A=E3=81=AB=E5=85=A5=E3=82=8C=E3=82=8B"
=20
-#: git-gui.sh:2378 lib/transport.tcl:93 lib/transport.tcl:182
+#: git-gui.sh:2480 lib/transport.tcl:93 lib/transport.tcl:182
 msgid "Push"
 msgstr "=E3=83=97=E3=83=83=E3=82=B7=E3=83=A5"
=20
-#: git-gui.sh:2408
+#: git-gui.sh:2510
 msgid "Initial Commit Message:"
 msgstr "=E6=9C=80=E5=88=9D=E3=81=AE=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=
=E3=83=A1=E3=83=83=E3=82=BB=E3=83=BC=E3=82=B8:"
=20
-#: git-gui.sh:2409
+#: git-gui.sh:2511
 msgid "Amended Commit Message:"
 msgstr "=E8=A8=82=E6=AD=A3=E3=81=97=E3=81=9F=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E3=83=A1=E3=83=83=E3=82=BB=E3=83=BC=E3=82=B8:"
=20
-#: git-gui.sh:2410
+#: git-gui.sh:2512
 msgid "Amended Initial Commit Message:"
 msgstr "=E8=A8=82=E6=AD=A3=E3=81=97=E3=81=9F=E6=9C=80=E5=88=9D=E3=81=AE=
=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=83=A1=E3=83=83=E3=82=BB=E3=83=BC=
=E3=82=B8:"
=20
-#: git-gui.sh:2411
+#: git-gui.sh:2513
 msgid "Amended Merge Commit Message:"
 msgstr "=E8=A8=82=E6=AD=A3=E3=81=97=E3=81=9F=E3=83=9E=E3=83=BC=E3=82=B8=
=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=83=A1=E3=83=83=E3=82=BB=E3=83=BC=
=E3=82=B8:"
=20
-#: git-gui.sh:2412
+#: git-gui.sh:2514
 msgid "Merge Commit Message:"
 msgstr "=E3=83=9E=E3=83=BC=E3=82=B8=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=
=E3=83=A1=E3=83=83=E3=82=BB=E3=83=BC=E3=82=B8:"
=20
-#: git-gui.sh:2413
+#: git-gui.sh:2515
 msgid "Commit Message:"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=83=A1=E3=83=83=E3=82=BB=
=E3=83=BC=E3=82=B8:"
=20
-#: git-gui.sh:2459 git-gui.sh:2622 lib/console.tcl:73
+#: git-gui.sh:2561 git-gui.sh:2723 lib/console.tcl:73
 msgid "Copy All"
 msgstr "=E5=85=A8=E3=81=A6=E3=82=B3=E3=83=94=E3=83=BC"
=20
-#: git-gui.sh:2483 lib/blame.tcl:107
+#: git-gui.sh:2585 lib/blame.tcl:100
 msgid "File:"
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB:"
=20
-#: git-gui.sh:2589
+#: git-gui.sh:2691
 msgid "Apply/Reverse Hunk"
 msgstr "=E3=83=91=E3=83=83=E3=83=81=E3=82=92=E9=81=A9=E7=94=A8/=E5=8F=96=
=E3=82=8A=E6=B6=88=E3=81=99"
=20
-#: git-gui.sh:2595
-msgid "Show Less Context"
-msgstr "=E6=96=87=E8=84=88=E3=82=92=E5=B0=91=E3=81=AA=E3=81=8F"
-
-#: git-gui.sh:2602
-msgid "Show More Context"
-msgstr "=E6=96=87=E8=84=88=E3=82=92=E5=A4=9A=E3=81=8F"
+#: git-gui.sh:2696
+msgid "Apply/Reverse Line"
+msgstr "=E3=83=91=E3=83=83=E3=83=81=E8=A1=8C=E3=82=92=E9=81=A9=E7=94=A8=
/=E5=8F=96=E3=82=8A=E6=B6=88=E3=81=99"
=20
-#: git-gui.sh:2610
+#: git-gui.sh:2711
 msgid "Refresh"
 msgstr "=E5=86=8D=E8=AA=AD=E3=81=BF=E8=BE=BC=E3=81=BF"
=20
-#: git-gui.sh:2631
+#: git-gui.sh:2732
 msgid "Decrease Font Size"
 msgstr "=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88=E3=82=92=E5=B0=8F=E3=81=95=
=E3=81=8F"
=20
-#: git-gui.sh:2635
+#: git-gui.sh:2736
 msgid "Increase Font Size"
 msgstr "=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88=E3=82=92=E5=A4=A7=E3=81=8D=
=E3=81=8F"
=20
-#: git-gui.sh:2646
+#: git-gui.sh:2747
 msgid "Unstage Hunk From Commit"
 msgstr "=E3=83=91=E3=83=83=E3=83=81=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E4=BA=88=E5=AE=9A=E3=81=8B=E3=82=89=E5=A4=96=E3=81=99"
=20
-#: git-gui.sh:2648
+#: git-gui.sh:2748
+msgid "Unstage Line From Commit"
+msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=E3=81=8B=
=E3=82=89=E8=A1=8C=E3=82=92=E5=A4=96=E3=81=99"
+
+#: git-gui.sh:2750
 msgid "Stage Hunk For Commit"
 msgstr "=E3=83=91=E3=83=83=E3=83=81=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E4=BA=88=E5=AE=9A=E3=81=AB=E5=8A=A0=E3=81=88=E3=82=8B"
=20
-#: git-gui.sh:2667
+#: git-gui.sh:2751
+msgid "Stage Line For Commit"
+msgstr "=E3=83=91=E3=83=83=E3=83=81=E8=A1=8C=E3=82=92=E3=82=B3=E3=83=9F=
=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=E3=81=AB=E5=8A=A0=E3=81=88=E3=82=8B=
"
+
+#: git-gui.sh:2771
 msgid "Initializing..."
 msgstr "=E5=88=9D=E6=9C=9F=E5=8C=96=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=
=E3=81=99=E2=80=A6"
=20
-#: git-gui.sh:2762
+#: git-gui.sh:2876
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -449,7 +450,7 @@ msgstr ""
 "=E4=BB=A5=E4=B8=8B=E3=81=AE=E7=92=B0=E5=A2=83=E5=A4=89=E6=95=B0=E3=81=
=AF %s =E3=81=8C=E8=B5=B7=E5=8B=95=E3=81=99=E3=82=8B Git =E3=82=B5=E3=83=
=96=E3=83=97=E3=83=AD=E3=82=BB=E3=82=B9=E3=81=AB=E3=82=88=E3=81=A3=E3=81=
=A6=E7=84=A1=E8=A6=96=E3=81=95=E3=82=8C=E3=82=8B=E3=81=A7=E3=81=97=E3=82=
=87=E3=81=86:\n"
 "\n"
=20
-#: git-gui.sh:2792
+#: git-gui.sh:2906
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
@@ -459,7 +460,7 @@ msgstr ""
 "=E3=81=93=E3=82=8C=E3=81=AF Cygwin =E3=81=A7=E9=85=8D=E5=B8=83=E3=81=95=
=E3=82=8C=E3=81=A6=E3=81=84=E3=82=8B Tcl =E3=83=90=E3=82=A4=E3=83=8A=E3=
=83=AA=E3=81=AB\n"
 "=E9=96=A2=E3=81=97=E3=81=A6=E3=81=AE=E6=97=A2=E7=9F=A5=E3=81=AE=E5=95=
=8F=E9=A1=8C=E3=81=AB=E3=82=88=E3=82=8A=E3=81=BE=E3=81=99"
=20
-#: git-gui.sh:2797
+#: git-gui.sh:2911
 #, tcl-format
 msgid ""
 "\n"
@@ -478,64 +479,80 @@ msgstr ""
 msgid "git-gui - a graphical user interface for Git."
 msgstr "Git =E3=81=AE=E3=82=B0=E3=83=A9=E3=83=95=E3=82=A3=E3=82=AB=E3=83=
=ABUI git-gui"
=20
-#: lib/blame.tcl:77
+#: lib/blame.tcl:70
 msgid "File Viewer"
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=83=94=E3=83=A5=E3=83=BC=
=E3=83=AF"
=20
-#: lib/blame.tcl:81
+#: lib/blame.tcl:74
 msgid "Commit:"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88:"
=20
-#: lib/blame.tcl:264
+#: lib/blame.tcl:257
 msgid "Copy Commit"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=82=92=E3=82=B3=E3=83=94=
=E3=83=BC"
=20
-#: lib/blame.tcl:384
+#: lib/blame.tcl:260
+msgid "Do Full Copy Detection"
+msgstr "=E3=82=B3=E3=83=94=E3=83=BC=E6=A4=9C=E7=9F=A5"
+
+#: lib/blame.tcl:388
 #, tcl-format
 msgid "Reading %s..."
 msgstr "%s =E3=82=92=E8=AA=AD=E3=82=93=E3=81=A7=E3=81=84=E3=81=BE=E3=81=
=99=E2=80=A6"
=20
-#: lib/blame.tcl:488
+#: lib/blame.tcl:492
 msgid "Loading copy/move tracking annotations..."
 msgstr "=E3=82=B3=E3=83=94=E3=83=BC=E3=83=BB=E7=A7=BB=E5=8B=95=E8=BF=BD=
=E8=B7=A1=E3=83=87=E3=83=BC=E3=82=BF=E3=82=92=E8=AA=AD=E3=82=93=E3=81=A7=
=E3=81=84=E3=81=BE=E3=81=99=E2=80=A6"
=20
-#: lib/blame.tcl:508
+#: lib/blame.tcl:512
 msgid "lines annotated"
 msgstr "=E8=A1=8C=E3=82=92=E6=B3=A8=E9=87=88=E3=81=97=E3=81=BE=E3=81=97=
=E3=81=9F"
=20
-#: lib/blame.tcl:689
+#: lib/blame.tcl:704
 msgid "Loading original location annotations..."
 msgstr "=E5=85=83=E4=BD=8D=E7=BD=AE=E8=A1=8C=E3=81=AE=E6=B3=A8=E9=87=88=
=E3=83=87=E3=83=BC=E3=82=BF=E3=82=92=E8=AA=AD=E3=82=93=E3=81=A7=E3=81=84=
=E3=81=BE=E3=81=99=E2=80=A6"
=20
-#: lib/blame.tcl:692
+#: lib/blame.tcl:707
 msgid "Annotation complete."
 msgstr "=E6=B3=A8=E9=87=88=E5=AE=8C=E4=BA=86=E3=81=97=E3=81=BE=E3=81=97=
=E3=81=9F"
=20
-#: lib/blame.tcl:746
+#: lib/blame.tcl:737
+msgid "Busy"
+msgstr "=E5=AE=9F=E8=A1=8C=E4=B8=AD"
+
+#: lib/blame.tcl:738
+msgid "Annotation process is already running."
+msgstr "=E3=81=99=E3=81=A7=E3=81=AB blame =E3=83=97=E3=83=AD=E3=82=BB=E3=
=82=B9=E3=82=92=E5=AE=9F=E8=A1=8C=E4=B8=AD=E3=81=A7=E3=81=99=E3=80=82"
+
+#: lib/blame.tcl:777
+msgid "Running thorough copy detection..."
+msgstr "=E3=82=B3=E3=83=94=E3=83=BC=E6=A4=9C=E7=9F=A5=E3=82=92=E5=AE=9F=
=E8=A1=8C=E4=B8=AD=E2=80=A6"
+
+#: lib/blame.tcl:827
 msgid "Loading annotation..."
 msgstr "=E6=B3=A8=E9=87=88=E3=82=92=E8=AA=AD=E3=81=BF=E8=BE=BC=E3=82=93=
=E3=81=A7=E3=81=84=E3=81=BE=E3=81=99=E2=80=A6"
=20
-#: lib/blame.tcl:802
+#: lib/blame.tcl:883
 msgid "Author:"
 msgstr "=E4=BD=9C=E8=80=85:"
=20
-#: lib/blame.tcl:806
+#: lib/blame.tcl:887
 msgid "Committer:"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E8=80=85:"
=20
-#: lib/blame.tcl:811
+#: lib/blame.tcl:892
 msgid "Original File:"
 msgstr "=E5=85=83=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB"
=20
-#: lib/blame.tcl:925
+#: lib/blame.tcl:1006
 msgid "Originally By:"
 msgstr "=E5=8E=9F=E4=BD=9C=E8=80=85:"
=20
-#: lib/blame.tcl:931
+#: lib/blame.tcl:1012
 msgid "In File:"
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB:"
=20
-#: lib/blame.tcl:936
+#: lib/blame.tcl:1017
 msgid "Copied Or Moved Here By:"
 msgstr "=E8=A4=87=E5=86=99=E3=83=BB=E7=A7=BB=E5=8B=95=E8=80=85:"
=20
@@ -549,7 +566,7 @@ msgstr "=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=E3=82=A2=
=E3=82=A6=E3=83=88"
=20
 #: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
 #: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:2=
82
-#: lib/checkout_op.tcl:522 lib/choose_font.tcl:43 lib/merge.tcl:171
+#: lib/checkout_op.tcl:544 lib/choose_font.tcl:43 lib/merge.tcl:171
 #: lib/option.tcl:103 lib/remote_branch_delete.tcl:42 lib/transport.tc=
l:97
 msgid "Cancel"
 msgstr "=E4=B8=AD=E6=AD=A2"
@@ -558,7 +575,7 @@ msgstr "=E4=B8=AD=E6=AD=A2"
 msgid "Revision"
 msgstr "=E3=83=AA=E3=83=93=E3=82=B8=E3=83=A7=E3=83=B3"
=20
-#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:=
242
+#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:=
244
 msgid "Options"
 msgstr "=E3=82=AA=E3=83=97=E3=82=B7=E3=83=A7=E3=83=B3"
=20
@@ -610,7 +627,7 @@ msgstr "=E3=81=84=E3=81=84=E3=81=88"
 msgid "Fast Forward Only"
 msgstr "=E6=97=A9=E9=80=81=E3=82=8A=E3=81=AE=E3=81=BF"
=20
-#: lib/branch_create.tcl:85 lib/checkout_op.tcl:514
+#: lib/branch_create.tcl:85 lib/checkout_op.tcl:536
 msgid "Reset"
 msgstr "=E3=83=AA=E3=82=BB=E3=83=83=E3=83=88"
=20
@@ -700,7 +717,7 @@ msgstr "=E6=96=B0=E3=81=97=E3=81=84=E5=90=8D=E5=89=8D=
:"
 msgid "Please select a branch to rename."
 msgstr "=E5=90=8D=E5=89=8D=E3=82=92=E5=A4=89=E6=9B=B4=E3=81=99=E3=82=8B=
=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=82=92=E9=81=B8=E3=82=93=E3=81=A7=
=E4=B8=8B=E3=81=95=E3=81=84=E3=80=82"
=20
-#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:179
+#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:201
 #, tcl-format
 msgid "Branch '%s' already exists."
 msgstr "'%s'=E3=81=A8=E3=81=84=E3=81=86=E3=83=96=E3=83=A9=E3=83=B3=E3=83=
=81=E3=81=AF=E6=97=A2=E3=81=AB=E5=AD=98=E5=9C=A8=E3=81=97=E3=81=BE=E3=81=
=99=E3=80=82"
@@ -732,31 +749,36 @@ msgid "Browse Branch Files"
 msgstr "=E7=8F=BE=E5=9C=A8=E3=81=AE=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
=E3=81=AE=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=82=92=E8=A6=8B=E3=82=8B=
"
=20
 #: lib/browser.tcl:278 lib/choose_repository.tcl:387
-#: lib/choose_repository.tcl:474 lib/choose_repository.tcl:484
-#: lib/choose_repository.tcl:987
+#: lib/choose_repository.tcl:472 lib/choose_repository.tcl:482
+#: lib/choose_repository.tcl:985
 msgid "Browse"
 msgstr "=E3=83=96=E3=83=A9=E3=82=A6=E3=82=BA"
=20
-#: lib/checkout_op.tcl:79
+#: lib/checkout_op.tcl:84
 #, tcl-format
 msgid "Fetching %s from %s"
 msgstr "%s =E3=81=8B=E3=82=89 %s =E3=82=92=E3=83=95=E3=82=A7=E3=83=83=E3=
=83=81=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
=20
-#: lib/checkout_op.tcl:127
+#: lib/checkout_op.tcl:132
 #, tcl-format
 msgid "fatal: Cannot resolve %s"
 msgstr "=E8=87=B4=E5=91=BD=E7=9A=84=E3=82=A8=E3=83=A9=E3=83=BC: %s =E3=
=82=92=E8=A7=A3=E6=B1=BA=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93"
=20
-#: lib/checkout_op.tcl:140 lib/console.tcl:81 lib/database.tcl:31
+#: lib/checkout_op.tcl:145 lib/console.tcl:81 lib/database.tcl:31
 msgid "Close"
 msgstr "=E9=96=89=E3=81=98=E3=82=8B"
=20
-#: lib/checkout_op.tcl:169
+#: lib/checkout_op.tcl:174
 #, tcl-format
 msgid "Branch '%s' does not exist."
 msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81'%s'=E3=81=AF=E5=AD=98=E5=9C=
=A8=E3=81=97=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82"
=20
-#: lib/checkout_op.tcl:206
+#: lib/checkout_op.tcl:193
+#, tcl-format
+msgid "Failed to configure simplified git-pull for '%s'."
+msgstr "'%s' =E3=81=AB=E7=B0=A1=E6=98=93 git-pull =E3=82=92=E8=A8=AD=E5=
=AE=9A=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93=E3=81=A7=E3=81=97=E3=
=81=9F"
+
+#: lib/checkout_op.tcl:228
 #, tcl-format
 msgid ""
 "Branch '%s' already exists.\n"
@@ -769,21 +791,21 @@ msgstr ""
 "%s =E3=81=AB=E6=97=A9=E9=80=81=E3=82=8A=E3=81=A7=E3=81=8D=E3=81=BE=E3=
=81=9B=E3=82=93=E3=80=82\n"
 "=E3=83=9E=E3=83=BC=E3=82=B8=E3=81=8C=E5=BF=85=E8=A6=81=E3=81=A7=E3=81=
=99=E3=80=82"
=20
-#: lib/checkout_op.tcl:220
+#: lib/checkout_op.tcl:242
 #, tcl-format
 msgid "Merge strategy '%s' not supported."
 msgstr "'%s' =E3=83=9E=E3=83=BC=E3=82=B8=E6=88=A6=E7=95=A5=E3=81=AF=E3=
=82=B5=E3=83=9D=E3=83=BC=E3=83=88=E3=81=95=E3=82=8C=E3=81=A6=E3=81=84=E3=
=81=BE=E3=81=9B=E3=82=93=E3=80=82"
=20
-#: lib/checkout_op.tcl:239
+#: lib/checkout_op.tcl:261
 #, tcl-format
 msgid "Failed to update '%s'."
 msgstr "'%s' =E3=81=AE=E6=9B=B4=E6=96=B0=E3=81=AB=E5=A4=B1=E6=95=97=E3=
=81=97=E3=81=BE=E3=81=97=E3=81=9F=E3=80=82"
=20
-#: lib/checkout_op.tcl:251
+#: lib/checkout_op.tcl:273
 msgid "Staging area (index) is already locked."
 msgstr "=E3=82=A4=E3=83=B3=E3=83=87=E3=83=83=E3=82=AF=E3=82=B9=E3=81=AF=
=E6=97=A2=E3=81=AB=E3=83=AD=E3=83=83=E3=82=AF=E3=81=95=E3=82=8C=E3=81=A6=
=E3=81=84=E3=81=BE=E3=81=99=E3=80=82"
=20
-#: lib/checkout_op.tcl:266
+#: lib/checkout_op.tcl:288
 msgid ""
 "Last scanned state does not match repository state.\n"
 "\n"
@@ -799,30 +821,30 @@ msgstr ""
 "\n"
 "=E8=87=AA=E5=8B=95=E7=9A=84=E3=81=AB=E5=86=8D=E3=82=B9=E3=82=AD=E3=83=
=A3=E3=83=B3=E3=82=92=E9=96=8B=E5=A7=8B=E3=81=97=E3=81=BE=E3=81=99=E3=80=
=82\n"
=20
-#: lib/checkout_op.tcl:322
+#: lib/checkout_op.tcl:344
 #, tcl-format
 msgid "Updating working directory to '%s'..."
 msgstr "=E4=BD=9C=E6=A5=AD=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=
=E3=83=AA=E3=82=92 '%s' =E3=81=AB=E6=9B=B4=E6=96=B0=E3=81=97=E3=81=A6=E3=
=81=84=E3=81=BE=E3=81=99=E2=80=A6"
=20
-#: lib/checkout_op.tcl:323
+#: lib/checkout_op.tcl:345
 msgid "files checked out"
 msgstr "=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=E3=82=A2=E3=82=A6=E3=83=88=
=E3=81=95=E3=82=8C=E3=81=9F=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB"
=20
-#: lib/checkout_op.tcl:353
+#: lib/checkout_op.tcl:375
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
 msgstr "'%s' =E3=81=AE=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=E3=82=A2=E3=
=82=A6=E3=83=88=E3=82=92=E4=B8=AD=E6=AD=A2=E3=81=97=E3=81=BE=E3=81=97=E3=
=81=9F=EF=BC=88=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E6=AF=8E=E3=81=AE=E3=
=83=9E=E3=83=BC=E3=82=B8=E3=81=8C=E5=BF=85=E8=A6=81=E3=81=A7=E3=81=99=EF=
=BC=89=E3=80=82"
=20
-#: lib/checkout_op.tcl:354
+#: lib/checkout_op.tcl:376
 msgid "File level merge required."
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E6=AF=8E=E3=81=AE=E3=83=9E=
=E3=83=BC=E3=82=B8=E3=81=8C=E5=BF=85=E8=A6=81=E3=81=A7=E3=81=99=E3=80=82=
"
=20
-#: lib/checkout_op.tcl:358
+#: lib/checkout_op.tcl:380
 #, tcl-format
 msgid "Staying on branch '%s'."
 msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81 '%s' =E3=81=AB=E6=BB=9E=E3=
=81=BE=E3=82=8A=E3=81=BE=E3=81=99=E3=80=82"
=20
-#: lib/checkout_op.tcl:429
+#: lib/checkout_op.tcl:451
 msgid ""
 "You are no longer on a local branch.\n"
 "\n"
@@ -834,30 +856,30 @@ msgstr ""
 "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E4=B8=8A=E3=81=AB=E6=BB=9E=E3=81=
=BE=E3=82=8A=E3=81=9F=E3=81=84=E3=81=A8=E3=81=8D=E3=81=AF=E3=80=81=E3=81=
=93=E3=81=AE=E3=80=8C=E5=88=86=E9=9B=A2=E3=81=95=E3=82=8C=E3=81=9F=E3=83=
=81=E3=82=A7=E3=83=83=E3=82=AF=E3=82=A2=E3=82=A6=E3=83=88=E3=80=8D=E3=81=
=8B=E3=82=89=E6=96=B0=E8=A6=8F=E3=83=96=E3=83=A9=E3=83=B3"
 "=E3=83=81=E3=82=92=E9=96=8B=E5=A7=8B=E3=81=97=E3=81=A6=E3=81=8F=E3=81=
=A0=E3=81=95=E3=81=84=E3=80=82"
=20
-#: lib/checkout_op.tcl:446 lib/checkout_op.tcl:450
+#: lib/checkout_op.tcl:468 lib/checkout_op.tcl:472
 #, tcl-format
 msgid "Checked out '%s'."
 msgstr "'%s' =E3=82=92=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=E3=82=A2=E3=
=82=A6=E3=83=88=E3=81=97=E3=81=BE=E3=81=97=E3=81=9F"
=20
-#: lib/checkout_op.tcl:478
+#: lib/checkout_op.tcl:500
 #, tcl-format
 msgid "Resetting '%s' to '%s' will lose the following commits:"
 msgstr "'%s' =E3=82=92 '%s' =E3=81=AB=E3=83=AA=E3=82=BB=E3=83=83=E3=83=
=88=E3=81=99=E3=82=8B=E3=81=A8=E3=80=81=E4=BB=A5=E4=B8=8B=E3=81=AE=E3=82=
=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=8C=E5=A4=B1=E3=81=AA=E3=82=8F=E3=82=
=8C=E3=81=BE=E3=81=99:"
=20
-#: lib/checkout_op.tcl:500
+#: lib/checkout_op.tcl:522
 msgid "Recovering lost commits may not be easy."
 msgstr "=E5=A4=B1=E3=81=AA=E3=82=8F=E3=82=8C=E3=81=9F=E3=82=B3=E3=83=9F=
=E3=83=83=E3=83=88=E3=82=92=E5=9B=9E=E5=BE=A9=E3=81=99=E3=82=8B=E3=81=AE=
=E3=81=AF=E7=B0=A1=E5=8D=98=E3=81=A7=E3=81=AF=E3=81=82=E3=82=8A=E3=81=BE=
=E3=81=9B=E3=82=93=E3=80=82"
=20
-#: lib/checkout_op.tcl:505
+#: lib/checkout_op.tcl:527
 #, tcl-format
 msgid "Reset '%s'?"
 msgstr "'%s' =E3=82=92=E3=83=AA=E3=82=BB=E3=83=83=E3=83=88=E3=81=97=E3=
=81=BE=E3=81=99=E3=81=8B=EF=BC=9F"
=20
-#: lib/checkout_op.tcl:510 lib/merge.tcl:163
+#: lib/checkout_op.tcl:532 lib/merge.tcl:163
 msgid "Visualize"
 msgstr "=E5=8F=AF=E8=A6=96=E5=8C=96"
=20
-#: lib/checkout_op.tcl:578
+#: lib/checkout_op.tcl:600
 #, tcl-format
 msgid ""
 "Failed to set current branch.\n"
@@ -909,7 +931,7 @@ msgstr "=E6=96=B0=E3=81=97=E3=81=84=E3=83=AA=E3=83=9D=
=E3=82=B8=E3=83=88=E3=83=AA=E3=82=92=E4=BD=9C=E3=82=8B"
 msgid "New..."
 msgstr "=E6=96=B0=E8=A6=8F=E2=80=A6"
=20
-#: lib/choose_repository.tcl:94 lib/choose_repository.tcl:460
+#: lib/choose_repository.tcl:94 lib/choose_repository.tcl:458
 msgid "Clone Existing Repository"
 msgstr "=E6=97=A2=E5=AD=98=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA=
=E3=82=92=E8=A4=87=E8=A3=BD=E3=81=99=E3=82=8B"
=20
@@ -917,7 +939,7 @@ msgstr "=E6=97=A2=E5=AD=98=E3=83=AA=E3=83=9D=E3=82=B8=
=E3=83=88=E3=83=AA=E3=82=92=E8=A4=87=E8=A3=BD=E3=81=99=E3=82=8B"
 msgid "Clone..."
 msgstr "=E8=A4=87=E8=A3=BD=E2=80=A6"
=20
-#: lib/choose_repository.tcl:107 lib/choose_repository.tcl:976
+#: lib/choose_repository.tcl:107 lib/choose_repository.tcl:974
 msgid "Open Existing Repository"
 msgstr "=E6=97=A2=E5=AD=98=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA=
=E3=82=92=E9=96=8B=E3=81=8F"
=20
@@ -939,183 +961,183 @@ msgstr "=E6=9C=80=E8=BF=91=E4=BD=BF=E3=81=A3=E3=
=81=9F=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA=E3=82=92=E9=96=8B=E3=
=81=8F"
 msgid "Failed to create repository %s:"
 msgstr "=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA %s =E3=82=92=E4=BD=
=9C=E8=A3=BD=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93:"
=20
-#: lib/choose_repository.tcl:381 lib/choose_repository.tcl:478
+#: lib/choose_repository.tcl:381 lib/choose_repository.tcl:476
 msgid "Directory:"
 msgstr "=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=E3=83=AA:"
=20
-#: lib/choose_repository.tcl:412 lib/choose_repository.tcl:537
-#: lib/choose_repository.tcl:1011
+#: lib/choose_repository.tcl:410 lib/choose_repository.tcl:535
+#: lib/choose_repository.tcl:1007
 msgid "Git Repository"
 msgstr "GIT =E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA"
=20
-#: lib/choose_repository.tcl:437
+#: lib/choose_repository.tcl:435
 #, tcl-format
 msgid "Directory %s already exists."
 msgstr "=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=E3=83=AA '%s' =E3=
=81=AF=E6=97=A2=E3=81=AB=E5=AD=98=E5=9C=A8=E3=81=97=E3=81=BE=E3=81=99=E3=
=80=82"
=20
-#: lib/choose_repository.tcl:441
+#: lib/choose_repository.tcl:439
 #, tcl-format
 msgid "File %s already exists."
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB '%s' =E3=81=AF=E6=97=A2=E3=
=81=AB=E5=AD=98=E5=9C=A8=E3=81=97=E3=81=BE=E3=81=99=E3=80=82"
=20
-#: lib/choose_repository.tcl:455
+#: lib/choose_repository.tcl:453
 msgid "Clone"
 msgstr "=E8=A4=87=E8=A3=BD"
=20
-#: lib/choose_repository.tcl:468
+#: lib/choose_repository.tcl:466
 msgid "URL:"
 msgstr "URL:"
=20
-#: lib/choose_repository.tcl:489
+#: lib/choose_repository.tcl:487
 msgid "Clone Type:"
 msgstr "=E8=A4=87=E8=A3=BD=E6=96=B9=E5=BC=8F:"
=20
-#: lib/choose_repository.tcl:495
+#: lib/choose_repository.tcl:493
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
 msgstr "=E6=A8=99=E6=BA=96(=E9=AB=98=E9=80=9F=E3=83=BB=E4=B8=AD=E5=86=97=
=E9=95=B7=E5=BA=A6=E3=83=BB=E3=83=8F=E3=83=BC=E3=83=89=E3=83=AA=E3=83=B3=
=E3=82=AF)"
=20
-#: lib/choose_repository.tcl:501
+#: lib/choose_repository.tcl:499
 msgid "Full Copy (Slower, Redundant Backup)"
 msgstr "=E5=85=A8=E8=A4=87=E5=86=99(=E4=BD=8E=E9=80=9F=E3=83=BB=E5=86=97=
=E9=95=B7=E3=83=90=E3=83=83=E3=82=AF=E3=82=A2=E3=83=83=E3=83=97)"
=20
-#: lib/choose_repository.tcl:507
+#: lib/choose_repository.tcl:505
 msgid "Shared (Fastest, Not Recommended, No Backup)"
 msgstr "=E5=85=B1=E6=9C=89(=E6=9C=80=E9=AB=98=E9=80=9F=E3=83=BB=E9=9D=9E=
=E6=8E=A8=E5=A5=A8=E3=83=BB=E3=83=90=E3=83=83=E3=82=AF=E3=82=A2=E3=83=83=
=E3=83=97=E7=84=A1=E3=81=97)"
=20
-#: lib/choose_repository.tcl:543 lib/choose_repository.tcl:590
-#: lib/choose_repository.tcl:736 lib/choose_repository.tcl:806
-#: lib/choose_repository.tcl:1017 lib/choose_repository.tcl:1025
+#: lib/choose_repository.tcl:541 lib/choose_repository.tcl:588
+#: lib/choose_repository.tcl:734 lib/choose_repository.tcl:804
+#: lib/choose_repository.tcl:1013 lib/choose_repository.tcl:1021
 #, tcl-format
 msgid "Not a Git repository: %s"
 msgstr "Git =E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA=E3=81=A7=E3=81=
=AF=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93: %s"
=20
-#: lib/choose_repository.tcl:579
+#: lib/choose_repository.tcl:577
 msgid "Standard only available for local repository."
 msgstr "=E6=A8=99=E6=BA=96=E6=96=B9=E5=BC=8F=E3=81=AF=E5=90=8C=E4=B8=80=
=E8=A8=88=E7=AE=97=E6=A9=9F=E4=B8=8A=E3=81=AE=E3=83=AA=E3=83=9D=E3=82=B8=
=E3=83=88=E3=83=AA=E3=81=AB=E3=81=AE=E3=81=BF=E4=BD=BF=E3=81=88=E3=81=BE=
=E3=81=99=E3=80=82"
=20
-#: lib/choose_repository.tcl:583
+#: lib/choose_repository.tcl:581
 msgid "Shared only available for local repository."
 msgstr "=E5=85=B1=E6=9C=89=E6=96=B9=E5=BC=8F=E3=81=AF=E5=90=8C=E4=B8=80=
=E8=A8=88=E7=AE=97=E6=A9=9F=E4=B8=8A=E3=81=AE=E3=83=AA=E3=83=9D=E3=82=B8=
=E3=83=88=E3=83=AA=E3=81=AB=E3=81=AE=E3=81=BF=E4=BD=BF=E3=81=88=E3=81=BE=
=E3=81=99=E3=80=82"
=20
-#: lib/choose_repository.tcl:604
+#: lib/choose_repository.tcl:602
 #, tcl-format
 msgid "Location %s already exists."
 msgstr "'%s' =E3=81=AF=E6=97=A2=E3=81=AB=E5=AD=98=E5=9C=A8=E3=81=97=E3=
=81=BE=E3=81=99=E3=80=82"
=20
-#: lib/choose_repository.tcl:615
+#: lib/choose_repository.tcl:613
 msgid "Failed to configure origin"
 msgstr "origin =E3=82=92=E8=A8=AD=E5=AE=9A=E3=81=A7=E3=81=8D=E3=81=BE=E3=
=81=9B=E3=82=93=E3=81=A7=E3=81=97=E3=81=9F"
=20
-#: lib/choose_repository.tcl:627
+#: lib/choose_repository.tcl:625
 msgid "Counting objects"
 msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=
=E6=95=B0=E3=81=88=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
=20
-#: lib/choose_repository.tcl:628
+#: lib/choose_repository.tcl:626
 msgid "buckets"
 msgstr "=E3=83=90=E3=82=B1=E3=83=84"
=20
-#: lib/choose_repository.tcl:652
+#: lib/choose_repository.tcl:650
 #, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
 msgstr "objects/info/alternates =E3=82=92=E8=A4=87=E5=86=99=E3=81=A7=E3=
=81=8D=E3=81=BE=E3=81=9B=E3=82=93: %s"
=20
-#: lib/choose_repository.tcl:688
+#: lib/choose_repository.tcl:686
 #, tcl-format
 msgid "Nothing to clone from %s."
 msgstr "%s =E3=81=8B=E3=82=89=E8=A4=87=E8=A3=BD=E3=81=99=E3=82=8B=E5=86=
=85=E5=AE=B9=E3=81=AF=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93"
=20
-#: lib/choose_repository.tcl:690 lib/choose_repository.tcl:904
-#: lib/choose_repository.tcl:916
+#: lib/choose_repository.tcl:688 lib/choose_repository.tcl:902
+#: lib/choose_repository.tcl:914
 msgid "The 'master' branch has not been initialized."
 msgstr "'master' =E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=81=8C=E5=88=9D=
=E6=9C=9F=E5=8C=96=E3=81=95=E3=82=8C=E3=81=A6=E3=81=84=E3=81=BE=E3=81=9B=
=E3=82=93"
=20
-#: lib/choose_repository.tcl:703
+#: lib/choose_repository.tcl:701
 msgid "Hardlinks are unavailable.  Falling back to copying."
 msgstr "=E3=83=8F=E3=83=BC=E3=83=89=E3=83=AA=E3=83=B3=E3=82=AF=E3=81=8C=
=E4=BD=9C=E3=82=8C=E3=81=AA=E3=81=84=E3=81=AE=E3=81=A7=E3=80=81=E3=82=B3=
=E3=83=94=E3=83=BC=E3=81=97=E3=81=BE=E3=81=99"
=20
-#: lib/choose_repository.tcl:715
+#: lib/choose_repository.tcl:713
 #, tcl-format
 msgid "Cloning from %s"
 msgstr "%s =E3=81=8B=E3=82=89=E8=A4=87=E8=A3=BD=E3=81=97=E3=81=A6=E3=81=
=84=E3=81=BE=E3=81=99"
=20
-#: lib/choose_repository.tcl:746
+#: lib/choose_repository.tcl:744
 msgid "Copying objects"
 msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=
=E8=A4=87=E5=86=99=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
=20
-#: lib/choose_repository.tcl:747
+#: lib/choose_repository.tcl:745
 msgid "KiB"
 msgstr "KiB"
=20
-#: lib/choose_repository.tcl:771
+#: lib/choose_repository.tcl:769
 #, tcl-format
 msgid "Unable to copy object: %s"
 msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=
=E8=A4=87=E5=86=99=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93: %s"
=20
-#: lib/choose_repository.tcl:781
+#: lib/choose_repository.tcl:779
 msgid "Linking objects"
 msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=
=E9=80=A3=E7=B5=90=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
=20
-#: lib/choose_repository.tcl:782
+#: lib/choose_repository.tcl:780
 msgid "objects"
 msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88"
=20
-#: lib/choose_repository.tcl:790
+#: lib/choose_repository.tcl:788
 #, tcl-format
 msgid "Unable to hardlink object: %s"
 msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=
=E3=83=8F=E3=83=BC=E3=83=89=E3=83=AA=E3=83=B3=E3=82=AF=E3=81=A7=E3=81=8D=
=E3=81=BE=E3=81=9B=E3=82=93: %s"
=20
-#: lib/choose_repository.tcl:845
+#: lib/choose_repository.tcl:843
 msgid "Cannot fetch branches and objects.  See console output for deta=
ils."
 msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=82=84=E3=82=AA=E3=83=96=
=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=E5=8F=96=E5=BE=97=E3=81=A7=
=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82=E3=82=B3=E3=83=B3=E3=82=BD=
=E3=83=BC=E3=83=AB=E5=87=BA=E5=8A=9B=E3=82=92=E8=A6=8B=E3=81=A6=E4=B8=8B=
=E3=81=95=E3=81=84"
=20
-#: lib/choose_repository.tcl:856
+#: lib/choose_repository.tcl:854
 msgid "Cannot fetch tags.  See console output for details."
 msgstr "=E3=82=BF=E3=82=B0=E3=82=92=E5=8F=96=E5=BE=97=E3=81=A7=E3=81=8D=
=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82=E3=82=B3=E3=83=B3=E3=82=BD=E3=83=BC=
=E3=83=AB=E5=87=BA=E5=8A=9B=E3=82=92=E8=A6=8B=E3=81=A6=E4=B8=8B=E3=81=95=
=E3=81=84"
=20
-#: lib/choose_repository.tcl:880
+#: lib/choose_repository.tcl:878
 msgid "Cannot determine HEAD.  See console output for details."
 msgstr "HEAD =E3=82=92=E7=A2=BA=E5=AE=9A=E3=81=A7=E3=81=8D=E3=81=BE=E3=
=81=9B=E3=82=93=E3=80=82=E3=82=B3=E3=83=B3=E3=82=BD=E3=83=BC=E3=83=AB=E5=
=87=BA=E5=8A=9B=E3=82=92=E8=A6=8B=E3=81=A6=E4=B8=8B=E3=81=95=E3=81=84"
=20
-#: lib/choose_repository.tcl:889
+#: lib/choose_repository.tcl:887
 #, tcl-format
 msgid "Unable to cleanup %s"
 msgstr "%s =E3=82=92=E6=8E=83=E9=99=A4=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=
=9B=E3=82=93"
=20
-#: lib/choose_repository.tcl:895
+#: lib/choose_repository.tcl:893
 msgid "Clone failed."
 msgstr "=E8=A4=87=E5=86=99=E3=81=AB=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=
=E3=81=97=E3=81=9F=E3=80=82"
=20
-#: lib/choose_repository.tcl:902
+#: lib/choose_repository.tcl:900
 msgid "No default branch obtained."
 msgstr "=E3=83=87=E3=83=95=E3=82=A9=E3=83=BC=E3=83=AB=E3=83=88=E3=83=BB=
=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=81=8C=E5=8F=96=E5=BE=97=E3=81=95=
=E3=82=8C=E3=81=BE=E3=81=9B=E3=82=93=E3=81=A7=E3=81=97=E3=81=9F"
=20
-#: lib/choose_repository.tcl:913
+#: lib/choose_repository.tcl:911
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
 msgstr "%s =E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=A8=E3=81=
=97=E3=81=A6=E8=A7=A3=E9=87=88=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=
=93"
=20
-#: lib/choose_repository.tcl:925
+#: lib/choose_repository.tcl:923
 msgid "Creating working directory"
 msgstr "=E4=BD=9C=E6=A5=AD=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=
=E3=83=AA=E3=82=92=E4=BD=9C=E6=88=90=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=
=E3=81=99"
=20
-#: lib/choose_repository.tcl:926 lib/index.tcl:65 lib/index.tcl:127
+#: lib/choose_repository.tcl:924 lib/index.tcl:65 lib/index.tcl:127
 #: lib/index.tcl:193
 msgid "files"
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB"
=20
-#: lib/choose_repository.tcl:955
+#: lib/choose_repository.tcl:953
 msgid "Initial file checkout failed."
 msgstr "=E5=88=9D=E6=9C=9F=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=E3=82=A2=
=E3=82=A6=E3=83=88=E3=81=AB=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=E3=81=97=
=E3=81=9F"
=20
-#: lib/choose_repository.tcl:971
+#: lib/choose_repository.tcl:969
 msgid "Open"
 msgstr "=E9=96=8B=E3=81=8F"
=20
-#: lib/choose_repository.tcl:981
+#: lib/choose_repository.tcl:979
 msgid "Repository:"
 msgstr "=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA:"
=20
-#: lib/choose_repository.tcl:1031
+#: lib/choose_repository.tcl:1027
 #, tcl-format
 msgid "Failed to open repository %s:"
 msgstr "=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA %s =E3=82=92=E9=96=
=8B=E3=81=91=E3=81=BE=E3=81=9B=E3=82=93:"
@@ -1405,7 +1427,7 @@ msgstr ""
 msgid "Invalid date from Git: %s"
 msgstr "Git =E3=81=8B=E3=82=89=E5=87=BA=E3=81=9F=E7=84=A1=E5=8A=B9=E3=81=
=AA=E6=97=A5=E4=BB=98: %s"
=20
-#: lib/diff.tcl:42
+#: lib/diff.tcl:44
 #, tcl-format
 msgid ""
 "No differences detected.\n"
@@ -1427,40 +1449,48 @@ msgstr ""
 "\n"
 "=E5=90=8C=E6=A7=98=E3=81=AA=E7=8A=B6=E6=85=8B=E3=81=AE=E3=83=95=E3=82=
=A1=E3=82=A4=E3=83=AB=E3=82=92=E6=8E=A2=E3=81=99=E3=81=9F=E3=82=81=E3=81=
=AB=E3=80=81=E8=87=AA=E5=8B=95=E7=9A=84=E3=81=AB=E5=86=8D=E3=82=B9=E3=82=
=AD=E3=83=A3=E3=83=B3=E3=82=92=E9=96=8B=E5=A7=8B=E3=81=97=E3=81=BE=E3=81=
=99=E3=80=82"
=20
-#: lib/diff.tcl:81
+#: lib/diff.tcl:83
 #, tcl-format
 msgid "Loading diff of %s..."
 msgstr "%s =E3=81=AE=E5=A4=89=E6=9B=B4=E7=82=B9=E3=82=92=E3=83=AD=E3=83=
=BC=E3=83=89=E4=B8=AD=E2=80=A6"
=20
-#: lib/diff.tcl:114 lib/diff.tcl:184
+#: lib/diff.tcl:116 lib/diff.tcl:190
 #, tcl-format
 msgid "Unable to display %s"
 msgstr "%s =E3=82=92=E8=A1=A8=E7=A4=BA=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=
=9B=E3=82=93"
=20
-#: lib/diff.tcl:115
+#: lib/diff.tcl:117
 msgid "Error loading file:"
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=82=92=E8=AA=AD=E3=82=80=
=E9=9A=9B=E3=81=AE=E3=82=A8=E3=83=A9=E3=83=BC=E3=81=A7=E3=81=99:"
=20
-#: lib/diff.tcl:122
+#: lib/diff.tcl:124
 msgid "Git Repository (subproject)"
 msgstr "Git =E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA(=E3=82=B5=E3=
=83=96=E3=83=97=E3=83=AD=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88)"
=20
-#: lib/diff.tcl:134
+#: lib/diff.tcl:136
 msgid "* Binary file (not showing content)."
 msgstr "* =E3=83=90=E3=82=A4=E3=83=8A=E3=83=AA=E3=83=95=E3=82=A1=E3=82=
=A4=E3=83=AB(=E5=86=85=E5=AE=B9=E3=81=AF=E8=A1=A8=E7=A4=BA=E3=81=97=E3=81=
=BE=E3=81=9B=E3=82=93)"
=20
-#: lib/diff.tcl:185
+#: lib/diff.tcl:191
 msgid "Error loading diff:"
 msgstr "diff =E3=82=92=E8=AA=AD=E3=82=80=E9=9A=9B=E3=81=AE=E3=82=A8=E3=
=83=A9=E3=83=BC=E3=81=A7=E3=81=99:"
=20
-#: lib/diff.tcl:303
+#: lib/diff.tcl:313
 msgid "Failed to unstage selected hunk."
 msgstr "=E9=81=B8=E6=8A=9E=E3=81=95=E3=82=8C=E3=81=9F=E3=83=91=E3=83=83=
=E3=83=81=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=
=E3=81=8B=E3=82=89=E5=A4=96=E3=81=9B=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82=
"
=20
-#: lib/diff.tcl:310
+#: lib/diff.tcl:320
 msgid "Failed to stage selected hunk."
 msgstr "=E9=81=B8=E6=8A=9E=E3=81=95=E3=82=8C=E3=81=9F=E3=83=91=E3=83=83=
=E3=83=81=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=
=E3=81=AB=E5=8A=A0=E3=81=88=E3=82=89=E3=82=8C=E3=81=BE=E3=81=9B=E3=82=93=
=E3=80=82"
=20
+#: lib/diff.tcl:386
+msgid "Failed to unstage selected line."
+msgstr "=E9=81=B8=E6=8A=9E=E3=81=95=E3=82=8C=E3=81=9F=E3=83=91=E3=83=83=
=E3=83=81=E8=A1=8C=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=
=E5=AE=9A=E3=81=8B=E3=82=89=E5=A4=96=E3=81=9B=E3=81=BE=E3=81=9B=E3=82=93=
=E3=80=82"
+
+#: lib/diff.tcl:394
+msgid "Failed to stage selected line."
+msgstr "=E9=81=B8=E6=8A=9E=E3=81=95=E3=82=8C=E3=81=9F=E3=83=91=E3=83=83=
=E3=83=81=E8=A1=8C=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=
=E5=AE=9A=E3=81=AB=E5=8A=A0=E3=81=88=E3=82=89=E3=82=8C=E3=81=BE=E3=81=9B=
=E3=82=93=E3=80=82"
+
 #: lib/error.tcl:20 lib/error.tcl:114
 msgid "error"
 msgstr "=E3=82=A8=E3=83=A9=E3=83=BC"
@@ -1662,11 +1692,11 @@ msgstr "=E4=B8=AD=E6=96=AD=E3=81=97=E3=81=A6=E3=
=81=84=E3=81=BE=E3=81=99"
 msgid "files reset"
 msgstr "=E3=83=AA=E3=82=BB=E3=83=83=E3=83=88=E3=81=97=E3=81=9F=E3=83=95=
=E3=82=A1=E3=82=A4=E3=83=AB"
=20
-#: lib/merge.tcl:265
+#: lib/merge.tcl:266
 msgid "Abort failed."
 msgstr "=E4=B8=AD=E6=96=AD=E3=81=AB=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=
=E3=81=97=E3=81=9F=E3=80=82"
=20
-#: lib/merge.tcl:267
+#: lib/merge.tcl:268
 msgid "Abort completed.  Ready."
 msgstr "=E4=B8=AD=E6=96=AD=E5=AE=8C=E4=BA=86=E3=80=82"
=20
@@ -1720,42 +1750,62 @@ msgid "Match Tracking Branches"
 msgstr "=E3=83=88=E3=83=A9=E3=83=83=E3=82=AD=E3=83=B3=E3=82=B0=E3=83=96=
=E3=83=A9=E3=83=B3=E3=83=81=E3=82=92=E5=90=88=E3=82=8F=E3=81=9B=E3=82=8B=
"
=20
 #: lib/option.tcl:126
+msgid "Blame Copy Only On Changed Files"
+msgstr "=E5=A4=89=E6=9B=B4=E3=81=95=E3=82=8C=E3=81=9F=E3=83=95=E3=82=A1=
=E3=82=A4=E3=83=AB=E3=81=AE=E3=81=BF=E3=82=B3=E3=83=94=E3=83=BC=E6=A4=9C=
=E7=9F=A5=E3=82=92=E8=A1=8C=E3=81=AA=E3=81=86"
+
+#: lib/option.tcl:127
+msgid "Minimum Letters To Blame Copy On"
+msgstr "=E3=82=B3=E3=83=94=E3=83=BC=E3=82=92=E6=A4=9C=E7=9F=A5=E3=81=99=
=E3=82=8B=E6=9C=80=E5=B0=91=E6=96=87=E5=AD=97=E6=95=B0"
+
+#: lib/option.tcl:128
 msgid "Number of Diff Context Lines"
 msgstr "diff =E3=81=AE=E6=96=87=E8=84=88=E8=A1=8C=E6=95=B0"
=20
-#: lib/option.tcl:127
+#: lib/option.tcl:129
 msgid "Commit Message Text Width"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=83=A1=E3=83=83=E3=82=BB=
=E3=83=BC=E3=82=B8=E3=81=AE=E3=83=86=E3=82=AD=E3=82=B9=E3=83=88=E5=B9=85=
"
=20
-#: lib/option.tcl:128
+#: lib/option.tcl:130
 msgid "New Branch Name Template"
 msgstr "=E6=96=B0=E3=81=97=E3=81=84=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
=E5=90=8D=E3=81=AE=E3=83=86=E3=83=B3=E3=83=97=E3=83=AC=E3=83=BC=E3=83=88=
"
=20
-#: lib/option.tcl:192
+#: lib/option.tcl:194
 msgid "Spelling Dictionary:"
 msgstr "=E3=82=B9=E3=83=9A=E3=83=AB=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=
=E8=BE=9E=E6=9B=B8"
=20
-#: lib/option.tcl:216
+#: lib/option.tcl:218
 msgid "Change Font"
 msgstr "=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88=E3=82=92=E5=A4=89=E6=9B=B4=
"
=20
-#: lib/option.tcl:220
+#: lib/option.tcl:222
 #, tcl-format
 msgid "Choose %s"
 msgstr "%s =E3=82=92=E9=81=B8=E6=8A=9E"
=20
-#: lib/option.tcl:226
+#: lib/option.tcl:228
 msgid "pt."
 msgstr "=E3=83=9D=E3=82=A4=E3=83=B3=E3=83=88"
=20
-#: lib/option.tcl:240
+#: lib/option.tcl:242
 msgid "Preferences"
 msgstr "=E8=A8=AD=E5=AE=9A"
=20
-#: lib/option.tcl:275
+#: lib/option.tcl:277
 msgid "Failed to completely save options:"
 msgstr "=E5=AE=8C=E5=85=A8=E3=81=AB=E3=82=AA=E3=83=97=E3=82=B7=E3=83=A7=
=E3=83=B3=E3=82=92=E4=BF=9D=E5=AD=98=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=
=E3=82=93:"
=20
+#: lib/remote.tcl:165
+msgid "Prune from"
+msgstr "=E3=81=8B=E3=82=89=E5=88=88=E8=BE=BC=E3=82=80=E2=80=A6"
+
+#: lib/remote.tcl:170
+msgid "Fetch from"
+msgstr "=E5=8F=96=E5=BE=97=E5=85=83"
+
+#: lib/remote.tcl:213
+msgid "Push to"
+msgstr "=E3=83=97=E3=83=83=E3=82=B7=E3=83=A5=E5=85=88"
+
 #: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
 msgid "Delete Remote Branch"
 msgstr "=E3=83=AA=E3=83=A2=E3=83=BC=E3=83=88=E3=83=BB=E3=83=96=E3=83=A9=
=E3=83=B3=E3=83=81=E3=82=92=E5=89=8A=E9=99=A4"
@@ -1840,18 +1890,6 @@ msgstr "=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=
=AA=E3=81=8C=E9=81=B8=E6=8A=9E=E3=81=95=E3=82=8C=E3=81=A6=E3=81=84=E3=81=
=BE=E3=81=9B=E3=82=93=E3=80=82"
 msgid "Scanning %s..."
 msgstr "%s =E3=82=92=E3=82=B9=E3=82=AD=E3=83=A3=E3=83=B3=E3=81=97=E3=81=
=A6=E3=81=84=E3=81=BE=E3=81=99=E2=80=A6"
=20
-#: lib/remote.tcl:165
-msgid "Prune from"
-msgstr "=E3=81=8B=E3=82=89=E5=88=88=E8=BE=BC=E3=82=80=E2=80=A6"
-
-#: lib/remote.tcl:170
-msgid "Fetch from"
-msgstr "=E5=8F=96=E5=BE=97=E5=85=83"
-
-#: lib/remote.tcl:213
-msgid "Push to"
-msgstr "=E3=83=97=E3=83=83=E3=82=B7=E3=83=A5=E5=85=88"
-
 #: lib/shortcut.tcl:20 lib/shortcut.tcl:61
 msgid "Cannot write shortcut:"
 msgstr "=E3=82=B7=E3=83=A7=E3=83=BC=E3=83=88=E3=82=AB=E3=83=83=E3=83=88=
=E3=81=8C=E6=9B=B8=E3=81=91=E3=81=BE=E3=81=9B=E3=82=93:"
@@ -1885,15 +1923,15 @@ msgstr "=E3=82=B9=E3=83=9A=E3=83=AB=E3=83=81=E3=
=82=A7=E3=83=83=E3=82=AB=E3=83=BC=E3=81=AE=E8=B5=B7=E5=8B=95=E3=81=AB=E5=
=A4=B1=E6=95=97=E3=81=97=E3=81=BE=E3=81=97=E3=81=9F"
 msgid "Unrecognized spell checker"
 msgstr "=E3=82=B9=E3=83=9A=E3=83=AB=E3=83=81=E3=82=A7=E3=83=83=E3=82=AB=
=E3=83=BC=E3=81=8C=E5=88=A4=E5=88=A5=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=
=E3=82=93"
=20
-#: lib/spellcheck.tcl:180
+#: lib/spellcheck.tcl:186
 msgid "No Suggestions"
 msgstr "=E6=8F=90=E6=A1=88=E3=81=AA=E3=81=97"
=20
-#: lib/spellcheck.tcl:381
+#: lib/spellcheck.tcl:387
 msgid "Unexpected EOF from spell checker"
 msgstr "=E3=82=B9=E3=83=9A=E3=83=AB=E3=83=81=E3=82=A7=E3=83=83=E3=82=AB=
=E3=83=BC=E3=81=8C=E4=BA=88=E6=83=B3=E5=A4=96=E3=81=AE EOF =E3=82=92=E8=
=BF=94=E3=81=97=E3=81=BE=E3=81=97=E3=81=9F"
=20
-#: lib/spellcheck.tcl:385
+#: lib/spellcheck.tcl:391
 msgid "Spell Checker Failed"
 msgstr "=E3=82=B9=E3=83=9A=E3=83=AB=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=
=E5=A4=B1=E6=95=97"
=20
@@ -1964,6 +2002,3 @@ msgstr "Thin Pack =E3=82=92=E4=BD=BF=E3=81=86=EF=BC=
=88=E9=81=85=E3=81=84=E3=83=8D=E3=83=83=E3=83=88=E3=83=AF=E3=83=BC=E3=82=
=AF=E6=8E=A5=E7=B6=9A=EF=BC=89"
 #: lib/transport.tcl:168
 msgid "Include tags"
 msgstr "=E3=82=BF=E3=82=B0=E3=82=92=E5=90=AB=E3=82=81=E3=82=8B"
-
-#~ msgid "Not connected to aspell"
-#~ msgstr "aspell =E3=81=AB=E6=8E=A5=E7=B6=9A=E3=81=97=E3=81=A6=E3=81=84=
=E3=81=BE=E3=81=9B=E3=82=93"
--=20
1.6.0.rc1
