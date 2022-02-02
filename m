Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB616C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 06:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244886AbiBBGwu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 01:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244785AbiBBGwj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 01:52:39 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA59C061777
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 22:43:21 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u11so17349061plh.13
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 22:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XYffXZ7HeN5ih6UB3yw9clNgS54dj9r9mHGtTX8eUUY=;
        b=CDav8AqMmQyLKSghz+t8E+BKHsNNW1S+ZSdeSrrMHfIhqdAbqWfGXd7DmMNQrWWD0F
         fwzELdHCWnSb8koicvhZm6VrmKW56zKCuRemwxVPW/ZRtVsgT8SC5vuXv7HN9h/r6fbK
         zh4DbGchNkmKlg1mo2j9ztKN8oFOny8v1VGUMaxWi4/MWLqQf4Dk5pHhAH068AL2VQT6
         oQQVIwAOSYOicvYL/1ar2Mq6mXjhbGvQ63CzPguhAQ2RU/bvf04/cHu/ke5UqT/JZTtU
         fsXxWD/Lqf2XjmS2ItDEmK4kSTCD7jSWjJHViyC2mWnxPo51ESO4x+QnO0iyiAVJTsQM
         Tjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XYffXZ7HeN5ih6UB3yw9clNgS54dj9r9mHGtTX8eUUY=;
        b=hDee+hmCqY7oj+lMLrZwq0ztkl4a4eO700V2mo/dPdgNTkbKjCznDD+UX54QWOmub2
         ZMafXc0uL0qDCDPogsK79smyQced1u9H1+rgGObZe297N72RfhbtGhlUhSE5mi+4Jgg2
         Ho2wHF0dDnn0SuexwH/qrl/7Xy8n/xUF9b44pg7pWq+VTPs5oqP3O9z1BoQKvjc32caG
         aGiODzRCTq09GiIrhuNb4LcDLprYU2iqGL0sydgUhrG+oqUmtGDO3b6/cC4feC9oVsHB
         KU9Ax31fllvbN1QnpCfPomhfo2OAonVQVspn6vuyNarBS6lKLRqpLn3FSyZahtC2UUhu
         lUpQ==
X-Gm-Message-State: AOAM531t6DybEGBX34Rq8uuxoN8yLGzC3v9JCjK8m+H9JF8krtS+YzMW
        vhqfaRXC5VrNWAP7cU/KLus=
X-Google-Smtp-Source: ABdhPJw1rHScNwrCP3GBrg82FgHEB3/38x3UH6SBgcAkycOqtjpb8lEQkmNp5+qKbBgSs3Eqs+IPMg==
X-Received: by 2002:a17:90b:4d0e:: with SMTP id mw14mr6481874pjb.133.1643784200515;
        Tue, 01 Feb 2022 22:43:20 -0800 (PST)
Received: from ffyuanda.localdomain ([101.206.226.106])
        by smtp.gmail.com with ESMTPSA id z1sm21255084pfh.137.2022.02.01.22.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 22:43:20 -0800 (PST)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
Subject: [PATCH v3 2/2] t/lib-read-tree-m-3way: indent with tabs
Date:   Wed,  2 Feb 2022 14:43:00 +0800
Message-Id: <20220202064300.3601-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220202064300.3601-1-shaoxuan.yuan02@gmail.com>
References: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
 <20220202064300.3601-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As Documentation/CodingGuidelines says, our shell scripts
(including tests) are to use HT for indentation, but this script
uses 4-column indent with SP. Fix this.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 t/lib-read-tree-m-3way.sh | 96 +++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/t/lib-read-tree-m-3way.sh b/t/lib-read-tree-m-3way.sh
index 3c17cb7f80..2da25b3144 100644
--- a/t/lib-read-tree-m-3way.sh
+++ b/t/lib-read-tree-m-3way.sh
@@ -3,9 +3,9 @@
 mkdir Z
 for a in N D M
 do
-    for b in N D M
-    do
-        p=$a$b
+	for b in N D M
+	do
+		p=$a$b
 	echo This is $p from the original tree. >$p
 	echo This is Z/$p from the original tree. >Z/$p
 	test_expect_success "adding test file $p and Z/$p" '
@@ -16,7 +16,7 @@ do
 done
 echo This is SS from the original tree. >SS
 test_expect_success 'adding test file SS' '
-    git update-index --add SS
+	git update-index --add SS
 '
 cat >TT <<\EOF
 This is a trivial merge sample text.
@@ -31,10 +31,10 @@ the word, expected to be upcased by Branch B.
 This concludes the trivial merge sample file.
 EOF
 test_expect_success 'adding test file TT' '
-    git update-index --add TT
+	git update-index --add TT
 '
 test_expect_success 'prepare initial tree' '
-    tree_O=$(git write-tree)
+	tree_O=$(git write-tree)
 '
 
 ################################################################
@@ -46,46 +46,46 @@ test_expect_success 'prepare initial tree' '
 to_remove=$(echo D? Z/D?)
 rm -f $to_remove
 test_expect_success 'change in branch A (removal)' '
