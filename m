From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [GITK PATCH] Add menu accelerators
Date: Sun, 19 Oct 2008 23:19:46 +0200
Message-ID: <200810192319.46974.robin.rosenberg@dewire.com>
References: <1223532590-8706-1-git-send-email-robin.rosenberg@dewire.com> <18681.53866.855255.688290@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 11:37:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Krfi1-0002Uc-IK
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 23:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbYJSVTz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Oct 2008 17:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbYJSVTz
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 17:19:55 -0400
Received: from av9-1-sn2.hy.skanova.net ([81.228.8.179]:59825 "EHLO
	av9-1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbYJSVTy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Oct 2008 17:19:54 -0400
Received: by av9-1-sn2.hy.skanova.net (Postfix, from userid 502)
	id 0AAAB37FB8; Sun, 19 Oct 2008 23:19:52 +0200 (CEST)
Received: from smtp4-2-sn2.hy.skanova.net (smtp4-2-sn2.hy.skanova.net [81.228.8.93])
	by av9-1-sn2.hy.skanova.net (Postfix) with ESMTP
	id E704437FB8; Sun, 19 Oct 2008 23:19:51 +0200 (CEST)
Received: from sleipner.dewire.com (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-2-sn2.hy.skanova.net (Postfix) with ESMTP id 993AA37E43;
	Sun, 19 Oct 2008 23:19:51 +0200 (CEST)
Received: from dewire.com (unknown [10.9.0.1])
	by sleipner.dewire.com (Postfix) with ESMTP id D35D3B07;
	Sun, 19 Oct 2008 23:19:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 15C35147EAC3;
	Sun, 19 Oct 2008 23:19:51 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8rlo5fRf3icW; Sun, 19 Oct 2008 23:19:50 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 485F2800250;
	Sun, 19 Oct 2008 23:19:50 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <18681.53866.855255.688290@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98635>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

l=F6rdagen den 18 oktober 2008 14.11.22 skrev Paul Mackerras:
> Have a look at what I just pushed out.  It adds infrastructure to let
> us use "&" in menu items to specify an alt+letter accelerator, but in
> a different way to your patches.  If you'd like to redo your patch to
> add "&" to the menu items, that would be good.

Looks fine. Seems to work too. Then we want to do the same thing
with buttons. Btw, is it only for me that the "popup menu key" does
not work for in gitk?

This patch does not include re-generated po's, nor the updated swedish =
translation.

-- robin

 gitk |   72 +++++++++++++++++++++++++++++++++-------------------------=
--------
 1 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/gitk b/gitk
index 3678de1..e65c0ce 100755
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
-	    {mc "All files" radiobutton {selectedview 0} -command {showview 0=
}}
+	    {mc "&All files" radiobutton {selectedview 0} -command {showview =
0}}
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
=20
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
=20
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
=20
     set headctxmenu .headctxmenu
     makemenu $headctxmenu {
-	{mc "Check out this branch" command cobranch}
-	{mc "Remove this branch" command rmbranch}
+	{mc "&Check out this branch" command cobranch}
+	{mc "&Remove this branch" command rmbranch}
     }
     $headctxmenu configure -tearoff 0
=20
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
=20
--=20
1.6.0.2.308.gef4a
