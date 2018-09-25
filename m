Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB2BF1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbeIZEoM (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:44:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42175 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725762AbeIZEoL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:44:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id b20-v6so173347edr.9
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KFLUdGyAoCQ/P6vsfCnkNBod4LJcQgYQtSEWkoG/Wbw=;
        b=GHalHaYCi4sDpOpK4Uww0Dri9l63+WptiMzQA1uPr7n/4ff7dGJD1eDb3yJ1Bs9mj0
         r0dycedgR5vgRfmpl0rsCOrGTQcngrxhlt0T7Ac6S3EAfZUYPqjDZd7e/hqdrcmyRasw
         9YaDdFdR5c8Ypg6kDA5v/k0xlMK9MD0rK8EZUq4FDTEKf7G/DBGV+zr7EXQp86EW7DLC
         RK8UqvPJy0teXrd5uorGbu88PGtWpvAFJRScTg1YIzWNTlLs0jCzbsrLo6ST+dutf2gT
         fuFW3rpC7IRNWi0ZgJSlBLv3NrPG2bzPpz+Ykxo455oA6w3IxL17fqwznDLPPM0Bci8Y
         v5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KFLUdGyAoCQ/P6vsfCnkNBod4LJcQgYQtSEWkoG/Wbw=;
        b=lJEHA1WwCRgiUKjIIA8Kba4Z1Oo3BA5iXUnsgIQ4Vw46Ulqrm+GpP6MKbF8FyWk8od
         b1T5lRFOAR9dWqwHZzOE+rPRnFVCxNvnHoK6SLecuLi2aUjmvCc6Btwgyw4y7IT689jq
         7ukP2AN6RwEssePBG7g6NOeN+MqIwkK7oe4pLT4xCdUdF/bFoKsM4au2z8iw+qV869GB
         PT3r3fmptAjjddpdOMrXqcNx1kZUgnsuxwXlL/iABZu0GBxNCeAbytTAqXA6Xv3RiKCf
         vv6N906ItvBKT7rRTckdCRYaGEv2N3H1wShmIwXaJwRPz3yxbdnBlQ9RKc/XMybKNI3C
         z1Fw==
X-Gm-Message-State: ABuFfojtGKgWYsNnybeWXdDr4h8OsiFpWIIeO0I59U4MFiRH/uk0LO/i
        9mymTUK1ZdEexlhsHwMdBSsbAV+Z
X-Google-Smtp-Source: ACcGV61Daapu2Fo8Kc8uIMKffDi9bZZv72bcSES9xIfjQivMFQU94Pnz3ohkpR70cfdD3F0hilhH5w==
X-Received: by 2002:a50:baae:: with SMTP id x43-v6mr5004148ede.65.1537914864485;
        Tue, 25 Sep 2018 15:34:24 -0700 (PDT)
Received: from localhost.localdomain ([92.55.154.13])
        by smtp.gmail.com with ESMTPSA id o37-v6sm33553edo.71.2018.09.25.15.34.23
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:34:23 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v9 04/21] stash: rename test cases to be more descriptive
Date:   Wed, 26 Sep 2018 01:33:17 +0300
Message-Id: <41fa6cc1a9df062ee35a0fdd20ff53b46ace1719.1537911869.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g1fb9f40d88.dirty
In-Reply-To: <cover.1537911869.git.ungureanupaulsebastian@gmail.com>
References: <cover.1537911869.git.ungureanupaulsebastian@gmail.com>
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
index de6cab1fe7..3114c7bc4c 100755
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
2.19.0.rc0.23.g1c0a08a5d3

