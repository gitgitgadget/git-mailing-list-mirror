Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39109C433EF
	for <git@archiver.kernel.org>; Sun, 30 Jan 2022 09:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354491AbiA3JoJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Jan 2022 04:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354463AbiA3JoG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jan 2022 04:44:06 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1485EC06173B
        for <git@vger.kernel.org>; Sun, 30 Jan 2022 01:44:06 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h20-20020a17090adb9400b001b518bf99ffso15232776pjv.1
        for <git@vger.kernel.org>; Sun, 30 Jan 2022 01:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a9rJXlrA0Eg2XmtZayTHQXj0N8OxP7VBjTn0LOt/EQc=;
        b=pK+9WWGMAtPfGOw9cG6UYaEUSr7XSLudyx1uGTaLilPcfq8mt/JAIBRFTpSWPyVUAz
         u5a+vdTdMrmZZhuxBtcydvq4lPUD69gtLuahKV3wWmpNNecxFcrJtojCHDxRp1v/O4ud
         kryTnooIhojvYMSdNAjNDBs4QiwQog4moOsLyKlbLqa1ZH+ShdBkcHD5YnOD1moG63bu
         H7M2ppOCnyIhm7tup9HYfqPFTmgYMeCsicMguSxrUm6G/hN+w31bwH6wdzWrQOOpW+TM
         rdDh32JqkLgl5ByjeE3GtECxPp/d7jj/ddORw13TOCkqtYafqoOm3nvGoTMBHgQUG3Di
         BJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a9rJXlrA0Eg2XmtZayTHQXj0N8OxP7VBjTn0LOt/EQc=;
        b=CDRbB2UT2dZTbfJSmf5g74CLtRCEH83LyHDxYdKQwFFWGmKZJ/HOhPoBmJrRkdX1yq
         4Nff+dS0QJ4PY3J7mA8JyYGzUJpzt8ZcfklnijuFoxBC380S18WzYgSDa0ZXhzM7H+8k
         iG44Fl8r+WKmlHGCwv6dAFPvkRWJ+hBFxfRrBZQ58myAdS/2Pp4Ub3sL4G51IhVMhxkK
         5TJTs+MKfEP3xyRl0Pb/T4cmvC9ruYlvkWLuZLuaZDQktLy3hJzl/qRa1TBxf/d+AgXR
         kpjiai0OK6WFZyK0Yg9qc1Tc46NxyFn/DaF093lS5Y01C2PljytN0F8qDeh+uU78eWZ0
         WHvA==
X-Gm-Message-State: AOAM533a1xju3xlmdQkfgN23mFwDdoLshdKRZgoFbu7PnKxsANMCnGIb
        8AzQtqIk2gQr2NotLjHD+g8=
X-Google-Smtp-Source: ABdhPJyPY970rARWNXnJo/yF3gXgSkvP6Y25wQw55NVg4qdUypfXff6qy27tjvuwCb/KMhzPnjHZIQ==
X-Received: by 2002:a17:90b:1bc7:: with SMTP id oa7mr28557765pjb.149.1643535845605;
        Sun, 30 Jan 2022 01:44:05 -0800 (PST)
Received: from ffyuanda.localdomain ([101.206.226.106])
        by smtp.gmail.com with ESMTPSA id il4sm8067888pjb.25.2022.01.30.01.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 01:44:05 -0800 (PST)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: [PATCH v2 2/2] t/lib-read-tree-m-3way: replace spaces with tabs
Date:   Sun, 30 Jan 2022 17:43:57 +0800
Message-Id: <20220130094357.515335-3-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220130094357.515335-1-shaoxuan.yuan02@gmail.com>
References: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
 <20220130094357.515335-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---

This commit simply replaced indentation spaces with tabs.
e.g.

-    git update-index --add SS
+	git update-index --add SS

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

