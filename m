From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] git-gui: update Japanese translation
Date: Wed, 26 Nov 2008 19:21:44 +0900
Message-ID: <20081126192144.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 26 11:24:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5HYr-0005fP-ET
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 11:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbYKZKWl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Nov 2008 05:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbYKZKWk
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 05:22:40 -0500
Received: from karen.lavabit.com ([72.249.41.33]:57134 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827AbYKZKWh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 05:22:37 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 80291C8428;
	Wed, 26 Nov 2008 04:22:35 -0600 (CST)
Received: from 7853.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id ALMK394ILUK2; Wed, 26 Nov 2008 04:22:35 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=rN3tG7L/p5gEQY2B0gWfztT8/x1KIMDaKbgEoc3ZKIRYT/zc9aaMNxPrE+Cm15mLC6YnLgvKrBP0zT+NjDk11BahBX1H36obGim0RP6ncYZ9k0b0YZIsTRgHraVKcIffC6HTCWIMtS/H9nxgVGRXq6tHT3urkO7QE5I2eOb6YaE=;
  h=From:To:cc:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101723>

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 po/ja.po | 1127 ++++++++++++++++++++++++++++++++++++++++++++++--------=
--------
 1 files changed, 833 insertions(+), 294 deletions(-)

diff --git a/po/ja.po b/po/ja.po
index 5db44a4..0cd6740 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -8,41 +8,41 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git-gui\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2008-08-02 14:45-0700\n"
-"PO-Revision-Date: 2008-08-03 17:00+0900\n"
+"POT-Creation-Date: 2008-11-16 13:56-0800\n"
+"PO-Revision-Date: 2008-11-26 19:17+0900\n"
 "Last-Translator: =E3=81=97=E3=82=89=E3=81=84=E3=81=97 =E3=81=AA=E3=81=
=AA=E3=81=93 <nanako3@lavabit.com>\n"
 "Language-Team: Japanese\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
=20
-#: git-gui.sh:41 git-gui.sh:688 git-gui.sh:702 git-gui.sh:715 git-gui.=
sh:798
-#: git-gui.sh:817
+#: git-gui.sh:41 git-gui.sh:737 git-gui.sh:751 git-gui.sh:764 git-gui.=
sh:847
+#: git-gui.sh:866
 msgid "git-gui: fatal error"
 msgstr "git-gui: =E8=87=B4=E5=91=BD=E7=9A=84=E3=81=AA=E3=82=A8=E3=83=A9=
=E3=83=BC"
=20
-#: git-gui.sh:644
+#: git-gui.sh:689
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr "%s =E3=81=AB=E7=84=A1=E5=8A=B9=E3=81=AA=E3=83=95=E3=82=A9=E3=83=
=B3=E3=83=88=E3=81=8C=E6=8C=87=E5=AE=9A=E3=81=95=E3=82=8C=E3=81=A6=E3=81=
=84=E3=81=BE=E3=81=99:"
=20
-#: git-gui.sh:674
+#: git-gui.sh:723
 msgid "Main Font"
 msgstr "=E4=B8=BB=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88"
=20
-#: git-gui.sh:675
+#: git-gui.sh:724
 msgid "Diff/Console Font"
 msgstr "diff/=E3=82=B3=E3=83=B3=E3=82=BD=E3=83=BC=E3=83=AB=E3=83=BB=E3=
=83=95=E3=82=A9=E3=83=B3=E3=83=88"
=20
-#: git-gui.sh:689
+#: git-gui.sh:738
 msgid "Cannot find git in PATH."
 msgstr "PATH =E4=B8=AD=E3=81=AB git =E3=81=8C=E8=A6=8B=E3=81=A4=E3=81=8B=
=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93"
=20
-#: git-gui.sh:716
+#: git-gui.sh:765
 msgid "Cannot parse Git version string:"
 msgstr "Git =E3=83=90=E3=83=BC=E3=82=B8=E3=83=A7=E3=83=B3=E5=90=8D=E3=81=
=8C=E7=90=86=E8=A7=A3=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93:"
=20
-#: git-gui.sh:734
+#: git-gui.sh:783
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -61,381 +61,446 @@ msgstr ""
 "\n"
 "'%s' =E3=81=AF=E3=83=90=E3=83=BC=E3=82=B8=E3=83=A7=E3=83=B3 1.5.0 =E3=
=81=A8=E6=80=9D=E3=81=A3=E3=81=A6=E8=89=AF=E3=81=84=E3=81=A7=E3=81=99=E3=
=81=8B=EF=BC=9F\n"
=20
-#: git-gui.sh:972
+#: git-gui.sh:1062
 msgid "Git directory not found:"
 msgstr "Git =E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=E3=83=AA=E3=81=
=8C=E8=A6=8B=E3=81=A4=E3=81=8B=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93:"
=20
-#: git-gui.sh:979
+#: git-gui.sh:1069
 msgid "Cannot move to top of working directory:"
 msgstr "=E4=BD=9C=E6=A5=AD=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=
=E3=83=AA=E3=81=AE=E6=9C=80=E4=B8=8A=E4=BD=8D=E3=81=AB=E7=A7=BB=E5=8B=95=
=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93"
=20
-#: git-gui.sh:986
+#: git-gui.sh:1076
 msgid "Cannot use funny .git directory:"
 msgstr "=E5=A4=89=E3=81=AA .git =E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=
=83=88=E3=83=AA=E3=81=AF=E4=BD=BF=E3=81=88=E3=81=BE=E3=81=9B=E3=82=93"
=20
-#: git-gui.sh:991
+#: git-gui.sh:1081
 msgid "No working directory"
 msgstr "=E4=BD=9C=E6=A5=AD=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=
=E3=83=AA=E3=81=8C=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93"
=20
-#: git-gui.sh:1138 lib/checkout_op.tcl:305
+#: git-gui.sh:1247 lib/checkout_op.tcl:305
 msgid "Refreshing file status..."
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E7=8A=B6=E6=85=8B=E3=82=92=
=E6=9B=B4=E6=96=B0=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99=E2=80=A6=
"
=20
-#: git-gui.sh:1194
+#: git-gui.sh:1303
 msgid "Scanning for modified files ..."
 msgstr "=E5=A4=89=E6=9B=B4=E3=81=95=E3=82=8C=E3=81=9F=E3=83=95=E3=82=A1=
=E3=82=A4=E3=83=AB=E3=82=92=E3=82=B9=E3=82=AD=E3=83=A3=E3=83=B3=E3=81=97=
=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99=E2=80=A6"
=20
-#: git-gui.sh:1369 lib/browser.tcl:246
+#: git-gui.sh:1367
+msgid "Calling prepare-commit-msg hook..."
+msgstr "prepare-commit-msg =E3=83=95=E3=83=83=E3=82=AF=E3=82=92=E5=AE=9F=
=E8=A1=8C=E4=B8=AD=E3=83=BB=E3=83=BB=E3=83=BB"
+
+#: git-gui.sh:1384
+msgid "Commit declined by prepare-commit-msg hook."
+msgstr "prepare-commit-msg =E3=83=95=E3=83=83=E3=82=AF=E3=81=8C=E3=82=B3=
=E3=83=9F=E3=83=83=E3=83=88=E3=82=92=E6=8B=92=E5=90=A6=E3=81=97=E3=81=BE=
=E3=81=97=E3=81=9F"
+
+#: git-gui.sh:1542 lib/browser.tcl:246
 msgid "Ready."
 msgstr "=E6=BA=96=E5=82=99=E5=AE=8C=E4=BA=86"
=20
-#: git-gui.sh:1635
+#: git-gui.sh:1819
 msgid "Unmodified"
 msgstr "=E5=A4=89=E6=9B=B4=E7=84=A1=E3=81=97"
=20
-#: git-gui.sh:1637
+#: git-gui.sh:1821
 msgid "Modified, not staged"
 msgstr "=E5=A4=89=E6=9B=B4=E3=81=82=E3=82=8A=E3=80=81=E3=82=B3=E3=83=9F=
=E3=83=83=E3=83=88=E6=9C=AA=E4=BA=88=E5=AE=9A"
=20
-#: git-gui.sh:1638 git-gui.sh:1643
+#: git-gui.sh:1822 git-gui.sh:1830
 msgid "Staged for commit"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=E6=B8=88=
"
=20
-#: git-gui.sh:1639 git-gui.sh:1644
+#: git-gui.sh:1823 git-gui.sh:1831
 msgid "Portions staged for commit"
 msgstr "=E9=83=A8=E5=88=86=E7=9A=84=E3=81=AB=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E4=BA=88=E5=AE=9A=E6=B8=88"
=20
-#: git-gui.sh:1640 git-gui.sh:1645
+#: git-gui.sh:1824 git-gui.sh:1832
 msgid "Staged for commit, missing"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=E6=B8=88=
=E3=80=81=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E7=84=A1=E3=81=97"
=20
-#: git-gui.sh:1642
+#: git-gui.sh:1826
+msgid "File type changed, not staged"
+msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E5=9E=8B=E5=A4=89=E6=9B=B4=
=E3=80=81=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E6=9C=AA=E4=BA=88=E5=AE=9A=
"
+
+#: git-gui.sh:1827
+msgid "File type changed, staged"
+msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E5=9E=8B=E5=A4=89=E6=9B=B4=
=E3=80=81=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=E6=B8=88=
"
+
+#: git-gui.sh:1829
 msgid "Untracked, not staged"
 msgstr "=E7=AE=A1=E7=90=86=E5=A4=96=E3=80=81=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E6=9C=AA=E4=BA=88=E5=AE=9A"
=20
-#: git-gui.sh:1647
+#: git-gui.sh:1834
 msgid "Missing"
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E7=84=A1=E3=81=97"
=20
-#: git-gui.sh:1648
+#: git-gui.sh:1835
 msgid "Staged for removal"
 msgstr "=E5=89=8A=E9=99=A4=E4=BA=88=E5=AE=9A=E6=B8=88"
=20
-#: git-gui.sh:1649
+#: git-gui.sh:1836
 msgid "Staged for removal, still present"
 msgstr "=E5=89=8A=E9=99=A4=E4=BA=88=E5=AE=9A=E6=B8=88=E3=80=81=E3=83=95=
=E3=82=A1=E3=82=A4=E3=83=AB=E6=9C=AA=E5=89=8A=E9=99=A4"
=20
-#: git-gui.sh:1651 git-gui.sh:1652 git-gui.sh:1653 git-gui.sh:1654
+#: git-gui.sh:1838 git-gui.sh:1839 git-gui.sh:1840 git-gui.sh:1841
+#: git-gui.sh:1842 git-gui.sh:1843
 msgid "Requires merge resolution"
 msgstr "=E8=A6=81=E3=83=9E=E3=83=BC=E3=82=B8=E8=A7=A3=E6=B1=BA"
=20
-#: git-gui.sh:1689
+#: git-gui.sh:1878
 msgid "Starting gitk... please wait..."
 msgstr "gitk =E3=82=92=E8=B5=B7=E5=8B=95=E4=B8=AD=E2=80=A6=E3=81=8A=E5=
=BE=85=E3=81=A1=E4=B8=8B=E3=81=95=E3=81=84=E2=80=A6"
=20
-#: git-gui.sh:1698
+#: git-gui.sh:1887
 msgid "Couldn't find gitk in PATH"
 msgstr "PATH =E4=B8=AD=E3=81=AB gitk =E3=81=8C=E8=A6=8B=E3=81=A4=E3=81=
=8B=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93"
=20
-#: git-gui.sh:1948 lib/choose_repository.tcl:36
+#: git-gui.sh:2280 lib/choose_repository.tcl:36
 msgid "Repository"
 msgstr "=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA"
=20
-#: git-gui.sh:1949
+#: git-gui.sh:2281
 msgid "Edit"
 msgstr "=E7=B7=A8=E9=9B=86"
=20
-#: git-gui.sh:1951 lib/choose_rev.tcl:561
+#: git-gui.sh:2283 lib/choose_rev.tcl:561
 msgid "Branch"
 msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81"
=20
-#: git-gui.sh:1954 lib/choose_rev.tcl:548
+#: git-gui.sh:2286 lib/choose_rev.tcl:548
 msgid "Commit@@noun"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88"
=20
-#: git-gui.sh:1957 lib/merge.tcl:120 lib/merge.tcl:149 lib/merge.tcl:1=
67
+#: git-gui.sh:2289 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
 msgid "Merge"
 msgstr "=E3=83=9E=E3=83=BC=E3=82=B8"
=20
-#: git-gui.sh:1958 lib/choose_rev.tcl:557
+#: git-gui.sh:2290 lib/choose_rev.tcl:557
 msgid "Remote"
 msgstr "=E3=83=AA=E3=83=A2=E3=83=BC=E3=83=88"
=20
-#: git-gui.sh:1967
+#: git-gui.sh:2293
+msgid "Tools"
+msgstr "=E3=83=84=E3=83=BC=E3=83=AB"
+
+#: git-gui.sh:2302
+msgid "Explore Working Copy"
+msgstr "=E3=83=AF=E3=83=BC=E3=82=AD=E3=83=B3=E3=82=B0=E3=82=B3=E3=83=94=
=E3=83=BC=E3=82=92=E3=83=96=E3=83=A9=E3=82=A6=E3=82=BA"
+
+#: git-gui.sh:2307
 msgid "Browse Current Branch's Files"
 msgstr "=E7=8F=BE=E5=9C=A8=E3=81=AE=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
=E3=81=AE=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=82=92=E8=A6=8B=E3=82=8B=
"
=20
-#: git-gui.sh:1971
+#: git-gui.sh:2311
 msgid "Browse Branch Files..."
 msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=81=AE=E3=83=95=E3=82=A1=
=E3=82=A4=E3=83=AB=E3=82=92=E8=A6=8B=E3=82=8B=E2=80=A6"
=20
-#: git-gui.sh:1976
+#: git-gui.sh:2316
 msgid "Visualize Current Branch's History"
 msgstr "=E7=8F=BE=E5=9C=A8=E3=81=AE=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
=E3=81=AE=E5=B1=A5=E6=AD=B4=E3=82=92=E8=A6=8B=E3=82=8B"
=20
-#: git-gui.sh:1980
+#: git-gui.sh:2320
 msgid "Visualize All Branch History"
 msgstr "=E5=85=A8=E3=81=A6=E3=81=AE=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
=E3=81=AE=E5=B1=A5=E6=AD=B4=E3=82=92=E8=A6=8B=E3=82=8B"
=20
-#: git-gui.sh:1987
+#: git-gui.sh:2327
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81 %s =E3=81=AE=E3=83=95=E3=82=
=A1=E3=82=A4=E3=83=AB=E3=82=92=E8=A6=8B=E3=82=8B"
=20
-#: git-gui.sh:1989
+#: git-gui.sh:2329
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81 %s =E3=81=AE=E5=B1=A5=E6=AD=
=B4=E3=82=92=E8=A6=8B=E3=82=8B"
=20
-#: git-gui.sh:1994 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:2334 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr "=E3=83=87=E3=83=BC=E3=82=BF=E3=83=99=E3=83=BC=E3=82=B9=E7=B5=B1=
=E8=A8=88"
=20
-#: git-gui.sh:1997 lib/database.tcl:34
+#: git-gui.sh:2337 lib/database.tcl:34
 msgid "Compress Database"
 msgstr "=E3=83=87=E3=83=BC=E3=82=BF=E3=83=99=E3=83=BC=E3=82=B9=E5=9C=A7=
=E7=B8=AE"
=20
-#: git-gui.sh:2000
+#: git-gui.sh:2340
 msgid "Verify Database"
 msgstr "=E3=83=87=E3=83=BC=E3=82=BF=E3=83=99=E3=83=BC=E3=82=B9=E6=A4=9C=
=E8=A8=BC"
=20
-#: git-gui.sh:2007 git-gui.sh:2011 git-gui.sh:2015 lib/shortcut.tcl:7
+#: git-gui.sh:2347 git-gui.sh:2351 git-gui.sh:2355 lib/shortcut.tcl:7
 #: lib/shortcut.tcl:39 lib/shortcut.tcl:71
 msgid "Create Desktop Icon"
 msgstr "=E3=83=87=E3=82=B9=E3=82=AF=E3=83=88=E3=83=83=E3=83=97=E3=83=BB=
=E3=82=A2=E3=82=A4=E3=82=B3=E3=83=B3=E3=82=92=E4=BD=9C=E3=82=8B"
=20
-#: git-gui.sh:2023 lib/choose_repository.tcl:177 lib/choose_repository=
=2Etcl:185
+#: git-gui.sh:2363 lib/choose_repository.tcl:183 lib/choose_repository=
=2Etcl:191
 msgid "Quit"
 msgstr "=E7=B5=82=E4=BA=86"
=20
-#: git-gui.sh:2031
+#: git-gui.sh:2371
 msgid "Undo"
 msgstr "=E5=85=83=E3=81=AB=E6=88=BB=E3=81=99"
=20
-#: git-gui.sh:2034
+#: git-gui.sh:2374
 msgid "Redo"
 msgstr "=E3=82=84=E3=82=8A=E7=9B=B4=E3=81=97"
=20
-#: git-gui.sh:2038 git-gui.sh:2545
+#: git-gui.sh:2378 git-gui.sh:2923
 msgid "Cut"
 msgstr "=E5=88=87=E3=82=8A=E5=8F=96=E3=82=8A"
=20
-#: git-gui.sh:2041 git-gui.sh:2548 git-gui.sh:2622 git-gui.sh:2715
+#: git-gui.sh:2381 git-gui.sh:2926 git-gui.sh:3000 git-gui.sh:3082
 #: lib/console.tcl:69
 msgid "Copy"
 msgstr "=E3=82=B3=E3=83=94=E3=83=BC"
=20
-#: git-gui.sh:2044 git-gui.sh:2551
+#: git-gui.sh:2384 git-gui.sh:2929
 msgid "Paste"
 msgstr "=E8=B2=BC=E3=82=8A=E4=BB=98=E3=81=91"
=20
-#: git-gui.sh:2047 git-gui.sh:2554 lib/branch_delete.tcl:26
+#: git-gui.sh:2387 git-gui.sh:2932 lib/branch_delete.tcl:26
 #: lib/remote_branch_delete.tcl:38
 msgid "Delete"
 msgstr "=E5=89=8A=E9=99=A4"
=20
-#: git-gui.sh:2051 git-gui.sh:2558 git-gui.sh:2719 lib/console.tcl:71
+#: git-gui.sh:2391 git-gui.sh:2936 git-gui.sh:3086 lib/console.tcl:71
 msgid "Select All"
 msgstr "=E5=85=A8=E3=81=A6=E9=81=B8=E6=8A=9E"
=20
-#: git-gui.sh:2060
+#: git-gui.sh:2400
 msgid "Create..."
 msgstr "=E4=BD=9C=E6=88=90=E2=80=A6"
=20
-#: git-gui.sh:2066
+#: git-gui.sh:2406
 msgid "Checkout..."
 msgstr "=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=E3=82=A2=E3=82=A6=E3=83=88=
"
=20
-#: git-gui.sh:2072
+#: git-gui.sh:2412
 msgid "Rename..."
 msgstr "=E5=90=8D=E5=89=8D=E5=A4=89=E6=9B=B4=E2=80=A6"
=20
-#: git-gui.sh:2077 git-gui.sh:2187
+#: git-gui.sh:2417
 msgid "Delete..."
 msgstr "=E5=89=8A=E9=99=A4=E2=80=A6"
=20
-#: git-gui.sh:2082
+#: git-gui.sh:2422
 msgid "Reset..."
 msgstr "=E3=83=AA=E3=82=BB=E3=83=83=E3=83=88=E2=80=A6"
=20
-#: git-gui.sh:2094 git-gui.sh:2491
+#: git-gui.sh:2432
+msgid "Done"
+msgstr "=E5=AE=8C=E4=BA=86"
+
+#: git-gui.sh:2434
+msgid "Commit@@verb"
+msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88"
+
+#: git-gui.sh:2443 git-gui.sh:2864
 msgid "New Commit"
 msgstr "=E6=96=B0=E8=A6=8F=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88"
=20
-#: git-gui.sh:2102 git-gui.sh:2498
+#: git-gui.sh:2451 git-gui.sh:2871
 msgid "Amend Last Commit"
 msgstr "=E6=9C=80=E6=96=B0=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=82=92=
=E8=A8=82=E6=AD=A3"
=20
-#: git-gui.sh:2111 git-gui.sh:2458 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:2461 git-gui.sh:2825 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
 msgstr "=E5=86=8D=E3=82=B9=E3=82=AD=E3=83=A3=E3=83=B3"
=20
-#: git-gui.sh:2117
+#: git-gui.sh:2467
 msgid "Stage To Commit"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=E3=81=99=
=E3=82=8B"
=20
-#: git-gui.sh:2123
+#: git-gui.sh:2473
 msgid "Stage Changed Files To Commit"
 msgstr "=E5=A4=89=E6=9B=B4=E3=81=95=E3=82=8C=E3=81=9F=E3=83=95=E3=82=A1=
=E3=82=A4=E3=83=AB=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=
=E5=AE=9A"
=20
-#: git-gui.sh:2129
+#: git-gui.sh:2479
 msgid "Unstage From Commit"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=8B=E3=82=89=E9=99=8D=
=E3=82=8D=E3=81=99"
=20
-#: git-gui.sh:2134 lib/index.tcl:395
+#: git-gui.sh:2484 lib/index.tcl:410
 msgid "Revert Changes"
 msgstr "=E5=A4=89=E6=9B=B4=E3=82=92=E5=85=83=E3=81=AB=E6=88=BB=E3=81=99=
"
=20
-#: git-gui.sh:2141 git-gui.sh:2702
+#: git-gui.sh:2491 git-gui.sh:3069
 msgid "Show Less Context"
 msgstr "=E6=96=87=E8=84=88=E3=82=92=E5=B0=91=E3=81=AA=E3=81=8F"
=20
-#: git-gui.sh:2145 git-gui.sh:2706
+#: git-gui.sh:2495 git-gui.sh:3073
 msgid "Show More Context"
 msgstr "=E6=96=87=E8=84=88=E3=82=92=E5=A4=9A=E3=81=8F"
=20
-#: git-gui.sh:2151 git-gui.sh:2470 git-gui.sh:2569
+#: git-gui.sh:2502 git-gui.sh:2838 git-gui.sh:2947
 msgid "Sign Off"
 msgstr "=E7=BD=B2=E5=90=8D"
=20
-#: git-gui.sh:2155 git-gui.sh:2474
-msgid "Commit@@verb"
-msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88"
-
-#: git-gui.sh:2166
+#: git-gui.sh:2518
 msgid "Local Merge..."
 msgstr "=E3=83=AD=E3=83=BC=E3=82=AB=E3=83=AB=E3=83=BB=E3=83=9E=E3=83=BC=
=E3=82=B8=E2=80=A6"
=20
-#: git-gui.sh:2171
+#: git-gui.sh:2523
 msgid "Abort Merge..."
 msgstr "=E3=83=9E=E3=83=BC=E3=82=B8=E4=B8=AD=E6=AD=A2=E2=80=A6"
=20
-#: git-gui.sh:2183
+#: git-gui.sh:2535 git-gui.sh:2575
+msgid "Add..."
+msgstr "=E8=BF=BD=E5=8A=A0"
+
+#: git-gui.sh:2539
 msgid "Push..."
 msgstr "=E3=83=97=E3=83=83=E3=82=B7=E3=83=A5=E2=80=A6"
=20
-#: git-gui.sh:2197 git-gui.sh:2219 lib/about.tcl:14
-#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:50
+#: git-gui.sh:2543
+msgid "Delete Branch..."
+msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E5=89=8A=E9=99=A4..."
+
+#: git-gui.sh:2553 git-gui.sh:2589 lib/about.tcl:14
+#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
 #, tcl-format
 msgid "About %s"
 msgstr "%s =E3=81=AB=E3=81=A4=E3=81=84=E3=81=A6"
=20
-#: git-gui.sh:2201
+#: git-gui.sh:2557
 msgid "Preferences..."
 msgstr "=E8=A8=AD=E5=AE=9A=E2=80=A6"
=20
-#: git-gui.sh:2209 git-gui.sh:2740
+#: git-gui.sh:2565 git-gui.sh:3115
 msgid "Options..."
 msgstr "=E3=82=AA=E3=83=97=E3=82=B7=E3=83=A7=E3=83=B3=E2=80=A6"
=20
-#: git-gui.sh:2215 lib/choose_repository.tcl:47
+#: git-gui.sh:2576
+msgid "Remove..."
+msgstr "=E5=89=8A=E9=99=A4..."
+
+#: git-gui.sh:2585 lib/choose_repository.tcl:50
 msgid "Help"
 msgstr "=E3=83=98=E3=83=AB=E3=83=97"
=20
-#: git-gui.sh:2256
+#: git-gui.sh:2611
 msgid "Online Documentation"
 msgstr "=E3=82=AA=E3=83=B3=E3=83=A9=E3=82=A4=E3=83=B3=E3=83=BB=E3=83=89=
=E3=82=AD=E3=83=A5=E3=83=A1=E3=83=B3=E3=83=88"
=20
-#: git-gui.sh:2340
+#: git-gui.sh:2614 lib/choose_repository.tcl:47 lib/choose_repository.=
tcl:56
+msgid "Show SSH Key"
+msgstr "SSH =E3=82=AD=E3=83=BC=E3=82=92=E8=A1=A8=E7=A4=BA"
+
+#: git-gui.sh:2707
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
-#: git-gui.sh:2373
+#: git-gui.sh:2740
 msgid "Current Branch:"
 msgstr "=E7=8F=BE=E5=9C=A8=E3=81=AE=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
"
=20
-#: git-gui.sh:2394
+#: git-gui.sh:2761
 msgid "Staged Changes (Will Commit)"
 msgstr "=E3=82=B9=E3=83=86=E3=83=BC=E3=82=B8=E3=83=B3=E3=82=B0=E3=81=95=
=E3=82=8C=E3=81=9F=EF=BC=88=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=
=E5=AE=9A=E6=B8=88=E3=81=AE=EF=BC=89=E5=A4=89=E6=9B=B4"
=20
-#: git-gui.sh:2414
+#: git-gui.sh:2781
 msgid "Unstaged Changes"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=E3=81=AB=
=E5=85=A5=E3=81=A3=E3=81=A6=E3=81=84=E3=81=AA=E3=81=84=E5=A4=89=E6=9B=B4=
"
=20
-#: git-gui.sh:2464
+#: git-gui.sh:2831
 msgid "Stage Changed"
 msgstr "=E5=A4=89=E6=9B=B4=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=
=E4=BA=88=E5=AE=9A=E3=81=AB=E5=85=A5=E3=82=8C=E3=82=8B"
=20
-#: git-gui.sh:2480 lib/transport.tcl:93 lib/transport.tcl:182
+#: git-gui.sh:2850 lib/transport.tcl:93 lib/transport.tcl:182
 msgid "Push"
 msgstr "=E3=83=97=E3=83=83=E3=82=B7=E3=83=A5"
=20
-#: git-gui.sh:2510
+#: git-gui.sh:2885
 msgid "Initial Commit Message:"
 msgstr "=E6=9C=80=E5=88=9D=E3=81=AE=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=
=E3=83=A1=E3=83=83=E3=82=BB=E3=83=BC=E3=82=B8:"
=20
-#: git-gui.sh:2511
+#: git-gui.sh:2886
 msgid "Amended Commit Message:"
 msgstr "=E8=A8=82=E6=AD=A3=E3=81=97=E3=81=9F=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E3=83=A1=E3=83=83=E3=82=BB=E3=83=BC=E3=82=B8:"
=20
-#: git-gui.sh:2512
+#: git-gui.sh:2887
 msgid "Amended Initial Commit Message:"
 msgstr "=E8=A8=82=E6=AD=A3=E3=81=97=E3=81=9F=E6=9C=80=E5=88=9D=E3=81=AE=
=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=83=A1=E3=83=83=E3=82=BB=E3=83=BC=
=E3=82=B8:"
=20
-#: git-gui.sh:2513
+#: git-gui.sh:2888
 msgid "Amended Merge Commit Message:"
 msgstr "=E8=A8=82=E6=AD=A3=E3=81=97=E3=81=9F=E3=83=9E=E3=83=BC=E3=82=B8=
=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=83=A1=E3=83=83=E3=82=BB=E3=83=BC=
=E3=82=B8:"
=20
-#: git-gui.sh:2514
+#: git-gui.sh:2889
 msgid "Merge Commit Message:"
 msgstr "=E3=83=9E=E3=83=BC=E3=82=B8=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=
=E3=83=A1=E3=83=83=E3=82=BB=E3=83=BC=E3=82=B8:"
=20
-#: git-gui.sh:2515
+#: git-gui.sh:2890
 msgid "Commit Message:"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=83=A1=E3=83=83=E3=82=BB=
=E3=83=BC=E3=82=B8:"
=20
-#: git-gui.sh:2561 git-gui.sh:2723 lib/console.tcl:73
+#: git-gui.sh:2939 git-gui.sh:3090 lib/console.tcl:73
 msgid "Copy All"
 msgstr "=E5=85=A8=E3=81=A6=E3=82=B3=E3=83=94=E3=83=BC"
=20
-#: git-gui.sh:2585 lib/blame.tcl:100
+#: git-gui.sh:2963 lib/blame.tcl:104
 msgid "File:"
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB:"
=20
-#: git-gui.sh:2691
-msgid "Apply/Reverse Hunk"
-msgstr "=E3=83=91=E3=83=83=E3=83=81=E3=82=92=E9=81=A9=E7=94=A8/=E5=8F=96=
=E3=82=8A=E6=B6=88=E3=81=99"
-
-#: git-gui.sh:2696
-msgid "Apply/Reverse Line"
-msgstr "=E3=83=91=E3=83=83=E3=83=81=E8=A1=8C=E3=82=92=E9=81=A9=E7=94=A8=
/=E5=8F=96=E3=82=8A=E6=B6=88=E3=81=99"
-
-#: git-gui.sh:2711
+#: git-gui.sh:3078
 msgid "Refresh"
 msgstr "=E5=86=8D=E8=AA=AD=E3=81=BF=E8=BE=BC=E3=81=BF"
=20
-#: git-gui.sh:2732
+#: git-gui.sh:3099
 msgid "Decrease Font Size"
 msgstr "=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88=E3=82=92=E5=B0=8F=E3=81=95=
=E3=81=8F"
=20
-#: git-gui.sh:2736
+#: git-gui.sh:3103
 msgid "Increase Font Size"
 msgstr "=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88=E3=82=92=E5=A4=A7=E3=81=8D=
=E3=81=8F"
=20
-#: git-gui.sh:2747
+#: git-gui.sh:3111 lib/blame.tcl:281
+msgid "Encoding"
+msgstr "=E3=82=A8=E3=83=B3=E3=82=B3=E3=83=BC=E3=83=87=E3=82=A3=E3=83=B3=
=E3=82=B0"
+
+#: git-gui.sh:3122
+msgid "Apply/Reverse Hunk"
+msgstr "=E3=83=91=E3=83=83=E3=83=81=E3=82=92=E9=81=A9=E7=94=A8/=E5=8F=96=
=E3=82=8A=E6=B6=88=E3=81=99"
+
+#: git-gui.sh:3127
+msgid "Apply/Reverse Line"
+msgstr "=E3=83=91=E3=83=83=E3=83=81=E8=A1=8C=E3=82=92=E9=81=A9=E7=94=A8=
/=E5=8F=96=E3=82=8A=E6=B6=88=E3=81=99"
+
+#: git-gui.sh:3137
+msgid "Run Merge Tool"
+msgstr "=E3=83=9E=E3=83=BC=E3=82=B8=E3=83=84=E3=83=BC=E3=83=AB=E3=82=92=
=E8=B5=B7=E5=8B=95"
+
+#: git-gui.sh:3142
+msgid "Use Remote Version"
+msgstr "=E3=83=AA=E3=83=A2=E3=83=BC=E3=83=88=E3=81=AE=E6=96=B9=E3=82=92=
=E6=8E=A1=E7=94=A8"
+
+#: git-gui.sh:3146
+msgid "Use Local Version"
+msgstr "=E3=83=AD=E3=83=BC=E3=82=AB=E3=83=AB=E3=81=AE=E6=96=B9=E3=82=92=
=E6=8E=A1=E7=94=A8"
+
+#: git-gui.sh:3150
+msgid "Revert To Base"
+msgstr "=E3=83=99=E3=83=BC=E3=82=B9=E7=89=88=E3=82=92=E6=8E=A1=E7=94=A8=
"
+
+#: git-gui.sh:3169
 msgid "Unstage Hunk From Commit"
 msgstr "=E3=83=91=E3=83=83=E3=83=81=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E4=BA=88=E5=AE=9A=E3=81=8B=E3=82=89=E5=A4=96=E3=81=99"
=20
-#: git-gui.sh:2748
+#: git-gui.sh:3170
 msgid "Unstage Line From Commit"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=E3=81=8B=
=E3=82=89=E8=A1=8C=E3=82=92=E5=A4=96=E3=81=99"
=20
-#: git-gui.sh:2750
+#: git-gui.sh:3172
 msgid "Stage Hunk For Commit"
 msgstr "=E3=83=91=E3=83=83=E3=83=81=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E4=BA=88=E5=AE=9A=E3=81=AB=E5=8A=A0=E3=81=88=E3=82=8B"
=20
-#: git-gui.sh:2751
+#: git-gui.sh:3173
 msgid "Stage Line For Commit"
 msgstr "=E3=83=91=E3=83=83=E3=83=81=E8=A1=8C=E3=82=92=E3=82=B3=E3=83=9F=
=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=E3=81=AB=E5=8A=A0=E3=81=88=E3=82=8B=
"
=20
-#: git-gui.sh:2771
+#: git-gui.sh:3196
 msgid "Initializing..."
 msgstr "=E5=88=9D=E6=9C=9F=E5=8C=96=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=
=E3=81=99=E2=80=A6"
=20
-#: git-gui.sh:2876
+#: git-gui.sh:3301
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -450,7 +515,7 @@ msgstr ""
 "=E4=BB=A5=E4=B8=8B=E3=81=AE=E7=92=B0=E5=A2=83=E5=A4=89=E6=95=B0=E3=81=
=AF %s =E3=81=8C=E8=B5=B7=E5=8B=95=E3=81=99=E3=82=8B Git =E3=82=B5=E3=83=
=96=E3=83=97=E3=83=AD=E3=82=BB=E3=82=B9=E3=81=AB=E3=82=88=E3=81=A3=E3=81=
=A6=E7=84=A1=E8=A6=96=E3=81=95=E3=82=8C=E3=82=8B=E3=81=A7=E3=81=97=E3=82=
=87=E3=81=86:\n"
 "\n"
=20
-#: git-gui.sh:2906
+#: git-gui.sh:3331
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
@@ -460,7 +525,7 @@ msgstr ""
 "=E3=81=93=E3=82=8C=E3=81=AF Cygwin =E3=81=A7=E9=85=8D=E5=B8=83=E3=81=95=
=E3=82=8C=E3=81=A6=E3=81=84=E3=82=8B Tcl =E3=83=90=E3=82=A4=E3=83=8A=E3=
=83=AA=E3=81=AB\n"
 "=E9=96=A2=E3=81=97=E3=81=A6=E3=81=AE=E6=97=A2=E7=9F=A5=E3=81=AE=E5=95=
=8F=E9=A1=8C=E3=81=AB=E3=82=88=E3=82=8A=E3=81=BE=E3=81=99"
=20
-#: git-gui.sh:2911
+#: git-gui.sh:3336
 #, tcl-format
 msgid ""
 "\n"
@@ -479,80 +544,108 @@ msgstr ""
 msgid "git-gui - a graphical user interface for Git."
 msgstr "Git =E3=81=AE=E3=82=B0=E3=83=A9=E3=83=95=E3=82=A3=E3=82=AB=E3=83=
=ABUI git-gui"
=20
-#: lib/blame.tcl:70
+#: lib/blame.tcl:72
 msgid "File Viewer"
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=83=94=E3=83=A5=E3=83=BC=
=E3=83=AF"
=20
-#: lib/blame.tcl:74
+#: lib/blame.tcl:78
 msgid "Commit:"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88:"
=20
-#: lib/blame.tcl:257
+#: lib/blame.tcl:271
 msgid "Copy Commit"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=82=92=E3=82=B3=E3=83=94=
=E3=83=BC"
=20
-#: lib/blame.tcl:260
+#: lib/blame.tcl:275
+msgid "Find Text..."
+msgstr "=E3=83=86=E3=82=AD=E3=82=B9=E3=83=88=E3=82=92=E6=A4=9C=E7=B4=A2=
"
+
+#: lib/blame.tcl:284
 msgid "Do Full Copy Detection"
 msgstr "=E3=82=B3=E3=83=94=E3=83=BC=E6=A4=9C=E7=9F=A5"
=20
-#: lib/blame.tcl:388
+#: lib/blame.tcl:288
+msgid "Show History Context"
+msgstr "=E6=96=87=E8=84=88=E3=82=92=E8=A6=8B=E3=81=9B=E3=82=8B"
+
+#: lib/blame.tcl:291
+msgid "Blame Parent Commit"
+msgstr "=E8=A6=AA=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=82=92=E8=A8=BB=
=E9=87=88"
+
+#: lib/blame.tcl:450
 #, tcl-format
 msgid "Reading %s..."
 msgstr "%s =E3=82=92=E8=AA=AD=E3=82=93=E3=81=A7=E3=81=84=E3=81=BE=E3=81=
=99=E2=80=A6"
=20
-#: lib/blame.tcl:492
+#: lib/blame.tcl:557
 msgid "Loading copy/move tracking annotations..."
 msgstr "=E3=82=B3=E3=83=94=E3=83=BC=E3=83=BB=E7=A7=BB=E5=8B=95=E8=BF=BD=
=E8=B7=A1=E3=83=87=E3=83=BC=E3=82=BF=E3=82=92=E8=AA=AD=E3=82=93=E3=81=A7=
=E3=81=84=E3=81=BE=E3=81=99=E2=80=A6"
=20
-#: lib/blame.tcl:512
+#: lib/blame.tcl:577
 msgid "lines annotated"
 msgstr "=E8=A1=8C=E3=82=92=E6=B3=A8=E9=87=88=E3=81=97=E3=81=BE=E3=81=97=
=E3=81=9F"
=20
-#: lib/blame.tcl:704
+#: lib/blame.tcl:769
 msgid "Loading original location annotations..."
 msgstr "=E5=85=83=E4=BD=8D=E7=BD=AE=E8=A1=8C=E3=81=AE=E6=B3=A8=E9=87=88=
=E3=83=87=E3=83=BC=E3=82=BF=E3=82=92=E8=AA=AD=E3=82=93=E3=81=A7=E3=81=84=
=E3=81=BE=E3=81=99=E2=80=A6"
=20
-#: lib/blame.tcl:707
+#: lib/blame.tcl:772
 msgid "Annotation complete."
 msgstr "=E6=B3=A8=E9=87=88=E5=AE=8C=E4=BA=86=E3=81=97=E3=81=BE=E3=81=97=
=E3=81=9F"
=20
-#: lib/blame.tcl:737
+#: lib/blame.tcl:802
 msgid "Busy"
 msgstr "=E5=AE=9F=E8=A1=8C=E4=B8=AD"
=20
-#: lib/blame.tcl:738
+#: lib/blame.tcl:803
 msgid "Annotation process is already running."
 msgstr "=E3=81=99=E3=81=A7=E3=81=AB blame =E3=83=97=E3=83=AD=E3=82=BB=E3=
=82=B9=E3=82=92=E5=AE=9F=E8=A1=8C=E4=B8=AD=E3=81=A7=E3=81=99=E3=80=82"
=20
-#: lib/blame.tcl:777
+#: lib/blame.tcl:842
 msgid "Running thorough copy detection..."
 msgstr "=E3=82=B3=E3=83=94=E3=83=BC=E6=A4=9C=E7=9F=A5=E3=82=92=E5=AE=9F=
=E8=A1=8C=E4=B8=AD=E2=80=A6"
=20
-#: lib/blame.tcl:827
+#: lib/blame.tcl:910
 msgid "Loading annotation..."
 msgstr "=E6=B3=A8=E9=87=88=E3=82=92=E8=AA=AD=E3=81=BF=E8=BE=BC=E3=82=93=
=E3=81=A7=E3=81=84=E3=81=BE=E3=81=99=E2=80=A6"
=20
-#: lib/blame.tcl:883
+#: lib/blame.tcl:964
 msgid "Author:"
 msgstr "=E4=BD=9C=E8=80=85:"
=20
-#: lib/blame.tcl:887
+#: lib/blame.tcl:968
 msgid "Committer:"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E8=80=85:"
=20
-#: lib/blame.tcl:892
+#: lib/blame.tcl:973
 msgid "Original File:"
 msgstr "=E5=85=83=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB"
=20
-#: lib/blame.tcl:1006
+#: lib/blame.tcl:1021
+msgid "Cannot find HEAD commit:"
+msgstr "HEAD =E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=8C=E8=A6=8B=E3=
=81=A4=E3=81=8B=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93"
+
+#: lib/blame.tcl:1076
+msgid "Cannot find parent commit:"
+msgstr "=E8=A6=AA=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=8C=E8=A6=8B=
=E3=81=A4=E3=81=8B=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93:"
+
+#: lib/blame.tcl:1091
+msgid "Unable to display parent"
+msgstr "=E8=A6=AA=E3=82=92=E8=A1=A8=E7=A4=BA=E3=81=A7=E3=81=8D=E3=81=BE=
=E3=81=9B=E3=82=93"
+
+#: lib/blame.tcl:1092 lib/diff.tcl:297
+msgid "Error loading diff:"
+msgstr "diff =E3=82=92=E8=AA=AD=E3=82=80=E9=9A=9B=E3=81=AE=E3=82=A8=E3=
=83=A9=E3=83=BC=E3=81=A7=E3=81=99:"
+
+#: lib/blame.tcl:1232
 msgid "Originally By:"
 msgstr "=E5=8E=9F=E4=BD=9C=E8=80=85:"
=20
-#: lib/blame.tcl:1012
+#: lib/blame.tcl:1238
 msgid "In File:"
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB:"
=20
-#: lib/blame.tcl:1017
+#: lib/blame.tcl:1243
 msgid "Copied Or Moved Here By:"
 msgstr "=E8=A4=87=E5=86=99=E3=83=BB=E7=A7=BB=E5=8B=95=E8=80=85:"
=20
@@ -566,16 +659,18 @@ msgstr "=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=E3=82=
=A2=E3=82=A6=E3=83=88"
=20
 #: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
 #: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:2=
82
-#: lib/checkout_op.tcl:544 lib/choose_font.tcl:43 lib/merge.tcl:171
-#: lib/option.tcl:103 lib/remote_branch_delete.tcl:42 lib/transport.tc=
l:97
+#: lib/checkout_op.tcl:544 lib/choose_font.tcl:43 lib/merge.tcl:172
+#: lib/option.tcl:125 lib/remote_add.tcl:32 lib/remote_branch_delete.t=
cl:42
+#: lib/tools_dlg.tcl:40 lib/tools_dlg.tcl:204 lib/tools_dlg.tcl:352
+#: lib/transport.tcl:97
 msgid "Cancel"
 msgstr "=E4=B8=AD=E6=AD=A2"
=20
-#: lib/branch_checkout.tcl:32 lib/browser.tcl:287
+#: lib/branch_checkout.tcl:32 lib/browser.tcl:287 lib/tools_dlg.tcl:32=
8
 msgid "Revision"
 msgstr "=E3=83=AA=E3=83=93=E3=82=B8=E3=83=A7=E3=83=B3"
=20
-#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:=
244
+#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:=
280
 msgid "Options"
 msgstr "=E3=82=AA=E3=83=97=E3=82=B7=E3=83=A7=E3=83=B3"
=20
@@ -595,7 +690,7 @@ msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=82=92=
=E4=BD=9C=E6=88=90"
 msgid "Create New Branch"
 msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=82=92=E6=96=B0=E8=A6=8F=
=E4=BD=9C=E6=88=90"
=20
-#: lib/branch_create.tcl:31 lib/choose_repository.tcl:371
+#: lib/branch_create.tcl:31 lib/choose_repository.tcl:377
 msgid "Create"
 msgstr "=E4=BD=9C=E6=88=90"
=20
@@ -603,7 +698,7 @@ msgstr "=E4=BD=9C=E6=88=90"
 msgid "Branch Name"
 msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E5=90=8D"
=20
-#: lib/branch_create.tcl:43
+#: lib/branch_create.tcl:43 lib/remote_add.tcl:39 lib/tools_dlg.tcl:50
 msgid "Name:"
 msgstr "=E5=90=8D=E5=89=8D:"
=20
@@ -748,9 +843,9 @@ msgstr "[=E4=B8=8A=E4=BD=8D=E3=83=95=E3=82=A9=E3=83=
=AB=E3=83=80=E3=81=B8]"
 msgid "Browse Branch Files"
 msgstr "=E7=8F=BE=E5=9C=A8=E3=81=AE=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
