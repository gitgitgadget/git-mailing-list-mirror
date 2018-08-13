Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 179771F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbeHMOPR (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:15:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37297 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbeHMOPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:15:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id n7-v6so7383442pgq.4
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 04:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UP+zTuYl4UH0qQkQ/Jb2UJAYrYPO5AJcBI1iwln+b9Q=;
        b=qH+2qrD+2L053z/j4WlxgiMoaFuiK1Gc1KKXlmZ5NeYQa2Rys0nDOyvAFycMp8KnY4
         4F808hq3Sq7g9WQJkAAHGfUtSdBguWEZA29sEjipiLddg19gJwkZCWTc0ApFc6k41fpI
         CDjq0mecQSpTNxRhAcLj2KFNizPOp9zeSZ+JjkALtuL873nz3N06jkDBw1ZuBcfaIM/H
         xcI5BQpC4DlRXUHmCCBTnL5LWqSyJF6hSf0sEoIWXsDN9DqHmAFUrXV1djDCC3fElwxe
         mH5YaZDGBf8S+v+ja6WmKZHVjvVMptJ8R2gBKZGThGkED94E/kYKJVh3mEfGssMB2cmp
         EBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UP+zTuYl4UH0qQkQ/Jb2UJAYrYPO5AJcBI1iwln+b9Q=;
        b=UDR+PDfs55jdnyfs7Lp5o89Har0+Bu26vAlY9LX2v3M5LRxWkF0JpeFCZvGBFnZtbd
         0WblXc7197196Pic6DWuoX763JoJx02dFOrpZSyoQODUjOxvbHqICdRJHk9Ni8shBPZo
         5UPjbcA+dBUZJvTrZQnibziLsbURNFainavJQo+APOGMIDcresCU75K+NxxVOXrKQfWF
         0N9a/NDK1iYDONbaqCJmePvsrSKSYNqksJNYjLostiYGs26fbxxKKUYEbfUFsJGeNG/O
         BpsvrdWK4xWc2LfnhRwCI8XxGpyjXorTVFF50Yl/hrlXVd9RAbgDFEBkGAYjJgcrXNrx
         G9gA==
X-Gm-Message-State: AOUpUlGkJC+xPFV2Q6ibXJ3VIVr7nbq9d8VO9WgvWI2pYM4lLlKGP4zd
        uTo7LhaAYxGEinrq1lDMBdo1EbgE
X-Google-Smtp-Source: AA+uWPxwDiWi0W9lUNzfEw78PBFr7Rwy6+KxLJPctMuEfeTOaeS3B2FeGvVDpmQ2qDt5TVpsT9AkDw==
X-Received: by 2002:a63:f043:: with SMTP id s3-v6mr15988772pgj.94.1534160003450;
        Mon, 13 Aug 2018 04:33:23 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id h69-v6sm39342647pfh.13.2018.08.13.04.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 04:33:22 -0700 (PDT)
Date:   Mon, 13 Aug 2018 04:33:22 -0700 (PDT)
X-Google-Original-Date: Mon, 13 Aug 2018 11:32:50 GMT
Message-Id: <3c7b9f339258fee12a1ea1184dc078ca5eca1cba.1534159977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v6.git.gitgitgadget@gmail.com>
References: <pull.1.v5.git.gitgitgadget@gmail.com>
        <pull.1.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 15/21] range-diff: offer to dual-color the diffs
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

When showing what changed between old and new commits, we show a diff of
the patches. This diff is a diff between diffs, therefore there are
nested +/- signs, and it can be relatively hard to understand what is
going on.

With the --dual-color option, the preimage and the postimage are colored
like the diffs they are, and the *outer* +/- sign is inverted for
clarity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/range-diff.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 76659d0b3..5a9ad82fb 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -20,9 +20,12 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 {
 	int creation_factor = 60;
 	struct diff_options diffopt = { NULL };
+	int dual_color = 0;
 	struct option options[] = {
 		OPT_INTEGER(0, "creation-factor", &creation_factor,
 			    N_("Percentage by which creation is weighted")),
+		OPT_BOOL(0, "dual-color", &dual_color,
+			    N_("color both diff and diff-between-diffs")),
 		OPT_END()
 	};
 	int i, j, res = 0;
@@ -60,6 +63,11 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 			     options + ARRAY_SIZE(options) - 1, /* OPT_END */
 			     builtin_range_diff_usage, 0);
 
+	if (dual_color) {
+		diffopt.use_color = 1;
+		diffopt.flags.dual_color_diffed_diffs = 1;
+	}
+
 	if (argc == 2) {
 		if (!strstr(argv[0], ".."))
 			die(_("no .. in range: '%s'"), argv[0]);
-- 
gitgitgadget

