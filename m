Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6EA91F660
	for <e@80x24.org>; Tue,  3 Jul 2018 11:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbeGCL0Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 07:26:25 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34871 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753203AbeGCL0V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 07:26:21 -0400
Received: by mail-pg0-f68.google.com with SMTP id i7-v6so843632pgp.2
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 04:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=jtmK+llqQ7M/RATmQ3o/ZekWn5y+wydb3yWNjByZS3c=;
        b=ms6WHIvu6JGeeq0/YeR2x9+MtNpWfSXViYhtY3YBrLK3NPZemcSP4qp+nBVMzHwWUd
         RdP54JbHrJg3qTFPHAsoyY8QVuCR7QyyVXfA2sUaXP71jgVbGvnntKe2zv+ByrEU1+jV
         mC3R7jlNkEc6hAs0U/OI5pWy9lKC/jr17puhDPpYqDQfYqznS+jTz9OsNIuSngN3Q/YG
         lPCtA2t26aok6PrOTV1m/1YpkSQcKPf0VKjwDDC26yDZ64q9GLHfcnHoaJM1iC15ornW
         6RTmXZ570ZoYNddZXR6LxdVL7ZbO4qzu/ueiOsXkh2r00m9SNxWIRcivQYJYErx9SltD
         Plkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=jtmK+llqQ7M/RATmQ3o/ZekWn5y+wydb3yWNjByZS3c=;
        b=LhCSkr2bkgqH79n2IknDNTffikjDiyTLikkcL/AQ7DcRKEdv38bqgE5HL8xxcEPs1Z
         7LsaDIrGR2l8w77Spkc5bhJjaGuEdoDgEWGakJU4sKiwLRC2/omkkYDYMN1+l0LIwVF4
         X9ccuY4ViaxWC5hSJq76SMEFFwa+mB2XrZoRLBhh+B40dkgKeT8k9q7tSuFKJY/WmREC
         PBtGE+fSfbrRCO+OdSBowGCToe5KglapbmIAHbZy9gaTZVNOWl8E8/J0s2B1WfMG53ug
         jYJ4hBNoUEU8hCXvRaLyJet2uHwB0Q03+A1cWT2TcgjaiSQPfGdBeEOQoBrsmTq3JS8G
         M/Xw==
X-Gm-Message-State: APt69E2VNjhqdABWgi8+MqwsyB91qTgC9wF+F9tuhkI3k8XFqmVIVHoR
        JsSWbsAqXsH6YDlJJILUcnRPjQ==
X-Google-Smtp-Source: AAOMgpen1tSzJZHXI8KVcTgrq8UomFrlw371PaQhkuapS3cISOhXzWXiSrICnLLb4th6Czo8OIorGw==
X-Received: by 2002:a63:4386:: with SMTP id q128-v6mr19039086pga.353.1530617181136;
        Tue, 03 Jul 2018 04:26:21 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id a20-v6sm1779618pgw.91.2018.07.03.04.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 04:26:20 -0700 (PDT)
Message-Id: <80622685f9bcc81bb93ad60d27b05c2d6c031e4b.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v3.git.gitgitgadget@gmail.com>
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 2 May 2018 16:53:50 +0200
Subject: [PATCH v3 08/20] range-diff: suppress the diff headers
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

When showing the diff between corresponding patches of the two branch
versions, we have to make up a fake filename to run the diff machinery.

That filename does not carry any meaningful information, hence tbdiff
suppresses it. So we should, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/range-diff.c | 1 +
 diff.c               | 5 ++++-
 diff.h               | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 660e1f961..7c0967220 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -33,6 +33,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 
 	diff_setup(&diffopt);
 	diffopt.output_format = DIFF_FORMAT_PATCH;
+	diffopt.flags.suppress_diff_headers = 1;
 	diffopt.output_prefix = output_prefix_cb;
 	strbuf_addstr(&four_spaces, "    ");
 	diffopt.output_prefix_data = &four_spaces;
diff --git a/diff.c b/diff.c
index 639eb646b..8c568cbe0 100644
--- a/diff.c
+++ b/diff.c
@@ -3189,13 +3189,16 @@ static void builtin_diff(const char *name_a,
 		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
 		memset(&ecbdata, 0, sizeof(ecbdata));
+		if (o->flags.suppress_diff_headers)
+			lbl[0] = NULL;
 		ecbdata.label_path = lbl;
 		ecbdata.color_diff = want_color(o->use_color);
 		ecbdata.ws_rule = whitespace_rule(name_b);
 		if (ecbdata.ws_rule & WS_BLANK_AT_EOF)
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
 		ecbdata.opt = o;
-		ecbdata.header = header.len ? &header : NULL;
+		if (header.len && !o->flags.suppress_diff_headers)
+			ecbdata.header = &header;
 		xpp.flags = o->xdl_opts;
 		xpp.anchors = o->anchors;
 		xpp.anchors_nr = o->anchors_nr;
diff --git a/diff.h b/diff.h
index dedac472c..928f48995 100644
--- a/diff.h
+++ b/diff.h
@@ -94,6 +94,7 @@ struct diff_flags {
 	unsigned funccontext:1;
 	unsigned default_follow_renames:1;
 	unsigned stat_with_summary:1;
+	unsigned suppress_diff_headers:1;
 };
 
 static inline void diff_flags_or(struct diff_flags *a,
-- 
gitgitgadget

