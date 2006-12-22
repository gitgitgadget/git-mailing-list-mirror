From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] make the message about the need for a new branch a bit clearer
Date: Fri, 22 Dec 2006 15:06:54 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612221502360.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 21:07:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxqfT-00082h-No
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 21:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563AbWLVUGz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 15:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbWLVUGz
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 15:06:55 -0500
Received: from relais.videotron.ca ([24.201.245.36]:15261 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbWLVUGz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 15:06:55 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JAO00JW9YJIPZA0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 22 Dec 2006 15:06:54 -0500 (EST)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35205>

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/git-checkout.sh b/git-checkout.sh
index c877440..923d81c 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -146,8 +146,11 @@ fi
 
 [ -z "$branch$newbranch" ] &&
 	[ "$new" != "$old" ] &&
-	die "git checkout: to checkout the requested commit you need to specify 
-              a name for a new branch which is created and switched to"
+	die "git checkout: provided reference cannot be checked out directly
+
+  You need -b to associate a new branch with the wanted checkout. Example:
+  git checkout -b <new_branch_name> $arg
+"
 
 if [ "X$old" = X ]
 then
