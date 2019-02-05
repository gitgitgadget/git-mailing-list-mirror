Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33A241F453
	for <e@80x24.org>; Tue,  5 Feb 2019 11:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfBELtI (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 06:49:08 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33124 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfBELtH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 06:49:07 -0500
Received: by mail-ed1-f68.google.com with SMTP id p6so2624594eds.0
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 03:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Lc/iPj+0V09znS3i4LT+/eLjNSe/+fI6PiNZ+ana19A=;
        b=NmcxCZ5XcIkfNs4h+By2A+dKC3Z/WdEyJF4sY7mV8psnBKv1FIXA8Awk+fRYTpYF1M
         w0AKCc5fTy6VvHRb3vru71+tZheIB8jWSoifMZLgxuCMBvSbq3sjoqp3I+DkPpacKulq
         NEvmzEeZtusf59b8T/cbgwjd/We4Zw9LSCl//T1j1ZHAkeB2AYDBaagquWGbm2tmIvL1
         FIkoJIrHqXaPSbubQvYviBXFfE2l+0uZekOJGnH1LzpiPfISOeK3WKPmXd1UUPULuxNz
         X+4CDrxBlPwrk7DWY4we0JbqlCOJYKjnWy98A/n0TDYcHVH6fNCr5NdLn0hEBlDz1QrT
         A+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Lc/iPj+0V09znS3i4LT+/eLjNSe/+fI6PiNZ+ana19A=;
        b=k9kL3FRt2LxUIatb02Tsmj5neUF+AKJX6tg9hNkGzBWqhEsKaAj4FQGKeGQI+OTeTi
         qZFlclc4DzTjfxdFJIn93I+7IrFRunEiwofBefWGeeE8cmpnICeBCkTxcOCERXz3AKD9
         kMWEJ4SMH8CECvLXIA3JWwPU3wJ4TX1EFPvy7i+jZcOUUxg2YRYy8AS/yosvbSlX0I6w
         LtZMsYGYcK4T1Rh6n76IIEsyaLkru/YJr8PfUKMcu8IR+TJwdU+hWpl9kLZzhLT79Xpj
         zIb9kY5dF0DMdGj2mQGoARmCbGccuiemo3y3B50ulFy1JGVDpEmtwWwkncSKlmcQ5GCd
         QWiw==
X-Gm-Message-State: AHQUAub5mVGwZeWdPy9bwvmYz7mpp0s3dW8yUzzcXhbKH0i5qCaGbiIR
        OQq0VdbDJHvrIIIYKLU08xzaL9RS
X-Google-Smtp-Source: AHgI3Ia1WAGxI9xuXj1GSP46tW7arXYH/CjVSvwnhKqDaq5cRBcZSvMGUbMVWgHIoC2/X6aYWAX41w==
X-Received: by 2002:a17:906:1c0c:: with SMTP id k12mr3269881ejg.39.1549367345072;
        Tue, 05 Feb 2019 03:49:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8sm3084995ejs.31.2019.02.05.03.49.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 03:49:04 -0800 (PST)
Date:   Tue, 05 Feb 2019 03:49:04 -0800 (PST)
X-Google-Original-Date: Tue, 05 Feb 2019 11:49:02 GMT
Message-Id: <e61ebc30605e21ce71623903bc9c850fd964e826.1549367342.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.118.git.gitgitgadget@gmail.com>
References: <pull.118.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] Revert "rebase: introduce a shortcut for
 --reschedule-failed-exec"
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

When contributing the patch series, the cover letter tried to convey
clearly that the patch introducing the shortcut -y was included only to
show that it is possible, with a slight bias against it.

During the review, there were a couple reviewers who agreed with this
sentiment, and the author was happy that this patch was not needed and
concurred that it should be dropped. See e.g. Stefan Beller's reply:
<CAGZ79kZL5CRqCDRb6B-EedUm8Z_i4JuSF2=UtwwdRXMitrrOBw@mail.gmail.com>

However, it slipped by the original patch author (yours truly) that the
patch *was* included when the branch made it to `next` and then when it
made it to `master`.

