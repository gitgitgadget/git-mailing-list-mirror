Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCD8D1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 20:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbfA3U5T (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 15:57:19 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43057 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387901AbfA3U43 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 15:56:29 -0500
Received: by mail-ed1-f68.google.com with SMTP id f9so769445eds.10
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 12:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lEO2zm4D+RRdgd0jZP3xHjEnfHFoC5J4c6eHcxbWOoE=;
        b=ayGTjVJJ0HsldrA3L0YiaWWB83roCtflTLHYLqzD4yJ1W41oW8xkB7IipNJyN3An84
         uofXqNieEIjjifjR7n1sJV9F1veFnOUgL0zkze+Xns8o1ayjfdIdDs53KVZmXBErg6p6
         MmwhRPq6LN2RhZURjlwOC4hU6ExlQBazWJnV5WbbbRwNmbHbSA55LP5+sQNMKSVil6yT
         nuef2PWdBmfR6Xko0nNIESFwXmz5A+XTQEzYYeTbAsuQzRVfh9YSnZRGeHYw8PLEM5FL
         Bp2orIduBtht8rJdvAJVAi3hOHaH8O/foxShXNoYRWUP9g8EtKCw6ZJOqghkCnrzhmSM
         FF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lEO2zm4D+RRdgd0jZP3xHjEnfHFoC5J4c6eHcxbWOoE=;
        b=BBN/lIT+uDfEWiMnKGZc3skhoAVrW5Y5TZ6qkCsDJz6rxpNsTurhrjsrA+bWhnELiL
         mx/UuO5aT3t+C/rcMNXtSc2rjQV01CCs4FTjwfBSi7ILiWjQikwvUrIUrU13MoC1HgBz
         0ov9JeovrDyWC6RHqqjmdCykjAhEf3Ch1GDZoY0JJRa7j6dNSFS217fJ69OfvTAQsfZO
         QvTgMUUmcHNQwMZ2z+qm9baQfJnSQoxI1uNrPusSB7Udz/PSPF9YaFxAENq7Ahemxiq4
         D07QAFBtzW2x90zp6RpZQPlLslnsihkOh5J/AGlRyLBtF9gjAwBXpdOps6wIjc+hzbJ8
         KYDw==
X-Gm-Message-State: AJcUukea69qrAP0N0Eo+joHz4gTrCOPnJDC4V1I9h4STEGwNPGRjHbmv
        24ojPUwICAGYYqoRbvbBJrPUca7h
X-Google-Smtp-Source: ALg8bN4kpOH2ycak2rciFVDh7AOuPDOhXmi4deFX+GPAbB4Ckc4Hcmo+aBUM0RFirf7S0GkGzMtuuw==
X-Received: by 2002:a17:906:2e59:: with SMTP id r25-v6mr23567887eji.186.1548881787235;
        Wed, 30 Jan 2019 12:56:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18sm473638eja.36.2019.01.30.12.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 12:56:26 -0800 (PST)
Date:   Wed, 30 Jan 2019 12:56:26 -0800 (PST)
X-Google-Original-Date: Wed, 30 Jan 2019 20:56:11 GMT
Message-Id: <f4f0453e6bde289c8d4a696521148d41320bbb8b.1548881779.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v4.git.gitgitgadget@gmail.com>
References: <pull.108.v3.git.gitgitgadget@gmail.com>
        <pull.108.v4.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 06/14] trace2:data: add trace2 sub-process classification
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

