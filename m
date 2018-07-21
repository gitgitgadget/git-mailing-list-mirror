Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 178BC1F597
	for <e@80x24.org>; Sat, 21 Jul 2018 22:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeGUW7N (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 18:59:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44050 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeGUW7L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 18:59:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so297213pff.11
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 15:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4I/tgP1D/I8b5MoKxkkbsEyBBePCwRp3AvOA0X6EyWQ=;
        b=Ck4Xv2Q38LPPQ4umMxMkI2Hb5FxqU1EOgRGSh7EqK3JC9b05kh7etzZNzZ/++AsiwS
         +PG4MNPaJc/tOBjypvlKAl5ONPZ0EVgyNk2qo/zzaTBoKSDnrssuZScxEd9tM2tbRu9r
         i2rbnndOUBNogiVHaJvEy4jhRciKuvAMSndYTPSwKIVJA5AWPRJWL3XKq+tZ9d+AFhOG
         KSUuaxfKThsTXXMOm+EYhtZ5mcXpkfBnYwqPnSijJPlAz1dMHUYHCm3qwwQSAwS1CUHZ
         P3lX2PhtgyJ0mlBVZJ53A6jdX8Q5W8bcOBZkboEky65ejzNPlLCFSMB4LjRBGkNOwcAN
         tWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4I/tgP1D/I8b5MoKxkkbsEyBBePCwRp3AvOA0X6EyWQ=;
        b=eRaGFBtg4Lgdz6/zHmxXht+jtzERHv/7QxbRL91E/YuzKeEfyvDihXM45CFv0Ux6YJ
         Cdyidnh7kJY5KxEHKF1IBQIQDjrtUZc68Cbg2vcg13UAWbE0+Yicp+4AjVDXv5+qfKuw
         IkE0Rlux1nUaP1tZ5c86gcx3GORX8M8sJiqPTXSxYVGQ2xrcz/zmEafxPgMjaf8AVBdc
         0iroDyJ0lyoIAz6DImLykITPmfTblT1mQHv7hlaJ+xDczky/cYuRhBtyFOh8Ac1MElUC
         rvUV4Q0gAHA/qji2/g3mvIg9sZ0bW0+DvL+J88e35JobXxl1/Bmm4OZfSWEN8Kba2KZW
         Ctow==
X-Gm-Message-State: AOUpUlF1hfBqMqCU2xu2nSqa8PiRULVSsgvSkdxemMomerArOcdvciBH
        TXzZO3xSpgujGjt0KPgYWSG02bf5
X-Google-Smtp-Source: AAOMgpd+Zv+5YwrD4YyvdeE37W7puiAYm8zzEWfabW15gUsx7D3Bn4Ppk6GIjVOX8YRCbvr1qvciKg==
X-Received: by 2002:a65:448c:: with SMTP id l12-v6mr6600449pgq.277.1532210695414;
        Sat, 21 Jul 2018 15:04:55 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id 16-v6sm10225528pfo.164.2018.07.21.15.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 15:04:54 -0700 (PDT)
Date:   Sat, 21 Jul 2018 15:04:54 -0700 (PDT)
X-Google-Original-Date: Sat, 21 Jul 2018 22:04:28 GMT
Message-Id: <a3dd9950982626f5cf5f64e0f76ed9e1f223f0ea.1532210683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v4.git.gitgitgadget@gmail.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
        <pull.1.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 07/21] range-diff: indent the diffs just like tbdiff
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

The main information in the `range-diff` view comes from the list of
matching and non-matching commits, the diffs are additional information.
Indenting them helps with the reading flow.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/range-diff.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 093202117..96e8bf841 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -11,6 +11,11 @@ N_("git range-diff [<options>] <base> <old-tip> <new-tip>"),
 NULL
 };
 
+static struct strbuf *output_prefix_cb(struct diff_options *opt, void *data)
+{
+	return data;
+}
+
 int cmd_range_diff(int argc, const char **argv, const char *prefix)
 {
 	int creation_factor = 60;
@@ -21,12 +26,16 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	int i, j, res = 0;
+	struct strbuf four_spaces = STRBUF_INIT;
 	struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
 
 	git_config(git_diff_ui_config, NULL);
 
 	diff_setup(&diffopt);
 	diffopt.output_format = DIFF_FORMAT_PATCH;
+	diffopt.output_prefix = output_prefix_cb;
+	strbuf_addstr(&four_spaces, "    ");
+	diffopt.output_prefix_data = &four_spaces;
 
 	argc = parse_options(argc, argv, NULL, options,
 			     builtin_range_diff_usage, PARSE_OPT_KEEP_UNKNOWN);
@@ -80,6 +89,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 
 	strbuf_release(&range1);
 	strbuf_release(&range2);
+	strbuf_release(&four_spaces);
 
 	return res;
 }
-- 
gitgitgadget

