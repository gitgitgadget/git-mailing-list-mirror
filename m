From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH 1/2] git-gui: Update git-gui.pot with latest (few) string additions and changes.
Date: Sat, 24 Nov 2007 11:04:31 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200711241104.32371.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wc/RHuC8xtq1LcX"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Nov 24 11:05:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ivrst-0001Jw-Pp
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 11:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbXKXKEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2007 05:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752132AbXKXKEt
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 05:04:49 -0500
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:39439 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbXKXKEr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2007 05:04:47 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lAOA4eVY024943
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 24 Nov 2007 11:04:40 +0100
Received: from [192.168.2.102] (p549032F8.dip0.t-ipconnect.de [84.144.50.248])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lAOA4bmp021134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 24 Nov 2007 11:04:39 +0100
User-Agent: KMail/1.9.5
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65940>

--Boundary-00=_wc/RHuC8xtq1LcX
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

---
I've attached this and the following (German translation update) patch as
tarball as well, just in case mailers will mess with whitespaces again.

This is against master of git-gui.git. Alternatively, you can just as well run
"make po/git-gui.pot" and commit the result.

 po/git-gui.pot |  404 +++++++++++++++++++++++++++++++-------------------------
 1 files changed, 221 insertions(+), 183 deletions(-)

diff --git a/po/git-gui.pot b/po/git-gui.pot
index 00f0f59..dfa48ae 100644
--- a/po/git-gui.pot
+++ b/po/git-gui.pot
@@ -8,7 +8,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: PACKAGE VERSION\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2007-10-10 04:04-0400\n"
+"POT-Creation-Date: 2007-11-24 10:36+0100\n"
 "PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
 "Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
 "Language-Team: LANGUAGE <LL@li.org>\n"
@@ -16,33 +16,33 @@ msgstr ""
 "Content-Type: text/plain; charset=CHARSET\n"
 "Content-Transfer-Encoding: 8bit\n"
 
-#: git-gui.sh:41 git-gui.sh:634 git-gui.sh:648 git-gui.sh:661 git-gui.sh:744
-#: git-gui.sh:763
+#: git-gui.sh:41 git-gui.sh:604 git-gui.sh:618 git-gui.sh:631 git-gui.sh:714
+#: git-gui.sh:733
 msgid "git-gui: fatal error"
 msgstr ""
 
-#: git-gui.sh:595
+#: git-gui.sh:565
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr ""
 
-#: git-gui.sh:620
+#: git-gui.sh:590
 msgid "Main Font"
 msgstr ""
 
-#: git-gui.sh:621
+#: git-gui.sh:591
 msgid "Diff/Console Font"
 msgstr ""
 
-#: git-gui.sh:635
+#: git-gui.sh:605
 msgid "Cannot find git in PATH."
 msgstr ""
 
-#: git-gui.sh:662
+#: git-gui.sh:632
 msgid "Cannot parse Git version string:"
 msgstr ""
 
-#: git-gui.sh:680
+#: git-gui.sh:650
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -54,79 +54,79 @@ msgid ""
 "Assume '%s' is version 1.5.0?\n"
 msgstr ""
 
-#: git-gui.sh:853
+#: git-gui.sh:888
 msgid "Git directory not found:"
 msgstr ""
 
-#: git-gui.sh:860
+#: git-gui.sh:895
 msgid "Cannot move to top of working directory:"
 msgstr ""
 
-#: git-gui.sh:867
+#: git-gui.sh:902
 msgid "Cannot use funny .git directory:"
 msgstr ""
 
-#: git-gui.sh:872
+#: git-gui.sh:907
 msgid "No working directory"
 msgstr ""
 
-#: git-gui.sh:1019
+#: git-gui.sh:1054
 msgid "Refreshing file status..."
 msgstr ""
 
-#: git-gui.sh:1084
+#: git-gui.sh:1119
 msgid "Scanning for modified files ..."
 msgstr ""
 
-#: git-gui.sh:1259 lib/browser.tcl:245
+#: git-gui.sh:1294 lib/browser.tcl:245
 msgid "Ready."
 msgstr ""
 
