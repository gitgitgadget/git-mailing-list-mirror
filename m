Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F341D1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 21:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeIEByK (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 21:54:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33285 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeIEByK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 21:54:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id s7-v6so2303368pgc.0
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 14:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iGQNxb9O2pYI428bY0KO36IBFbGIupo3nzwCUC6n18w=;
        b=Riv4CD29ekukzErZBJt42rce9WVLjo971k8DOM+zox0kwQuqr//mfCmf7LeJhDOYf5
         mINRMkwhLdAa7l94ozfkx9/gmQH+WRUGaa0b7QmMuO0aDJ+XqqZlOp9OjeK67NWyUh9D
         S7rCTygGIX+PVXg6qatIm3iRWrqybbypKQoPzx7CRhFNNDbJzFi3Au6WQ6+E+cV8xgSS
         Op1SJXI32XhzsDdRBvgiJu6TrTW3N51au14BEDj/4vhw/IVEWe0Grc/yRqcc+tKt31OO
         aMyolrIz6n0oNHbD+zOTV312fZtexu92AyziZZphN8boc3T52h8JdjAS2f58dBj+LjiY
         cm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iGQNxb9O2pYI428bY0KO36IBFbGIupo3nzwCUC6n18w=;
        b=JtGcplWiS2JIMOhW3kDA4DeicmQQjf/FeubxPOPuOSlw8VeZ/i3sb7ANl7bxEBnXvS
         tHown6lHx1pt8l+iRK0b8z4qsL62GyUgR9LXobeNSjIvtEqaFbpUVXF5fwQEY5OxZxqN
         rSj0P1ttlsuf45GD4dlNwXExLqwQXl7AAbtLiQw50uvFzzos/MXJf/Q6/pCT5ItgyGZ1
         ghP9E+Ey5oSdutWvWKq9NiSASlgI7NfntFYoaMV6MNaAZdVM2O9PqH9B3zhVRBFRGz59
         7Fcbb2aBjMDvQNq1Nw4q1GUlVDzfF1j7jta0stZJ8tVXBd9DEY32K9iNr9tY5bbFmUIm
         8LjQ==
X-Gm-Message-State: APzg51BVGe1bOycF66FA/Iqfwmv4hJt3Fttt7eQ6ETZwcMce+9SqUDtK
        66rCB6o9VfnBKn7FXNVYE+esjVXb
X-Google-Smtp-Source: ANB0VdZIn0xvt+H3NdLlRAMxci5+Aw6SkqBIO7TODksYH3sEGbyGKPP9FDFCou3n3OiiGHgtpQfhIQ==
X-Received: by 2002:a63:4663:: with SMTP id v35-v6mr33455746pgk.178.1536096432863;
        Tue, 04 Sep 2018 14:27:12 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id q6-v6sm34910147pgq.19.2018.09.04.14.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 14:27:12 -0700 (PDT)
Date:   Tue, 04 Sep 2018 14:27:12 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:26:57 GMT
Message-Id: <5034f5302493ce44fb49ef3d064b5a5a3b67ac7f.1536096424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.32.v2.git.gitgitgadget@gmail.com>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
        <pull.32.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 04/11] builtin rebase: support --quiet
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

This commit introduces a rebase option `--quiet`. While `--quiet` is
commonly perceived as opposite to `--verbose`, this is not the case for
the rebase command: both `--quiet` and `--verbose` default to `false` if
neither `--quiet` nor `--verbose` is present.

Despite the default being `false` for both verbose and quiet mode,
passing the `--quiet` option will turn off verbose mode, and `--verbose`
will turn off quiet mode.

This patch introduces the `flags` bit field, with `REBASE_NO_QUIET`
as first user (with many more to come).

We do *not* use `REBASE_QUIET` here for an important reason: To keep the
implementation simple, this commit introduces `--no-quiet` instead of
`--quiet`, so that a single `OPT_NEGBIT()` can turn on quiet mode and
turn off verbose and diffstat mode at the same time. Likewise, the
companion commit which will introduce support for `--verbose` will have
a single `OPT_BIT()` that turns off quiet mode and turns on verbose and
diffstat mode at the same time.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b79f9b0a9f..19fa4d3fc4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -79,6 +79,10 @@ struct rebase_options {
 	int root;
 	struct commit *restrict_revision;
 	int dont_finish_rebase;
+	enum {
+		REBASE_NO_QUIET = 1<<0,
+	} flags;
+	struct strbuf git_am_opt;
 };
 
 /* Returns the filename prefixed by the state_dir */
@@ -159,6 +163,9 @@ static int run_specific_rebase(struct rebase_options *opts)
 	add_var(&script_snippet, "revisions", opts->revisions);
 	add_var(&script_snippet, "restrict_revision", opts->restrict_revision ?
 		oid_to_hex(&opts->restrict_revision->object.oid) : NULL);
+	add_var(&script_snippet, "GIT_QUIET",
+		opts->flags & REBASE_NO_QUIET ? "" : "t");
+	add_var(&script_snippet, "git_am_opt", opts->git_am_opt.buf);
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -308,6 +315,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
 	struct rebase_options options = {
 		.type = REBASE_UNSPECIFIED,
+		.flags = REBASE_NO_QUIET,
+		.git_am_opt = STRBUF_INIT,
 	};
 	const char *branch_name;
 	int ret, flags;
@@ -321,6 +330,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			   N_("rebase onto given branch instead of upstream")),
 		OPT_BOOL(0, "no-verify", &ok_to_skip_pre_rebase,
 			 N_("allow pre-rebase hook to run")),
+		OPT_NEGBIT('q', "quiet", &options.flags,
+			   N_("be quiet. implies --no-stat"),
+			   REBASE_NO_QUIET),
 		OPT_END(),
 	};
 
@@ -357,6 +369,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 
+	if (!(options.flags & REBASE_NO_QUIET))
+		strbuf_addstr(&options.git_am_opt, " -q");
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
-- 
gitgitgadget

