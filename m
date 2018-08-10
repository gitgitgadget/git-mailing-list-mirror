Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 162D61F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeHKAqW (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:46:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35378 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbeHKAqW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:46:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10-v6so4997816pgv.2
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VhV/vbDakN9EhHRG3aWx/Me5/PpYkKWEhx75dYuYVi0=;
        b=Zdta/jwR/BU6f/tZqvklbp++Wka5ZiBY96MBLTHEUb6/ygBTMSOoGThIlZzxpScGcI
         CnwSlrFOQXjwK4W7iWQWgWyFwhqDBwkH6x7wPCPIJfPugT1N5Lc7qF6zKI7Fi4y14eXu
         miEZEdWHRxWEkMejnNKMDt8GI+CrPvJ97RAmR4RbnRagpsMrT7SNgeryAPVJhqtKXh/R
         JXXgd+01PO6/uueEqaXqBex1bNe6bVXumKAr/NBKG361xaBOuT5v68TbI8aZEZ5fvcTQ
         2va9H0eA4esYHN4aLlwGF74F/yIISw2vunnTutsxr2x9hIF3wKSPG7RLLx6kPKc+dv5g
         RPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VhV/vbDakN9EhHRG3aWx/Me5/PpYkKWEhx75dYuYVi0=;
        b=qwXJuIVNW116Ervw8kB6k19hQovzhUycE0o3THRkldT1CUXuczZiKnLfJwdcziEtVK
         kzZs68CcGAzolmYtgXmMAP1AV0aQQwwgyDDAKKyC+Y76cTVPIv581RvrIgKPH12Wl4X3
         a2gkgYsziKSH2qonnXhMzvK3b0VTG5gmvi4QVvlGCFsUm6JLgYq1BQiDO1e/hv/W83RN
         zSNf7ZAKATTUW/TP8XIVb1H995he6JEoRJ3wBqNFL+jJOJf0VhS04V60gXTqamz1n6+W
         NFf17SQpTQEyrvIJo+ul8UOUeNTI2BwDvITXborgtfp6xlgANsNY6Pdat0ZReSrqIg1B
         Nvaw==
X-Gm-Message-State: AOUpUlETmY4Archc/BSQiF1RfwJtfjTAtZzo2ZxxjVKFGTDaDitVpkaV
        TeRkP95IjYYZIsyWmUtXWMKA6uwn
X-Google-Smtp-Source: AA+uWPz7mJaHp28S2RdH4oBVr47dsgCu5x3JGHCehKCyzDr3NKxKVDwIM4NcLPcnVwUYMafNU4c9Ng==
X-Received: by 2002:a63:6002:: with SMTP id u2-v6mr8059932pgb.433.1533939276524;
        Fri, 10 Aug 2018 15:14:36 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id f75-v6sm37080514pfk.85.2018.08.10.15.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 15:14:35 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:14:35 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 22:14:09 GMT
Message-Id: <ca8de8c75da1fd2cc2dcb4bf1cc3e4b11696c6f6.1533939264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v5.git.gitgitgadget@gmail.com>
References: <pull.1.v4.git.gitgitgadget@gmail.com>
        <pull.1.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 07/21] range-diff: indent the diffs just like tbdiff
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
index 19192ab31..f6df3f19a 100644
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
 			     builtin_range_diff_usage, PARSE_OPT_KEEP_UNKNOWN |
@@ -88,6 +97,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 
 	strbuf_release(&range1);
 	strbuf_release(&range2);
+	strbuf_release(&four_spaces);
 
 	return res;
 }
-- 
gitgitgadget

