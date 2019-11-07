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
	by dcvr.yhbt.net (Postfix) with ESMTP id 68CB01F454
	for <e@80x24.org>; Thu,  7 Nov 2019 18:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfKGSvg (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 13:51:36 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39621 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfKGSvg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 13:51:36 -0500
Received: by mail-pf1-f194.google.com with SMTP id x28so3130237pfo.6
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 10:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iPxCLePrhm2/kfMH6mNdtlnKt6XOUsR1p2H+WqpKSCw=;
        b=eVxOYaAOHjo0huw6Uj4JJopaTUXKHqNs5FmqpbtWNriq67V6+LVb9/1vW18xnsnPz/
         Z/Ni44l4sLVG20oMkcFZSpHFmRrPNeh0C3LaE3iEcR/r4Dl2GRjukl/Hf0TWWtVdSE4v
         VmHo1FlA22r8Ft87qtQOhjYEPJmZ9tc+Z2lpVhyuTNTkCF2FRUjyhhNBH3VGnpVwrt8K
         C4+Ucl5/rEpSsl/keE6d2UMQSbOWyVQp0OGQ0nNXgfK7RyY7um61kz8XXeQXAGkQJjeM
         NiAmIgM3h0o90j0hOquAWVzugqD1w2kItc3MIcLZPJUuGuFTLLjd+QI/c9LLSueTNrlS
         CgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iPxCLePrhm2/kfMH6mNdtlnKt6XOUsR1p2H+WqpKSCw=;
        b=JlWe4VMUELZWbV3d+xXNeIcR2VOBri9LxT1FQx7w2rfV5eMEMK4hVphZkWZ+oYD5Ke
         eeyjZ9fgC4hfAI9qWh7GCIcUwp84Fwh9sr88dD6EFXVKuUhJNx8LNitqdojKnGdwlwqM
         iQDaGOvhrCpKMo7oPqo+jLYUB+sD6/KxrFraGqwV4y5LxP/qoLbYNaT+GBKgugjvK2cA
         J8vLZSZH0nRKcbbaYgUT+dVJp7vY6KT8ZfDJAmG1QkQq0+YW8vmuVr4Q2cNDggmkP2LW
         csiTq1836Nxxb01UVUdX1PabKvEsby2ZbhtF1nn2t7tDzY0aF+nuMRtBYM44SRv9y1ek
         salw==
X-Gm-Message-State: APjAAAUHtbRHA3JrPuDNf1qjppnyzRy2JUkLcLWZY4A0wnvUR2J9/1Mu
        KHdHfo2IDcGkGN4YhL6zAlSNVSzO
X-Google-Smtp-Source: APXvYqybo9SevUeydWlwSBBD7k7dBV7RmEKxB1UlCUUw3utlCk0InYWGKfQbhXpvw8netwie/4XdFg==
X-Received: by 2002:a63:fc1e:: with SMTP id j30mr3049710pgi.158.1573152693848;
        Thu, 07 Nov 2019 10:51:33 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id w15sm3386054pfn.13.2019.11.07.10.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 10:51:32 -0800 (PST)
Date:   Thu, 7 Nov 2019 10:51:31 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 06/14] t5520: remove spaces after redirect operator
Message-ID: <280cfa0adc516810a3e642b5a3425589bc1ad398.1573152599.git.liu.denton@gmail.com>
References: <cover.1571739459.git.liu.denton@gmail.com>
 <cover.1573152598.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573152598.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The style for tests in Git is to have the redirect operator attached to
the filename with no spaces. Fix test cases where this is not the case.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 004d5884cd..7bb9031140 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -243,10 +243,10 @@ test_expect_success 'fast-forward fails with conflicting work tree' '
 
 test_expect_success '--rebase' '
 	git branch to-rebase &&
-	echo modified again > file &&
+	echo modified again >file &&
 	git commit -m file file &&
 	git checkout to-rebase &&
-	echo new > file2 &&
+	echo new >file2 &&
 	git add file2 &&
 	git commit -m "new file" &&
 	git tag before-rebase &&
@@ -542,10 +542,10 @@ test_expect_success '--rebase with rebased upstream' '
 	git checkout copy &&
 	git tag copy-orig &&
 	git reset --hard HEAD^ &&
-	echo conflicting modification > file &&
+	echo conflicting modification >file &&
 	git commit -m conflict file &&
 	git checkout to-rebase &&
-	echo file > file2 &&
+	echo file >file2 &&
 	git commit -m to-rebase file2 &&
 	git tag to-rebase-orig &&
 	git pull --rebase me copy &&
@@ -591,7 +591,7 @@ test_expect_success 'pull --rebase dies early with dirty working directory' '
 	test_config branch.to-rebase.remote me &&
 	test_config branch.to-rebase.merge refs/heads/copy &&
 	test_config branch.to-rebase.rebase true &&
-	echo dirty >> file &&
+	echo dirty >>file &&
 	git add file &&
 	test_must_fail git pull &&
 	test "$COPY" = "$(git rev-parse --verify me/copy)" &&
-- 
2.24.0.rc2.262.g2d07a97ef5

