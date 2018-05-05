Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DDB41F660
	for <e@80x24.org>; Tue,  3 Jul 2018 11:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbeGCL0o (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 07:26:44 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:41707 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753203AbeGCL0h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 07:26:37 -0400
Received: by mail-pf0-f175.google.com with SMTP id a11-v6so873547pff.8
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 04:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=KQfjAxhwz7dfhUC08ke+kiwVti5J8pUOyR9Xdx6BaRA=;
        b=d7/dyeQMBXLNXja6XrICd9EC6dV29datmdW1BJZylUKapms1ZPb9F0TdFdTxxcdap4
         xIswm8GcGtYXM9CC4dR0aHT71w28ftXDzrHB58DNUze8trJtXnENlISP8hEsqByySEVM
         W1xn0KIWEkjwdkDEPJRkCtTcxq8UCebKPbdTj2sIL9sF6178k2WNEL0WjCJD5cfJeKUL
         b+bmBiPN95A8aAv6r8l/4QzAoRBrx0ljMYiIaq8GwIka/k6MgSKIoMpCwEWB/3AA2cWl
         bIW+/daitCs1YotNKjPWpVyqziKRXqQFyK/E9h94WuiXz9ab78091SEiX8505/X4GndU
         18FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=KQfjAxhwz7dfhUC08ke+kiwVti5J8pUOyR9Xdx6BaRA=;
        b=ib02OZGPOm0a7FHvzn1Bovof2OyEIHWR6ioAFa7pclqTFOskPJWJpO4o+Ezfx2geR2
         OuEYgAZWBaDwczcxo2QmY1UnUlTEMU4YTCmKMXNP9pZ01O6nOomzRIBKY7JtEx4aA+EB
         F3MR0R66+DNRKSQjlRdm/TEnQ/BIQgYi6+QqD/fPqA9459t9WD8QXfA8+fx4dzIHjMp1
         9mlV31zhDKe9LqWJSR1qDcykx6Tsol2gju4gh7XRoIeCMX3tcNGljKsqL2bLlhhakM0m
         Er7Nh/+kX7EsyMyFYdOW2er752SkZYcmFtTFQ7NSxIlwQgLCKD+Yz1N0W23mKk0Hd38s
         lUwQ==
X-Gm-Message-State: APt69E1t50oPo0K8CHK54RLcu7owsUWEKywCuUY/CkYA8XDOE1eDGkC8
        A8rVV7DvD3+PNdODzxwMlV/liw==
X-Google-Smtp-Source: ADUXVKIB4hHMcLppSo/wPI2xc7f1kZL0pM9sKj1xain7I6x9zz3PFJ93iki6vQ4GHTjScI7hCELGzQ==
X-Received: by 2002:a65:594b:: with SMTP id g11-v6mr25723015pgu.260.1530617196650;
        Tue, 03 Jul 2018 04:26:36 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id u15-v6sm3256030pfk.174.2018.07.03.04.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 04:26:35 -0700 (PDT)
Message-Id: <144363006cf79624ace020c1856bfd760bdb2c62.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v3.git.gitgitgadget@gmail.com>
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 5 May 2018 21:52:20 +0200
Subject: [PATCH v3 19/20] range-diff: left-pad patch numbers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
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
 range-diff.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 870c3680c..d3e51bf36 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -254,7 +254,8 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
 	free(b2a);
 }
 
-static void output_pair_header(struct diff_options *diffopt, struct strbuf *buf,
+static void output_pair_header(struct diff_options *diffopt, int patch_no_width,
+			       struct strbuf *buf,
 			       struct patch_util *a_util,
 			       struct patch_util *b_util)
 {
@@ -293,9 +294,9 @@ static void output_pair_header(struct diff_options *diffopt, struct strbuf *buf,
 	strbuf_reset(buf);
 	strbuf_addstr(buf, status == '!' ? color_old : color);
 	if (!a_util)
-		strbuf_addf(buf, "-:  %s ", dashes);
+		strbuf_addf(buf, "%*s:  %s ", patch_no_width, "-", dashes);
 	else
-		strbuf_addf(buf, "%d:  %s ", a_util->i + 1,
+		strbuf_addf(buf, "%*d:  %s ", patch_no_width, a_util->i + 1,
 			    find_unique_abbrev(&a_util->oid, DEFAULT_ABBREV));
 
 	if (status == '!')
@@ -305,9 +306,9 @@ static void output_pair_header(struct diff_options *diffopt, struct strbuf *buf,
 		strbuf_addf(buf, "%s%s", color_reset, color_new);
 
 	if (!b_util)
-		strbuf_addf(buf, " -:  %s", dashes);
+		strbuf_addf(buf, " %*s:  %s", patch_no_width, "-", dashes);
 	else
-		strbuf_addf(buf, " %d:  %s", b_util->i + 1,
+		strbuf_addf(buf, " %*d:  %s", patch_no_width, b_util->i + 1,
 			    find_unique_abbrev(&b_util->oid, DEFAULT_ABBREV));
 
 	commit = lookup_commit_reference(oid);
@@ -360,6 +361,7 @@ static void output(struct string_list *a, struct string_list *b,
 		   struct diff_options *diffopt)
 {
 	struct strbuf buf = STRBUF_INIT;
+	int patch_no_width = decimal_width(1 + (a->nr > b->nr ? a->nr : b->nr));
 	int i = 0, j = 0;
 
 	/*
@@ -381,21 +383,24 @@ static void output(struct string_list *a, struct string_list *b,
 
 		/* Show unmatched LHS commit whose predecessors were shown. */
 		if (i < a->nr && a_util->matching < 0) {
-			output_pair_header(diffopt, &buf, a_util, NULL);
+			output_pair_header(diffopt, patch_no_width, &buf,
+					   a_util, NULL);
 			i++;
 			continue;
 		}
 
 		/* Show unmatched RHS commits. */
 		while (j < b->nr && b_util->matching < 0) {
-			output_pair_header(diffopt, &buf, NULL, b_util);
+			output_pair_header(diffopt, patch_no_width, &buf,
+					   NULL, b_util);
 			b_util = ++j < b->nr ? b->items[j].util : NULL;
 		}
 
 		/* Show matching LHS/RHS pair. */
 		if (j < b->nr) {
 			a_util = a->items[b_util->matching].util;
-			output_pair_header(diffopt, &buf, a_util, b_util);
+			output_pair_header(diffopt, patch_no_width, &buf,
+					   a_util, b_util);
 			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
 				patch_diff(a->items[b_util->matching].string,
 					   b->items[j].string, diffopt);
-- 
gitgitgadget

