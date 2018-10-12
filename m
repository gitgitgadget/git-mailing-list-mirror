Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD07A1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 13:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeJLUqw (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 16:46:52 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40725 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbeJLUqw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 16:46:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id n31-v6so5841836pgm.7
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yRcZO08AMwfu94oKwcRzM9e3tm7gKNl1kq2VUmqpeYU=;
        b=eVHV1UNacV6bhaudVPDG6X+4OvU61Bdq5lErfjIuMG2ANi6gaQtcjghoIvE0UbB+Q/
         IqXvrQBz0AiIIzk4WZp+fRDqD3xrBCZKDB1VCBP9kPE7tjr1IRYXYRK5a2yMlJ2oPrrl
         +1INDJTbIScCw4PSSh5Y0saguLrOkCG9OBtuZizs/p7eyWrsGl0SycNC74qjrktUdKlf
         ePjPywonzXqruNAfYsz7aKQDLY5qHOMNHz5BxNTv/Tw4fRHj4OLy1LORDJq2jheHFySO
         0qENxILqonDbUEAl2ED6VikkMHgsPWmiO2KW2Sl93B8o9CHIS67Dw0xoGEV0JD13dNiK
         Q3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yRcZO08AMwfu94oKwcRzM9e3tm7gKNl1kq2VUmqpeYU=;
        b=gkVFz8KM6lvsFi2WzgHN0cafA1kmznJCnz+RB6jMxiZKJEFk1+R1EGUE+Bx1Jt97gH
         fattcMylbwxw8kFR/PUCk1vZAHbV6uEhXQcDbLB4PYB3ChrmuawTuL97QokZ2NmsQdk/
         JyaGZfhOVC4jBqFWfhi4DJMomK4L4ayJhxd3dIMOrMIyA6gVq4mhfSkW6GFXR6SW/b/Y
         GVdZJmwYr5ct2KDrdzl325c978hzpiU503IxgCKwAopTj/uj4xbhWVl73nuTJSP64RMN
         7OsnvMkZ8zgcyRPjAf2n/dqzr5G+bUqm3gXr1HU/FIsaoBp90vI3LqHvmUkBZVh8gIhN
         1xGQ==
X-Gm-Message-State: ABuFfoikwQ28M6rPeqJlihpKSSU+I5dOS7B8WUIukqAaJHJJwQCZhOaD
        ZdPMVaRxijRc/LjlUim4FHHaEUtv
X-Google-Smtp-Source: ACcGV61PE5p8olf0EuZTLcZi2o53GYYWg49QlAxx8FOB2qXPIKglILMz83bVNMgSHTV7gX45yGcGQA==
X-Received: by 2002:a65:65c6:: with SMTP id y6-v6mr5374366pgv.233.1539350067251;
        Fri, 12 Oct 2018 06:14:27 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id a190-v6sm2003994pge.47.2018.10.12.06.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 06:14:26 -0700 (PDT)
Date:   Fri, 12 Oct 2018 06:14:26 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Oct 2018 13:14:21 GMT
Message-Id: <d44b425709d11eed833558c8bedfe4aeaa230e24.1539350061.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.43.v3.git.gitgitgadget@gmail.com>
References: <pull.43.v2.git.gitgitgadget@gmail.com>
        <pull.43.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 2/2] rebase -i: introduce the 'break' command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
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
 Documentation/git-rebase.txt |  3 +++
 rebase-interactive.c         |  1 +
 sequencer.c                  | 24 +++++++++++++++++++++++-
 t/lib-rebase.sh              |  2 +-
 t/t3418-rebase-continue.sh   |  9 +++++++++
 5 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index d9771bd25b..6b71694b0d 100644
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
index 8dd6db5a01..ee3961ec63 100644
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
@@ -3247,6 +3249,23 @@ static int checkout_onto(struct replay_opts *opts,
 	return update_ref(NULL, "ORIG_HEAD", &oid, NULL, 0, UPDATE_REFS_MSG_ON_ERR);
 }
 
+static int stopped_at_head(void)
+{
+	struct object_id head;
+	struct commit *commit;
+	struct commit_message message;
+
+	if (get_oid("HEAD", &head) || !(commit = lookup_commit(&head)) ||
+	    parse_commit(commit) || get_message(commit, &message))
+		fprintf(stderr, _("Stopped at HEAD\n"));
+	else {
+		fprintf(stderr, _("Stopped at %s\n"), message.label);
+		free_message(commit, &message);
+	}
+	return 0;
+
+}
+
 static const char rescheduled_advice[] =
 N_("Could not execute the todo command\n"
 "\n"
@@ -3293,6 +3312,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			unlink(rebase_path_stopped_sha());
 			unlink(rebase_path_amend());
 			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
+
+			if (item->command == TODO_BREAK)
+				return stopped_at_head();
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
