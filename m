Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3622E1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 01:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbfKFBeQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 20:34:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46100 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730712AbfKFBeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 20:34:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id b3so18025773wrs.13
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 17:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RllNBgoTwHFWPr5/7/JsW3N8Oj4aqJGMPdMY06fntX4=;
        b=uBAWVvh79PuNANnTDd1LURyepMt6kMaSCwPF4EiBMwQDB+Ut3QGZoC/U9xj7qmnl3n
         z45EKi3KvlTCujVgmSGxTdbc7K6wt1JaFBEG57ifxxfyapViV5HgIOhglET3pFeap3vQ
         +OuHaCsXL8ncIyexgyw7fhimAYGisqZl/dteLL+rMVO93O73XeWkj+TVwaeot6kInn4X
         ItNrcKTvTgtFMcIF3e0VwhpACUinhnuiJu3w5Bx3PFZmbUjPL/1ytKef9bCrId4KhJuz
         6X7xKmRqpFLe9xJ2ith/pyYFh53+xSOpyF2nNMqWYoMRSgk0eLQ9q0+vkRcQ+FVMUthF
         TY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RllNBgoTwHFWPr5/7/JsW3N8Oj4aqJGMPdMY06fntX4=;
        b=WKi6SkZeVINUmWLS+Ef4+N09f6b20ftOSK6+DwMQSDbDexHfh+LviA8W4BPcZKE+n5
         aXi5GZ4NUe/B/xlZaXs7ZijcQbhfd3W0BBZA03q5rntD8QF7Vi+XaMM1WCYc3JuurEN9
         hI7auSCTN00YjkdnHqvsfIywFC/C8e/gP1ca/Lh02nFim6CRPRf2nZ8LhzMnOURTy0Aw
         Io7XbtVoGkUnlsSYOC9H0U6EmUKB9w3/iVa+sfBMoQfOWqB1e6lJsbJXgYx3Xwl6RXqx
         WcuaJBdPQaz0x71slOAIR/X606iQznWKMgQkaRafcL/HTudi5vaOprF9lmzNTONE2wkD
         JKwg==
X-Gm-Message-State: APjAAAUo8HiGLaa1K9scbYmS3us9SFI7SmyvwjRgASqu1LcroaRJZwky
        ryMtAJk5XvUy/afuG01rVwzmA4D7
X-Google-Smtp-Source: APXvYqyNu9ihCtJ5GsbwkLbSDm2jcZOQmh0jX8SG+MRwZzfLNpoOWDuFwnGWJ/f8vtnrMcLZUwZ4lw==
X-Received: by 2002:a05:6000:1612:: with SMTP id u18mr218033wrb.306.1573004051631;
        Tue, 05 Nov 2019 17:34:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4sm1379316wmd.33.2019.11.05.17.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 17:34:11 -0800 (PST)
Message-Id: <0aaf1799e05e1f942d0a09888c008e7e4b73a8ce.1573004049.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.455.v2.git.1573004049.gitgitgadget@gmail.com>
References: <pull.455.git.1572998303.gitgitgadget@gmail.com>
        <pull.455.v2.git.1573004049.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 01:34:09 +0000
Subject: [PATCH v2 1/1] t6024: modernize style
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

No substantive changes, just a few cosmetic changes:
  * Indent steps of an individual test
  * Don't have logic between the "test_expect_success" blocks that
    the next block will depend upon, move it into the
    test_expect_success section itself
  * Fix spacing around redirection operators to match git style

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6024-recursive-merge.sh | 130 +++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 63 deletions(-)

diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index 27c7de90ce..0c9e3c20e8 100755
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -14,85 +14,90 @@ test_description='Test merge without common ancestors'
 GIT_COMMITTER_DATE="2006-12-12 23:28:00 +0100"
 export GIT_COMMITTER_DATE
 
