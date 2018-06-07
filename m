Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3AA61F403
	for <e@80x24.org>; Thu,  7 Jun 2018 11:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753550AbeFGLz4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 07:55:56 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:34624 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753028AbeFGLzz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 07:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EhDljdc2ZNmFHum6EF7WmS1GbH1ODL+GhqF75uDmCGI=; b=z1+o97dcE8XvbhNQ0lstHMaVWo
        BJA3f8XzrScRxYf3I7PLvpYT6yk/OqwOd9z9z2TNzY7K6JBmUrujGMBNANw2QORygHidHBe8eVn1Q
        Z8P2jEXkbKykqFCJu9Aj5uSW4pXQyuN8cCOhX8Qix0vYVRNK8vs7tJMjE7PC3kU9EKmsQMiCpW0QR
        at7u0JX1RPD5z68bAWaeBnBe0EZFJWFIe5dBlHHJFXUHvilwRtiPsZuZ5eBOa80dQULiqC/vogOzL
        kGewS87rL/JoISEAbIN61u3KlVvroKBo+mh6GKUqN0rS3WC2Eg6AzQQ2xONrXkhGYHXd746vJTdf/
        7/ZCqpCw==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:50730 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fQtWD-00E0pd-6f
        for git@vger.kernel.org; Thu, 07 Jun 2018 07:55:54 -0400
Date:   Thu, 7 Jun 2018 07:53:36 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH] Use hyphenated "remote-tracking branch" (docs and
 comments)
Message-ID: <alpine.LFD.2.21.1806070751020.10794@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Use the obvious consensus of hyphenated "remote-tracking branch", and
fix an obvious typo, all in documentation and comments.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 4a5cc38a6f..ef9d9d28a9 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -42,8 +42,8 @@ have to use '../foo.git' instead of './foo.git' - as one might expect
 when following the rules for relative URLs - because the evaluation
 of relative URLs in Git is identical to that of relative directories).
 +
-The default remote is the remote of the remote tracking branch
-of the current branch. If no such remote tracking branch exists or
+The default remote is the remote of the remote-tracking branch
+of the current branch. If no such remote-tracking branch exists or
 the HEAD is detached, "origin" is assumed to be the default remote.
 If the superproject doesn't have a default remote configured
 the superproject is its own authoritative upstream and the current
diff --git a/builtin/branch.c b/builtin/branch.c
index d53f6e2ad4..5217ba3bde 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -701,7 +701,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		 * If no sorting parameter is given then we default to sorting
 		 * by 'refname'. This would give us an alphabetically sorted
 		 * array with the 'HEAD' ref at the beginning followed by
-		 * local branches 'refs/heads/...' and finally remote-tacking
+		 * local branches 'refs/heads/...' and finally remote-tracking
 		 * branches 'refs/remotes/...'.
 		 */
 		if (!sorting)
diff --git a/builtin/pull.c b/builtin/pull.c
index 1f2ecf3a88..49cc3beb4c 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -673,7 +673,7 @@ static const char *get_upstream_branch(const char *remote)
 }

 /**
- * Derives the remote tracking branch from the remote and refspec.
+ * Derives the remote-tracking branch from the remote and refspec.
  *
  * FIXME: The current implementation assumes the default mapping of
  * refs/heads/<branch_name> to refs/remotes/<remote_name>/<branch_name>.
@@ -711,7 +711,7 @@ static const char *get_tracking_branch(const char *remote, const char *refspec)

 /**
  * Given the repo and refspecs, sets fork_point to the point at which the
- * current branch forked from its remote tracking branch. Returns 0 on success,
+ * current branch forked from its remote-tracking branch. Returns 0 on success,
  * -1 on failure.
  */
 static int get_rebase_fork_point(struct object_id *fork_point, const char *repo,

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
