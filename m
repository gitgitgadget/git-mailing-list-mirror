Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADEDC1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 00:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfKLAN4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 19:13:56 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40863 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfKLAN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 19:13:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id e3so8549385plt.7
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 16:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nF5MIJ365DDnh3GvMFaijHuwLUwniWWPVG/Jw9Zx1kQ=;
        b=A59DMy2Xa+y89KojpaYdJQ4ICfBzxGe2SNcP1yzfJHFvE6aqLir2cvKBhiVgYQUQSY
         k+v5s+RjDazyKr9eSjFQU2WcDLSJLQtXGttACC6uxypAiay/p6vudq2fb9Q6DyOVeh08
         mqT+3rtS6BkvK/OTvKF2hNh9uP510+6VHjrijakeuC0XUb+J9lMabW5QBSIMyVnzh0zq
         ZNDu7DWpUbkZDM63y1qkrPByUiE1DzR9+SJrWTUCVaFkZ1t0q0+YpmAQQ0NlGKAGhLXP
         PolXp2MSgkUx30vHrTkzspY4vq42Exrvo2dWdNl6KhvcoG77Jr9Om0Hhrxn6l5joGcR+
         9A7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nF5MIJ365DDnh3GvMFaijHuwLUwniWWPVG/Jw9Zx1kQ=;
        b=HiMqjNWvV+57KYb725938yd2IX8OKYTytYFx3Qf4pw6lBcK/zLhJdrl3PXhWDWcDCH
         X3Q5btAia3Sbju8noY+MIJv7Db+GTUYbxH6g2fWKN9Tb6svD8ABCevYuixutHOTL0V1S
         o6vV22HK7ahWlf/xPDiQJnLdOfFiZQkFLc3rE+sO0PmX1VWyGJmkNdnTLmWIro6q/Dhd
         kOA3YUDtpf492z9D0CD91EVMrMCc9uTIPygG50hyz0dQjPTEK2R6f3LjRZS39qwFs2dj
         q1ECmHC1hntjl0srjx3rFlIkjiv4/VjgcA+HFqkXhXhBq71nkiK2wDwMt9+x+a2PKW+R
         eVxA==
X-Gm-Message-State: APjAAAWCWisq24Q2RkdnTWREQjG0yG89vkyQLRrBxmXP7ELfu21Rujl2
        4sCesC60qaRvznAzo2IU9ZY/9Grf
X-Google-Smtp-Source: APXvYqxdkPc4Hs+hnHcQdpOzLtKJ9f6/ahyuKnIoxU9atmT1J/frl50qAD6priZhLPffYarQ4cgbrw==
X-Received: by 2002:a17:902:d215:: with SMTP id t21mr29169665ply.125.1573517635256;
        Mon, 11 Nov 2019 16:13:55 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id 16sm17067455pfc.21.2019.11.11.16.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 16:13:54 -0800 (PST)
Date:   Mon, 11 Nov 2019 16:13:53 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 06/14] t5520: remove spaces after redirect operator
Message-ID: <f1141f244f7d543a35bda374ef13ea3826bddbf0.1573517561.git.liu.denton@gmail.com>
References: <cover.1573152598.git.liu.denton@gmail.com>
 <cover.1573517561.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573517561.git.liu.denton@gmail.com>
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
2.24.0.300.g722ba42680