-#: git-gui.sh:1525
+#: git-gui.sh:1560
 msgid "Unmodified"
 msgstr ""
 
-#: git-gui.sh:1527
+#: git-gui.sh:1562
 msgid "Modified, not staged"
 msgstr ""
 
-#: git-gui.sh:1528 git-gui.sh:1533
+#: git-gui.sh:1563 git-gui.sh:1568
 msgid "Staged for commit"
 msgstr ""
 
-#: git-gui.sh:1529 git-gui.sh:1534
+#: git-gui.sh:1564 git-gui.sh:1569
 msgid "Portions staged for commit"
 msgstr ""
 
-#: git-gui.sh:1530 git-gui.sh:1535
+#: git-gui.sh:1565 git-gui.sh:1570
 msgid "Staged for commit, missing"
 msgstr ""
 
-#: git-gui.sh:1532
+#: git-gui.sh:1567
 msgid "Untracked, not staged"
 msgstr ""
 
-#: git-gui.sh:1537
+#: git-gui.sh:1572
 msgid "Missing"
 msgstr ""
 
-#: git-gui.sh:1538
+#: git-gui.sh:1573
 msgid "Staged for removal"
 msgstr ""
 
-#: git-gui.sh:1539
+#: git-gui.sh:1574
 msgid "Staged for removal, still present"
 msgstr ""
 
-#: git-gui.sh:1541 git-gui.sh:1542 git-gui.sh:1543 git-gui.sh:1544
+#: git-gui.sh:1576 git-gui.sh:1577 git-gui.sh:1578 git-gui.sh:1579
 msgid "Requires merge resolution"
 msgstr ""
 
-#: git-gui.sh:1579
+#: git-gui.sh:1614
 msgid "Starting gitk... please wait..."
 msgstr ""
 
-#: git-gui.sh:1588
+#: git-gui.sh:1623
 #, tcl-format
 msgid ""
 "Unable to start gitk:\n"
@@ -134,295 +134,295 @@ msgid ""
 "%s does not exist"
 msgstr ""
 
-#: git-gui.sh:1788 lib/choose_repository.tcl:32
+#: git-gui.sh:1823 lib/choose_repository.tcl:35
 msgid "Repository"
 msgstr ""
 
-#: git-gui.sh:1789
+#: git-gui.sh:1824
 msgid "Edit"
 msgstr ""
 
-#: git-gui.sh:1791 lib/choose_rev.tcl:560
+#: git-gui.sh:1826 lib/choose_rev.tcl:560
 msgid "Branch"
 msgstr ""
 
-#: git-gui.sh:1794 lib/choose_rev.tcl:547
+#: git-gui.sh:1829 lib/choose_rev.tcl:547
 msgid "Commit@@noun"
 msgstr ""
 
-#: git-gui.sh:1797 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:168
+#: git-gui.sh:1832 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:168
 msgid "Merge"
 msgstr ""
 
-#: git-gui.sh:1798 lib/choose_rev.tcl:556
+#: git-gui.sh:1833 lib/choose_rev.tcl:556
 msgid "Remote"
 msgstr ""
 
-#: git-gui.sh:1807
+#: git-gui.sh:1842
 msgid "Browse Current Branch's Files"
 msgstr ""
 
-#: git-gui.sh:1811
+#: git-gui.sh:1846
 msgid "Browse Branch Files..."
 msgstr ""
 
-#: git-gui.sh:1816
+#: git-gui.sh:1851
 msgid "Visualize Current Branch's History"
 msgstr ""
 
-#: git-gui.sh:1820
+#: git-gui.sh:1855
 msgid "Visualize All Branch History"
 msgstr ""
 
-#: git-gui.sh:1827
+#: git-gui.sh:1862
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr ""
 
-#: git-gui.sh:1829
+#: git-gui.sh:1864
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr ""
 
-#: git-gui.sh:1834 lib/database.tcl:27 lib/database.tcl:67
+#: git-gui.sh:1869 lib/database.tcl:27 lib/database.tcl:67
 msgid "Database Statistics"
 msgstr ""
 
