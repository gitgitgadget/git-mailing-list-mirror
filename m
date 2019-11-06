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
	by dcvr.yhbt.net (Postfix) with ESMTP id 798431F454
	for <e@80x24.org>; Wed,  6 Nov 2019 01:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbfKFBeP (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 20:34:15 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:54879 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbfKFBeP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 20:34:15 -0500
Received: by mail-wm1-f43.google.com with SMTP id z26so1510031wmi.4
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 17:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zUHleGroU6NpSGLg+TNzaQvWz7Edl3ckqS/opl5me88=;
        b=qFbKikYmxO0bXCnMFz5xWWB04Kpcfy9b4Y4uImsJl/zlr0hRzYC5dWNc5w8KiCmpXs
         NKWBBlCEdigfAMU7EzIwdSXrFxU/U8ZCQB1g8R1VzMybSinZ3MQn/02y+kMC4ovdJwHZ
         IX9t5+uxdRnEtBuEFE8Zc2eMkAM4bgW0gWnnEwhYHH9n2NycRv9weKQhKgSRtymAmEiE
         VvaU46VXkewOTKhNe8cNTATOfZadB1HfZDwqaXOAgVfJiIm4GScpPthBGiC/8JcFwr3t
         qW1Hd5ZY4X5ROr+ihUr+ATSDIgFhloZp9PlVC6e1tr9wVo4KKewhSvJaWZ20/seXwq1Q
         HxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zUHleGroU6NpSGLg+TNzaQvWz7Edl3ckqS/opl5me88=;
        b=BCZFIixIEYrtKu17R0eY85zP+SDfl8xvulOoAQCVtiqKQESng9xM11bRdDGOOaShU0
         w0Y/RzoiRypCNnJGTAE4qlYwarAG/ywRL37kjD+u7aNqOE1bAHxrCZhX8YklnE3TJV38
         YSpUyCvKsjaTVjkAdyanCwr7sVTuEWkSIQXYQPByH9Kf4bayXQIfnZljZUp9fPwJckuR
         Zfp7I4OKJzVirxalXP//ib1d/5Pd+P4H/WpqvaUp7ce3jlDyoOuHyvtOxtVAk7eopLOi
         /v6S4e2dWj7tMDNvxelG1MzD/LHqEcuy9q1r9be7z/BYQj3QactH4CqvR3R1Q1AyNIDo
         YVcg==
X-Gm-Message-State: APjAAAVKQhq2NPktCD1lJtOEQhkdwtOvqXzK83WHfwMumjCPTV1a0vFs
        PY3CjbEm9yyM11sOFoRMF5iOxnTV
X-Google-Smtp-Source: APXvYqx+2xl42ZVxfUmQplvbbBU6Dj9L7TahHHdDeO4HRtf7cxiUrdHVhVRxeQiSeCLhqWUfALlevA==
X-Received: by 2002:a1c:7c06:: with SMTP id x6mr166439wmc.34.1573004050787;
        Tue, 05 Nov 2019 17:34:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j15sm23281419wrt.78.2019.11.05.17.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 17:34:10 -0800 (PST)
Message-Id: <pull.455.v2.git.1573004049.gitgitgadget@gmail.com>
In-Reply-To: <pull.455.git.1572998303.gitgitgadget@gmail.com>
References: <pull.455.git.1572998303.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 01:34:08 +0000
Subject: [PATCH v2 0/1] t6024: modernize style
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A simple patch to modernize t6024; this was a change I made a few months ago
that I apparently forgot; found while cleaning out old branches.

Changes since v1:

 * Addressed feedback from Eric.

Elijah Newren (1):
  t6024: modernize style

 t/t6024-recursive-merge.sh | 130 +++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 63 deletions(-)


base-commit: da72936f544fec5a335e66432610e4cef4430991
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-455%2Fnewren%2Ft6024-test-modernization-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-455/newren/t6024-test-modernization-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/455

Range-diff vs v1:

 1:  c6349cdbd0 ! 1:  0aaf1799e0 t6024: modernize style
     @@ -15,9 +15,10 @@
       --- a/t/t6024-recursive-merge.sh
       +++ b/t/t6024-recursive-merge.sh
      @@
     + GIT_COMMITTER_DATE="2006-12-12 23:28:00 +0100"
       export GIT_COMMITTER_DATE
       
     - test_expect_success "setup tests" '
     +-test_expect_success "setup tests" '
      -echo 1 > a1 &&
      -git add a1 &&
      -GIT_AUTHOR_DATE="2006-12-12 23:00:00" git commit -m 1 a1 &&
     @@ -61,47 +62,48 @@
      -echo F > a1 &&
      -git update-index a1 &&
      -GIT_AUTHOR_DATE="2006-12-12 23:00:08" git commit -m F
     -+	echo 1 > a1 &&
     ++test_expect_success 'setup tests' '
     ++	echo 1 >a1 &&
      +	git add a1 &&
      +	GIT_AUTHOR_DATE="2006-12-12 23:00:00" git commit -m 1 a1 &&
      +
      +	git checkout -b A master &&
     -+	echo A > a1 &&
     ++	echo A >a1 &&
      +	GIT_AUTHOR_DATE="2006-12-12 23:00:01" git commit -m A a1 &&
      +
      +	git checkout -b B master &&
     -+	echo B > a1 &&
     ++	echo B >a1 &&
      +	GIT_AUTHOR_DATE="2006-12-12 23:00:02" git commit -m B a1 &&
      +
      +	git checkout -b D A &&
     -+	git rev-parse B > .git/MERGE_HEAD &&
     -+	echo D > a1 &&
     ++	git rev-parse B >.git/MERGE_HEAD &&
     ++	echo D >a1 &&
      +	git update-index a1 &&
      +	GIT_AUTHOR_DATE="2006-12-12 23:00:03" git commit -m D &&
      +
      +	git symbolic-ref HEAD refs/heads/other &&
     -+	echo 2 > a1 &&
     ++	echo 2 >a1 &&
      +	GIT_AUTHOR_DATE="2006-12-12 23:00:04" git commit -m 2 a1 &&
      +
      +	git checkout -b C &&
     -+	echo C > a1 &&
     ++	echo C >a1 &&
      +	GIT_AUTHOR_DATE="2006-12-12 23:00:05" git commit -m C a1 &&
      +
      +	git checkout -b E C &&
     -+	git rev-parse B > .git/MERGE_HEAD &&
     -+	echo E > a1 &&
     ++	git rev-parse B >.git/MERGE_HEAD &&
     ++	echo E >a1 &&
      +	git update-index a1 &&
      +	GIT_AUTHOR_DATE="2006-12-12 23:00:06" git commit -m E &&
      +
      +	git checkout -b G E &&
     -+	git rev-parse A > .git/MERGE_HEAD &&
     -+	echo G > a1 &&
     ++	git rev-parse A >.git/MERGE_HEAD &&
     ++	echo G >a1 &&
      +	git update-index a1 &&
      +	GIT_AUTHOR_DATE="2006-12-12 23:00:07" git commit -m G &&
      +
      +	git checkout -b F D &&
     -+	git rev-parse C > .git/MERGE_HEAD &&
     -+	echo F > a1 &&
     ++	git rev-parse C >.git/MERGE_HEAD &&
     ++	echo F >a1 &&
      +	git update-index a1 &&
      +	GIT_AUTHOR_DATE="2006-12-12 23:00:08" git commit -m F
       '
     @@ -117,36 +119,59 @@
      -G
      ->>>>>>> G
      -EOF
     -+test_expect_success "result contains a conflict" '
     -+	cat >expect <<-EOF &&
     -+		<<<<<<< HEAD
     -+		F
     -+		=======
     -+		G
     -+		>>>>>>> G
     -+		EOF
     ++test_expect_success 'result contains a conflict' '
     ++	cat >expect <<-\EOF &&
     ++	<<<<<<< HEAD
     ++	F
     ++	=======
     ++	G
     ++	>>>>>>> G
     ++	EOF
       
      -test_expect_success "result contains a conflict" "test_cmp expect a1"
     --
     ++	test_cmp expect a1
     ++'
     ++
     ++test_expect_success 'virtual trees were processed' '
     ++	git ls-files --stage >out &&
     + 
      -git ls-files --stage > out
      -cat > expect << EOF
      -100644 ec3fe2a791706733f2d8fa7ad45d9a9672031f5e 1	a1
      -100644 cf84443e49e1b366fac938711ddf4be2d4d1d9e9 2	a1
      -100644 fd7923529855d0b274795ae3349c5e0438333979 3	a1
      -EOF
     -+	test_cmp expect a1
     -+'
     ++	cat >expect <<-\EOF &&
     ++	100644 ec3fe2a791706733f2d8fa7ad45d9a9672031f5e 1	a1
     ++	100644 cf84443e49e1b366fac938711ddf4be2d4d1d9e9 2	a1
     ++	100644 fd7923529855d0b274795ae3349c5e0438333979 3	a1
     ++	EOF
       
      -test_expect_success "virtual trees were processed" "test_cmp expect out"
     -+test_expect_success "virtual trees were processed" '
     -+	git ls-files --stage >out &&
     -+	cat >expect <<-EOF &&
     -+		100644 ec3fe2a791706733f2d8fa7ad45d9a9672031f5e 1	a1
     -+		100644 cf84443e49e1b366fac938711ddf4be2d4d1d9e9 2	a1
     -+		100644 fd7923529855d0b274795ae3349c5e0438333979 3	a1
     -+		EOF
      +	test_cmp expect out
      +'
       
       test_expect_success 'refuse to merge binary files' '
       	git reset --hard &&
     +-	printf "\0" > binary-file &&
     ++	printf "\0" >binary-file &&
     + 	git add binary-file &&
     + 	git commit -m binary &&
     + 	git checkout G &&
     +-	printf "\0\0" > binary-file &&
     ++	printf "\0\0" >binary-file &&
     + 	git add binary-file &&
     + 	git commit -m binary2 &&
     +-	test_must_fail git merge F > merge.out 2> merge.err &&
     ++	test_must_fail git merge F >merge.out 2>merge.err &&
     + 	grep "Cannot merge binary files: binary-file (HEAD vs. F)" merge.err
     + '
     + 
     +@@
     + 	test 1 = $(git ls-files --unmerged | wc -l) &&
     + 	test_must_fail git rev-parse --verify :2:a2 &&
     + 	git rev-parse --verify :3:a2
     +-
     + '
     + 
     + test_done

-- 
gitgitgadget
