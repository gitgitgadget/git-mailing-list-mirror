Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DF1D1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 18:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfBFSpW (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 13:45:22 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41808 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfBFSpV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 13:45:21 -0500
Received: by mail-ed1-f66.google.com with SMTP id p15so2517507edy.8
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 10:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P8ZcNkeHPxFP7scr3iZkxXmespyYfQ2fIhzC9Wmqnao=;
        b=c9InDtfTC1pqe2p961HPbxoyY/D4hu3VtZEUHQq8oPhPq96FbdPi2xWVEkhyPDZeq3
         N5rthVxFHvZ7AD+p3kM3IjyFbiwMz056meOZMhWAkg4G9i73t1aTMrC3u9t+9u+AQJs8
         b5icjklJArIoh4juIcaKwYGhRCtnwhJSfTAuxF3q228Pb/JzrZNKWZNsh7JWwuCQbAPM
         kIQHU68YFBaXA71vYOoRhno0f6zDgeBOx23MKvMSTso3A+KjksnI4Zyh7om3qCMfHn4J
         SMGIDR+2jDNtZr/jW86Qh1iXIJKFb3i36e3L/o7jfZQsgg9luIvoiT8vLKvJ9XLw3RTy
         MhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P8ZcNkeHPxFP7scr3iZkxXmespyYfQ2fIhzC9Wmqnao=;
        b=NSaQIY8aN42igA0/DJPE1LPIcY6Dhqi8KT110K+YVnA5NTgP8aWwBY2Y4q8oA9T+9m
         3zUagPYAgkKivAoO3wt6i1bDpOJ4KevmHKzzd0QJAkrFoTgpRqn9dFqovr3PwOwqPFg0
         SQvGgQpOraU9hzT7sQR4zGl9pz4UN3k7YNEDSLsXAd8x2TMV9j2H7UsEJeVSBYrA0bff
         ddw33GwGV0WBsSx7043MmFebLjiOqrs0ul0vIEcpXlZ34DLEieKALo0bMCRt8KuuYR+X
         d/yH6HVBKl/Equ+/2dsiDaIBQQZyLezK2nH7kBBQzcmDji4jjoKHvQghLNbCo/Geb4m1
         dPPg==
X-Gm-Message-State: AHQUAubFETxphU8i+JO7ZcC20Z6ZJkXWjjMY8Lmxk97E94KQaIb5FTip
        sfvtu47G3CgRzqmT0RsybZYrY88L
X-Google-Smtp-Source: AHgI3IatnIjuZmgQ5bmnFcxrQ413m0tXGRJeM7MokuwnzKRfEO2K2ilgfeDYMizWpEz/Hj/ARBiVfg==
X-Received: by 2002:a50:b721:: with SMTP id g30mr9070042ede.155.1549478718689;
        Wed, 06 Feb 2019 10:45:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p21sm5854935edr.67.2019.02.06.10.45.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 10:45:17 -0800 (PST)
Date:   Wed, 06 Feb 2019 10:45:17 -0800 (PST)
X-Google-Original-Date: Wed, 06 Feb 2019 18:45:15 GMT
Message-Id: <a4857fb32d99088f27b5a80d23c4f9ec15586396.1549478715.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.118.v2.git.gitgitgadget@gmail.com>
References: <pull.118.git.gitgitgadget@gmail.com>
        <pull.118.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] Revert "rebase: introduce a shortcut for
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

This patch was contributed only as a tentative "we could introduce a
convenient short option if we do not want to change the default behavior
in the long run" patch, opening the discussion whether other people
agree with deprecating the current behavior in favor of the rescheduling
behavior.

But the consensus on the Git mailing list was that it would make sense
to show a warning in the near future, and flip the default
rebase.rescheduleFailedExec to reschedule failed `exec` commands by
default. See e.g.
<CAGZ79kZL5CRqCDRb6B-EedUm8Z_i4JuSF2=UtwwdRXMitrrOBw@mail.gmail.com>

So let's back out that patch that added the `-y` short option that we
agreed was not necessary or desirable.

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
