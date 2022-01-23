Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBF9C433EF
	for <git@archiver.kernel.org>; Sun, 23 Jan 2022 06:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiAWGEL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jan 2022 01:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbiAWGEK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jan 2022 01:04:10 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C655C06173B
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 22:04:10 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id p37so12790259pfh.4
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 22:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gu8lggEWUaXn//C5gZFKADg+wJY1H8qQ1ahTNTMyTEk=;
        b=ck0jcp+VtXUcHdSya4CJIFghd3GUbOMWnPTC424MZirEK3IydWT2uvaujQVb5a4c/g
         TGn2AHOCanARNDO+HyWcPVpDJYKvvwrmNujONXEq0RRJTLEd2akBnA72CMCf6CEKdyjo
         EZgtmLAmsPhslGfKvCd0ApgLy2iLiBMp4/TJofEwzlceahMk7Mi0BUbyYGq3kfhjRH/N
         6en5ZCyCZxDFnt6bwNTJrBG6318gVmwXkpBgrvsztdGmfCd2075KH2TFbm49Xphl0Lbm
         rmvPeJ6BVk38VmU7MOsetLD7D/vEb5oD2lxrkqALY0dB6ln8SM/16qi20NhPvW5PD4ZG
         ERRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gu8lggEWUaXn//C5gZFKADg+wJY1H8qQ1ahTNTMyTEk=;
        b=0WwJSmNTBFiPXUTCKLVrQ0VtT4vbCj0amxAEq6sDzt4Pf5+54Mwm7KdCXFU4jz2s52
         CCi+a4TaPcBMIiCBOy0AaDc06+sI9UbBvJSreWddeAaU9ZbVwrK0aywznR14ZFkckQDX
         O11TE0uso/i0AIM1iXzmc/u/aOOQpnkvast9TPa4FA34WSia28RpZJl/kabjSPGsX5Ji
         B5DdQ6JgpoTQx8LYZ2ZR9d8B2M+qEHV/wnWtD9FIt97aLZ91+YZqKzEhaNBbvEaO3q7M
         enfOWYCvsRlZMbMYYHBucrN/9lsvkF6NXR3IjMGZMSWY7Rvu6sv5Y0JCkBZ2rAfDYALF
         HcRg==
X-Gm-Message-State: AOAM533zzxrjI2hRQc1jaFATeEG5xwUIfqS14N/lSkLQD55tvO3Ix+fc
        yNVAt2qIXnNKwNrBGsclx+XrZWl3AIuIdBId
X-Google-Smtp-Source: ABdhPJxIEntns2VZnRwFEJ29d7q56WaMWUryRu0hLtFecwTDCol1F1AJar7zVR+/rIrHBFJSswBFZg==
X-Received: by 2002:a05:6a00:1345:b0:4c8:fe12:32fb with SMTP id k5-20020a056a00134500b004c8fe1232fbmr678043pfu.20.1642917849538;
        Sat, 22 Jan 2022 22:04:09 -0800 (PST)
Received: from ffyuanda.localdomain ([112.195.146.215])
        by smtp.gmail.com with ESMTPSA id e4sm8481375pge.74.2022.01.22.22.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 22:04:09 -0800 (PST)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [GSoC][PATCH] lib-read-tree-m-3way: modernize a test script (style)
Date:   Sun, 23 Jan 2022 14:03:19 +0800
Message-Id: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a microproject, I found another small fix regarding styling to do.

I changed the old style '\' (backslash) to new style "'" (single
quotes).

And I also fixed some double quotes misuse.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
Other than that, I forgot to introduce myself in the last patch and
here it goes:

I'm Shaoxuan Yuan, currently a sophomore majors in Computer Science and Engineering
(CSE) @ University of California, Irvine. 

I have prior open-source experience in which I was [maintaining|contributing to] the
Casbin community. My main language is Python, and I'm a C newbie
because I'm quite interested in contributing to git (since it is in my main daily
toolkit and it is a charm to wield :-) ).

