From: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH] Reference git-commit-tree for env vars.
Date: Fri, 17 Mar 2006 18:25:09 -0600
Message-ID: <E1FKPFl-000628-RS@jdl.com>
X-From: git-owner@vger.kernel.org Sat Mar 18 01:25:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKPGP-0006kc-Op
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 01:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWCRAZ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 19:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWCRAZ2
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 19:25:28 -0500
Received: from mail.jdl.com ([66.118.10.122]:16013 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S932280AbWCRAZ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Mar 2006 19:25:28 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1FKPFl-000628-RS
	for git@vger.kernel.org; Fri, 17 Mar 2006 18:25:10 -0600
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17678>


Signed-off-by: Jon Loeliger <jdl@jdl.com>


---

 Documentation/git-commit.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

4b5717172191a526600010ddfe9a4747fa9c33d2
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 214ed23..d04b342 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -18,6 +18,10 @@ Updates the index file for given paths, 
 VISUAL and EDITOR environment variables to edit the commit log
 message.
 
+Several environment variable are used during commits.  They are
+documented in gitlink:git-commit-tree[1].
+
+
 This command can run `commit-msg`, `pre-commit`, and
 `post-commit` hooks.  See link:hooks.html[hooks] for more
 information.
-- 
1.2.4.gdd7be
