Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7742AC433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB9564F60
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhBCVIP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 16:08:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:46576 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229872AbhBCVIO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 16:08:14 -0500
Received: (qmail 21648 invoked by uid 109); 3 Feb 2021 21:07:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Feb 2021 21:07:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4656 invoked by uid 111); 3 Feb 2021 21:07:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Feb 2021 16:07:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 3 Feb 2021 16:07:32 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] doc/git-branch: fix awkward wording for "-c"
Message-ID: <YBsQlC03pJgYUHde@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The description for "-c" is hard to parse. I think the big issue is lack
of commas, but I've also reordered the words to keep the main focus
point of "instead of renaming, copy" together.

Signed-off-by: Jeff King <peff@peff.net>
---
Just happened to be reading this when writing the nearby completion
patch.

 Documentation/git-branch.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index adaa1782a8..eb815c2248 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -78,8 +78,8 @@ renaming. If <newbranch> exists, -M must be used to force the rename
 to happen.
 
 The `-c` and `-C` options have the exact same semantics as `-m` and
-`-M`, except instead of the branch being renamed it along with its
-config and reflog will be copied to a new name.
+`-M`, except instead of the branch being renamed, it will be copied to a
+new name, along with its config and reflog.
 
 With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
 specify more than one branch for deletion.  If the branch currently
-- 
2.30.0.882.gf229bd7cc9
