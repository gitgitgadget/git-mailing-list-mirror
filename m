Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE8B120248
	for <e@80x24.org>; Fri, 12 Apr 2019 09:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfDLJhV (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 05:37:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34592 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfDLJhV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 05:37:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id x14so7781197eds.1
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 02:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QbAfOQ4cOaAq+LM8MKpKrOJAnixJh3So+nFx1z+2Swo=;
        b=jwS8hndVJOXTN9bpYLUtReEaaLnE5obZ2337li8MrS0ypbnFRcTYc0nsoiNHpthaw/
         Kj8/ViAe1imIqjusFTl495zfk8Xc6BfVxCFb5c7B6Uu31y28apggH/9K9+s+mrFYNoz6
         SAIMKnlb4NGOhzeMSWaaMswtpa98s8Xj7MmYYHnBXaXUXsvuHE6vZdiM9vqHnf2Uksub
         XbZgvPGlNAhE5fqVuj32nsFkvqP8Zpe1PUoH4eV17+vKAHZspK4Mnsifw3O6VhduaOF4
         b5sE4C9flUYk18KQlJX42xe27VcJBwVkCbV3C6q2/n302NqMH4Ecv/VQPYWfOhRhqc20
         NBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QbAfOQ4cOaAq+LM8MKpKrOJAnixJh3So+nFx1z+2Swo=;
        b=oxNQQLM8I4Vyh5w8vlrBpW+zcfeqQUwbzBZU5w4vSyRfVW012g5B2iTsZoagvzoHnz
         N1mS2fMnHJf16DgBxf5r1Exu6pcTCKTqNOcmeFyZbC5kogaYX6A45fK3j/W4QMBW7pM1
         ArfU0YUqy6CQLUWfLedRyuWNk0YuIIHJKqoXXd6/MeKW5hKlHKKYQ4OfxNmHofPnO79N
         AyGwilbGQiHrXaeUrfrmrpxzqkBjnZo80NPVut/sZ1p0bLDxZ5Bq6TrG1OV4v5OI1CGb
         wsDD+VKlu2uQFZOesk3nbHIIcDpmhtKs4CrsKzz0iUvY9zjYql+zCSNe7pe/VgiUNwhS
         TUJg==
X-Gm-Message-State: APjAAAUpB6mRI+XV8V+vKlIh4WNgbG9cdxs3KBzN1RuocQHlQx9Uu5Pk
        hy33xdxp8gN/nQL0ylstSMaoHNSC
X-Google-Smtp-Source: APXvYqzD/ztCgO0/Ow/M0z0/xLA6FlmN2cPzxKN1pIgBZFweTS2PTNqj+Ze7yrsqJIFv33ggheoSsA==
X-Received: by 2002:a17:906:d515:: with SMTP id ge21mr24341579ejb.7.1555061838689;
        Fri, 12 Apr 2019 02:37:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p24sm1412201edm.43.2019.04.12.02.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 02:37:17 -0700 (PDT)
Date:   Fri, 12 Apr 2019 02:37:17 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Apr 2019 09:37:09 GMT
Message-Id: <pull.167.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.167.git.gitgitgadget@gmail.com>
References: <pull.167.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/8] Do not use abbreviated options in tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We do not want to have tests that need to be changed by completely unrelated
patch series, just because abbreviations that used to be unique are being
made non-unique by said patch series.