=E3=81=AE=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=82=92=E8=A6=8B=E3=82=8B=
"
=20
-#: lib/browser.tcl:278 lib/choose_repository.tcl:387
-#: lib/choose_repository.tcl:472 lib/choose_repository.tcl:482
-#: lib/choose_repository.tcl:985
+#: lib/browser.tcl:278 lib/choose_repository.tcl:394
+#: lib/choose_repository.tcl:480 lib/choose_repository.tcl:491
+#: lib/choose_repository.tcl:995
 msgid "Browse"
 msgstr "=E3=83=96=E3=83=A9=E3=82=A6=E3=82=BA"
=20
@@ -765,6 +860,7 @@ msgid "fatal: Cannot resolve %s"
 msgstr "=E8=87=B4=E5=91=BD=E7=9A=84=E3=82=A8=E3=83=A9=E3=83=BC: %s =E3=
=82=92=E8=A7=A3=E6=B1=BA=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93"
=20
 #: lib/checkout_op.tcl:145 lib/console.tcl:81 lib/database.tcl:31
+#: lib/sshkey.tcl:53
 msgid "Close"
 msgstr "=E9=96=89=E3=81=98=E3=82=8B"
=20
@@ -875,7 +971,7 @@ msgstr "=E5=A4=B1=E3=81=AA=E3=82=8F=E3=82=8C=E3=81=9F=
=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=82=92=E5=9B=9E=E5=BE=A9=E3=81=99=
=E3=82=8B=E3=81=AE=E3=81=AF=E7=B0=A1=E5=8D=98=E3=81=A7=E3=81=AF=E3=81=82=
=E3=82=8A=E3=81=BE=E3=81=9B
 msgid "Reset '%s'?"
 msgstr "'%s' =E3=82=92=E3=83=AA=E3=82=BB=E3=83=83=E3=83=88=E3=81=97=E3=
