From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] gitk: bind <F5> key to Update (reread commits)
Date: Fri, 23 Feb 2007 12:36:34 -0800
Message-ID: <11722629943386-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 23 21:36:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKh9s-000084-3Z
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 21:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbXBWUgi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 15:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933202AbXBWUgi
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 15:36:38 -0500
Received: from hand.yhbt.net ([66.150.188.102]:35280 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932638AbXBWUgh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 15:36:37 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id AA4552DC01A;
	Fri, 23 Feb 2007 12:36:35 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 23 Feb 2007 12:36:34 -0800
X-Mailer: git-send-email 1.5.0.1.214.g3d9be
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40467>

I chose <F5> because it's also the key to reload the current
page in web browsers such as Konqueror and Firefox, so users
are more likely to be familiar with it.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 gitk |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 9ddff3e..1cd2a8f 100755
--- a/gitk
+++ b/gitk
@@ -720,6 +720,7 @@ proc makewindow {} {
     bindkey <Key-Return> {findnext 0}
     bindkey ? findprev
     bindkey f nextfile
+    bindkey <F5> updatecommits
     bind . <Control-q> doquit
     bind . <Control-f> dofind
     bind . <Control-g> {findnext 0}
@@ -985,6 +986,7 @@ f		Scroll diff view to next file
 <Ctrl-plus>	Increase font size
 <Ctrl-KP->	Decrease font size
 <Ctrl-minus>	Decrease font size
+<F5>		Update
 } \
 	    -justify left -bg white -border 2 -relief sunken
     pack $w.m -side top -fill both
-- 
1.5.0.1.213.g509b
