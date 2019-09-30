Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A94101F463
	for <e@80x24.org>; Mon, 30 Sep 2019 21:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbfI3VSl (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 17:18:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52251 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfI3VSl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 17:18:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id r19so980861wmh.2
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 14:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EKteq2LqbmJS7qpNSfvODGPn2gF/oPHNT0GuBcYdyX0=;
        b=P5LE5vM9IZ017MdljnpVp4BPHBwgQDY/E0Lkxwj4mIbgPlLfmeRYsXGmkQIDLHZ74T
         2G4hVeRBwaghN0m+rN+zN7HzT2zrA2OCXW9eO8R79eCHJG+DJgJdYs7iKn3DAPRAMkZF
         FfnFkv9CWgWW01W54Cl8OUCzgxmRUgmsxUNeE/rtIqVBxfndvuV8kCVoO1Ms/Dfk6Cx8
         8xvmT8FfowFo+ljiprTIE/MnB4WmMiZi0Tc+F2pwi6C6cTJkrskYRle7RUY3XFIgRNP1
         YDqeIjn0n4cgjHLkJLAJHlnFU0ZDDhT3GpuTPhbBJbNvDYHzSnI7296WrQRz0Olv7lis
         j9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EKteq2LqbmJS7qpNSfvODGPn2gF/oPHNT0GuBcYdyX0=;
        b=DjQYyWP41xLWQ90WMRpS4AS/C3j38nMq/nQiBvh3GlU08EQmRSzId87o29TvX9LIjF
         yyj4vF/0o/olndyvS7aIVfq46oNNVRqjTmQ8NdebFYKW94/JsROW8h+Dsn0IL0hpPSUS
         3YeO5mhkuhJzQ+mpE2xs9YL4n554RaxVKPK8l5nHWhgZIYN7bzhbTk4GxH3kXlmI9zYN
         x0sIHtzISuVA/+ZwIXSdsu8duHa8Mu8CfT172GhVELV7L/UgBXZYXlIBd/xa1EuQy4MJ
         YIx2s+yXNX5TxWqkDwFtNQgF3avRENRrZ5SX0pWtoL0YbZifJ3aHWiOuODLfykt/TVPb
         hK5A==
X-Gm-Message-State: APjAAAVMpKjgNmMSBDoNo9jdjW1L8nd8reW7SQCXn5TyIIy6000x4+Ta
        ZOHytPYWAdl4xTcm7pONYQQeiKyv
X-Google-Smtp-Source: APXvYqxLMUddCrHc4rQZ+VqcA4pFsBKKPzwMQXpeXpk6xFe82BvYaJIGkLvYN17hYrpBYRlpzaMkww==
X-Received: by 2002:a7b:c10c:: with SMTP id w12mr278202wmi.26.1569864114482;
        Mon, 30 Sep 2019 10:21:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b7sm10797907wrj.28.2019.09.30.10.21.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 10:21:53 -0700 (PDT)
Date:   Mon, 30 Sep 2019 10:21:53 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Sep 2019 17:21:50 GMT
Message-Id: <pull.352.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.352.git.gitgitgadget@gmail.com>
References: <pull.352.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/2] Git's rename detection requires a stable sort
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the en/merge-recursive-cleanup patches already having advanced to next,
the problem I discovered when rebasing Git for Windows' branch thicket
becomes quite relevant now: t3030.35 fails consistently in the MSVC build &
test (this part of the Azure Pipeline will be upstreamed later).

The solution: use a stable sort.

Note: this patch series is based on top of en/merge-recursive-cleanup.

Changes since v1:

 * The function was renamed to git_stable_qsort(), as per Junio's
   suggestion.

Johannes Schindelin (2):
  Move git_sort(), a stable sort, into into libgit.a
  diffcore_rename(): use a stable sort

 Makefile                         |  2 +-
 compat/mingw.c                   | 11 +++--------
 diffcore-rename.c                |  2 +-
 git-compat-util.h                |  9 ++++++---
 compat/qsort.c => stable-qsort.c |  6 +++---
 5 files changed, 14 insertions(+), 16 deletions(-)
 rename compat/qsort.c => stable-qsort.c (89%)


base-commit: 4615a8cb5b3a8d4959c30338925b1fa3b948ae52
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-352%2Fdscho%2Frename-needs-stable-sort-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-352/dscho/rename-needs-stable-sort-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/352

Range-diff vs v1:

 1:  1202809db7 < -:  ---------- Move git_sort(), a stable sort, into into libgit.a
 -:  ---------- > 1:  8a99008a64 Move git_sort(), a stable sort, into into libgit.a
 2:  a95cdf1e94 ! 2:  442140438a diffcore_rename(): use a stable sort
     @@ -16,7 +16,7 @@
          `a~Temporary merge branch 2_0` to `a` during a recursive merge,
          unexpectedly resulting in a clean merge.
      
     -    Let's use the stable sort provided by `git_sort()` to avoid this
     +    Let's use the stable sort provided by `git_stable_qsort()` to avoid this
          inconsistency.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     @@ -29,7 +29,7 @@
       
       	/* cost matrix sorted by most to least similar pair */
      -	QSORT(mx, dst_cnt * NUM_CANDIDATE_PER_DST, score_compare);
     -+	QSORT_STABLE(mx, dst_cnt * NUM_CANDIDATE_PER_DST, score_compare);
     ++	STABLE_QSORT(mx, dst_cnt * NUM_CANDIDATE_PER_DST, score_compare);
       
       	rename_count += find_renames(mx, dst_cnt, minimum_score, 0);
       	if (detect_rename == DIFF_DETECT_COPY)

-- 
gitgitgadget