=81=BE=E3=81=99=E3=81=8B=EF=BC=9F"
=20
-#: lib/checkout_op.tcl:532 lib/merge.tcl:163
+#: lib/checkout_op.tcl:532 lib/merge.tcl:164 lib/tools_dlg.tcl:343
 msgid "Visualize"
 msgstr "=E5=8F=AF=E8=A6=96=E5=8C=96"
=20
@@ -923,221 +1019,225 @@ msgstr ""
 msgid "Git Gui"
 msgstr "Git GUI"
=20
-#: lib/choose_repository.tcl:81 lib/choose_repository.tcl:376
+#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:382
 msgid "Create New Repository"
 msgstr "=E6=96=B0=E3=81=97=E3=81=84=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=
=E3=83=AA=E3=82=92=E4=BD=9C=E3=82=8B"
=20
-#: lib/choose_repository.tcl:87
+#: lib/choose_repository.tcl:93
 msgid "New..."
 msgstr "=E6=96=B0=E8=A6=8F=E2=80=A6"
=20
-#: lib/choose_repository.tcl:94 lib/choose_repository.tcl:458
+#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:465
 msgid "Clone Existing Repository"
 msgstr "=E6=97=A2=E5=AD=98=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA=
=E3=82=92=E8=A4=87=E8=A3=BD=E3=81=99=E3=82=8B"
=20
-#: lib/choose_repository.tcl:100
+#: lib/choose_repository.tcl:106
 msgid "Clone..."
 msgstr "=E8=A4=87=E8=A3=BD=E2=80=A6"
=20
-#: lib/choose_repository.tcl:107 lib/choose_repository.tcl:974
+#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:983
 msgid "Open Existing Repository"
 msgstr "=E6=97=A2=E5=AD=98=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA=
=E3=82=92=E9=96=8B=E3=81=8F"
=20
-#: lib/choose_repository.tcl:113
+#: lib/choose_repository.tcl:119
 msgid "Open..."
 msgstr "=E9=96=8B=E3=81=8F=E2=80=A6"
=20
-#: lib/choose_repository.tcl:126
+#: lib/choose_repository.tcl:132
 msgid "Recent Repositories"
 msgstr "=E6=9C=80=E8=BF=91=E4=BD=BF=E3=81=A3=E3=81=9F=E3=83=AA=E3=83=9D=
