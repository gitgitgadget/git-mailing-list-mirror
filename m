Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B5271F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfA2O4L (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:56:11 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44212 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfA2O4K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:56:10 -0500
Received: by mail-ed1-f66.google.com with SMTP id y56so16174851edd.11
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 06:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PnR9bnc4EHv2MBFJKEW3rbETmsfSZ+EsvV5BKXOJ2GU=;
        b=mESRoNfyL1zTQsOXwLddrddw6X+xDXhh4wGtMCPktmntisILxaxFOcFeZTsuw6Qvp5
         xC7zEwM+rCvZkgWyD9Fqc/Ho91hD9VWIT6KkMzMaUyTxVM6TSVa8XyWWJzMlVI+cnOFi
         T1qg2P53MGjhiT2l/Xp43nNSkiCcMnNUrZqszMtmXIC/MQ3vaR4pGwHrTTkUyN15hk8u
         9yxCMUt6tZv62isD86pqpSspmBHuvSBSqWTQy54/Mfk8ylprrhPlgXTWkltnv9NU/TTW
         alHcpX9kHGFhjNfH2B9QAzT0XxB/VPAoTUN2E4U8KsKSJ1sxViZyuUtFm6wzpugtFj29
         SjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PnR9bnc4EHv2MBFJKEW3rbETmsfSZ+EsvV5BKXOJ2GU=;
        b=MBVmcqsKISjCtGMsSvbO4M2b38X6K+m7N0xLUq/qA8GJTcCdNSKJ7HTUq8z0K8k4C0
         0AWuKU+AnoKEa1EhcUNzDKyVwV8giuCkdYGhS5yFnqfx8AyuHVRTnlidOHjcANNrITSn
         LMzFqvkdu8dBCX5R47EMRi/XJf40R3QmcsQsM5yyO7/RHBWm3Mg4PCL1k5oPhefeFVOK
         Ij53SYBlxH7msLEr8xgaHW41U7/MnHbu/Q12P2YsyVdg8VVrgJ8d7UXCbTRYHd8ck8xz
         RQF19/e7DTg8VBjpFNyX354GUeNKauP7Hv7YuIG0aP6QCobMpwd7L4L0tkYlRbVw7bDo
         utaQ==
X-Gm-Message-State: AJcUukcdlp+pn3hu/TN9K69jSRTdFa+hBEp/93a5BEqsYUX4bEp92EPu
        kf8p7xf3qx5o8hiP1gDg7y41eOaS
X-Google-Smtp-Source: ALg8bN5l0qDRyaRlJWEoTyJ0oYdSFUu8HbFiN+hLik/zew/lSEwpSclbNy5Eyr+QHgXDt+L7BDTToQ==
X-Received: by 2002:aa7:da57:: with SMTP id w23mr26021607eds.7.1548773768959;
        Tue, 29 Jan 2019 06:56:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c22sm1978880ejd.39.2019.01.29.06.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 06:56:08 -0800 (PST)
Date:   Tue, 29 Jan 2019 06:56:08 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 14:56:06 GMT
Message-Id: <294187c6968eff952e78bcea808c66fbedbf1f90.1548773766.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.114.git.gitgitgadget@gmail.com>
References: <pull.114.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] Makefile: add prove and coverage-prove targets
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When running the test suite for code coverage using
'make coverage-test', a single test failure stops the
test suite from completing. This leads to significant
undercounting of covered blocks.

Add two new targets to the Makefile:

* 'prove' runs the test suite using 'prove'.

* 'coverage-prove' compiles the source using the
  coverage flags, then runs the test suite using
  'prove'.

These targets are modeled after the 'test' and
'coverage-test' targets.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Makefile b/Makefile
index 1a44c811aa..ec886635ae 100644
--- a/Makefile
+++ b/Makefile
@@ -2665,6 +2665,9 @@ export TEST_NO_MALLOC_CHECK
 test: all
 	$(MAKE) -C t/ all
 
+prove: all
+	$(MAKE) -C t/ prove
+
 perf: all
 	$(MAKE) -C t/perf/ all
 
@@ -3077,6 +3080,10 @@ coverage-test: coverage-clean-results coverage-compile
 	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
 		DEFAULT_TEST_TARGET=test -j1 test
 
+coverage-prove: coverage-clean-results coverage-compile
+	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
+		DEFAULT_TEST_TARGET=prove -j1 prove
+
 coverage-report:
 	$(QUIET_GCOV)for dir in $(object_dirs); do \
 		$(GCOV) $(GCOVFLAGS) --object-directory=$$dir $$dir*.c || exit; \
-- 
gitgitgadget
