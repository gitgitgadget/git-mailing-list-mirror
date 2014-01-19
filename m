From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH] Documentation: @{-N} can refer to a commit
Date: Sun, 19 Jan 2014 08:01:15 +0100
Message-ID: <c9a93954276440ae251dd763837d5159923b6d59.1390114656.git.tr@thomasrast.ch>
References: <CAO54GHBRbVQWDjE70tEZY=nP==gtrqVvmx1JWYNkc_HOeDnYDA@mail.gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, Kevin <ikke@ikke.info>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 19 08:01:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4mNx-0008AU-BD
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jan 2014 08:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbaASHBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jan 2014 02:01:30 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:52499 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739AbaASHB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jan 2014 02:01:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 5E2684D6572;
	Sun, 19 Jan 2014 08:01:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id LRe4wz_Whyav; Sun, 19 Jan 2014 08:01:16 +0100 (CET)
Received: from linux.local (unknown [213.55.184.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id B628C4D64BD;
	Sun, 19 Jan 2014 08:01:15 +0100 (CET)
X-Mailer: git-send-email 1.9.rc0.162.g8980120
In-Reply-To: <CAO54GHBRbVQWDjE70tEZY=nP==gtrqVvmx1JWYNkc_HOeDnYDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240673>

The @{-N} syntax always referred to the N-th last thing checked out,
which can be either a branch or a commit (for detached HEAD cases).
However, the documentation only mentioned branches.

Edit in a "/commit" in the appropriate places.

Reported-by: Kevin <ikke@ikke.info>
Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---

This is the "minimal" edit.  I'd welcome better wording for the
git-commit manpage, I can't come up with any right now.


 Documentation/git-checkout.txt | 4 ++--
 Documentation/revisions.txt    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 91294f8..33ad2ad 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -232,8 +232,8 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 	commit, your HEAD becomes "detached" and you are no longer on
 	any branch (see below for details).
 +
-As a special case, the `"@{-N}"` syntax for the N-th last branch
-checks out the branch (instead of detaching).  You may also specify
+As a special case, the `"@{-N}"` syntax for the N-th last branch/commit
+checks out branches (instead of detaching).  You may also specify
 `-` which is synonymous with `"@{-1}"`.
 +
 As a further special case, you may use `"A...B"` as a shortcut for the
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 2c06ed3..5a286d0 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -88,7 +88,7 @@ some output processing may assume ref names in UTF-8.
   branch 'blabla' then '@\{1\}' means the same as 'blabla@\{1\}'.
 
 '@\{-<n>\}', e.g. '@\{-1\}'::
-  The construct '@\{-<n>\}' means the <n>th branch checked out
+  The construct '@\{-<n>\}' means the <n>th branch/commit checked out
   before the current one.
 
 '<branchname>@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
-- 
1.9.rc0.162.g8980120
