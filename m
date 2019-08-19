Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A33261F461
	for <e@80x24.org>; Mon, 19 Aug 2019 09:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfHSJS0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 05:18:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42979 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfHSJSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 05:18:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id b16so7900750wrq.9
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 02:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=M0hcebQaKPWpKz3XqdQZBNPF1dcodVjx5QRnb/Fq8to=;
        b=TEy7ZXaiJztpPp7EoGunIxKF3Nl1hBJisxFHoLjsCbHhPCusIhKRz3z2SUplTkO/pK
         E4K8CfPan8e6iiaj37ohFSRLzelCas9DtDsz1P2aI1AJ/Fbm1xXhoD4eAg0Xb7r3eWbk
         +7umkdn/t1mszaWpHdRXZOADhTbq6PIR106HzhHv+drZUU/d6xnS+8/uM4JGBh4BzTv5
         +1IFQ/+sMPAIwQah0BuddVNjRIOWvp4mbYAwlBlih2PW8S4F8whJo8QrG++lPYjoiqTW
         br4Mp5d9DVhnL7cmFOgwjpTBvFOpHmV2YHjvZJ2P1Xoj+fYXsWXZaMolbwTcAFfyp3Mu
         rFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=M0hcebQaKPWpKz3XqdQZBNPF1dcodVjx5QRnb/Fq8to=;
        b=hdvtswmSPryfQfpnxtr15Ddn7lmJq+5BpU509h5YS/0jo24/aGztciG8Wvr+K0PRHE
         Cnow1Yb4Q8k4o8NdeYCgalcOhkiNy2GevhTO+FjJGdNIb8ac66do2Ys4+zvmad+CQCjx
         8sQtQVl0Vwp2E39sVnh1osbSFOGV+tBklykhlmXgMFG3sTJo47bby3/8DNLyRcNsklHh
         qnmOa3Faj1I+hmmaIBm48Z9qYHW0AfSk0fI7YSpEC52mZRrm8b3hQK8QQUkYwxq0WWwh
         /AaERGlDPeNSv0OCInnSShtbciKqmWUeV3MbhRmLdR6KMRQPlH0OptZp1LyEpqEA3sd9
         HwTg==
X-Gm-Message-State: APjAAAVb1S4D3o6TNuhDc5zj/B7VpN11LVzoumpmfmAcIbO3l+EUhXQ6
        ryxtc1Wh9cPkyK7yxdib7at4y5H3
X-Google-Smtp-Source: APXvYqwguxZgCykx97bXPF6Guu+p4seByZKEqJ3mb6XzxUoci2sVtmwcyV4AtCIvKaKFKHdmKnNlsg==
X-Received: by 2002:a05:6000:1041:: with SMTP id c1mr24367575wrx.99.1566206302224;
        Mon, 19 Aug 2019 02:18:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f10sm12969787wrm.31.2019.08.19.02.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 02:18:21 -0700 (PDT)
Date:   Mon, 19 Aug 2019 02:18:21 -0700 (PDT)
X-Google-Original-Date: Mon, 19 Aug 2019 09:18:18 GMT
Message-Id: <628939679c63e735b1f81a9da11c31e1bbc929e3.1566206300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.312.git.gitgitgadget@gmail.com>
References: <pull.312.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/3] rebase -i: always update HEAD before rewording
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the user runs git log while rewording a commit it is confusing if
sometimes we're amending the commit that's being reworded and at other
times we're creating a new commit depending on whether we could
fast-forward or not[1]. Fix this inconsistency by always committing the
picked commit and then running 'git commit --amend' to do the reword.

The first commit is performed by the sequencer without forking git
commit and does not impact on the speed of rebase. In a test rewording
100 commits with

    GIT_EDITOR=true GIT_SEQUENCE_EDITOR='sed -i s/pick/reword/' \
	../bin-wrappers/git rebase -i --root

and taking the best of three runs the current master took
957ms and with this patch it took 961ms.

This change fixes rewording the new root commit when rearranging commits
with --root.

Note that the new code no longer updates CHERRY_PICK_HEAD after creating
a root commit - I'm not sure why the old code was that creating that ref
after a successful commit, everywhere else it is removed after a
successful commit.

[1] https://public-inbox.org/git/xmqqlfvu4be3.fsf@gitster-ct.c.googlers.com/T/#m133009cb91cf0917bcf667300f061178be56680a

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                        | 19 +++++++++++--------
 t/t3404-rebase-interactive.sh      | 16 +++++++++++++---
 t/t7505-prepare-commit-msg-hook.sh |  8 +-------
 t/t7505/expected-rebase-i          |  3 ++-
 4 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 34ebf8ed94..085777f4a1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -986,12 +986,10 @@ static int run_git_commit(struct repository *r,
 
 		strbuf_release(&msg);
 		strbuf_release(&script);
-		if (!res) {
-			update_ref(NULL, "CHERRY_PICK_HEAD", &root_commit, NULL,
-				   REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR);
+		if (!res)
 			res = update_ref(NULL, "HEAD", &root_commit, NULL, 0,
 					 UPDATE_REFS_MSG_ON_ERR);
-		}
+
 		return res < 0 ? error(_("writing root commit")) : 0;
 	}
 
