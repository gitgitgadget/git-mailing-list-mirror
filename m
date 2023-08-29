Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C99C83F17
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 23:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239761AbjH2Xp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 19:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236539AbjH2XpY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 19:45:24 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D59C1B1
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 16:45:21 -0700 (PDT)
Received: (qmail 14841 invoked by uid 109); 29 Aug 2023 23:45:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Aug 2023 23:45:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19862 invoked by uid 111); 29 Aug 2023 23:45:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Aug 2023 19:45:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Aug 2023 19:45:20 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 08/22] stash: mark unused parameter in diff callback
Message-ID: <20230829234520.GF227214@coredump.intra.peff.net>
References: <20230829234305.GA226944@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829234305.GA226944@coredump.intra.peff.net>
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
2.42.0.528.g7950723a09