=E3=82=B8=E3=83=88=E3=83=AA"
=20
-#: lib/choose_repository.tcl:132
+#: lib/choose_repository.tcl:138
 msgid "Open Recent Repository:"
 msgstr "=E6=9C=80=E8=BF=91=E4=BD=BF=E3=81=A3=E3=81=9F=E3=83=AA=E3=83=9D=
=E3=82=B8=E3=83=88=E3=83=AA=E3=82=92=E9=96=8B=E3=81=8F"
=20
-#: lib/choose_repository.tcl:296 lib/choose_repository.tcl:303
-#: lib/choose_repository.tcl:310
+#: lib/choose_repository.tcl:302 lib/choose_repository.tcl:309
+#: lib/choose_repository.tcl:316
 #, tcl-format
 msgid "Failed to create repository %s:"
 msgstr "=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA %s =E3=82=92=E4=BD=
=9C=E8=A3=BD=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93:"
=20
-#: lib/choose_repository.tcl:381 lib/choose_repository.tcl:476
+#: lib/choose_repository.tcl:387
 msgid "Directory:"
 msgstr "=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=E3=83=AA:"
=20
-#: lib/choose_repository.tcl:410 lib/choose_repository.tcl:535
-#: lib/choose_repository.tcl:1007
+#: lib/choose_repository.tcl:417 lib/choose_repository.tcl:544
+#: lib/choose_repository.tcl:1017
 msgid "Git Repository"
 msgstr "GIT =E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA"
=20
-#: lib/choose_repository.tcl:435
+#: lib/choose_repository.tcl:442
 #, tcl-format
 msgid "Directory %s already exists."
 msgstr "=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=E3=83=AA '%s' =E3=
=81=AF=E6=97=A2=E3=81=AB=E5=AD=98=E5=9C=A8=E3=81=97=E3=81=BE=E3=81=99=E3=
=80=82"
=20
-#: lib/choose_repository.tcl:439
+#: lib/choose_repository.tcl:446
 #, tcl-format
 msgid "File %s already exists."
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB '%s' =E3=81=AF=E6=97=A2=E3=
=81=AB=E5=AD=98=E5=9C=A8=E3=81=97=E3=81=BE=E3=81=99=E3=80=82"
=20
-#: lib/choose_repository.tcl:453
+#: lib/choose_repository.tcl:460
 msgid "Clone"
 msgstr "=E8=A4=87=E8=A3=BD"
=20
-#: lib/choose_repository.tcl:466
-msgid "URL:"
-msgstr "URL:"
+#: lib/choose_repository.tcl:473
+msgid "Source Location:"
+msgstr "=E3=82=BD=E3=83=BC=E3=82=B9=E3=81=AE=E4=BD=8D=E7=BD=AE"
+
+#: lib/choose_repository.tcl:484
+msgid "Target Directory:"
+msgstr "=E5=85=88=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=E3=83=AA=
:"
=20
-#: lib/choose_repository.tcl:487
+#: lib/choose_repository.tcl:496
 msgid "Clone Type:"
 msgstr "=E8=A4=87=E8=A3=BD=E6=96=B9=E5=BC=8F:"
=20
-#: lib/choose_repository.tcl:493
+#: lib/choose_repository.tcl:502
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
 msgstr "=E6=A8=99=E6=BA=96(=E9=AB=98=E9=80=9F=E3=83=BB=E4=B8=AD=E5=86=97=
=E9=95=B7=E5=BA=A6=E3=83=BB=E3=83=8F=E3=83=BC=E3=83=89=E3=83=AA=E3=83=B3=
=E3=82=AF)"
=20
-#: lib/choose_repository.tcl:499
+#: lib/choose_repository.tcl:508
 msgid "Full Copy (Slower, Redundant Backup)"
 msgstr "=E5=85=A8=E8=A4=87=E5=86=99(=E4=BD=8E=E9=80=9F=E3=83=BB=E5=86=97=
=E9=95=B7=E3=83=90=E3=83=83=E3=82=AF=E3=82=A2=E3=83=83=E3=83=97)"
=20
-#: lib/choose_repository.tcl:505
+#: lib/choose_repository.tcl:514
 msgid "Shared (Fastest, Not Recommended, No Backup)"
 msgstr "=E5=85=B1=E6=9C=89(=E6=9C=80=E9=AB=98=E9=80=9F=E3=83=BB=E9=9D=9E=
=E6=8E=A8=E5=A5=A8=E3=83=BB=E3=83=90=E3=83=83=E3=82=AF=E3=82=A2=E3=83=83=
=E3=83=97=E7=84=A1=E3=81=97)"
=20
-#: lib/choose_repository.tcl:541 lib/choose_repository.tcl:588
-#: lib/choose_repository.tcl:734 lib/choose_repository.tcl:804
-#: lib/choose_repository.tcl:1013 lib/choose_repository.tcl:1021
+#: lib/choose_repository.tcl:550 lib/choose_repository.tcl:597
+#: lib/choose_repository.tcl:743 lib/choose_repository.tcl:813
+#: lib/choose_repository.tcl:1023 lib/choose_repository.tcl:1031
 #, tcl-format
 msgid "Not a Git repository: %s"
 msgstr "Git =E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA=E3=81=A7=E3=81=
=AF=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93: %s"
=20
-#: lib/choose_repository.tcl:577
+#: lib/choose_repository.tcl:586
 msgid "Standard only available for local repository."
 msgstr "=E6=A8=99=E6=BA=96=E6=96=B9=E5=BC=8F=E3=81=AF=E5=90=8C=E4=B8=80=
=E8=A8=88=E7=AE=97=E6=A9=9F=E4=B8=8A=E3=81=AE=E3=83=AA=E3=83=9D=E3=82=B8=
=E3=83=88=E3=83=AA=E3=81=AB=E3=81=AE=E3=81=BF=E4=BD=BF=E3=81=88=E3=81=BE=
=E3=81=99=E3=80=82"
=20
-#: lib/choose_repository.tcl:581
+#: lib/choose_repository.tcl:590
 msgid "Shared only available for local repository."
 msgstr "=E5=85=B1=E6=9C=89=E6=96=B9=E5=BC=8F=E3=81=AF=E5=90=8C=E4=B8=80=
=E8=A8=88=E7=AE=97=E6=A9=9F=E4=B8=8A=E3=81=AE=E3=83=AA=E3=83=9D=E3=82=B8=
=E3=83=88=E3=83=AA=E3=81=AB=E3=81=AE=E3=81=BF=E4=BD=BF=E3=81=88=E3=81=BE=
=E3=81=99=E3=80=82"
=20
-#: lib/choose_repository.tcl:602
+#: lib/choose_repository.tcl:611
 #, tcl-format
 msgid "Location %s already exists."
 msgstr "'%s' =E3=81=AF=E6=97=A2=E3=81=AB=E5=AD=98=E5=9C=A8=E3=81=97=E3=
=81=BE=E3=81=99=E3=80=82"
=20
-#: lib/choose_repository.tcl:613
+#: lib/choose_repository.tcl:622
 msgid "Failed to configure origin"
 msgstr "origin =E3=82=92=E8=A8=AD=E5=AE=9A=E3=81=A7=E3=81=8D=E3=81=BE=E3=
=81=9B=E3=82=93=E3=81=A7=E3=81=97=E3=81=9F"
=20
-#: lib/choose_repository.tcl:625
+#: lib/choose_repository.tcl:634
 msgid "Counting objects"
 msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=
=E6=95=B0=E3=81=88=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
=20
-#: lib/choose_repository.tcl:626
+#: lib/choose_repository.tcl:635
 msgid "buckets"
 msgstr "=E3=83=90=E3=82=B1=E3=83=84"
=20
-#: lib/choose_repository.tcl:650
+#: lib/choose_repository.tcl:659
 #, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
 msgstr "objects/info/alternates =E3=82=92=E8=A4=87=E5=86=99=E3=81=A7=E3=
=81=8D=E3=81=BE=E3=81=9B=E3=82=93: %s"
=20
-#: lib/choose_repository.tcl:686
+#: lib/choose_repository.tcl:695
 #, tcl-format
 msgid "Nothing to clone from %s."
 msgstr "%s =E3=81=8B=E3=82=89=E8=A4=87=E8=A3=BD=E3=81=99=E3=82=8B=E5=86=
=85=E5=AE=B9=E3=81=AF=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93"
=20
-#: lib/choose_repository.tcl:688 lib/choose_repository.tcl:902
-#: lib/choose_repository.tcl:914
+#: lib/choose_repository.tcl:697 lib/choose_repository.tcl:911
+#: lib/choose_repository.tcl:923
 msgid "The 'master' branch has not been initialized."
 msgstr "'master' =E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=81=8C=E5=88=9D=
=E6=9C=9F=E5=8C=96=E3=81=95=E3=82=8C=E3=81=A6=E3=81=84=E3=81=BE=E3=81=9B=
=E3=82=93"
=20
-#: lib/choose_repository.tcl:701
+#: lib/choose_repository.tcl:710
 msgid "Hardlinks are unavailable.  Falling back to copying."
 msgstr "=E3=83=8F=E3=83=BC=E3=83=89=E3=83=AA=E3=83=B3=E3=82=AF=E3=81=8C=
=E4=BD=9C=E3=82=8C=E3=81=AA=E3=81=84=E3=81=AE=E3=81=A7=E3=80=81=E3=82=B3=
=E3=83=94=E3=83=BC=E3=81=97=E3=81=BE=E3=81=99"
=20
-#: lib/choose_repository.tcl:713
+#: lib/choose_repository.tcl:722
 #, tcl-format
 msgid "Cloning from %s"
 msgstr "%s =E3=81=8B=E3=82=89=E8=A4=87=E8=A3=BD=E3=81=97=E3=81=A6=E3=81=
=84=E3=81=BE=E3=81=99"
=20
-#: lib/choose_repository.tcl:744
+#: lib/choose_repository.tcl:753
 msgid "Copying objects"
 msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=
=E8=A4=87=E5=86=99=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
=20
-#: lib/choose_repository.tcl:745
+#: lib/choose_repository.tcl:754
 msgid "KiB"
 msgstr "KiB"
=20
-#: lib/choose_repository.tcl:769
+#: lib/choose_repository.tcl:778
 #, tcl-format
 msgid "Unable to copy object: %s"
 msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=
=E8=A4=87=E5=86=99=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93: %s"
=20
-#: lib/choose_repository.tcl:779
+#: lib/choose_repository.tcl:788
 msgid "Linking objects"
 msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=
=E9=80=A3=E7=B5=90=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
=20
-#: lib/choose_repository.tcl:780
+#: lib/choose_repository.tcl:789
 msgid "objects"
 msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88"
=20
-#: lib/choose_repository.tcl:788
+#: lib/choose_repository.tcl:797
 #, tcl-format
 msgid "Unable to hardlink object: %s"
 msgstr "=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=
=E3=83=8F=E3=83=BC=E3=83=89=E3=83=AA=E3=83=B3=E3=82=AF=E3=81=A7=E3=81=8D=
=E3=81=BE=E3=81=9B=E3=82=93: %s"
=20
-#: lib/choose_repository.tcl:843
+#: lib/choose_repository.tcl:852
 msgid "Cannot fetch branches and objects.  See console output for deta=
ils."
 msgstr "=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=82=84=E3=82=AA=E3=83=96=
=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=82=92=E5=8F=96=E5=BE=97=E3=81=A7=
=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82=E3=82=B3=E3=83=B3=E3=82=BD=
=E3=83=BC=E3=83=AB=E5=87=BA=E5=8A=9B=E3=82=92=E8=A6=8B=E3=81=A6=E4=B8=8B=
=E3=81=95=E3=81=84"
=20
-#: lib/choose_repository.tcl:854
+#: lib/choose_repository.tcl:863
 msgid "Cannot fetch tags.  See console output for details."
 msgstr "=E3=82=BF=E3=82=B0=E3=82=92=E5=8F=96=E5=BE=97=E3=81=A7=E3=81=8D=
=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82=E3=82=B3=E3=83=B3=E3=82=BD=E3=83=BC=
=E3=83=AB=E5=87=BA=E5=8A=9B=E3=82=92=E8=A6=8B=E3=81=A6=E4=B8=8B=E3=81=95=
=E3=81=84"
=20
-#: lib/choose_repository.tcl:878
+#: lib/choose_repository.tcl:887
 msgid "Cannot determine HEAD.  See console output for details."
 msgstr "HEAD =E3=82=92=E7=A2=BA=E5=AE=9A=E3=81=A7=E3=81=8D=E3=81=BE=E3=
=81=9B=E3=82=93=E3=80=82=E3=82=B3=E3=83=B3=E3=82=BD=E3=83=BC=E3=83=AB=E5=
=87=BA=E5=8A=9B=E3=82=92=E8=A6=8B=E3=81=A6=E4=B8=8B=E3=81=95=E3=81=84"
=20
-#: lib/choose_repository.tcl:887
+#: lib/choose_repository.tcl:896
 #, tcl-format
 msgid "Unable to cleanup %s"
 msgstr "%s =E3=82=92=E6=8E=83=E9=99=A4=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=
=9B=E3=82=93"
=20
-#: lib/choose_repository.tcl:893
+#: lib/choose_repository.tcl:902
 msgid "Clone failed."
 msgstr "=E8=A4=87=E5=86=99=E3=81=AB=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=
=E3=81=97=E3=81=9F=E3=80=82"
=20
-#: lib/choose_repository.tcl:900
+#: lib/choose_repository.tcl:909
 msgid "No default branch obtained."
 msgstr "=E3=83=87=E3=83=95=E3=82=A9=E3=83=BC=E3=83=AB=E3=83=88=E3=83=BB=
=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=E3=81=8C=E5=8F=96=E5=BE=97=E3=81=95=
=E3=82=8C=E3=81=BE=E3=81=9B=E3=82=93=E3=81=A7=E3=81=97=E3=81=9F"
=20
-#: lib/choose_repository.tcl:911
+#: lib/choose_repository.tcl:920
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
 msgstr "%s =E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=A8=E3=81=
=97=E3=81=A6=E8=A7=A3=E9=87=88=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=
=93"
=20
-#: lib/choose_repository.tcl:923
+#: lib/choose_repository.tcl:932
 msgid "Creating working directory"
 msgstr "=E4=BD=9C=E6=A5=AD=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=83=88=
=E3=83=AA=E3=82=92=E4=BD=9C=E6=88=90=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=
=E3=81=99"
=20
-#: lib/choose_repository.tcl:924 lib/index.tcl:65 lib/index.tcl:127
-#: lib/index.tcl:193
+#: lib/choose_repository.tcl:933 lib/index.tcl:65 lib/index.tcl:128
+#: lib/index.tcl:196
 msgid "files"
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB"
=20
-#: lib/choose_repository.tcl:953
+#: lib/choose_repository.tcl:962
 msgid "Initial file checkout failed."
 msgstr "=E5=88=9D=E6=9C=9F=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=E3=82=A2=
=E3=82=A6=E3=83=88=E3=81=AB=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=E3=81=97=
=E3=81=9F"
=20
-#: lib/choose_repository.tcl:969
+#: lib/choose_repository.tcl:978
 msgid "Open"
 msgstr "=E9=96=8B=E3=81=8F"
=20
-#: lib/choose_repository.tcl:979
+#: lib/choose_repository.tcl:988
 msgid "Repository:"
 msgstr "=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA:"
=20
-#: lib/choose_repository.tcl:1027
+#: lib/choose_repository.tcl:1037
 #, tcl-format
 msgid "Failed to open repository %s:"
 msgstr "=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA %s =E3=82=92=E9=96=
=8B=E3=81=91=E3=81=BE=E3=81=9B=E3=82=93:"
@@ -1236,7 +1336,7 @@ msgstr ""
 "\n"
 "=E8=87=AA=E5=8B=95=E7=9A=84=E3=81=AB=E5=86=8D=E3=82=B9=E3=82=AD=E3=83=
=A3=E3=83=B3=E3=82=92=E9=96=8B=E5=A7=8B=E3=81=97=E3=81=BE=E3=81=99=E3=80=
=82\n"
=20
-#: lib/commit.tcl:154
+#: lib/commit.tcl:156
 #, tcl-format
 msgid ""
 "Unmerged files cannot be committed.\n"
@@ -1249,7 +1349,7 @@ msgstr ""
 "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB %s =E3=81=AB=E3=81=AF=E3=83=9E=E3=
=83=BC=E3=82=B8=E8=A1=9D=E7=AA=81=E3=81=8C=E6=AE=8B=E3=81=A3=E3=81=A6=E3=
=81=84=E3=81=BE=E3=81=99=E3=80=82=E3=81=BE=E3=81=9A=E8=A7=A3=E6=B1=BA=E3=
=81=97=E3=81=A6=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=E3=
=81=AB=E5=8A=A0=E3=81=88=E3=82=8B=E5=BF=85"
 "=E8=A6=81=E3=81=8C=E3=81=82=E3=82=8A=E3=81=BE=E3=81=99=E3=80=82\n"
