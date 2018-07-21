Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A08A1F597
	for <e@80x24.org>; Sat, 21 Jul 2018 22:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeGUW7N (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 18:59:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35297 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbeGUW7M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 18:59:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6-v6so9548154pgv.2
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 15:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PjDSr5eoIg+ZoWhHjy/jCltI+C5auo2cZgHyXJaE7u0=;
        b=EavLZ9xOMZqIM2+bi4hect22eL/NnpkzA6Kdw59KAfDoaoecOm+dZt8N+HhYYw9WXG
         mugAR7PVLCx9GOb0PAHxMXTOUtZV0chwdqnYTalITPmwTMs7fLaVULcjWEb2NrXTjw8U
         3VPXquOKee6VVNN1Ie4oR4zfOaPwJM/68+b1DaMQRB4seBGO68jZyn67j6l12UZc/7xY
         Klln3I2ZAa5h39ZDSQeK83AAESie95Qx+3P+eQvgKop866naIuBXVnhisDrApWIWnwvI
         NySw5EWIM0Vl3AbiPcGd9DK7CrzN+A0aLu0o6GtgHcvxaAiDsP6U0+IQ+yVH6SRrIXvW
         0CXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PjDSr5eoIg+ZoWhHjy/jCltI+C5auo2cZgHyXJaE7u0=;
        b=h980PtiwJKzqskRmSbTIzXnMXE/j3cY4D6zxoTzn03VZJoAoNoN5fToW+a+KETJoIS
         BGHUruBlaTNbEG+m4kRwIaeOfpRRv7pGimjmrFgDd4OTaVZH3FCW2IN2VUZc/t8SpET9
         88Rk3Zj6n9fjZSDSvjw7LSBWBZlnAEQOjAozYw3IIJSwWFb+xnpRi+KuvnFMdzjlM1vs
         GjmUC6n0zNYA4MyyjJBSjrdJInCmPCBqVypD02vCzfATrkgtX2XcYkW3AcNuhwNfCX6w
         0h3gCxX3Mn/f8W7NVPR2WWjRiG37yctZlk2rH8DXcNiY44lrfzHYJakprJMIxD9cEBkL
         FP+Q==
X-Gm-Message-State: AOUpUlHSvVBLDHsZSl/kjXvD2ku/ONK4RqDTKA+dyPM395y2jy4H6POL
        zJlNTxMtMviGyRlwjuVXLUbHUlqb
X-Google-Smtp-Source: AAOMgpf9/wN6/3zksLKU8n93nwlwsxZ7uHDEjcdulRwrlWjwES1hofB7DSJtXn4wtm9P+bEYW5kdQw==
X-Received: by 2002:a65:46ca:: with SMTP id n10-v6mr6866108pgr.345.1532210696765;
        Sat, 21 Jul 2018 15:04:56 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id 70-v6sm8087450pfz.55.2018.07.21.15.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 15:04:56 -0700 (PDT)
Date:   Sat, 21 Jul 2018 15:04:56 -0700 (PDT)
X-Google-Original-Date: Sat, 21 Jul 2018 22:04:29 GMT
Message-Id: <61b2ff2f7e28b685b50c1599fa80d462e1e236d9.1532210683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v4.git.gitgitgadget@gmail.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
        <pull.1.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 08/21] range-diff: suppress the diff headers
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
index 96e8bf841..10065315d 100644
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
index dc53a19ba..a94a8214f 100644
--- a/diff.c
+++ b/diff.c
@@ -3190,13 +3190,16 @@ static void builtin_diff(const char *name_a,
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

