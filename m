From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [GITK PATCH v2] Add menu accelerators
Date: Mon, 20 Oct 2008 00:00:32 +0200
Message-ID: <200810200000.33035.robin.rosenberg@dewire.com>
References: <1223532590-8706-1-git-send-email-robin.rosenberg@dewire.com> <18681.53866.855255.688290@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 11:07:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrgM0-00040e-6D
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 00:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbYJSWAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 18:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbYJSWAl
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 18:00:41 -0400
Received: from av11-1-sn2.hy.skanova.net ([81.228.8.183]:44408 "EHLO
	av11-1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbYJSWAk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 18:00:40 -0400
Received: by av11-1-sn2.hy.skanova.net (Postfix, from userid 502)
	id C506237FAE; Mon, 20 Oct 2008 00:00:37 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av11-1-sn2.hy.skanova.net (Postfix) with ESMTP
	id AB88F37F6C; Mon, 20 Oct 2008 00:00:37 +0200 (CEST)
Received: from sleipner.dewire.com (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 5E16337E45;
	Mon, 20 Oct 2008 00:00:37 +0200 (CEST)
Received: from dewire.com (unknown [10.9.0.1])
	by sleipner.dewire.com (Postfix) with ESMTP id B5F7DB07;
	Mon, 20 Oct 2008 00:00:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 151BB147EACD;
	Mon, 20 Oct 2008 00:00:37 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2wETXZv6-xWZ; Mon, 20 Oct 2008 00:00:36 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 4D66A8006B1;
	Mon, 20 Oct 2008 00:00:36 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <18681.53866.855255.688290@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98630>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 gitk |   80 +++++++++++++++++++++++++++++++++---------------------------------
 1 files changed, 40 insertions(+), 40 deletions(-)

This one is slightly better than the first one.  Works with gitk id...id too.

-- robin

diff --git a/gitk b/gitk
index 3678de1..df039b9 100755
--- a/gitk
+++ b/gitk
@@ -1817,26 +1817,26 @@ proc makewindow {} {
     # The "mc" arguments here are purely so that xgettext
     # sees the following string as needing to be translated
     makemenu .bar {
-	{mc "File" cascade {
-	    {mc "Update" command updatecommits -accelerator F5}
-	    {mc "Reload" command reloadcommits}
-	    {mc "Reread references" command rereadrefs}
-	    {mc "List references" command showrefs}
-	    {mc "Quit" command doquit}
+	{mc "&File" cascade {
+	    {mc "&Update" command updatecommits -accelerator F5}
+	    {mc "&Reload" command reloadcommits}
+	    {mc "R&eread references" command rereadrefs}
+	    {mc "&List references" command showrefs}
+	    {mc "&Quit" command doquit}
 	}}
-	{mc "Edit" cascade {
-	    {mc "Preferences" command doprefs}
+	{mc "&Edit" cascade {
+	    {mc "&Preferences" command doprefs}
 	}}
-	{mc "View" cascade {
-	    {mc "New view..." command {newview 0}}
-	    {mc "Edit view..." command editview -state disabled}
-	    {mc "Delete view" command delview -state disabled}
+	{mc "&View" cascade {
+	    {mc "&New view..." command {newview 0}}
+	    {mc "&Edit view..." command editview -state disabled}
+	    {mc "&Delete view" command delview -state disabled}
 	    {xx "" separator}
-	    {mc "All files" radiobutton {selectedview 0} -command {showview 0}}
+	    {mc "&All files" radiobutton {selectedview 0} -command {showview 0}}
 	}}
-	{mc "Help" cascade {
-	    {mc "About gitk" command about}
-	    {mc "Key bindings" command keys}
+	{mc "&Help" cascade {
+	    {mc "&About gitk" command about}
+	    {mc "&Key bindings" command keys}
 	}}
     }
     . configure -menu .bar
@@ -2220,39 +2220,39 @@ proc makewindow {} {
 
     set rowctxmenu .rowctxmenu
     makemenu $rowctxmenu {
-	{mc "Diff this -> selected" command {diffvssel 0}}
-	{mc "Diff selected -> this" command {diffvssel 1}}
-	{mc "Make patch" command mkpatch}
-	{mc "Create tag" command mktag}
-	{mc "Write commit to file" command writecommit}
-	{mc "Create new branch" command mkbranch}
-	{mc "Cherry-pick this commit" command cherrypick}
-	{mc "Reset HEAD branch to here" command resethead}
+	{mc "Diff &this -> selected" command {diffvssel 0}}
+	{mc "Diff &selected -> this" command {diffvssel 1}}
+	{mc "Make &patch" command mkpatch}
+	{mc "Create ta&g" command mktag}
+	{mc "&Write commit to file" command writecommit}
+	{mc "Create new &branch" command mkbranch}
+	{mc "&Cherry-pick this commit" command cherrypick}
+	{mc "&Reset HEAD branch to here" command resethead}
     }
     $rowctxmenu configure -tearoff 0
 
     set fakerowmenu .fakerowmenu
     makemenu $fakerowmenu {
-	{mc "Diff this -> selected" command {diffvssel 0}}
-	{mc "Diff selected -> this" command {diffvssel 1}}
-	{mc "Make patch" command mkpatch}
+	{mc "Diff &this -> selected" command {diffvssel 0}}
+	{mc "Diff &selected -> this" command {diffvssel 1}}
+	{mc "Make &patch" command mkpatch}
     }
     $fakerowmenu configure -tearoff 0
 
     set headctxmenu .headctxmenu
     makemenu $headctxmenu {
-	{mc "Check out this branch" command cobranch}
-	{mc "Remove this branch" command rmbranch}
+	{mc "&Check out this branch" command cobranch}
+	{mc "&Remove this branch" command rmbranch}
     }
     $headctxmenu configure -tearoff 0
 
     global flist_menu
     set flist_menu .flistctxmenu
     makemenu $flist_menu {
-	{mc "Highlight this too" command {flist_hl 0}}
-	{mc "Highlight this only" command {flist_hl 1}}
-	{mc "External diff" command {external_diff}}
-	{mc "Blame parent commit" command {external_blame 1}}
+	{mc "Highlight this &too" command {flist_hl 0}}
+	{mc "Highlight this &only" command {flist_hl 1}}
+	{mc "E&xternal diff" command {external_diff}}
+	{mc "&Blame parent commit" command {external_blame 1}}
     }
     $flist_menu configure -tearoff 0
 }
@@ -3414,8 +3414,8 @@ proc showview {n} {
 
     set curview $n
     set selectedview $n
-    .bar.view entryconf [mca "Edit view..."] -state [expr {$n == 0? "disabled": "normal"}]
-    .bar.view entryconf [mca "Delete view"] -state [expr {$n == 0? "disabled": "normal"}]
+    .bar.view entryconf [mca "&Edit view..."] -state [expr {$n == 0? "disabled": "normal"}]
+    .bar.view entryconf [mca "&Delete view"] -state [expr {$n == 0? "disabled": "normal"}]
 
     run refill_reflist
     if {![info exists viewcomplete($n)]} {
@@ -7361,9 +7361,9 @@ proc rowmenu {x y id} {
     } else {
 	set menu $fakerowmenu
     }
-    $menu entryconfigure [mca "Diff this -> selected"] -state $state
-    $menu entryconfigure [mca "Diff selected -> this"] -state $state
-    $menu entryconfigure [mca "Make patch"] -state $state
+    $menu entryconfigure [mca "Diff &this -> selected"] -state $state
+    $menu entryconfigure [mca "Diff &selected -> this"] -state $state
+    $menu entryconfigure [mca "Make &patch"] -state $state
     tk_popup $menu $x $y
 }
 
@@ -10184,8 +10184,8 @@ if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {
     set viewperm(1) 0
     set vdatemode(1) 0
     addviewmenu 1
-    .bar.view entryconf [mca "Edit view..."] -state normal
-    .bar.view entryconf [mca "Delete view"] -state normal
+    .bar.view entryconf [mca "&Edit view..."] -state normal
+    .bar.view entryconf [mca "&Delete view"] -state normal
 }
 
 if {[info exists permviews]} {
-- 
1.6.0.2.308.gef4a
