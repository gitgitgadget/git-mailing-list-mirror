Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 944921F97F
	for <e@80x24.org>; Wed, 10 Oct 2018 08:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeJJQPI (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 12:15:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36673 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJJQPH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 12:15:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id f18-v6so2200620pgv.3
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 01:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fcCxFYUWPk0CICOdOQIlg2IIpgJaJ407Nj8FgixHykI=;
        b=QCeVjUUr3ApqDfwa6lpM4cX4W4P+DxmH3iB3iT2uCytsIa84UNGRQPbYLRT0AiVcAm
         i5Sp9L9KaYS84mERCX9olwnu4uRCM/0Q0ehTtvMFA19pRDo19BINDaIOeEMl4XsQKvFU
         qtF0BoszgEgJcSdkRE49m1Oujoz5fgObZdSkhZIKO9yK4DLU5WhX0EiFT3EnB3U5rlfk
         mI6siInUphoQs42/RouZEiQmDoXjaHl9rIp7zeaFrqNzd11zMyXO/L+3mNYZzBQpyneF
         2YBKVIHW2JepzDCC9rC8t2dzZIBCr+exuxb3FDB5dJSm+LQY2AFbVAORg42fTr4RY8Q3
         pEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fcCxFYUWPk0CICOdOQIlg2IIpgJaJ407Nj8FgixHykI=;
        b=qIi6T42+Ua6weyXWz53gtpHTmRfJZnhtb64ziJsF6I71bGh1pT6PKm6+LyqvLLjVo9
         hBVJDQ5+2I1T1IvpLKLA9DXFWrzNT5Xo+KGtkJ3dKq25GUPV9Zu9C+IYLPhA2BmdxYdB
         yojybGna0mOJiRxS1imjSv2N7WiAmITIinVvoYV9/jlJTVMNM5BzhJy5JM9400CcV4S4
         QHbgymwOt0cWlzScN7jp6Kcs4ANe7NMjgi33bfxJJ7eu8viTP5DDcdRHEv5o4eJKvkEC
         ZwpkgDxfFViwhhBlJ6kref0Y/zMiu51saEtfAdrMCYkshgi7oJrP5c01kgdspe6S4wPX
         yzcA==
X-Gm-Message-State: ABuFfoiKC+zyWdpj17t+zBP81/tgwAdNyyvpp8awGiLwJLwVkZGauw34
        386z9oXwOwAthRxw6KsBnOpn1JVE
X-Google-Smtp-Source: ACcGV63mizQ9bKVYkLt9jyw4xlil/M5qOx1M2m4GPqwY3HDFvA0GXSN2Tb2rcxLByouFhz5BjE2+kw==
X-Received: by 2002:a62:1316:: with SMTP id b22-v6mr33941148pfj.37.1539161637203;
        Wed, 10 Oct 2018 01:53:57 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id i21-v6sm37281820pgj.55.2018.10.10.01.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 01:53:56 -0700 (PDT)
Date:   Wed, 10 Oct 2018 01:53:56 -0700 (PDT)
X-Google-Original-Date: Wed, 10 Oct 2018 08:53:51 GMT
Message-Id: <2eefdb4874d36f14aac79b24c0f6216911f2143e.1539161632.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.43.v2.git.gitgitgadget@gmail.com>
References: <pull.43.git.gitgitgadget@gmail.com>
        <pull.43.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/2] rebase -i: clarify what happens on a failed `exec`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We had not documented previously what happens when an `exec` command in
an interactive rebase fails. Now we do.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-rebase.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 091eb53faa..db2faca73c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -420,7 +420,8 @@ idea unless you know what you are doing (see BUGS below).
 --exec <cmd>::
 	Append "exec <cmd>" after each line creating a commit in the
 	final history. <cmd> will be interpreted as one or more shell
-	commands.
+	commands. Anz command that fails will interrupt the rebase,
+	withe exit code 1.
 +
 You may execute several commands by either using one instance of `--exec`
 with several commands:
-- 
gitgitgadget