-#: git-gui.sh:1837 lib/database.tcl:34
+#: git-gui.sh:1872 lib/database.tcl:34
 msgid "Compress Database"
 msgstr ""
 
-#: git-gui.sh:1840
+#: git-gui.sh:1875
 msgid "Verify Database"
 msgstr ""
 
-#: git-gui.sh:1847 git-gui.sh:1851 git-gui.sh:1855 lib/shortcut.tcl:9
-#: lib/shortcut.tcl:45 lib/shortcut.tcl:84
+#: git-gui.sh:1882 git-gui.sh:1886 git-gui.sh:1890 lib/shortcut.tcl:7
+#: lib/shortcut.tcl:39 lib/shortcut.tcl:71
 msgid "Create Desktop Icon"
 msgstr ""
 
-#: git-gui.sh:1860 lib/choose_repository.tcl:36 lib/choose_repository.tcl:95
+#: git-gui.sh:1895 lib/choose_repository.tcl:176 lib/choose_repository.tcl:184
 msgid "Quit"
 msgstr ""
 
-#: git-gui.sh:1867
+#: git-gui.sh:1902
 msgid "Undo"
 msgstr ""
 
-#: git-gui.sh:1870
+#: git-gui.sh:1905
 msgid "Redo"
 msgstr ""
 
-#: git-gui.sh:1874 git-gui.sh:2366
+#: git-gui.sh:1909 git-gui.sh:2403
 msgid "Cut"
 msgstr ""
 
-#: git-gui.sh:1877 git-gui.sh:2369 git-gui.sh:2440 git-gui.sh:2512
+#: git-gui.sh:1912 git-gui.sh:2406 git-gui.sh:2477 git-gui.sh:2549
 #: lib/console.tcl:67
 msgid "Copy"
 msgstr ""
 
-#: git-gui.sh:1880 git-gui.sh:2372
+#: git-gui.sh:1915 git-gui.sh:2409
 msgid "Paste"
 msgstr ""
 
-#: git-gui.sh:1883 git-gui.sh:2375 lib/branch_delete.tcl:26
+#: git-gui.sh:1918 git-gui.sh:2412 lib/branch_delete.tcl:26
 #: lib/remote_branch_delete.tcl:38
 msgid "Delete"
 msgstr ""
 
-#: git-gui.sh:1887 git-gui.sh:2379 git-gui.sh:2516 lib/console.tcl:69
+#: git-gui.sh:1922 git-gui.sh:2416 git-gui.sh:2553 lib/console.tcl:69
 msgid "Select All"
 msgstr ""
 
-#: git-gui.sh:1896
+#: git-gui.sh:1931
 msgid "Create..."
 msgstr ""
 
-#: git-gui.sh:1902
+#: git-gui.sh:1937
 msgid "Checkout..."
 msgstr ""
 
-#: git-gui.sh:1908
+#: git-gui.sh:1943
 msgid "Rename..."
 msgstr ""
 
-#: git-gui.sh:1913 git-gui.sh:2012
+#: git-gui.sh:1948 git-gui.sh:2048
 msgid "Delete..."
 msgstr ""
 
-#: git-gui.sh:1918
+#: git-gui.sh:1953
 msgid "Reset..."
 msgstr ""
 
-#: git-gui.sh:1930 git-gui.sh:2313
+#: git-gui.sh:1965 git-gui.sh:2350
 msgid "New Commit"
 msgstr ""
 
-#: git-gui.sh:1938 git-gui.sh:2320
+#: git-gui.sh:1973 git-gui.sh:2357
 msgid "Amend Last Commit"
 msgstr ""
 
-#: git-gui.sh:1947 git-gui.sh:2280 lib/remote_branch_delete.tcl:99
+#: git-gui.sh:1982 git-gui.sh:2317 lib/remote_branch_delete.tcl:99
 msgid "Rescan"
 msgstr ""
 
-#: git-gui.sh:1953
+#: git-gui.sh:1988
 msgid "Stage To Commit"
 msgstr ""
 
