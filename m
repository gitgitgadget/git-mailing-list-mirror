Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5FC11F660
	for <e@80x24.org>; Tue,  3 Jul 2018 11:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932079AbeGCL06 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 07:26:58 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45585 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753248AbeGCL0b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 07:26:31 -0400
Received: by mail-pf0-f196.google.com with SMTP id y24-v6so869654pfe.12
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 04:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=h58e79OUrb+FhiMTIlpdZSfYqBeU2b8HrhrIpkJIop4=;
        b=jES9UPvZfP1lfl8QaT2FM8UyWGVDv1rFGDcVJ7ZLexvlir10DqKecKVtsukfpTp9XP
         3K75+OSes6FBO2XwTEagwQn+BmNLXMpnHeDummd7QKQK0Rg4FDG0g43z9mt3PIH99Ms8
         YvYod0iSFUvqAPnHY5xKN96uS+l+5DNcik+WaUmlgBuf/DjdcL9D/Opw8izl5TdaySe1
         JoDjAod4U+PyTbe1LPTvWSCgNOqHbq+pS93YpplHZnRELSmuF8wGOTYD44a/bkIknXp/
         QGK1h/vzOTb6+kjjqMvaTW0eQmGWpPLcERsb3Dx38mjDhNXVt4bwi3Z8uo8bSrH9wYDz
         xSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=h58e79OUrb+FhiMTIlpdZSfYqBeU2b8HrhrIpkJIop4=;
        b=HLGGHyMAktXR6vAw7SEunTqM9fyroZXl4vv1C7jTzWeDR9XjHNRcaUERrSup0E7nLF
         MAnn1B8ir7orHmY1QAL0SSIf503bgmpCd7KDd6VONDzc0NubeLON8TsWK0N96KbKzMON
         0ZEDEe+JogAWoglpDDdR2hG1MYkVxIUKQm7+jsl3z7rCiysNTC9dsicYvDE40pBMxsDo
         F5n72oJtJRgx3Fc3N4LAp9DYL66Z3crkbpuHaVkkF775giCvlh86VzxoItr5r68QX52M
         CsDpCTNFL+J90hkZDgsbWVs1dJxRwrUL7NQwMddf+xF5X/tCSDufAaEF0V7i2qFjqdZZ
         FgnQ==
X-Gm-Message-State: APt69E3INuSE+pV7TdfR8E2qJXUzVrTpiX+KSbKifPH92o1B1iu9Vmc9
        kBocaBVqMLu8piAnjsaJFonV5A==
X-Google-Smtp-Source: AAOMgpdh552k1aSrUEpLNmSRA8qxQcDhZxgQRWMqw6HHKjmi7hqSUKn58Do+E5pScmKuNZN1ItRgvw==
X-Received: by 2002:a63:3509:: with SMTP id c9-v6mr17606389pga.237.1530617191087;
        Tue, 03 Jul 2018 04:26:31 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id j133-v6sm2111322pgc.75.2018.07.03.04.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 04:26:30 -0700 (PDT)
Message-Id: <02e13c0c6836bb0d16e0241df5ae8907b6fb4c4d.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v3.git.gitgitgadget@gmail.com>
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 3 May 2018 03:01:00 +0200
Subject: [PATCH v3 15/20] range-diff: offer to dual-color the diffs
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
index 7c0967220..e8f7fe452 100644
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
@@ -50,6 +53,11 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	argc = j;
 	diff_setup_done(&diffopt);
 
+	if (dual_color) {
+		diffopt.use_color = 1;
+		diffopt.flags.dual_color_diffed_diffs = 1;
+	}
+
 	if (argc == 2) {
 		if (!strstr(argv[0], ".."))
 			warning(_("no .. in range: '%s'"), argv[0]);
-- 
gitgitgadget

