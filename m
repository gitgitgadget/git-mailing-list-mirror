Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 382DA1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 16:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfH0Q4i (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 12:56:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52513 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbfH0Q4i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 12:56:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id o4so3854912wmh.2
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CDnW+/zm/e6yALhpey+0VhsELh8dHaGTbGQnK0JbMt4=;
        b=BhSNJPwBBVNi3uIs+wElPYnhW8jm/csHGmo5V4eDCjCYZf8ORTUaRI64prn1KQAojd
         c7n+e/qwobDQjFn3qGLPOReyCKPeTkXF8atX0c+A4Vs2qJXAuanwQYBsxzU13pRl3eRW
         uI2cYPOWWwIhFjZUtD2zz/u4f9tbws6Bby4Dp/5CBp7XrX0PuZeYM2ArWXCIXUva6hHj
         y9fo0FRN/G7dNqtElQlzs6C1wXpJO+Ur9ooWFMDTyx1jFhpcWJu7eZIDQaMLothzAJrN
         Jp3Y+I2bwY5Jy5qAZodncT+no+i53iF9PzfQG/S7vnop3rmdq6d8mZzOZaHh4iRsAF1d
         ewdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CDnW+/zm/e6yALhpey+0VhsELh8dHaGTbGQnK0JbMt4=;
        b=WPtkUgkfxdCGk/PnnzjNT9pokMaJzM5ay6nriLMX0VdWMioFaqUNoH9HVRZfLRlFsa
         4ul71udMV4MvQ4kju9dRkSCnLeu1G3x+SIUjj1nBUjEPwOoR3VcMEmyyi0tG3Ha3PeyK
         w5sGNOTKgxnRWZuqEwvOVPSi+0WJHVeZAy49Xyj4gao0KOH5ER9iGrnVPGWfd/p18Dtx
         Y5BEh92B7vNNG168SELGPs1YJLpzjLVOJ2s2eXsnqT/sQhYqkR8tSwtCC1SshYAO/+PB
         Hb0zaTRkgbx2dAkKJm+IvjgEtKDaQdepAYMVXtP3XdhABLY5nOwBTx27tu+2uTOz55lJ
         Gm3A==
X-Gm-Message-State: APjAAAWAT6M5srheXsgBTkTz6MOOny5cy9QBDxf7k/X7jaAsNUcYH5uA
        B/Zb0FgqSM5et9VkWqqY1jsG9Rb3
X-Google-Smtp-Source: APXvYqyOczusjbE7sc25VLtFFOKVCfKNksKOBrTuZFtI1fv/ZpNUhigQqhfhMG6MWv8dNobW3XTGNA==
X-Received: by 2002:a7b:cd06:: with SMTP id f6mr30768990wmj.66.1566924995614;
        Tue, 27 Aug 2019 09:56:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t198sm5293048wmt.39.2019.08.27.09.56.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 09:56:34 -0700 (PDT)
Date:   Tue, 27 Aug 2019 09:56:34 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Aug 2019 16:56:31 GMT
Message-Id: <80496fdcfc42cd7ea883ea1a7200ab3611cbbca5.1566924992.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.323.git.gitgitgadget@gmail.com>
References: <pull.323.git.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] commit-graph: emit trace2 cmd_mode for each sub-command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

Emit trace2_cmd_mode() messages for each commit-graph
sub-command.

The commit graph commands were in flux when trace2 was
making it's way to git. Now that we have enough sub-commands
in commit-graph, we can label the various modes within them.
Distinguishing between read, write and verify is a great
start.

Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 builtin/commit-graph.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 57863619b7..ef68b26744 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -58,6 +58,8 @@ static int graph_verify(int argc, const char **argv)
 		OPT_END(),
 	};
 
+	trace2_cmd_mode("verify");
+
 	argc = parse_options(argc, argv, NULL,
 			     builtin_commit_graph_verify_options,
 			     builtin_commit_graph_verify_usage, 0);
@@ -102,6 +104,8 @@ static int graph_read(int argc, const char **argv)
 		OPT_END(),
 	};
 
+	trace2_cmd_mode("read");
+
 	argc = parse_options(argc, argv, NULL,
 			     builtin_commit_graph_read_options,
 			     builtin_commit_graph_read_usage, 0);
@@ -183,6 +187,8 @@ static int graph_write(int argc, const char **argv)
 	split_opts.max_commits = 0;
 	split_opts.expire_time = 0;
 
+	trace2_cmd_mode("write");
+
 	argc = parse_options(argc, argv, NULL,
 			     builtin_commit_graph_write_options,
 			     builtin_commit_graph_write_usage, 0);
-- 
gitgitgadget