-#: git-gui.sh:1958
+#: git-gui.sh:1994
 msgid "Stage Changed Files To Commit"
 msgstr ""
 
-#: git-gui.sh:1964
+#: git-gui.sh:2000
 msgid "Unstage From Commit"
 msgstr ""
 
-#: git-gui.sh:1969 lib/index.tcl:352
+#: git-gui.sh:2005 lib/index.tcl:393
 msgid "Revert Changes"
 msgstr ""
 
-#: git-gui.sh:1976 git-gui.sh:2292 git-gui.sh:2390
+#: git-gui.sh:2012 git-gui.sh:2329 git-gui.sh:2427
 msgid "Sign Off"
 msgstr ""
 
-#: git-gui.sh:1980 git-gui.sh:2296
+#: git-gui.sh:2016 git-gui.sh:2333
 msgid "Commit@@verb"
 msgstr ""
 
-#: git-gui.sh:1991
+#: git-gui.sh:2027
 msgid "Local Merge..."
 msgstr ""
 
-#: git-gui.sh:1996
+#: git-gui.sh:2032
 msgid "Abort Merge..."
 msgstr ""
 
-#: git-gui.sh:2008
+#: git-gui.sh:2044
 msgid "Push..."
 msgstr ""
 
-#: git-gui.sh:2019 lib/choose_repository.tcl:41
+#: git-gui.sh:2055 lib/choose_repository.tcl:40
 msgid "Apple"
 msgstr ""
 
-#: git-gui.sh:2022 git-gui.sh:2044 lib/about.tcl:13
-#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:50
+#: git-gui.sh:2058 git-gui.sh:2080 lib/about.tcl:13
+#: lib/choose_repository.tcl:43 lib/choose_repository.tcl:49
 #, tcl-format
 msgid "About %s"
 msgstr ""
 
-#: git-gui.sh:2026
+#: git-gui.sh:2062
 msgid "Preferences..."
 msgstr ""
 
-#: git-gui.sh:2034 git-gui.sh:2558
+#: git-gui.sh:2070 git-gui.sh:2595
 msgid "Options..."
 msgstr ""
 
-#: git-gui.sh:2040 lib/choose_repository.tcl:47
+#: git-gui.sh:2076 lib/choose_repository.tcl:46
 msgid "Help"
 msgstr ""
 
-#: git-gui.sh:2081
+#: git-gui.sh:2117
 msgid "Online Documentation"
 msgstr ""
 
-#: git-gui.sh:2165
+#: git-gui.sh:2201
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
 msgstr ""
 
-#: git-gui.sh:2198
+#: git-gui.sh:2234
 msgid "Current Branch:"
 msgstr ""
 
-#: git-gui.sh:2219
+#: git-gui.sh:2255
 msgid "Staged Changes (Will Commit)"
 msgstr ""
 
-#: git-gui.sh:2239
+#: git-gui.sh:2274
 msgid "Unstaged Changes"
 msgstr ""
 
-#: git-gui.sh:2286
+#: git-gui.sh:2323
 msgid "Stage Changed"
 msgstr ""
 
-#: git-gui.sh:2302 lib/transport.tcl:93 lib/transport.tcl:182
+#: git-gui.sh:2339 lib/transport.tcl:93 lib/transport.tcl:182
 msgid "Push"
 msgstr ""
 
-#: git-gui.sh:2332
+#: git-gui.sh:2369
 msgid "Initial Commit Message:"
 msgstr ""
 
-#: git-gui.sh:2333
+#: git-gui.sh:2370
 msgid "Amended Commit Message:"
 msgstr ""
 
-#: git-gui.sh:2334
+#: git-gui.sh:2371
 msgid "Amended Initial Commit Message:"
 msgstr ""
 
-#: git-gui.sh:2335
+#: git-gui.sh:2372
 msgid "Amended Merge Commit Message:"
 msgstr ""
 
-#: git-gui.sh:2336
+#: git-gui.sh:2373
 msgid "Merge Commit Message:"
 msgstr ""
 
