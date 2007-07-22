From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-gui-i18n: Fix translation of the context menu
Date: Sun, 22 Jul 2007 17:20:02 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707221719430.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 18:20:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICeAP-00018K-BB
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 18:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860AbXGVQUS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 12:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754844AbXGVQUR
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 12:20:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:33680 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754819AbXGVQUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 12:20:16 -0400
Received: (qmail invoked by alias); 22 Jul 2007 16:20:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 22 Jul 2007 18:20:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+oGAdvgBiogB9rrxYF68sdkmm7mUFjWFjJXOl8pO
	l00RsrrLNH3PjN
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53277>


There is some funny code generation going on to make the context menu,
and the messages for this have to be doubly quoted.

Noticed by Harri Ilari Tapio Liusvaara

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-gui.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 075a2b9..52170ee 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2457,9 +2457,9 @@ bind_button3 $ui_diff "
 	set cursorX %x
 	set cursorY %y
 	if {\$ui_index eq \$current_diff_side} {
-		$ctxm entryconf $ui_diff_applyhunk -label [mc {Unstage Hunk From Commit}]
+		$ctxm entryconf $ui_diff_applyhunk -label \"[mc "Unstage Hunk From Commit"]\"
 	} else {
-		$ctxm entryconf $ui_diff_applyhunk -label [mc {Stage Hunk For Commit}]
+		$ctxm entryconf $ui_diff_applyhunk -label \"[mc "Stage Hunk For Commit"]\"
 	}
 	tk_popup $ctxm %X %Y
 "
-- 
1.5.3.rc2.29.gc4640f
