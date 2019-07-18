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
	by dcvr.yhbt.net (Postfix) with ESMTP id EF3FC1F461
	for <e@80x24.org>; Thu, 18 Jul 2019 13:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390529AbfGRNTS (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 09:19:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39763 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390416AbfGRNTL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id u25so15308687wmc.4
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 06:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IrxWEx8GtkHx4fIAP4Or72H4HaPYjZzV1xwU+EApZWE=;
        b=VdUq5ZyZ/1y1RAaBv5RjF5cBIcsZlCs7hFViPZsW7vSY3tjYaa9LH/ioEkjMEjv+6T
         xXQKDmN/eEc5GZpXchhXh8BVx1uAMBQ25vbzkWSe2ZmX2t+N3FKfujmzVokLTrYq+z61
         JErBs9tHam8poFo2fOIcO9tFCSKGiI37Hzn7yCXiYmr7398WzSmRiSsmxV+0hwJwNVLI
         IaAnxhfLAV8WZDIYe07MGpkpw5MYhYeemBO/TxKO4wBLOL45+Ra/Rvb8UyO3kOPo650J
         EVJHFDZYvno1nbNp9H/H0ZAgNSixvbErn5FXbKKnARXwAY4aopFB9x2484+G8H6pKLFS
         dtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IrxWEx8GtkHx4fIAP4Or72H4HaPYjZzV1xwU+EApZWE=;
        b=R5COhgDxIF0crwVW/CQcwWjJeoszwETGoZdKDHBE2KERfr/DM1ZlurPtqzf6kvDRCt
         9By3ioPu4QPRhIqEUng+F2M18KARO0Yz78R1VdAbMob4lgDA0GYPRv6MROxXFMpPsZcV
         SBZ1rwb+ruX4FVlXrLhF/j3xnBQIqfPPKU3VPJivApd6VgymU9y+5A4DJKzBiMi7PHYC
         CTDtWt5kAbmOMmAS4OkW7WGtmpp/vhDeC+TzL5HG98OAONqqSw7+ck1REAJdJ/1ytwN1
         KPC3uFoNeIrIAE6H/BRAEGu++fPohTdCZrwOLwq8/Eu88EiUfp+3D4PGn+DmcL2KhMd9
         0tbw==
X-Gm-Message-State: APjAAAVh8Ahw2kQ0IMo3v1uFsxREUUKKKtuy35uIwC4OZQ57LRfBJrVj
        dj+Lr5xdpc+C+2vrm7R7ajHKHdS0
X-Google-Smtp-Source: APXvYqw3APoPdGzFFOOYVDv7/ow0pSxJCRjQK9tsfQtdcBglqYjJslF1SvKSUVhkSx1jrAAhKNwy/g==
X-Received: by 2002:a7b:c106:: with SMTP id w6mr44916188wmi.80.1563455949255;
        Thu, 18 Jul 2019 06:19:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 15sm19483045wmk.34.2019.07.18.06.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:19:08 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:19:08 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 13:18:47 GMT
Message-Id: <c696152c7f3e424d2d3ba9f57a2668cc4f1c0629.1563455939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 12/24] contrib/buildsystems: error out on unknown option
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

