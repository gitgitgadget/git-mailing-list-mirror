Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA9E21F404
	for <e@80x24.org>; Tue,  4 Sep 2018 21:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeIEC06 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 22:26:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41977 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeIEC05 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 22:26:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id b12-v6so2248958plr.8
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 14:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AHZcdTjrcl3hlEWSZoadvfDMmsxC1/MV+/rVAwuI/nw=;
        b=aao6eQi/SVn/4pezr1RpAC6LnFy7p3iwbs06CEfhFFDOcX8flqoR6SU6hGaJZpiHzM
         bI8EbnmimI1/y2zk6ca4L7m8/xZjM1ATZIcgvL/MX1RWDzQ8qYcE0kcDBMFmqp4wMVX5
         Fp5OWKxAC8fl8WySwf1cxhDngaabHFD76XhVoO0j6+BxS9L++rDQYUdFJikvHwLuYP4u
         lcLOWRcWQFmi4/gKKCjOBr0OGOlY9z/oqgVlxeq1pSoLHp+RnDf7x9GUG1Wdxq14Ou6b
         Rk9Y/LEu2jiD0ZpEyiiLz8EkEEqXTEPvlhl5sfSL4xCz+thfFovtIYdmes8+hoEbRmqQ
         qi1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AHZcdTjrcl3hlEWSZoadvfDMmsxC1/MV+/rVAwuI/nw=;
        b=W+OcevzdOjfG1/tAdJaTaS8tt4Gz6PmNcFzDlWvXdU5X4OI3ctDSox3itiKSe+9idh
         AUKB4YIwMoVpZOc4LE4tIyj62G9Ov57NNa3YFl+RMOtvc0Z/5uwSgfK/wVT+fedZJlxe
         3Kt6wXZFEP5OJtBv8CRPbWbhOb0Ot7Vgcb2D2+JyN2IXa7+EsGzzuXzUZkiTlPWfM92u
         B3Qbl97Yg3DCqU4m2J7StLtd9phK1YzyUAE5tRQLoMVgrrT07M3pv+N8SK5um/MnvFPe
         v0TfHZgwWhpEVO0AfRB1Bkfm4d8U67CC8tqTZMMgHofTfI8XGOs8m/rFqpw9xqURLxNz
         kB2Q==
X-Gm-Message-State: APzg51C54u/ckrtCsXVrlANHuQfPZayIVA+rj5BqJfD/uFxu7K8HbfMD
        dCmR3c7dTVEhMSjrxXPtM3xVBcS7
X-Google-Smtp-Source: ANB0VdaLFPoFOfS8NAh4HsCMVOnNtynQmjopVLIix9Qv+L3FxV+myrH+6NudZkNeZeF6BlEViUdmeQ==
X-Received: by 2002:a17:902:8b86:: with SMTP id ay6-v6mr35878434plb.25.1536098392730;
        Tue, 04 Sep 2018 14:59:52 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id u184-v6sm31032408pgd.46.2018.09.04.14.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 14:59:52 -0700 (PDT)
Date:   Tue, 04 Sep 2018 14:59:52 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:59:30 GMT
Message-Id: <a301ef6bbdcdc1696991123cee078246deb65727.1536098386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.33.v2.git.gitgitgadget@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
        <pull.33.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 03/18] builtin rebase: support --rerere-autoupdate
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pratik Karki <predatoramigo@gmail.com>

The `--rerere-autoupdate` option allows rerere to update the index with
resolved conflicts. This commit follows closely the equivalent part of
`git-legacy-rebase.sh`.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index a491481120..1729d2d9e2 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -94,6 +94,7 @@ struct rebase_options {
 	struct strbuf git_am_opt;
 	const char *action;
 	int signoff;
+	int allow_rerere_autoupdate;
 };
 
 static int is_interactive(struct rebase_options *opts)
@@ -174,6 +175,21 @@ static int read_basic_state(struct rebase_options *opts)
 		opts->flags |= REBASE_FORCE;
 	}
 
+	if (file_exists(state_dir_path("allow_rerere_autoupdate", opts))) {
+		strbuf_reset(&buf);
+		if (read_one(state_dir_path("allow_rerere_autoupdate", opts),
+			    &buf))
+			return -1;
+		if (!strcmp(buf.buf, "--rerere-autoupdate"))
+			opts->allow_rerere_autoupdate = 1;
+		else if (!strcmp(buf.buf, "--no-rerere-autoupdate"))
+			opts->allow_rerere_autoupdate = 0;
+		else
+			warning(_("ignoring invalid allow_rerere_autoupdate: "
+				  "'%s'"), buf.buf);
+	} else
+		opts->allow_rerere_autoupdate = -1;
+
 	strbuf_release(&buf);
 
 	return 0;
@@ -256,6 +272,10 @@ static int run_specific_rebase(struct rebase_options *opts)
 		add_var(&script_snippet, "switch_to", opts->switch_to);
 	add_var(&script_snippet, "action", opts->action ? opts->action : "");
 	add_var(&script_snippet, "signoff", opts->signoff ? "--signoff" : "");
+	add_var(&script_snippet, "allow_rerere_autoupdate",
+		opts->allow_rerere_autoupdate < 0 ? "" :
+		opts->allow_rerere_autoupdate ?
+		"--rerere-autoupdate" : "--no-rerere-autoupdate");
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -488,6 +508,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		.type = REBASE_UNSPECIFIED,
 		.flags = REBASE_NO_QUIET,
 		.git_am_opt = STRBUF_INIT,
+		.allow_rerere_autoupdate  = -1,
 	};
 	const char *branch_name;
 	int ret, flags, total_argc, in_progress = 0;
@@ -553,6 +574,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('p', "preserve-merges", &options.type,
 			    N_("try to recreate merges instead of ignoring "
 			       "them"), REBASE_PRESERVE_MERGES),
+		OPT_BOOL(0, "rerere-autoupdate",
+			 &options.allow_rerere_autoupdate,
+			 N_("allow rerere to update index  with resolved "
+			    "conflict")),
 		OPT_END(),
 	};
 
-- 
gitgitgadget

