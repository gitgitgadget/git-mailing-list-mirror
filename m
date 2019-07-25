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
	by dcvr.yhbt.net (Postfix) with ESMTP id ED0E71F462
	for <e@80x24.org>; Thu, 25 Jul 2019 10:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387953AbfGYKLS (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 06:11:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51079 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729812AbfGYKLS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 06:11:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so44447159wml.0
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 03:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JC7Y6UUK4wTj8fsWwU1KYecKXknoaBCkaHUBcYWNd1g=;
        b=E5p7NPtZMLhxYgZbXyvH5JCiLn+eh1ElKmXnPrDN60uX8JYFmfO7sLtbhiqdfpb3m0
         4GSh/IaRckGkWax1/5HeRVUXL/0kcf2fcmYORZjBTYn06RVusCEts3lJZybMI68hrfAs
         JssXh8fduWIErUl5IL4a8Vgwt5VeJmfdVsL4VLVRUu2NcWF5v/FBkpqjnXi9bahNQNCr
         GJZ8VLEe+TF+RxjW21ocGI00wMoYmBGtHsuotBtL+ouL+P0J/L82+HWhE93q8nPdLhLv
         9wjeyudbdPpEZRxw3jouwbTvX++ZKbIH/8bSCys//TT9wqmtmz5UsQutKR4htK65L1dZ
         V/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JC7Y6UUK4wTj8fsWwU1KYecKXknoaBCkaHUBcYWNd1g=;
        b=bd8FKadeRuzrzGYBOAugcH0w/U9NPzy8KDhgj5dx74BJ5xmJPzCVDQzPkw7/c53zuI
         R4sqpEB+WAjlp+SRBkA+QqBlYKWoH1ymSLKur9RDrPdko5i3rU4jMTpCSo01RROX8pMi
         K4CG/2sIh0owfAMyS+CQGT9ryTaK+6S+jd6nOn7mpyiwvQVRG+Tua/jhAxOijJhVQKic
         s1jnCWTuH2SI1ztTHx4Jpfm2Xg9uQtUCgz3d6Bn1eLpAvoWzTFK6oOpQIYidhpwb6tcc
         yz2dkX3QBeeFqRT2pYXxNW4z6fe6dGLwb2nn//wFI/F0iZhd177+EOokVquHibHMFkTJ
         hoHw==
X-Gm-Message-State: APjAAAW/v3ILdTZOEm6JeoqOLzDrBqVtA3tpkgikBve4DGGSwrtr+ba0
        xTLxh206ZM7kOmtKGu43ASk/MZzX
X-Google-Smtp-Source: APXvYqxkPRoxiVsoix0Wx56SxDGtwI6n8wX/dZKZm5QfST0sdqo36HJ5GgODA1IXE66uif1CNE0Fng==
X-Received: by 2002:a1c:9a4b:: with SMTP id c72mr53383254wme.102.1564049476877;
        Thu, 25 Jul 2019 03:11:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12sm53640703wrg.5.2019.07.25.03.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 03:11:16 -0700 (PDT)
Date:   Thu, 25 Jul 2019 03:11:16 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Jul 2019 10:11:03 GMT
Message-Id: <df096e054d7b1646c489af8a7360de328d00c1c0.1564049473.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 02/12] t3427: simplify the `setup` test case significantly
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

It still does the very same thing as before, but expresses it in a much
more succinct (and still quite readable) manner.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3427-rebase-subtree.sh | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index a9b93c39d0..f41a08e436 100755
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

