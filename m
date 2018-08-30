Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F3501F404
	for <e@80x24.org>; Thu, 30 Aug 2018 21:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeHaBp4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 21:45:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54926 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeHaBpz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 21:45:55 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so3332722wmb.4
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 14:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=u6UfGQIrDugGN8sGjfHon82XKFB9JdGShpbUMmXABjY=;
        b=smsPBdO2VOnlsfBKhlKAMttGWnJvRRUmbzWhqCUewym7/05ChJf6wNJBlCbbKWGyJq
         k9mYcJBQBxY0x50Cpk+MvzKLI5fZahtwjKsqRyr73i/y4B1qX3OV/us3D62DCv3sppwI
         bOZI6Zj6AHveR6arIx9ELfYlSQKaAaovBVY64DEJbsrLXi3+NyfAEs4x1HT859gBl4zR
         RgsgqA6l6wycsYtQlnKGGPYYrRlh8jVFTZDyWLRSzQCITjGyJefc6TSU6+wnwmJitF9d
         4/dzyP/+W0KFEhbv4BNU3yD4HqFxvoq3Mfr9vuW0VfpYeZuq6jgq41bpy2ko8OU5Jjfi
         OC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u6UfGQIrDugGN8sGjfHon82XKFB9JdGShpbUMmXABjY=;
        b=lS5j39Kx0NB2DVVqdggpH08pCy/aKfcKMRXqGf+SSVZ57K09+CY6nLPZAHmb7WenkC
         ncghW5PrTZ91N6gep4t2weEqWUNWSmChiWjtUtI8WDbqvhL/bbnZ1+JgyOKGw6WLRCsN
         XBIL9Y3mwL5hjgzAS1etCc6vBwJp8j+MMegMlMQfTMyTKa4lp3b8/0rOlJcdveS1U58k
         M6ASgeh62i7pDpcRrzfrzU2YBD8IUAt/HcTwE3lOl9mvYHIfhLQqIsjcBG9Jja0grU02
         ghR6B6hjBayPljKeElt4bRx7+NIOG1txa1rieVXI9QeIeM9OiAZGqefmCVYkrXUXCkdw
         hzzg==
X-Gm-Message-State: APzg51BounzlCKOu95hcpoo9yYbjLQxh4dAgGHh/oNsdGOEJ+brk/OYw
        lP0vCJn6eouJxdr+XVrhDg9hKAgc
X-Google-Smtp-Source: ANB0Vda4HvTy5Rvi71L1WVvOfypGRGWOocch6xomdKSkDdi/9R+0NxbmdVf3gsI95vAzqDHAf6TPRQ==
X-Received: by 2002:a1c:a614:: with SMTP id p20-v6mr2960401wme.68.1535665301812;
        Thu, 30 Aug 2018 14:41:41 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([188.24.241.57])
        by smtp.gmail.com with ESMTPSA id x24-v6sm14445951wrd.13.2018.08.30.14.41.40
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 14:41:41 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v8 04/20] stash: rename test cases to be more descriptive
Date:   Fri, 31 Aug 2018 00:40:34 +0300
Message-Id: <41fa6cc1a9df062ee35a0fdd20ff53b46ace1719.1535665109.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.22.gc26283d74e
In-Reply-To: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
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
2.19.0.rc0.22.gc26283d74e

