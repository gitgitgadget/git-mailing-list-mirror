Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EFCF1F404
	for <e@80x24.org>; Sat, 10 Mar 2018 15:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932439AbeCJPzL (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Mar 2018 10:55:11 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34900 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932150AbeCJPzK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Mar 2018 10:55:10 -0500
Received: by mail-pl0-f68.google.com with SMTP id w22-v6so6908540pll.2
        for <git@vger.kernel.org>; Sat, 10 Mar 2018 07:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9yMXDERL+EoylwsSscbLOvOf4O0AWZeP7DoX0bRdPSw=;
        b=ngAMA5iN4dUTzO1s9h1+tVJQDCDbSdjT0q0Jt0EYGHumDw0mF9sWKh53rwxYpx3Im0
         MKIqtWdq7hD0U/0zK1htRUrjd2B8rD94XztucAkIF5c6S2yTDakkaGkr/iKxSdMdg28k
         tLPTUOtSHA3IGoodgCi97meqvYpiKHh2giros8hDPWRRrnyIk2Vhrl8telseWtAwggyz
         VEfcw/qE1E/hb0UClenKhup+36cp4SrqaE61c9qlzglL/WRbtMWFMxYh/kV3bjMp73Cs
         4jCNrFnKL7JSdsSktaSw/2PDVDf+MX6pPolk5jjp1QexBSdMCIVl+2+IrcZiejNl6zN6
         nIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9yMXDERL+EoylwsSscbLOvOf4O0AWZeP7DoX0bRdPSw=;
        b=Z+82yHTm41Vk6Q892LW6uSlO22zbWXY9xanDGXrvzU7XlwN3R4sK00WKYdcvXLIEsh
         P1Njq0/JTutJg2RiANNfRAsN8HTb051XkJo4xMmz8G5a0QUbKD/2Aqv+WCLe3qsQhrvz
         6bPlkoOPfISx5S+PGTnmIw6VscVb8ZwQTCuiCkjLIxxLaY/xg3P7y6ukJWvPtM2VRWV6
         WQTAenRWCHYNgRCjfZ+6e2pkFmSfFr709uBn3r88gtQQsNOL2Wj67R54qU4dg1JuGnwk
         Um1c5sPaMqldPPxUixovQPSjlzEJsau5IP/cxAVHPTIVNaIuYKLZ25NZ0CDMLZuIm0+d
         ex8Q==
X-Gm-Message-State: AElRT7GPiPCkIdQEbX8n8HSLePK9uwUyu5GSldgR0aFprmNll1mRUnde
        6iRMqJ2pMxm/xyIbKHyLFRQrKscU
X-Google-Smtp-Source: AG47ELsVplr9Q3phQ1JzRBI2nTJ4tPvZCEgICdKAqMKyuyrnFugcPaP4eyGciE4iipRqQ1Ntk4KEbw==
X-Received: by 2002:a17:902:7593:: with SMTP id j19-v6mr2385310pll.408.1520697309443;
        Sat, 10 Mar 2018 07:55:09 -0800 (PST)
Received: from localhost.localdomain ([117.209.148.118])
        by smtp.gmail.com with ESMTPSA id j25sm7795956pgn.92.2018.03.10.07.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Mar 2018 07:55:08 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 3/3] t/t3200: fix a typo in a test description
Date:   Sat, 10 Mar 2018 21:24:16 +0530
Message-Id: <20180310155416.21802-4-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f13
In-Reply-To: <20180310155416.21802-1-kaartic.sivaraam@gmail.com>
References: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
 <20180310155416.21802-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 t/t3200-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 503a88d02..6c0b7ea4a 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -528,7 +528,7 @@ test_expect_success 'git branch -c -f o/q o/p should work when o/p exists' '
 	git branch -c -f o/q o/p
 '
 
-test_expect_success 'git branch -c qq rr/qq should fail when r exists' '
+test_expect_success 'git branch -c qq rr/qq should fail when rr exists' '
 	git branch qq &&
 	git branch rr &&
 	test_must_fail git branch -c qq rr/qq
-- 
2.16.1.291.g4437f3f13

