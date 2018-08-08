Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C74B71F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbeHHVUV (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36355 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbeHHVUV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id w24-v6so3836156wmc.1
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HEuc96Vl56vZ0TqWo7xOsZ30Sr0t8dt9hklcC8WFxJI=;
        b=pQNMjAaO4KJPOWEQdye8GEWrUuqyifRbRw++uFT6DY9DJ5e0Dvk4pnK3D58rivAwE6
         QcyiBZyhMYoQjRVymV3zr/ETmM/UwxLo+z5WEH1fu7WNehofKv+JRbH54hfFoJy3zMEU
         /NxYgcdEPNgsQYgKiosYnkFattLT75UZLcKShs74VxqO7iGaAxxJRqvVoZK/ioOqRKz4
         gV7L3z3UhM5SUQ680Gqie79Wk6Nq6Sen+grsdPLJ9RyoOxX0M9ktNNU7DlgO+rf8WpSY
         ATv8JnsaCX2ni9iTzvETd3sBa9ekLiYNQpjPvx4Hh+jKg5vkTcZfqhJzK5pkFANd1Lal
         kZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HEuc96Vl56vZ0TqWo7xOsZ30Sr0t8dt9hklcC8WFxJI=;
        b=DrmK5Zt0U2W42sjGjLV/BpiEj9tWiLXVYuNg4egEf4Xw7lEZOWJPZX1zAwH2ZD+QY4
         NivPLWU3+ahAakXG5enMAURsHfY1hRS9ibODCPdNvlGnmP0g/EQfxbyccUfRQO0xKYd2
         0GKjREnWbIJHZA+UUs0bRdMRN+uhXwDeeNftKxu4aIrpStr1kcYw7qeQnxvR5Y/RA7DO
         d773qXnwfNVg525sQool5vPxgXTwtq2bkhoFaNtcCcrMQfJ87+Dj6aiLci9MEdWh8kNO
         XWyJNxFv8Ah3YgTpnOtswSIPkH6Qyws/uZH/V4OfG480n3RB/xnQPUL2QDwDJOj8f83W
         jSqQ==
X-Gm-Message-State: AOUpUlH+P+o4WO8uSKh++oVOrhrOYZo6k4LhDM2vDJz+vM0Wne/bJsla
        HSi79Js2b2TBWbBe/nJHjYbZ6ab6
X-Google-Smtp-Source: AA+uWPwtYRqeiAFJhgDonDjKnNT3F/Z2frQUlbvMLp1YGs1SjOmm9pkCP/Pa2kNQ2+/iTNhTxfpC7w==
X-Received: by 2002:a1c:8f0e:: with SMTP id r14-v6mr2823691wmd.79.1533754759067;
        Wed, 08 Aug 2018 11:59:19 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.18
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:18 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 04/26] stash: renamed test cases to be more descriptive
Date:   Wed,  8 Aug 2018 21:58:43 +0300
Message-Id: <cb70dc2317b8bdbe640a50de7050cb405067c0f0.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Renamed some test cases' labels to be more descriptive and under 80
characters per line.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 t/t3903-stash.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index de6cab1fe..8d002a7f2 100755
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
+test_expect_success 'branch: should not drop the stash if the branch exists' '
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
+test_expect_success 'apply: shows same status as git status (relative to ./)' '
 	git stash clear &&
 	echo 1 >subdir/subfile1 &&
 	echo 2 >subdir/subfile2 &&
@@ -1048,7 +1048,7 @@ test_expect_success 'stash push -p with pathspec shows no changes only once' '
 	test_i18ncmp expect actual
 '
 
-test_expect_success 'stash push with pathspec shows no changes when there are none' '
+test_expect_success 'push: <pathspec> shows no changes when there are none' '
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
2.18.0.573.g56500d98f

