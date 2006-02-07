From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 1/2] Document git-diff-tree --always
Date: Tue, 07 Feb 2006 12:47:44 +0100
Message-ID: <20060207114744.27532.21094.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 07 12:47:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6RJp-0007cW-9C
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 12:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbWBGLre (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 06:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbWBGLre
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 06:47:34 -0500
Received: from w241.dkm.cz ([62.24.88.241]:32231 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965031AbWBGLre (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 06:47:34 -0500
Received: (qmail 27549 invoked from network); 7 Feb 2006 12:47:44 +0100
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 7 Feb 2006 12:47:44 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15693>

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-diff-tree.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 674ee61..9153e4c 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -95,6 +95,10 @@ separated with a single space are given.
 	hunks disappear, the commit itself and the commit log
 	message is not shown, just like any other "empty diff" cases.
 
+--always::
+	Show the commit itself and the commit log message even
+	if the diff itself is empty.
+
 
 Limiting Output
 ---------------
