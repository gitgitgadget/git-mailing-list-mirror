Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2A8F1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeHKAqk (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:46:40 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:44987 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbeHKAqk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:46:40 -0400
Received: by mail-pl0-f43.google.com with SMTP id ba4-v6so4566828plb.11
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lHzzfZ8VMPcrUk1+h3rhdw/7G97WHjeDoH+G9YKYg00=;
        b=fK4DDNEUvFOo1chrZ7KbheocYqjrBvhhPZPqLFQF9fCjsbvQfgHfQRXNnpLKp0EHYJ
         w9G4S+rFWsqaQmtMM1nX8pL+nD9oUsz9MCMfT2fVMsbkjU4HM7t8FdMNMohEq1WbjDnd
         Lrftg8wkN3SWkrSSsWyWg2ktXQ2bo9yaQBQhWrNYXU/fSIL1/hfc07pLC7WLL8UALwPE
         sEB0pLIZLaiFXE6xqmQ47z0/MDptoNdv0B1lG2NFXjL8xw3Pw0ud/XeZWgcNwvPu/qeh
         WPMeRX6WHoF9Lwm9SEsm9DBkcrRsJDFliNqtzd8UXBf2QutVGwEm50vfxCrDN5/JO97N
         yD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lHzzfZ8VMPcrUk1+h3rhdw/7G97WHjeDoH+G9YKYg00=;
        b=qv8GeWKMTcRq+LvWGGeu1EVWQfVVknd66aqgXjQJ+lY6hz6kZli2jH+Phe2vNiTrW6
         ywhHneIthNYpzSyd69YL8//dI9S9ux+A9cHxSMP8J1oGWmMXKI94oxzim1KH0AzdhT6B
         3slk/GOvMQ32KXu56gt9oCYD6T9SZBibfNM0e9M8iZ0ngQFTJI/4yAlM+o48gyazxNRE
         b9s7ljXgt8u8XJBGd/8D/2s5/WlaK6mMh53A3jfDTGUM1Wde/u92mrcyNXr4zuMjT4Su
         UfidBEF0Q/NMCwwdDjLAL1bDkIHRZlXOqyrvhBso9B/ly+pfXVvcath8Pke2wlhZhuSB
         TuUw==
X-Gm-Message-State: AOUpUlFgxvxKe02Oqfx2gOaoQ45G2jolO3GYVEiWDwkQjgh/c5bwctlg
        JT1kndWicNFi9IyPuRxAuC3m5qcl
X-Google-Smtp-Source: AA+uWPwB/Dj5WiP5+/H4/pcyHmpPl8NdDNtWcVgPqDG5EfgXHWBavWX22XvInVvkikiXBTC1IDgp5w==
X-Received: by 2002:a17:902:3204:: with SMTP id y4-v6mr7689956plb.195.1533939294452;
        Fri, 10 Aug 2018 15:14:54 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id n24-v6sm18972511pfi.161.2018.08.10.15.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 15:14:53 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:14:53 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 22:14:21 GMT
Message-Id: <19406283e3f30803b9c6f502a9e9a8820b6ede61.1533939264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v5.git.gitgitgadget@gmail.com>
References: <pull.1.v4.git.gitgitgadget@gmail.com>
        <pull.1.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 19/21] range-diff: left-pad patch numbers
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
index b1663da7c..b6b9abac2 100644
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
 
 	commit = lookup_commit_reference(the_repository, oid);
@@ -357,6 +358,7 @@ static void output(struct string_list *a, struct string_list *b,
 		   struct diff_options *diffopt)
 {
 	struct strbuf buf = STRBUF_INIT, dashes = STRBUF_INIT;
+	int patch_no_width = decimal_width(1 + (a->nr > b->nr ? a->nr : b->nr));
 	int i = 0, j = 0;
 
 	/*
@@ -378,7 +380,7 @@ static void output(struct string_list *a, struct string_list *b,
 
 		/* Show unmatched LHS commit whose predecessors were shown. */
 		if (i < a->nr && a_util->matching < 0) {
-			output_pair_header(diffopt,
+			output_pair_header(diffopt, patch_no_width,
 					   &buf, &dashes, a_util, NULL);
 			i++;
 			continue;
@@ -386,7 +388,7 @@ static void output(struct string_list *a, struct string_list *b,
 
 		/* Show unmatched RHS commits. */
 		while (j < b->nr && b_util->matching < 0) {
-			output_pair_header(diffopt,
+			output_pair_header(diffopt, patch_no_width,
 					   &buf, &dashes, NULL, b_util);
 			b_util = ++j < b->nr ? b->items[j].util : NULL;
 		}
@@ -394,7 +396,7 @@ static void output(struct string_list *a, struct string_list *b,
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

