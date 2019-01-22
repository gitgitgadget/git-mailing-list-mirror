Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2A4D1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 21:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfAVVWW (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 16:22:22 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:45134 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfAVVWU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 16:22:20 -0500
Received: by mail-ed1-f41.google.com with SMTP id d39so20487136edb.12
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uPrJ5qOuiYsgfwz3PWht0IeUmu6vzl9iKaPfLJVtHt0=;
        b=YGNAVimFybG6L7yd1Kx/aGug2fwKExdZr8dzjvZSFFPvvI1QTcERPuOospp9xxAfER
         Klz2uxJglrAKUe4P5f8AmMoR3w4Fdi7F6KrPhInLEg9UDWQayPK0zrixaZojCBKT5z6g
         AgJb4wKdUkGyiHLUzPIK6eaCYIkTSm2dXjGhkbYMA9iLDeIkM3lQ5r9yQF5QLSdTktWJ
         klxYxhOlTmNEiEvIgOE7yPplmYWVkDKVvNyVR1bq33vhnDUgVAslQ3tOuxacdOQOOk9n
         ijDN4bC0I2vSZLCADu256izp125QO2cc4Siq9VACs+wkkxGLywk8VybBo3T5p2PU4CwI
         LGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uPrJ5qOuiYsgfwz3PWht0IeUmu6vzl9iKaPfLJVtHt0=;
        b=m7XKo8ecqU6e98sUHVw2q+NktAzmtz9ZVzWYiATdLPIxRXDcHX2nb2ldce/akUXqOo
         VTpsj/enJfxwl/3DOaNHjAcLG+VWBhkV8SKZG0rvagl9d5CtqsdZLXPTohzv2jKdGqRr
         62M2G04zwGgM8PxrG14pDMndj8egwNMlJUy7PrgUmiQx36lkAkNwshHAk9xlrLRWFMxC
         nndXVwGgJTF+DDYy/d6LX3oVUGxZ8+6XGjwCoJHsxXMsiACH0+tJMXMBQSIiDBlxVW+o
         kHf4CrvYn6UoAc/QwpgTGl9+gJhkUpg1/66lGS2wyjZYASFWThrjz9FP4dhg2Y7WGlbd
         gvcQ==
X-Gm-Message-State: AJcUukfFaaB5ZpdP7wFG+WfnXng8CHfvPRrA+N0FyKMtZRdHS6l2TGXO
        JavdFMt6YC0Y4hNJWGS+5ZjqIBbt
X-Google-Smtp-Source: ALg8bN7Tc5quP343rcEcTwn1d1Q5n8QntMyBs0JKPuxGEngRTlW8GMslNzTEUCYpLisN3Ju9A/hJjA==
X-Received: by 2002:a17:906:6c97:: with SMTP id s23-v6mr107125ejr.79.1548192138793;
        Tue, 22 Jan 2019 13:22:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6sm11075669ede.53.2019.01.22.13.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 13:22:18 -0800 (PST)
Date:   Tue, 22 Jan 2019 13:22:18 -0800 (PST)
X-Google-Original-Date: Tue, 22 Jan 2019 21:22:04 GMT
Message-Id: <49b6b9bd24e7ee2deaee83868e9d5e8c3d3c8956.1548192131.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.git.gitgitgadget@gmail.com>
References: <pull.108.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 07/14] trace2:data: add trace2 transport child classification
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