And for now I'm still taking baby steps trying to crack some test script
styling issues. After getting more familiar with the git contribution
process, I will try something bigger (though not THAT big) to get a
firmer grasp of git.

 t/lib-read-tree-m-3way.sh | 154 +++++++++++++++++++-------------------
 1 file changed, 77 insertions(+), 77 deletions(-)

diff --git a/t/lib-read-tree-m-3way.sh b/t/lib-read-tree-m-3way.sh
index 168329adbc..e40739b8db 100644
--- a/t/lib-read-tree-m-3way.sh
+++ b/t/lib-read-tree-m-3way.sh
@@ -8,16 +8,16 @@ do
         p=$a$b
 	echo This is $p from the original tree. >$p
 	echo This is Z/$p from the original tree. >Z/$p
-	test_expect_success \
-	    "adding test file $p and Z/$p" \
-	    'git update-index --add $p &&
-	    git update-index --add Z/$p'
+	test_expect_success 'adding test file $p and Z/$p' '
+	    git update-index --add $p &&
+	    git update-index --add Z/$p
+    '
     done
 done
 echo This is SS from the original tree. >SS
-test_expect_success \
-    'adding test file SS' \
-    'git update-index --add SS'
+test_expect_success 'adding test file SS' '
+    git update-index --add SS
+'
 cat >TT <<\EOF
 This is a trivial merge sample text.
 Branch A is expected to upcase this word, here.
@@ -30,12 +30,12 @@ At the very end, here comes another line, that is
 the word, expected to be upcased by Branch B.
 This concludes the trivial merge sample file.
 EOF
-test_expect_success \
-    'adding test file TT' \
-    'git update-index --add TT'
-test_expect_success \
-    'prepare initial tree' \
-    'tree_O=$(git write-tree)'
+test_expect_success 'adding test file TT' '
+    git update-index --add TT
+'
+test_expect_success 'prepare initial tree' '
+    tree_O=$(git write-tree)
+'
 
 ################################################################
 # Branch A and B makes the changes according to the above matrix.
@@ -45,48 +45,48 @@ test_expect_success \
 
 to_remove=$(echo D? Z/D?)
 rm -f $to_remove
-test_expect_success \
-    'change in branch A (removal)' \
-    'git update-index --remove $to_remove'
+test_expect_success 'change in branch A (removal)' '
+    git update-index --remove $to_remove
+'
 
 for p in M? Z/M?
 do
     echo This is modified $p in the branch A. >$p
-    test_expect_success \
-	'change in branch A (modification)' \
-        "git update-index $p"
+    test_expect_success 'change in branch A (modification)' '
+        git update-index $p
+    '
 done
 
 for p in AN AA Z/AN Z/AA
 do
     echo This is added $p in the branch A. >$p
-    test_expect_success \
-	'change in branch A (addition)' \
-	"git update-index --add $p"
+    test_expect_success 'change in branch A (addition)' '
+	    git update-index --add $p
+    '
 done
 
 echo This is SS from the modified tree. >SS
 echo This is LL from the modified tree. >LL
-test_expect_success \
-    'change in branch A (addition)' \
-    'git update-index --add LL &&
-     git update-index SS'
+test_expect_success 'change in branch A (addition)' '
+    git update-index --add LL &&
+    git update-index SS
+'
 mv TT TT-
 sed -e '/Branch A/s/word/WORD/g' <TT- >TT
 rm -f TT-
-test_expect_success \
-    'change in branch A (edit)' \
-    'git update-index TT'
+test_expect_success 'change in branch A (edit)' '
+    git update-index TT
+'
 
 mkdir DF
 echo Branch A makes a file at DF/DF, creating a directory DF. >DF/DF
-test_expect_success \
-    'change in branch A (change file to directory)' \
-    'git update-index --add DF/DF'
+test_expect_success 'change in branch A (change file to directory)' '
+    git update-index --add DF/DF
+'
 
