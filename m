Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EE5F1F45F
	for <e@80x24.org>; Thu,  9 May 2019 14:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfEIOWk (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 10:22:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38444 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfEIOWj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 10:22:39 -0400
Received: by mail-ed1-f66.google.com with SMTP id w11so2202908edl.5
        for <git@vger.kernel.org>; Thu, 09 May 2019 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uzybkjUBKgSztD4N3xI6wIUUgBNDjyuAwYKjXy2pLIo=;
        b=DO+fCmJjiTxBIjSkEW2QASefCY35Hih5Y1+jv/bIDgs1/N1J03C41HEVqTcpcZ1Z7n
         tYolbdKdY5DZPjphM78cncSHhKiJvVlwSKBq3p7B0XvbGuBbr9RZMb47S8sMwF02MgrX
         GZyF0cKq72tFCTOgDnHezxxQQDKk1P1po7HkhnieDcexZktLSvIVmCCHGgV92lrT2acP
         xMBk+5hwuXIazZ0jCSCcWWnpuJZcnhAWZzaRlaLj2mJj2uUOzna9lYV8Q32z9i92HH0p
         LzvA4WLECUdxmg7fmjJBqXgjhd2JLE2bsIVxmLXgyFmKDZsPn1aQO249Y14QCm+GYv/U
         Xaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uzybkjUBKgSztD4N3xI6wIUUgBNDjyuAwYKjXy2pLIo=;
        b=HwTc2j7Eck2tMf5KR/SLDyk58ur5jwDOolgZz8mKP3eNK8ZBRLQmL1d2YK/glLABVG
         G4bP7ZsTXPPE7Ifjk9QMqmowS3k+E8J+13FHjML6gciFM17fYeA2wEuovYhczCo9/3p1
         TGI49jcw8G2SVn7KdboKRqf6B4YAAWWCtAC39oQMvyoLDNwh3bQfKhn6DO2R77j3lpb5
         Ms24XnyRJdTaPB7SZUcx5ta0i0LdYbRzu/vmMgvIRvmiL514r/KQXZ+Fr2AOo5NjHRhd
         t2315sUi6epmPh85j1kqMwOx0WJiRKegve/snG1g8YXkTOrc7xMSVR/iWwHxQ3sthc/R
         sxkg==
X-Gm-Message-State: APjAAAUuqV7unY5l9DnjO1v2IRN+EW2YTkOrHcKeOrLj4YB7yuhyqjTP
        rCdiswSeK/yCgPsLABNJt9dy7fYC
X-Google-Smtp-Source: APXvYqzN9PbyZOMC+SdSTPeFabGaFyIkRxW/CvHHzprkM8UxMip6lyS7/6PppFfyitLUHzNbtQvh/Q==
X-Received: by 2002:a50:fd0a:: with SMTP id i10mr4290589eds.117.1557411758230;
        Thu, 09 May 2019 07:22:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w54sm650175edw.40.2019.05.09.07.22.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 07:22:37 -0700 (PDT)
Date:   Thu, 09 May 2019 07:22:37 -0700 (PDT)
X-Google-Original-Date: Thu, 09 May 2019 14:22:26 GMT
Message-Id: <8f7129672a15514138a3d677ce22522f21b43ec0.1557411749.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v4.git.gitgitgadget@gmail.com>
References: <pull.112.v3.git.gitgitgadget@gmail.com>
        <pull.112.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 08/11] commit-graph: extract fill_oids_from_all_packs()
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

