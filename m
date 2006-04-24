From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 2/4] Document git-var -l listing also configuration variables
Date: Tue, 25 Apr 2006 00:59:28 +0200
Message-ID: <20060424225928.14086.54461.stgit@machine.or.cz>
References: <20060424225925.14086.97825.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 25 00:59:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYA1P-0005Ay-AU
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 00:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWDXW7F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 18:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWDXW7F
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 18:59:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49579 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932095AbWDXW7E (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Apr 2006 18:59:04 -0400
Received: (qmail 14170 invoked from network); 25 Apr 2006 00:59:28 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 25 Apr 2006 00:59:28 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060424225925.14086.97825.stgit@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19114>

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-var.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 90cb157..379571e 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -17,7 +17,9 @@ Prints a git logical variable.
 OPTIONS
 -------
 -l::
-	Cause the logical variables to be listed.
+	Cause the logical variables to be listed. In addition, all the
+	variables of the git configuration file .git/config are listed
+	as well.
 
 EXAMPLE
 --------
@@ -46,6 +48,7 @@ See Also
 --------
 gitlink:git-commit-tree[1]
 gitlink:git-tag[1]
+gitlink:git-repo-config[1]
 
 Author
 ------