I stumbled over this while investigating the test failures in
dl/rebase-i-keep-base
[https://dev.azure.com/gitgitgadget/git/_build/results?buildId=5482&view=ms.vss-test-web.build-test-results-tab]
: the new --keep-base option makes the --keep abbreviation of --keep-empty 
in t5407 non-unique, which causes the test suite to fail.

Changes since v1:

 * Fixed a typo ("expaneded") in the last commit message.
 * Added a regression test for the GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS 
   handling.
 * Adjusted the code in test-lib.sh that makes sure that this variable is
   set: it is now consistent with the way we do similar things in that file
   already.

Johannes Schindelin (8):
  tests (rebase): spell out the `--keep-empty` option
  tests (rebase): spell out the `--force-rebase` option
  t7810: do not abbreviate `--no-exclude-standard` nor `--invert-match`
  t5531: avoid using an abbreviated option
  tests (push): do not abbreviate the `--follow-tags` option
  tests (status): spell out the `--find-renames` option in full
  tests (pack-objects): use the full, unabbreviated `--revs` option
  tests: disallow the use of abbreviated options (by default)

 parse-options.c                        |  9 ++++++
 t/README                               |  4 +++
 t/t0040-parse-options.sh               | 14 +++++++-
 t/t3415-rebase-autosquash.sh           |  2 +-
 t/t3430-rebase-merges.sh               |  4 +--
 t/t5317-pack-objects-filter-objects.sh | 44 +++++++++++++-------------
 t/t5407-post-rewrite-hook.sh           |  4 +--
 t/t5516-fetch-push.sh                  |  4 +--
 t/t5531-deep-submodule-push.sh         |  2 +-
 t/t7525-status-rename.sh               |  8 ++---
 t/t7810-grep.sh                        | 16 +++++-----
 t/test-lib.sh                          |  7 ++++
 12 files changed, 75 insertions(+), 43 deletions(-)


base-commit: 041f5ea1cf987a4068ef5f39ba0a09be85952064
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-167%2Fdscho%2Fdisallow-abbreviated-options-in-tests-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-167/dscho/disallow-abbreviated-options-in-tests-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/167

Range-diff vs v1:

 1:  a1b4b74b91 = 1:  a1b4b74b91 tests (rebase): spell out the `--keep-empty` option
 2:  017ec9a0c7 = 2:  017ec9a0c7 tests (rebase): spell out the `--force-rebase` option
 3:  7d8f6a2ee6 = 3:  7d8f6a2ee6 t7810: do not abbreviate `--no-exclude-standard` nor `--invert-match`
 4:  f45c435e4a = 4:  f45c435e4a t5531: avoid using an abbreviated option
 5:  7372059922 = 5:  7372059922 tests (push): do not abbreviate the `--follow-tags` option
 6:  531450c00d = 6:  531450c00d tests (status): spell out the `--find-renames` option in full
 7:  a722a065d2 = 7:  a722a065d2 tests (pack-objects): use the full, unabbreviated `--revs` option
 8:  04c36b1de9 ! 8:  a27d316855 tests: disallow the use of abbreviated options (by default)
     @@ -14,7 +14,7 @@
      
          For example, if a future contribution added a new mode
          `git init --babyproofing` and a previously-introduced test case used the
     -    fact that `git init --ba` expaneded to `git init --bare`, that future
     +    fact that `git init --ba` expanded to `git init --bare`, that future
          contribution would now have to touch seemingly unrelated tests just to
          keep the test suite from failing.
      
     @@ -115,6 +115,18 @@
       	test-tool parse-options --no-ambig >output 2>output.err &&
       	test_must_be_empty output.err &&
       	test_cmp expect output
     +@@
     + 	test-tool parse-options --expect="verbose: 0" -v -v -v --no-verbose
     + '
     + 
     ++test_expect_success 'GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS works' '
     ++	env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
     ++		test-tool parse-options --ye &&
     ++	test_must_fail env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true \
     ++		test-tool parse-options --ye
     ++'
     ++
     + test_done
      
       diff --git a/t/test-lib.sh b/t/test-lib.sh
       --- a/t/test-lib.sh
     @@ -124,10 +136,11 @@
       export PERL_PATH SHELL_PATH
       
      +# Disallow the use of abbreviated options in the test suite by default
     -+test -n "$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS" || {
     ++if test -n "${GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS:+isset}"
     ++then
      +	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true
      +	export GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS
     -+}
     ++fi
      +
       ################################################################
       # It appears that people try to run tests without building...

-- 
gitgitgadget
