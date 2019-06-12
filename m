Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC42E1F462
	for <e@80x24.org>; Wed, 12 Jun 2019 13:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbfFLN3r (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 09:29:47 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46132 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729231AbfFLN3o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 09:29:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id d4so2421502edr.13
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 06:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+pSaVZCM/hXXj12kr/gWfz2FJFF/AS+MXPwAmoGJ0Lo=;
        b=tl+xPTi3WdpQyPIQv/YufssdhVxM/G0g9/I8IRUu21BgmIfEkEn2kEOA98/kH+VV3/
         1JKUUgkUzvp+6yRhMuU0xc76NzD9hL8GhKrrApL2IwgZV12CeXOQ4471UI2o/9AaK45R
         Fzoe0KgppHBnpompUGYAirALh0+trnJIWdF1MC7XQMLwA5+LKk61PZIn/x66IV6kJIog
         foawkoeVPoJ9G5XHitEVYLiF8cZD/rcMU9lcLK8tIAHGgQ2636H0R3GL/lyYOi91LzY+
         RRjYYn+hCbi65fRbwZaItpqXSo87GGl6JYBeIEwyEsAQgHqui4Gx08oS2JDRfTGqBj+F
         uMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+pSaVZCM/hXXj12kr/gWfz2FJFF/AS+MXPwAmoGJ0Lo=;
        b=A3DQ0yXhRowkxx6UKpxyXIvv3uW7aF26fBsxDBXYqQ8w5goN8Q9kpev88d2m+alulO
         IzJrhGnviBcTtXyEKtJs6GKvU2nS5mJJNZxnbHEdQQ+qvYxZ6IdutsQ/8WlNK13XU5Qw
         StSvtWQiA+eNvDW5DKb/F6l3en/atLgsPNOuJrcnFmhLqtPlvi8LVfL+hEioGSygcVHQ
         c48RwBWl2LqUJbcPclNcMrB4HJ19Oli3yaQgfXdjGNNh0Rx1bpoTggYYOd+H9oS6S4E1
         reVOXNNebI14cHcyKsRaVlT72HRPYin6/WkwLjVhHFwlXZUkBSjsem49oo9yL7UsF+6x
         rLhg==
X-Gm-Message-State: APjAAAVcDFf14P7TAZ9ta5CxQ/SrE41/b40V5rTqEcA74Wn7nZOqs/vz
        lUTJ7/XwUqIw3iruFEETK74Fmuoc
X-Google-Smtp-Source: APXvYqyDKJR4m5IhckK13ZlOMcrfwwrYZsUg6MDXOjzAQdzI6u47jOW5Ya8mv5Zu3UQq31c4XQQrsw==
X-Received: by 2002:a17:906:3e92:: with SMTP id a18mr54571304ejj.170.1560346182650;
        Wed, 12 Jun 2019 06:29:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e8sm2463444ejk.70.2019.06.12.06.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 06:29:42 -0700 (PDT)
Date:   Wed, 12 Jun 2019 06:29:42 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jun 2019 13:29:29 GMT
Message-Id: <fe36c8ad28f4e608739f10d2bbef7fadf236a3db.1560346174.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v5.git.gitgitgadget@gmail.com>
References: <pull.112.v4.git.gitgitgadget@gmail.com>
        <pull.112.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 07/11] commit-graph: extract fill_oids_from_commit_hex()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, avarab@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The write_commit_graph() method is too complex, so we are
extracting helper functions one by one.

Extract fill_oids_from_commit_hex() that reads the given commit
id list and fille the oid list in the context.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 72 ++++++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 32 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 02e5f8c651..4fae1fcdb2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -912,6 +912,44 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 	return 0;
 }
 
+static void fill_oids_from_commit_hex(struct write_commit_graph_context *ctx,
+				      struct string_list *commit_hex)
+{
+	uint32_t i;
+	struct strbuf progress_title = STRBUF_INIT;
+
+	if (ctx->report_progress) {
+		strbuf_addf(&progress_title,
+			    Q_("Finding commits for commit graph from %d ref",
+			       "Finding commits for commit graph from %d refs",
+			       commit_hex->nr),
+			    commit_hex->nr);
+		ctx->progress = start_delayed_progress(
+					progress_title.buf,
+					commit_hex->nr);
+	}
+	for (i = 0; i < commit_hex->nr; i++) {
+		const char *end;
+		struct object_id oid;
+		struct commit *result;
+
+		display_progress(ctx->progress, i + 1);
+		if (commit_hex->items[i].string &&
+		    parse_oid_hex(commit_hex->items[i].string, &oid, &end))
+			continue;
+
+		result = lookup_commit_reference_gently(ctx->r, &oid, 1);
+
+		if (result) {
+			ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
+			oidcpy(&ctx->oids.list[ctx->oids.nr], &(result->object.oid));
+			ctx->oids.nr++;
+		}
+	}
+	stop_progress(&ctx->progress);
+	strbuf_release(&progress_title);
+}
+
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
@@ -965,38 +1003,8 @@ int write_commit_graph(const char *obj_dir,
 			goto cleanup;
 	}
 
-	if (commit_hex) {
-		if (ctx->report_progress) {
-			strbuf_addf(&progress_title,
-				    Q_("Finding commits for commit graph from %d ref",
-				       "Finding commits for commit graph from %d refs",
-				       commit_hex->nr),
-				    commit_hex->nr);
-			ctx->progress = start_delayed_progress(
-						progress_title.buf,
-						commit_hex->nr);
-		}
-		for (i = 0; i < commit_hex->nr; i++) {
-			const char *end;
-			struct object_id oid;
-			struct commit *result;
-
-			display_progress(ctx->progress, i + 1);
-			if (commit_hex->items[i].string &&
-			    parse_oid_hex(commit_hex->items[i].string, &oid, &end))
-				continue;
-
-			result = lookup_commit_reference_gently(ctx->r, &oid, 1);
-
-			if (result) {
-				ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
-				oidcpy(&ctx->oids.list[ctx->oids.nr], &(result->object.oid));
-				ctx->oids.nr++;
-			}
-		}
-		stop_progress(&ctx->progress);
-		strbuf_reset(&progress_title);
-	}
+	if (commit_hex)
+		fill_oids_from_commit_hex(ctx, commit_hex);
 
 	if (!pack_indexes && !commit_hex) {
 		if (ctx->report_progress)
-- 
gitgitgadget

