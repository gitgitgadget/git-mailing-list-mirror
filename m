Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB24220248
	for <e@80x24.org>; Fri, 22 Feb 2019 22:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfBVWZJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 17:25:09 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36971 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfBVWZI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 17:25:08 -0500
Received: by mail-ed1-f65.google.com with SMTP id m12so3105146edv.4
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 14:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wWxV4nv1i3Sj+TzKdE/M42eHEQ+Scronuo/HjRFyFKo=;
        b=kfwONS6fyeQTwb+Qdl+JJet1rZiH6wwcvAy5QGtXLyuIphaML+knMXx3GAdDP9VbyI
         yUyeFeaw6IP6B/0Q2mBhK5x+nCkAkTHW1YwbpDQppLD6PvwACh2o+5Mdpg3Fh+Sup4gF
         mpHC3+AQ3KvL7VHVY+8f4ivVOA4TidTBkO9XmefjmiXCft9fnJtLQ0z7Kds04cPmGrlV
         poOsEitVeyYENLjUNkk8vwwprljhlEXsNJaT+XP3rw8X+hlt9LxYbKwZY97Cws5V4gxO
         jWV2tgU8v9N41TWlfYxqeqNpNTQr7I5BuDOuvRl+0NlJIK/V+GrAA4mHSBmf+9BTLnIg
         Esdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wWxV4nv1i3Sj+TzKdE/M42eHEQ+Scronuo/HjRFyFKo=;
        b=OeC8Ab4j7IT/Ih4ShtQdS8DSgKQcabzWUFq9OLHj9XqzUVirXrhZIncs+nOdDJkJ/Q
         jdk6eJgghlW2EQ1O7aHVj6FMtfwTWL0lFGVDyoFhqsJJd8yR79d9lOoqYu9PQsaZuZYy
         lWWhvVsTLcGqIE/0B7SK8Ya0//3rfyUqk78JIsof6u8Ty1af/BIicLBmI7GhLXHdkey8
         x1lcdLdcl4PbibZYGgS/5IdH37QLCQXMXZaiFwbo7pTaOwWadsC2hZdasq6OlQRU8aXk
         5HMJO6W+1fPvggHr4YBfegzDPrUnfaFe0kv5Sigf/OzX11zzMYM3fG34fscmZ6qJTUcZ
         TNVw==
X-Gm-Message-State: AHQUAuZffxF0fDRbjOnmKsmv3Z6A1v70+M1Nabd7FZG0S0ba3phon0K4
        QQJXanpd/zIOHnrQ5l3IsvUOn5ck
X-Google-Smtp-Source: AHgI3IZoF5Mi6q07S4CCjUPmgOJxNzxUzSDrWyJDAZevA/m1qPOhQona5TKApQkbtremwWRJhZBRiw==
X-Received: by 2002:a05:6402:1495:: with SMTP id e21mr4902271edv.52.1550874306224;
        Fri, 22 Feb 2019 14:25:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z18sm471848ejp.44.2019.02.22.14.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:25:05 -0800 (PST)
Date:   Fri, 22 Feb 2019 14:25:05 -0800 (PST)
X-Google-Original-Date: Fri, 22 Feb 2019 22:24:50 GMT
Message-Id: <485a4f2a68538aa3fd75ff113585ff543e49b31a.1550874298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v7.git.gitgitgadget@gmail.com>
References: <pull.108.v6.git.gitgitgadget@gmail.com>
        <pull.108.v7.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v7 07/15] trace2:data: add trace2 transport child
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

