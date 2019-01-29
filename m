Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5556E1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 17:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfA2RFU (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 12:05:20 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37711 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbfA2RFT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 12:05:19 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so16571383edb.4
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 09:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CQ8wvi0cJh7j0QVStadM8wtolh8xzebJ2zY8sgegODE=;
        b=fzFv3hycUql+QqhuqPxrD8sgBAaqiuYm68pblsfq2TFqog7zdNGohn4oQv5Fs7j8MU
         f39DwQeNcdffU98dK9UUQ2fSspxn1mwurvZGMLuBrlJs4aPEPg9i2o5N0PvlZa+0umhY
         kKli/6EuDKztVGlYfQIqIpWPQaZk/PzL6rhv54/FS86R9pstjVhfjhoOcS1j1/CBIgLb
         AfpR3+216iHPnZQHP+KGCCc5R0qpni4YakaQEjbHob6s6LuKPXuCDMq2QJ2oB/d99aS2
         JcmJ9KHJZ/qJ8+5MkYuItS/09mTmolBzt6xqLbpG2izteYcHQ5BndFUCRpDwlkHxLtib
         gEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CQ8wvi0cJh7j0QVStadM8wtolh8xzebJ2zY8sgegODE=;
        b=gW2mIsrC9yRmQlTScoC2BeG9CidiojIbjSGW5eM1sFNtYCeIjewoh9Fy81PTj69kYX
         d+PPZOGZ2d5kTB9E4UYh33X/2xCJOjImJE73jhhQvSWOM+G+e28Rsg8j+Sal61WexPxu
         2N0WoitH5ZD6rqWKFfB/9d6tGBXGrEEJQTubEG1Pj2jMetia2Dzu7FgGSGipJWS/4yF8
         nY/3XhGlrQXJG0CeKKX+CqP/FB982KEy2L8R5jwZ7+SNf9BTZg0B6xioS279Rcd0BVAZ
         eZPp5PCoSk4LZA+afZ2j04wlEVO5si+rg+Y4ZtVRjKTVlRiCv3f+OPov7DGM5AHG9xhh
         z6ng==
X-Gm-Message-State: AJcUukfuwnDRHf0WT4rsK6STf4i8ptJ5y7ELwl4RIDlfYua8+7qWZNSB
        yilhf202aoSH+AaPDJ+oQmuOUTCN
X-Google-Smtp-Source: ALg8bN58oq3NPTTiQUhSLelSCL5GoAJo7ovZxBBK4jfUuRcvxcfsZfAWye7llTPxpjDSQRBScfhcwg==
X-Received: by 2002:a17:906:4201:: with SMTP id z1mr12550711ejk.81.1548781517781;
        Tue, 29 Jan 2019 09:05:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u18sm846438ejl.5.2019.01.29.09.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 09:05:17 -0800 (PST)
Date:   Tue, 29 Jan 2019 09:05:17 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 17:05:15 GMT
Message-Id: <pull.114.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.114.git.gitgitgadget@gmail.com>
References: <pull.114.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] Makefile: add prove and coverage-prove targets
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, szeder.dev@gmail.com, Johannes.Schindelin@gmx.de,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes there are test failures in the 'pu' branch. This is somewhat
expected for a branch that takes the very latest topics under development,
and those sometimes have semantic conflicts that only show up during test
runs. This also can happen when running the test suite with different
GIT_TEST_* environment variables that interact in unexpected ways.

This causes a problem for the test coverage reports, as the typical 'make
coverage-test coverage-report' run halts at the first failed test. If that
test is early in the suite, then many valuable tests are not exercising the
code and the coverage report becomes noisy with false positives.

This patch adds two targets to the Makefile: 'prove' and 'coverage-prove'.
The idea is to use the 'prove' tool to run the test suite, as it will track
failed tests but continue running the full suite even with a failure.

If/when this merges down, I will use this new target for the automation
around the test coverage reports.

Updates in V2:

 * Dropped the 'prove' target
   
   
 * Append '-j1' to GIT_PROVE_OPTS
   
   
 * Commit message tweaks.

Derrick Stolee (1):
  Makefile: add coverage-prove target

 Makefile | 5 +++++
 1 file changed, 5 insertions(+)


base-commit: 0d0ac3826a3bbb9247e39e12623bbcfdd722f24c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-114%2Fderrickstolee%2Fcoverage-prove-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-114/derrickstolee/coverage-prove-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/114

Range-diff vs v1:

 1:  294187c696 < -:  ---------- Makefile: add prove and coverage-prove targets
 -:  ---------- > 1:  af810fad97 Makefile: add coverage-prove target

-- 
gitgitgadget
