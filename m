Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3F361F597
	for <e@80x24.org>; Sat, 21 Jul 2018 22:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbeGUW7X (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 18:59:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33722 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbeGUW7W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 18:59:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id r5-v6so9549699pgv.0
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 15:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bP/ld/3Q7zUcJZprWR7XksCBB7vlt+absA6Ivt6yorI=;
        b=u+/+ggXk+2h69iCwNldhobLYNmnsvRnfRmiG/a9eQImQOTFPibKVpZus7Y4t25BXZF
         UuAlJ9BuKXXW4fcEPvof6ddKlkD7xlLYTtVel6Ln9jrdmtxs8UXw4ABhrzKUfs5iz27G
         fjQ/yvtrzgVVmjUa/DDCC9IBgTjzzsk2ir8wUrhLnnvbUt6jeER/r1AL5sFeXlmQoBgE
         MnUyQldSQIC8V5qkLB52orMbi+/YuaqIA03qHvyugOyoEOsoGBxvJ1DkYEwFn09nwo2f
         ZC2kiA6CzZPDpTxVZInD7al0te39551pRXhKGf0Ak3eeq7breR0DNMCpVGcr3VpW9ENJ
         W32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bP/ld/3Q7zUcJZprWR7XksCBB7vlt+absA6Ivt6yorI=;
        b=DTBXJeL5sq1JgnuTiX5arY6sTzz/JqBlqQHhSfdvTXuLHGfbEEOkzGYt0gLO+yTwr2
         lndDr0VO0hc6994nUgmAyqri4exBFwzEI4V5S30WrXeEr3KMOiNvsEp2emITamgNPXOu
         DDTnnof2VOctHX4KQ+SespghmFB5ZuOSMgLFGa0GxmkZ8aHFOZ2InN7TUzcSR0gj0RIS
         ycbY0AIPNCT/G5tdT4AOybrGlHv5GTpTKpTPSrENv4p6YD2vOY6j8HxUVHFrCLBQw8OO
         SuNqK4hRWheYGoKkNNWPHr7yCKuOlxBQNHky4VXS5S/V5R4YvZ4k70MrxPDon5UeGP7H
         cLyg==
X-Gm-Message-State: AOUpUlHEh2Ob41HxhfDl5XDFfu72/h/J8nm206GWM6U0PUmZCkOBaOPz
        s/J1xgiIMnSSCHsn85DjQKtwsWjG
X-Google-Smtp-Source: AAOMgpckEJN8NWKvJtU7R9cXj+1zYBQCxx/B2ZT/X1GFMk1/SWUHXDjCp0aZvMGgABohiQBJyy3mUg==
X-Received: by 2002:aa7:8118:: with SMTP id b24-v6mr7364464pfi.78.1532210706456;
        Sat, 21 Jul 2018 15:05:06 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id v1-v6sm6489925pgs.89.2018.07.21.15.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 15:05:05 -0700 (PDT)
Date:   Sat, 21 Jul 2018 15:05:05 -0700 (PDT)
X-Google-Original-Date: Sat, 21 Jul 2018 22:04:36 GMT
Message-Id: <21b2f9e4b90a7e25ced8ce561a22aae1a419401a.1532210683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v4.git.gitgitgadget@gmail.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
        <pull.1.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 15/21] range-diff: offer to dual-color the diffs
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
index 10065315d..c25d88317 100644
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
@@ -52,6 +55,11 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	argc = j;
 	diff_setup_done(&diffopt);
 
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

