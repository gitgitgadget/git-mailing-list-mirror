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
	by dcvr.yhbt.net (Postfix) with ESMTP id 67FAF1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 12:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfFRMYD (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 08:24:03 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38287 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfFRMX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 08:23:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id r12so19254335edo.5
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 05:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r5uoQmZO3M+XVfIq4e5gddCzILUfy/PIzJiD/+VBcEo=;
        b=pm/hV5yarxnvk7kC3CxopxoURCd8+xkCz5tKBqPhV4BJPjE8HOSpiCoBAb0KBKVzv3
         7Q2+F3L7udOC4rdnFk3oZme/vy103zJ96wT80jGl9hAQ6yDosxgPd9cPr5fPQIqc2z+B
         WizDxZCUWeA4+uO/G8BQN5JGa93uLPR7m+zN69j+bnixqkvURJMQW1BJMv8ezZSXbBKQ
         ZkErOp79VL4CQZbVut2dkh1XIxYLZfTzSJq0JdLDDFgh0CmkW3N05XViT3XQHc5x7KND
         yCXi41MyuGhk9t/2RVtHl3mfEDNmfAG++dKxPL4g+8xJwtEIhdznZmy25cEyg6BZSYC0
         SCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r5uoQmZO3M+XVfIq4e5gddCzILUfy/PIzJiD/+VBcEo=;
        b=lI71/mntDnk0HzLbtzZcv1aeSjmrdOeUKOEImUvJ9YTTDNAckS//p3f1+8wEechQLV
         ukWJO8WHgp1zTlKlg7Tk2m2hMLS5MAUOSt/OuXTdwqBPVv1UkvNfvOmO91NreHs/IWRY
         D+rXWlwv00CkCz6xmMokPmNjDy+VKdC9xE66AZmDsuSUmeN0oxJRP5odgA5CqgOE1+WN
         NNa453MbjsnejUr7LS4SP1U1GhA9V8TDj2ODgDfz67XHeJHsD7GSSBw58dvahQViNMNr
         NKQfGaSLD5ezHibCqnXFXCBgEWFoXz1wI2q5Ze7EftbYHHH73tRw2XFoUJis4PN0Ia3J
         Q2ag==
X-Gm-Message-State: APjAAAWib62mcnl362Q0cRZNdZSWHcPf3UwMPOep5M8iDsjlxasmn/bQ
        zTTf9WCcGD9sUF9+j0Bq6aV7k8xc
X-Google-Smtp-Source: APXvYqyFEFQ6nfwzu6OD1tRUYDtvNZ91UMQXu/d4sNieyf8dgwNus2x1l3tfgUfiLOBnAcSzlemVBg==
X-Received: by 2002:a50:974b:: with SMTP id d11mr88771534edb.24.1560860637679;
        Tue, 18 Jun 2019 05:23:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y22sm4392960edw.94.2019.06.18.05.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 05:23:57 -0700 (PDT)
Date:   Tue, 18 Jun 2019 05:23:57 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 12:23:39 GMT
Message-Id: <d551cdeafbf2953ba340aa16554fbd5ac6194a6e.1560860634.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 02/17] t0001 (mingw): do not expect a specific order of
 stdout/stderr
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

When redirecting stdout/stderr to the same file, we cannot guarantee
that stdout will come first.

In fact, in this test case, it seems that an MSVC build always prints
stderr first.

In any case, this test case does not want to verify the *order* but
the *presence* of both outputs, so let's relax the test a little.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0001-init.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 77a224aafb..c7ab18f40f 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -474,7 +474,8 @@ test_expect_success MINGW 'redirect std handles' '
 		GIT_REDIRECT_STDERR="2>&1" \
 		git rev-parse --git-dir --verify refs/invalid &&
 	printf ".git\nfatal: Needed a single revision\n" >expect &&
-	test_cmp expect output.txt
+	sort <output.txt >output.sorted &&
+	test_cmp expect output.sorted
 '
 
 test_done
-- 
gitgitgadget

