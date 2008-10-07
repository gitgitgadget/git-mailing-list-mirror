From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [Gitk PATCH 2/6] gitk: Change menus to use accelerated design
Date: Tue,  7 Oct 2008 23:56:45 +0200
Message-ID: <1223416609-18864-3-git-send-email-robin.rosenberg@dewire.com>
References: <1223416609-18864-1-git-send-email-robin.rosenberg@dewire.com>
 <1223416609-18864-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: speace@spearce.org
X-From: git-owner@vger.kernel.org Tue Oct 07 23:59:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnKaU-00033q-Vj
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 23:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681AbYJGV6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 17:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755042AbYJGV6M
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 17:58:12 -0400
Received: from av8-2-sn3.vrr.skanova.net ([81.228.9.184]:45985 "EHLO
	av8-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306AbYJGV6H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 17:58:07 -0400
Received: by av8-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 8059C37FC1; Tue,  7 Oct 2008 23:58:05 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av8-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 43D9A37ECC; Tue,  7 Oct 2008 23:58:05 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id 140B337E43;
	Tue,  7 Oct 2008 23:58:05 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2.308.gef4a
In-Reply-To: <1223416609-18864-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97748>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 gitk |   88 +++++++++++++++++++++++++++++++++---------------------------------
 1 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/gitk b/gitk
index 050019c..6298b0a 100755
--- a/gitk
+++ b/gitk
@@ -1795,31 +1795,31 @@ proc makewindow {} {
     global have_tk85
 
     menu .bar
-    .bar add cascade -label [mc "File"] -menu .bar.file
+    mcw .bar add cascade -label [mc "File"] -menu .bar.file
     menu .bar.file
-    .bar.file add command -label [mc "Update"] -command updatecommits
-    .bar.file add command -label [mc "Reload"] -command reloadcommits
-    .bar.file add command -label [mc "Reread references"] -command rereadrefs
-    .bar.file add command -label [mc "List references"] -command showrefs
-    .bar.file add command -label [mc "Quit"] -command doquit
+    mcw .bar.file add command -label [mc "Update"] -command updatecommits
+    mcw .bar.file add command -label [mc "Reload"] -command reloadcommits
+    mcw .bar.file add command -label [mc "Reread references"] -command rereadrefs
+    mcw .bar.file add command -label [mc "List references"] -command showrefs
+    mcw .bar.file add command -label [mc "Quit"] -command doquit
     menu .bar.edit
-    .bar add cascade -label [mc "Edit"] -menu .bar.edit
-    .bar.edit add command -label [mc "Preferences"] -command doprefs
+    mcw .bar add cascade -label [mc "Edit"] -menu .bar.edit
+    mcw .bar.edit add command -label [mc "Preferences"] -command doprefs
 
     menu .bar.view
-    .bar add cascade -label [mc "View"] -menu .bar.view
-    .bar.view add command -label [mc "New view..."] -command {newview 0}
-    .bar.view add command -label [mc "Edit view..."] -command editview \
+    mcw .bar add cascade -label [mc "View"] -menu .bar.view
+    mcw .bar.view add command -label [mc "New view..."] -command {newview 0}
+    mcw .bar.view add command -label [mc "Edit view..."] -command editview \
 	-state disabled
-    .bar.view add command -label [mc "Delete view"] -command delview -state disabled
-    .bar.view add separator
-    .bar.view add radiobutton -label [mc "All files"] -command {showview 0} \
+    mcw .bar.view add command -label [mc "Delete view"] -command delview -state disabled
+    mcw .bar.view add separator
+    mcw .bar.view add radiobutton -label [mc "All files"] -command {showview 0} \
 	-variable selectedview -value 0
 
     menu .bar.help
-    .bar add cascade -label [mc "Help"] -menu .bar.help
-    .bar.help add command -label [mc "About gitk"] -command about
-    .bar.help add command -label [mc "Key bindings"] -command keys
+    mcw .bar add cascade -label [mc "Help"] -menu .bar.help
+    mcw .bar.help add command -label [mc "About gitk"] -command about
+    mcw .bar.help add command -label [mc "Key bindings"] -command keys
     .bar.help configure
     . configure -menu .bar
 
@@ -2201,47 +2201,47 @@ proc makewindow {} {
 
     set rowctxmenu .rowctxmenu
     menu $rowctxmenu -tearoff 0
-    $rowctxmenu add command -label [mc "Diff this -> selected"] \
+    mcw $rowctxmenu add command -label [mc "Diff this -> selected"] \
 	-command {diffvssel 0}
-    $rowctxmenu add command -label [mc "Diff selected -> this"] \
+    mcw $rowctxmenu add command -label [mc "Diff selected -> this"] \
 	-command {diffvssel 1}
-    $rowctxmenu add command -label [mc "Make patch"] -command mkpatch
-    $rowctxmenu add command -label [mc "Create tag"] -command mktag
-    $rowctxmenu add command -label [mc "Write commit to file"] -command writecommit
-    $rowctxmenu add command -label [mc "Create new branch"] -command mkbranch
-    $rowctxmenu add command -label [mc "Cherry-pick this commit"] \
+    mcw $rowctxmenu add command -label [mc "Make patch"] -command mkpatch
+    mcw $rowctxmenu add command -label [mc "Create tag"] -command mktag
+    mcw $rowctxmenu add command -label [mc "Write commit to file"] -command writecommit
+    mcw $rowctxmenu add command -label [mc "Create new branch"] -command mkbranch
+    mcw $rowctxmenu add command -label [mc "Cherry-pick this commit"] \
 	-command cherrypick
-    $rowctxmenu add command -label [mc "Reset HEAD branch to here"] \
+    mcw $rowctxmenu add command -label [mc "Reset HEAD branch to here"] \
 	-command resethead
 
     set fakerowmenu .fakerowmenu
     menu $fakerowmenu -tearoff 0
-    $fakerowmenu add command -label [mc "Diff this -> selected"] \
+    mcw $fakerowmenu add command -label [mc "Diff this -> selected"] \
 	-command {diffvssel 0}
-    $fakerowmenu add command -label [mc "Diff selected -> this"] \
+    mcw $fakerowmenu add command -label [mc "Diff selected -> this"] \
 	-command {diffvssel 1}
-    $fakerowmenu add command -label [mc "Make patch"] -command mkpatch
-#    $fakerowmenu add command -label [mc "Commit"] -command {mkcommit 0}
-#    $fakerowmenu add command -label [mc "Commit all"] -command {mkcommit 1}
-#    $fakerowmenu add command -label [mc "Revert local changes"] -command revertlocal
+    mcw $fakerowmenu add command -label [mc "Make patch"] -command mkpatch
+#   mcw $fakerowmenu add command -label [mc "Commit"] -command {mkcommit 0}
+#   mcw $fakerowmenu add command -label [mc "Commit all"] -command {mkcommit 1}
+#   mcw $fakerowmenu add command -label [mc "Revert local changes"] -command revertlocal
 
     set headctxmenu .headctxmenu
     menu $headctxmenu -tearoff 0
-    $headctxmenu add command -label [mc "Check out this branch"] \
+    mcw $headctxmenu add command -label [mc "Check out this branch"] \
 	-command cobranch
-    $headctxmenu add command -label [mc "Remove this branch"] \
+    mcw $headctxmenu add command -label [mc "Remove this branch"] \
 	-command rmbranch
 
     global flist_menu
     set flist_menu .flistctxmenu
     menu $flist_menu -tearoff 0
-    $flist_menu add command -label [mc "Highlight this too"] \
+    mcw $flist_menu add command -label [mc "Highlight this too"] \
 	-command {flist_hl 0}
-    $flist_menu add command -label [mc "Highlight this only"] \
+    mcw $flist_menu add command -label [mc "Highlight this only"] \
 	-command {flist_hl 1}
-    $flist_menu add command -label [mc "External diff"] \
+    mcw $flist_menu add command -label [mc "External diff"] \
         -command {external_diff}
-    $flist_menu add command -label [mc "Blame parent commit"] \
+    mcw $flist_menu add command -label [mc "Blame parent commit"] \
         -command {external_blame 1}
 }
 
@@ -3401,8 +3401,8 @@ proc showview {n} {
 
     set curview $n
     set selectedview $n
-    .bar.view entryconf [mc "Edit view..."] -state [expr {$n == 0? "disabled": "normal"}]
-    .bar.view entryconf [mc "Delete view"] -state [expr {$n == 0? "disabled": "normal"}]
+    .bar.view entryconf [mca "&Edit view..."] -state [expr {$n == 0? "disabled": "normal"}]
+    .bar.view entryconf [mca "&Delete view"] -state [expr {$n == 0? "disabled": "normal"}]
 
     run refill_reflist
     if {![info exists viewcomplete($n)]} {
@@ -7315,9 +7315,9 @@ proc rowmenu {x y id} {
     } else {
 	set menu $fakerowmenu
     }
-    $menu entryconfigure [mc "Diff this -> selected"] -state $state
-    $menu entryconfigure [mc "Diff selected -> this"] -state $state
-    $menu entryconfigure [mc "Make patch"] -state $state
+    $menu entryconfigure [mca "Diff &this -> selected"] -state $state
+    $menu entryconfigure [mca "Diff &selected -> this"] -state $state
+    $menu entryconfigure [mca "&Make patch"] -state $state
     tk_popup $menu $x $y
 }
 
@@ -10046,8 +10046,8 @@ if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {
     set viewperm(1) 0
     set vdatemode(1) 0
     addviewmenu 1
-    .bar.view entryconf [mc "Edit view..."] -state normal
-    .bar.view entryconf [mc "Delete view"] -state normal
+    .bar.view entryconf [mca "&Edit view..."] -state normal
+    .bar.view entryconf [mca "&Delete view"] -state normal
 }
 
 if {[info exists permviews]} {
-- 
1.6.0.2.308.gef4a
