Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B5FA1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393241AbfAPNgd (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:36:33 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35930 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393221AbfAPNgb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:36:31 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so5440263edb.3
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ziOnt1d5ptto+qoVg/U05MvTYTU5KnFXSFZ0TfHiJK0=;
        b=k6whV3eC3YFMSB/rN2BqM0/Pjr9NZGPn10Ey6G1oMx08e1qxR3CpTS45IQhnBvaVc1
         AZlQiwjg/wPsZR5w60l2cB42Fljryum/JHq4W+aZyDMlppLAafLmnMgjHBb4XN35hnli
         BMhmXykGzneSmm2yY+nqkiEsjvRxnDHuMcMxcr7XrZ9TKJz8fY7Ie0tR43iafsCCqbqY
         RYV7j0PxUakducuWa4bRPD39XvPmrTcvU9Yyd93FztivFI9Jz6fFwC4AoYZWHts8TlZD
         /o0X+2s8C0UAhLZCnZ7fjfjS/Tj1ksNjrZ244QSwEkYI9GOnWy0t+TZ7dH7aQRfN2Y1c
         NKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ziOnt1d5ptto+qoVg/U05MvTYTU5KnFXSFZ0TfHiJK0=;
        b=YMhrbKEgQLkdeGEr883EZ4ReNPn2/yW1tTAS7iGwS4UESzCN7RheemwUXBu4KlP7hX
         jaTx3/Hm7f5oFD6VmvWYYpChXvIEPJ1aC2vckw+tM60Y+rI+GlYcQCxtl/APB0clvTVN
         0WIcWLWesXe21L5dldoZ/+lxnvzZu4aunvyGyyBeql2mqBURvGB1hQSF7By42GvhdrM0
         9S+2SExgFt1zVpwZETWAZVH6ATizwwXVYWnVpHvwf9aKCozk1HK3D+EymPTsvlF4YkNg
         ElobYatDKfMr31yGQf1JqOaOzVn7q+bzdPPKuWu8RsYPQoCsFXnVVcYlhxUOPtfSZqtI
         8KCQ==
X-Gm-Message-State: AJcUukfAJyu32egHnP8U1rYqiDOg1TfkANVcJQiBgT2gKyqzuUwqNlL2
        dSeHL73dNrBFChD3ZbkPDEFzBiu9
X-Google-Smtp-Source: ALg8bN7g/3zK231dA0gW7exUFU053y2To+D9qgMRNP0LEYfOKC3K/dQ3757BT7T6sSbUiVOXYdpdyQ==
X-Received: by 2002:a17:906:2452:: with SMTP id a18-v6mr6926069ejb.17.1547645789779;
        Wed, 16 Jan 2019 05:36:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l20-v6sm3106434eja.18.2019.01.16.05.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:36:28 -0800 (PST)
Date:   Wed, 16 Jan 2019 05:36:28 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 13:36:08 GMT
Message-Id: <fba97133bf476ce66eae77c962440efacee46d6d.1547645770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v3.git.gitgitgadget@gmail.com>
References: <pull.31.v2.git.gitgitgadget@gmail.com>
        <pull.31.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 20/21] ci: speed up Windows phase
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
index c5228c1547..bf5f1c9c0f 100755
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

