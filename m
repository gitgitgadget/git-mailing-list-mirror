Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34C691F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeHKAqe (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:46:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44866 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbeHKAqe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:46:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so5113005pff.11
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ygTNx1JHniJf/DLFA6pbGdP74Vosb/+ARNkIfQ3eKk8=;
        b=thxF+txbmqTskaeo7uFu3Yoti6rSKR1bW/t/sndncyg4gKM/7Qp0O6epGjEWxRgna2
         5u5s0k76QrbNZTyl4qC8Gw+lyQXsxbuzAPJwJEHHKs2DTTUpnbzwVS1ovltLb/g1G5Tg
         vJtOdvUFbEMReDJICXWuiVYmB0ZppFXqsMAQPbhWM6SyAKv5f4C7hr+5Dib27VfaTivu
         IEegQsWYVPLWu5z0rHqDxo6NwOW3X9M1Tj4n1PwIDhj7kWFjk5HR/5mIlf8Wgq+D7F5h
         hL0F/R+XVI6/ZLSGDCtkDREd4RMZYP79IlSMZ7Fkk+J0OS6v4kMrKHxBXp+esIOXT/kq
         tKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ygTNx1JHniJf/DLFA6pbGdP74Vosb/+ARNkIfQ3eKk8=;
        b=g3yhzQyeLaWhbDShyo90uIFdjbmKk7Cdp/PHkG5iBhQ3E6rwRjzZPuewVX6maAVGdB
         NJRLZn6Ea4ZHdE+lgHmS6m57bakqLXqljfxJI1aYBa0oB1b1BJuRozz1Q0h9DXpOSOEm
         GxiadqBRFHSQMbGkf1vjGHu4CnHv96i2R4tMEn4OVovjs1BmeWIpYot7ndkkk0D7lNQg
         cOIqaeCnluHJNlXVOMn665rpfiyW/jxG5zu276ioo4Mi4NlcgphqhEsypR9gVMxfgG7J
         sIkP+IxNcom1RgQA2mh3xRovmGCdCDDODGTJZhwIxo2Bikc2Stt3/8ZSVeeKHbwhnR+U
         CR/w==
X-Gm-Message-State: AOUpUlGaSbDaQi2qH1gfx42SsCh0RntwxVChgBreCvj6oMZUUiTZczYU
        d1LXS6cowSTp2KWUxHImad0qcxOk
X-Google-Smtp-Source: AA+uWPyiwUIE6f6r8AuLmLhwj8LsI8ItCW2qwUQSpFXohmpIDEtVN5PU8XQq5I2TVGMZNzaK7j3k8Q==
X-Received: by 2002:a63:416:: with SMTP id 22-v6mr8100627pge.229.1533939288438;
        Fri, 10 Aug 2018 15:14:48 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id x7-v6sm18792401pgk.9.2018.08.10.15.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 15:14:47 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:14:47 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 22:14:17 GMT
Message-Id: <c32a24f6aa12950dbed6079160a3aa8b9e62dc4c.1533939264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v5.git.gitgitgadget@gmail.com>
References: <pull.1.v4.git.gitgitgadget@gmail.com>
        <pull.1.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 15/21] range-diff: offer to dual-color the diffs
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
index bc7a2fb76..da3ad3eba 100644
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
@@ -58,6 +61,11 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
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

