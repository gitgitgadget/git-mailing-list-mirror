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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DCE11F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbfG2UIP (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:08:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42021 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbfG2UIL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:08:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so13297366wrr.9
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IrxWEx8GtkHx4fIAP4Or72H4HaPYjZzV1xwU+EApZWE=;
        b=YAyIVWJuGDG3O0TOZQpGxwH+C9MCUHIOQKt8K+8XE+SRwcG9RqwF2WB+cqlBrBxfKW
         JlVfZBd2wuXSeSOmyDP74Yxy8js8t6UJmFl2oxT3FCIrQu2f/+CYCwHrlkH8jCam0CeT
         0P4I0B+ESa/83saf0vi67O5gVzJU1ff71xh5SHKlS71hpXLSuAWryS+aqAul991UHxgS
         UQcnzuoDfQkDHC2ji0///Cnh/VWIi6cr/gImmsSgGenJfvjpUJsk5B5NdBDuKJBUqaCF
         vAQCX/e23Tjt5yCpd+GUfuYKK2BEf1StWRsHP2KyyTEfHz4W60GcI+joOn3p9RGXYS4c
         Yyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IrxWEx8GtkHx4fIAP4Or72H4HaPYjZzV1xwU+EApZWE=;
        b=ZuVyRoGhps2IWAyrmBuPRzBZy+jHrnGqzyUGEfRD8gSWflz9m4d12QeG5MKPNV6sCV
         4BrZxckwaDVyUJfBGIKc6OvtcmOqJ151K3KXcX+GPFM56o92130gthfOIciijfR4AqWA
         glEo8zG4UTsz+6t/X0Tnn4S7KIl+lkm2LMYIF9KuQkrLZuXrRXSbl4sYe3X3h91OTEJd
         GGEOIeWPI9XUpB29Yw30VHDjctBb2HNB0pPN7XTQCUwYTaUo8jKRnjpmLw6Ywa7gkDvn
         7IRDjIkfYdu0Ec+BCOVATZmlp8pvL+aG7whwwAISN5/lna/FcOvKOlVUULeibb8DuAGz
         G9Zw==
X-Gm-Message-State: APjAAAWeKgz2r3EOjTlkMqYWnAHGqEzpHbdbk/Hmf9tlhiTxU05IsOw2
        9yhUvIzB0ctz8Xc84C0OR0/BO3RY
X-Google-Smtp-Source: APXvYqxvguPW4xmP5/pn0ZWDjjKX5cE9W+QV6CHwuNZmQcgmyS/HVqBZCnRscx37BXLdzbV8waKJ2g==
X-Received: by 2002:a5d:428b:: with SMTP id k11mr88511814wrq.174.1564430889050;
        Mon, 29 Jul 2019 13:08:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a6sm48622511wmj.15.2019.07.29.13.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:08:08 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:08:08 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Jul 2019 20:07:48 GMT
Message-Id: <c696152c7f3e424d2d3ba9f57a2668cc4f1c0629.1564430879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.v2.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
        <pull.287.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 12/23] contrib/buildsystems: error out on unknown option
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

One time too many did this developer call the `generate` script passing
a `--make-out=<PATH>` option that was happily ignored (because there
should be a space, not an equal sign, between `--make-out` and the
path).

And one time too many, this script not only ignored it but did not even
complain. Let's fix that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/engine.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 732239d817..1a12f4d556 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -57,6 +57,8 @@ sub showUsage
         open(F, "<$infile") || die "Couldn't open file $infile";
         @makedry = <F>;
         close(F);
+    } else {
+        die "Unknown option: " . $arg;
     }
 }
 
-- 
gitgitgadget

