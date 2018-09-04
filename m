Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 661D51F404
	for <e@80x24.org>; Tue,  4 Sep 2018 21:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeIEC0z (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 22:26:55 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35782 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeIEC0y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 22:26:54 -0400
Received: by mail-pl1-f193.google.com with SMTP id g2-v6so1297462plo.2
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 14:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=knzWlXP/zmaf1hqvqMPqcxr3yCeOUExQm69VAYxxFQc=;
        b=LVrXldbJotGV45bY7pK+SCUXaK+nIG60HUbtNAzdoJ5O+NdOgw9b1j9HDzunQogDRn
         RtvtaB7YJNowueAGkGtM73FqeF7POS+yzANXbzpgkbiAUaHUg7qOQrNVUnsR6QPoSZZ+
         9AWalY9UHCc0Rb26zirWNm9133Ih/oaM45En8bYpCjve5M8u+8nClps6xA7Q/yYwVTZp
         LKIFnuPQEivaEy5MkI4ySqmNLbPst9ZPbODyUYORezs4s46H2SSLikU8DNd3wEyJWZg1
         vhrgL5o8TXCGppqoJ7W38i4a1gbkrTuD4p5F3jFiIa9MPRT+hVzuBsWFVWkvBtgeAbYk
         ZLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=knzWlXP/zmaf1hqvqMPqcxr3yCeOUExQm69VAYxxFQc=;
        b=lPCiSC59VsHoK3Ys+bUV2QQcsqzAIMcCETjaKm7SR/R4r0keYN1+X3uyML1d4CBL4T
         RQZa6GOlED1v0Eb3xVGOlf8RmO4HrKePe/z5KfCF8500lszaX6660w5UEnK+IYIwEd9L
         BanNdVo2wXvam151qiYmRrqr3/bbsrlR3bnbavTj+la56EVlML2DF+nyyUnYD2TmTzzw
         giU+ERN9z2+3XaUEncvFayDFIID+ss6pymdof3evvz3fqHj1Gf2tjwll4FsmSgK4Rv53
         2iX+VE4Y6dRp3Fnd+GGbHRYq+4By2j/7fl3Xgcudo8k4Lf3m9aDgIEQZyoqe3FAVlbzs
         1c8w==
X-Gm-Message-State: APzg51DlUcEmEV/3/h5JhONC90pr/ckYFFTb8lwGB+UdLG+TRohdmxMM
        SOKfrRkGpm1zgDXxUsm6CLxBau1R
X-Google-Smtp-Source: ANB0Vdb2peFOsRxLN7hgKkEU5vwwE2m3wZWIvp6Ik2WtppjCnXIyU7YEH7Ts30ZyBttwCYfSFeBU+Q==
X-Received: by 2002:a17:902:a716:: with SMTP id w22-v6mr35816674plq.334.1536098390021;
        Tue, 04 Sep 2018 14:59:50 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id y64-v6sm24953343pgd.65.2018.09.04.14.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 14:59:49 -0700 (PDT)
Date:   Tue, 04 Sep 2018 14:59:49 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Sep 2018 21:59:28 GMT
Message-Id: <7f751c6ce106e1ca7c4fb63ae8db5ffe339e7404.1536098386.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.33.v2.git.gitgitgadget@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
        <pull.33.v2.git.gitgitgadget@gmail.com>
From:   "Pratik Karki via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 01/18] builtin rebase: allow selecting the rebase "backend"
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

With this commit the builtin rebase supports selecting the "rebase
backends" (or "type") `interactive`, `preserve-merges`, and `merge`.

The `state_dir` was already handled according to the rebase type in a
previous commit.

Note that there is one quirk in the shell script: `--interactive`
followed by `--merge` won't reset the type to "merge" but keeps the type
as "interactive". And as t3418 tests this explicitly, we have to support
it in the builtin rebase, too.

Likewise, `--interactive` followed by `--preserve-merges` makes it an
"explicitly interactive" rebase, i.e. a rebase that should show the todo
list, while `--preserve-merges` alone is not interactive (and t5520
tests for this via `git pull --rebase=preserve`).

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 75c4ac66e0..fc9b5a8a60 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -452,6 +452,29 @@ static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
 	return res && is_linear_history(onto, head);
 }
 
+/* -i followed by -m is still -i */
+static int parse_opt_merge(const struct option *opt, const char *arg, int unset)
+{
+	struct rebase_options *opts = opt->value;
+
+	if (!is_interactive(opts))
+		opts->type = REBASE_MERGE;
+
+	return 0;
+}
+
+/* -i followed by -p is still explicitly interactive, but -p alone is not */
+static int parse_opt_interactive(const struct option *opt, const char *arg,
+				 int unset)
+{
+	struct rebase_options *opts = opt->value;
+
+	opts->type = REBASE_INTERACTIVE;
+	opts->flags |= REBASE_INTERACTIVE_EXPLICIT;
+
+	return 0;
+}
+
 int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
 	struct rebase_options options = {
@@ -510,6 +533,17 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "show-current-patch", &action,
 			    N_("show the patch file being applied or merged"),
 			    ACTION_SHOW_CURRENT_PATCH),
+		{ OPTION_CALLBACK, 'm', "merge", &options, NULL,
+			N_("use merging strategies to rebase"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			parse_opt_merge },
+		{ OPTION_CALLBACK, 'i', "interactive", &options, NULL,
+			N_("let the user edit the list of commits to rebase"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			parse_opt_interactive },
+		OPT_SET_INT('p', "preserve-merges", &options.type,
+			    N_("try to recreate merges instead of ignoring "
+			       "them"), REBASE_PRESERVE_MERGES),
 		OPT_END(),
 	};
 
@@ -884,6 +918,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		diff_flush(&opts);
 	}
 
+	if (is_interactive(&options))
+		goto run_rebase;
+
 	/* Detach HEAD and reset the tree */
 	if (options.flags & REBASE_NO_QUIET)
 		printf(_("First, rewinding head to replay your work on top of "
-- 
gitgitgadget

