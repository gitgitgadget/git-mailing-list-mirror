Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6A9C83F15
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 21:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjH1Vrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 17:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbjH1Vrk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 17:47:40 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED4AF9
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 14:47:37 -0700 (PDT)
Received: (qmail 537 invoked by uid 109); 28 Aug 2023 21:47:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Aug 2023 21:47:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4529 invoked by uid 111); 28 Aug 2023 21:47:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 17:47:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 17:47:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 05/22] worktree: mark unused parameters in each_ref_fn
 callback
Message-ID: <20230828214736.GE3831137@coredump.intra.peff.net>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828214604.GA3830831@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is similar to the cases in 63e14ee2d6 (refs: mark unused
each_ref_fn parameters, 2022-08-19), but it was added after that commit.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/worktree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 10db70b7ec..62b7e26f4b 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -628,10 +628,10 @@ static void print_preparing_worktree_line(int detach,
  *
  * Returns 0 on failure and non-zero on success.
  */
-static int first_valid_ref(const char *refname,
-			   const struct object_id *oid,
-			   int flags,
-			   void *cb_data)
+static int first_valid_ref(const char *refname UNUSED,
+			   const struct object_id *oid UNUSED,
+			   int flags UNUSED,
+			   void *cb_data UNUSED)
 {
 	return 1;
 }
-- 
2.42.0.505.g4c6fb48dec

