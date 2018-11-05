Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BF411F453
	for <e@80x24.org>; Mon,  5 Nov 2018 19:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387760AbeKFEmR (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 23:42:17 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44172 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387409AbeKFEmR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 23:42:17 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so9108695lji.11
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 11:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yDVPCNBg8si75m/HCwWEHvx+0vw+vX26vcFCs33Cqzo=;
        b=KUz6zovgFizJ7yPAEJt2HCrP7XF9yUf5SR7gQLGi9QVIdX37qD75Zlr4teKW6lBLGz
         IIGGRLsRw3nMZ63++f0Y59ouG0lDJAcX4S8dZkU9yms4EkGA7+ZoSy7EOqkOFK25UbkK
         efc9uWq2LelL9eajKEJ5AfKfzt3CzSUOAH4GoiVmKqceSkVynbe0fQNdLJR/DZhfAPq1
         Iof0GvVHIDXfHblwiB5EW+hAKG+Yl542838F3WM/fHL857mT9RHWKxHOvyBrh8OZ6ZQC
         Edz2IxuUNTvoHXcAFiLflRUFGdrYSzbHICerGKBy4HwOhqYbHcEpfVo8ejeHRFJaefpz
         hT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yDVPCNBg8si75m/HCwWEHvx+0vw+vX26vcFCs33Cqzo=;
        b=ICj8xrifDyWzavmNv6l2ePiNnvtGv22eMG07NRC2VFKG+zp5OwZdl0H7THA0uPEm9P
         Z5mSctvNndMThxCDYkWvg8TUO4pJAGk5GKbveN9XfWG7sHITvf/tiHgs9r3afZwmMWpO
         FekURAalmAgE9phxeh+P5jGkiiwBj1uB6fJCV0iiM2QQUCzozeAelqjrVahOiqqnYqfI
         hPWzMAKMoFExacUpOtOCRtLCCyPOXimWNTnChk8fajXV2uFRnbIhnEkbyMHMNPoOJ+lN
         XxMxc81JFkScXVzTEtAiHEr97XupePvX4i6zjbm/r1cAaSZ+RN8PUL4AAdyFdZNhJI3T
         zQoQ==
X-Gm-Message-State: AGRZ1gKN0KC1bFsNB8jwUCyi9JwMfu9+taNv2djjJ0RlNozKDeSDfEza
        27FM1qTFW1zuF+VsY9xC9Kk=
X-Google-Smtp-Source: AJdET5eGF4A6wRZAiI7wvgP7NVSqNNvBNbanLomlWVzT7vs08UBOh8++zFiyuQJ7t+5kNiWZmxKzwQ==
X-Received: by 2002:a2e:851a:: with SMTP id j26-v6mr5019716lji.163.1541445666878;
        Mon, 05 Nov 2018 11:21:06 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x5-v6sm3591056lfe.58.2018.11.05.11.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 11:21:06 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 01/16] git.c: mark more strings for translation
Date:   Mon,  5 Nov 2018 20:20:44 +0100
Message-Id: <20181105192059.20303-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181105192059.20303-1-pclouds@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
 <20181105192059.20303-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One string is slightly updated to keep consistency with the rest:
die() should with lowercase.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 git.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/git.c b/git.c
index adac132956..5fd30da093 100644
--- a/git.c
+++ b/git.c
@@ -338,27 +338,27 @@ static int handle_alias(int *argcp, const char ***argv)
 			if (ret >= 0)   /* normal exit */
 				exit(ret);
 
-			die_errno("while expanding alias '%s': '%s'",
-			    alias_command, alias_string + 1);
+			die_errno(_("while expanding alias '%s': '%s'"),
+				  alias_command, alias_string + 1);
 		}
 		count = split_cmdline(alias_string, &new_argv);
 		if (count < 0)
-			die("Bad alias.%s string: %s", alias_command,
+			die(_("bad alias.%s string: %s"), alias_command,
 			    split_cmdline_strerror(count));
 		option_count = handle_options(&new_argv, &count, &envchanged);
 		if (envchanged)
-			die("alias '%s' changes environment variables.\n"
-				 "You can use '!git' in the alias to do this",
-				 alias_command);
+			die(_("alias '%s' changes environment variables.\n"
+			      "You can use '!git' in the alias to do this"),
+			    alias_command);
 		memmove(new_argv - option_count, new_argv,
 				count * sizeof(char *));
 		new_argv -= option_count;
 
 		if (count < 1)
-			die("empty alias for %s", alias_command);
+			die(_("empty alias for %s"), alias_command);
 
 		if (!strcmp(alias_command, new_argv[0]))
-			die("recursive alias: %s", alias_command);
+			die(_("recursive alias: %s"), alias_command);
 
 		trace_argv_printf(new_argv,
 				  "trace: alias expansion: %s =>",
@@ -409,7 +409,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 	if (!help && get_super_prefix()) {
 		if (!(p->option & SUPPORT_SUPER_PREFIX))
-			die("%s doesn't support --super-prefix", p->cmd);
+			die(_("%s doesn't support --super-prefix"), p->cmd);
 	}
 
 	if (!help && p->option & NEED_WORK_TREE)
@@ -433,11 +433,11 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 	/* Check for ENOSPC and EIO errors.. */
 	if (fflush(stdout))
-		die_errno("write failure on standard output");
+		die_errno(_("write failure on standard output"));
 	if (ferror(stdout))
-		die("unknown write failure on standard output");
+		die(_("unknown write failure on standard output"));
 	if (fclose(stdout))
-		die_errno("close failed on standard output");
+		die_errno(_("close failed on standard output"));
 	return 0;
 }
 
@@ -648,7 +648,7 @@ static void execv_dashed_external(const char **argv)
 	int status;
 
 	if (get_super_prefix())
-		die("%s doesn't support --super-prefix", argv[0]);
+		die(_("%s doesn't support --super-prefix"), argv[0]);
 
 	if (use_pager == -1 && !is_builtin(argv[0]))
 		use_pager = check_pager_config(argv[0]);
@@ -760,7 +760,7 @@ int cmd_main(int argc, const char **argv)
 	if (skip_prefix(cmd, "git-", &cmd)) {
 		argv[0] = cmd;
 		handle_builtin(argc, argv);
-		die("cannot handle %s as a builtin", cmd);
+		die(_("cannot handle %s as a builtin"), cmd);
 	}
 
 	/* Look for flags.. */
@@ -773,7 +773,7 @@ int cmd_main(int argc, const char **argv)
 	} else {
 		/* The user didn't specify a command; give them help */
 		commit_pager_choice();
-		printf("usage: %s\n\n", git_usage_string);
+		printf(_("usage: %s\n\n"), git_usage_string);
 		list_common_cmds_help();
 		printf("\n%s\n", _(git_more_info_string));
 		exit(1);
-- 
2.19.1.1005.gac84295441

