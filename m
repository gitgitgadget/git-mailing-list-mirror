Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C67441F424
	for <e@80x24.org>; Sat, 21 Apr 2018 07:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751433AbeDUHj0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 03:39:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:58293 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750931AbeDUHj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 03:39:26 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MAQMg-1fFnNo0Syo-00BfxO; Sat, 21
 Apr 2018 09:39:22 +0200
Date:   Sat, 21 Apr 2018 09:39:05 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 4/4] rebase --skip: clean up commit message after a failed
 fixup/squash
In-Reply-To: <cover.1524296064.git.johannes.schindelin@gmx.de>
Message-ID: <5523b5b5ed7a7fa8433465a8eaf7909361501365.1524296064.git.johannes.schindelin@gmx.de>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com> <cover.1524296064.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IRfpK1FU3gH3hqPXNsXn7j2yE8DhBZH6irvaMm4cJu3i35O/mCZ
 mRbUO88mJN0qrLfu9umc3EzqycCqmzv3FnyHUiWeS3vgEwsvG2uaoHOkeZiLAtk4nIQsyOy
 uVR/TJUF3kIOTOWQblD7HPiHMPOSBbYaMAyjVnuPY5HGH2nJYhpvQbeG4T+tIei7sNzFFwb
 5yLlZw+F/uq2HS3QZjxEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vflSW/63qL8=:pYFyQ6lNEAtrrbAbfMCJgo
 Ul8yXd/pN+DUtm23isS7aXv1drW72kG3FfmDck5irh2baDHHAfyZ3rMX++N9+c0kK32hTAdNA
 qAxVQh47krK0ZIa1xVZQFZQJL4oZuOBx+qL0xZNFfZ2Ec+rNXwpNkfkIEcuTi5hlYKInLVfBT
 VBIkCzDATGmuFEN56bHfYCT+y/snGkvvMedVfB+Lr34ZFqtu07izLFCNapwro0nsahBU6Tdcc
 ZEP2V2xZsTrCuMgTW0IpYCUJ/NJ+BMHDSqQTcDXz3uXCZs4XmrOjIPihGboGqQLw/Mq4x3pM2
 kUFcyDjhWqjbE4wVEoKLJXLZn5VlDW89Q2Zj9i7qGViuauIiGee8HdtO59EOUGK2xrcpNH5sR
 PsaK0eNf8t9IvwvzpGCil+/ZnC8FPUPnv9jESUSoXApHj7YIzqLN/zyvq22/Wdo+830Wc6RY0
 H+KhgaNXHcF5o05SqyYwYGWfS8guRwUtTH9HUm/r/9bp6npBB51iledJbbj5jzlJRplZqevZD
 pHXYSZudhV4cA/SFWrZGMi99xlFRi29suMrYcS1XWGIIgDnClcWZfWu+CigOUAhyWeAKAAfmJ
 Qj5L28xDNhklRI2H3IwjhyMHpWYT5sz5doiQtEtjdFdLB95prg0cExq4tUFimXoDGbGKJHgT8
 RAt8jn3y6/OKS13sA+HC4RaOekhmJuErTRzBOCCLhl9FaglEHKRhxI+YPGM/vMLP7wilhApvo
 lHlPb8suyAuye4C5juETQ1WdkNhNFo7zfzfgMNULDqQ6KZiyaG534ZwJlhuDVGl+6JOMzBBOC
 AZOx0AJJfzrzmkSJnlHUd7PSt8y56HW9np35JXu79d9Rv4zbHQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During a series of fixup/squash commands, the interactive rebase builds
up a commit message with comments. This will be presented to the user in
the editor if at least one of those commands was a `squash`.

However, if the last of these fixup/squash commands fails with merge
conflicts, and if the user then decides to skip it (or resolve it to a
clean worktree and then continue the rebase), the current code fails to
clean up the commit message.

This commit fixes that behavior.

The diff is best viewed with --color-moved.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c                | 36 ++++++++++++++++++++++++++++--------
 t/t3418-rebase-continue.sh |  2 +-
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 9a85b705a84..b8b72fd540f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2790,17 +2790,12 @@ static int continue_single_pick(void)
 
 static int commit_staged_changes(struct replay_opts *opts)
 {
-	unsigned int flags = ALLOW_EMPTY | EDIT_MSG;
+	unsigned int flags = ALLOW_EMPTY | EDIT_MSG, is_fixup = 0, is_clean;
 
 	if (has_unstaged_changes(1))
 		return error(_("cannot rebase: You have unstaged changes."));
-	if (!has_uncommitted_changes(0)) {
-		const char *cherry_pick_head = git_path_cherry_pick_head();
 
-		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
-			return error(_("could not remove CHERRY_PICK_HEAD"));
-		return 0;
-	}
+	is_clean = !has_uncommitted_changes(0);
 
 	if (file_exists(rebase_path_amend())) {
 		struct strbuf rev = STRBUF_INIT;
@@ -2813,16 +2808,41 @@ static int commit_staged_changes(struct replay_opts *opts)
 		if (get_oid_hex(rev.buf, &to_amend))
 			return error(_("invalid contents: '%s'"),
 				rebase_path_amend());
-		if (oidcmp(&head, &to_amend))
+		if (!is_clean && oidcmp(&head, &to_amend))
 			return error(_("\nYou have uncommitted changes in your "
 				       "working tree. Please, commit them\n"
 				       "first and then run 'git rebase "
 				       "--continue' again."));
+		if (is_clean && !oidcmp(&head, &to_amend)) {
+			strbuf_reset(&rev);
+			/*
+			 * Clean tree, but we may need to finalize a
+			 * fixup/squash chain. A failed fixup/squash leaves the
+			 * file amend-type in rebase-merge/; It is okay if that
+			 * file is missing, in which case there is no such
+			 * chain to finalize.
+			 */
+			read_oneliner(&rev, rebase_path_amend_type(), 0);
+			if (!strcmp("squash", rev.buf))
+				is_fixup = TODO_SQUASH;
+			else if (!strcmp("fixup", rev.buf)) {
+				is_fixup = TODO_FIXUP;
+				flags = (flags & ~EDIT_MSG) | CLEANUP_MSG;
+			}
+		}
 
 		strbuf_release(&rev);
 		flags |= AMEND_MSG;
 	}
 
+	if (is_clean && !is_fixup) {
+		const char *cherry_pick_head = git_path_cherry_pick_head();
+
+		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
+			return error(_("could not remove CHERRY_PICK_HEAD"));
+		return 0;
+	}
+
 	if (run_git_commit(rebase_path_message(), opts, flags))
 		return error(_("could not commit staged changes."));
 	unlink(rebase_path_amend());
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 6ddf952b7b9..693f92409ec 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -88,7 +88,7 @@ test_expect_success 'rebase passes merge strategy options correctly' '
 	git rebase --continue
 '
 
-test_expect_failure '--skip after failed fixup cleans commit message' '
+test_expect_success '--skip after failed fixup cleans commit message' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout -b with-conflicting-fixup &&
 	test_commit wants-fixup &&
-- 
2.17.0.windows.1.15.gaa56ade3205
