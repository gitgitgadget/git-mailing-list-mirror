Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A3271F42D
	for <e@80x24.org>; Fri, 20 Apr 2018 21:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752085AbeDTVIY (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 17:08:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:51493 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751325AbeDTVIX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 17:08:23 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mh5h7-1enp811Rar-00MNNN; Fri, 20
 Apr 2018 23:08:20 +0200
Date:   Fri, 20 Apr 2018 23:08:04 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 4/4] rebase --skip: clean up commit message after a failed
 fixup/squash
In-Reply-To: <cover.1524258351.git.johannes.schindelin@gmx.de>
Message-ID: <31cb9f9c534a4d0c47d67cc61619c0a9bb56c56c.1524258351.git.johannes.schindelin@gmx.de>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com> <cover.1524258351.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:AfP/iz/CTcrqZs6Rsg5CghG+gDZ7XYP1xFty4KShOp3ZJCxxL1U
 8emYYokZbBfxlx7p8a+BlEYmlHLSkilFSxECQMWTKGlBdSKjQ8z8D8njUDgAbOzLDz9P96H
 fqb5VLNWsVX6qXvROWWbEr5gEcuJNCpKuQFFQ4DLk+zA6mWjmL+VZIRmKjwvadFK6w0v2hn
 kb2lN72JysESKtgV5Qw5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:s6j3KoXgxBI=:wQoQvXLn7UdlZyHO1/cX/+
 ow4prw9KHa6bqLe2ZdDfCzsQ9U82Uv+WTb73bOSDeUJVZeuU/HWbZclLy/NzIZOqH3A8tuYOD
 qH6DhLPdDomArNTqELXB0LfxlgNRd6gJ95FrIdkWfmNGd/A+T5J9w5xZ0X0t+szIW1ASWVYpO
 1P48pXlGZWyP5eQQ1aVcLC0woBvCaL7Wv5gqSD+53JDsAbLw1iozFwYMD2OtLthvDV9wu5bKe
 XyaIFrFPrSCHe0izEMcTwei+eSlMTJT5/zWymulqQeAonE/UCZRa3UfTvTJ7Ue75EBmZJN2h1
 7Psv4f93hVc5UFMsSPmd6mTVhbQrH62Gy8/sEtZjhFiKIFoPkv1Ki4SXgQbn15KsUzS8jA++v
 zjNiLG12qDvV/FVKcZ1RJ8HX+65t31EhNK3Moac2rWIzALKQNBGQ9rH57DQoYqQ9KDnE+5RwZ
 x1bakrTYijSUJOMXmf7wle/zaDdRlas8AXg+0WCFoKJeXYUn9rYLfo9fnnmE3jva3KlDsN7WC
 G1LdH27Viq/UGk6rTVR1X/J7nyfiQbjra7U7H5gzoBqv+DeH6hX87nNViuvDl3/VVPPA6jaG5
 6LO/34sHxigGTYIH8TsATTBHKak2FeJTwkSOaPgL9uWSdt2DwtMYCoCPJwCgT5L3AoFv3NWeK
 WBloUQerfAS7ydDQ8he3u8pLiZq1wUUFxcwEf6KfV7ZRZpH2ChM3deCmeciSagdR4yVBoabmf
 kZT2qcNrif49z4l1NQHGO4mDvbDo5VAwtTSi6I5ryVTBnuFQEzGRf+PL8tHjAnM7rhmh/wIM0
 Arwjkvt2K41T8OPtNPxPKmYqrqD7hzgsUEtCCHfOw5DdpVqU4U=
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
index a6a4efeaae2..881503a6463 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2789,17 +2789,12 @@ static int continue_single_pick(void)
 
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
@@ -2812,16 +2807,41 @@ static int commit_staged_changes(struct replay_opts *opts)
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
