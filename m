From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] gitk: fix "Key bindings" message
Date: Tue, 8 Jan 2008 14:37:46 +0100
Message-ID: <200801081437.46398.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Jan 08 15:10:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCFAL-00066C-Jo
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 15:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438AbYAHOK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 09:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754688AbYAHOK0
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 09:10:26 -0500
Received: from slim-3a.inet.it ([213.92.5.124]:58308 "EHLO slim-3a.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753863AbYAHOKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 09:10:25 -0500
X-Greylist: delayed 2400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2008 09:10:24 EST
Received: from host49-57-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.57.49]) by slim-3a.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.57.49+MWWcvQ0Sp5a8; Tue, 08 Jan 2008 14:30:21 +0100
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69880>

Fix string substitution. Now the "Key bindings" message under the
"Help" menu is ready for translation.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 gitk |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/gitk b/gitk
index 4a923af..871a006 100755
--- a/gitk
+++ b/gitk
@@ -1309,7 +1309,7 @@ proc keys {} {
     message $w.m -text [mc "
 Gitk key bindings:
 
-<$M1T-Q>		Quit
+<%s-Q>		Quit
 <Home>		Move to first commit
 <End>		Move to last commit
 <Up>, p, i	Move up one commit
@@ -1318,12 +1318,12 @@ Gitk key bindings:
 <Right>, x, l	Go forward in history list
 <PageUp>	Move up one page in commit list
 <PageDown>	Move down one page in commit list
-<$M1T-Home>	Scroll to top of commit list
-<$M1T-End>	Scroll to bottom of commit list
-<$M1T-Up>	Scroll commit list up one line
-<$M1T-Down>	Scroll commit list down one line
-<$M1T-PageUp>	Scroll commit list up one page
-<$M1T-PageDown>	Scroll commit list down one page
+<%s-Home>	Scroll to top of commit list
+<%s-End>	Scroll to bottom of commit list
+<%s-Up>	Scroll commit list up one line
+<%s-Down>	Scroll commit list down one line
+<%s-PageUp>	Scroll commit list up one page
+<%s-PageDown>	Scroll commit list down one page
 <Shift-Up>	Find backwards (upwards, later commits)
 <Shift-Down>	Find forwards (downwards, earlier commits)
 <Delete>, b	Scroll diff view up one page
@@ -1331,20 +1331,20 @@ Gitk key bindings:
 <Space>		Scroll diff view down one page
 u		Scroll diff view up 18 lines
 d		Scroll diff view down 18 lines
-<$M1T-F>		Find
-<$M1T-G>		Move to next find hit
+<%s-F>		Find
+<%s-G>		Move to next find hit
 <Return>	Move to next find hit
 /		Move to next find hit, or redo find
 ?		Move to previous find hit
 f		Scroll diff view to next file
-<$M1T-S>		Search for next hit in diff view
-<$M1T-R>		Search for previous hit in diff view
-<$M1T-KP+>	Increase font size
-<$M1T-plus>	Increase font size
-<$M1T-KP->	Decrease font size
-<$M1T-minus>	Decrease font size
+<%s-S>		Search for next hit in diff view
+<%s-R>		Search for previous hit in diff view
+<%s-KP+>	Increase font size
+<%s-plus>	Increase font size
+<%s-KP->	Decrease font size
+<%s-minus>	Decrease font size
 <F5>		Update
-"] \
+" $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T ] \
 	    -justify left -bg white -border 2 -relief groove
     pack $w.m -side top -fill both -padx 2 -pady 2
     button $w.ok -text [mc "Close"] -command "destroy $w" -default active
-- 
1.5.3.5
