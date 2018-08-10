Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6F481F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbeHKAqY (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:46:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33208 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbeHKAqY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:46:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id r5-v6so4997773pgv.0
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=e7WJp/p/dShlR3175SV6lFfJvb0yrEIDwWgGS54qKik=;
        b=ModT6naIJI12X72Rj9Nxfed0AHe2d6PPsw4Cdtr2qy6+hpHY1CyO7YQTgDRN4tihcK
         duN6KQOQhhw7bSnlv4bnzQyHw/my0N2PKwtMp7ziSvdgOmNpFLsQsrVY2NhCbBzFNInN
         MMv9wkPb8LvsoLpzF2UeOY4N1CxyDH+YymKU7Ob0clf/SBXnOukopvFtWBWO25xv1B/X
         RLqE1IrqLccBiqy9sQh9PPk9LD3/2jYvAON79qKmcnwwEGNINOPHFR+UovDWbZAnRkCM
         Bap5hHcsZkQHOy+Oz+KXzNKmm0dhM+js6KJz5NxL9NUAQqV8GahYAUXuVu3Viz/0HqlM
         3CHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=e7WJp/p/dShlR3175SV6lFfJvb0yrEIDwWgGS54qKik=;
        b=qFLT+SjLO479f3W/+NldMTW1r9sFDVYRnQw+XiucPjdRBqVmw5WB8KluGugWyzPUHq
         5pWoayQS+Rc3bt8Y/iHumtLWuTFbh5keEOrQUgjObzm+2D7pV3XJLxmIMS4H0aLB8lA8
         llsidknV/YPMdmG/FAgYSiQxGRjvkzh3QlZ1UomiRHVjDrpfKPmehoeomRemNVUYqrFi
         xM5GxgIIGlmBrodkkusT0rU3S2WhHONUm8iHTJT/9Aw+YVlUBoEDoHGOIY6WIY1uWdS7
         yBn32N2grpjDpi6QPb3nFLd49gXTxqm0NlCdYYPDkOy188pe0r/F0xObQHWESugkUTEG
         kcew==
X-Gm-Message-State: AOUpUlHWNfEwmnlOZsXbP8qbkYvdkxUffABg4Zs5LPAQPDirswsI0t32
        qb4D7r0NUgAJNITiFRDI1JcXjqwL
X-Google-Smtp-Source: AA+uWPzQJfu4i59Ajkrz9A3rYuAGbU+1PKupIPExC6AT3HvD8yBAGIFpCpQFQ85vMIgdS9I3Y7kWLw==
X-Received: by 2002:a62:bd4:: with SMTP id 81-v6mr8791892pfl.67.1533939277960;
        Fri, 10 Aug 2018 15:14:37 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id i192-v6sm13850321pfe.188.2018.08.10.15.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 15:14:37 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:14:37 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 22:14:10 GMT
Message-Id: <eb94d1982ea06abd11ff3f2e120cf7b4ef09a869.1533939264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v5.git.gitgitgadget@gmail.com>
References: <pull.1.v4.git.gitgitgadget@gmail.com>
        <pull.1.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 08/21] range-diff: suppress the diff headers
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
index f6df3f19a..bc7a2fb76 100644
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

