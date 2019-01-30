Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDCB31F453
	for <e@80x24.org>; Wed, 30 Jan 2019 19:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733022AbfA3Tvc (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 14:51:32 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46824 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732941AbfA3TvN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 14:51:13 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so593244edt.13
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 11:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wWxV4nv1i3Sj+TzKdE/M42eHEQ+Scronuo/HjRFyFKo=;
        b=NMM8Rzo57orTuFEu+/ZGJrlOra02EwDulqLk1scx3uwXaESKbt/10hJ6BqTq/qkCbH
         lVlUs4afTauiyRfifmIyb3Yc5tKNtIII2/XDp+U+PbjwaryjWNyRuwgW4T/tON2IsGP+
         WjrPZTU8tpk3lPsNLFm4JnZFtEQUF+uGyZdLO27D2wRimTjKpqZrl4lB7cnepNBVzGcG
         0jSA/4R/sTjSFFLV+C3qHtDYc3v/HuSiiVa9+7OSy6N/d+7DwuSrmUaF1yc8KbzUgS8Z
         Uawx63NQeXmh8OPEucCNsccNz7Wi7+UrHekqi4rz5XVD0YuTByb1nIHmeNwB7TKYYhwg
         yuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wWxV4nv1i3Sj+TzKdE/M42eHEQ+Scronuo/HjRFyFKo=;
        b=hNTzhGEUl6k61s/tdRS16HzCbEQbSgEczUZviYnLX0tkkDZ4YG9BKbbBrssOTOO5/T
         QxzYzq9FjLOaTkZXSAqDv1JBo+8r8wD1ZLUU0gp897bejX1y6Tn8IZzCW7rKyQ0xl7FQ
         pG69OIFo2Phqw6OcPBbtf5igmsbUs80o9h0PKc3PfGd02IqRALKGaOzHVL6tOq01bChH
         a1dj5RK7m3ezA36ukan2Z1PlOMwxX4JLyy5eVN22DV5qWPneYmYSw7E+tp2P8mSZfuIS
         MLuxEinZrbqWfODmLAPW7c4bnMrVNPqJF/8Don7ItT+nUt6Gmh6K8tiApi2fwVN2AMZu
         r/cg==
X-Gm-Message-State: AJcUukcZpfCnXJtGJeCtfwmSqFxLEVhSK2+zeOR6b2BZy1qgvWFtcEJf
        CoZQ2U7UuLLlixPfAxPu6HeOhAwn
X-Google-Smtp-Source: ALg8bN7l/nYSTjIZe20ZuPEeKWdwVxb/cx5b+kKoZD2vZsiNMnxUEySK1jcWHQeFWNgjQbbxxWV6bA==
X-Received: by 2002:a17:906:4d1a:: with SMTP id r26mr28074942eju.32.1548877871132;
        Wed, 30 Jan 2019 11:51:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e35sm733557eda.13.2019.01.30.11.51.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 11:51:10 -0800 (PST)
Date:   Wed, 30 Jan 2019 11:51:10 -0800 (PST)
X-Google-Original-Date: Wed, 30 Jan 2019 19:50:56 GMT
Message-Id: <b7e6644f4bc365e3bca02294c87a88c99d18f371.1548877863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v3.git.gitgitgadget@gmail.com>
References: <pull.108.v2.git.gitgitgadget@gmail.com>
        <pull.108.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 07/14] trace2:data: add trace2 transport child
 classification
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

Add trace2 child classification for transport processes.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 connect.c          | 3 +++
 transport-helper.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/connect.c b/connect.c
index 24281b6082..3c6f829a05 100644
--- a/connect.c
+++ b/connect.c
@@ -1251,6 +1251,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		conn = NULL;
 	} else if (protocol == PROTO_GIT) {
 		conn = git_connect_git(fd, hostandport, path, prog, version, flags);
+		conn->trace2_child_class = "transport/git";
 	} else {
 		struct strbuf cmd = STRBUF_INIT;
 		const char *const *var;
@@ -1293,9 +1294,11 @@ struct child_process *git_connect(int fd[2], const char *url,
 				strbuf_release(&cmd);
 				return NULL;
 			}
+			conn->trace2_child_class = "transport/ssh";
 			fill_ssh_args(conn, ssh_host, port, version, flags);
 		} else {
 			transport_check_allowed("file");
+			conn->trace2_child_class = "transport/file";
 			if (version > 0) {
 				argv_array_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
 						 version);
diff --git a/transport-helper.c b/transport-helper.c
index 6cf3bb324e..a01cc0093f 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -127,6 +127,8 @@ static struct child_process *get_helper(struct transport *transport)
 		argv_array_pushf(&helper->env_array, "%s=%s",
 				 GIT_DIR_ENVIRONMENT, get_git_dir());
 
+	helper->trace2_child_class = helper->args.argv[0]; /* "remote-<name>" */
+
 	code = start_command(helper);
 	if (code < 0 && errno == ENOENT)
 		die(_("unable to find remote helper for '%s'"), data->name);
-- 
gitgitgadget

