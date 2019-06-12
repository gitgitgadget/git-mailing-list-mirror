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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7775E1F462
	for <e@80x24.org>; Wed, 12 Jun 2019 13:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbfFLN3r (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 09:29:47 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35311 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732419AbfFLN3p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 09:29:45 -0400
Received: by mail-ed1-f65.google.com with SMTP id p26so21743467edr.2
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 06:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fiTKrJhWr9kTDyMkSRvF9bh/Ql3QaE+tC1w+lf1/8Vs=;
        b=ZtqAUXXTgiEoHz7rgLsWQsBj/QYVBwfxSmCBTyiUIead7+SXU4zIXQIxkEKQaNnK+N
         keZI4UpIHQQjqhUn5QI/c4kVJq35jDqHJJCBU0jobj+IOEANcAwie7Kb/U1z8/yH90S8
         ntBvXO0aUzrO6HFDopTW72aR98NaecmcNp5PJTjIuiv/bp025EcuSdVR6VquYvWK5f1V
         bNieBb1rlj+os5swq+mFWnrJE0ohmi4Byp9zyR9p8dKrsVp6xHYHsfNBIg3WBDjnD9kr
         CS7eIY5mvmbmhyqYuvxg3y8fhQ1UJF12mTfhQMz4M1um7dB46pEsX+YMibnOuOVpW8fa
         nd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fiTKrJhWr9kTDyMkSRvF9bh/Ql3QaE+tC1w+lf1/8Vs=;
        b=CfKNf5z0xbTOho5VEiEPPX0War3cAEdhZEADrlIklY1Opkxn7AY8cAmdQwGD+bwOQ/
         Gl+8dVqYiUyVw37R1beDJemukGNka+Q0FnA+qA358rLaShLLx7w5y4DZZoII8H5HW5uY
         URXOvsaTlRUKuTrV0zk45cqkNnoCnxlBWMuB2i/htpPk2YdRmRKHUyYl8Dow0wCzAzsM
         p7RNRkw+WDgXS6mkIgsbgHIkBigkEpwe7+ZI3QtqaIKoFNpI6Q7DSBhxt4i863g4x1pV
         w+AJSYNs9b3OvlL4uDAqwqTyTvwjXc5ehXVUb/fiqxM+Umuk8XiiF3mtVpmZwyEq9tSN
         7Sjw==
X-Gm-Message-State: APjAAAUjCKcE9bP+Oo2C8Rc42lyLWYpbpaFgb1HkElK5d0RY4XayP9Oa
        JJdCt7V1DGFEdTtUEk0Iju4PhIqi
X-Google-Smtp-Source: APXvYqxZE7wUyHrW/HwnK+DKA7X3BConG2Y/hHqg5uBwl94d/0XnRfBoKAn8afJy1540Jkr2jOaz2Q==
X-Received: by 2002:a17:906:310c:: with SMTP id 12mr8508187ejx.162.1560346184024;
        Wed, 12 Jun 2019 06:29:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9sm2781294ejk.73.2019.06.12.06.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 06:29:43 -0700 (PDT)
Date:   Wed, 12 Jun 2019 06:29:43 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jun 2019 13:29:31 GMT
Message-Id: <40acc6ec3716f2e8ce5e08b18b394bc07ed56f36.1560346174.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v5.git.gitgitgadget@gmail.com>
References: <pull.112.v4.git.gitgitgadget@gmail.com>
        <pull.112.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 09/11] commit-graph: extract count_distinct_commits()
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

Extract count_distinct_commits(), which sorts the oids list, then
iterates through to find duplicates.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 61cb43ddf8..1a0a875a7b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -963,6 +963,27 @@ static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
+static uint32_t count_distinct_commits(struct write_commit_graph_context *ctx)
+{
+	uint32_t i, count_distinct = 1;
+
+	if (ctx->report_progress)
+		ctx->progress = start_delayed_progress(
+			_("Counting distinct commits in commit graph"),
+			ctx->oids.nr);
+	display_progress(ctx->progress, 0); /* TODO: Measure QSORT() progress */
+	QSORT(ctx->oids.list, ctx->oids.nr, commit_compare);
+
+	for (i = 1; i < ctx->oids.nr; i++) {
+		display_progress(ctx->progress, i + 1);
+		if (!oideq(&ctx->oids.list[i - 1], &ctx->oids.list[i]))
+			count_distinct++;
+	}
+	stop_progress(&ctx->progress);
+
+	return count_distinct;
+}
+
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
@@ -1024,19 +1045,7 @@ int write_commit_graph(const char *obj_dir,
 
 	close_reachable(ctx);
 
-	if (ctx->report_progress)
-		ctx->progress = start_delayed_progress(
-			_("Counting distinct commits in commit graph"),
-			ctx->oids.nr);
-	display_progress(ctx->progress, 0); /* TODO: Measure QSORT() progress */
-	QSORT(ctx->oids.list, ctx->oids.nr, commit_compare);
-	count_distinct = 1;
-	for (i = 1; i < ctx->oids.nr; i++) {
-		display_progress(ctx->progress, i + 1);
-		if (!oideq(&ctx->oids.list[i - 1], &ctx->oids.list[i]))
-			count_distinct++;
-	}
-	stop_progress(&ctx->progress);
+	count_distinct = count_distinct_commits(ctx);
 
 	if (count_distinct >= GRAPH_EDGE_LAST_MASK) {
 		error(_("the commit graph format cannot write %d commits"), count_distinct);
-- 
gitgitgadget

