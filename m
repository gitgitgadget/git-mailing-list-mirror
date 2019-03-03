Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0163420248
	for <e@80x24.org>; Sun,  3 Mar 2019 14:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfCCOo4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 09:44:56 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35818 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCCOo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 09:44:56 -0500
Received: by mail-ed1-f66.google.com with SMTP id g19so2140872edp.2
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 06:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mqy+E9CZngPc3CqdxqnAwKfJ0IrqINuxHiVej8fn66I=;
        b=QRUd+4nQljIeQS1ufziLBdntWuRvGhqXJ93hEcoI97F+gYAAzkPezfskPfjLjpG/tz
         +MYQ3ZooFnf7wWlR9xRxgxbP/huWUG3w6nK8AXHuCdordpC8pFJX6y0yVj3YOHrQOoyH
         YoH7zHiXxt5+uLlCfevwFb277x7o9V7GEabpmHKypyeEN9xryuUhFmmFa4ajcC2d1PYF
         NN8KURDrjLrofsUBoM1sFXRotE7SyUWD8fotZA07huN778D4dd4W2ABWjPe8BPorvTs5
         BfgpjKAm1t5+JHhIBG4pH0F2i7d/KNteezebRNAPov3Z3Eyv6OA03fqdsbiEYDkj6R+l
         7hJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mqy+E9CZngPc3CqdxqnAwKfJ0IrqINuxHiVej8fn66I=;
        b=qAFlBz4TTRS8Dd/lmhnAjtnI8SApzfHDPy/eVcnPnPRTDqqxSNjF94L9bwZD7JOoYS
         ULD4fhhMVzsdrfTo+KK5kapXqrDrRtlOs52KIRn/fw3QnU5AIQs8MFCrZ/SZ44bsJSbt
         7iArhhGSWhBkU4cWcpzPO8xpSjg5x8mphHbwjdGZJ3+Iv94EWopvYvXn3NXqlLRfYxAt
         ckRzmFwH9jQtrFib8U4sae1Kz6Aor/7FWfGOzhO1AhLWnFN0usseK7RscaxQB9W875/k
         R6SH5C5fIIOz7OdpcgeSBNlOdzXwtlxi0kNtUUrMRr0VHXM4BGGnS9gRhEWiPh+JdYKJ
         n+OQ==
X-Gm-Message-State: APjAAAWNujN1WcaMJWrX2W4GU1FLVy66UsLYxJaeSB0U1B+d0lqHUcW3
        QQPZ5kyQySXYVqs+1ATh5ZJBGsY7
X-Google-Smtp-Source: APXvYqxt2EsWnHmasXBxGRo4vUj7XCThtsN4LGTyYznqWeT+IRXsJtQrnltakjTXnMldw6MF97jGYQ==
X-Received: by 2002:a50:9964:: with SMTP id l33mr11723085edb.115.1551624294604;
        Sun, 03 Mar 2019 06:44:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o24sm692218ejx.56.2019.03.03.06.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 06:44:54 -0800 (PST)
Date:   Sun, 03 Mar 2019 06:44:54 -0800 (PST)
X-Google-Original-Date: Sun, 03 Mar 2019 14:44:51 GMT
Message-Id: <pull.155.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.155.git.gitgitgadget@gmail.com>
References: <pull.155.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/2] tests: some touchups related to the --stress feature
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If my mistake using --stress= instead of --stress-limit= is any indication,
then the current options are very confusing.

This is my attempt at making them less confusing.

Changes since v1:

 * Now the patches actually adjust the documentation according to the
   changes ;-)

Johannes Schindelin (2):
  tests: let --stress-limit=<N> imply --stress
  tests: introduce --stress-jobs=<N>

 t/README      | 8 +++++---
 t/test-lib.sh | 9 ++++++++-
 2 files changed, 13 insertions(+), 4 deletions(-)


base-commit: 7d661e5ed16dca303d7898f5ab0cc2ffc69e0499
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-155%2Fdscho%2Fstress-test-extra-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-155/dscho/stress-test-extra-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/155

Range-diff vs v1:

 1:  16c6508c4b ! 1:  fbe773c22a tests: let --stress-limit=<N> imply --stress
     @@ -8,6 +8,19 @@
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     + diff --git a/t/README b/t/README
     + --- a/t/README
     + +++ b/t/README
     +@@
     + --stress-limit=<N>::
     + 	When combined with --stress run the test script repeatedly
     + 	this many times in each of the parallel jobs or until one of
     +-	them fails, whichever comes first.
     ++	them fails, whichever comes first. Implies `--stress`.
     + 
     + You can also set the GIT_TEST_INSTALLED environment variable to
     + the bindir of an existing git installation to test that installation.
     +
       diff --git a/t/test-lib.sh b/t/test-lib.sh
       --- a/t/test-lib.sh
       +++ b/t/test-lib.sh
 2:  281d3f1d19 ! 2:  074628c22b tests: introduce --stress-jobs=<N>
     @@ -13,6 +13,33 @@
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     + diff --git a/t/README b/t/README
     + --- a/t/README
     + +++ b/t/README
     +@@
     + 	variable to "1" or "0", respectively.
     + 
     + --stress::
     +---stress=<N>::
     + 	Run the test script repeatedly in multiple parallel jobs until
     + 	one of them fails.  Useful for reproducing rare failures in
     + 	flaky tests.  The number of parallel jobs is, in order of
     +-	precedence: <N>, or the value of the GIT_TEST_STRESS_LOAD
     ++	precedence: the value of the GIT_TEST_STRESS_LOAD
     + 	environment variable, or twice the number of available
     + 	processors (as shown by the 'getconf' utility),	or 8.
     + 	Implies `--verbose -x --immediate` to get the most information
     +@@
     + 	'.stress-<nr>' suffix, and the trash directory of the failed
     + 	test job is renamed to end with a '.stress-failed' suffix.
     + 
     ++--stress-jobs=<N>::
     ++	Override the number of parallel jobs. Implies `--stress`.
     ++
     + --stress-limit=<N>::
     + 	When combined with --stress run the test script repeatedly
     + 	this many times in each of the parallel jobs or until one of
     +
       diff --git a/t/test-lib.sh b/t/test-lib.sh
       --- a/t/test-lib.sh
       +++ b/t/test-lib.sh

-- 
gitgitgadget
