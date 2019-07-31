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
	by dcvr.yhbt.net (Postfix) with ESMTP id 38DF51F731
	for <e@80x24.org>; Wed, 31 Jul 2019 15:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbfGaPSq (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 11:18:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36760 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbfGaPSp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 11:18:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so70201544wrs.3
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=odFXuFT7sZLBagIRUB/2t/dJn4xMdo/dDOa1irtTdFM=;
        b=H/Ec1l7wOCeqj3opKt8OYWT+p/8dAWTsasEkZjNkML8K96lA6Z+kd8+tarpYzRxsnt
         EPLhahBM1mjnkP8nmg2tbdKFAs+V5j7Z/OuFbJxIIBwyYtgivHcGUB7PyrUtO9Ejcmfr
         6ygXsiEjmYklBuk6YiwJCFUwwJMoiEbnvH/V1T/rs/ZpT4y7fNLSUhobCw6/xe0KXApJ
         Sk2K3oT5rICpsZQZ3+QpbHCO5dVF7x6QwFGp29bXYxnqjIOPhjrxobw+763PzeRD2s12
         HdAo8IqpkIkCe87urt+oGINhCwvqVWoF9pko5Q5aHrChUrQ1JvpkSdimvhyWX135bjh0
         AY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=odFXuFT7sZLBagIRUB/2t/dJn4xMdo/dDOa1irtTdFM=;
        b=Y/YfJ+WErpeO7YgTNwfHjpHMvaBUelKRdV/ABgmP65pBlKWjDN/c/GyTthVqZqryeA
         uyNdczZ35iZyTyV0oRmxVBxAv/cs7IfOzscE5UbVcn1u/Z3O4Q7ij/zs3g1mE/kOaClO
         r25zD2gXiGGGpMwIziLNjPq9Da073LrJjUmKRB+2mxOvTdpTkDQdIZQAU8TXhY+8PZXu
         v/HsFEJdUD1E8pl704raJ2L+3QZbqrv7o4rX6fGEJkQhcFuCVBzo+U//9gl2InQw8/Er
         93eNhT7bkaGwYyVgXxrYihgkmHA2KioWyLsFfEQenqwqS9APBeJs/904WTKz04eJVD7Z
         rPOQ==
X-Gm-Message-State: APjAAAV141hjJdJA1LWimvZS8rGKN9ioDd8qYbk2g4Zi79pKgnE4ajhh
        JjhYNS6g68tARsnJmd8mBf4H9opm
X-Google-Smtp-Source: APXvYqxjzWfKSjbdOBKDe0AkBCbJwzKMW/Dp7Z3O9iYbhrYQnJs8Fjpe9SWLV8OeLVBAfkFQ+5Q61Q==
X-Received: by 2002:a5d:514f:: with SMTP id u15mr36269233wrt.183.1564586323306;
        Wed, 31 Jul 2019 08:18:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x16sm51601045wmj.4.2019.07.31.08.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:18:42 -0700 (PDT)
Date:   Wed, 31 Jul 2019 08:18:42 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Jul 2019 15:18:27 GMT
Message-Id: <c168c4499b674db3aefa4d0303c349a2464a3de1.1564586316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.v2.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
        <pull.294.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 07/16] t3427: simplify the `setup` test case significantly
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

It still does the very same thing as before, but expresses it in a much
more succinct (and still quite readable) manner.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3427-rebase-subtree.sh | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index 3a2ae7b55d..36c4f92e06 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -41,27 +41,21 @@ commit_message() {
 
 test_expect_success 'setup' '
 	test_commit README &&
-	mkdir files &&
-	(
-		cd files &&
-		git init &&
-		test_commit master1 &&
-		test_commit master2 &&
-		test_commit master3
-	) &&
-	git fetch files master &&
-	git branch files-master FETCH_HEAD &&
-	git read-tree --prefix=files_subtree files-master &&
-	git checkout -- files_subtree &&
-	tree=$(git write-tree) &&
-	head=$(git rev-parse HEAD) &&
-	rev=$(git rev-parse --verify files-master^0) &&
-	commit=$(git commit-tree -p $head -p $rev -m "Add subproject master" $tree) &&
-	git update-ref HEAD $commit &&
-	(
-		cd files_subtree &&
-		test_commit master4
-	) &&
+
+	git init files &&
+	test_commit -C files master1 &&
+	test_commit -C files master2 &&
+	test_commit -C files master3 &&
+
+	: perform subtree merge into files_subtree/ &&
+	git fetch files refs/heads/master:refs/heads/files-master &&
+	git merge -s ours --no-commit --allow-unrelated-histories \
+		files-master &&
+	git read-tree --prefix=files_subtree -u files-master &&
+	git commit -m "Add subproject master" &&
+
+	: add two extra commits to rebase &&
+	test_commit -C files_subtree master4 &&
 	test_commit files_subtree/master5
 '
 
-- 
gitgitgadget

