Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F062D20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 14:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbeLMOEV (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 09:04:21 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:38059 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbeLMOEV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 09:04:21 -0500
Received: by mail-pl1-f172.google.com with SMTP id e5so1126507plb.5
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 06:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GzLo7wovnXVXwRa7kMrywRqqPTs/6P9VdvA7HJF+BF0=;
        b=Rm++gFzQDISox9KoJZ13Qn364697EX8/S5p8hohWuItxcPSIkLvm/ZVA/8DaKP4TsM
         YtWp9MrZQlYgzwEf/ZamUWl7ksqlpY2qe0R3St1ggY/HZgfJzhme2bzO0RHGo6LM5g8v
         zQmcVVfFG9Txe4V6h3pVQVBzdPfUz1486GKPkJNgqqwYCkEVwKzmuGtjveawNDeqlPaM
         7+U67izeMmwFtC86Mx0fRnh3siBbYKy29rA9RcqM6aK0/j4w0/osWJ6wFLskwNbaRMj2
         ghCFHKMjW98l3FLbeAPhKz+zUg6LeqVMJIMANTnMTAcryPzT3ueQhsGEwZKkW7NIn6dR
         YHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GzLo7wovnXVXwRa7kMrywRqqPTs/6P9VdvA7HJF+BF0=;
        b=fJV5zDQZVGb0HVO4mGuf2Tcw5pT6D3zfR6saTlue5lW+WEbRWPrcWrh42PwGhuCEf3
         yGFA+kjIiJp8UyO1aNMkOkc4wUIRMOTx0dzsLn43+0ZVTfVZd0PmeZ6vou9QZPhEgSrq
         BDDZtXJrRmLmb2CtuPDbWGxF/v1deJwCVTu9eqQwPONhco7oSPhL9CXIXZuVGQvZBtE7
         qS+otODkhuWN88RDCGDmvUDkYKBaT37TWVs8IMK93I7nUm1AFarUZOPtcYQBCxs7jOPJ
         ij3BB0cluCPWg6dllUonhdis2Ei/cre+77DZYgmkUBgEVY6ldyktp4cQJXs6M7p+po3N
         j/Aw==
X-Gm-Message-State: AA+aEWamQ81PfIdPCWlmq2o0+WbJ29GRFHuIsEdt0wo2sIrqi7Udk3g/
        LLTVa9mnqhxFLOb2TLP2xVrJ3lug
X-Google-Smtp-Source: AFSGD/VCGr0GieFSrudCyFAT4y/iCZZkA+DkVGmiLHNY66Lw0sbSbaK+ZwN6VLd6RovLSJXY4C9elQ==
X-Received: by 2002:a17:902:d01:: with SMTP id 1mr24185103plu.127.1544709860583;
        Thu, 13 Dec 2018 06:04:20 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id l64sm2397937pge.73.2018.12.13.06.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 06:04:19 -0800 (PST)
Date:   Thu, 13 Dec 2018 06:04:19 -0800 (PST)
X-Google-Original-Date: Thu, 13 Dec 2018 14:04:16 GMT
Message-Id: <8e3ddff2c7d2f76a565de33ab638b0778155f2ad.1544709857.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.99.v2.git.gitgitgadget@gmail.com>
References: <pull.99.git.gitgitgadget@gmail.com>
        <pull.99.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] t9902: 'send-email' test case requires PERL
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

The oneline notwithstanding, 13374987dd (completion: use _gitcompbuiltin
for format-patch, 2018-11-03) changed also the way send-email options
are completed, by asking the git send-email command itself what options
it offers.

Necessarily, this must fail when built with NO_PERL because send-email
itself is a Perl script. Which means that we need the PERL prerequisite
for the send-email test case in t9902.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9902-completion.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index d01ad8eb25..137fdc9bd5 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1539,7 +1539,7 @@ test_expect_success 'complete tree filename with metacharacters' '
 	EOF
 '
 
-test_expect_success 'send-email' '
+test_expect_success PERL 'send-email' '
 	test_completion "git send-email --cov" "--cover-letter " &&
 	test_completion "git send-email ma" "master "
 '
-- 
gitgitgadget
