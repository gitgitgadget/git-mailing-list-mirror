From: Michael Prokop <mika@grml.org>
Subject: [PATCH 1/1] Replace svn.foo.org with svn.example.com in git-svn docs (RFC 2606)
Date: Tue, 30 Sep 2008 01:01:34 +0200
Message-ID: <1222729294-20649-1-git-send-email-mika@grml.org>
Cc: Michael Prokop <mika@grml.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 30 01:31:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkSDI-00080v-T3
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 01:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbYI2XaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 19:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbYI2XaX
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 19:30:23 -0400
Received: from mail.michael-prokop.at ([88.198.6.110]:48442 "EHLO
	mail.michael-prokop.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbYI2XaW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 19:30:22 -0400
X-Greylist: delayed 1714 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Sep 2008 19:30:22 EDT
Received: from mail.michael-prokop.at (grmlvrs [127.0.0.1])
	by mail.michael-prokop.at (Postfix) with ESMTP id 9FB65434265;
	Tue, 30 Sep 2008 01:01:45 +0200 (CEST)
Received: by mail.michael-prokop.at (Postfix, from userid 5001)
	id 928584341FA; Tue, 30 Sep 2008 01:01:45 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on grmlvrs
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=4.5 tests=ALL_TRUSTED,AWL,BAYES_00,
	WHOIS_NETSOLPR autolearn=ham version=3.2.5
Received: from localhost (grml.org [88.198.6.110])
	by mail.michael-prokop.at (Postfix) with ESMTP id 661EB4341FA;
	Tue, 30 Sep 2008 01:01:39 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97058>

foo.org is an existing domain, use RFC 2606 complying example.com instead
as used in other docs as well.

Signed-off-by: Michael Prokop <mika@grml.org>
---
 Documentation/git-svn.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 1e644ca..82d03b4 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -473,7 +473,7 @@ Tracking and contributing to the trunk of a Subversion-managed project:
 
 ------------------------------------------------------------------------
 # Clone a repo (like git clone):
-	git svn clone http://svn.foo.org/project/trunk
+	git svn clone http://svn.example.com/project/trunk
 # Enter the newly cloned directory:
 	cd trunk
 # You should be on master branch, double-check with git-branch
@@ -495,7 +495,7 @@ Tracking and contributing to an entire Subversion-managed project
 
 ------------------------------------------------------------------------
 # Clone a repo (like git clone):
-	git svn clone http://svn.foo.org/project -T trunk -b branches -t tags
+	git svn clone http://svn.example.com/project -T trunk -b branches -t tags
 # View all branches and tags you have cloned:
 	git branch -r
 # Reset your master to trunk (or any other branch, replacing 'trunk'
@@ -514,7 +514,7 @@ have each person clone that repository with 'git-clone':
 
 ------------------------------------------------------------------------
 # Do the initial import on a server
-	ssh server "cd /pub && git svn clone http://svn.foo.org/project
+	ssh server "cd /pub && git svn clone http://svn.example.com/project
 # Clone locally - make sure the refs/remotes/ space matches the server
 	mkdir project
 	cd project
@@ -523,7 +523,7 @@ have each person clone that repository with 'git-clone':
 	git config --add remote.origin.fetch '+refs/remotes/*:refs/remotes/*'
 	git fetch
 # Initialize git-svn locally (be sure to use the same URL and -T/-b/-t options as were used on server)
-	git svn init http://svn.foo.org/project
+	git svn init http://svn.example.com/project
 # Pull the latest changes from Subversion
 	git svn rebase
 ------------------------------------------------------------------------
-- 
1.5.6.5
