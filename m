Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C214020248
	for <e@80x24.org>; Fri, 22 Feb 2019 22:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfBVWZH (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 17:25:07 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35391 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfBVWZG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 17:25:06 -0500
Received: by mail-ed1-f67.google.com with SMTP id g19so3116794edp.2
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 14:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m3WRjV0vGcYO/s8Lbvc+ufD3Abycq3lG2DvCDGRaZMY=;
        b=iHmkIfHuyY9PyWahDGWMhoFoxGtult4yI674JTxwa/LHzmkQFXITci7BXPO0xoU7f7
         slYMCzy+gIuwk5YcC57jGWRiiLLiQKQwWbK4ryxMnIh8AkVreibgbZSzZjEbkEznHZhm
         b4RAEi+8SiDnDcIOe3PQR22Z/SLoy7n1DV/7Mh30FPkBcOpAAXVXx2azHyhhGeH18gKN
         PyjLm6dZ+mMmED71noNYS7Nkrmo3LHtBJJQmC+MffrhtEIjteTyngqchQ6KqFGMMtArX
         kca13KCUj0IXr83gqvs8VzZOuWfP8fvBB4D4iZPPtfqMXW1gHPV3Di5M3t+w/U7FRcdW
         tVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m3WRjV0vGcYO/s8Lbvc+ufD3Abycq3lG2DvCDGRaZMY=;
        b=oXDW1Q/tRo9DobZopSuKIlRkp/Zm4M7pOF03fBu9W9NUWaRHVkJwmPB5/TpJ8DeBP5
         B8tzwyVu+6K1kc+RNyryX2OFO61VsaQSSvAy9hyxS2CbqMNGf/yEskdVLxA1OzBoEAc4
         XvUfXj1TSk8/IHMB3QujN1v+UhcbWUCLaVpyTSNF+HQf3YllnBscu/jAeVVGmS/ADGPs
         P7GeFDEXGZ3fNVJkgBYLKTmBL95uHNHo9L0JxlwUKTMjrW9stegfaZUjxjGxxpjNqCZ3
         Y9WeJdfTn5gkalmLsoLPAEUH2KX6qNwbIrbBWLwuPLrkLdrKUM1X1l8XiQ9YON0TpNUE
         YVlw==
X-Gm-Message-State: AHQUAub01gEylauNsZ7j8954N6JXDfSPh7B3RbRBueQcqjpLz29elQke
        ijtHKCARDvzOFf4ddlcFH+n/vZ01
X-Google-Smtp-Source: AHgI3IYI4lKTU6zsPVJFb9Ig4XY/gWCpSbF8M5eb8tps8TGp3c1Drxoi2YGwIT+5LEPLRYZtmHoT3w==
X-Received: by 2002:a50:be44:: with SMTP id b4mr4993036edi.41.1550874304779;
        Fri, 22 Feb 2019 14:25:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z9sm381561ejg.36.2019.02.22.14.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:25:04 -0800 (PST)
Date:   Fri, 22 Feb 2019 14:25:04 -0800 (PST)
X-Google-Original-Date: Fri, 22 Feb 2019 22:24:48 GMT
Message-Id: <18ff59d6fec8caeb0844fe8c3130daa6f60fed4e.1550874298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v7.git.gitgitgadget@gmail.com>
References: <pull.108.v6.git.gitgitgadget@gmail.com>
        <pull.108.v7.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v7 05/15] trace2:data: add editor/pager child classification
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