So let's back out that patch before it even slips into an official
release (in which case we would even have to support this unwanted
flag).

This reverts commit 81ef8ee75d5f348d3c71ff633d13d302124e1a5e.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-rebase.txt |  6 ------
 builtin/rebase.c             | 21 ---------------------
 git-legacy-rebase.sh         |  6 ------
 t/t3418-rebase-continue.sh   |  3 ---
 4 files changed, 36 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 4dd5853d6e..44ffe2c8c5 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -462,12 +462,6 @@ without an explicit `--interactive`.
 +
 See also INCOMPATIBLE OPTIONS below.
 
--y <cmd>::
-	This is the same as passing `--reschedule-failed-exec` before
-	`-x <cmd>`, i.e. it appends the specified `exec` command and
-	turns on the mode where failed `exec` commands are automatically
-	rescheduled.
-
 --root::
 	Rebase all commits reachable from <branch>, instead of
 	limiting them with an <upstream>.  This allows you to rebase
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 774264bae8..7c77a80687 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -760,23 +760,6 @@ static int parse_opt_interactive(const struct option *opt, const char *arg,
 	return 0;
 }
 
-struct opt_y {
-	struct string_list *list;
-	struct rebase_options *options;
-};
-
-static int parse_opt_y(const struct option *opt, const char *arg, int unset)
-{
-	struct opt_y *o = opt->value;
-
-	if (unset || !arg)
-		return -1;
-
-	o->options->reschedule_failed_exec = 1;
-	string_list_append(o->list, arg);
-	return 0;
-}
-
 static void NORETURN error_on_missing_default_upstream(void)
 {
 	struct branch *current_branch = branch_get(NULL);
@@ -857,7 +840,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
 	struct object_id squash_onto;
 	char *squash_onto_name = NULL;
-	struct opt_y opt_y = { .list = &exec, .options = &options };
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -935,9 +917,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_STRING_LIST('x', "exec", &exec, N_("exec"),
 				N_("add exec lines after each commit of the "
 				   "editable list")),
-		{ OPTION_CALLBACK, 'y', NULL, &opt_y, N_("<cmd>"),
-			N_("same as --reschedule-failed-exec -x <cmd>"),
-			PARSE_OPT_NONEG, parse_opt_y },
 		OPT_BOOL(0, "allow-empty-message",
 			 &options.allow_empty_message,
 			 N_("allow rebasing commits with empty messages")),
diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
index 3bb0682db5..37db5a7ca4 100755
--- a/git-legacy-rebase.sh
+++ b/git-legacy-rebase.sh
@@ -26,7 +26,6 @@ f,force-rebase!    cherry-pick all commits, even if unchanged
 m,merge!           use merging strategies to rebase
 i,interactive!     let the user edit the list of commits to rebase
 x,exec=!           add exec lines after each commit of the editable list
-y=!                same as --reschedule-failed-exec -x
 k,keep-empty	   preserve empty commits during rebase
 allow-empty-message allow rebasing commits with empty messages
 stat!              display a diffstat of what changed upstream
@@ -263,11 +262,6 @@ do
 		cmd="${cmd}exec ${1#--exec=}${LF}"
 		test -z "$interactive_rebase" && interactive_rebase=implied
 		;;
-	-y*)
-		reschedule_failed_exec=--reschedule-failed-exec
-		cmd="${cmd}exec ${1#-y}${LF}"
-		test -z "$interactive_rebase" && interactive_rebase=implied
-		;;
 	--interactive)
 		interactive_rebase=explicit
 		;;
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 25aaacacfc..bdaa511bb0 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -262,9 +262,6 @@ test_expect_success '--reschedule-failed-exec' '
 	test_must_fail git -c rebase.rescheduleFailedExec=true \
 		rebase -x false HEAD^ 2>err &&
 	grep "^exec false" .git/rebase-merge/git-rebase-todo &&
-	test_i18ngrep "has been rescheduled" err &&
-	git rebase --abort &&
-	test_must_fail git rebase -y false HEAD^ 2>err &&
 	test_i18ngrep "has been rescheduled" err
 '
 
-- 
gitgitgadget
