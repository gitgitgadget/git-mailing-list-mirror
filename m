From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH - v3] gitk: fix "Key bindings" message
Date: Tue, 15 Jan 2008 23:31:49 +0100
Message-ID: <200801152331.49990.barra_cuda@katamail.com>
References: <200801081437.46398.barra_cuda@katamail.com> <200801091916.52680.barra_cuda@katamail.com> <18316.40891.875291.618507@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Jan 15 23:24:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEuD8-0001wj-JQ
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 23:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757419AbYAOWYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 17:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757208AbYAOWYQ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 17:24:16 -0500
Received: from slim-3c.inet.it ([213.92.5.125]:35570 "EHLO slim-3c.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755906AbYAOWYO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 17:24:14 -0500
Received: from host27-56-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.56.27]) by slim-3c.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.56.27+T0ldpl0uTUuw; Tue, 15 Jan 2008 23:24:07 +0100
User-Agent: KMail/1.9.7
In-Reply-To: <18316.40891.875291.618507@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70568>

The "Key bindings" message under the "Help" menu was too long
and could not be parsed by the translation engine.

Fix both issues by translating one line at a time.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
On Tuesday 15 January 2008, Paul Mackerras wrote:
> I am wondering whether the help text
> needs to be busted up into individual lines for processing by [mc].

Here it is. With this patch the strings do show up in po/gitk.pot.

 gitk |   78 +++++++++++++++++++++++++++++++++---------------------------------
 1 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/gitk b/gitk
index 5560e4d..7555968 100755
--- a/gitk
+++ b/gitk
@@ -1307,45 +1307,45 @@ proc keys {} {
     }
     toplevel $w
     wm title $w [mc "Gitk key bindings"]
-    message $w.m -text [mc "
-Gitk key bindings:
-
-<$M1T-Q>		Quit
-<Home>		Move to first commit
-<End>		Move to last commit
-<Up>, p, i	Move up one commit
-<Down>, n, k	Move down one commit
-<Left>, z, j	Go back in history list
-<Right>, x, l	Go forward in history list
-<PageUp>	Move up one page in commit list
-<PageDown>	Move down one page in commit list
-<$M1T-Home>	Scroll to top of commit list
-<$M1T-End>	Scroll to bottom of commit list
-<$M1T-Up>	Scroll commit list up one line
-<$M1T-Down>	Scroll commit list down one line
-<$M1T-PageUp>	Scroll commit list up one page
-<$M1T-PageDown>	Scroll commit list down one page
-<Shift-Up>	Find backwards (upwards, later commits)
-<Shift-Down>	Find forwards (downwards, earlier commits)
-<Delete>, b	Scroll diff view up one page
-<Backspace>	Scroll diff view up one page
-<Space>		Scroll diff view down one page
-u		Scroll diff view up 18 lines
-d		Scroll diff view down 18 lines
-<$M1T-F>		Find
-<$M1T-G>		Move to next find hit
-<Return>	Move to next find hit
-/		Move to next find hit, or redo find
-?		Move to previous find hit
-f		Scroll diff view to next file
-<$M1T-S>		Search for next hit in diff view
-<$M1T-R>		Search for previous hit in diff view
-<$M1T-KP+>	Increase font size
-<$M1T-plus>	Increase font size
-<$M1T-KP->	Decrease font size
-<$M1T-minus>	Decrease font size
-<F5>		Update
-"] \
+    message $w.m -text "
+[mc "Gitk key bindings:"]
+
+[mc "<%s-Q>		Quit" $M1T]
+[mc "<Home>		Move to first commit"]
+[mc "<End>		Move to last commit"]
+[mc "<Up>, p, i	Move up one commit"]
+[mc "<Down>, n, k	Move down one commit"]
+[mc "<Left>, z, j	Go back in history list"]
+[mc "<Right>, x, l	Go forward in history list"]
+[mc "<PageUp>	Move up one page in commit list"]
+[mc "<PageDown>	Move down one page in commit list"]
+[mc "<%s-Home>	Scroll to top of commit list" $M1T]
+[mc "<%s-End>	Scroll to bottom of commit list" $M1T]
+[mc "<%s-Up>	Scroll commit list up one line" $M1T]
+[mc "<%s-Down>	Scroll commit list down one line" $M1T]
+[mc "<%s-PageUp>	Scroll commit list up one page" $M1T]
+[mc "<%s-PageDown>	Scroll commit list down one page" $M1T]
+[mc "<Shift-Up>	Find backwards (upwards, later commits)"]
+[mc "<Shift-Down>	Find forwards (downwards, earlier commits)"]
+[mc "<Delete>, b	Scroll diff view up one page"]
+[mc "<Backspace>	Scroll diff view up one page"]
+[mc "<Space>		Scroll diff view down one page"]
+[mc "u		Scroll diff view up 18 lines"]
+[mc "d		Scroll diff view down 18 lines"]
+[mc "<%s-F>		Find" $M1T]
+[mc "<%s-G>		Move to next find hit" $M1T]
+[mc "<Return>	Move to next find hit"]
+[mc "/		Move to next find hit, or redo find"]
+[mc "?		Move to previous find hit"]
+[mc "f		Scroll diff view to next file"]
+[mc "<%s-S>		Search for next hit in diff view" $M1T]
+[mc "<%s-R>		Search for previous hit in diff view" $M1T]
+[mc "<%s-KP+>	Increase font size" $M1T]
+[mc "<%s-plus>	Increase font size" $M1T]
+[mc "<%s-KP->	Decrease font size" $M1T]
+[mc "<%s-minus>	Decrease font size" $M1T]
+[mc "<F5>		Update"]
+" \
 	    -justify left -bg white -border 2 -relief groove
     pack $w.m -side top -fill both -padx 2 -pady 2
     button $w.ok -text [mc "Close"] -command "destroy $w" -default active
-- 
1.5.3.5
