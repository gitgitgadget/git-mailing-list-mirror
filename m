Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0010A1F461
	for <e@80x24.org>; Thu, 18 Jul 2019 13:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390534AbfGRNTa (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 09:19:30 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:35378 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390482AbfGRNTR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:17 -0400
Received: by mail-wr1-f50.google.com with SMTP id y4so28695474wrm.2
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 06:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rJs8zLNJc5W3EABytVF5MZ2gJQf9eTWKZGXO/abrFIY=;
        b=XgYy5d6AFCM4qhhvlYizDMT0nHuco6xIOT18k7pgCgFI8zqwCUDR3e9UGnQU2on7rQ
         5yqDhkGJhFLm9AWHQ/fZFDO6AE9m4lRYvkG2LSrTuwzGFYfQGLNM5q3yjTV+t8yGze7H
         Fa/otWKEUTqb1+iNmFhD2dRWAy4/e+c9lYKAxWlUjyDhY6zs2dqB2u/9iQzBlYWyhkZV
         Gqh/mV1q8BH3ay0KtTaQh3gPKImi7JDr0i0396EC+wf3a+O7xg7bukR1jVdtvINfeYkE
         x/RQCVD1h2XLXqEr1ODqEkJMqKEb8c/i1DI2mtDmDVwbH7jlQdyyTfAHb7zWXfEguPrl
         C7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rJs8zLNJc5W3EABytVF5MZ2gJQf9eTWKZGXO/abrFIY=;
        b=B1vEcMKmTDGJ3eX7F4lrFqEeBarps5GS82jCbnwntPz/u7THsjjbc0aTqNlJj2EUHC
         eGN1Pa5XjKExZ76CnE0sgW5gUqetxNul2h/qKk1g0k0G4cpy+yYLjABT/zhBa6zagop8
         jJUxyjYiAtsrljX2sn1K9tOOmv8KniJatk1PveMlA1RSRjQe5xIMY31V8heVSji+cPnl
         8eG1L7pXX4m222Q6NKK/edPOuPXSLO8nhkUlWS2w1jqy/aMfbczDstcvcWiF08MTML2E
         Tmk70gCYxhra7x2SjnYNuUxA4ojp0trb9lbQ1QnSAgP0XyCwKywltq0saZW/irfx0pWQ
         d0QA==
X-Gm-Message-State: APjAAAXZYU2v5G4B7v3DbxN3z2fBBM8TAEqOSyKuiXd4WUJedbeXCZXW
        PfIcQJyNJMY4dMFiEG18zPIZGTkT
X-Google-Smtp-Source: APXvYqzv3GlekuD/j0v6lJw9xFDuykeF8p47QZNm4zAnnUW1W4YimzhXxARB9UCqLEsKyxxmExcUqQ==
X-Received: by 2002:adf:db0b:: with SMTP id s11mr3992887wri.7.1563455955250;
        Thu, 18 Jul 2019 06:19:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g17sm18900490wrm.7.2019.07.18.06.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:19:14 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:19:14 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 13:18:56 GMT
Message-Id: <8f19bb5a8c816c4a269a946670b94940a7616247.1563455939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 21/24] .gitignore: ignore Visual Studio's temporary/generated
 files
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

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index e7bb15d301..fcfb708b9e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -233,4 +233,7 @@
 *.manifest
 Debug/
 Release/
+/UpgradeLog*.htm
+/git.VC.VC.opendb
+/git.VC.db
 *.dSYM
-- 
gitgitgadget

