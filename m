Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C11D1F45F
	for <e@80x24.org>; Wed,  8 May 2019 15:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfEHPx5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 11:53:57 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42946 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbfEHPx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 11:53:56 -0400
Received: by mail-ed1-f68.google.com with SMTP id l25so22544996eda.9
        for <git@vger.kernel.org>; Wed, 08 May 2019 08:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uzybkjUBKgSztD4N3xI6wIUUgBNDjyuAwYKjXy2pLIo=;
        b=RQAtjeeGx/bu05KkDT7hOcAk+zgtFFUWYvdscL7hRz4BDk1LrKCAh4VzWGnyKdNh3+
         klFAosQaGK1Wkdo1hYqRlM/pABCROl6IVto9RxwylGdl7sDliRVpmoD+piY7RptBCnyI
         bdygLmIl/BPjxF4TpPAbBPrXBG4ZarOxBCiqX51x90I6oSlhxjEsObDAbcoPB0ZnP/cn
         91fIejoyH29fMAZTRsZzLu4AzdcHi1WMceQYlQBYS4FNYqa7Gh44yCQs9MM65WIYNEZ4
         AOS4O4sDDCQrxe6oBi1JPTKXU8XRyxYMXhYdaDzGf2mN66Chp1C3z0nAS+LkWsq7Iaoz
         Dx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uzybkjUBKgSztD4N3xI6wIUUgBNDjyuAwYKjXy2pLIo=;
        b=g534lv1QTj/oS7Vb4faRRvZcmfGXMBHQ23eT3+uUWJJl1IJCQSzrXZz+b+HWuaXb0O
         gPf9EX6HCiO3cmDOeZQbUvp8deqvsjjj8mF4RiDILSfLCg/MigeWvn/W7Zh1jkQSnFyw
         a1HSe2/IsyJr7ztIPY4Cyr3+bmhlnHWih0SGUf3kvLicDbDEKD2e3kRqT2kYqxV77VBn
         6Dtw12vy8uHUbfqWOXbP8ujmfRebDDbLqnTZh6HL0QASR9YnxsiIyne6Msu2K20zLxc7
         OB5JBLD8Lnazikk1X/HLXiq4JXF+u3NonGwSUt1E3b7zOlWsu2aAYmzYkW+Z0aq9OlcX
         pvqg==
X-Gm-Message-State: APjAAAXUCLxcFFh6RH/UTnP8JtE5ADH0arUvwZEEcW/Jvn4ofJpZDBrS
        xhFewH2MSn3xFynrGbv2WKT6tKpFxJI=
X-Google-Smtp-Source: APXvYqxns/rKdwLTiUp1+V2WdDXGq4Ze6o/YLtXzWko5h6dmCghEDcWY3pW4dP3DGXmSofZhvr3m/Q==
X-Received: by 2002:a17:906:2403:: with SMTP id z3mr30035469eja.278.1557330834605;
        Wed, 08 May 2019 08:53:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r20sm775540edx.46.2019.05.08.08.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:53:54 -0700 (PDT)
Date:   Wed, 08 May 2019 08:53:54 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 15:53:37 GMT
Message-Id: <aaae85f1ec0b39a800078ce2aba68f9b1b6b71d1.1557330827.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 08/17] commit-graph: extract fill_oids_from_all_packs()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The write_commit_graph() method is too complex, so we are
extracting methods one by one.

Extract fill_oids_from_all_packs() that reads all pack-files
for commits and fills the oid list in the context.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index fb25280df1..730d529815 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -950,6 +950,19 @@ static void fill_oids_from_commit_hex(struct write_commit_graph_context *ctx,
 	strbuf_release(&progress_title);
 }
 
+static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
+{
+	if (ctx->report_progress)
+		ctx->progress = start_delayed_progress(
+			_("Finding commits for commit graph among packed objects"),
+			ctx->approx_nr_objects);
+	for_each_packed_object(add_packed_commits, ctx,
+			       FOR_EACH_OBJECT_PACK_ORDER);
+	if (ctx->progress_done < ctx->approx_nr_objects)
+		display_progress(ctx->progress, ctx->approx_nr_objects);
+	stop_progress(&ctx->progress);
+}
+
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
@@ -1006,17 +1019,8 @@ int write_commit_graph(const char *obj_dir,
 	if (commit_hex)
 		fill_oids_from_commit_hex(ctx, commit_hex);
 
-	if (!pack_indexes && !commit_hex) {
-		if (ctx->report_progress)
-			ctx->progress = start_delayed_progress(
-				_("Finding commits for commit graph among packed objects"),
-				ctx->approx_nr_objects);
-		for_each_packed_object(add_packed_commits, ctx,
-				       FOR_EACH_OBJECT_PACK_ORDER);
-		if (ctx->progress_done < ctx->approx_nr_objects)
-			display_progress(ctx->progress, ctx->approx_nr_objects);
-		stop_progress(&ctx->progress);
-	}
+	if (!pack_indexes && !commit_hex)
+		fill_oids_from_all_packs(ctx);
 
 	close_reachable(ctx);
 
-- 
gitgitgadget

