Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C712C1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 21:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfA1Vrs (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 16:47:48 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37947 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfA1Vrr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 16:47:47 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so14335358ede.5
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 13:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m3WRjV0vGcYO/s8Lbvc+ufD3Abycq3lG2DvCDGRaZMY=;
        b=enT+DEwqoUTwut9qyitHDpLM1XU6huVIn07vUqqjvrwc1uyRwI6dyiyxg/E6kZpZGV
         Wfgdq7URfhmGQBRj4D10RsLR/hxcHAeQVKk2vpKTONzGQxrQJKQMN7IqxcPiWSjoJtK6
         co5iVtZojMhYVdIem1YHG8s9+EWw8M23GHxXbPNJS8ZO3UMd1YYxbVlvW4toeZ8IAVbP
         s8K3j+MHwmCELP1BIJB3k5kXyYY5mQldxG4lDf5LL7QOOPGAXVpYwvW/pKd50lVczlNV
         K4TxCUXgXHmVsUYDD8MBh3ETOpsUEvFepYwEaLNy8MlqVW5brzjz7InrWm9a+pYOQRQy
         sIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m3WRjV0vGcYO/s8Lbvc+ufD3Abycq3lG2DvCDGRaZMY=;
        b=PhbcpjhEbEnsbWPRC1cu9Ayz2G3JgBU6vFv7HIP/wPRjRYW8NPoQuKLsyHrqeWDFCi
         6lX0FT9ia3TSlwluULvUVmoZebEsJ98Kq3IEtCYWdTW4jduC6tNW1t++t7HQjawtq0ii
         cCFBM7mQSRzR4jI5ZH42chDQrtUu12FrXoKJkIcA2B8ussnqZHsBYCdg0jqpUmtolf0r
         FTwhle2Zmq6Kke0tPrLAb2iZIZlBurG7SH4BaI8vZomxHDP9ULGApfZYAg5YqASvkcUQ
         ldqrR+SeAQ/Wf9H07q3zRo2yX+WfHWho29MhGg6FFQN1DPiutdPAI4dcJHhYuImuFDkO
         waRA==
X-Gm-Message-State: AJcUukeuy5eOAuj2dkj5vt17O+KchS4Jk1eyQHu4pkY4b3ZqKJRC9PPO
        uait5kKf425z2KbKuat7d7P9VsYC
X-Google-Smtp-Source: ALg8bN672UeEv5NwTbA5RqYDDOYNR1IuJO4Xufr3o/nTwnn79Gd65YrihVcnUKVQ12OYfrchJHxpkw==
X-Received: by 2002:a50:d2d6:: with SMTP id q22mr23520632edg.121.1548712065598;
        Mon, 28 Jan 2019 13:47:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f19-v6sm7663137eje.28.2019.01.28.13.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 13:47:45 -0800 (PST)
Date:   Mon, 28 Jan 2019 13:47:45 -0800 (PST)
X-Google-Original-Date: Mon, 28 Jan 2019 21:47:30 GMT
Message-Id: <6be101d520ac7cc8169e94b9b8f865ec599935b4.1548712060.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v2.git.gitgitgadget@gmail.com>
References: <pull.108.git.gitgitgadget@gmail.com>
        <pull.108.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 05/14] trace2:data: add editor/pager child classification
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

