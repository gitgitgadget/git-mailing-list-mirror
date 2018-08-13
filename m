Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22B441F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbeHMOPF (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:15:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44537 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbeHMOPF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:15:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so7514734pff.11
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 04:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KoWJnliQT4jiXuo7wGM3LBeN9THxjB0pobP1OLXdrRQ=;
        b=p8LtRBtcBQFZyyvgGUV1u1pPkqWNS/WOVgQiedL59bxfNUjdn88pxNlmNj/dOqdtZG
         0EB3Nh1Hrhj4L34dKDvpT1ALv6fsBDk2AD6yQsFvbZc+EciLriOiB98H5EGEmD0iXAHV
         4LPe04h3yT2LtbvwFYufRC4lTBck8QBPj06FieP0ziA5BgSJIAFpfdOmzFXmUx7zQNKf
         XkCZv43FSSxp+8CHia3sYHXigmgtAS8HLKuuH4ku2tDcTXkAjnXaC6HV7M9Va80dWlqF
         7COFFhLefENTRdzZ57xTlvu5xaw8FIOetPcLocY1d9TYySrQtHN8p2FfWMzngfdfvZEl
         yfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KoWJnliQT4jiXuo7wGM3LBeN9THxjB0pobP1OLXdrRQ=;
        b=LIPPgYIheulRLwEJg15wK25SNADt/rAM3cF1+PuBOj4C6Mbg6xlf/K0UY42mk3QiZd
         JkHt0JVcDgPn1PP6C/xT76OItzy0UHpkIkIl/1Cu9fcXmun8ioswrTbrTJN+ppJS37Ve
         pVFxng49ZON//dYhXcL+d4bsrq4FtIYQ0EU+PqMuqdtRwxuOixBqOVYGWKE5p5jNztfr
         etdVTExD8niCNA5yqe7frTLlX0KQnV6FJaSfL1T3gl0yCmrtTCr/tfrjV02oEjVcZdMS
         VQ0t9ZQWmZch7bJZhK5+vwJLB1Yu2x70uBQ9yQLkr3zBp9oL/lrAvudFNB1/IP7Vc2hI
         2plQ==
X-Gm-Message-State: AOUpUlEQe0/NLmJSUR099ikJvKs4iGgwTVLBJIZ8s1/45hyHc8UsaEKb
        fuibiV6h7zVN6dQjwHGAOj4uJmkW
X-Google-Smtp-Source: AA+uWPzIYX853zRbDM31EAX7FUgl1Gca1K3LjwKObxnla9mkjq0PesLFCBp5/1tDw5Bt2hqL7+vodQ==
X-Received: by 2002:a62:411a:: with SMTP id o26-v6mr18457286pfa.111.1534159992619;
        Mon, 13 Aug 2018 04:33:12 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id l10-v6sm24855454pfj.179.2018.08.13.04.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 04:33:11 -0700 (PDT)
Date:   Mon, 13 Aug 2018 04:33:11 -0700 (PDT)
X-Google-Original-Date: Mon, 13 Aug 2018 11:32:43 GMT
Message-Id: <458090ffd23115545c999aeef952e2e29ee628f0.1534159977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v6.git.gitgitgadget@gmail.com>
References: <pull.1.v5.git.gitgitgadget@gmail.com>
        <pull.1.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 08/21] range-diff: suppress the diff headers
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
index f0598005a..76659d0b3 100644
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
index 04d044bbb..9c4bd9fa1 100644
--- a/diff.c
+++ b/diff.c
@@ -3395,13 +3395,16 @@ static void builtin_diff(const char *name_a,
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
index a14895bb8..d88ceb357 100644
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

