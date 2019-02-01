Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 328971F453
	for <e@80x24.org>; Fri,  1 Feb 2019 17:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbfBAR7I (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 12:59:08 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:40458 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730936AbfBAR7G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 12:59:06 -0500
Received: by mail-ed1-f51.google.com with SMTP id g22so6142670edr.7
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 09:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lEO2zm4D+RRdgd0jZP3xHjEnfHFoC5J4c6eHcxbWOoE=;
        b=dGISqX79Dmbbik2zxRfuqhrGWYVkiAHEgHzpcDv4Org/tUOiuAFyC0k4fqIvYitLR4
         rEy1uXXfrloGaoAJ6Gymnj3VvTgrmyZhuLJG9DaEXtN2azIi2sWka12ubPpXNkBXiCoU
         NGi6qcdUp+uygTlAStxlSxQF/c8oy+IozwGEqhaEv3M+DT5VGa5epTJDTXZw8DsWCEXZ
         1fgA4eYWbYq6FkD2rxSet8JNyk+rbKl6GBUZ324YU6mOuUrizjewaVAUX3fsADPoVFw+
         +Hx3T3nVfZuGMD2IrFXUBDS3iqzpNiBW+Bec8DuK5u74DuaPbLxMKwqHzWg9wfSh5huF
         9rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lEO2zm4D+RRdgd0jZP3xHjEnfHFoC5J4c6eHcxbWOoE=;
        b=e/mSTvCRU1CCACDzS5fPo6WcPVKEYmLDVr62qIIw4SBve747jo77OWECJYaf7ku+n1
         Iq+8wLu6PJF7O/zB8XVGI+qR6SEAd1ddO+S4EAfa67XiO3OTkAPEoI0qbAevzi0kSTHo
         ED6AwMRDjhHGMza35cfRPZUgPZ4gDUkmTY9cfEB7sq4NeIHlL4rWW4tFXq125/qiInQh
         Jm1+L4UkcbqswF9KSz2eGKkJ8tmXQ9MlqBTC4c7AcG6Yk1MdX5XlTxChwFxHgIjwPKaC
         Ny4IBhCMfobEjMfKc8B7qHNIz3nGnZJ3b18gV0eGzkbe9qE3SaCMxP/gdAYY2Nqpqvl4
         /BtA==
X-Gm-Message-State: AJcUukc2AfI+ploozq4mMMMRpbkYbqrG9wibMqA8vU24Dg/GzrOPFoTP
        kKrj1BjiJw2h8wWlsRjyaTc87ew2
X-Google-Smtp-Source: ALg8bN7S4e1dM7Q0tEEwI8Gyfbd1M6/iqng/eVluoOciSGYBPg9VYIEA6KAx5dRWTGDmzhN8P8E0Fw==
X-Received: by 2002:a17:906:77da:: with SMTP id m26mr28640658ejn.60.1549043944189;
        Fri, 01 Feb 2019 09:59:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f31sm2266094eda.16.2019.02.01.09.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 09:59:03 -0800 (PST)
Date:   Fri, 01 Feb 2019 09:59:03 -0800 (PST)
X-Google-Original-Date: Fri, 01 Feb 2019 17:58:47 GMT
Message-Id: <c869de80636bd42a504fd5e898ad0449673b850b.1549043936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v5.git.gitgitgadget@gmail.com>
References: <pull.108.v4.git.gitgitgadget@gmail.com>
        <pull.108.v5.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 06/15] trace2:data: add trace2 sub-process classification
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add trace2 classification for long-running processes
started in sub-process.c

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 sub-process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sub-process.c b/sub-process.c
index 8d2a1707cf..3f4af93555 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -88,6 +88,7 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co
 	process->out = -1;
 	process->clean_on_exit = 1;
 	process->clean_on_exit_handler = subprocess_exit_handler;
+	process->trace2_child_class = "subprocess";
 
 	err = start_command(process);
 	if (err) {
-- 
gitgitgadget

