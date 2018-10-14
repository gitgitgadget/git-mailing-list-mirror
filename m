Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EFA01F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 22:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbeJOFzm (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 01:55:42 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:44787 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeJOFzl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 01:55:41 -0400
Received: by mail-ed1-f42.google.com with SMTP id z21-v6so16040919edb.11
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 15:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PmgyxctsUKgV5KvT/igCFhEJD1mr82EoxObXr5dLlmE=;
        b=N43a2QmxLTWl70YUWuGMOToK5SUjRnEPACgYR6/lDiilnKZmTErwRU7QxgzCnEBg4k
         671ZqSZhJAnAjDSrmEbkHJ17SK6N7brSxjxggmXMLTKYIa1Knjfjw2vErMdsRCYtIEd0
         rYbqYb+n+krUBfAm1UZL8tJbyjTP1E13Vfd7973Cr5fC9Q1toXsna904NwvcpjTNQnIK
         wf+6vCxiqkvdYvwj+gsZEff1tyeVrmRjr5AVIE6ozo6fIzP0Ece4tEfYI0nswRsy7G22
         SdM+QqNj2ASCcnj5lf3oqBuEUI2S5qixNcSYlg4eVbihEL60eI/iYrdMNLA79mhUlI69
         VfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PmgyxctsUKgV5KvT/igCFhEJD1mr82EoxObXr5dLlmE=;
        b=j+CZnvI7FqwI1rS45kXNZCR2TMXt+Deft1q8PzJNVFDGldtAiIbOdGNzP6Xw3bYbRf
         clmyb+w2spVgdl8Gq7Uxvz4QiHo9Dqf8GDrdCdmUKyFsO78sF8RbGlRbzNdsDcLj1vuW
         g2KL7X7DdJx8D2EKqtfxivVga6ToT661MJ2x9gvYdBTtW5aUqWOYutGYTKw0PdtOzvnJ
         X/hz8PB4w09MyDyvVhuRFDF4OgyW0j4RIWgLvsarfvfLyL458eNsDnvmFRe0XA6RSwZ1
         9z7xZR44W/ybYWFiY/djb1NPdmOgNQbVlMuGZVuDmzcfmWgKPqi9Nb3a+zKtxOBqbOUd
         +XeQ==
X-Gm-Message-State: ABuFfoh28rwYq9H/sWQPLMDFcbnn60/+BUTe0MGNMlM3/WUe36/OOIk8
        8l6EaF5BGZJY8pWWZTUqzLeuNKYI
X-Google-Smtp-Source: ACcGV60ag0C025KP+dCQDBhcSRavSjUbpMU86gfxaPfzIggiH3yZ4BOIAANZGo6MFRgQH+q7DZFIwA==
X-Received: by 2002:a50:9a81:: with SMTP id p1-v6mr21824878edb.112.1539555194274;
        Sun, 14 Oct 2018 15:13:14 -0700 (PDT)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id p23-v6sm1829273ejj.16.2018.10.14.15.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 15:13:13 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v10 05/21] stash: rename test cases to be more descriptive
Date:   Mon, 15 Oct 2018 01:11:11 +0300
Message-Id: <ba1f9c1b1d36241047a915ef186e038d14128afb.1539553398.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g10a62394e7
In-Reply-To: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
References: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
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
2.19.0.rc0.23.g10a62394e7

