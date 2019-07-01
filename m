Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3F931F461
	for <e@80x24.org>; Mon,  1 Jul 2019 11:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfGAL6R (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 07:58:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36542 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfGAL6R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 07:58:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id k21so4523686edq.3
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 04:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EWHveCRWMuhib4b0nqXbxOeNG9CRyvGtUnz4YBpJi3A=;
        b=SIb90pKe4SxrZkn4FD9hBadVF35ETrOdLj/4z6YHmFjyzCTmBfCsrF2qK6ZZ+FXnix
         gj+kIpbxN85Iel7ursUTavpmmDM07cmhDpZS9cPBBqFa9D3zdSYW0f3/qHuKI0ceHf38
         yyR0PDH6Kg4RuCX30IBmyvSx/Uxi4ZTG7eo+O4Wxu+z78MikmAMgbF+/oMUQJg4wzuCD
         Ew61Ijb3vWgJgeIVpjeZKdhKvcuCZScWXm9Kgx2/natWYorJCyfFqrJY7qj3GlVke2zf
         2+EBVzN7PjArOwxoPmnqfxULnWQU/ZpVN9Lj1ZeUvH6SFMDrJIrTc46aPUMgtqwBooPD
         z3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EWHveCRWMuhib4b0nqXbxOeNG9CRyvGtUnz4YBpJi3A=;
        b=FYN48h9+mxbvmmk0x3wXbVVktTN28a8XVjNvJ4f/Uy+iHn5mcwNvvqqc/+5Y0D5RHh
         rCGOQH2bVzTtIZLfDfqd4aEewhtSBDnD9NwqNE12a4howRIPQmAzHvoE7dUgd+KbGIw7
         zVFdXfNA1Kl0BcypZgR6FctJ2Frv/AVyo/18o3NVzOatGmz5BTQl5lTVtd7f+8Il6kKV
         YyHa1GXAg5u1q8Ncs8kKUzVTuzuNqhVdXVRLGA49TR01EhmFEvFe+bn/KYOxbOg7QGzU
         AvHEsG7YzKSGTyRZUP3O2ypLKIjTYA8ea5BPYoXPf38jpUS4xsPgzrBkHzADUsniHOcW
         IKFA==
X-Gm-Message-State: APjAAAV536PwzOlAlLtpda5CsDkWCNzl+d5NZG9dndil7SBwQGly2kMN
        b389Sq+KR+ipcUeoMzMRsWVloqyj
X-Google-Smtp-Source: APXvYqzfmKb4PoqsnUUylQkFTFQ9+Ui7cTCVKTalqNFW8Cf9+gRo2JujFtCO36Fi23r2v+ee/Al1vw==
X-Received: by 2002:a17:906:7f0f:: with SMTP id d15mr23143088ejr.39.1561982296032;
        Mon, 01 Jul 2019 04:58:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11sm2134646ejm.86.2019.07.01.04.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 04:58:15 -0700 (PDT)
Date:   Mon, 01 Jul 2019 04:58:15 -0700 (PDT)
X-Google-Original-Date: Mon, 01 Jul 2019 11:58:14 GMT
Message-Id: <beaeb24bc0cee7d1d80dcc377f135e80782567af.1561982294.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.253.v2.git.gitgitgadget@gmail.com>
References: <pull.253.git.gitgitgadget@gmail.com>
        <pull.253.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] rebase --am: ignore rebase.reschedulefailedexec
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Vas Sudanagunta <vas@commonkarma.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `exec` command is specific to the interactive backend, therefore it
does not make sense for non-interactive rebases to heed that config
setting.

We still want to error out if a non-interactive rebase is started with
`--reschedule-failed-exec`, of course.

Reported by Vas Sudanagunta via:
https://github.com/git/git/commit/969de3ff0e0#commitcomment-33257187

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c           | 10 +++++++---
 t/t3418-rebase-continue.sh |  8 ++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 4839e52555..b33d7f74d6 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -834,6 +834,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
 	struct object_id squash_onto;
 	char *squash_onto_name = NULL;
+	int reschedule_failed_exec = -1;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -929,7 +930,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "root", &options.root,
 			 N_("rebase all reachable commits up to the root(s)")),
 		OPT_BOOL(0, "reschedule-failed-exec",
-			 &options.reschedule_failed_exec,
+			 &reschedule_failed_exec,
 			 N_("automatically re-schedule any `exec` that fails")),
 		OPT_END(),
 	};
@@ -1227,8 +1228,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
-	if (options.reschedule_failed_exec && !is_interactive(&options))
-		die(_("--reschedule-failed-exec requires an interactive rebase"));
+	if (reschedule_failed_exec > 0 && !is_interactive(&options))
+		die(_("--reschedule-failed-exec requires "
+		      "--exec or --interactive"));
+	if (reschedule_failed_exec >= 0)
+		options.reschedule_failed_exec = reschedule_failed_exec;
 
 	if (options.git_am_opts.argc) {
 		/* all am options except -q are compatible only with --am */
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index bdaa511bb0..4eff14dae5 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -265,4 +265,12 @@ test_expect_success '--reschedule-failed-exec' '
 	test_i18ngrep "has been rescheduled" err
 '
 
+test_expect_success 'rebase.reschedulefailedexec only affects `rebase -i`' '
+	test_config rebase.reschedulefailedexec true &&
+	test_must_fail git rebase -x false HEAD^ &&
+	grep "^exec false" .git/rebase-merge/git-rebase-todo &&
+	git rebase --abort &&
+	git rebase HEAD^
+'
+
 test_done
-- 
gitgitgadget