-#: git-gui.sh:2337
+#: git-gui.sh:2374
 msgid "Commit Message:"
 msgstr ""
 
-#: git-gui.sh:2382 git-gui.sh:2520 lib/console.tcl:71
+#: git-gui.sh:2419 git-gui.sh:2557 lib/console.tcl:71
 msgid "Copy All"
 msgstr ""
 
-#: git-gui.sh:2406 lib/blame.tcl:104
+#: git-gui.sh:2443 lib/blame.tcl:104
 msgid "File:"
 msgstr ""
 
-#: git-gui.sh:2508
+#: git-gui.sh:2545
 msgid "Refresh"
 msgstr ""
 
-#: git-gui.sh:2529
+#: git-gui.sh:2566
 msgid "Apply/Reverse Hunk"
 msgstr ""
 
-#: git-gui.sh:2535
+#: git-gui.sh:2572
 msgid "Decrease Font Size"
 msgstr ""
 
-#: git-gui.sh:2539
+#: git-gui.sh:2576
 msgid "Increase Font Size"
 msgstr ""
 
-#: git-gui.sh:2544
+#: git-gui.sh:2581
 msgid "Show Less Context"
 msgstr ""
 
-#: git-gui.sh:2551
+#: git-gui.sh:2588
 msgid "Show More Context"
 msgstr ""
 
-#: git-gui.sh:2565
+#: git-gui.sh:2602
 msgid "Unstage Hunk From Commit"
 msgstr ""
 
-#: git-gui.sh:2567
+#: git-gui.sh:2604
 msgid "Stage Hunk For Commit"
 msgstr ""
 
-#: git-gui.sh:2586
+#: git-gui.sh:2623
 msgid "Initializing..."
 msgstr ""
 
-#: git-gui.sh:2677
+#: git-gui.sh:2718
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -433,14 +433,14 @@ msgid ""
 "\n"
 msgstr ""
 
-#: git-gui.sh:2707
+#: git-gui.sh:2748
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
 "Tcl binary distributed by Cygwin."
 msgstr ""
 
-#: git-gui.sh:2712
+#: git-gui.sh:2753
 #, tcl-format
 msgid ""
 "\n"
@@ -555,7 +555,7 @@ msgstr ""
 msgid "Create New Branch"
 msgstr ""
 
-#: lib/branch_create.tcl:31 lib/choose_repository.tcl:199
+#: lib/branch_create.tcl:31 lib/choose_repository.tcl:375
 msgid "Create"
 msgstr ""
 
@@ -703,9 +703,9 @@ msgstr ""
 msgid "Browse Branch Files"
 msgstr ""
 
-#: lib/browser.tcl:277 lib/choose_repository.tcl:215
-#: lib/choose_repository.tcl:305 lib/choose_repository.tcl:315
-#: lib/choose_repository.tcl:811
+#: lib/browser.tcl:277 lib/choose_repository.tcl:391
+#: lib/choose_repository.tcl:482 lib/choose_repository.tcl:492
+#: lib/choose_repository.tcl:989
 msgid "Browse"
 msgstr ""
 
@@ -844,209 +844,225 @@ msgid ""
 "If you like this text, it can be your font."
 msgstr ""
 
-#: lib/choose_repository.tcl:25
+#: lib/choose_repository.tcl:27
 msgid "Git Gui"
 msgstr ""
 
-#: lib/choose_repository.tcl:69 lib/choose_repository.tcl:204
+#: lib/choose_repository.tcl:80 lib/choose_repository.tcl:380
 msgid "Create New Repository"
 msgstr ""
 
-#: lib/choose_repository.tcl:74 lib/choose_repository.tcl:291
+#: lib/choose_repository.tcl:86
+msgid "New..."
+msgstr ""
+
+#: lib/choose_repository.tcl:93 lib/choose_repository.tcl:468
 msgid "Clone Existing Repository"
 msgstr ""
 
-#: lib/choose_repository.tcl:79 lib/choose_repository.tcl:800
+#: lib/choose_repository.tcl:99
+msgid "Clone..."
+msgstr ""
+
+#: lib/choose_repository.tcl:106 lib/choose_repository.tcl:978
 msgid "Open Existing Repository"
 msgstr ""
 
