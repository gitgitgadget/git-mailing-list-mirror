Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 490581F453
	for <e@80x24.org>; Wed,  6 Feb 2019 17:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbfBFRQA (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 12:16:00 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42659 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731523AbfBFRP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 12:15:59 -0500
Received: by mail-ed1-f65.google.com with SMTP id r15so5085787eds.9
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 09:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m3WRjV0vGcYO/s8Lbvc+ufD3Abycq3lG2DvCDGRaZMY=;
        b=icjOUzFR52RCsOVc3TojREVh7pTyTPC42ZDEKB7kyZrFKZoqCFJd1Wdq6tXZ05Hh7J
         sen7DC4SeGIBp+actYOA9KjSqiMznyGm4s9di2QctbOo+tT7e4q6B3Al465fFoncqc08
         cbZ41jVvFiPIx0YHHoHS4axRY42WbTQJ0GXj/0w+Mof7NK7CcHDQGLWGhc5XuWWAHWND
         et2IDSOyB29UTQaElrU3jPG8cBvlXIAyFbhv/suHBOB8L/Y4Jf2RQssaCfDZ1h7/xMx+
         gEqitnrLUQhXqxRUt566ACNH59NUL+40JYVU1kxsp6sKxHwMKdhQTB0fq9P/gAhwIZzd
         wGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m3WRjV0vGcYO/s8Lbvc+ufD3Abycq3lG2DvCDGRaZMY=;
        b=S9bZpo8/4/SPIi3qKRNvOoJy3HX9iQcHOKtF4L4ytNpcxsktpds2VIO45Hsum8NwmB
         /A3KeacKfEqldy3DlB0Lsu3pvTthIjZ3FHBqIQTF99Kr6IYlI0yz5vUbktg67E34rMd7
         h/3I1RfYi2e4sL0r3Z1lSfAe4CRjOyGa+Mjp/DAXvkvbNX9t0H7nvVbz5rH0j3qj3uu0
         pLz51a0nZU7d1n6sYZ/Z32DcQT31GwXamCdUDc16+RyRa3R+14+uODg6FvwFJSU+ENTu
         6L3JuFdRb7iowtJsgW1b9NIsz63PaKNvNwfwYA0JmlcFsUOuzhDebOSRzdUJUL2C/qOu
         Vt4g==
X-Gm-Message-State: AHQUAub61cA5uE4rCXqTP2e0aTBBhFcxSvDMSHsKJkF75+M7ZGuBJPtm
        uYk8TXQlRTGrlUlhfwk+EGCDWVKC
X-Google-Smtp-Source: AHgI3IbJowsnCxhdp/A4ZQC+0h7iBz+YKoW9IAq6A2ajufL/wAVk27XCcN4lhcz5+E7xHvKrnlTwvA==
X-Received: by 2002:a50:b8e5:: with SMTP id l92mr8885420ede.294.1549473357963;
        Wed, 06 Feb 2019 09:15:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z40sm6130032edz.86.2019.02.06.09.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:15:57 -0800 (PST)
Date:   Wed, 06 Feb 2019 09:15:57 -0800 (PST)
X-Google-Original-Date: Wed, 06 Feb 2019 17:15:40 GMT
Message-Id: <99d13ef478b7f004a36795cc28bd2e0beadfec58.1549473350.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v6.git.gitgitgadget@gmail.com>
References: <pull.108.v5.git.gitgitgadget@gmail.com>
        <pull.108.v6.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 05/15] trace2:data: add editor/pager child classification
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

Add trace2 process classification for editor and pager
child processes.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 editor.c | 1 +
 pager.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/editor.c b/editor.c
index c985eee1f9..71547674ab 100644
--- a/editor.c
+++ b/editor.c
@@ -78,6 +78,7 @@ static int launch_specified_editor(const char *editor, const char *path,
 		p.argv = args;
 		p.env = env;
 		p.use_shell = 1;
+		p.trace2_child_class = "editor";
 		if (start_command(&p) < 0)
 			return error("unable to start editor '%s'", editor);
 
diff --git a/pager.c b/pager.c
index a768797fcf..4168460ae9 100644
--- a/pager.c
+++ b/pager.c
@@ -100,6 +100,7 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
 	argv_array_push(&pager_process->args, pager);
 	pager_process->use_shell = 1;
 	setup_pager_env(&pager_process->env_array);
+	pager_process->trace2_child_class = "pager";
 }
 
 void setup_pager(void)
-- 
gitgitgadget