=20
-#: lib/commit.tcl:162
+#: lib/commit.tcl:164
 #, tcl-format
 msgid ""
 "Unknown file state %s detected.\n"
@@ -1260,7 +1360,7 @@ msgstr ""
 "\n"
 "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB %s =E3=81=AF=E6=9C=AC=E3=83=97=E3=
=83=AD=E3=82=B0=E3=83=A9=E3=83=A0=E3=81=A7=E3=81=AF=E3=82=B3=E3=83=9F=E3=
=83=83=E3=83=88=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82\n=
"
=20
-#: lib/commit.tcl:170
+#: lib/commit.tcl:172
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1270,7 +1370,7 @@ msgstr ""
 "\n"
 "=E6=9C=80=E4=BD=8E=E4=B8=80=E3=81=A4=E3=81=AE=E5=A4=89=E6=9B=B4=E3=82=
=92=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=E3=81=AB=E5=8A=
=A0=E3=81=88=E3=81=A6=E3=81=8B=E3=82=89=E3=82=B3=E3=83=9F=E3=83=83=E3=83=
=88=E3=81=97=E3=81=A6=E4=B8=8B=E3=81=95=E3=81=84=E3=80=82\n"
=20
-#: lib/commit.tcl:183
+#: lib/commit.tcl:187
 msgid ""
 "Please supply a commit message.\n"
 "\n"
@@ -1288,45 +1388,45 @@ msgstr ""
 "- =E7=AC=AC=EF=BC=92=E8=A1=8C: =E7=A9=BA=E7=99=BD\n"
 "- =E6=AE=8B=E3=82=8A=E3=81=AE=E8=A1=8C: =E3=81=AA=E3=81=9C=E3=80=81=E3=
=81=93=E3=81=AE=E5=A4=89=E6=9B=B4=E3=81=8C=E8=89=AF=E3=81=84=E5=A4=89=E6=
=9B=B4=E3=81=8B=E3=80=81=E3=81=AE=E8=AA=AC=E6=98=8E=E3=80=82\n"
=20
-#: lib/commit.tcl:207
+#: lib/commit.tcl:211
 #, tcl-format
 msgid "warning: Tcl does not support encoding '%s'."
 msgstr "=E8=AD=A6=E5=91=8A: Tcl =E3=81=AF=E3=82=A8=E3=83=B3=E3=82=B3=E3=
=83=BC=E3=83=87=E3=82=A3=E3=83=B3=E3=82=B0 '%s' =E3=82=92=E3=82=B5=E3=83=
=9D=E3=83=BC=E3=83=88=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=9B=E3=82=
=93"
=20
-#: lib/commit.tcl:221
+#: lib/commit.tcl:227
 msgid "Calling pre-commit hook..."
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E5=89=8D=E3=83=95=E3=83=83=
=E3=82=AF=E3=82=92=E5=AE=9F=E8=A1=8C=E4=B8=AD=E3=83=BB=E3=83=BB=E3=83=BB=
"
=20
-#: lib/commit.tcl:236
+#: lib/commit.tcl:242
 msgid "Commit declined by pre-commit hook."
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E5=89=8D=E3=83=95=E3=83=83=
=E3=82=AF=E3=81=8C=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=82=92=E6=8B=92=
=E5=90=A6=E3=81=97=E3=81=BE=E3=81=97=E3=81=9F"
=20
-#: lib/commit.tcl:259
+#: lib/commit.tcl:265
 msgid "Calling commit-msg hook..."
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=83=BB=E3=83=A1=E3=83=83=
=E3=82=BB=E3=83=BC=E3=82=B8=E3=83=BB=E3=83=95=E3=83=83=E3=82=AF=E3=82=92=
=E5=AE=9F=E8=A1=8C=E4=B8=AD=E3=83=BB=E3=83=BB=E3=83=BB"
=20
-#: lib/commit.tcl:274
+#: lib/commit.tcl:280
 msgid "Commit declined by commit-msg hook."
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=83=BB=E3=83=A1=E3=83=83=
=E3=82=BB=E3=83=BC=E3=82=B8=E3=83=BB=E3=83=95=E3=83=83=E3=82=AF=E3=81=8C=
=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=82=92=E6=8B=92=E5=90=A6=E3=81=97=
=E3=81=BE=E3=81=97=E3=81=9F"
=20
-#: lib/commit.tcl:287
+#: lib/commit.tcl:293
 msgid "Committing changes..."
 msgstr "=E5=A4=89=E6=9B=B4=E7=82=B9=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E4=B8=AD=E3=83=BB=E3=83=BB=E3=83=BB"
=20
-#: lib/commit.tcl:303
+#: lib/commit.tcl:309
 msgid "write-tree failed:"
 msgstr "write-tree =E3=81=8C=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=E3=81=
=97=E3=81=9F:"
=20
-#: lib/commit.tcl:304 lib/commit.tcl:348 lib/commit.tcl:368
+#: lib/commit.tcl:310 lib/commit.tcl:354 lib/commit.tcl:374
 msgid "Commit failed."
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=AB=E5=A4=B1=E6=95=97=
=E3=81=97=E3=81=BE=E3=81=97=E3=81=9F=E3=80=82"
=20
-#: lib/commit.tcl:321
+#: lib/commit.tcl:327
 #, tcl-format
 msgid "Commit %s appears to be corrupt"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88 %s =E3=81=AF=E5=A3=8A=E3=82=
=8C=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
=20
-#: lib/commit.tcl:326
+#: lib/commit.tcl:332
 msgid ""
 "No changes to commit.\n"
 "\n"
@@ -1340,19 +1440,19 @@ msgstr ""
 "\n"
 "=E8=87=AA=E5=8B=95=E7=9A=84=E3=81=AB=E5=86=8D=E3=82=B9=E3=82=AD=E3=83=
=A3=E3=83=B3=E3=82=92=E9=96=8B=E5=A7=8B=E3=81=97=E3=81=BE=E3=81=99=E3=80=
=82\n"
=20
-#: lib/commit.tcl:333
+#: lib/commit.tcl:339
 msgid "No changes to commit."
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=99=E3=82=8B=E5=A4=89=
=E6=9B=B4=E3=81=8C=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82=
"
=20
-#: lib/commit.tcl:347
+#: lib/commit.tcl:353
 msgid "commit-tree failed:"
 msgstr "commit-tree =E3=81=8C=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=E3=81=
=97=E3=81=9F:"
=20
-#: lib/commit.tcl:367
+#: lib/commit.tcl:373
 msgid "update-ref failed:"
 msgstr "update-ref =E3=81=8C=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=E3=81=
=97=E3=81=9F:"
=20
-#: lib/commit.tcl:454
+#: lib/commit.tcl:461
 #, tcl-format
 msgid "Created commit %s: %s"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88 %s =E3=82=92=E4=BD=9C=E6=88=
=90=E3=81=97=E3=81=BE=E3=81=97=E3=81=9F: %s"
@@ -1427,7 +1527,7 @@ msgstr ""
 msgid "Invalid date from Git: %s"
 msgstr "Git =E3=81=8B=E3=82=89=E5=87=BA=E3=81=9F=E7=84=A1=E5=8A=B9=E3=81=
=AA=E6=97=A5=E4=BB=98: %s"
=20
-#: lib/diff.tcl:44
+#: lib/diff.tcl:59
 #, tcl-format
 msgid ""
 "No differences detected.\n"
@@ -1449,48 +1549,105 @@ msgstr ""
 "\n"
 "=E5=90=8C=E6=A7=98=E3=81=AA=E7=8A=B6=E6=85=8B=E3=81=AE=E3=83=95=E3=82=
=A1=E3=82=A4=E3=83=AB=E3=82=92=E6=8E=A2=E3=81=99=E3=81=9F=E3=82=81=E3=81=
=AB=E3=80=81=E8=87=AA=E5=8B=95=E7=9A=84=E3=81=AB=E5=86=8D=E3=82=B9=E3=82=
=AD=E3=83=A3=E3=83=B3=E3=82=92=E9=96=8B=E5=A7=8B=E3=81=97=E3=81=BE=E3=81=
=99=E3=80=82"
=20
-#: lib/diff.tcl:83
+#: lib/diff.tcl:99
 #, tcl-format
 msgid "Loading diff of %s..."
 msgstr "%s =E3=81=AE=E5=A4=89=E6=9B=B4=E7=82=B9=E3=82=92=E3=83=AD=E3=83=
=BC=E3=83=89=E4=B8=AD=E2=80=A6"
=20
-#: lib/diff.tcl:116 lib/diff.tcl:190
+#: lib/diff.tcl:120
+msgid ""
+"LOCAL: deleted\n"
+"REMOTE:\n"
+msgstr ""
+"\n"
+"LOCAL: =E5=89=8A=E9=99=A4\n"
+"Remote:\n"
+
+#: lib/diff.tcl:125
+msgid ""
+"REMOTE: deleted\n"
+"LOCAL:\n"
+msgstr ""
+"\n"
+"REMOTE: =E5=89=8A=E9=99=A4\n"
+"LOCAL:\n"
+
+#: lib/diff.tcl:132
+msgid "LOCAL:\n"
+msgstr "LOCAL:\n"
+
+#: lib/diff.tcl:135
+msgid "REMOTE:\n"
+msgstr "REMOTE\n"
+
+#: lib/diff.tcl:197 lib/diff.tcl:296
 #, tcl-format
 msgid "Unable to display %s"
 msgstr "%s =E3=82=92=E8=A1=A8=E7=A4=BA=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=
=9B=E3=82=93"
=20
-#: lib/diff.tcl:117
+#: lib/diff.tcl:198
 msgid "Error loading file:"
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=82=92=E8=AA=AD=E3=82=80=
=E9=9A=9B=E3=81=AE=E3=82=A8=E3=83=A9=E3=83=BC=E3=81=A7=E3=81=99:"
=20
-#: lib/diff.tcl:124
+#: lib/diff.tcl:205
 msgid "Git Repository (subproject)"
 msgstr "Git =E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA(=E3=82=B5=E3=
=83=96=E3=83=97=E3=83=AD=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88)"
=20
-#: lib/diff.tcl:136
+#: lib/diff.tcl:217
 msgid "* Binary file (not showing content)."
 msgstr "* =E3=83=90=E3=82=A4=E3=83=8A=E3=83=AA=E3=83=95=E3=82=A1=E3=82=
=A4=E3=83=AB(=E5=86=85=E5=AE=B9=E3=81=AF=E8=A1=A8=E7=A4=BA=E3=81=97=E3=81=
=BE=E3=81=9B=E3=82=93)"
=20
-#: lib/diff.tcl:191
-msgid "Error loading diff:"
-msgstr "diff =E3=82=92=E8=AA=AD=E3=82=80=E9=9A=9B=E3=81=AE=E3=82=A8=E3=
=83=A9=E3=83=BC=E3=81=A7=E3=81=99:"
+#: lib/diff.tcl:222
+#, tcl-format
+msgid ""
+"* Untracked file is %d bytes.\n"
+"* Showing only first %d bytes.\n"
+msgstr ""
+"\n"
+"* =E7=AE=A1=E7=90=86=E5=A4=96=E3=81=AE=E3=83=95=E3=82=A1=E3=82=A4=E3=83=
=AB=E3=81=AE=E5=A4=A7=E3=81=8D=E3=81=95=E3=81=AF %d =E3=83=90=E3=82=A4=E3=
=83=88=E3=81=A7=E3=81=99=E3=80=82\n"
+"* =E6=9C=80=E5=88=9D=E3=81=AE %d =E3=83=90=E3=82=A4=E3=83=88=E3=81=A0=
=E3=81=91=E8=A1=A8=E7=A4=BA=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99=
=E3=80=82\n"
+
+#: lib/diff.tcl:228
+#, tcl-format
+msgid ""
+"\n"
+"* Untracked file clipped here by %s.\n"
+"* To see the entire file, use an external editor.\n"
+msgstr ""
+"\n"
+"\n"
+"* %s =E3=81=AF=E7=AE=A1=E7=90=86=E5=A4=96=E3=81=AE=E3=83=95=E3=82=A1=E3=
=82=A4=E3=83=AB=E3=82=92=E3=81=93=E3=81=93=E3=81=A7=E5=88=87=E3=82=8A=E3=
=81=8A=E3=81=A8=E3=81=97=E3=81=BE=E3=81=97=E3=81=9F=E3=80=82\n"
+"* =E5=85=A8=E4=BD=93=E3=82=92=E8=A6=8B=E3=82=8B=E3=81=AB=E3=81=AF=E5=A4=
=96=E9=83=A8=E3=82=A8=E3=83=87=E3=82=A3=E3=82=BF=E3=82=92=E4=BD=BF=E3=81=
=A3=E3=81=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84=E3=80=82\n"
=20
-#: lib/diff.tcl:313
+#: lib/diff.tcl:436
 msgid "Failed to unstage selected hunk."
 msgstr "=E9=81=B8=E6=8A=9E=E3=81=95=E3=82=8C=E3=81=9F=E3=83=91=E3=83=83=
=E3=83=81=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=
=E3=81=8B=E3=82=89=E5=A4=96=E3=81=9B=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82=
"
=20
-#: lib/diff.tcl:320
+#: lib/diff.tcl:443
 msgid "Failed to stage selected hunk."
 msgstr "=E9=81=B8=E6=8A=9E=E3=81=95=E3=82=8C=E3=81=9F=E3=83=91=E3=83=83=
=E3=83=81=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=
=E3=81=AB=E5=8A=A0=E3=81=88=E3=82=89=E3=82=8C=E3=81=BE=E3=81=9B=E3=82=93=
=E3=80=82"
=20
-#: lib/diff.tcl:386
+#: lib/diff.tcl:509
 msgid "Failed to unstage selected line."
 msgstr "=E9=81=B8=E6=8A=9E=E3=81=95=E3=82=8C=E3=81=9F=E3=83=91=E3=83=83=
=E3=83=81=E8=A1=8C=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=
=E5=AE=9A=E3=81=8B=E3=82=89=E5=A4=96=E3=81=9B=E3=81=BE=E3=81=9B=E3=82=93=
=E3=80=82"
=20
-#: lib/diff.tcl:394
+#: lib/diff.tcl:517
 msgid "Failed to stage selected line."
 msgstr "=E9=81=B8=E6=8A=9E=E3=81=95=E3=82=8C=E3=81=9F=E3=83=91=E3=83=83=
=E3=83=81=E8=A1=8C=E3=82=92=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=
=E5=AE=9A=E3=81=AB=E5=8A=A0=E3=81=88=E3=82=89=E3=82=8C=E3=81=BE=E3=81=9B=
=E3=82=93=E3=80=82"
=20
+#: lib/encoding.tcl:443
+msgid "Default"
+msgstr "=E3=83=87=E3=83=95=E3=82=A9=E3=83=BC=E3=83=AB=E3=83=88"
+
+#: lib/encoding.tcl:448
+#, tcl-format
+msgid "System (%s)"
+msgstr "=E3=82=B7=E3=82=B9=E3=83=86=E3=83=A0 (%s)"
+
+#: lib/encoding.tcl:459 lib/encoding.tcl:465
+msgid "Other"
+msgstr "=E3=81=9D=E3=81=AE=E4=BB=96"
+
 #: lib/error.tcl:20 lib/error.tcl:114
 msgid "error"
 msgstr "=E3=82=A8=E3=83=A9=E3=83=BC"
@@ -1527,38 +1684,47 @@ msgstr "=E7=B6=9A=E8=A1=8C"
 msgid "Unlock Index"
 msgstr "=E3=82=A4=E3=83=B3=E3=83=87=E3=83=83=E3=82=AF=E3=82=B9=E3=81=AE=
=E3=83=AD=E3=83=83=E3=82=AF=E8=A7=A3=E9=99=A4"
=20
-#: lib/index.tcl:282
+#: lib/index.tcl:287
 #, tcl-format
 msgid "Unstaging %s from commit"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=8B=E3=82=89 '%s' =E3=
=82=92=E9=99=8D=E3=82=8D=E3=81=99"
=20
-#: lib/index.tcl:313
+#: lib/index.tcl:326
 msgid "Ready to commit."
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E6=BA=96=E5=82=99=E5=AE=8C=
=E4=BA=86"
=20
-#: lib/index.tcl:326
+#: lib/index.tcl:339
 #, tcl-format
 msgid "Adding %s"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=AB %s =E3=82=92=E5=8A=
