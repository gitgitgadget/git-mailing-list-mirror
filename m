Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 641541F454
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbeJ0PEm (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34737 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbeJ0PEl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id g8-v6so215371ljk.1
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9uMJPwbGQMEvV7/Ij4zv9PMSOu66O0uo4gl7+Wsik6E=;
        b=ZvQhKiTnhGVO/l58w1jOKbzQdm2WKrhkPnHqcy62RmVkQ+7E/34YDpojaKM1esn+vU
         gAU8q0jWU7l8yLnNZTBDR0mK9Ml9d992TyEtBbpbjW8hw8z7RrE3PreHb5EZDQdWm3T7
         h1kZFYZesWqIQ72gaUVtcgby2UiKCPfWs3Ymh4Y3LQtEsNByvw82/u/KpQu7/YjAZCJN
         Usm6oSFXYHj2EErZVrBIkD5xCLbxiMueICw/NnZQEMh4i5u656N9R0bWcGLNbJh/UD+C
         gUzSU1k1ElAJ+t/QrxC2d2+3Vs3+Fqo6KN40KL5vbf3GujdKb2O93P44MSJjFae5MF86
         nZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9uMJPwbGQMEvV7/Ij4zv9PMSOu66O0uo4gl7+Wsik6E=;
        b=DjARjCtnim3LLf2zhB8zJebG31bN3l3/klqbFlfJRGbrC8DNjI3rWPRN/2WYSYNT6q
         +EUMpIutUMMI165+PTGMcFhz3QylGXf/yZrPCT3uqjt9fp5yoK3b3UHz8lv1c7HqxpkA
         Fb7OAwe1xlX/A15YZt541VFfTGPYvylsUo1dPcw0vBNGgXQa8+TYP/Oqc0xpvJzqEDmk
         oxyFqoWnU84lqwmgHjb4iPzxqjSfu0EtFJuuo4vO+Db0zjef2XhCKhs3cLzONpwTRDie
         3d8wTP67XkmF97m+XFr9Amkpk0mDOyhDH9wwJeo8ez6tUMcqEPduCUq5VJYVbvF3P64h
         G5AA==
X-Gm-Message-State: AGRZ1gInyMcHAA9Qc5JlDQQ87Qsj72tvY8AZkhLv730sDZlDssVBI7Ei
        lkFsYqb0NRVYcfZIHUdoguRB4MgC
X-Google-Smtp-Source: AJdET5fWZLmb8GQ04YbQEikzdNjBN1A1+7PJcDbVMI9KN536xOEWQRnujO7iW/xPvY/FdsW746ItFQ==
X-Received: by 2002:a2e:7217:: with SMTP id n23-v6mr3624223ljc.71.1540621485624;
        Fri, 26 Oct 2018 23:24:45 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 42/78] config.txt: move log.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:15 +0200
Message-Id: <20181027062351.30446-43-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt     | 44 +-----------------------------------
 Documentation/config/log.txt | 43 +++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/config/log.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 763bb291e5..cce89ea50c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -363,49 +363,7 @@ include::config/instaweb.txt[]
 
 include::config/interactive.txt[]
 
-log.abbrevCommit::
-	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
-	linkgit:git-whatchanged[1] assume `--abbrev-commit`. You may
-	override this option with `--no-abbrev-commit`.
-
-log.date::
-	Set the default date-time mode for the 'log' command.
-	Setting a value for log.date is similar to using 'git log''s
-	`--date` option.  See linkgit:git-log[1] for details.
-
-log.decorate::
-	Print out the ref names of any commits that are shown by the log
-	command. If 'short' is specified, the ref name prefixes 'refs/heads/',
-	'refs/tags/' and 'refs/remotes/' will not be printed. If 'full' is
-	specified, the full ref name (including prefix) will be printed.
-	If 'auto' is specified, then if the output is going to a terminal,
-	the ref names are shown as if 'short' were given, otherwise no ref
-	names are shown. This is the same as the `--decorate` option
-	of the `git log`.
-
-log.follow::
-	If `true`, `git log` will act as if the `--follow` option was used when
-	a single <path> is given.  This has the same limitations as `--follow`,
-	i.e. it cannot be used to follow multiple files and does not work well
-	on non-linear history.
-
-log.graphColors::
-	A list of colors, separated by commas, that can be used to draw
-	history lines in `git log --graph`.
-
-log.showRoot::
-	If true, the initial commit will be shown as a big creation event.
-	This is equivalent to a diff against an empty tree.
-	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
-	normally hide the root commit will now show it. True by default.
-
-log.showSignature::
-	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
-	linkgit:git-whatchanged[1] assume `--show-signature`.
-
-log.mailmap::
-	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
-	linkgit:git-whatchanged[1] assume `--use-mailmap`.
+include::config/log.txt[]
 
 mailinfo.scissors::
 	If true, makes linkgit:git-mailinfo[1] (and therefore
diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
new file mode 100644
index 0000000000..78d9e4453a
--- /dev/null
+++ b/Documentation/config/log.txt
@@ -0,0 +1,43 @@
+log.abbrevCommit::
+	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
+	linkgit:git-whatchanged[1] assume `--abbrev-commit`. You may
+	override this option with `--no-abbrev-commit`.
+
+log.date::
+	Set the default date-time mode for the 'log' command.
+	Setting a value for log.date is similar to using 'git log''s
+	`--date` option.  See linkgit:git-log[1] for details.
+
+log.decorate::
+	Print out the ref names of any commits that are shown by the log
+	command. If 'short' is specified, the ref name prefixes 'refs/heads/',
+	'refs/tags/' and 'refs/remotes/' will not be printed. If 'full' is
+	specified, the full ref name (including prefix) will be printed.
+	If 'auto' is specified, then if the output is going to a terminal,
+	the ref names are shown as if 'short' were given, otherwise no ref
+	names are shown. This is the same as the `--decorate` option
+	of the `git log`.
+
+log.follow::
+	If `true`, `git log` will act as if the `--follow` option was used when
+	a single <path> is given.  This has the same limitations as `--follow`,
+	i.e. it cannot be used to follow multiple files and does not work well
+	on non-linear history.
+
+log.graphColors::
+	A list of colors, separated by commas, that can be used to draw
+	history lines in `git log --graph`.
+
+log.showRoot::
+	If true, the initial commit will be shown as a big creation event.
+	This is equivalent to a diff against an empty tree.
+	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
+	normally hide the root commit will now show it. True by default.
+
+log.showSignature::
+	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
+	linkgit:git-whatchanged[1] assume `--show-signature`.
+
+log.mailmap::
+	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
+	linkgit:git-whatchanged[1] assume `--use-mailmap`.
-- 
2.19.1.647.g708186aaf9

