Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B09061F453
	for <e@80x24.org>; Thu, 25 Apr 2019 21:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfDYVKi (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 17:10:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41018 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfDYVKi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 17:10:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id f6so451546pgs.8
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 14:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zCFwCon/q16ECc7OYA/3Nf/KElxKyNbEJ5u+FzbXmfU=;
        b=ZG6trilOfZup+ZmaHt+qrmkAN+lRLiGzIBIfAxDfTpa0AObP3Ko58XrX601fqkEZ6d
         Z3RdAEFfLKK4v3eXJYfqM1bxmkmfh/DQ+dV9tNCvuCOxasX94BlqH7aBW5fiZX4tQCNa
         GDU0ghr06FV8V7FaU3RdpEZ4OPfKLepY2xe6pMD1L9VDKFpnATkMZMYcVCiZFbPFa0wz
         6jlVDLMxbZk7sLopbeIOzV1CaXXc+faU3X+8uaf4hLxudxAVBSPInyVUZAOzSpuxvnT7
         LMsXXszKzjPzrpNnYqn2gCUQ+49CjwsKNDtmyCvPe/E6ZmTeTi7imsgZ7FajAjSc7k8F
         rHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zCFwCon/q16ECc7OYA/3Nf/KElxKyNbEJ5u+FzbXmfU=;
        b=XaK62k05aLLdEscdYSN3vm1hSsrX5mLxNtoS0AfeBpQa31gLouwrcNbnRtXeCprGQf
         RbsFG53PkTYGY47TNYWg8Q9BudJmBW4e4VFwTvs8+KtD7fg9eFSzoWqQOXfw9oop/q1x
         9GlVCeuqYmB7DEYHVyO3l0RHOW4L2rXa9qAFvkSoW36+Y3LOIo0hxJEp7+pOsHiXFAaJ
         jbrPy4OGa2u7RbDiTIvbN6HKz7Xz5EHppu4rdUaxCmV00FEKhXVw6DPsN0upKLzWx0Ph
         UJCmj54XhTpQBg1ktVdhyAW7cIVeAZxbXwyb4BWMVvA5c3QDUPtIdN3DEoMx/VTY3kFR
         6NOA==
X-Gm-Message-State: APjAAAUPeURfVvFTrbaty4zOGSB4YG5CNNg9x2zPwgfQVY93Pj6fcels
        1IGWlzoxrQl8j6kp0GwBQgyMIL8Z
X-Google-Smtp-Source: APXvYqxL1M1UybcId8MQkavTKkk2J1ei1gixOKl+x6i73dmX+y0wkEwjNQGx15IasJ9cPQr0hKRr8g==
X-Received: by 2002:a63:6e0e:: with SMTP id j14mr39705243pgc.203.1556226637096;
        Thu, 25 Apr 2019 14:10:37 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id o14sm25668822pgn.4.2019.04.25.14.10.36
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 14:10:36 -0700 (PDT)
Date:   Thu, 25 Apr 2019 14:10:36 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/3] t2018: cleanup in current test
Message-ID: <c0c7171e3d523e5d4a0ac01810378447a38854da.1556226502.git.liu.denton@gmail.com>
References: <cover.1556226502.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556226502.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, in t2018, if do_checkout failed to create `branch2`, the next
test-case would run `git branch -D branch2` but then fail because it was
expecting `branch2` to exist, even though it doesn't. As a result, an
early failure could cause a cascading failure of tests.

Make test-case responsible for cleaning up their own branches so that
future tests can start with a sane environment.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t2018-checkout-branch.sh | 39 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index c5014ad9a6..fdb7fd282d 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -60,38 +60,36 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'checkout -b to a new branch, set to HEAD' '
+	test_when_finished test_might_fail git branch -D branch2 &&
+	test_when_finished git checkout branch1 &&
 	do_checkout branch2
 '
 
 test_expect_success 'checkout -b to a new branch, set to an explicit ref' '
-	git checkout branch1 &&
-	git branch -D branch2 &&
-
+	test_when_finished test_might_fail git branch -D branch2 &&
+	test_when_finished git checkout branch1 &&
 	do_checkout branch2 $HEAD1
 '
 
 test_expect_success 'checkout -b to a new branch with unmergeable changes fails' '
-	git checkout branch1 &&
-
-	# clean up from previous test
-	git branch -D branch2 &&
-
 	setup_dirty_unmergeable &&
 	test_must_fail do_checkout branch2 $HEAD1 &&
 	test_dirty_unmergeable
 '
 
 test_expect_success 'checkout -f -b to a new branch with unmergeable changes discards changes' '
+	test_when_finished test_might_fail git branch -D branch2 &&
+	test_when_finished git checkout branch1 &&
+
 	# still dirty and on branch1
 	do_checkout branch2 $HEAD1 "-f -b" &&
 	test_must_fail test_dirty_unmergeable
 '
 
 test_expect_success 'checkout -b to a new branch preserves mergeable changes' '
-	git checkout branch1 &&
-
-	# clean up from previous test
-	git branch -D branch2 &&
+	test_when_finished test_might_fail git branch -D branch2 &&
+	test_when_finished git checkout branch1 &&
+	test_when_finished git reset --hard &&
 
 	setup_dirty_mergeable &&
 	do_checkout branch2 $HEAD1 &&
@@ -99,27 +97,18 @@ test_expect_success 'checkout -b to a new branch preserves mergeable changes' '
 '
 
 test_expect_success 'checkout -f -b to a new branch with mergeable changes discards changes' '
-	# clean up from previous test
-	git reset --hard &&
-
-	git checkout branch1 &&
-
-	# clean up from previous test
-	git branch -D branch2 &&
-
+	test_when_finished git reset --hard HEAD &&
 	setup_dirty_mergeable &&
 	do_checkout branch2 $HEAD1 "-f -b" &&
 	test_must_fail test_dirty_mergeable
 '
 
 test_expect_success 'checkout -b to an existing branch fails' '
-	git reset --hard HEAD &&
-
+	test_when_finished git reset --hard HEAD &&
 	test_must_fail do_checkout branch2 $HEAD2
 '
 
 test_expect_success 'checkout -b to @{-1} fails with the right branch name' '
-	git reset --hard HEAD &&
 	git checkout branch1 &&
 	git checkout branch2 &&
 	echo  >expect "fatal: A branch named '\''branch1'\'' already exists." &&
@@ -160,6 +149,7 @@ test_expect_success 'checkout -f -B to an existing branch with unmergeable chang
 '
 
 test_expect_success 'checkout -B to an existing branch preserves mergeable changes' '
+	test_when_finished git reset --hard &&
 	git checkout branch1 &&
 
 	setup_dirty_mergeable &&
@@ -168,9 +158,6 @@ test_expect_success 'checkout -B to an existing branch preserves mergeable chang
 '
 
 test_expect_success 'checkout -f -B to an existing branch with mergeable changes discards changes' '
-	# clean up from previous test
-	git reset --hard &&
-
 	git checkout branch1 &&
 
 	setup_dirty_mergeable &&
-- 
2.21.0.1033.g0e8cc1100c

