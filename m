Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CDC020372
	for <e@80x24.org>; Wed, 11 Oct 2017 08:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757189AbdJKIqe (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 04:46:34 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:38734 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756608AbdJKIqc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 04:46:32 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:56568 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1e2Ceu-0006df-Bp
        for git@vger.kernel.org; Wed, 11 Oct 2017 04:46:32 -0400
Date:   Wed, 11 Oct 2017 04:46:30 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH] doc: emphasize stash "--keep-index" stashes staged content
Message-ID: <alpine.LFD.2.21.1710110443360.11205@localhost.localdomain>
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


It's not immediately obvious from the man page that the "--keep-index"
option still adds the staged content to the stash, so make that
abundantly clear.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 00f95fee1..037144037 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -68,8 +68,8 @@ entries and working tree files are then rolled back to the state in
 HEAD only for these files, too, leaving files that do not match the
 pathspec intact.
 +
-If the `--keep-index` option is used, all changes already added to the
-index are left intact.
+If the `--keep-index` option is used, all changes already staged in the
+index are left intact in the index, while still being added to the stash.
 +
 If the `--include-untracked` option is used, all untracked files are also
 stashed and then cleaned up with `git clean`, leaving the working directory

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