-#: lib/choose_repository.tcl:91
-msgid "Next >"
+#: lib/choose_repository.tcl:112
+msgid "Open..."
+msgstr ""
+
+#: lib/choose_repository.tcl:125
+msgid "Recent Repositories"
 msgstr ""
 
-#: lib/choose_repository.tcl:152
+#: lib/choose_repository.tcl:131
+msgid "Open Recent Repository:"
+msgstr ""
+
+#: lib/choose_repository.tcl:294
 #, tcl-format
 msgid "Location %s already exists."
 msgstr ""
 
-#: lib/choose_repository.tcl:158 lib/choose_repository.tcl:165
-#: lib/choose_repository.tcl:172
+#: lib/choose_repository.tcl:300 lib/choose_repository.tcl:307
+#: lib/choose_repository.tcl:314
 #, tcl-format
 msgid "Failed to create repository %s:"
 msgstr ""
 
-#: lib/choose_repository.tcl:209 lib/choose_repository.tcl:309
+#: lib/choose_repository.tcl:385 lib/choose_repository.tcl:486
 msgid "Directory:"
 msgstr ""
 
-#: lib/choose_repository.tcl:238 lib/choose_repository.tcl:363
-#: lib/choose_repository.tcl:834
+#: lib/choose_repository.tcl:415 lib/choose_repository.tcl:544
+#: lib/choose_repository.tcl:1013
 msgid "Git Repository"
 msgstr ""
 
-#: lib/choose_repository.tcl:253 lib/choose_repository.tcl:260
+#: lib/choose_repository.tcl:430 lib/choose_repository.tcl:437
 #, tcl-format
 msgid "Directory %s already exists."
 msgstr ""
 
-#: lib/choose_repository.tcl:265
+#: lib/choose_repository.tcl:442
 #, tcl-format
 msgid "File %s already exists."
 msgstr ""
 
-#: lib/choose_repository.tcl:286
+#: lib/choose_repository.tcl:463
 msgid "Clone"
 msgstr ""
 
-#: lib/choose_repository.tcl:299
+#: lib/choose_repository.tcl:476
 msgid "URL:"
 msgstr ""
 
-#: lib/choose_repository.tcl:319
+#: lib/choose_repository.tcl:496
 msgid "Clone Type:"
 msgstr ""
 
-#: lib/choose_repository.tcl:325
+#: lib/choose_repository.tcl:502
 msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
 msgstr ""
 
-#: lib/choose_repository.tcl:331
+#: lib/choose_repository.tcl:508
 msgid "Full Copy (Slower, Redundant Backup)"
 msgstr ""
 
-#: lib/choose_repository.tcl:337
+#: lib/choose_repository.tcl:514
 msgid "Shared (Fastest, Not Recommended, No Backup)"
 msgstr ""
 
-#: lib/choose_repository.tcl:369 lib/choose_repository.tcl:418
-#: lib/choose_repository.tcl:560 lib/choose_repository.tcl:630
-#: lib/choose_repository.tcl:840 lib/choose_repository.tcl:848
+#: lib/choose_repository.tcl:550 lib/choose_repository.tcl:597
+#: lib/choose_repository.tcl:738 lib/choose_repository.tcl:808
+#: lib/choose_repository.tcl:1019 lib/choose_repository.tcl:1027
 #, tcl-format
 msgid "Not a Git repository: %s"
 msgstr ""
 
-#: lib/choose_repository.tcl:405
+#: lib/choose_repository.tcl:586
 msgid "Standard only available for local repository."
 msgstr ""
 
-#: lib/choose_repository.tcl:409
+#: lib/choose_repository.tcl:590
 msgid "Shared only available for local repository."
 msgstr ""
 
-#: lib/choose_repository.tcl:439
+#: lib/choose_repository.tcl:617
 msgid "Failed to configure origin"
 msgstr ""
 
-#: lib/choose_repository.tcl:451
+#: lib/choose_repository.tcl:629
 msgid "Counting objects"
 msgstr ""
 
