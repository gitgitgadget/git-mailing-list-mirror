Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E54C21F97F
	for <e@80x24.org>; Wed, 10 Oct 2018 08:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeJJQPJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 12:15:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45487 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeJJQPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 12:15:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id u12-v6so2271813pfn.12
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 01:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ckgacp4rsEhUTdQjhj1DsudxXArghGVFtZyPzk/qqJI=;
        b=raFGKXJFGBgNSsZAjyN7+5+Y/5PrxYiwSaf307bnhjNDLXvtJ4kfmZlgHPuuSz48nz
         mIU3jXbCvCpDDzcirlKjEB+RjyHTb4bhuW5d6S96mxam0BMXoZWr0quz/WqOd3EYlK4E
         MopVIZewTJvTg9UxKI+xyD60pu8jg7n+BlYW5B0JwRNMibk/c78iotzWMF1vnRJIeL/f
         gV15iQluN8PKz5Y8T/2+HKLffyAuYbcRwzg54falnMLQhMduMubsaqqnftThDt56LvCp
         0dGWr86x2UzhbAF+uq4hHesvwNZCAOSDCcVXXSYf+Vl1bpbm704Q1fLTw2B5Fi8CW6Rf
         dN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ckgacp4rsEhUTdQjhj1DsudxXArghGVFtZyPzk/qqJI=;
        b=IH/OUuUkA0M2YiYYG7jxZ9h5OM4rEWvryhxJMXWIKdVHEzCckZXMhzh5o/nc+EA6BK
         CDNkwpXoJ7q14a+ZmeC34yKtl0TVJy3ZCYy3s5LuX8s56DfFzjYxXoEDQJZW09qMCPd5
         E8YWETa++ozwWN5EjnNwK745qc1K4wAQjhYARiKxMyrtFxyDjEPJVQUHMINk9uZTahf5
         fqLOph3EOzrzxaTHrhUZpeSQP6WK+dCtC5eZB0P7DxeGvmvx4YzVWJbERrCOd4aTD2Em
         wGr8qqyxlwVwWo0+mo9xIkHOkVkvR7MiTgTi9cONKMoDIyi47mYaUfgWtqfR4O533hMX
         ZiIA==
X-Gm-Message-State: ABuFfojwac2QnhxYm68KDRryDMLU9Tx80BZ4OPEif3+LucWMsw3Ye33j
        maqf+Bxby6arg9+sz+D2Uvnzqy8m
X-Google-Smtp-Source: ACcGV63Qs1TFMyKva/J2wQATgFUjkCPgY/L32DaSyNEl+eYWroTvkcg4hrrfPGBJVIsyHNH/ZyXiIQ==
X-Received: by 2002:a62:3995:: with SMTP id u21-v6mr34155017pfj.116.1539161638666;
        Wed, 10 Oct 2018 01:53:58 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id l16-v6sm36090831pfj.179.2018.10.10.01.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 01:53:57 -0700 (PDT)
Date:   Wed, 10 Oct 2018 01:53:57 -0700 (PDT)
X-Google-Original-Date: Wed, 10 Oct 2018 08:53:52 GMT
Message-Id: <c74e02c4b643652d43108c1a5a675df0fae5f059.1539161632.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.43.v2.git.gitgitgadget@gmail.com>
References: <pull.43.git.gitgitgadget@gmail.com>
        <pull.43.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/2] rebase -i: introduce the 'break' command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The 'edit' command can be used to cherry-pick a commit and then
immediately drop out of the interactive rebase, with exit code 0, to let
the user amend the commit, or test it, or look around.

Sometimes this functionality would come in handy *without*
cherry-picking a commit, e.g. to interrupt the interactive rebase even
before cherry-picking a commit, or immediately after an 'exec' or a
'merge'.

This commit introduces that functionality, as the spanking new 'break'
command.

Suggested-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-rebase.txt | 3 +++
 rebase-interactive.c         | 1 +
 sequencer.c                  | 7 ++++++-
 t/lib-rebase.sh              | 2 +-
 t/t3418-rebase-continue.sh   | 9 +++++++++
 5 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index db2faca73c..5bed1da36b 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -561,6 +561,9 @@ By replacing the command "pick" with the command "edit", you can tell
 the files and/or the commit message, amend the commit, and continue
 rebasing.
 
+To interrupt the rebase (just like an "edit" command would do, but without
+cherry-picking any commit first), use the "break" command.
+
 If you just want to edit the commit message for a commit, replace the
 command "pick" with the command "reword".
 
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 0f4119cbae..78f3263fc1 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -14,6 +14,7 @@ void append_todo_help(unsigned edit_todo, unsigned keep_empty,
 "s, squash <commit> = use commit, but meld into previous commit\n"
 "f, fixup <commit> = like \"squash\", but discard this commit's log message\n"
 "x, exec <command> = run command (the rest of the line) using shell\n"
+"b, break = stop here (continue rebase later with 'git rebase --continue')\n"
 "d, drop <commit> = remove commit\n"
 "l, label <label> = label current HEAD with a name\n"
 "t, reset <label> = reset HEAD to a label\n"
diff --git a/sequencer.c b/sequencer.c
index 8dd6db5a01..b209f8af46 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1416,6 +1416,7 @@ enum todo_command {
 	TODO_SQUASH,
 	/* commands that do something else than handling a single commit */
 	TODO_EXEC,
+	TODO_BREAK,
 	TODO_LABEL,
 	TODO_RESET,
 	TODO_MERGE,
@@ -1437,6 +1438,7 @@ static struct {
 	{ 'f', "fixup" },
 	{ 's', "squash" },
 	{ 'x', "exec" },
+	{ 'b', "break" },
 	{ 'l', "label" },
 	{ 't', "reset" },
 	{ 'm', "merge" },
@@ -1964,7 +1966,7 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	padding = strspn(bol, " \t");
 	bol += padding;
 
-	if (item->command == TODO_NOOP) {
+	if (item->command == TODO_NOOP || item->command == TODO_BREAK) {
 		if (bol != eol)
 			return error(_("%s does not accept arguments: '%s'"),
 				     command_to_string(item->command), bol);
@@ -3293,6 +3295,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			unlink(rebase_path_stopped_sha());
 			unlink(rebase_path_amend());
 			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
+
+			if (item->command == TODO_BREAK)
+				break;
 		}
 		if (item->command <= TODO_SQUASH) {
 			if (is_rebase_i(opts))
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 25a77ee5cb..584604ee63 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -49,7 +49,7 @@ set_fake_editor () {
 		case $line in
 		squash|fixup|edit|reword|drop)
 			action="$line";;
-		exec*)
+		exec*|break)
 			echo "$line" | sed 's/_/ /g' >> "$1";;
 		"#")
 			echo '# comment' >> "$1";;
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index c145dbac38..185a491089 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -239,5 +239,14 @@ test_rerere_autoupdate -m
 GIT_SEQUENCE_EDITOR=: && export GIT_SEQUENCE_EDITOR
 test_rerere_autoupdate -i
 test_rerere_autoupdate --preserve-merges
+unset GIT_SEQUENCE_EDITOR
+
+test_expect_success 'the todo command "break" works' '
+	rm -f execed &&
+	FAKE_LINES="break exec_>execed" git rebase -i HEAD &&
+	test_path_is_missing execed &&
+	git rebase --continue &&
+	test_path_is_file execed
+'
 
 test_done
-- 
gitgitgadget
