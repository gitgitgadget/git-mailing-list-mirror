From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] Point git-clone man-page to git-pull and friends for remote repo syntax.
Date: Wed,  2 Nov 2005 00:25:08 +0100 (CET)
Message-ID: <20051101232508.097715BF70@nox.op5.se>
X-From: git-owner@vger.kernel.org Wed Nov 02 00:26:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX5VP-0002uG-3i
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 00:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbVKAXZK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 18:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbVKAXZK
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 18:25:10 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:52204 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751432AbVKAXZJ
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 18:25:09 -0500
Received: from nox.op5.se (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 2E36A6BD00
	for <git@vger.kernel.org>; Wed,  2 Nov 2005 00:25:08 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 097715BF70; Wed,  2 Nov 2005 00:25:08 +0100 (CET)
To: undisclosed-recipients:;
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10969>

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 Documentation/git-clone.txt |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

applies-to: 10d2c80712a3ff324ddd1c0f37b2b0e8bfda554c
189416bb09953a7268d13ea38cbef6bd61485863
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index dd92cde..1d23be5 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -48,10 +48,8 @@ OPTIONS
 	run on the other end.
 
 <repository>::
-	The (possibly remote) repository to clone from.  It can
-	be an "rsync://host/dir" URL, an "http://host/dir" URL,
-	or [<host>:]/dir notation that is used by 'git-clone-pack'.
-	Currently http transport is not supported.
+	The repository to clone from.  See the man-page for
+	git-pull, git-fetch or git-push for syntax explanation.
 
 <directory>::
 	The name of a new directory to be cloned into.  It is an
---
0.99.9.GIT
