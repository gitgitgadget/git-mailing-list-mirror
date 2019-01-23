Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41C3A1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 14:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfAWOkh (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 09:40:37 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:41423 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfAWOkd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 09:40:33 -0500
Received: by mail-ed1-f44.google.com with SMTP id a20so1862780edc.8
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 06:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D/xMBG3VYCTIdwTucGhD4/lsdRH5mFPt1pjIs1nYDZQ=;
        b=AT9t7IRph917FUm/AHuNx34TO5/hx6nV9MmZXGsnKhfORxpaHv9qypAeVBtEExK0Ww
         h0H0tXPekBSbLpDx4/60OJjSvaOSgMSKuf2g9/Pn+E8HHeg5Rt3x9IxdkKBZllBeC7cy
         NhW+Oj/V5rcpcnV5j6wrHZ326S2kxC6s5jSxaUgZXOYUBOOPf5kq1+Pj0lemUJsAC5CC
         5Otsunv6Gn7h/cyUS1R0dUY1BwrkAmE+BKTfgp8D+/OEg9l+G7p09dwKaT1fXmFAa5S6
         In69qPUVE1SUQrM/16SVZBQE6trRjWm83G74HGtvA7vV4DraiwrLwpWPv7OoCUwrl40Q
         pn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=D/xMBG3VYCTIdwTucGhD4/lsdRH5mFPt1pjIs1nYDZQ=;
        b=nH28Vv2fTytl9hkM5jjGsFM1PkWepNVdn9Oiqi9f5D1UwozbrDRkBdmRMWwjy0uIj+
         5hzOYC/C3zM3d1r0q13naXYbazwmF7j8pDtnDSfzuMFhYLcttLtZdXg9fuS3UyzT1D5J
         nFiNJjc3WJS+u4IyInJtamAvOv1w7LXm8qsMK9ksIi2YsXt5RYNWdXRiUHoAjiBPGMG8
         fZp8+HdSO9sJ1956VQOdFte13Cd/saSwzcigL166IkTyRiDDGB9cRdi57h7j7HxY4kQR
         XMCTbdvTK3Cwn2b125jTX25npM9/NMvEfXaE9ivoD+b+X8MX0m14p4tLNj5pvZIdOYUh
         1Bdg==
X-Gm-Message-State: AJcUukf4RzZk9eEfk4hWIWJfGt8Vs9TqgxeIYaxLPQUZZ2sTD7gqJsdt
        C2xuLjbAhnnSkHgCXbq5T3QGPRgF
X-Google-Smtp-Source: ALg8bN4udsCc2Wt9xGQgPGmDs4FLAa5HzcODwSbM0oUwITSavqlvO9ALoJM8TNiA9Sb+pwLewK3Wtg==
X-Received: by 2002:a17:906:7057:: with SMTP id r23-v6mr2656988ejj.113.1548254431281;
        Wed, 23 Jan 2019 06:40:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q16sm9875619eds.60.2019.01.23.06.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:40:30 -0800 (PST)
Date:   Wed, 23 Jan 2019 06:40:30 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 14:40:11 GMT
Message-Id: <6520f4603c78d38f5168164218dc108833a5583d.1548254412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v4.git.gitgitgadget@gmail.com>
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 20/21] ci: speed up Windows phase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As Unix shell scripting comes at a hefty price on Windows, we have to
see where we can save some time to run the test suite.

Let's skip the chain linting and the bin-wrappers/ redirection on
Windows; this seems to shave of anywhere between 10-30% from the overall
runtime.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index 91cf1402bf..e1d5222ceb 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -43,6 +43,8 @@ then
 	BREW_INSTALL_PACKAGES=
 	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
 	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
+	test windows_nt != "$CI_OS_NAME" ||
+	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 fi
 
 skip_branch_tip_with_tag () {
-- 
gitgitgadget

