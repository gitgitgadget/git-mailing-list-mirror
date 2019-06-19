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
	by dcvr.yhbt.net (Postfix) with ESMTP id C86711F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbfFSVGB (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:06:01 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37942 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfFSVGA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:06:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id r12so1289874edo.5
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 14:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=528239hnOHI6K+T7ibhsYcnma7vmlnOrafBrcPk1qOY=;
        b=N+wCU3gO9VlAOfQjatYmpNjXU3SCjEStfcAxOJnzkblVa2/jFSTpUQLicHwha+RovF
         G6MeR5AK2dc6QhsrwWYLSJ1i7Hjvp6F+SWhndmBR3RvMEOWPYkNxCKcHHJfpTgy9fhQU
         h/NCp478pdx+NuOCY6kSxeYJDFHfdHsAGWC2V5vXPUUW4o92wC75ECjBfffT9ANw8VZq
         l/TW5WJtlZ02rxaYdK1lzhrlYuhxrRrXzSGlrVJSTok3TmTki0P8T1tB5ImDT9YBrLsr
         ufgAuZnH741AfBo+3aTKVG/+jR/rDXwhOIDD5UIoRJWh0hBzDliAwJeoW9IrbkA/DVtf
         VxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=528239hnOHI6K+T7ibhsYcnma7vmlnOrafBrcPk1qOY=;
        b=ubeVNzkB39Hyu1e4UdqivOeLt85tbOUe3oBjRsyBcafweh64ec8Zdg0H9SRWff1SKn
         BGNBL15m7QGoqJxrR3NcDOWVK3KhzSYDQoPaMUyocbgt9ve97qRJM5NBM+DbuvHK5/Wv
         TDsau0ZeSk/vR0kXEbgWLg8y1Th4/7jlUoQZPUD/MUGvgLzy/L4rZh4I0qiB3S02LEcu
         K9Vz1YBiCMm4H+EkoU3nC+U6SczySr4KgzDcvcuV5cbuK4NYoeFGYQ10byWGVfVi3HZ2
         rqfqVA73MQgLqqNqYRZ1HFi8sgioDNIVNf/7mWB9/RWtNL0Yx6b+wpZ+MslERimPdWGE
         cuhA==
X-Gm-Message-State: APjAAAUnh6i9twb38l0KyIliOxBVN2Rpx+DLIobkgS5ojm0R0ji8TzZw
        CMBxEj0gvo5g+XBOmL+E47jojPEe
X-Google-Smtp-Source: APXvYqzNokPG/COgidHafPGlFMGqNU/dYVdh7x7c3krzHZZHm9r6A76KGl0MrkavHPYS8sXyl71lLA==
X-Received: by 2002:a50:9422:: with SMTP id p31mr94281462eda.127.1560978358183;
        Wed, 19 Jun 2019 14:05:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10sm914381ejh.53.2019.06.19.14.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 14:05:57 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:05:57 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 21:05:37 GMT
Message-Id: <3e108cfb0250919c10833bcff3985e79c6452ae0.1560978354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v2.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
        <pull.149.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 03/20] t0001 (mingw): do not expect a specific order of
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

