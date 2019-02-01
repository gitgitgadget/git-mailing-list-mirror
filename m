Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEC731F453
	for <e@80x24.org>; Fri,  1 Feb 2019 17:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbfBAR70 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 12:59:26 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40125 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731506AbfBAR7H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 12:59:07 -0500
Received: by mail-ed1-f66.google.com with SMTP id g22so6142719edr.7
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 09:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wWxV4nv1i3Sj+TzKdE/M42eHEQ+Scronuo/HjRFyFKo=;
        b=EEwxQRrLob2ks/K4jQAgeYjnmGXTb4LCZLHnfzLU1MjyHs35owjFNgyxXssh/UqOmW
         cWdDNV292QVIuQFiWswoJvAfEuLHdURMAG1GlaaVnyrnHRC1xzkMHUXVwmwP+nkRLlWK
         GEEb36gW7KD91JkW02s7o02nWbrhEjK55S2RmmNe3qcVVnxLa+JNTQuQgJMc8vmD63A0
         vJ4a9opYwl7jPuWALCg7eAKQ0ROqAe9eJ8zx0MiOrddl7wXZLWkQo6XWrwkuJB6WGRU7
         RN6gBg86e6wHdWAbUSzjKDce6taJ+a3f9w0q1YXPaPcCHR/dU9eXrKACJwTLmkBxEcWB
         1i/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wWxV4nv1i3Sj+TzKdE/M42eHEQ+Scronuo/HjRFyFKo=;
        b=qj1rjLmbZDGXGIsJq6WgOx8hwFV2LkV9bqcscFC/j08+7y/dEYlOeg8y+UW0gnTRKx
         nVkW6QxdKbh9wB3JrtVLJ/RUeDnl4K43GUZ1P9+RtwPXLVh0BiDy+35GNtT6/d10ekHj
         CMr9o4puf0CT0g7ee565GaEIWpiZz4GvozxbJXLyrlN3DvR7O4b/idibPZcuwV0+Gb7E
         wW6Tv+qjUQ0N4DXxwoaSzYmiWrbYAS8G+kV7IZgOdakoh3MsW632oVxNWMAQFmgJuRzZ
         NWCZH7Okt8qM/7Yaenp8eJ8wCN3Bd+71iLNhjQr8NSyaQ9nLGX2vRZ+OX9bp8INaf/Mg
         kR1A==
X-Gm-Message-State: AHQUAuayHz+fnzxrZhpHcghb3CmoEW9z36CM4Q6qm5jC3S3ZG4icPJID
        oiOl4ZZnmtNNpgxsmkl4/gnbg/LS
X-Google-Smtp-Source: AHgI3IbJbV6fC/6q8J7HVKrBAQw8AZCK9qXWFOdKA+vBmWqmqIMx5nD2KUpaJDIU1gtR9gUZwG66xw==
X-Received: by 2002:a50:9063:: with SMTP id z32mr760724edz.133.1549043945035;
        Fri, 01 Feb 2019 09:59:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b46sm2191339edc.57.2019.02.01.09.59.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 09:59:04 -0800 (PST)
Date:   Fri, 01 Feb 2019 09:59:04 -0800 (PST)
X-Google-Original-Date: Fri, 01 Feb 2019 17:58:48 GMT
Message-Id: <3cd525b80edcba78b097b805ce2937e6e54cbdec.1549043936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v5.git.gitgitgadget@gmail.com>
References: <pull.108.v4.git.gitgitgadget@gmail.com>
        <pull.108.v5.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 07/15] trace2:data: add trace2 transport child
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

