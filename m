Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A0E41F731
	for <e@80x24.org>; Wed, 31 Jul 2019 15:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbfGaPTE (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 11:19:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46167 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbfGaPSs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 11:18:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so70095694wru.13
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 08:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d+B3IKDPR5LPMucqtsnn5xBAKgD+1jSjntMCODxJJqg=;
        b=oLaHqMus22uVjPNCzmgy5YH07lR74HlllGWw0OIXj/ENmEi0IhdWAdxa04MEPragvM
         eOR1Hr9LnGn5xUDILxsOziAxGoKH7C4KpdgPXkLT8oH4OsrGUi/Idk8PUzTiWZ40Ywg2
         b6wu7elQetdZEUsa2/YuP9P7F8gvrbsRFxuOJVk765Y/nmR5u+i+/SvPooa3aKbTZuGY
         js0lMeWAZVPzEjaArH7JOoezUUZTbTaM2LV1PsTV08RAJSNKsLs3mnoQDI5ue8IQUvIs
         dfBy4hgOaJUezVF4SX6yZlk/NACgPoCQxGx0Q5Gv7EKYYfTAKgMfq7BfcOvjfkPKi1V6
         yvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d+B3IKDPR5LPMucqtsnn5xBAKgD+1jSjntMCODxJJqg=;
        b=BarrczabYdgoTbydJPxoCt4jgoh6ZfPThWBwMyg1piSqnbclEgcBYTBhJV8PKcTnen
         T634by5CEebPXqDBBCIDbpfdx1oEvoF4/oHf9VpqWzIHdtvb4sgqCv0Ebs+/Zi1SRTdi
         52riKXUyALNeFzI6aIVQE+q8JsCyZgk1Ik1ImUtMI3FXDCOdwQDrQfGY5ytXIWd0KND/
         gIH6IZlpA1cR+5h1DS3NG6rMi5rvCZktSCZVHlCrlHm8hquAVLPvPrSnpomq5hlAARpG
         5/LlCNK86etXnyMcZCoY1lWCVX5zCHxDGUGrDQV31RpPenH7XMSuVOJYifDtI2Dtja0g
         1J2w==
X-Gm-Message-State: APjAAAVLNjSLaSnA0L5aWgIy/YbS37nm+FLDMtVIcvcvC5O/KCIR+LiS
        eZWYByCWjCaNwPiUskqUQdRjAowK
X-Google-Smtp-Source: APXvYqyAmKmrbyfj1Mr/9UUozSypW6oYe0g5gnra39Gh5PMN8hSngpTiQnpcyqosVR6eFs10GFfZ+A==
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr105795582wrv.39.1564586324814;
        Wed, 31 Jul 2019 08:18:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y16sm70346387wrw.33.2019.07.31.08.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:18:44 -0700 (PDT)
Date:   Wed, 31 Jul 2019 08:18:44 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Jul 2019 15:18:29 GMT
Message-Id: <46ef0053650d9bcc7c3218cfbf0cb729307c03f8.1564586316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.v2.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
        <pull.294.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 09/16] t3427: condense the unnecessarily repetitive test
 cases into three
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Previously, this test script performed essentially three rebases and
verified breakages by testing the post-rebase commits' messages.

To do so, the rebases were performed multiple times, though, once per
commit message to test. This wastes electricity (and CO2) and time.

Let's condense the test cases to the essential number: the number of
different rebases to validate.

On Windows, where the scripted nature of the `--preserve-merges` backend
hurts performance rather badly, this reduces the overall runtime in this
developer's setup from ~1m to ~28s while still performing the exact same
testing as before.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3427-rebase-subtree.sh | 61 +++++++--------------------------------
 1 file changed, 11 insertions(+), 50 deletions(-)

diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index 64ba95f3e0..b21925d279 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -64,70 +64,31 @@ test_expect_success 'setup' '
 '
 
 # FAILURE: Does not preserve master4.
-test_expect_failure REBASE_P \
-	'Rebase -Xsubtree --preserve-merges --onto commit 4' '
+test_expect_failure REBASE_P 'Rebase -Xsubtree --preserve-merges --onto commit' '
 	reset_rebase &&
-	git checkout -b rebase-preserve-merges-4 to-rebase &&
-	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
-	verbose test "$(commit_message HEAD~)" = "files_subtree/master4"
-'
-
-# FAILURE: Does not preserve master5.
-test_expect_failure REBASE_P \
-	'Rebase -Xsubtree --preserve-merges --onto commit 5' '
-	reset_rebase &&
-	git checkout -b rebase-preserve-merges-5 to-rebase &&
+	git checkout -b rebase-preserve-merges to-rebase &&
 	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
+	verbose test "$(commit_message HEAD~)" = "files_subtree/master4" &&
 	verbose test "$(commit_message HEAD)" = "files_subtree/master5"
 '
 
 # FAILURE: Does not preserve master4.
-test_expect_failure REBASE_P \
-	'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 4' '
+test_expect_failure REBASE_P 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit' '
 	reset_rebase &&
-	git checkout -b rebase-keep-empty-4 to-rebase &&
-	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
-	verbose test "$(commit_message HEAD~2)" = "files_subtree/master4"
-'
-
-# FAILURE: Does not preserve master5.
-test_expect_failure REBASE_P \
-	'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 5' '
-	reset_rebase &&
-	git checkout -b rebase-keep-empty-5 to-rebase &&
-	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
-	verbose test "$(commit_message HEAD~)" = "files_subtree/master5"
-'
-
-# FAILURE: Does not preserve Empty.
-test_expect_failure REBASE_P \
-	'Rebase -Xsubtree --keep-empty --preserve-merges --onto empty commit' '
-	reset_rebase &&
-	git checkout -b rebase-keep-empty-empty to-rebase &&
+	git checkout -b rebase-keep-empty to-rebase &&
 	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
+	verbose test "$(commit_message HEAD~2)" = "files_subtree/master4" &&
+	verbose test "$(commit_message HEAD~)" = "files_subtree/master5" &&
 	verbose test "$(commit_message HEAD)" = "Empty commit"
 '
 
 # FAILURE: fatal: Could not parse object
-test_expect_failure 'Rebase -Xsubtree --onto commit 4' '
-	reset_rebase &&
-	git checkout -b rebase-onto-4 to-rebase &&
-	git rebase -Xsubtree=files_subtree --onto files-master master &&
-	verbose test "$(commit_message HEAD~2)" = "files_subtree/master4"
-'
-
-# FAILURE: fatal: Could not parse object
-test_expect_failure 'Rebase -Xsubtree --onto commit 5' '
-	reset_rebase &&
-	git checkout -b rebase-onto-5 to-rebase &&
-	git rebase -Xsubtree=files_subtree --onto files-master master &&
-	verbose test "$(commit_message HEAD~)" = "files_subtree/master5"
-'
-# FAILURE: fatal: Could not parse object
-test_expect_failure 'Rebase -Xsubtree --onto empty commit' '
+test_expect_failure 'Rebase -Xsubtree --onto commit' '
 	reset_rebase &&
-	git checkout -b rebase-onto-empty to-rebase &&
+	git checkout -b rebase-onto to-rebase &&
 	git rebase -Xsubtree=files_subtree --onto files-master master &&
+	verbose test "$(commit_message HEAD~2)" = "files_subtree/master4" &&
+	verbose test "$(commit_message HEAD~)" = "files_subtree/master5" &&
 	verbose test "$(commit_message HEAD)" = "Empty commit"
 '
 
-- 
gitgitgadget

