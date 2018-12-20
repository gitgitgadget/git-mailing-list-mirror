Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CA6B1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389290AbeLTTpB (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:45:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34157 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731612AbeLTTo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:44:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so2994801wrw.1
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mY7vCVVW5WN+pf2edAMLwHM9d7jaxC038SCALe+ipLM=;
        b=Mph3szaZr1ptJwq6CqXM89Coc9Q+KaoHSIQ8FXOjSHMxDgQ44uPBKeh3Tll0Bqawjx
         jfcCgCT4eCjWVAkvd/yLnVxHareV9UOo6xXZjx/GXy8wYSDGda32wVuwE0m3o3aTvvUy
         DDfW4k8zBUji5SVfseMQ8YEi4bexq02su+4BffCpJpxoWKaTd+/7+vpDQp1De1ldDKby
         zqSy/i9wBxXvxtcC4nbSXpJiUF9fVEBoSFQoQMs7vqzRUfkHAhGZy1IbGkE3LCIKUlfw
         WepxYC16FT6p8FttmDmJMWR8f6jj52lUIGAOY8I4Zs3qI6gTazNdJaPJBZl8rP6XOA0Q
         QzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mY7vCVVW5WN+pf2edAMLwHM9d7jaxC038SCALe+ipLM=;
        b=pNrwRTu6CnSf80CJTSJgUa5MJDIm/j4/gGWzwNodGjcdCSJmH1Y7hCi/iSrwJYv+Z4
         GPoUtz/fHu9RHZuIDCWoWzeos0gI3D9MtbE4VM8glMeL4EUiglxk4s9U0p94O1h16ncc
         +MryiQHqfQzydCKeuBKodtgYQ75cBrbllNt9AeeyyXZC2I86Hk2nvdVHmrhnT38rGhYJ
         nPk9TLdo0GuPmlaawkmQPQVB1SaAQ24z3AEtGI5lb6PVE2hzM7IhrhvChAfG9fAGZjs4
         CaJ8WCKSfy9q7akEqkUntD2Ar8yO8PUH+FDJHNgIVF41Q4F8XpKBOeBGY3UzJ+TZEWPL
         eLcA==
X-Gm-Message-State: AA+aEWbQi2m1EGQRtu0w4Uu6uEHcVJLa8wAEoujPmlsuCFkd4yse5oA5
        1ZSpQrJ4H3qAnJR6IvfxgIG9xPdQZFw=
X-Google-Smtp-Source: AFSGD/Um2iTDElipUMOLkzfvMUSiOwDw57Wt1Rn3Zyu+bTca+fwdfIGsu6Gt6jSwwiwLl03upj95yw==
X-Received: by 2002:adf:e8c1:: with SMTP id k1mr22406882wrn.104.1545335094932;
        Thu, 20 Dec 2018 11:44:54 -0800 (PST)
Received: from sebi-laptop.tendawifi.com ([188.24.227.76])
        by smtp.gmail.com with ESMTPSA id j129sm7587267wmb.39.2018.12.20.11.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:44:54 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v12 07/26] stash: rename test cases to be more descriptive
Date:   Thu, 20 Dec 2018 21:44:23 +0200
Message-Id: <f595ccc2c1b5dd439e8a6b86959d7a987cf9fb50.1545331726.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.20.1.336.g43b67505b2.dirty
In-Reply-To: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename some test cases' labels to be more descriptive and under 80
characters per line.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 t/t3903-stash.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 4e83facf23..98c25a671c 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -604,7 +604,7 @@ test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
 	test_cmp expected actual
 '
 
-test_expect_success 'stash drop - fail early if specified stash is not a stash reference' '
+test_expect_success 'drop: fail early if specified stash is not a stash ref' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD && git stash clear" &&
 	git reset --hard &&
@@ -618,7 +618,7 @@ test_expect_success 'stash drop - fail early if specified stash is not a stash r
 	git reset --hard HEAD
 '
 
-test_expect_success 'stash pop - fail early if specified stash is not a stash reference' '
+test_expect_success 'pop: fail early if specified stash is not a stash ref' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD && git stash clear" &&
 	git reset --hard &&
@@ -682,7 +682,7 @@ test_expect_success 'invalid ref of the form "n", n >= N' '
 	git stash drop
 '
 
-test_expect_success 'stash branch should not drop the stash if the branch exists' '
+test_expect_success 'branch: do not drop the stash if the branch exists' '
 	git stash clear &&
 	echo foo >file &&
 	git add file &&
@@ -693,7 +693,7 @@ test_expect_success 'stash branch should not drop the stash if the branch exists
 	git rev-parse stash@{0} --
 '
 
-test_expect_success 'stash branch should not drop the stash if the apply fails' '
+test_expect_success 'branch: should not drop the stash if the apply fails' '
 	git stash clear &&
 	git reset HEAD~1 --hard &&
 	echo foo >file &&
@@ -707,7 +707,7 @@ test_expect_success 'stash branch should not drop the stash if the apply fails'
 	git rev-parse stash@{0} --
 '
 
-test_expect_success 'stash apply shows status same as git status (relative to current directory)' '
+test_expect_success 'apply: show same status as git status (relative to ./)' '
 	git stash clear &&
 	echo 1 >subdir/subfile1 &&
 	echo 2 >subdir/subfile2 &&
@@ -1048,7 +1048,7 @@ test_expect_success 'stash push -p with pathspec shows no changes only once' '
 	test_i18ncmp expect actual
 '
 
-test_expect_success 'stash push with pathspec shows no changes when there are none' '
+test_expect_success 'push <pathspec>: show no changes when there are none' '
 	>foo &&
 	git add foo &&
 	git commit -m "tmp" &&
@@ -1058,7 +1058,7 @@ test_expect_success 'stash push with pathspec shows no changes when there are no
 	test_i18ncmp expect actual
 '
 
-test_expect_success 'stash push with pathspec not in the repository errors out' '
+test_expect_success 'push: <pathspec> not in the repository errors out' '
 	>untracked &&
 	test_must_fail git stash push untracked &&
 	test_path_is_file untracked
-- 
2.20.1.441.g764a526393

