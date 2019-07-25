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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F8DF1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 10:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388680AbfGYKLX (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 06:11:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36201 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388120AbfGYKLU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 06:11:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so40088835wme.1
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 03:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zML5Qsmc8HszOfCBhNZlNUAJRbxKu5Wz/AFIkV9NkO0=;
        b=BAr0U4S9AYvpXXFApPOCqqA+PI4oz6U7X6Y9SzHWk6I+5hcQanv+fq9cRKrOC5IxWo
         JhZ7UF1Mqq4MTUSAuRttgE4AaWQCC17Ki3ZImZol4qcd+4u62FgTACjt5wOzVRaPpp1o
         3sCNzTZCFGCF74JFXEd8392BgLjE1nraSUwdwpWyHiNUiC++FZzxdDdnpU52tGmtH2V/
         kjZQ5KNIdNVpjgsJSF5YSCfACSA4X7erk2qBdCEqXxCZH8f9NYf8B9pDag0FWmH1zg0q
         O6KMdi93J3vx3G8S5Ub+uD56gIvxcKGgQ2Vazq5zLbFMNMBX35OgzZjQAiB2Kfr2PAIS
         fIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zML5Qsmc8HszOfCBhNZlNUAJRbxKu5Wz/AFIkV9NkO0=;
        b=oKr49bFgefeP7HGctWqEDC4cOIlLqoOe/YMmbjurzzRyJjFzrzDl8yz+DU4FiZg9J2
         rvjDXhQ6zZdJcACS+jq188LhFNT4PCEYWpxna4gfiWZpxf5GlvXn1msg18gzse9gJUXh
         lkF0wHOFpy8DwUZh3mdHX1f533HtC1zqNyPk9Zr2ZSJu5uObDA7Ze9c9Ksbad63HtyVI
         CbokFtMlxO+6ccXb7kWVp/Gf2F5cesZDJRINezCPLHTE3zG6vhPocNserTT302vPIj4f
         aKOQr6exAI4E6jWbejE6rjAwKc6e6pGmhKXF3jV4tQhvi3gPXYnnEKBSYmlJq0F0Os9V
         MgOQ==
X-Gm-Message-State: APjAAAUqM7tHhhpqXzNvbtm6+lqRvg1doiZxalIhjOu0yuf+RDPdURiG
        nd5S2KNRVXWpWMp1b3j9rxOkWF4K
X-Google-Smtp-Source: APXvYqzxMYAahSBgDsUMGZrpK9mrrilNLE972I72s972NwT/LdGiUbo1VHMuL4DEEBs2JpCYLCcMFA==
X-Received: by 2002:a05:600c:2102:: with SMTP id u2mr81104579wml.105.1564049478494;
        Thu, 25 Jul 2019 03:11:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x129sm46805325wmg.44.2019.07.25.03.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 03:11:18 -0700 (PDT)
Date:   Thu, 25 Jul 2019 03:11:18 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Jul 2019 10:11:05 GMT
Message-Id: <9aeb57fa8f5c882f00c349e01a4459ce21c6cd24.1564049473.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 04/12] t3427: condense the unnecessarily repetitive test cases
 into three
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
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
 t/t3427-rebase-subtree.sh | 56 ++++++++-------------------------------
 1 file changed, 11 insertions(+), 45 deletions(-)

diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index c0e6a49b61..7d3ba766de 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -64,65 +64,31 @@ test_expect_success 'setup' '
 '
 
 # FAILURE: Does not preserve master4.
-test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto commit 4' '
+test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto commit' '
 	reset_rebase &&
-	git checkout -b rebase-preserve-merges-4 to-rebase &&
-	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
-	verbose test "$(commit_message HEAD~)" = "files_subtree/master4"
-'
-
-# FAILURE: Does not preserve master5.
-test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto commit 5' '
-	reset_rebase &&
-	git checkout -b rebase-preserve-merges-5 to-rebase &&
+	git checkout -b rebase-preserve-merges to-rebase &&
 	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
+	verbose test "$(commit_message HEAD~)" = "files_subtree/master4" &&
 	verbose test "$(commit_message HEAD)" = "files_subtree/master5"
 '
 
 # FAILURE: Does not preserve master4.
-test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 4' '
+test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit' '
 	reset_rebase &&
-	git checkout -b rebase-keep-empty-4 to-rebase &&
-	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
-	verbose test "$(commit_message HEAD~2)" = "files_subtree/master4"
-'
-
-# FAILURE: Does not preserve master5.
-test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 5' '
-	reset_rebase &&
-	git checkout -b rebase-keep-empty-5 to-rebase &&
-	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
-	verbose test "$(commit_message HEAD~)" = "files_subtree/master5"
-'
-
-# FAILURE: Does not preserve Empty.
-test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto empty commit' '
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