-#: lib/choose_repository.tcl:452
+#: lib/choose_repository.tcl:630
 msgid "buckets"
 msgstr ""
 
-#: lib/choose_repository.tcl:476
+#: lib/choose_repository.tcl:654
 #, tcl-format
 msgid "Unable to copy objects/info/alternates: %s"
 msgstr ""
 
-#: lib/choose_repository.tcl:512
+#: lib/choose_repository.tcl:690
 #, tcl-format
 msgid "Nothing to clone from %s."
 msgstr ""
 
-#: lib/choose_repository.tcl:514 lib/choose_repository.tcl:728
-#: lib/choose_repository.tcl:740
+#: lib/choose_repository.tcl:692 lib/choose_repository.tcl:906
+#: lib/choose_repository.tcl:918
 msgid "The 'master' branch has not been initialized."
 msgstr ""
 
-#: lib/choose_repository.tcl:527
+#: lib/choose_repository.tcl:705
 msgid "Hardlinks are unavailable.  Falling back to copying."
 msgstr ""
 
-#: lib/choose_repository.tcl:539
+#: lib/choose_repository.tcl:717
 #, tcl-format
 msgid "Cloning from %s"
 msgstr ""
 
-#: lib/choose_repository.tcl:570
+#: lib/choose_repository.tcl:748
 msgid "Copying objects"
 msgstr ""
 
-#: lib/choose_repository.tcl:571
+#: lib/choose_repository.tcl:749
 msgid "KiB"
 msgstr ""
 
-#: lib/choose_repository.tcl:595
+#: lib/choose_repository.tcl:773
 #, tcl-format
 msgid "Unable to copy object: %s"
 msgstr ""
 
-#: lib/choose_repository.tcl:605
+#: lib/choose_repository.tcl:783
 msgid "Linking objects"
 msgstr ""
 
-#: lib/choose_repository.tcl:606
+#: lib/choose_repository.tcl:784
 msgid "objects"
 msgstr ""
 
-#: lib/choose_repository.tcl:614
+#: lib/choose_repository.tcl:792
 #, tcl-format
 msgid "Unable to hardlink object: %s"
 msgstr ""
 
-#: lib/choose_repository.tcl:669
+#: lib/choose_repository.tcl:847
 msgid "Cannot fetch branches and objects.  See console output for details."
 msgstr ""
 
-#: lib/choose_repository.tcl:680
+#: lib/choose_repository.tcl:858
 msgid "Cannot fetch tags.  See console output for details."
 msgstr ""
 
-#: lib/choose_repository.tcl:704
+#: lib/choose_repository.tcl:882
 msgid "Cannot determine HEAD.  See console output for details."
 msgstr ""
 
-#: lib/choose_repository.tcl:713
+#: lib/choose_repository.tcl:891
 #, tcl-format
 msgid "Unable to cleanup %s"
 msgstr ""
 
-#: lib/choose_repository.tcl:719
+#: lib/choose_repository.tcl:897
 msgid "Clone failed."
 msgstr ""
 
-#: lib/choose_repository.tcl:726
+#: lib/choose_repository.tcl:904
 msgid "No default branch obtained."
 msgstr ""
 
-#: lib/choose_repository.tcl:737
+#: lib/choose_repository.tcl:915
 #, tcl-format
 msgid "Cannot resolve %s as a commit."
 msgstr ""
 
-#: lib/choose_repository.tcl:749
+#: lib/choose_repository.tcl:927
 msgid "Creating working directory"
 msgstr ""
 
-#: lib/choose_repository.tcl:750 lib/index.tcl:15 lib/index.tcl:80
-#: lib/index.tcl:149
+#: lib/choose_repository.tcl:928 lib/index.tcl:65 lib/index.tcl:127
+#: lib/index.tcl:193
 msgid "files"
 msgstr ""
 
-#: lib/choose_repository.tcl:779
+#: lib/choose_repository.tcl:957
 msgid "Initial file checkout failed."
 msgstr ""
 
