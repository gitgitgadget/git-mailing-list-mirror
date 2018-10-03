Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A07C1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 15:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeJCVtJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 17:49:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37386 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJCVtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 17:49:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id az3-v6so3617645plb.4
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 08:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vQJCeMQH+T5I0zx8MJTVY7L957YxJ9IacuzDrLNiqSM=;
        b=Y5Oy6Mf3k0/1725jxH3GAmR6BvBjP34OA9FBe0y0UCfCEIjWdEQARptGblS+btGNIh
         JxvLI3ZkM7lHLvusRkuuuvyNEjdJlhzk4eDJfmXo7WLBDASyHa0lWkgNAWEp3++wzmuS
         JuU+LjuH5pFWtpPhClvsdcvnCwoPSzuWFITDdahvXlCf1TsH1w6UVHpArjSDjk75THpL
         e9n6kN8K5hhs4o5iFqiFpZdxY1SwHbYl7aOS2aGl2ZPfCimUCXi4lXNXfGNgAcRbR/KH
         DoilTTTaqCnLOKVcqJJL6MxenXl938K5rdt/tH3qXNQ18M4EQitk/elYJT+c4dcrB55M
         pn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vQJCeMQH+T5I0zx8MJTVY7L957YxJ9IacuzDrLNiqSM=;
        b=EdThhWVb0jl0KZzFZG7aj3V3qoIb4syTOnmNH4OLkni0AWY9IfCIDB7SUGXg5MscIk
         jqVu+DAQ3D1YCPILHBzxkbcN3YWPGMZhVIc3RR3hStwWcl/2+pdpje/zyI9Ps9K6xDKR
         f3CoiQSMDGNbwK/tY+UU64w9WNxYPAvoFHysyadQqe8FmNq+EiA+B2DLNuwCibPia684
         Gg+Sp7nNL0MYGrab4G3SGknmoYIFlC3jMlr0GIUCpZwFbLjOAS20wVcO6y0+IRvRZGO0
         a2EbSrhyeRGofDyfcpmGvJOliNqs9ltYF5Nv+WGfxPXCjla8iSDYkanI8jO7zAEi+Asu
         m9nA==
X-Gm-Message-State: ABuFfoil1l+Mv5H1DpVAbMkRa9aqVnlH9tyMosMiFUlZtHQOO6ddpvgV
        EYs9Bjgz5hSMCQuhNwc7lRADep/f
X-Google-Smtp-Source: ACcGV63dAwdOzcwsVhCAPMbgXiGn3CwUBNJTModeL0J258ZZ+3arEbWsEc76oQTIYDk5OBTUk0tuKw==
X-Received: by 2002:a17:902:2e83:: with SMTP id r3-v6mr2101129plb.80.1538578822664;
        Wed, 03 Oct 2018 08:00:22 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id 22-v6sm3384547pfl.126.2018.10.03.08.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 08:00:21 -0700 (PDT)
Date:   Wed, 03 Oct 2018 08:00:21 -0700 (PDT)
X-Google-Original-Date: Wed, 03 Oct 2018 15:00:18 GMT
Message-Id: <b358178548bdc9134d4e4b83b1d0384ebb257a72.1538578818.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.43.git.gitgitgadget@gmail.com>
References: <pull.43.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] rebase -i: introduce the 'break' command
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

This commit introduces that functionality, as the spanking new 'break' command.

Suggested-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 rebase-interactive.c       | 1 +
 sequencer.c                | 7 ++++++-
 t/lib-rebase.sh            | 2 +-
 t/t3418-rebase-continue.sh | 9 +++++++++
 4 files changed, 17 insertions(+), 2 deletions(-)

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
