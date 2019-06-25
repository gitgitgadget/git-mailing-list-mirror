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
	by dcvr.yhbt.net (Postfix) with ESMTP id 627D41F461
	for <e@80x24.org>; Tue, 25 Jun 2019 14:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731419AbfFYOte (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 10:49:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43946 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731171AbfFYOtd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 10:49:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id e3so27492160edr.10
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 07:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=528239hnOHI6K+T7ibhsYcnma7vmlnOrafBrcPk1qOY=;
        b=eSw2IJoIWd6WmvYGGfhQbxC4qreTs9Z0VRncFT//ZF0ZsjqzF/bOW2CgeaVp1U7RGt
         IyPgwraLlJFRDs3cEOGDLYIQbQiy3j6FnMd2xWgpqciQ2T+WRs2Ykkq8+2AENZRU8cwi
         zRsFBbSPhPwSA8rt5JpcPQLl4Kv/A1u5E1d5Iro3/cw+HmOT3T/ETiT+SL/66hxp6SQc
         4qtUAOLilY3UPy1uBCK8zcoWfCB5Cb2LW+BuvWqGE6s075wqnNYFLpEbEhSvn9oGJP7k
         5IwZvkx8MbLMlzFlSBCG6fSOkdA6uUiel3Fzyj/sIOfcjJ2XnLhVSiLDobLlHsfZUVja
         iAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=528239hnOHI6K+T7ibhsYcnma7vmlnOrafBrcPk1qOY=;
        b=Qa8DT5NBkG+KA05p8tnmts3/aRGs4f5xqwvzkC9latViSC3LB7Cj5cj+m1BHnKrFUo
         D9S+ODaI7jwqRI37A7sWL4Zk9uMcO00Ec2hq1M0e/l77tx5whWfvvb9KM0B6oSaFkkEC
         79cAKq4eYj1+WAp3nHUaInkAuahZel00V73jv6Ng1QpWenC3yGORG1Pmv5eholQWWHjY
         NqvkJ3/fHghDZie6suPpPlHyMm3NOBHeeYOII7P2bCHvbIfUKv+CZ0kcwA26BaTELzFZ
         SP0U4TLVsGWG0TV05QeW6bMqRPVlR+VPJjfLdmLu7E3+JZ1nIor1DbsCvaoIaT95iznt
         4azg==
X-Gm-Message-State: APjAAAVO3ro+GF+X+5NeX+wuCQRG4/caOMdIWbMNSlnccN7fuLmBt1Cp
        GsZ/aXZPN9eEstr0vf9QkR0c8vSs
X-Google-Smtp-Source: APXvYqxK6dYeX3da8lZCdBDjx4TYrgzEzTS4nF1gJYBrT8AYh1G5T/BE5nW8w1X6qAlmyF7dqKw90Q==
X-Received: by 2002:a50:94e6:: with SMTP id t35mr133090737eda.137.1561474171135;
        Tue, 25 Jun 2019 07:49:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f36sm4738230ede.47.2019.06.25.07.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:49:30 -0700 (PDT)
Date:   Tue, 25 Jun 2019 07:49:30 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 14:49:09 GMT
Message-Id: <3e108cfb0250919c10833bcff3985e79c6452ae0.1561474167.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v3.git.gitgitgadget@gmail.com>
References: <pull.149.v2.git.gitgitgadget@gmail.com>
        <pull.149.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 03/20] t0001 (mingw): do not expect a specific order of
 stdout/stderr
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
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
the *presence* of both outputs, so let's test exactly that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0001-init.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 77a224aafb..387e4e6b81 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -473,8 +473,8 @@ test_expect_success MINGW 'redirect std handles' '
 		GIT_REDIRECT_STDOUT=output.txt \
 		GIT_REDIRECT_STDERR="2>&1" \
 		git rev-parse --git-dir --verify refs/invalid &&
-	printf ".git\nfatal: Needed a single revision\n" >expect &&
-	test_cmp expect output.txt
+	grep "^\\.git\$" output.txt &&
+	grep "Needed a single revision" output.txt
 '
 
 test_done
-- 
gitgitgadget

