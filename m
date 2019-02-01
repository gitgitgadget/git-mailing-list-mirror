Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7AFC1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 17:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbfBAR7F (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 12:59:05 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:43325 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731489AbfBAR7F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 12:59:05 -0500
Received: by mail-ed1-f47.google.com with SMTP id f9so6115300eds.10
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 09:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m3WRjV0vGcYO/s8Lbvc+ufD3Abycq3lG2DvCDGRaZMY=;
        b=bF9rAnpxLbKSa2HCzedH0aV1PtCKpyP2DVGfVLzs7nGw/BwZQTZMnDhUhXipGII+74
         58cDLQJEg2ftzobSZZh8+XX9R1otIH4UR5aRCbcH6hWOTDCw6Fs7KQFLu5t6HFh4Xn2/
         IreXfbhXlmElbgULiTCY9KFSg+QJLONG6RpYD2wocPIoVk6UJWIlDkiio0CIRweTAo7P
         wQ/Y+WfquYtniRXWag8fDTZJQVVazfOWMOoEUIHkLojxHleJyNsM2iECQtPJODsPFzsQ
         6gKNlCD4eudcaJ8OUMg/M1Yb/MMtY2GOsPiPZBqLKGRXw80FRtxbJdarujYm6cx5OyMd
         SQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m3WRjV0vGcYO/s8Lbvc+ufD3Abycq3lG2DvCDGRaZMY=;
        b=N4d3F5Hh5SR3+hWmAeOfjShj7xKezu5CYu+i0hLNaNFNNeFX6dfCljZjvujj6VEQHV
         bhazEsgnhXzfEZIe4AP58mUtYoL8eUrjEWnxsujSeC5iOPlaOhaLKXSc3c6iPJbTGCf0
         gVnc/VbPK8Uq8cub1WicPQuTeOUTAfDV9OrAfmOjU6yVPTkCCDF39ZR5TmhTcwykpneY
         cmz6eOB81jnYlexYWlS5lON5ocdHKngO5Ah++NjhzKfs0rnVKCUwQ0CQAamSJ/wPCLRt
         Fa3BpMr76MYnIO3gkpnFTYXWmZekR3RLshgP56svFbZHuuyTKhl90E5/YM4S0vN/XHBB
         4xFw==
X-Gm-Message-State: AJcUukcugceyQ03Kqc1ED9eCDUa/DqyLW4JYu79/cKIqsVRL66e0SxnU
        0Ue+th13LJ0z8PYdVVl2eS7bRCqk
X-Google-Smtp-Source: ALg8bN7dE9zhiLwIEk40mGxHr8ZXsPvlPx30yec7DrR/2WSnr2tXXd5ACAcf34aZ+Pj0AxzD9NEO8g==
X-Received: by 2002:a17:906:33db:: with SMTP id w27mr31828505eja.108.1549043943306;
        Fri, 01 Feb 2019 09:59:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6sm2235011ede.53.2019.02.01.09.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 09:59:02 -0800 (PST)
Date:   Fri, 01 Feb 2019 09:59:02 -0800 (PST)
X-Google-Original-Date: Fri, 01 Feb 2019 17:58:46 GMT
Message-Id: <30bcea9435558edae4836a24cb2bf5f30a579321.1549043936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v5.git.gitgitgadget@gmail.com>
References: <pull.108.v4.git.gitgitgadget@gmail.com>
        <pull.108.v5.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 05/15] trace2:data: add editor/pager child classification
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

