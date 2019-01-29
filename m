Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70F8B1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 17:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfA2RFV (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 12:05:21 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35501 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbfA2RFU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 12:05:20 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so16610574edx.2
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 09:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1M//82zNVpHbz6gdaDacDbKESJSSZSy8lteIgevo7KM=;
        b=rjqSu/iBVKAq32XD3S/CBMjj1PgCARBn2GUBR+0zhLOUNDKW0ptYUUIUd9lvWLKrB5
         mNyx80qLJyhQjWFI1y7LEyPoBtk+OkJHDiuD1PP9SlCskQx0BxkgMy0ilnLFS9XX0nux
         uRfdrqgLiNk9wtsE2/kJSPRDikUTTe7//KaScZmBqlFvqKW++9f5ltk4KtknMaZu4ccC
         9XjI52/9crAnGKsMEnNvuKQVw1fumORbNo+knz77wRxs7ppje/Oho3m2MtR3lzIYWvjn
         NzeKQPXCgPspp9XPIAQ4UAbRuc7QADqoO2eqEGfnb0ppKDDQOuiCOae8SNDG/RTLKd0s
         s5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1M//82zNVpHbz6gdaDacDbKESJSSZSy8lteIgevo7KM=;
        b=mqtr8n5oTXeP6R/ooS7kdvO03PB1KQuFPGS5b4xwhSKT9Rli/4tp02Co9H2bu2L6Pj
         ZPxG/JS57tAiezYthVmDE+iEZrAEd9INKfHX/dNRRnj/XHWdvmfnxMNkEuEfcnLHEwun
         FLon0deDjRDoYfUc7IIdgA6z6LdHKkEsFL1Dd4PvcVp9XGMGHsXS6Lp9V5BXoqRldBw0
         i626aTITJr9LVSLAcIVK9K+8pygoBaI12/IslEVYscITwKLne2ZrUjnjECj80AnGAS31
         tQKlZAASmPUogo2rtsvI81sqJUqXPFPkMaflDfIJCGnDQF6ZbQl1mDm12ZVF+t11s1cH
         Sv2A==
X-Gm-Message-State: AJcUukfBjgKD2h5A4v42YQuDcbbBGwrcSeJZyIVoqr3RG0w7DaWBm0rA
        GniINfgilKeA7AMkQhrUS5mpmnK3
X-Google-Smtp-Source: ALg8bN5tGczxeZZZZGIVCu8+0cv7rzVjLOXooy8difvz9tKUNza9vjWoiOoWCMkqIWD2QPO3bv0pBg==
X-Received: by 2002:a17:906:b886:: with SMTP id hb6mr18109529ejb.71.1548781518653;
        Tue, 29 Jan 2019 09:05:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x47sm14816755eda.91.2019.01.29.09.05.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 09:05:18 -0800 (PST)
Date:   Tue, 29 Jan 2019 09:05:18 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 17:05:16 GMT
Message-Id: <af810fad9765a09d598981b4244945bc74404609.1548781516.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.114.v2.git.gitgitgadget@gmail.com>
References: <pull.114.git.gitgitgadget@gmail.com>
        <pull.114.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] Makefile: add coverage-prove target
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, szeder.dev@gmail.com, Johannes.Schindelin@gmx.de,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Sometimes there are test failures in the 'pu' branch. This
is somewhat expected for a branch that takes the very latest
topics under development, and those sometimes have semantic
conflicts that only show up during test runs. This also can
happen when running the test suite with different GIT_TEST_*
environment variables that interact in unexpected ways

This causes a problem for the test coverage reports, as
the typical 'make coverage-test coverage-report' run halts
at the first failed test. If that test is early in the
suite, then many valuable tests are not exercising the code
and the coverage report becomes noisy with false positives.

Add a new 'coverage-prove' target to the Makefile,
modeled after the 'coverage-test' target. This compiles
the source using the coverage flags, then runs the test
suite using the 'prove' tool. Since the coverage
machinery is not thread-safe, enforce that the tests
are run in sequence by appending '-j1' to GIT_PROVE_OPTS.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index 1a44c811aa..23d8730482 100644
--- a/Makefile
+++ b/Makefile
@@ -3077,6 +3077,11 @@ coverage-test: coverage-clean-results coverage-compile
 	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
 		DEFAULT_TEST_TARGET=test -j1 test
 
+coverage-prove: coverage-clean-results coverage-compile
+	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
+		DEFAULT_TEST_TARGET=prove GIT_PROVE_OPTS="$(GIT_PROVE_OPTS) -j1" \
+		-j1 test
+
 coverage-report:
 	$(QUIET_GCOV)for dir in $(object_dirs); do \
 		$(GCOV) $(GCOVFLAGS) --object-directory=$$dir $$dir*.c || exit; \
-- 
gitgitgadget
