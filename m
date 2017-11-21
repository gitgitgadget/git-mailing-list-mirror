Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4A6F2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 15:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbdKUPlS (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 10:41:18 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:37606 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbdKUPlS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 10:41:18 -0500
Received: from 69-196-158-250.dsl.teksavvy.com ([69.196.158.250]:52800 helo=DESKTOP-1GPMCEJ)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eHAfl-00038l-CS
        for git@vger.kernel.org; Tue, 21 Nov 2017 10:41:17 -0500
Date:   Tue, 21 Nov 2017 10:39:55 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@DESKTOP-1GPMCEJ
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH v2] doc: Add missing "-n" (dry-run) option to reflog man
 page
Message-ID: <alpine.LFD.2.21.1711211038410.8568@DESKTOP-1GPMCEJ>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the "git reflog" man page supports both "--dry-run" and "-n" for
a dry run, the man page mentions only the former, not the latter.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  sorry, i accidentally chopped off the leading lines of the patch in
the earlier post.

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 44c736f1a..472a6808c 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -20,9 +20,9 @@ depending on the subcommand:
 'git reflog' ['show'] [log-options] [<ref>]
 'git reflog expire' [--expire=<time>] [--expire-unreachable=<time>]
 	[--rewrite] [--updateref] [--stale-fix]
-	[--dry-run] [--verbose] [--all | <refs>...]
+	[--dry-run | -n] [--verbose] [--all | <refs>...]
 'git reflog delete' [--rewrite] [--updateref]
-	[--dry-run] [--verbose] ref@\{specifier\}...
+	[--dry-run | -n] [--verbose] ref@\{specifier\}...
 'git reflog exists' <ref>

 Reference logs, or "reflogs", record when the tips of branches and


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