@@ -1785,7 +1783,7 @@ static int do_pick_commit(struct repository *r,
 	char *author = NULL;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	struct strbuf msgbuf = STRBUF_INIT;
-	int res, unborn = 0, allow;
+	int res, unborn = 0, reword = 0, allow;
 
 	if (opts->no_commit) {
 		/*
@@ -1855,7 +1853,7 @@ static int do_pick_commit(struct repository *r,
 			opts);
 		if (res || command != TODO_REWORD)
 			goto leave;
-		flags |= EDIT_MSG | AMEND_MSG | VERIFY_MSG;
+		reword = 1;
 		msg_file = NULL;
 		goto fast_forward_edit;
 	}
@@ -1913,7 +1911,7 @@ static int do_pick_commit(struct repository *r,
 	}
 
 	if (command == TODO_REWORD)
-		flags |= EDIT_MSG | VERIFY_MSG;
+		reword = 1;
 	else if (is_fixup(command)) {
 		if (update_squash_messages(r, command, commit, opts))
 			return -1;
@@ -1997,13 +1995,18 @@ static int do_pick_commit(struct repository *r,
 	} else if (allow)
 		flags |= ALLOW_EMPTY;
 	if (!opts->no_commit) {
-fast_forward_edit:
 		if (author || command == TODO_REVERT || (flags & AMEND_MSG))
 			res = do_commit(r, msg_file, author, opts, flags);
 		else
 			res = error(_("unable to parse commit author"));
+		if (!res && reword)
+fast_forward_edit:
+			res = run_git_commit(r, NULL, opts, EDIT_MSG |
+					     VERIFY_MSG | AMEND_MSG |
+					     (flags & ALLOW_EMPTY));
 	}
 
+
 	if (!res && final_fixup) {
 		unlink(rebase_path_fixup_msg());
 		unlink(rebase_path_squash_msg());
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 461dd539ff..d2f1d5bd23 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1016,9 +1016,9 @@ test_expect_success 'rebase -i --root fixup root commit' '
 	test 0 = $(git cat-file commit HEAD | grep -c ^parent\ )
 '
 
-test_expect_success 'rebase -i --root reword root commit' '
+test_expect_success 'rebase -i --root reword original root commit' '
 	test_when_finished "test_might_fail git rebase --abort" &&
-	git checkout -b reword-root-branch master &&
+	git checkout -b reword-original-root-branch master &&
 	set_fake_editor &&
 	FAKE_LINES="reword 1 2" FAKE_COMMIT_MESSAGE="A changed" \
 	git rebase -i --root &&
@@ -1026,6 +1026,16 @@ test_expect_success 'rebase -i --root reword root commit' '
 	test -z "$(git show -s --format=%p HEAD^)"
 '
 
+test_expect_success 'rebase -i --root reword new root commit' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout -b reword-now-root-branch master &&
+	set_fake_editor &&
+	FAKE_LINES="reword 3 1" FAKE_COMMIT_MESSAGE="C changed" \
+	git rebase -i --root &&
+	git show HEAD^ | grep "C changed" &&
+	test -z "$(git show -s --format=%p HEAD^)"
+'
+
 test_expect_success 'rebase -i --root when root has untracked file conflict' '
 	test_when_finished "reset_rebase" &&
 	git checkout -b failing-root-pick A &&
@@ -1054,7 +1064,7 @@ test_expect_success 'rebase -i --root reword root when root has untracked file c
 '
 
 test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on non-interactive rebase' '
-	git checkout reword-root-branch &&
+	git checkout reword-original-root-branch &&
 	git reset --hard &&
 	git checkout conflict-branch &&
 	set_fake_editor &&
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index ba8bd1b514..94f85cdf83 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -241,13 +241,7 @@ test_rebase () {
 			git add b &&
 			git rebase --continue
 		) &&
-		if test "$mode" = -p # reword amended after pick
-		then
-			n=18
-		else
-			n=17
-		fi &&
-		git log --pretty=%s -g -n$n HEAD@{1} >actual &&
+		git log --pretty=%s -g -n18 HEAD@{1} >actual &&
 		test_cmp "$TEST_DIRECTORY/t7505/expected-rebase${mode:--i}" actual
 	'
 }
diff --git a/t/t7505/expected-rebase-i b/t/t7505/expected-rebase-i
index c514bdbb94..93bada596e 100644
--- a/t/t7505/expected-rebase-i
+++ b/t/t7505/expected-rebase-i
@@ -7,7 +7,8 @@ message (no editor) [edit rebase-10]
 message [fixup rebase-9]
 message (no editor) [fixup rebase-8]
 message (no editor) [squash rebase-7]
-message [reword rebase-6]
+HEAD [reword rebase-6]
+message (no editor) [reword rebase-6]
 message [squash rebase-5]
 message (no editor) [fixup rebase-4]
 message (no editor) [pick rebase-3]
-- 
gitgitgadget

