Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D07E1F45F
	for <e@80x24.org>; Thu,  9 May 2019 14:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfEIOWk (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 10:22:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38440 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfEIOWj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 10:22:39 -0400
Received: by mail-ed1-f66.google.com with SMTP id w11so2202855edl.5
        for <git@vger.kernel.org>; Thu, 09 May 2019 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Xs0dnuZT2HlSNFfGJN34jFbb8FsInMLoBcXOCQalhbA=;
        b=mJ0oAA1ZDzW65ui0LgsydxCQL6UmYJ2OG2s6K2zzli0/z9JvsXpDlp3ar+kCmSf9Kx
         wMgzLOepvV2gRsFi1fk0gpzwOvzVemoXRiMDZayEedS9O09GwvB1pbtKjCo5fzk4JAEI
         Rd8GJnMD2iQbnadyeq633opdtI74jxVHRWHI73YA3CILAQnJ6JQY7XjL6Gud0jyLB0C7
         yjnuQN11YzvYmDReSoOA5oI9gG2+jahBSesSzTsFF599BgV2jmfqI41mTLYP6VlSeKBq
         q+Wnz5vH/N/z71uj8blL5zWO82FMSx4apCr1kvDP4iutzAQ9UfF2tFLKX94zYzmVSf6g
         gQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Xs0dnuZT2HlSNFfGJN34jFbb8FsInMLoBcXOCQalhbA=;
        b=kORho+TDe2gCztb2y9btdn2AmjE6QMJ4hM36gI6tyN3AL3lK/21LthREIoA36M8kex
         qfDrtuLotD5TPSvgkXmyqEtkZpeKMRYDVb15g97r1opq7ns/3a80XR9TgSN2FLQ5qbqY
         tLGMjXx9g9NTasHpseJkmXU7fF9t+8IVZ/aIlFYy/f9ExYeL5nPj3KjjQ3DMC7QagEi0
         JcJY1IklO+PWOzESuZTu/US93ZTLZzFaMxzaczrMSUZWadfHi0JI9jnHAaBztb6VQn1g
         OK7h1hzOqsMn8SkypclEAvt8g1IYUZFA5NiJ+8D3tYqs7SzjEKdzsaTR/qqnbzpHBQP5
         8F1g==
X-Gm-Message-State: APjAAAVigk2O9mxX0xWkNtm+NrbrxoOk2+k6r5IaazXh2QpVu0GYhKT4
        WXjibV0xhU27qbnaO6U3TZqSrgW5
X-Google-Smtp-Source: APXvYqxhJXK8DZQPe9DpLea8cHOOH5Otj1l/ByLMNRlLSFZzoJicMYl/FB7Ro0PU8zIvo0ScGa8wlg==
X-Received: by 2002:a50:907a:: with SMTP id z55mr4417981edz.140.1557411757479;
        Thu, 09 May 2019 07:22:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u47sm610693edm.86.2019.05.09.07.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 07:22:36 -0700 (PDT)
Date:   Thu, 09 May 2019 07:22:36 -0700 (PDT)
X-Google-Original-Date: Thu, 09 May 2019 14:22:25 GMT
Message-Id: <8cb2613dfa5cad1f6872a1fe1cf8e317a1bc400e.1557411749.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v4.git.gitgitgadget@gmail.com>
References: <pull.112.v3.git.gitgitgadget@gmail.com>
        <pull.112.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 07/11] commit-graph: extract fill_oids_from_commit_hex()
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
extracting methods one by one.

Extract fill_oids_from_commit_hex() that reads the given commit
id list and fille the oid list in the context.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 72 ++++++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 32 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 80c7069aaa..fb25280df1 100644
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

