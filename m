Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D2161F462
	for <e@80x24.org>; Mon, 20 May 2019 18:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfETSYO (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 14:24:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42807 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfETSYN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 14:24:13 -0400
Received: by mail-qt1-f194.google.com with SMTP id j53so17436265qta.9
        for <git@vger.kernel.org>; Mon, 20 May 2019 11:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aPI9Xe+rR3BaMz5w+Fn7VTjd6FSWyYV7xyzNEpq+N/g=;
        b=sZiEzFB118ySWAh/+ra/Q6N1/enjHfsvPEnQLlNp9cqKeadosPUCnJqaLHxc3hngnG
         sgThBn80tyZnO49WKPxDmWAL8m1Na01/igf4CRjylFZ+DI8FJXP/ZlZqxQwZZRDJLnK2
         fwKTGUJM2Vp+BSSl2KxL3sOT+S/N8c2kQ0jXo6fx+JK77jpTjCwraRMpyHgpVmNTu1il
         yNbN7ZFQuzuvis0VfaeRR4I07tJ7cHCkISUyCIWrlu0UIeSYIhpLgk1s9uM4knUiWvmv
         LcPrPX7TihT0tlOSlVGei5cZhweYIy4rzAVOB4kx7b9f9pnXMVqcBcfwkYS0QFAdg9na
         zN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aPI9Xe+rR3BaMz5w+Fn7VTjd6FSWyYV7xyzNEpq+N/g=;
        b=gkF/PN/tCR21ZAuhifjx9K359rXJHLhDEWCLUyRZAUSfekWOAQ/bUkZUiZUflul1xM
         pub2ljlDmM1yD+ODoCp1roTCwnudsvS13IqktizybSv3aJB3I18OdHbW27kzjdzgQHE8
         7hXYpHYJ5wcNRPh6VCH1dEiI0YvYMRIBVHw6eRNMFfbQfpu7kb4siO5Mx2+ryuW1Fge5
         C9XrBYJmJI0osnj561IdAK/nYTMYMKuQ7C1/htzRWRnR7KWUnG1+GLHzHAsfk7heuvwm
         88smvbYzu8fPRb1XJxUhndxK/G9tqE656CIqFsSlppmJ1vDyMrdct+afwOFlt/luz62+
         SUBg==
X-Gm-Message-State: APjAAAWto/dS+fYDBAClmAtq0UxWKEjobhsailGGJfNZw0BcFcqWrVSl
        +rfqD3OO+OHwkqhE7c3oOb99GNJtxT8RTg==
X-Google-Smtp-Source: APXvYqxHkjpmpSjfR0K+mMvz87qxtwTl/O6+ur0kWwALfNUBAvcFT+OD7oNATTo7P3N+HUgBH8X0Yw==
X-Received: by 2002:ac8:37d6:: with SMTP id e22mr64909128qtc.126.1558376652844;
        Mon, 20 May 2019 11:24:12 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::2])
        by smtp.gmail.com with ESMTPSA id g15sm10231922qta.31.2019.05.20.11.24.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 11:24:12 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=D0=9E=D0=BB=D1=8F=20=D0=A2=D0=B5=D0=BB=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F?= 
        <olyatelezhnaya@gmail.com>
Subject: Re: [GSoC] Some #leftoverbits for anyone looking for little projects
Date:   Mon, 20 May 2019 15:23:53 -0300
Message-Id: <20190520182353.22221-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87in9ucsbb.fsf@evledraar.gmail.com>
References: <87in9ucsbb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Ævar

> Give "rebase -i" some option so when you "reword" the patch is
> included in the message.
>
> I keep going to the shell because I have no idea what change I'm
> describing.

I have the same problem, so I wanted to try solving this. The patch
bellow creates a "rebase.verboseCommit" configuration that includes
a diff when rewording or squashing. I'd appreciate knowing your thoughts
on it.

As Christian wisely pointed out to me, though, we can also achieve this
behavior by setting "commit.verbose" to true. The only "downside" of it
is that users cannot choose to see the diff only when rebasing. Despite
of that, if we decide not to go with this patch, what do you think of
adding a "commit.verbose" entry at git-rebase's man page? 

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
index d98e32d812..ae50b3e05d 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -62,3 +62,8 @@ rebase.rescheduleFailedExec::
 	Automatically reschedule `exec` commands that failed. This only makes
 	sense in interactive mode (or when an `--exec` option was provided).
 	This is the same as specifying the `--reschedule-failed-exec` option.
