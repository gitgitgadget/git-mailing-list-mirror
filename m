Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F0861F404
	for <e@80x24.org>; Fri, 31 Aug 2018 16:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeHaU6X (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 16:58:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34973 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbeHaU6W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 16:58:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id 7-v6so757065pgf.2
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 09:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b5ocTq6EEV/0sd3iyVx71haHyHOBYQF1UpkWETZaA9I=;
        b=VGG1reFFoAeWGRPX8bUh5pBuP56b63cKoTlA8qeD72vzqLEqgqfHEEdkowzJb24N4/
         1qp8Q9VmqjCxXMmKFvX4tKrZcAo9Zd7kgiyPliOvb6qGLsrvIgv1fdpCH9diUP/N8ErP
         M9MH3FMeHkm6dQDuhrgIVJQAJbJwgkdb5I0yWzBHj8j4NRtyUTfYw87XAOa5swZldjYG
         u37ybiNQFGyivFXoiscRLAEEbsgD1oFNZAhnLZrbh3EMTrT49q1jTSrXMxqTSy1MSrKM
         tDecG3dITRpHq8UUfzICOVE6CmtCA2RN9FETYERO85EADmr76MuebVMu4FfwVSS5/3Uy
         awdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b5ocTq6EEV/0sd3iyVx71haHyHOBYQF1UpkWETZaA9I=;
        b=l3P/NN2YPbWkNL2G6GRbQ5Dkf7IqiurtpM7RLbvyHxWUgU6nB54CLGDb5oYzySyws8
         U628NXjmnBnBQ0CZ099LdNBXjLoLpSmhDipEmO3bH9tenMFTgLxt0dL59W2Eoh3TmBSy
         S3yvF/zDAfd+2jgv5Jjt+JfYycLRwcBFPw7KfdBHcDu5803izDGriCUeYcmulo4r4vUJ
         8MyPqoLVNTAN6obcEKMstrj0H3UV3beEQ4pYBGmTmwGt4evbOeJfJWnxtEItUYYF/hBI
         ZALer5TyMpmSZMZXbm2Bzsy9Rfbuey8AQp3UDKcTMr+kUCBoe0a54iGFKzMc7zIQRTjm
         l36A==
X-Gm-Message-State: APzg51DzgccyE6m0cZeV4QOzmxm/xke3BagXFfmP1t1ygL1xRfic/Mbq
        cMLZCrOma3utmIfMZ8kkJo+vOLlV
X-Google-Smtp-Source: ANB0VdYp8PoX4d4ZTEsSuRyhiPuOWVNjmpGogQg+Jc+ISbnFxSBTEZ4RGF5bSJTXvGswPZtk75Gexg==
X-Received: by 2002:a62:6781:: with SMTP id t1-v6mr16863142pfj.200.1535734200250;
        Fri, 31 Aug 2018 09:50:00 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id d184-v6sm30459665pfg.74.2018.08.31.09.49.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 09:49:59 -0700 (PDT)
Date:   Fri, 31 Aug 2018 09:49:59 -0700 (PDT)
X-Google-Original-Date: Fri, 31 Aug 2018 16:49:47 GMT
Message-Id: <3ee8dcc8d356bfe18292dede717be509ca406b3d.1535734192.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.29.git.gitgitgadget@gmail.com>
References: <pull.29.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/8] trace2: demonstrate trace2 child process classification
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

Classify editory, pager, and sub-process child processes.
The former two can be used to identify interactive commands,
for example.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 editor.c      | 1 +
 pager.c       | 1 +
 sub-process.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/editor.c b/editor.c
index 9a9b4e12d1..29707de198 100644
--- a/editor.c
+++ b/editor.c
@@ -66,6 +66,7 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
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

