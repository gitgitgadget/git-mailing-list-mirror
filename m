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
	by dcvr.yhbt.net (Postfix) with ESMTP id B9B101F461
	for <e@80x24.org>; Tue, 25 Jun 2019 14:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731376AbfFYOtd (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 10:49:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39015 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731198AbfFYOtb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 10:49:31 -0400
Received: by mail-ed1-f67.google.com with SMTP id m10so27561916edv.6
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 07:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EqWet8OWHv5Fm6Wm9fDw7t4RsdT/tqbq3V03EERpNek=;
        b=VYc9CMWwZPvKDnyMOknNycFFnbl+YYdzydTq8OEfYxOziOy7VJvn0q+Jq40TlxtJPE
         8AbnqNRajJ5qO0C4u9/arOiCPtunY7XzDlC+9hrw+ea9iTftbjfmSHqTNFswKqzs3h9B
         tS6K4/BVCMwqJrWZjWTmfip/Om9AkMCqROHB4m9nqj585GR7VLWrGFUqSiZj6kPJJVvX
         mowpck5y2fBFjkts+UGFErK0MBKN5V6l1O7dKsuUEEzJWlQvXn4zwektERdImxoAFTbc
         +KyADt1vIU+A8mkY2nnmSgzGsAwA2rtkZY3wqPZNAqUQ/RQ1bSbaVfJLxF53p/neURcX
         wovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EqWet8OWHv5Fm6Wm9fDw7t4RsdT/tqbq3V03EERpNek=;
        b=NGkZ1009/vaaIskrDiB8APDBivmGm4o05ha6M6f/j6amUzH8ke24L0ndRLC6O0p1BA
         BQFd88k76iWlqFJi9GDts7rRa+RESGbd5NN7KJAUbeb+0SvI+8bjTibYpAWkLfuZLIXi
         6/iWYtEjeTmg7Bret2IOAtpk5G8cSNYikrKRhCgWKI7M1x4cFEPK0uEkeLno8futDSB1
         hooOz0oLCHZBCSgl5YB66FFv12JwTfxp9i03zADccu7YWcX6iQKCWJD5CE3cgBrzI7Af
         v50m1XefFN9V4dObDF1NlXv9Z+cCZUUCg2QM9qlFYYXXCA9zLWPT/jPaYOTs4frebAVk
         bvcA==
X-Gm-Message-State: APjAAAW9XzpZ57NSVbysLE3vnxNHcTd0T6ttpjkimW7Hy2HgkjVz28Et
        8XCa5ZSwNOcGA83+hWi89t5PwE8J
X-Google-Smtp-Source: APXvYqzu6irtckOo5cxDnO+V1hq7/jvxZr5LTw2B664HoaP8SSoBgMrpXZt74uYEyt9RZhdJyUbdHw==
X-Received: by 2002:a50:f091:: with SMTP id v17mr2620736edl.254.1561474170423;
        Tue, 25 Jun 2019 07:49:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm2480575ejr.20.2019.06.25.07.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:49:29 -0700 (PDT)
Date:   Tue, 25 Jun 2019 07:49:29 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 14:49:08 GMT
Message-Id: <aa27e7f9cbfda50a02ac6bb555f2ee6487c47625.1561474167.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v3.git.gitgitgadget@gmail.com>
References: <pull.149.v2.git.gitgitgadget@gmail.com>
        <pull.149.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 02/20] Mark .bat files as requiring CR/LF endings
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

Just like the natural line ending for Unix shell scripts consist of a
single Line Feed, the natural line ending for (DOS) Batch scripts
consists of a Carriage Return followed by a Line Feed.

It seems that both Unix shell script interpreters and the interpreter
for Batch scripts (`cmd.exe`) are keen on seeing the "right" line
endings.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitattributes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitattributes b/.gitattributes
index 9fa72ad450..b08a1416d8 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -5,6 +5,7 @@
 *.pl eof=lf diff=perl
 *.pm eol=lf diff=perl
 *.py eol=lf diff=python
+*.bat eol=crlf
 /Documentation/**/*.txt eol=lf
 /command-list.txt eol=lf
 /GIT-VERSION-GEN eol=lf
-- 
gitgitgadget

