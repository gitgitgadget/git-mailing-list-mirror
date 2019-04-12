Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72A2820248
	for <e@80x24.org>; Fri, 12 Apr 2019 09:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfDLJhZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 05:37:25 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41290 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfDLJhX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 05:37:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id g6so3788775edc.8
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 02:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cfj03u7cjqe525OLOvGdFTd7m0oyq4qTfT+sl2XCBrk=;
        b=sSaBbSpxnsz0tS1HBP7kN1OesOpu+WjD3u82wKq+A2l1tJ/TC5uldXoC8gJVCgNUrM
         WYy2sRes9Hdho0nAZ+nFwdStnZsgf/LBIljFOttoOWvJbt4YxSQOzqGpxP+ufyIvVoGO
         0nk5oBaNMi+jIQE+sCkw4P2amg5m9u2rZnkwD6mRD+2xooNVX+RshsNNA1k4typ8ijR8
         ErKjVXAhKCIk51Z5FS70I0/1D6ryQ1y02xnUyQgSS5/YaRilErpKO66QOcDmjKECb3fV
         ftFpb9U4qFVXQEQDe943N5+roJzxyQxyFvcx3eyVVMYIZmONQ05zHHy46Evc+xIzmzqh
         EIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cfj03u7cjqe525OLOvGdFTd7m0oyq4qTfT+sl2XCBrk=;
        b=KD5P4sucfRjEiADn54R16rorEo2J7lJHlwaaCeJdX5COdMEbl/58ithQGmb4aexq0X
         pHoiSAVtsXLOwgED4C+TdwAExi/fNOHHw2/pDoRWA5QgnXZniYq+n2apcY8oOW1b1nje
         Dy7jVhJ7hIdRBnQt31zIWRWdR0xaszQjSv3v19vNheReRBivzr9QXF3X2xYDyjMlCsiZ
         48pG16sFWsNxjC/A6lAwW/BJlkOT6EKZmLTXIt1l+8raF3lJxd//GZiNTbF7r0IvMa87
         BJKhwEPIlwB65xQfVRa1gshrkBceeL7GC3jq+BzF3rz/dKGSCNBV4kxw6ZLuIuR65uuc
         zD7g==
X-Gm-Message-State: APjAAAVO2K5ygf53sc7kox70y1tVjNOfOpB74dqkHpt7mB9cKvxkJNdV
        Y/vP/P2zdrNOhMr10zdAK0quptT6
X-Google-Smtp-Source: APXvYqzPRV8sZWxg/RmAR/QWr7bigCk1FfkTx7xY/VALyQuCbcWWOouASJd55js8BBZ3IeZSSELGVw==
X-Received: by 2002:a05:6402:150e:: with SMTP id f14mr29342075edw.33.1555061842090;
        Fri, 12 Apr 2019 02:37:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j10sm7459613eja.58.2019.04.12.02.37.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 02:37:21 -0700 (PDT)
Date:   Fri, 12 Apr 2019 02:37:21 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Apr 2019 09:37:13 GMT
Message-Id: <f45c435e4acb765a68b83ab2c5127388c59dc0b1.1555061837.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.167.v2.git.gitgitgadget@gmail.com>
References: <pull.167.git.gitgitgadget@gmail.com>
        <pull.167.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 4/8] t5531: avoid using an abbreviated option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It was probably just an oversight: the `--recurse-submodules` option
puts the term "submodules" in the plural form, not the singular one.

To avoid future problems in case that another option is introduced that
starts with the prefix `--recurse-submodule`, let's just fix this.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5531-deep-submodule-push.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index e2c37fd978..4ad059e6be 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -363,7 +363,7 @@ test_expect_success 'push succeeds if submodule has no remote and is on the firs
 		) &&
 		git add b &&
 		git commit -m "added submodule" &&
-		git push --recurse-submodule=check origin master
+		git push --recurse-submodules=check origin master
 	)
 '
 
-- 
gitgitgadget