=A0=E3=81=88=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
=20
-#: lib/index.tcl:381
+#: lib/index.tcl:396
 #, tcl-format
 msgid "Revert changes in file %s?"
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB %s =E3=81=AB=E3=81=97=E3=81=
=9F=E5=A4=89=E6=9B=B4=E3=82=92=E5=85=83=E3=81=AB=E6=88=BB=E3=81=97=E3=81=
=BE=E3=81=99=E3=81=8B=EF=BC=9F"
=20
-#: lib/index.tcl:383
+#: lib/index.tcl:398
 #, tcl-format
 msgid "Revert changes in these %i files?"
 msgstr "=E3=81=93=E3=82=8C=E3=82=89 %i =E5=80=8B=E3=81=AE=E3=83=95=E3=82=
=A1=E3=82=A4=E3=83=AB=E3=81=AB=E3=81=97=E3=81=9F=E5=A4=89=E6=9B=B4=E3=82=
=92=E5=85=83=E3=81=AB=E6=88=BB=E3=81=97=E3=81=BE=E3=81=99=E3=81=8B=EF=BC=
=9F"
=20
-#: lib/index.tcl:391
+#: lib/index.tcl:406
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr "=E5=A4=89=E6=9B=B4=E3=82=92=E5=85=83=E3=81=AB=E6=88=BB=E3=81=99=
=E3=81=A8=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=E3=81=97=
=E3=81=A6=E3=81=84=E3=81=AA=E3=81=84=E5=A4=89=E6=9B=B4=E3=81=AF=E5=85=A8=
=E3=81=A6=E5=A4=B1=E3=82=8F=E3=82=8C=E3=81=BE=E3=81=99=E3=80=82"
=20
-#: lib/index.tcl:394
+#: lib/index.tcl:409
 msgid "Do Nothing"
 msgstr "=E4=BD=95=E3=82=82=E3=81=97=E3=81=AA=E3=81=84"
=20
+#: lib/index.tcl:427
+msgid "Reverting selected files"
+msgstr "=E9=81=B8=E6=8A=9E=E3=81=95=E3=82=8C=E3=81=9F=E3=83=95=E3=82=A1=
=E3=82=A4=E3=83=AB=E3=81=AB=E3=81=97=E3=81=9F=E5=A4=89=E6=9B=B4=E3=82=92=
=E5=85=83=E3=81=AB=E6=88=BB=E3=81=97=E3=81=BE=E3=81=99"
+
+#: lib/index.tcl:431
+#, tcl-format
+msgid "Reverting %s"
+msgstr "%s =E3=81=AB=E3=81=97=E3=81=9F=E5=A4=89=E6=9B=B4=E3=82=92=E5=85=
=83=E3=81=AB=E6=88=BB=E3=81=97=E3=81=BE=E3=81=99"
+
 #: lib/merge.tcl:13
 msgid ""
 "Cannot merge while amending.\n"
@@ -1585,7 +1751,7 @@ msgstr ""
 "\n"
 "=E8=87=AA=E5=8B=95=E7=9A=84=E3=81=AB=E5=86=8D=E3=82=B9=E3=82=AD=E3=83=
=A3=E3=83=B3=E3=82=92=E9=96=8B=E5=A7=8B=E3=81=97=E3=81=BE=E3=81=99=E3=80=
=82\n"
=20
-#: lib/merge.tcl:44
+#: lib/merge.tcl:45
 #, tcl-format
 msgid ""
 "You are in the middle of a conflicted merge.\n"
@@ -1602,7 +1768,7 @@ msgstr ""
 "=E3=81=93=E3=81=AE=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=81=AE=E8=A1=
=9D=E7=AA=81=E3=82=92=E8=A7=A3=E6=B1=BA=E3=81=97=E3=80=81=E3=82=B3=E3=83=
=9F=E3=83=83=E3=83=88=E4=BA=88=E5=AE=9A=E3=81=AB=E5=8A=A0=E3=81=88=E3=81=
=A6=E3=80=81=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=81=99=E3=82=8B=E3=81=
=93=E3=81=A8=E3=81=A7=E3=83=9E=E3=83=BC=E3=82=B8=E3=82=92"
 "=E5=AE=8C=E4=BA=86=E3=81=97=E3=81=BE=E3=81=99=E3=80=82=E3=81=9D=E3=81=
=86=E3=82=84=E3=81=A3=E3=81=A6=E5=A7=8B=E3=82=81=E3=81=A6=E3=80=81=E6=96=
=B0=E3=81=9F=E3=81=AA=E3=83=9E=E3=83=BC=E3=82=B8=E3=82=92=E9=96=8B=E5=A7=
=8B=E3=81=A7=E3=81=8D=E3=82=8B=E3=82=88=E3=81=86=E3=81=AB=E3=81=AA=E3=82=
=8A=E3=81=BE=E3=81=99=E3=80=82\n"
=20
-#: lib/merge.tcl:54
+#: lib/merge.tcl:55
 #, tcl-format
 msgid ""
 "You are in the middle of a change.\n"
@@ -1619,34 +1785,34 @@ msgstr ""
 "=E7=8F=BE=E5=9C=A8=E3=81=AE=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=82=
=92=E5=AE=8C=E4=BA=86=E3=81=97=E3=81=A6=E3=81=8B=E3=82=89=E3=83=9E=E3=83=
=BC=E3=82=B8=E3=82=92=E9=96=8B=E5=A7=8B=E3=81=97=E3=81=A6=E4=B8=8B=E3=81=
=95=E3=81=84=E3=80=82=E3=81=9D=E3=81=86=E3=81=99=E3=82=8B=E6=96=B9=E3=81=
=8C=E3=83=9E=E3=83=BC=E3=82=B8=E3=81=AB=E5=A4=B1=E6=95=97"
 "=E3=81=97=E3=81=9F=E3=81=A8=E3=81=8D=E3=81=AE=E5=9B=9E=E5=BE=A9=E3=81=
=8C=E6=A5=BD=E3=81=A7=E3=81=99=E3=80=82\n"
=20
-#: lib/merge.tcl:106
+#: lib/merge.tcl:107
 #, tcl-format
 msgid "%s of %s"
 msgstr "%s =E3=81=AE %s =E3=83=96=E3=83=A9=E3=83=B3=E3=83=81"
=20
-#: lib/merge.tcl:119
+#: lib/merge.tcl:120
 #, tcl-format
 msgid "Merging %s and %s..."
 msgstr "%s =E3=81=A8 %s =E3=82=92=E3=83=9E=E3=83=BC=E3=82=B8=E4=B8=AD=E3=
=83=BB=E3=83=BB=E3=83=BB"
=20
-#: lib/merge.tcl:130
+#: lib/merge.tcl:131
 msgid "Merge completed successfully."
 msgstr "=E3=83=9E=E3=83=BC=E3=82=B8=E3=81=8C=E5=AE=8C=E4=BA=86=E3=81=97=
=E3=81=BE=E3=81=97=E3=81=9F"
=20
-#: lib/merge.tcl:132
+#: lib/merge.tcl:133
 msgid "Merge failed.  Conflict resolution is required."
 msgstr "=E3=83=9E=E3=83=BC=E3=82=B8=E3=81=8C=E5=A4=B1=E6=95=97=E3=81=97=
=E3=81=BE=E3=81=97=E3=81=9F=E3=80=82=E8=A1=9D=E7=AA=81=E3=81=AE=E8=A7=A3=
=E6=B1=BA=E3=81=8C=E5=BF=85=E8=A6=81=E3=81=A7=E3=81=99=E3=80=82"
=20
-#: lib/merge.tcl:157
+#: lib/merge.tcl:158
 #, tcl-format
 msgid "Merge Into %s"
 msgstr "%s =E3=81=AB=E3=83=9E=E3=83=BC=E3=82=B8"
=20
-#: lib/merge.tcl:176
+#: lib/merge.tcl:177
 msgid "Revision To Merge"
 msgstr "=E3=83=9E=E3=83=BC=E3=82=B8=E3=81=99=E3=82=8B=E3=83=AA=E3=83=93=
=E3=82=B8=E3=83=A7=E3=83=B3"
=20
-#: lib/merge.tcl:211
+#: lib/merge.tcl:212
 msgid ""
 "Cannot abort while amending.\n"
 "\n"
@@ -1656,7 +1822,7 @@ msgstr ""
 "\n"
 "=E3=81=BE=E3=81=9A=E4=BB=8A=E3=81=AE=E3=82=B3=E3=83=9F=E3=83=83=E3=83=
=88=E8=A8=82=E6=AD=A3=E3=82=92=E5=AE=8C=E4=BA=86=E3=81=95=E3=81=9B=E3=81=
=A6=E4=B8=8B=E3=81=95=E3=81=84=E3=80=82\n"
=20
-#: lib/merge.tcl:221
+#: lib/merge.tcl:222
 msgid ""
 "Abort merge?\n"
 "\n"
@@ -1670,7 +1836,7 @@ msgstr ""
 "\n"
 "=E3=83=9E=E3=83=BC=E3=82=B8=E3=82=92=E4=B8=AD=E6=96=AD=E3=81=97=E3=81=
=A6=E3=82=88=E3=82=8D=E3=81=97=E3=81=84=E3=81=A7=E3=81=99=E3=81=8B=EF=BC=
=9F"
=20
-#: lib/merge.tcl:227
+#: lib/merge.tcl:228
 msgid ""
 "Reset changes?\n"
 "\n"
@@ -1684,131 +1850,326 @@ msgstr ""
 "\n"
 "=E3=83=AA=E3=82=BB=E3=83=83=E3=83=88=E3=81=97=E3=81=A6=E3=82=88=E3=82=
=8D=E3=81=97=E3=81=84=E3=81=A7=E3=81=99=E3=81=8B=EF=BC=9F"
=20
-#: lib/merge.tcl:238
+#: lib/merge.tcl:239
 msgid "Aborting"
 msgstr "=E4=B8=AD=E6=96=AD=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99=
"
=20
-#: lib/merge.tcl:238
+#: lib/merge.tcl:239
 msgid "files reset"
 msgstr "=E3=83=AA=E3=82=BB=E3=83=83=E3=83=88=E3=81=97=E3=81=9F=E3=83=95=
=E3=82=A1=E3=82=A4=E3=83=AB"
=20
-#: lib/merge.tcl:266
+#: lib/merge.tcl:267
 msgid "Abort failed."
 msgstr "=E4=B8=AD=E6=96=AD=E3=81=AB=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=
=E3=81=97=E3=81=9F=E3=80=82"
=20
-#: lib/merge.tcl:268
+#: lib/merge.tcl:269
 msgid "Abort completed.  Ready."
 msgstr "=E4=B8=AD=E6=96=AD=E5=AE=8C=E4=BA=86=E3=80=82"
=20
-#: lib/option.tcl:95
+#: lib/mergetool.tcl:8
+msgid "Force resolution to the base version?"
+msgstr "=E5=85=B1=E9=80=9A=E3=81=AE=E7=89=88=E3=82=92=E4=BD=BF=E3=81=84=
=E3=81=BE=E3=81=99=E3=81=8B?"
+
+#: lib/mergetool.tcl:9
+msgid "Force resolution to this branch?"
+msgstr "=E8=87=AA=E5=88=86=E3=81=AE=E5=81=B4=E3=81=AE=E7=89=88=E3=82=92=
=E4=BD=BF=E3=81=84=E3=81=BE=E3=81=99=E3=81=8B?"
+
+#: lib/mergetool.tcl:10
+msgid "Force resolution to the other branch?"
+msgstr "=E7=9B=B8=E6=89=8B=E5=88=B6=E3=81=AE=E7=89=88=E3=82=92=E4=BD=BF=
=E3=81=84=E3=81=BE=E3=81=99=E3=81=8B?"
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
+"\n"
+"=E7=AB=B6=E5=90=88=E3=81=99=E3=82=8B=E5=A4=89=E6=9B=B4=E7=82=B9=E3=81=
=A0=E3=81=91=E3=81=8C=E8=A1=A8=E7=A4=BA=E3=81=95=E3=82=8C=E3=81=A6=E3=81=
=84=E3=82=8B=E3=81=93=E3=81=A8=E3=81=AB=E6=B3=A8=E6=84=8F=E3=81=97=E3=81=
=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84=E3=80=82\n"
+"\n"
+"%s =E3=81=AF=E4=B8=8A=E6=9B=B8=E3=81=8D=E3=81=95=E3=82=8C=E3=81=BE=E3=
=81=99=E3=80=82\n"
+"\n"
+"=E3=82=84=E3=82=8A=E7=9B=B4=E3=81=99=E3=81=AB=E3=81=AF=E3=83=9E=E3=83=
=BC=E3=82=B8=E5=85=A8=E4=BD=93=E3=82=92=E3=82=84=E3=82=8A=E7=9B=B4=E3=81=
=97=E3=81=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84=E3=80=82"
+
+#: lib/mergetool.tcl:45
+#, tcl-format
+msgid "File %s seems to have unresolved conflicts, still stage?"
+msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB %s =E3=81=AB=E3=81=AF=E8=A7=
=A3=E6=B1=BA=E3=81=97=E3=81=A6=E3=81=84=E3=81=AA=E3=81=84=E7=AB=B6=E5=90=
=88=E9=83=A8=E5=88=86=E3=81=8C=E3=81=BE=E3=81=A0=E3=81=82=E3=82=8B=E3=82=
=88=E3=81=86=E3=81=A7=E3=81=99=E3=81=8C=E3=80=81=E3=81=84=E3=81=84=E3=81=
=A7=E3=81=99=E3=81=8B?"
+
+#: lib/mergetool.tcl:60
+#, tcl-format
+msgid "Adding resolution for %s"
+msgstr "%s =E3=81=B8=E3=81=AE=E8=A7=A3=E6=B1=BA=E3=82=92=E3=82=B9=E3=83=
=86=E3=83=BC=E3=82=B8=E3=81=97=E3=81=BE=E3=81=99"
+
+#: lib/mergetool.tcl:141
+msgid "Cannot resolve deletion or link conflicts using a tool"
+msgstr "=E3=83=84=E3=83=BC=E3=83=AB=E3=81=A7=E3=81=AF=E5=89=8A=E9=99=A4=
=E3=82=84=E3=83=AA=E3=83=B3=E3=82=AF=E7=AB=B6=E5=90=88=E3=81=AF=E6=89=B1=
=E3=81=88=E3=81=BE=E3=81=9B=E3=82=93"
+
+#: lib/mergetool.tcl:146
+msgid "Conflict file does not exist"
+msgstr "=E7=AB=B6=E5=90=88=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=81=AF=
=E5=AD=98=E5=9C=A8=E3=81=97=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82"
+
+#: lib/mergetool.tcl:264
+#, tcl-format
+msgid "Not a GUI merge tool: '%s'"
+msgstr "GUI =E3=83=9E=E3=83=BC=E3=82=B8=E3=83=84=E3=83=BC=E3=83=AB=E3=81=
=A7=E3=81=AF=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93: %s"
+
+#: lib/mergetool.tcl:268
+#, tcl-format
+msgid "Unsupported merge tool '%s'"
+msgstr "=E3=83=9E=E3=83=BC=E3=82=B8=E3=83=84=E3=83=BC=E3=83=AB '%s' =E3=
=81=AF=E3=82=B5=E3=83=9D=E3=83=BC=E3=83=88=E3=81=97=E3=81=A6=E3=81=84=E3=
=81=BE=E3=81=9B=E3=82=93"
+
+#: lib/mergetool.tcl:303
+msgid "Merge tool is already running, terminate it?"
+msgstr "=E3=83=9E=E3=83=BC=E3=82=B8=E3=83=84=E3=83=BC=E3=83=AB=E3=81=AF=
=E3=81=99=E3=81=A7=E3=81=AB=E8=B5=B7=E5=8B=95=E3=81=97=E3=81=A6=E3=81=84=
=E3=81=BE=E3=81=99=E3=80=82=E7=B5=82=E4=BA=86=E3=81=97=E3=81=BE=E3=81=99=
=E3=81=8B?"
+
+#: lib/mergetool.tcl:323
+#, tcl-format
+msgid ""
+"Error retrieving versions:\n"
+"%s"
+msgstr ""
+"\n"
+"=E7=89=88=E3=81=AE=E5=8F=96=E3=82=8A=E5=87=BA=E3=81=97=E6=99=82=E3=81=
=AB=E3=82=A8=E3=83=A9=E3=83=BC=E3=81=8C=E5=87=BA=E3=81=BE=E3=81=97=E3=81=
=9F:\n"
+"%s"
+
+#: lib/mergetool.tcl:343
+#, tcl-format
+msgid ""
+"Could not start the merge tool:\n"
+"\n"
+"%s"
+msgstr ""
+"\n"
+"=E3=83=9E=E3=83=BC=E3=82=B8=E3=83=84=E3=83=BC=E3=83=AB=E3=81=8C=E8=B5=
=B7=E5=8B=95=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93:\n"
+"\n"
+"%s"
+
+#: lib/mergetool.tcl:347
+msgid "Running merge tool..."
+msgstr "=E3=83=9E=E3=83=BC=E3=82=B8=E3=83=84=E3=83=BC=E3=83=AB=E3=82=92=
=E5=AE=9F=E8=A1=8C=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99..."
+
+#: lib/mergetool.tcl:375 lib/mergetool.tcl:383
+msgid "Merge tool failed."
+msgstr "=E3=83=9E=E3=83=BC=E3=82=B8=E3=83=84=E3=83=BC=E3=83=AB=E3=81=8C=
=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=E3=81=97=E3=81=9F=E3=80=82"
+
+#: lib/option.tcl:11
+#, tcl-format
+msgid "Invalid global encoding '%s'"
+msgstr "=E5=85=A8=E4=BD=93=E3=82=A8=E3=83=B3=E3=82=B3=E3=83=BC=E3=83=87=
=E3=82=A3=E3=83=B3=E3=82=B0=E3=81=AB =E7=84=A1=E5=8A=B9=E3=81=AA %s =E3=
=81=8C=E6=8C=87=E5=AE=9A=E3=81=95=E3=82=8C=E3=81=A6=E3=81=84=E3=81=BE=E3=
=81=99"
+
+#: lib/option.tcl:19
+#, tcl-format
+msgid "Invalid repo encoding '%s'"
+msgstr "=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA=E3=82=A8=E3=83=B3=
=E3=82=B3=E3=83=BC=E3=83=87=E3=82=A3=E3=83=B3=E3=82=B0=E3=81=AB =E7=84=A1=
=E5=8A=B9=E3=81=AA %s =E3=81=8C=E6=8C=87=E5=AE=9A=E3=81=95=E3=82=8C=E3=81=
=A6=E3=81=84=E3=81=BE=E3=81=99"
+
+#: lib/option.tcl:117
 msgid "Restore Defaults"
 msgstr "=E6=97=A2=E5=AE=9A=E5=80=A4=E3=81=AB=E6=88=BB=E3=81=99"