-    git update-index --remove $to_remove
+	git update-index --remove $to_remove
 '
 
 for p in M? Z/M?
 do
-    echo This is modified $p in the branch A. >$p
-    test_expect_success 'change in branch A (modification)' '
-        git update-index $p
-    '
+	echo This is modified $p in the branch A. >$p
+	test_expect_success 'change in branch A (modification)' '
+		git update-index $p
+	'
 done
 
 for p in AN AA Z/AN Z/AA
 do
-    echo This is added $p in the branch A. >$p
-    test_expect_success 'change in branch A (addition)' '
-	    git update-index --add $p
-    '
+	echo This is added $p in the branch A. >$p
+	test_expect_success 'change in branch A (addition)' '
+		git update-index --add $p
+	'
 done
 
 echo This is SS from the modified tree. >SS
 echo This is LL from the modified tree. >LL
 test_expect_success 'change in branch A (addition)' '
-    git update-index --add LL &&
-    git update-index SS
+	git update-index --add LL &&
+	git update-index SS
 '
 mv TT TT-
 sed -e '/Branch A/s/word/WORD/g' <TT- >TT
 rm -f TT-
 test_expect_success 'change in branch A (edit)' '
-    git update-index TT
+	git update-index TT
 '
 
 mkdir DF
 echo Branch A makes a file at DF/DF, creating a directory DF. >DF/DF
 test_expect_success 'change in branch A (change file to directory)' '
-    git update-index --add DF/DF
+	git update-index --add DF/DF
 '
 
 test_expect_success 'recording branch A tree' '
-    tree_A=$(git write-tree)
+	tree_A=$(git write-tree)
 '
 
 ################################################################
@@ -95,64 +95,64 @@ test_expect_success 'recording branch A tree' '
 rm -rf [NDMASLT][NDMASLT] Z DF
 mkdir Z
 test_expect_success 'reading original tree and checking out' '
-    git read-tree $tree_O &&
-    git checkout-index -a
+	git read-tree $tree_O &&
+	git checkout-index -a
 '
 
 to_remove=$(echo ?D Z/?D)
 rm -f $to_remove
 test_expect_success 'change in branch B (removal)' '
-    git update-index --remove $to_remove
+	git update-index --remove $to_remove
 '
 
 for p in ?M Z/?M
 do
-    echo This is modified $p in the branch B. >$p
-    test_expect_success 'change in branch B (modification)' '
-	    git update-index $p
-    '
+	echo This is modified $p in the branch B. >$p
+	test_expect_success 'change in branch B (modification)' '
+		git update-index $p
+	'
 done
 
 for p in NA AA Z/NA Z/AA
 do
-    echo This is added $p in the branch B. >$p
-    test_expect_success 'change in branch B (addition)' '
-	    git update-index --add $p
-    '
+	echo This is added $p in the branch B. >$p
+	test_expect_success 'change in branch B (addition)' '
+		git update-index --add $p
+	'
 done
 echo This is SS from the modified tree. >SS
 echo This is LL from the modified tree. >LL
 test_expect_success 'change in branch B (addition and modification)' '
-    git update-index --add LL &&
-    git update-index SS
+	git update-index --add LL &&
+	git update-index SS
 '
 mv TT TT-
 sed -e '/Branch B/s/word/WORD/g' <TT- >TT
 rm -f TT-
 test_expect_success 'change in branch B (modification)' '
-    git update-index TT
+	git update-index TT
 '
 
 echo Branch B makes a file at DF. >DF
 test_expect_success 'change in branch B (addition of a file to conflict with directory)' '
-    git update-index --add DF
+	git update-index --add DF
 '
 
 test_expect_success 'recording branch B tree' '
-    tree_B=$(git write-tree)
+	tree_B=$(git write-tree)
 '
 
 test_expect_success 'keep contents of 3 trees for easy access' '
-    rm -f .git/index &&
-    git read-tree $tree_O &&
-    mkdir .orig-O &&
-    git checkout-index --prefix=.orig-O/ -f -q -a &&
-    rm -f .git/index &&
-    git read-tree $tree_A &&
-    mkdir .orig-A &&
-    git checkout-index --prefix=.orig-A/ -f -q -a &&
-    rm -f .git/index &&
-    git read-tree $tree_B &&
-    mkdir .orig-B &&
-    git checkout-index --prefix=.orig-B/ -f -q -a
+	rm -f .git/index &&
+	git read-tree $tree_O &&
+	mkdir .orig-O &&
+	git checkout-index --prefix=.orig-O/ -f -q -a &&
+	rm -f .git/index &&
+	git read-tree $tree_A &&
+	mkdir .orig-A &&
+	git checkout-index --prefix=.orig-A/ -f -q -a &&
+	rm -f .git/index &&
+	git read-tree $tree_B &&
+	mkdir .orig-B &&
+	git checkout-index --prefix=.orig-B/ -f -q -a
 '
-- 
2.35.0

