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
	by dcvr.yhbt.net (Postfix) with ESMTP id C757E1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 15:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbfGaPTT (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 11:19:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37604 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbfGaPSs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 11:18:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id f17so60175472wme.2
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 08:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RJIBRcnb6Fyu7SUJHmDralrlG7XvAPezGLLixmCFhbQ=;
        b=epTg1ycZdzZQFNcCaz9OCwhQbm7I0G5c0Jy79PTTcW5Xev6sRLUFlyLBdPCsREWOIl
         SIoqRYL1hZvcPt08imomYLxZ5OvJqhb7/RH2QS9Nr3rUWJJukXaQzNQv5eIpIZQSEbZm
         0iAFsBM5F5XvYPHHJAB/YOwdo4waD4RCiqHmMkm0IskNpeXxDeeW4pDwi8Yoc3WY2RdL
         wzMgupbT+EyWY5ct/9A2ttJ93rBdC/2ARjkC28HjncgbBGLVYI2DTkdNzRnsfZw/Uspp
         mtcDctToyB0n4Gk5XeZDCthA+YW65jfcGTua+8uWtpK3g1IpMBr5yU91vQ6LZQtYWhJo
         SxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RJIBRcnb6Fyu7SUJHmDralrlG7XvAPezGLLixmCFhbQ=;
        b=X507y/B811ygiqAlK+kYJdIDUGIh0IwWS7jWlQdq1BD5hp399EYv0v46ZF7MwWkBQi
         3cdwtisUZ5SyfWkZ0kbiOjwQoEMEPOlshHtLrFBzFNhZagcMwJbP6bguAhE0MK5eHfAP
         idN5KdJvNpBrDFkg6ps7YS0wmFw92fhjUojKtI6UJKvsS1bWJzO8Cb09nPhS2ZjKxnY2
         di0iSrxuGEVKHh6SU4ZXHi40llyoORmt3zJktHJC9WCWys8MDdzbWUMGChQ/Ikln2QeW
         jzdhEtfo36XOojWaCWaS5uHaUlikItvVxJDn0UY/iYrGSO8pXmjWo8h1sIMcv8wB0D4L
         Y0BA==
X-Gm-Message-State: APjAAAW5x2zx2vZXzaLU49q9gXGiEwRXWR7rxb9C+emfSGH/ja+riq0a
        apfoLIjyvLPOYSAuR9tLiGh6Z2Ir
X-Google-Smtp-Source: APXvYqxWOnCvfYdn7f/KyTY8a13KVoMZ9PXqjySEbZff8PLmL1uQUgfahxZuIrPm1ZqtQqKTKmxRaw==
X-Received: by 2002:a1c:35c2:: with SMTP id c185mr109695420wma.58.1564586326385;
        Wed, 31 Jul 2019 08:18:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q1sm52284196wmq.25.2019.07.31.08.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:18:45 -0700 (PDT)
Date:   Wed, 31 Jul 2019 08:18:45 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Jul 2019 15:18:31 GMT
Message-Id: <d73b0a05d90237253d0793580fe285df3aba689a.1564586316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.v2.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
        <pull.294.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 11/16] t3427: accommodate for the `rebase --merge` backend
 having been replaced
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

Since 68aa495b590 (rebase: implement --merge via the interactive
machinery, 2018-12-11), the job of the old `--merge` backend is now
performed by the `--interactive` backend, too.

One consequence is that empty commits are no longer rebased by default.

Meaning that the test case that calls `git rebase -Xsubtree` (which used
to be handled by the `--merge` backend) now needs to ask explicitly for
the empty commit to be rebased.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3427-rebase-subtree.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index 94cc532e10..a734716ea3 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -83,10 +83,10 @@ test_expect_failure REBASE_P 'Rebase -Xsubtree --keep-empty --preserve-merges --
 '
 
 # FAILURE: fatal: Could not parse object
-test_expect_failure 'Rebase -Xsubtree --onto commit' '
+test_expect_failure 'Rebase -Xsubtree --keep-empty --onto commit' '
 	reset_rebase &&
 	git checkout -b rebase-onto to-rebase &&
-	git rebase -Xsubtree=files_subtree --onto files-master master &&
+	git rebase -Xsubtree=files_subtree --keep-empty --onto files-master master &&
 	verbose test "$(commit_message HEAD~2)" = "master4" &&
 	verbose test "$(commit_message HEAD~)" = "files_subtree/master5" &&
 	verbose test "$(commit_message HEAD)" = "Empty commit"
-- 
gitgitgadget

