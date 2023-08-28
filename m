Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC05C83F19
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 21:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjH1Vrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 17:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjH1Vru (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 17:47:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8D6F9
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 14:47:47 -0700 (PDT)
Received: (qmail 550 invoked by uid 109); 28 Aug 2023 21:47:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Aug 2023 21:47:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4538 invoked by uid 111); 28 Aug 2023 21:47:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 17:47:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 17:47:46 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 08/22] stash: mark unused parameter in diff callback
Message-ID: <20230828214746.GH3831137@coredump.intra.peff.net>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828214604.GA3830831@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is similar to the cases in 61bdc7c5d8 (diff: mark unused parameters
in callbacks, 2022-12-13), but I missed it when making that commit.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/stash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index fe64cde9ce..c9365bea13 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -362,7 +362,7 @@ static int is_path_a_directory(const char *path)
 }
 
 static void add_diff_to_buf(struct diff_queue_struct *q,
-			    struct diff_options *options,
+			    struct diff_options *options UNUSED,
 			    void *data)
 {
 	int i;
-- 
2.42.0.505.g4c6fb48dec

