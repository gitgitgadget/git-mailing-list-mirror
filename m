Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EACF1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 21:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfA1Vru (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 16:47:50 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37874 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfA1Vrt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 16:47:49 -0500
Received: by mail-ed1-f68.google.com with SMTP id h15so14345478edb.4
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 13:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uPrJ5qOuiYsgfwz3PWht0IeUmu6vzl9iKaPfLJVtHt0=;
        b=Bt0hb3IUE63dW5s+VQvQ78GGM8XqLRB2GQBjN7PY/FapTZGNEBQuKOq0EeZTDKVvSv
         a7104d/mEuh5nxCrohvBJWQWU2LyKJRz6oBcPc6guoqovEuHu4iek1sonqaH0DLTvzIj
         pncn+smZr44Ds1PlNc0G9+QVrzojvXGkfxhwYiRmK9hReZH6aa+GfVIi0Sl0aqlrcDAN
         rd2s5fCS6WLq/J/45v1txcHemQzRIm9Sk6Sta/IvkxWlBgNzvYn6gGCpfKnkvLlqGuhR
         w2y4dwfl+UpLe2TRhRpAZ3jB4mjKtzGbUr4MrnHcLyizEl2vvyLeGsg3J0gDXkZ8j55L
         p+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uPrJ5qOuiYsgfwz3PWht0IeUmu6vzl9iKaPfLJVtHt0=;
        b=qqClHF/4tM1eYzLxt5OvYTr5eZTZ3JRmcgei6TyAjfK4nj2zJkm8VfmG8Ps0VqAjW/
         Yj5zreaoJ6YcbJQWt6FL1CQ3TA868yMMWy0Qs2RIgLWp7uJQkRkXDFr0c35QW+aIn3jr
         aHP2IDmf8u0Csdat6fU/evMYkU/Em83S5dgxp6OIEsIvj8biJidMHSmjmnreETQDmEOH
         geJ5eA9dB1dbqdsg/kC6pWJbGWgarAxYZAJV2CBVL29PFJKcmHeHlCR254QEQsw7m97B
         vKWQVf7kqamt+YNIERwxNGWz6T9OX0BynHNyC1wx4Bgvq9CU0pAo+Xg27i51eVcBqTSt
         2sdw==
X-Gm-Message-State: AJcUukdwPIe1LP1KBOe+bYsb+MFST+VZUvlPnveYc2HHSUbR6faaP0jk
        pBLVQ+bwQVY1atvabvFSnDfgOcep
X-Google-Smtp-Source: ALg8bN7ImwXdQXSeR78lElwNnRLW8o9MTZqkrI1bWuuBNb4SR1vtdUzppqduKBdtQesQTSA4IVfKuQ==
X-Received: by 2002:a50:fc07:: with SMTP id i7mr23142365edr.153.1548712067343;
        Mon, 28 Jan 2019 13:47:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w10sm14067420eda.77.2019.01.28.13.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 13:47:46 -0800 (PST)
Date:   Mon, 28 Jan 2019 13:47:46 -0800 (PST)
X-Google-Original-Date: Mon, 28 Jan 2019 21:47:32 GMT
Message-Id: <68192b8dfb42c6991fb5133e4ae6442411fbd71b.1548712060.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v2.git.gitgitgadget@gmail.com>
References: <pull.108.git.gitgitgadget@gmail.com>
        <pull.108.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 07/14] trace2:data: add trace2 transport child
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
index bf225c698f..1eb656b687 100644
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