-test_expect_success "setup tests" '
-echo 1 > a1 &&
-git add a1 &&
-GIT_AUTHOR_DATE="2006-12-12 23:00:00" git commit -m 1 a1 &&
-
-git checkout -b A master &&
-echo A > a1 &&
-GIT_AUTHOR_DATE="2006-12-12 23:00:01" git commit -m A a1 &&
-
-git checkout -b B master &&
-echo B > a1 &&
-GIT_AUTHOR_DATE="2006-12-12 23:00:02" git commit -m B a1 &&
-
-git checkout -b D A &&
-git rev-parse B > .git/MERGE_HEAD &&
-echo D > a1 &&
-git update-index a1 &&
-GIT_AUTHOR_DATE="2006-12-12 23:00:03" git commit -m D &&
-
-git symbolic-ref HEAD refs/heads/other &&
-echo 2 > a1 &&
-GIT_AUTHOR_DATE="2006-12-12 23:00:04" git commit -m 2 a1 &&
-
-git checkout -b C &&
-echo C > a1 &&
-GIT_AUTHOR_DATE="2006-12-12 23:00:05" git commit -m C a1 &&
-
-git checkout -b E C &&
-git rev-parse B > .git/MERGE_HEAD &&
-echo E > a1 &&
-git update-index a1 &&
-GIT_AUTHOR_DATE="2006-12-12 23:00:06" git commit -m E &&
-
-git checkout -b G E &&
-git rev-parse A > .git/MERGE_HEAD &&
-echo G > a1 &&
-git update-index a1 &&
-GIT_AUTHOR_DATE="2006-12-12 23:00:07" git commit -m G &&
-
-git checkout -b F D &&
-git rev-parse C > .git/MERGE_HEAD &&
-echo F > a1 &&
-git update-index a1 &&
-GIT_AUTHOR_DATE="2006-12-12 23:00:08" git commit -m F
+test_expect_success 'setup tests' '
+	echo 1 >a1 &&
+	git add a1 &&
+	GIT_AUTHOR_DATE="2006-12-12 23:00:00" git commit -m 1 a1 &&
+
+	git checkout -b A master &&
+	echo A >a1 &&
+	GIT_AUTHOR_DATE="2006-12-12 23:00:01" git commit -m A a1 &&
+
+	git checkout -b B master &&
+	echo B >a1 &&
+	GIT_AUTHOR_DATE="2006-12-12 23:00:02" git commit -m B a1 &&
+
+	git checkout -b D A &&
+	git rev-parse B >.git/MERGE_HEAD &&
+	echo D >a1 &&
+	git update-index a1 &&
+	GIT_AUTHOR_DATE="2006-12-12 23:00:03" git commit -m D &&
+
+	git symbolic-ref HEAD refs/heads/other &&
+	echo 2 >a1 &&
+	GIT_AUTHOR_DATE="2006-12-12 23:00:04" git commit -m 2 a1 &&
+
+	git checkout -b C &&
+	echo C >a1 &&
+	GIT_AUTHOR_DATE="2006-12-12 23:00:05" git commit -m C a1 &&
+
+	git checkout -b E C &&
+	git rev-parse B >.git/MERGE_HEAD &&
+	echo E >a1 &&
+	git update-index a1 &&
+	GIT_AUTHOR_DATE="2006-12-12 23:00:06" git commit -m E &&
+
+	git checkout -b G E &&
+	git rev-parse A >.git/MERGE_HEAD &&
+	echo G >a1 &&
+	git update-index a1 &&
+	GIT_AUTHOR_DATE="2006-12-12 23:00:07" git commit -m G &&
+
+	git checkout -b F D &&
+	git rev-parse C >.git/MERGE_HEAD &&
+	echo F >a1 &&
+	git update-index a1 &&
+	GIT_AUTHOR_DATE="2006-12-12 23:00:08" git commit -m F
 '
 
 test_expect_success 'combined merge conflicts' '
 	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git merge -m final G
 '
 
-cat > expect << EOF
-<<<<<<< HEAD
-F
-=======
-G
->>>>>>> G
-EOF
+test_expect_success 'result contains a conflict' '
+	cat >expect <<-\EOF &&
+	<<<<<<< HEAD
+	F
+	=======
+	G
+	>>>>>>> G
+	EOF
 
-test_expect_success "result contains a conflict" "test_cmp expect a1"
+	test_cmp expect a1
+'
+
+test_expect_success 'virtual trees were processed' '
+	git ls-files --stage >out &&
 
-git ls-files --stage > out
-cat > expect << EOF
-100644 ec3fe2a791706733f2d8fa7ad45d9a9672031f5e 1	a1
-100644 cf84443e49e1b366fac938711ddf4be2d4d1d9e9 2	a1
-100644 fd7923529855d0b274795ae3349c5e0438333979 3	a1
-EOF
+	cat >expect <<-\EOF &&
+	100644 ec3fe2a791706733f2d8fa7ad45d9a9672031f5e 1	a1
+	100644 cf84443e49e1b366fac938711ddf4be2d4d1d9e9 2	a1
+	100644 fd7923529855d0b274795ae3349c5e0438333979 3	a1
+	EOF
 
-test_expect_success "virtual trees were processed" "test_cmp expect out"
+	test_cmp expect out
+'
 
 test_expect_success 'refuse to merge binary files' '
 	git reset --hard &&
-	printf "\0" > binary-file &&
+	printf "\0" >binary-file &&
 	git add binary-file &&
 	git commit -m binary &&
 	git checkout G &&
-	printf "\0\0" > binary-file &&
+	printf "\0\0" >binary-file &&
 	git add binary-file &&
 	git commit -m binary2 &&
-	test_must_fail git merge F > merge.out 2> merge.err &&
+	test_must_fail git merge F >merge.out 2>merge.err &&
 	grep "Cannot merge binary files: binary-file (HEAD vs. F)" merge.err
 '
 
@@ -116,7 +121,6 @@ test_expect_success 'mark rename/delete as unmerged' '
 	test 1 = $(git ls-files --unmerged | wc -l) &&
 	test_must_fail git rev-parse --verify :2:a2 &&
 	git rev-parse --verify :3:a2
-
 '
 
 test_done
-- 
gitgitgadget