-#: lib/choose_repository.tcl:795
+#: lib/choose_repository.tcl:973
 msgid "Open"
 msgstr ""
 
-#: lib/choose_repository.tcl:805
+#: lib/choose_repository.tcl:983
 msgid "Repository:"
 msgstr ""
 
-#: lib/choose_repository.tcl:854
+#: lib/choose_repository.tcl:1033
 #, tcl-format
 msgid "Failed to open repository %s:"
 msgstr ""
@@ -1161,7 +1177,7 @@ msgid ""
 "\n"
 "A good commit message has the following format:\n"
 "\n"
-"- First line: Describe in one sentance what you did.\n"
+"- First line: Describe in one sentence what you did.\n"
 "- Second line: Blank\n"
 "- Remaining lines: Describe why this change is good.\n"
 msgstr ""
@@ -1330,31 +1346,53 @@ msgstr ""
 msgid "You must correct the above errors before committing."
 msgstr ""
 
-#: lib/index.tcl:241
+#: lib/index.tcl:6
+msgid "Unable to unlock the index."
+msgstr ""
+
+#: lib/index.tcl:15
+msgid "Index Error"
+msgstr ""
+
+#: lib/index.tcl:21
+msgid ""
+"Updating the Git index failed.  A rescan will be automatically started to "
+"resynchronize git-gui."
+msgstr ""
+
+#: lib/index.tcl:27
+msgid "Continue"
+msgstr ""
+
+#: lib/index.tcl:31
+msgid "Unlock Index"
+msgstr ""
+
+#: lib/index.tcl:282
 #, tcl-format
 msgid "Unstaging %s from commit"
 msgstr ""
 
-#: lib/index.tcl:285
+#: lib/index.tcl:326
 #, tcl-format
 msgid "Adding %s"
 msgstr ""
 
-#: lib/index.tcl:340
+#: lib/index.tcl:381
 #, tcl-format
 msgid "Revert changes in file %s?"
 msgstr ""
 
-#: lib/index.tcl:342
+#: lib/index.tcl:383
 #, tcl-format
 msgid "Revert changes in these %i files?"
 msgstr ""
 
-#: lib/index.tcl:348
+#: lib/index.tcl:389
 msgid "Any unstaged changes will be permanently lost by the revert."
 msgstr ""
 
-#: lib/index.tcl:351
+#: lib/index.tcl:392
 msgid "Do Nothing"
 msgstr ""
 
@@ -1539,18 +1577,6 @@ msgstr ""
 msgid "Failed to completely save options:"
 msgstr ""
 
-#: lib/remote.tcl:165
-msgid "Prune from"
-msgstr ""
-
-#: lib/remote.tcl:170
-msgid "Fetch from"
-msgstr ""
-
-#: lib/remote.tcl:213
-msgid "Push to"
-msgstr ""
-
 #: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
 msgid "Delete Remote Branch"
 msgstr ""
@@ -1627,11 +1653,23 @@ msgstr ""
 msgid "Scanning %s..."
 msgstr ""
 
-#: lib/shortcut.tcl:26 lib/shortcut.tcl:74
-msgid "Cannot write script:"
+#: lib/remote.tcl:165
+msgid "Prune from"
+msgstr ""
+
+#: lib/remote.tcl:170
+msgid "Fetch from"
+msgstr ""
+
+#: lib/remote.tcl:213
+msgid "Push to"
+msgstr ""
+
+#: lib/shortcut.tcl:20 lib/shortcut.tcl:61
+msgid "Cannot write shortcut:"
 msgstr ""
 
-#: lib/shortcut.tcl:149
+#: lib/shortcut.tcl:136
 msgid "Cannot write icon:"
 msgstr ""
 
-- 
1.5.3.4.206.g58ba4


--Boundary-00=_wc/RHuC8xtq1LcX
Content-Type: application/x-tgz;
  name="git-gui_i18n.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="git-gui_i18n.tar.gz"

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
utKVrnSlK135M5T/Axh3XqoAyAAA

--Boundary-00=_wc/RHuC8xtq1LcX--
