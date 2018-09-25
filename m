Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FAC41F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbeIZEoP (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:44:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40393 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbeIZEoO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:44:14 -0400
Received: by mail-ed1-f65.google.com with SMTP id j62-v6so184284edd.7
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=c2xiakzPdSSucM3px2nSWY450mjKhCf2mnIZTRBtDtA=;
        b=XB2X5UGs6Tis53g7z8BBPxHVlR/4U4G+rVRZreOLqvaczgVUjC2lAItej7TV4oVKFT
         I3GDevGTXDCBEQj6nYzROSx14LZFMKYbWn2d+G8+6gUagMuB1YbNoyw1YnheSZ7cw/FC
         mMt9PlegizdCABFwoXGYP5doVZKAPkttFzNJ4cgf/iHKJgR39xToDOrz1nz1o7ctNwj3
         fgO3GmaxiM8IjGRU5a7ds1v4E0qpJ21E2Z00tixGT8Ff/kVIo+ZBybYvB2V8/UQAlTZf
         P9PQvo44I1KrtIAmrK3OqEzIWm6r1swsu04+v6AKmcJYNB7FXJPNweCdAzmaQsM1BCnm
         XLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c2xiakzPdSSucM3px2nSWY450mjKhCf2mnIZTRBtDtA=;
        b=tDC8KRBLRkXoQxw1oU3fcVXZFJWi4WEwTmZoZB3nRKjMRdEk0l+ERoCVfhZfYjBIPI
         FE3VFXMP6SOfxGA/oAMlDNxZ7BtEVAAzYk9IxpBUzD5xzV7LoeuMA6PjGAEWkLVXMDIs
         OjHLjoJ0y49lH8kacaKV/6PFA5NFu+FjhRZ5k9kwwMWmPTFwCJRfxOGhaRhYVsZFaSov
         icmjjhLMMk6O0e6C1rb6Rnu6UGQniQYWoqcBqaqsIBfay+ER3OKrD3if5S3ihuUVu6Vm
         NU1DSNTllILt7Z9/eonrNVV8cXWHHcxai3+M/KhdGrE0QP8eOIq1kS2rfBir2JW7G2zr
         1DDw==
X-Gm-Message-State: ABuFfohtElkfbH648HD+1J4r9FbZJyM3+0gWlA0N7nc5fu1E83gf1N37
        +YYPvuY675MRJHgO/Yn+KMHKGZpn
X-Google-Smtp-Source: ACcGV60eRHnb053dONTDcnmg3c3RoT9gRMUbvhmOCOy7x3u9sdU+bKJfrcEsb4Dod3OwpIgoUN+Utg==
X-Received: by 2002:a50:d59a:: with SMTP id v26-v6mr4654304edi.226.1537914867622;
        Tue, 25 Sep 2018 15:34:27 -0700 (PDT)
Received: from localhost.localdomain ([92.55.154.13])
        by smtp.gmail.com with ESMTPSA id o37-v6sm33553edo.71.2018.09.25.15.34.26
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:34:26 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v9 05/21] stash: rename test cases to be more descriptive
Date:   Wed, 26 Sep 2018 01:33:20 +0300
Message-Id: <13b53e154222fb28b1100e0ba3e0080fe9bbc2a1.1537913094.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g1fb9f40d88.dirty
In-Reply-To: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
References: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
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
2.19.0.rc0.23.g1fb9f40d88

