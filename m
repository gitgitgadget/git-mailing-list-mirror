From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 2/5] gitk: Set the font for all spinbox widgets
Date: Mon, 28 Dec 2009 20:04:00 +0000
Message-ID: <1262030643-12952-2-git-send-email-mark@pogo.org.uk>
References: <1262030643-12952-1-git-send-email-mark@pogo.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 28 21:31:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPMFK-0006Za-0J
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 21:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbZL1UbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 15:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbZL1UbF
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 15:31:05 -0500
Received: from mailout.ijneb.com ([212.13.201.26]:58973 "EHLO wes.ijneb.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751363AbZL1UbE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 15:31:04 -0500
Received: from host86-131-13-173.range86-131.btcentralplus.com ([86.131.13.173] helo=vega)
	by wes.ijneb.com with esmtpa (Exim 4.69)
	(envelope-from <mark@pogo.org.uk>)
	id 1NPLp3-0002rR-9a; Mon, 28 Dec 2009 20:04:09 +0000
Received: from mark by vega with local (Exim 4.69)
	(envelope-from <mark@vega>)
	id 1NPLoy-0003NW-0z; Mon, 28 Dec 2009 20:04:04 +0000
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1262030643-12952-1-git-send-email-mark@pogo.org.uk>
X-SA-Exim-Connect-IP: 86.131.13.173
X-SA-Exim-Mail-From: mark@pogo.org.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135759>

Use the X resources to set the font, removing the need to set the font
for specific widgets.

Signed-off-by: Mark Hills <mark@pogo.org.uk>
---
 gitk-git/gitk |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index c58fd58..299a2ae 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1876,6 +1876,7 @@ proc setoptions {} {
     option add *Message.font uifont startupFile
     option add *Entry.font uifont startupFile
     option add *Labelframe.font uifont startupFile
+    option add *Spinbox.font textfont startupFile
 }
 
 # Make a menu and submenus.
@@ -2226,7 +2227,7 @@ proc makewindow {} {
 	-command changediffdisp -variable diffelide -value {1 0}
     ${NS}::label .bleft.mid.labeldiffcontext -text "      [mc "Lines of context"]: "
     pack .bleft.mid.diff .bleft.mid.old .bleft.mid.new -side left
-    spinbox .bleft.mid.diffcontext -width 5 -font textfont \
+    spinbox .bleft.mid.diffcontext -width 5 \
 	-from 0 -increment 1 -to 10000000 \
 	-validate all -validatecommand "diffcontextvalidate %P" \
 	-textvariable diffcontextstring
-- 
1.6.6