-test_expect_success \
-    'recording branch A tree' \
-    'tree_A=$(git write-tree)'
+test_expect_success 'recording branch A tree' '
+    tree_A=$(git write-tree)
+'
 
 ################################################################
 # Branch B
@@ -94,65 +94,65 @@ test_expect_success \
 
 rm -rf [NDMASLT][NDMASLT] Z DF
 mkdir Z
-test_expect_success \
-    'reading original tree and checking out' \
-    'git read-tree $tree_O &&
-     git checkout-index -a'
+test_expect_success 'reading original tree and checking out' '
+    git read-tree $tree_O &&
+    git checkout-index -a
+'
 
 to_remove=$(echo ?D Z/?D)
 rm -f $to_remove
-test_expect_success \
-    'change in branch B (removal)' \
-    "git update-index --remove $to_remove"
+test_expect_success 'change in branch B (removal)' '
+    git update-index --remove $to_remove
+'
 
 for p in ?M Z/?M
 do
     echo This is modified $p in the branch B. >$p
-    test_expect_success \
-	'change in branch B (modification)' \
-	"git update-index $p"
+    test_expect_success 'change in branch B (modification)' '
+	    git update-index $p
+    '
 done
 
 for p in NA AA Z/NA Z/AA
 do
     echo This is added $p in the branch B. >$p
-    test_expect_success \
-	'change in branch B (addition)' \
-	"git update-index --add $p"
+    test_expect_success 'change in branch B (addition)' '
+	    git update-index --add $p
+    '
 done
 echo This is SS from the modified tree. >SS
 echo This is LL from the modified tree. >LL
-test_expect_success \
-    'change in branch B (addition and modification)' \
-    'git update-index --add LL &&
-     git update-index SS'
+test_expect_success 'change in branch B (addition and modification)' '
+    git update-index --add LL &&
+    git update-index SS
+'
 mv TT TT-
 sed -e '/Branch B/s/word/WORD/g' <TT- >TT
 rm -f TT-
-test_expect_success \
-    'change in branch B (modification)' \
-    'git update-index TT'
+test_expect_success 'change in branch B (modification)' '
+    git update-index TT
+'
 
 echo Branch B makes a file at DF. >DF
-test_expect_success \
-    'change in branch B (addition of a file to conflict with directory)' \
-    'git update-index --add DF'
-
-test_expect_success \
-    'recording branch B tree' \
-    'tree_B=$(git write-tree)'
-
-test_expect_success \
-    'keep contents of 3 trees for easy access' \
-    'rm -f .git/index &&
-     git read-tree $tree_O &&
-     mkdir .orig-O &&
-     git checkout-index --prefix=.orig-O/ -f -q -a &&
-     rm -f .git/index &&
-     git read-tree $tree_A &&
-     mkdir .orig-A &&
-     git checkout-index --prefix=.orig-A/ -f -q -a &&
-     rm -f .git/index &&
-     git read-tree $tree_B &&
-     mkdir .orig-B &&
-     git checkout-index --prefix=.orig-B/ -f -q -a'
+test_expect_success 'change in branch B (addition of a file to conflict with directory)' '
+    git update-index --add DF
+'
+
+test_expect_success 'recording branch B tree' '
+    tree_B=$(git write-tree)
+'
+
+test_expect_success 'keep contents of 3 trees for easy access' '
+    rm -f .git/index &&
+    git read-tree $tree_O &&
+    mkdir .orig-O &&
+    git checkout-index --prefix=.orig-O/ -f -q -a &&
+    rm -f .git/index &&
+    git read-tree $tree_A &&
+    mkdir .orig-A &&
+    git checkout-index --prefix=.orig-A/ -f -q -a &&
+    rm -f .git/index &&
+    git read-tree $tree_B &&
+    mkdir .orig-B &&
+    git checkout-index --prefix=.orig-B/ -f -q -a
+'
-- 
2.25.1