=20
-#: lib/option.tcl:99
+#: lib/option.tcl:121
 msgid "Save"
 msgstr "=E4=BF=9D=E5=AD=98"
=20
-#: lib/option.tcl:109
+#: lib/option.tcl:131
 #, tcl-format
 msgid "%s Repository"
 msgstr "%s =E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA"
=20
-#: lib/option.tcl:110
+#: lib/option.tcl:132
 msgid "Global (All Repositories)"
 msgstr "=E5=A4=A7=E5=9F=9F=EF=BC=88=E5=85=A8=E3=81=A6=E3=81=AE=E3=83=AA=
=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA=EF=BC=89"
=20
-#: lib/option.tcl:116
+#: lib/option.tcl:138
 msgid "User Name"
 msgstr "=E3=83=A6=E3=83=BC=E3=82=B6=E5=90=8D"
=20
-#: lib/option.tcl:117
+#: lib/option.tcl:139
 msgid "Email Address"
 msgstr "=E9=9B=BB=E5=AD=90=E3=83=A1=E3=83=BC=E3=83=AB=E3=82=A2=E3=83=89=
=E3=83=AC=E3=82=B9"
=20
-#: lib/option.tcl:119
+#: lib/option.tcl:141
 msgid "Summarize Merge Commits"
 msgstr "=E3=83=9E=E3=83=BC=E3=82=B8=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=
=E3=81=AE=E8=A6=81=E7=B4=84"
=20
-#: lib/option.tcl:120
+#: lib/option.tcl:142
 msgid "Merge Verbosity"
 msgstr "=E3=83=9E=E3=83=BC=E3=82=B8=E3=81=AE=E5=86=97=E9=95=B7=E5=BA=A6=
"
=20
-#: lib/option.tcl:121
+#: lib/option.tcl:143
 msgid "Show Diffstat After Merge"
 msgstr "=E3=83=9E=E3=83=BC=E3=82=B8=E5=BE=8C=E3=81=AB diffstat =E3=82=92=
=E8=A1=A8=E7=A4=BA"
=20
-#: lib/option.tcl:123
+#: lib/option.tcl:144
+msgid "Use Merge Tool"
+msgstr "=E3=83=9E=E3=83=BC=E3=82=B8=E3=83=84=E3=83=BC=E3=83=AB=E3=82=92=
=E4=BD=BF=E7=94=A8"
+
+#: lib/option.tcl:146
 msgid "Trust File Modification Timestamps"
 msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E5=A4=89=E6=9B=B4=E6=99=82=
=E5=88=BB=E3=82=92=E4=BF=A1=E9=A0=BC=E3=81=99=E3=82=8B"
=20
-#: lib/option.tcl:124
+#: lib/option.tcl:147
 msgid "Prune Tracking Branches During Fetch"
 msgstr "=E3=83=95=E3=82=A7=E3=83=83=E3=83=81=E4=B8=AD=E3=81=AB=E3=83=88=
=E3=83=A9=E3=83=83=E3=82=AD=E3=83=B3=E3=82=B0=E3=83=96=E3=83=A9=E3=83=B3=
=E3=83=81=E3=82=92=E5=88=88=E3=82=8B"
=20
-#: lib/option.tcl:125
+#: lib/option.tcl:148
 msgid "Match Tracking Branches"
 msgstr "=E3=83=88=E3=83=A9=E3=83=83=E3=82=AD=E3=83=B3=E3=82=B0=E3=83=96=
=E3=83=A9=E3=83=B3=E3=83=81=E3=82=92=E5=90=88=E3=82=8F=E3=81=9B=E3=82=8B=
"
=20
-#: lib/option.tcl:126
+#: lib/option.tcl:149
 msgid "Blame Copy Only On Changed Files"
 msgstr "=E5=A4=89=E6=9B=B4=E3=81=95=E3=82=8C=E3=81=9F=E3=83=95=E3=82=A1=
=E3=82=A4=E3=83=AB=E3=81=AE=E3=81=BF=E3=82=B3=E3=83=94=E3=83=BC=E6=A4=9C=
=E7=9F=A5=E3=82=92=E8=A1=8C=E3=81=AA=E3=81=86"
=20
-#: lib/option.tcl:127
+#: lib/option.tcl:150
 msgid "Minimum Letters To Blame Copy On"
 msgstr "=E3=82=B3=E3=83=94=E3=83=BC=E3=82=92=E6=A4=9C=E7=9F=A5=E3=81=99=
=E3=82=8B=E6=9C=80=E5=B0=91=E6=96=87=E5=AD=97=E6=95=B0"
=20
-#: lib/option.tcl:128
+#: lib/option.tcl:151
+msgid "Blame History Context Radius (days)"
+msgstr "=E8=A8=BB=E9=87=88=E3=81=99=E3=82=8B=E5=B1=A5=E6=AD=B4=E5=8D=8A=
=E5=BE=84=EF=BC=88=E6=97=A5=E6=95=B0=EF=BC=89"
+
+#: lib/option.tcl:152
 msgid "Number of Diff Context Lines"
 msgstr "diff =E3=81=AE=E6=96=87=E8=84=88=E8=A1=8C=E6=95=B0"
=20
-#: lib/option.tcl:129
+#: lib/option.tcl:153
 msgid "Commit Message Text Width"
 msgstr "=E3=82=B3=E3=83=9F=E3=83=83=E3=83=88=E3=83=A1=E3=83=83=E3=82=BB=
=E3=83=BC=E3=82=B8=E3=81=AE=E3=83=86=E3=82=AD=E3=82=B9=E3=83=88=E5=B9=85=
"
=20
-#: lib/option.tcl:130
+#: lib/option.tcl:154
 msgid "New Branch Name Template"
 msgstr "=E6=96=B0=E3=81=97=E3=81=84=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
=E5=90=8D=E3=81=AE=E3=83=86=E3=83=B3=E3=83=97=E3=83=AC=E3=83=BC=E3=83=88=
"
=20
-#: lib/option.tcl:194
+#: lib/option.tcl:155
+msgid "Default File Contents Encoding"
+msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E5=86=85=E5=AE=B9=E3=81=AE=
=E3=83=87=E3=83=95=E3=82=A9=E3=83=BC=E3=83=AB=E3=83=88=E3=82=A8=E3=83=B3=
=E3=82=B3=E3=83=BC=E3=83=87=E3=82=A3=E3=83=B3=E3=82=B0"
+
+#: lib/option.tcl:203
+msgid "Change"
+msgstr "=E5=A4=89=E6=9B=B4"
+
+#: lib/option.tcl:230
 msgid "Spelling Dictionary:"
 msgstr "=E3=82=B9=E3=83=9A=E3=83=AB=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=
=E8=BE=9E=E6=9B=B8"
=20
-#: lib/option.tcl:218
+#: lib/option.tcl:254
 msgid "Change Font"
 msgstr "=E3=83=95=E3=82=A9=E3=83=B3=E3=83=88=E3=82=92=E5=A4=89=E6=9B=B4=
"
=20
-#: lib/option.tcl:222
+#: lib/option.tcl:258
 #, tcl-format
 msgid "Choose %s"
 msgstr "%s =E3=82=92=E9=81=B8=E6=8A=9E"
=20
-#: lib/option.tcl:228
+#: lib/option.tcl:264
 msgid "pt."
 msgstr "=E3=83=9D=E3=82=A4=E3=83=B3=E3=83=88"
=20
-#: lib/option.tcl:242
+#: lib/option.tcl:278
 msgid "Preferences"
 msgstr "=E8=A8=AD=E5=AE=9A"
=20
-#: lib/option.tcl:277
+#: lib/option.tcl:314
 msgid "Failed to completely save options:"
 msgstr "=E5=AE=8C=E5=85=A8=E3=81=AB=E3=82=AA=E3=83=97=E3=82=B7=E3=83=A7=
=E3=83=B3=E3=82=92=E4=BF=9D=E5=AD=98=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=
=E3=82=93:"
=20
-#: lib/remote.tcl:165
+#: lib/remote.tcl:163
+msgid "Remove Remote"
+msgstr "=E3=83=AA=E3=83=A2=E3=83=BC=E3=83=88=E3=82=92=E5=89=8A=E9=99=A4=
"
+
+#: lib/remote.tcl:168
 msgid "Prune from"
 msgstr "=E3=81=8B=E3=82=89=E5=88=88=E8=BE=BC=E3=82=80=E2=80=A6"
=20
-#: lib/remote.tcl:170
+#: lib/remote.tcl:173
 msgid "Fetch from"
 msgstr "=E5=8F=96=E5=BE=97=E5=85=83"
=20
-#: lib/remote.tcl:213
+#: lib/remote.tcl:215
 msgid "Push to"
 msgstr "=E3=83=97=E3=83=83=E3=82=B7=E3=83=A5=E5=85=88"
=20
+#: lib/remote_add.tcl:19
+msgid "Add Remote"
+msgstr "=E3=83=AA=E3=83=A2=E3=83=BC=E3=83=88=E3=82=92=E8=BF=BD=E5=8A=A0=
"
+
+#: lib/remote_add.tcl:24
+msgid "Add New Remote"
+msgstr "=E3=83=AA=E3=83=A2=E3=83=BC=E3=83=88=E3=82=92=E6=96=B0=E8=A6=8F=
=E3=81=AB=E8=BF=BD=E5=8A=A0"
+
+#: lib/remote_add.tcl:28 lib/tools_dlg.tcl:36
+msgid "Add"
+msgstr "=E8=BF=BD=E5=8A=A0"
+
+#: lib/remote_add.tcl:37
+msgid "Remote Details"
+msgstr "=E3=83=AA=E3=83=A2=E3=83=BC=E3=83=88=E3=81=AE=E8=A9=B3=E7=B4=B0=
"
+
+#: lib/remote_add.tcl:50
+msgid "Location:"
+msgstr "=E5=A0=B4=E6=89=80:"
+
+#: lib/remote_add.tcl:62
+msgid "Further Action"
+msgstr "=E3=81=9D=E3=81=AE=E4=BB=96=E3=81=AE=E5=8B=95=E4=BD=9C"
+
+#: lib/remote_add.tcl:65
+msgid "Fetch Immediately"
+msgstr "=E5=8D=B3=E5=BA=A7=E3=81=AB=E5=8F=96=E5=BE=97"
+
+#: lib/remote_add.tcl:71
+msgid "Initialize Remote Repository and Push"
+msgstr "=E3=83=AA=E3=83=A2=E3=83=BC=E3=83=88=E3=83=AC=E3=83=9D=E3=82=B8=
=E3=83=88=E3=83=AA=E3=82=92=E5=88=9D=E6=9C=9F=E5=8C=96=E3=81=97=E3=81=A6=
=E3=83=97=E3=83=83=E3=82=B7=E3=83=A5"
+
+#: lib/remote_add.tcl:77
+msgid "Do Nothing Else Now"
+msgstr "=E4=BD=95=E3=82=82=E3=81=97=E3=81=AA=E3=81=84"
+
+#: lib/remote_add.tcl:101
+msgid "Please supply a remote name."
+msgstr "=E3=83=AA=E3=83=A2=E3=83=BC=E3=83=88=E5=90=8D=E3=82=92=E6=8C=87=
=E5=AE=9A=E3=81=97=E3=81=A6=E4=B8=8B=E3=81=95=E3=81=84=E3=80=82"
+
+#: lib/remote_add.tcl:114
+#, tcl-format
+msgid "'%s' is not an acceptable remote name."
+msgstr "'%s' =E3=81=AF=E3=83=AA=E3=83=A2=E3=83=BC=E3=83=88=E5=90=8D=E3=
=81=AB=E4=BD=BF=E3=81=88=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82"
+
+#: lib/remote_add.tcl:125
+#, tcl-format
+msgid "Failed to add remote '%s' of location '%s'."
+msgstr "=E5=A0=B4=E6=89=80 '%2$s' =E3=81=AE=E3=83=AA=E3=83=A2=E3=83=BC=
=E3=83=88 '%1$s'=E3=81=AE=E5=90=8D=E5=89=8D=E5=A4=89=E6=9B=B4=E3=81=AB=E5=
=A4=B1=E6=95=97=E3=81=97=E3=81=BE=E3=81=97=E3=81=9F=E3=80=82"
+
+#: lib/remote_add.tcl:133 lib/transport.tcl:6
+#, tcl-format
+msgid "fetch %s"
+msgstr "%s =E3=82=92=E5=8F=96=E5=BE=97"
+
+#: lib/remote_add.tcl:134
+#, tcl-format
+msgid "Fetching the %s"
+msgstr "%s =E3=81=8B=E3=82=89=E3=83=95=E3=82=A7=E3=83=83=E3=83=81=E3=81=
=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=99"
+
+#: lib/remote_add.tcl:157
+#, tcl-format
+msgid "Do not know how to initialize repository at location '%s'."
+msgstr "=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA '%s' =E3=82=92=E5=
=88=9D=E6=9C=9F=E5=8C=96=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=9B=E3=82=93=E3=
=80=82"
+
+#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:71
+#, tcl-format
+msgid "push %s"
+msgstr "%s =E3=82=92=E3=83=97=E3=83=83=E3=82=B7=E3=83=A5"
+
+#: lib/remote_add.tcl:164
+#, tcl-format
+msgid "Setting up the %s (at %s)"
+msgstr "%2$s =E3=81=AB=E3=81=82=E3=82=8B %1$s =E3=82=92=E3=82=BB=E3=83=
=83=E3=83=88=E3=82=A2=E3=83=83=E3=83=97=E3=81=97=E3=81=BE=E3=81=99"
+
 #: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
-msgid "Delete Remote Branch"
-msgstr "=E3=83=AA=E3=83=A2=E3=83=BC=E3=83=88=E3=83=BB=E3=83=96=E3=83=A9=
=E3=83=B3=E3=83=81=E3=82=92=E5=89=8A=E9=99=A4"
+msgid "Delete Branch Remotely"
+msgstr "=E9=81=A0=E9=9A=94=E3=81=A7=E3=83=96=E3=83=A9=E3=83=B3=E3=83=81=
=E5=89=8A=E9=99=A4"
=20
 #: lib/remote_branch_delete.tcl:47
 msgid "From Repository"
