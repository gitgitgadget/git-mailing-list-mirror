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
	by dcvr.yhbt.net (Postfix) with ESMTP id B47F31F462
	for <e@80x24.org>; Thu, 25 Jul 2019 10:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfGYKLS (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 06:11:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51076 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbfGYKLS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 06:11:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so44447111wml.0
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 03:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=moUMSE90+nFsxeOHcgCy5QUerZMMwZsZ2pp3Wa/hwc8=;
        b=tNJYHPt+3EFNhclRP4ZGrzt41ninNFbR6RROu7Iifiox5VdGmZNjX67ZpoN/G1rXJh
         PYCZV6B9hOGbZExAaSgFXFBDRkWDN/qrJsShdzNahPn8mU/YUMfXCJV3BGeA/NCD9gU2
         mNoskiqwX20ocTqL+MgDc3YlsnsPkR/K8X4ItoZ4WjUPYZjjSQYJfHSjZwtMXOT8BNyr
         d9dup1z1DTT/QN+BKZ4cv22pQklC8Yj27cl60NZ2VhMfaXsXNHunVEjf3701wOgO+1Q7
         ikodJCQ2JSEbLaOmrWzVT/Q/QDtacqRxviR8wnWY8O+b7f5K2y+JpfOPxtWrDuPkmgD4
         xUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=moUMSE90+nFsxeOHcgCy5QUerZMMwZsZ2pp3Wa/hwc8=;
        b=l+eni77Bvl1BKORaLrZWaqTaEyZ8gDaURYmjio8zrOXjjXnrYeprFqW+7OSIX66KQg
         h/l9QdSZ2my65Pr/Dsq4wDK1GZP2ciIuxAWnlS5miwFwzVmaQuYRchIiSsOHLZytCNOo
         +KGigI9rcdexzcYLSCxGeDKkR2gebfDbGwMgsdImCYboxJz+giLzmn0vFo7lvbfhacdZ
         5MXgSc4G9hVx7LOl9GJgtnhTJg44BMlyWxbqnHsBLUXEH7/0VVD3YZP4x4ozgFAhTlJt
         f1gsi+ZY5KtTOw44/0Bq1mgLYIm0Ra+/SrWGepWMWVxIvJPxgFBsdic7EH3HgjUMSjKT
         KZgg==
X-Gm-Message-State: APjAAAVDbSo08hDZMtU9ZPSn3W0AIm8iC8/Jxo7XbVljfFUdZsX+4hur
        SQP7xHlHlR8RcxQjm3ROToWoQGad
X-Google-Smtp-Source: APXvYqw1vhNa0OPLyBxlXIG2TZ3VLifr+sg8u2nWkgiLfXUoUtT7S8wLR7J9Sb+3baeb8e2hv3RXQQ==
X-Received: by 2002:a05:600c:228b:: with SMTP id 11mr80615693wmf.26.1564049476099;
        Thu, 25 Jul 2019 03:11:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w25sm47101842wmk.18.2019.07.25.03.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 03:11:15 -0700 (PDT)
Date:   Thu, 25 Jul 2019 03:11:15 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Jul 2019 10:11:02 GMT
Message-Id: <05be92d9213bf16b479cc95af520eea038748567.1564049473.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 01/12] t3427: add a clarifying comment
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

The flow of this test script is outright confusing, and to start the
endeavor to address that, let's describe what this test is all about,
and how it tries to do it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3427-rebase-subtree.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index 3780877e4e..a9b93c39d0 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -11,6 +11,34 @@ commit_message() {
 	git log --pretty=format:%s -1 "$1"
 }
 
+# There are a few bugs in the rebase with regards to the subtree strategy, and
+# this test script tries to document them.  First, the following commit history
+# is generated (the onelines are shown, time flows from left to right):
+#
+# master1 - master2 - master3
+#                             \
+# README ---------------------- Add subproject master - master4 - files_subtree/master5
+#
+# Where the merge moves the files master[123].t into the subdirectory
+# files_subtree/ and master4 as well as files_subtree/master5 add files to that
+# directory directly.
+#
+# Then, in subsequent test cases, `git filter-branch` is used to distill just
+# the commits that touch files_subtree/. To give it a final pre-rebase touch,
+# an empty commit is added on top. The pre-rebase commit history looks like
+# this:
+#
+# Add subproject master - master4 - files_subtree/master5 - Empty commit
+#
+# where the root commit adds three files: master1.t, master2.t and master3.t.
+#
+# This commit history is then rebased onto `master3` with the
+# `-Xsubtree=files_subtree` option in three different ways:
+#
+# 1. using `--preserve-merges`
+# 2. using `--preserve-merges` and --keep-empty
+# 3. without specifying a rebase backend
+
 test_expect_success 'setup' '
 	test_commit README &&
 	mkdir files &&
-- 
gitgitgadget

