Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 059E21F597
	for <e@80x24.org>; Sat, 21 Jul 2018 22:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbeGUW73 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 18:59:29 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:45815 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbeGUW72 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 18:59:28 -0400
Received: by mail-pg1-f182.google.com with SMTP id f1-v6so9538090pgq.12
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 15:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4VNn2NGB5kZmtvioyie40WFGtBZ2CtSOl6Qj3BM+ras=;
        b=QMdoEGAERCb/5FcKiAJh2jG/2dTk88qSDz11bDFp9jIM4IReW746z+S9ETBcW3rYiZ
         HodsSKOYB/W7n1HD4NYWRaKs4xilDMQkECFt7bw7rXcqQ7vLG0hMLsD7E52RRkB3DpW1
         O6i2PUB/YYQgW+WojLRcWFfbIUV9u4gsCDsVXhCWP06i9zrhSgbO4H2ezoj2KWT0Bwqb
         +PBDQu+AaS3IrqrzBPY9e/p9kUO60ViR1igEigaQPRDJB/z/KdoGR7U3XjIM24SBlhfU
         URoADvakb5QjH5lScYdX//tfjThdzOrfWRBxh+4aarpioUQPZ4b6mKC1JxXrgBXJZbz1
         YZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4VNn2NGB5kZmtvioyie40WFGtBZ2CtSOl6Qj3BM+ras=;
        b=W1WuJ56h2CHzYbQoYURhu1GAmBg+fhog8EzSHnZJev50dTFeeEuxxHwxIy1xRfDJQA
         RlQvXkqNQ23fHwqkdzoTWhb0QQZb00JTDY7/M+Ym2w9JNBQnnNUzf0kiqqpnLZkDALHk
         drOtTHoPT4gFYWgxcNxtQMLnFX4y3FjTNuLEZWnPgERbvenQOztNZVqT256V4xfhVV/j
         xVFpcBiX/J3KL5aADwAywfJ1XlxQLObr8AbXUkrKXmQxc/yP/M81xj18dMH4mYp6IS8G
         XqkZ6b/JOV5wWxrA2NmlIpPvxO0fzfBBsmXFZebVWGa2nsyTzZrPr5YpDwjO+lJXQ8kF
         i1SQ==
X-Gm-Message-State: AOUpUlHyHAhBj2A62nXLDmQPWXDIe3OklGFbO8WSoIcws94RoMxyPHla
        HD7R6COl/UD9OBdmsT4OjoASPFia
X-Google-Smtp-Source: AAOMgpdJLGeSS8jAM5Z67HSnbG+wzVBa+NqySdcwLlJDu3zqe5IbrJ6yvbfPHM592H9mJdFanRqqFw==
X-Received: by 2002:a65:594b:: with SMTP id g11-v6mr6960792pgu.260.1532210712062;
        Sat, 21 Jul 2018 15:05:12 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id e82-v6sm10676386pfd.40.2018.07.21.15.05.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 15:05:11 -0700 (PDT)
Date:   Sat, 21 Jul 2018 15:05:11 -0700 (PDT)
X-Google-Original-Date: Sat, 21 Jul 2018 22:04:40 GMT
Message-Id: <07ec215e83d73ab5d0cb6221c243b24d58694b6d.1532210683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v4.git.gitgitgadget@gmail.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
        <pull.1.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 19/21] range-diff: left-pad patch numbers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As pointed out by Elijah Newren, tbdiff has this neat little alignment
trick where it outputs the commit pairs with patch numbers that are
padded to the maximal patch number's width:

	  1: cafedead =   1: acefade first patch
	[...]
	314: beefeada < 314: facecab up to PI!

Let's do the same in range-diff, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 range-diff.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index ab1e71e10..347b4a79f 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -259,6 +259,7 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
 }
 
 static void output_pair_header(struct diff_options *diffopt,
+			       int patch_no_width,
 			       struct strbuf *buf,
 			       struct strbuf *dashes,
 			       struct patch_util *a_util,
@@ -295,9 +296,9 @@ static void output_pair_header(struct diff_options *diffopt,
 	strbuf_reset(buf);
 	strbuf_addstr(buf, status == '!' ? color_old : color);
 	if (!a_util)
-		strbuf_addf(buf, "-:  %s ", dashes->buf);
+		strbuf_addf(buf, "%*s:  %s ", patch_no_width, "-", dashes->buf);
 	else
-		strbuf_addf(buf, "%d:  %s ", a_util->i + 1,
+		strbuf_addf(buf, "%*d:  %s ", patch_no_width, a_util->i + 1,
 			    find_unique_abbrev(&a_util->oid, DEFAULT_ABBREV));
 
 	if (status == '!')
@@ -307,9 +308,9 @@ static void output_pair_header(struct diff_options *diffopt,
 		strbuf_addf(buf, "%s%s", color_reset, color_new);
 
 	if (!b_util)
-		strbuf_addf(buf, " -:  %s", dashes->buf);
+		strbuf_addf(buf, " %*s:  %s", patch_no_width, "-", dashes->buf);
 	else
-		strbuf_addf(buf, " %d:  %s", b_util->i + 1,
+		strbuf_addf(buf, " %*d:  %s", patch_no_width, b_util->i + 1,
 			    find_unique_abbrev(&b_util->oid, DEFAULT_ABBREV));
 
 	commit = lookup_commit_reference(oid);
@@ -362,6 +363,7 @@ static void output(struct string_list *a, struct string_list *b,
 		   struct diff_options *diffopt)
 {
 	struct strbuf buf = STRBUF_INIT, dashes = STRBUF_INIT;
+	int patch_no_width = decimal_width(1 + (a->nr > b->nr ? a->nr : b->nr));
 	int i = 0, j = 0;
 
 	/*
@@ -383,7 +385,7 @@ static void output(struct string_list *a, struct string_list *b,
 
 		/* Show unmatched LHS commit whose predecessors were shown. */
 		if (i < a->nr && a_util->matching < 0) {
-			output_pair_header(diffopt,
+			output_pair_header(diffopt, patch_no_width,
 					   &buf, &dashes, a_util, NULL);
 			i++;
 			continue;
@@ -391,7 +393,7 @@ static void output(struct string_list *a, struct string_list *b,
 
 		/* Show unmatched RHS commits. */
 		while (j < b->nr && b_util->matching < 0) {
-			output_pair_header(diffopt,
+			output_pair_header(diffopt, patch_no_width,
 					   &buf, &dashes, NULL, b_util);
 			b_util = ++j < b->nr ? b->items[j].util : NULL;
 		}
@@ -399,7 +401,7 @@ static void output(struct string_list *a, struct string_list *b,
 		/* Show matching LHS/RHS pair. */
 		if (j < b->nr) {
 			a_util = a->items[b_util->matching].util;
-			output_pair_header(diffopt,
+			output_pair_header(diffopt, patch_no_width,
 					   &buf, &dashes, a_util, b_util);
 			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
 				patch_diff(a->items[b_util->matching].string,
-- 
gitgitgadget