+
+rebase.verboseCommit::
+	When rewording or squashing commits, during an interactive rebase, show
+	the commits' diff to help describe the modifications they bring. False
+	by default.
diff --git a/sequencer.c b/sequencer.c
index f88a97fb10..1596fc4cd0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -914,6 +914,7 @@ N_("you have staged changes in your working tree\n"
 #define CLEANUP_MSG (1<<3)
 #define VERIFY_MSG  (1<<4)
 #define CREATE_ROOT_COMMIT (1<<5)
+#define VERBOSE_COMMIT (1<<6)
 
 static int run_command_silent_on_success(struct child_process *cmd)
 {
@@ -1007,6 +1008,8 @@ static int run_git_commit(struct repository *r,
 		argv_array_push(&cmd.args, "-n");
 	if ((flags & AMEND_MSG))
 		argv_array_push(&cmd.args, "--amend");
+	if ((flags & VERBOSE_COMMIT))
+		argv_array_push(&cmd.args, "-v");
 	if (opts->gpg_sign)
 		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
 	if (defmsg)
@@ -1782,7 +1785,7 @@ static int do_pick_commit(struct repository *r,
 	char *author = NULL;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	struct strbuf msgbuf = STRBUF_INIT;
-	int res, unborn = 0, allow;
+	int res, unborn = 0, allow, verbose_commit = 0;
 
 	if (opts->no_commit) {
 		/*
@@ -1843,6 +1846,9 @@ static int do_pick_commit(struct repository *r,
 		return error(_("cannot get commit message for %s"),
 			oid_to_hex(&commit->object.oid));
 
+	if (git_config_get_maybe_bool("rebase.verbosecommit", &verbose_commit) < 0)
+		warning("Invalid value for rebase.verboseCommit. Using 'false' instead.");
+
 	if (opts->allow_ff && !is_fixup(command) &&
 	    ((parent && oideq(&parent->object.oid, &head)) ||
 	     (!parent && unborn))) {
@@ -1853,6 +1859,8 @@ static int do_pick_commit(struct repository *r,
 		if (res || command != TODO_REWORD)
 			goto leave;
 		flags |= EDIT_MSG | AMEND_MSG | VERIFY_MSG;
+		if (verbose_commit)
+			flags |= VERBOSE_COMMIT;
 		msg_file = NULL;
 		goto fast_forward_edit;
 	}
@@ -1909,12 +1917,17 @@ static int do_pick_commit(struct repository *r,
 			author = get_author(msg.message);
 	}
 
-	if (command == TODO_REWORD)
+	if (command == TODO_REWORD) {
 		flags |= EDIT_MSG | VERIFY_MSG;
+		if (verbose_commit)
+			flags |= VERBOSE_COMMIT;
+	}
 	else if (is_fixup(command)) {
 		if (update_squash_messages(r, command, commit, opts))
 			return -1;
 		flags |= AMEND_MSG;
+		if (verbose_commit)
+			flags |= VERBOSE_COMMIT;
 		if (!final_fixup)
 			msg_file = rebase_path_squash_msg();
 		else if (file_exists(rebase_path_fixup_msg())) {
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 1723e1a858..9b410d31e2 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1477,4 +1477,60 @@ test_expect_success 'valid author header when author contains single quote' '
 	test_cmp expected actual
 '
 
+write_script "reword-and-check-for-diff" <<\EOF &&
+case "$1" in
+*/git-rebase-todo)
+	sed s/pick/reword/ "$1" > "$1.tmp"
+	mv -f "$1.tmp" "$1"
+	;;
+*)
+	grep '^diff --git' "$1" >has-diff
+	;;
+esac
+exit 0
+EOF
+
+test_expect_success 'rebase -i does not show diff by default when rewording' '
+	rebase_setup_and_clean no-verbose-commit-reword &&
+	test_set_editor "$PWD/reword-and-check-for-diff" &&
+	git rebase -i HEAD~1 &&
+	test_line_count = 0 has-diff
+'
+
+test_expect_success 'rebase -i respects rebase.verboseCommit when rewording' '
+	rebase_setup_and_clean verbose-commit-reword &&
+	test_config rebase.verboseCommit true &&
+	test_set_editor "$PWD/reword-and-check-for-diff" &&
+	git rebase -i HEAD~1 &&
+	test_line_count -gt 0 has-diff
+'
+
+write_script "squash-and-check-for-diff" <<\EOF &&
+case "$1" in
+*/git-rebase-todo)
+	sed "s/pick \([0-9a-f]*\) E/squash \1 E/" "$1" > "$1.tmp"
+	mv -f "$1.tmp" "$1"
+	;;
+*)
+	grep '^diff --git' "$1" >has-diff
+	;;
+esac
+exit 0
+EOF
+
+test_expect_success 'rebase -i does not show diff by default when squashing' '
+	rebase_setup_and_clean no-verbose-commit-squash &&
+	test_set_editor "$PWD/squash-and-check-for-diff" &&
+	git rebase -i HEAD~2 &&
+	test_line_count = 0 has-diff
+'
+
+test_expect_success 'rebase -i respects rebase.verboseCommit when squashing' '
+	rebase_setup_and_clean verbose-commit-squash &&
+	test_config rebase.verboseCommit true &&
+	test_set_editor "$PWD/squash-and-check-for-diff" &&
+	git rebase -i HEAD~2 &&
+	test_line_count -gt 0 has-diff
+'
+
 test_done
-- 
2.20.1

