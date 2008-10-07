From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [Gitk PATCH 4/6] gitk: Add accelerator hints
Date: Tue,  7 Oct 2008 23:56:47 +0200
Message-ID: <1223416609-18864-5-git-send-email-robin.rosenberg@dewire.com>
References: <1223416609-18864-1-git-send-email-robin.rosenberg@dewire.com>
 <1223416609-18864-2-git-send-email-robin.rosenberg@dewire.com>
 <1223416609-18864-3-git-send-email-robin.rosenberg@dewire.com>
 <1223416609-18864-4-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: speace@spearce.org
X-From: git-owner@vger.kernel.org Tue Oct 07 23:59:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnKaV-00033q-P0
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 23:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755483AbYJGV6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 17:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755042AbYJGV6P
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 17:58:15 -0400
Received: from av9-1-sn3.vrr.skanova.net ([81.228.9.185]:40085 "EHLO
	av9-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815AbYJGV6I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 17:58:08 -0400
Received: by av9-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 2EACE383FD; Tue,  7 Oct 2008 23:58:07 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av9-1-sn3.vrr.skanova.net (Postfix) with ESMTP
	id DAB7D3800F; Tue,  7 Oct 2008 23:58:06 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id A81E037E43;
	Tue,  7 Oct 2008 23:58:06 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2.308.gef4a
In-Reply-To: <1223416609-18864-4-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97749>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 gitk |   66 +++++++++++++++++++++++++++++++++---------------------------------
 1 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/gitk b/gitk
index 6298b0a..79de9a6 100755
--- a/gitk
+++ b/gitk
@@ -1795,31 +1795,31 @@ proc makewindow {} {
     global have_tk85
 
     menu .bar
-    mcw .bar add cascade -label [mc "File"] -menu .bar.file
+    mcw .bar add cascade -label [mc "&File"] -menu .bar.file
     menu .bar.file
-    mcw .bar.file add command -label [mc "Update"] -command updatecommits
-    mcw .bar.file add command -label [mc "Reload"] -command reloadcommits
-    mcw .bar.file add command -label [mc "Reread references"] -command rereadrefs
-    mcw .bar.file add command -label [mc "List references"] -command showrefs
-    mcw .bar.file add command -label [mc "Quit"] -command doquit
+    mcw .bar.file add command -label [mc "&Update"] -command updatecommits
+    mcw .bar.file add command -label [mc "&Reload"] -command reloadcommits
+    mcw .bar.file add command -label [mc "R&eread references"] -command rereadrefs
+    mcw .bar.file add command -label [mc "&List references"] -command showrefs
+    mcw .bar.file add command -label [mc "&Quit"] -command doquit
     menu .bar.edit
-    mcw .bar add cascade -label [mc "Edit"] -menu .bar.edit
-    mcw .bar.edit add command -label [mc "Preferences"] -command doprefs
+    mcw .bar add cascade -label [mc "&Edit"] -menu .bar.edit
+    mcw .bar.edit add command -label [mc "&Preferences"] -command doprefs
 
     menu .bar.view
-    mcw .bar add cascade -label [mc "View"] -menu .bar.view
-    mcw .bar.view add command -label [mc "New view..."] -command {newview 0}
-    mcw .bar.view add command -label [mc "Edit view..."] -command editview \
+    mcw .bar add cascade -label [mc "&View"] -menu .bar.view
+    mcw .bar.view add command -label [mc "&New view..."] -command {newview 0}
+    mcw .bar.view add command -label [mc "&Edit view..."] -command editview \
 	-state disabled
-    mcw .bar.view add command -label [mc "Delete view"] -command delview -state disabled
+    mcw .bar.view add command -label [mc "&Delete view"] -command delview -state disabled
     mcw .bar.view add separator
-    mcw .bar.view add radiobutton -label [mc "All files"] -command {showview 0} \
+    mcw .bar.view add radiobutton -label [mc "&All files"] -command {showview 0} \
 	-variable selectedview -value 0
 
     menu .bar.help
-    mcw .bar add cascade -label [mc "Help"] -menu .bar.help
-    mcw .bar.help add command -label [mc "About gitk"] -command about
-    mcw .bar.help add command -label [mc "Key bindings"] -command keys
+    mcw .bar add cascade -label [mc "&Help"] -menu .bar.help
+    mcw .bar.help add command -label [mc "&About gitk"] -command about
+    mcw .bar.help add command -label [mc "&Key bindings"] -command keys
     .bar.help configure
     . configure -menu .bar
 
@@ -2201,47 +2201,47 @@ proc makewindow {} {
 
     set rowctxmenu .rowctxmenu
     menu $rowctxmenu -tearoff 0
-    mcw $rowctxmenu add command -label [mc "Diff this -> selected"] \
+    mcw $rowctxmenu add command -label [mc "Diff &this -> selected"] \
 	-command {diffvssel 0}
-    mcw $rowctxmenu add command -label [mc "Diff selected -> this"] \
+    mcw $rowctxmenu add command -label [mc "Diff &selected -> this"] \
 	-command {diffvssel 1}
-    mcw $rowctxmenu add command -label [mc "Make patch"] -command mkpatch
-    mcw $rowctxmenu add command -label [mc "Create tag"] -command mktag
-    mcw $rowctxmenu add command -label [mc "Write commit to file"] -command writecommit
-    mcw $rowctxmenu add command -label [mc "Create new branch"] -command mkbranch
-    mcw $rowctxmenu add command -label [mc "Cherry-pick this commit"] \
+    mcw $rowctxmenu add command -label [mc "&Make patch"] -command mkpatch
+    mcw $rowctxmenu add command -label [mc "Create ta&g"] -command mktag
+    mcw $rowctxmenu add command -label [mc "&Write commit to file"] -command writecommit
+    mcw $rowctxmenu add command -label [mc "Create new &branch"] -command mkbranch
+    mcw $rowctxmenu add command -label [mc "C&herry-pick this commit"] \
 	-command cherrypick
-    mcw $rowctxmenu add command -label [mc "Reset HEAD branch to here"] \
+    mcw $rowctxmenu add command -label [mc "&Reset HEAD branch to here"] \
 	-command resethead
 
     set fakerowmenu .fakerowmenu
     menu $fakerowmenu -tearoff 0
-    mcw $fakerowmenu add command -label [mc "Diff this -> selected"] \
+    mcw $fakerowmenu add command -label [mc "Diff &this -> selected"] \
 	-command {diffvssel 0}
-    mcw $fakerowmenu add command -label [mc "Diff selected -> this"] \
+    mcw $fakerowmenu add command -label [mc "Diff &selected -> this"] \
 	-command {diffvssel 1}
-    mcw $fakerowmenu add command -label [mc "Make patch"] -command mkpatch
+    mcw $fakerowmenu add command -label [mc "&Make patch"] -command mkpatch
 #   mcw $fakerowmenu add command -label [mc "Commit"] -command {mkcommit 0}
 #   mcw $fakerowmenu add command -label [mc "Commit all"] -command {mkcommit 1}
 #   mcw $fakerowmenu add command -label [mc "Revert local changes"] -command revertlocal
 
     set headctxmenu .headctxmenu
     menu $headctxmenu -tearoff 0
-    mcw $headctxmenu add command -label [mc "Check out this branch"] \
+    mcw $headctxmenu add command -label [mc "Check &out this branch"] \
 	-command cobranch
-    mcw $headctxmenu add command -label [mc "Remove this branch"] \
+    mcw $headctxmenu add command -label [mc "Re&move this branch"] \
 	-command rmbranch
 
     global flist_menu
     set flist_menu .flistctxmenu
     menu $flist_menu -tearoff 0
-    mcw $flist_menu add command -label [mc "Highlight this too"] \
+    mcw $flist_menu add command -label [mc "Highlight this &too"] \
 	-command {flist_hl 0}
-    mcw $flist_menu add command -label [mc "Highlight this only"] \
+    mcw $flist_menu add command -label [mc "Highlight this &only"] \
 	-command {flist_hl 1}
-    mcw $flist_menu add command -label [mc "External diff"] \
+    mcw $flist_menu add command -label [mc "E&xternal diff"] \
         -command {external_diff}
-    mcw $flist_menu add command -label [mc "Blame parent commit"] \
+    mcw $flist_menu add command -label [mc "&Blame parent commit"] \
         -command {external_blame 1}
 }
 
-- 
1.6.0.2.308.gef4a