@@ -1819,8 +2180,8 @@ msgid "Remote:"
 msgstr "=E3=83=AA=E3=83=A2=E3=83=BC=E3=83=88:"
=20
 #: lib/remote_branch_delete.tcl:66 lib/transport.tcl:138
-msgid "Arbitrary URL:"
-msgstr "=E4=BB=BB=E6=84=8F=E3=81=AE URL:"
+msgid "Arbitrary Location:"
+msgstr "=E4=BB=BB=E6=84=8F=E3=81=AE=E4=BD=8D=E7=BD=AE:"
=20
 #: lib/remote_branch_delete.tcl:84
 msgid "Branches"
@@ -1890,6 +2251,22 @@ msgstr "=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=
=AA=E3=81=8C=E9=81=B8=E6=8A=9E=E3=81=95=E3=82=8C=E3=81=A6=E3=81=84=E3=81=
=BE=E3=81=9B=E3=82=93=E3=80=82"
 msgid "Scanning %s..."
 msgstr "%s =E3=82=92=E3=82=B9=E3=82=AD=E3=83=A3=E3=83=B3=E3=81=97=E3=81=
=A6=E3=81=84=E3=81=BE=E3=81=99=E2=80=A6"
=20
+#: lib/search.tcl:21
+msgid "Find:"
+msgstr "=E6=A4=9C=E7=B4=A2:"
+
+#: lib/search.tcl:23
+msgid "Next"
+msgstr "=E6=AC=A1"
+
+#: lib/search.tcl:24
+msgid "Prev"
+msgstr "=E5=89=8D"
+
+#: lib/search.tcl:25
+msgid "Case-Sensitive"
+msgstr "=E5=A4=A7=E6=96=87=E5=AD=97=E5=B0=8F=E6=96=87=E5=AD=97=E3=82=92=
=E5=8C=BA=E5=88=A5"
+
 #: lib/shortcut.tcl:20 lib/shortcut.tcl:61
 msgid "Cannot write shortcut:"
 msgstr "=E3=82=B7=E3=83=A7=E3=83=BC=E3=83=88=E3=82=AB=E3=83=83=E3=83=88=
=E3=81=8C=E6=9B=B8=E3=81=91=E3=81=BE=E3=81=9B=E3=82=93:"
@@ -1927,23 +2304,190 @@ msgstr "=E3=82=B9=E3=83=9A=E3=83=AB=E3=83=81=E3=
=82=A7=E3=83=83=E3=82=AB=E3=83=BC=E3=81=8C=E5=88=A4=E5=88=A5=E3=81=A7=E3=
=81=8D=E3=81=BE=E3=81=9B=E3=82=93"
 msgid "No Suggestions"
 msgstr "=E6=8F=90=E6=A1=88=E3=81=AA=E3=81=97"
=20
-#: lib/spellcheck.tcl:387
+#: lib/spellcheck.tcl:388
 msgid "Unexpected EOF from spell checker"
 msgstr "=E3=82=B9=E3=83=9A=E3=83=AB=E3=83=81=E3=82=A7=E3=83=83=E3=82=AB=
=E3=83=BC=E3=81=8C=E4=BA=88=E6=83=B3=E5=A4=96=E3=81=AE EOF =E3=82=92=E8=
=BF=94=E3=81=97=E3=81=BE=E3=81=97=E3=81=9F"
=20
-#: lib/spellcheck.tcl:391
+#: lib/spellcheck.tcl:392
 msgid "Spell Checker Failed"
 msgstr "=E3=82=B9=E3=83=9A=E3=83=AB=E3=83=81=E3=82=A7=E3=83=83=E3=82=AF=
=E5=A4=B1=E6=95=97"
=20
+#: lib/sshkey.tcl:31
+msgid "No keys found."
+msgstr "=E3=82=AD=E3=83=BC=E3=81=8C=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=
=E3=82=93=E3=80=82"
+
+#: lib/sshkey.tcl:34
+#, tcl-format
+msgid "Found a public key in: %s"
+msgstr "=E5=85=AC=E9=96=8B=E9=8D=B5=E3=81=8C=E3=81=82=E3=82=8A=E3=81=BE=
=E3=81=97=E3=81=9F: %s"
+
+#: lib/sshkey.tcl:40
+msgid "Generate Key"
+msgstr "=E9=8D=B5=E3=82=92=E7=94=9F=E6=88=90"
+
+#: lib/sshkey.tcl:56
+msgid "Copy To Clipboard"
+msgstr "=E3=82=AF=E3=83=AA=E3=83=83=E3=83=97=E3=83=9C=E3=83=BC=E3=83=89=
=E3=81=AB=E3=82=B3=E3=83=94=E3=83=BC"
+
+#: lib/sshkey.tcl:70
+msgid "Your OpenSSH Public Key"
+msgstr "=E3=81=82=E3=81=AA=E3=81=9F=E3=81=AE OpenSSH =E5=85=AC=E9=96=8B=
=E9=8D=B5"
+
+#: lib/sshkey.tcl:78
+msgid "Generating..."
+msgstr "=E7=94=9F=E6=88=90=E4=B8=AD..."
+
+#: lib/sshkey.tcl:84
+#, tcl-format
+msgid ""
+"Could not start ssh-keygen:\n"
+"\n"
+"%s"
+msgstr ""
+"\n"
+"ssh-keygen =E3=82=92=E8=B5=B7=E5=8B=95=E3=81=A7=E3=81=8D=E3=81=BE=E3=81=
=9B=E3=82=93:\n"
+"\n"
+"%s"
+
+#: lib/sshkey.tcl:111
+msgid "Generation failed."
+msgstr "=E7=94=9F=E6=88=90=E3=81=AB=E5=A4=B1=E6=95=97=E3=81=97=E3=81=BE=
=E3=81=97=E3=81=9F=E3=80=82"
+
+#: lib/sshkey.tcl:118
+msgid "Generation succeded, but no keys found."
+msgstr "=E7=94=9F=E6=88=90=E3=81=AB=E3=81=AF=E6=88=90=E5=8A=9F=E3=81=97=
=E3=81=BE=E3=81=97=E3=81=9F=E3=81=8C=E3=80=81=E9=8D=B5=E3=81=8C=E8=A6=8B=
=E3=81=A4=E3=81=8B=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93=E3=80=82"
+
+#: lib/sshkey.tcl:121
+#, tcl-format
+msgid "Your key is in: %s"
+msgstr "=E3=81=82=E3=81=AA=E3=81=9F=E3=81=AE=E9=8D=B5=E3=81=AF %s =E3=81=
=AB=E3=81=82=E3=82=8A=E3=81=BE=E3=81=99"
+
 #: lib/status_bar.tcl:83
 #, tcl-format
 msgid "%s ... %*i of %*i %s (%3i%%)"
 msgstr "%1$s ... %4$*i %6$s =E4=B8=AD=E3=81=AE %2$*i (%7$3i%%)"
=20
-#: lib/transport.tcl:6
+#: lib/tools.tcl:75
 #, tcl-format
-msgid "fetch %s"
-msgstr "%s =E3=82=92=E5=8F=96=E5=BE=97"
+msgid "Running %s requires a selected file."
+msgstr "=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=82=92=E9=81=B8=E6=8A=9E=
=E3=81=97=E3=81=A6=E3=81=8B=E3=82=89 %s =E3=82=92=E8=B5=B7=E5=8B=95=E3=81=
=97=E3=81=A6=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84=E3=80=82"
+
+#: lib/tools.tcl:90
+#, tcl-format
+msgid "Are you sure you want to run %s?"
+msgstr "=E6=9C=AC=E5=BD=93=E3=81=AB %s =E3=82=92=E8=B5=B7=E5=8B=95=E3=81=
=97=E3=81=BE=E3=81=99=E3=81=8B?"
+
+#: lib/tools.tcl:110
+#, tcl-format
+msgid "Tool: %s"
+msgstr "=E3=83=84=E3=83=BC=E3=83=AB: %s"
+
+#: lib/tools.tcl:111
+#, tcl-format
+msgid "Running: %s"
+msgstr "=E5=AE=9F=E8=A1=8C=E4=B8=AD: %s"
+
+#: lib/tools.tcl:149
+#, tcl-format
+msgid "Tool completed succesfully: %s"
+msgstr "=E3=83=84=E3=83=BC=E3=83=AB=E3=81=8C=E5=AE=8C=E4=BA=86=E3=81=97=
=E3=81=BE=E3=81=97=E3=81=9F: %s"
+
+#: lib/tools.tcl:151
+#, tcl-format
+msgid "Tool failed: %s"
+msgstr "=E3=83=84=E3=83=BC=E3=83=AB=E3=81=8C=E5=A4=B1=E6=95=97=E3=81=97=
=E3=81=BE=E3=81=97=E3=81=9F: %s"
+
+#: lib/tools_dlg.tcl:22
+msgid "Add Tool"
+msgstr "=E3=83=84=E3=83=BC=E3=83=AB=E3=81=AE=E8=BF=BD=E5=8A=A0"
+
+#: lib/tools_dlg.tcl:28
+msgid "Add New Tool Command"
+msgstr "=E6=96=B0=E8=A6=8F=E3=83=84=E3=83=BC=E3=83=AB=E3=82=B3=E3=83=9E=
=E3=83=B3=E3=83=89=E3=81=AE=E8=BF=BD=E5=8A=A0"
+
+#: lib/tools_dlg.tcl:33
+msgid "Add globally"
+msgstr "=E5=85=A8=E4=BD=93=E3=81=AB=E8=BF=BD=E5=8A=A0"
+
+#: lib/tools_dlg.tcl:45
+msgid "Tool Details"
+msgstr "=E3=83=84=E3=83=BC=E3=83=AB=E3=81=AE=E8=A9=B3=E7=B4=B0"
+
+#: lib/tools_dlg.tcl:48
+msgid "Use '/' separators to create a submenu tree:"
+msgstr "'/' =E3=81=A7=E3=82=B5=E3=83=96=E3=83=A1=E3=83=8B=E3=83=A5=E3=83=
=BC=E3=82=92=E5=8C=BA=E5=88=87=E3=82=8A=E3=81=BE=E3=81=99:"
+
+#: lib/tools_dlg.tcl:61
+msgid "Command:"
+msgstr "=E3=82=B3=E3=83=9E=E3=83=B3=E3=83=89:"
+
+#: lib/tools_dlg.tcl:74
+msgid "Show a dialog before running"
+msgstr "=E8=B5=B7=E5=8B=95=E3=81=99=E3=82=8B=E5=89=8D=E3=81=AB=E3=83=80=
=E3=82=A4=E3=82=A2=E3=83=AD=E3=82=B0=E3=82=92=E8=A1=A8=E7=A4=BA"
+
+#: lib/tools_dlg.tcl:80
+msgid "Ask the user to select a revision (sets $REVISION)"
+msgstr "=E3=83=A6=E3=83=BC=E3=82=B6=E3=81=AB=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E3=82=92=E4=B8=80=E3=81=A4=E9=81=B8=E3=81=B0=E3=81=9B=E3=82=8B=
 ($REVISION =E3=81=AB=E3=82=BB=E3=83=83=E3=83=88=E3=81=97=E3=81=BE=E3=81=
=99)"
+
+#: lib/tools_dlg.tcl:85
+msgid "Ask the user for additional arguments (sets $ARGS)"
+msgstr "=E3=83=A6=E3=83=BC=E3=82=B6=E3=81=AB=E4=BB=96=E3=81=AE=E5=BC=95=
=E6=95=B0=E3=82=92=E8=BF=BD=E5=8A=A0=E3=81=95=E3=81=9B=E3=82=8B ($ARGS =
=E3=81=AB=E3=82=BB=E3=83=83=E3=83=88=E3=81=97=E3=81=BE=E3=81=99)"
+
+#: lib/tools_dlg.tcl:92
+msgid "Don't show the command output window"
+msgstr "=E3=82=B3=E3=83=9E=E3=83=B3=E3=83=89=E3=81=8B=E3=82=89=E3=81=AE=
=E5=87=BA=E5=8A=9B=E3=82=A6=E3=82=A3=E3=83=B3=E3=83=89=E3=82=A6=E3=82=92=
=E8=A6=8B=E3=81=9B=E3=81=AA=E3=81=84"
+
+#: lib/tools_dlg.tcl:97
+msgid "Run only if a diff is selected ($FILENAME not empty)"
+msgstr "=E3=83=91=E3=83=83=E3=83=81=E3=81=8C=E9=81=B8=E3=81=B0=E3=82=8C=
=E3=81=A6=E3=81=84=E3=82=8B=E3=81=A8=E3=81=8D=E3=81=A0=E3=81=91=E5=8B=95=
=E3=81=8B=E3=81=99($FILENAME =E3=81=8C=E7=A9=BA=E3=81=A7=E3=81=AA=E3=81=
=84)"
+
+#: lib/tools_dlg.tcl:121
+msgid "Please supply a name for the tool."
+msgstr "=E3=83=84=E3=83=BC=E3=83=AB=E5=90=8D=E3=82=92=E6=8C=87=E5=AE=9A=
=E3=81=97=E3=81=A6=E4=B8=8B=E3=81=95=E3=81=84=E3=80=82"
+
+#: lib/tools_dlg.tcl:129
+#, tcl-format
+msgid "Tool '%s' already exists."
+msgstr "=E3=83=84=E3=83=BC=E3=83=AB '%s' =E3=81=AF=E6=97=A2=E3=81=AB=E5=
=AD=98=E5=9C=A8=E3=81=97=E3=81=BE=E3=81=99=E3=80=82"
+
+#: lib/tools_dlg.tcl:151
+#, tcl-format
+msgid ""
+"Could not add tool:\n"
+"%s"
+msgstr ""
+"\n"
+"=E3=83=84=E3=83=BC=E3=83=AB=E3=82=92=E8=BF=BD=E5=8A=A0=E3=81=A7=E3=81=
=8D=E3=81=BE=E3=81=9B=E3=82=93:\n"
+"%s"
+
+#: lib/tools_dlg.tcl:190
+msgid "Remove Tool"
+msgstr "=E3=83=84=E3=83=BC=E3=83=AB=E3=81=AE=E5=89=8A=E9=99=A4"
+
+#: lib/tools_dlg.tcl:196
+msgid "Remove Tool Commands"
+msgstr "=E3=83=84=E3=83=BC=E3=83=AB=E3=82=B3=E3=83=9E=E3=83=B3=E3=83=89=
=E3=81=AE=E5=89=8A=E9=99=A4"
+
+#: lib/tools_dlg.tcl:200
+msgid "Remove"
+msgstr "=E5=89=8A=E9=99=A4"
+
+#: lib/tools_dlg.tcl:236
+msgid "(Blue denotes repository-local tools)"
+msgstr "(=E9=9D=92=E8=89=B2=E3=81=AF=E3=83=AD=E3=83=BC=E3=82=AB=E3=83=AB=
=E3=83=AC=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA=E3=81=AE=E3=83=84=E3=83=BC=
=E3=83=AB=E3=81=A7=E3=81=99)"
+
+#: lib/tools_dlg.tcl:297
+#, tcl-format
+msgid "Run Command: %s"
+msgstr "=E3=82=B3=E3=83=9E=E3=83=B3=E3=83=89=E3=82=92=E8=B5=B7=E5=8B=95=
: %s"
+
+#: lib/tools_dlg.tcl:311
+msgid "Arguments"
+msgstr "=E5=BC=95=E6=95=B0"
+
+#: lib/tools_dlg.tcl:348
+msgid "OK"
+msgstr "OK"
=20
 #: lib/transport.tcl:7
 #, tcl-format
@@ -1960,11 +2504,6 @@ msgstr "=E9=81=A0=E9=9A=94=E5=88=88=E8=BE=BC %s"
 msgid "Pruning tracking branches deleted from %s"
 msgstr "%s =E3=81=8B=E3=82=89=E5=89=8A=E9=99=A4=E3=81=95=E3=82=8C=E3=81=
=9F=E3=83=88=E3=83=A9=E3=83=83=E3=82=AD=E3=83=B3=E3=82=B0=E3=83=BB=E3=83=
=96=E3=83=A9=E3=83=B3=E3=83=81=E3=82=92=E5=88=88=E3=81=A3=E3=81=A6=E3=81=
=84=E3=81=BE=E3=81=99"
=20
-#: lib/transport.tcl:25 lib/transport.tcl:71
-#, tcl-format
-msgid "push %s"
-msgstr "%s =E3=82=92=E3=83=97=E3=83=83=E3=82=B7=E3=83=A5"
-
 #: lib/transport.tcl:26
 #, tcl-format
 msgid "Pushing changes to %s"
--=20
1.6.0.2

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
