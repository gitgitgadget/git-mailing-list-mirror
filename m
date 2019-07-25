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
	by dcvr.yhbt.net (Postfix) with ESMTP id 328111F462
	for <e@80x24.org>; Thu, 25 Jul 2019 10:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388713AbfGYKLX (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 06:11:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55048 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388139AbfGYKLU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 06:11:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id p74so44392111wme.4
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 03:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qgc0NnOqvzExLfDn+q9OgvuzvfA1PVDCb+zpDNezixg=;
        b=UkNHvLBup40fFBGX33Y7/HGvrIiJrNKVQNwLVvEtPcpkf15h8Yl7A72sO+sHYc301i
         bSSsWG5B8GZ6ITRbMNsBa4+lUhgNlAbm4ldhJaXSB85YLkUlg9zoOKOzE9/T+FLREgZf
         6qielaA5Bp5WQ+/4Vp9yv8EsTCcxUbKNekgynNVtETNv/zcmBWZoTzk6EbDW7KWvSAZX
         /VYo5oymZC1vfPkI68WD6417N78piOs15B0ETku+yCTn2WecIwqAL3XHXSkl6NKhET6h
         HKI+TnVrvmvpluaadLKyqm5ACsEzvYhy/HEOFe7Qz6K0wqrP0RBU4c+ML75CFqIRCInu
         uocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qgc0NnOqvzExLfDn+q9OgvuzvfA1PVDCb+zpDNezixg=;
        b=TdKJqaxrOyRvVutCAIoczYx/sI7Vh3Xh0c0vy0zHTE7hm1B6q4ipInJqofH8YU4Npi
         +2YgE7+KO2cuawuhpaqz2IW2D3Zeno3+HRPrCf9DrugMnwdNrllzOKdzmOgowql6KwLy
         fG0MpOGMm93s8sw+QDnnCFDG9RuY8JIjaWBL7A9UfmPY4o1KEJytfmC1jE3nkemj+MVJ
         5S11mw9taldQ/uJo+5wSxxdwBysvNhkVtJ/uPcCWqi9/Xs7cDuYKSzTUrutDDWv8xlcW
         +3rHGklsxTKesw/akzbjtL4U81cXVSDIV0IgWiLmXSBroFWge7/29t2iqNVS6Q8gZNLk
         vjyw==
X-Gm-Message-State: APjAAAVbLdr5fRS/XENLovbA8EEK/yf/bMUPBu+a1mOf4o8/vn0eBH6X
        C8zbHUJ+I1dnp5obPoLdA/OIJTK3
X-Google-Smtp-Source: APXvYqxIQ9cqfH7RI3mJ1fr0LrQrMf5AuK2daf5LccAlu0dHyhc3RFRUcckfFnE5foYF/S5SHoeD4g==
X-Received: by 2002:a05:600c:c4:: with SMTP id u4mr79101909wmm.96.1564049479205;
        Thu, 25 Jul 2019 03:11:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t13sm60929426wrr.0.2019.07.25.03.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 03:11:18 -0700 (PDT)
Date:   Thu, 25 Jul 2019 03:11:18 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Jul 2019 10:11:06 GMT
Message-Id: <3196413c2af972f5ba9745b6bc9f2f9e764e8116.1564049473.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 05/12] t3427: fix erroneous assumption
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

Apart from the `setup` test case, `t3427-rebase-subtree.sh` is made up
exclusively of demonstrations of breakages. The tricky thing about such
demonstrations is that they are often buggy themselves.

In this instance, somewhere over the course of the six iterations
of the patch that eventually made it into Git's `master` as 5f35900849e
(contrib/subtree: Add a test for subtree rebase that loses commits,
2016-06-28), the commit message "files_subtree/master4" was changed to
just "master4", but the test cases still expected the old commit
message.

Let's fix this, at long last.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3427-rebase-subtree.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index 7d3ba766de..8c4ddd3408 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -68,7 +68,7 @@ test_expect_failure 'Rebase -Xsubtree --preserve-merges --onto commit' '
 	reset_rebase &&
 	git checkout -b rebase-preserve-merges to-rebase &&
 	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
-	verbose test "$(commit_message HEAD~)" = "files_subtree/master4" &&
+	verbose test "$(commit_message HEAD~)" = "master4" &&
 	verbose test "$(commit_message HEAD)" = "files_subtree/master5"
 '
 
@@ -77,7 +77,7 @@ test_expect_failure 'Rebase -Xsubtree --keep-empty --preserve-merges --onto comm
 	reset_rebase &&
 	git checkout -b rebase-keep-empty to-rebase &&
 	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
-	verbose test "$(commit_message HEAD~2)" = "files_subtree/master4" &&
+	verbose test "$(commit_message HEAD~2)" = "master4" &&
 	verbose test "$(commit_message HEAD~)" = "files_subtree/master5" &&
 	verbose test "$(commit_message HEAD)" = "Empty commit"
 '
@@ -87,7 +87,7 @@ test_expect_failure 'Rebase -Xsubtree --onto commit' '
 	reset_rebase &&
 	git checkout -b rebase-onto to-rebase &&
 	git rebase -Xsubtree=files_subtree --onto files-master master &&
-	verbose test "$(commit_message HEAD~2)" = "files_subtree/master4" &&
+	verbose test "$(commit_message HEAD~2)" = "master4" &&
 	verbose test "$(commit_message HEAD~)" = "files_subtree/master5" &&
 	verbose test "$(commit_message HEAD)" = "Empty commit"
 '
-- 
gitgitgadget

