Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8328C1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 18:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeJaDer (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 23:34:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39005 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbeJaDer (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 23:34:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id c25-v6so6287983pfe.6
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 11:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=54Dapt86JCXujLphP/Ru7u119YJCTK1QsvRp3uYzSfQ=;
        b=B4Yd3b1io5yiexag11wwqi36/VoOslK2KMQx40FN8DcTf8AGTPr1sG1ptczzdLeB17
         ECfq9C+iRXme4QSqaAqIRjfrR93Pg4F21T6oLB+iJ7DcMRmXIscxfm4L7flXeg6pMgB5
         16ZSv+P84QH/9TuDzA4BE5SxyP3beLOyGywZJb9hbmg00AKcxa3l2k4hz6DPikF6lChv
         QqfN1IYflBfKzRcX4/Mfs2+3Kpppv5j1IQlG4tnpfKzyZnB+7TBvN0oy25NBYCHWYFyj
         NUt0FyCL1mMwIQMiNluGLZMSuF8/ixVRj8bApTNHp+11l+C2Ym9eD2u/L00f7RCm2xc4
         v36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=54Dapt86JCXujLphP/Ru7u119YJCTK1QsvRp3uYzSfQ=;
        b=hlx2bKCQ8hyGArCVcCR+DTWDAUL33c5NeO2HHmaboHEEQEb2yjPLMOxTf8KLv8oVFd
         d/8xET4TxNReOtrrhDjgIWmWxJBqPET4tMOKP6cGOSceUgBmHi4KnrEN/lZG77H5ojys
         VPZumArdrzrMBl3wxswFw2bGZR19AN0hqjwMSB5UoUCwTnkOyaliBWMKRzMksrTzFG8O
         kCWwToEH45B+h/g3bqIh6/Ff0GN5+2HdLtAm/oV3Dp+py4jtRMl85Imor7zEdGVqAZ1D
         dhsIXKbC9SOAQK1bqSc+GLLpQLz/J4rED3VwrqV1eFGn5aSYYpJ7UX36/bF62Vp/0H+o
         RZEw==
X-Gm-Message-State: AGRZ1gIslv81LFKo1Kz1RXHTpkrleRv5FhwgRqs2nePahYW89HPi/Tb9
        Fr3ebS0v6lhyvbmSBvaMPMC3cyZi
X-Google-Smtp-Source: AJdET5cjd2UzsiXhcSbBAptu4K7FjVtUc3S+HnGSqRGCZr0+8ZKJSwENgWF83foQ7PF16CZ+/czU1Q==
X-Received: by 2002:a62:642:: with SMTP id 63-v6mr4079540pfg.190.1540924808506;
        Tue, 30 Oct 2018 11:40:08 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id v8-v6sm19308650pgk.54.2018.10.30.11.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 11:40:07 -0700 (PDT)
Date:   Tue, 30 Oct 2018 11:40:07 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Oct 2018 18:39:59 GMT
Message-Id: <567701fc798fec58e7401bdf88ee3b8dbbfe390d.1540924800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.62.git.gitgitgadget@gmail.com>
References: <pull.62.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/4] mingw: unset PERL5LIB by default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Git for Windows ships with its own Perl interpreter, and insists on
using it, so it will most likely wreak havoc if PERL5LIB is set before
launching Git.

Let's just unset that environment variables when spawning processes.

To make this feature extensible (and overrideable), there is a new
config setting `core.unsetenvvars` that allows specifying a
comma-separated list of names to unset before spawning processes.

Reported by Gabriel Fuhrmann.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt     |  6 ++++++
 compat/mingw.c               | 35 ++++++++++++++++++++++++++++++++++-
 t/t0029-core-unsetenvvars.sh | 30 ++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100755 t/t0029-core-unsetenvvars.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 09e95e9e9..f338f0b2c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -921,6 +921,12 @@ relatively high IO latencies.  When enabled, Git will do the
 index comparison to the filesystem data in parallel, allowing
 overlapping IO's.  Defaults to true.
 
+core.unsetenvvars::
+	Windows-only: comma-separated list of environment variables'
+	names that need to be unset before spawning any other process.
+	Defaults to `PERL5LIB` to account for the fact that Git for
+	Windows insists on using its own Perl interpreter.
+
 core.createObject::
 	You can set this to 'link', in which case a hardlink followed by
 	a delete of the source are used to make sure that object creation
diff --git a/compat/mingw.c b/compat/mingw.c
index 272d5e11e..181e74c23 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -212,6 +212,7 @@ enum hide_dotfiles_type {
 };
 
 static enum hide_dotfiles_type hide_dotfiles = HIDE_DOTFILES_DOTGITONLY;
+static char *unset_environment_variables;
 
 int mingw_core_config(const char *var, const char *value, void *cb)
 {
@@ -223,6 +224,12 @@ int mingw_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.unsetenvvars")) {
+		free(unset_environment_variables);
+		unset_environment_variables = xstrdup(value);
+		return 0;
+	}
+
 	return 0;
 }
 
@@ -1180,6 +1187,27 @@ static wchar_t *make_environment_block(char **deltaenv)
 	return wenvblk;
 }
 
+static void do_unset_environment_variables(void)
+{
+	static int done;
+	char *p = unset_environment_variables;
+
+	if (done || !p)
+		return;
+	done = 1;
+
+	for (;;) {
+		char *comma = strchr(p, ',');
+
+		if (comma)
+			*comma = '\0';
+		unsetenv(p);
+		if (!comma)
+			break;
+		p = comma + 1;
+	}
+}
+
 struct pinfo_t {
 	struct pinfo_t *next;
 	pid_t pid;
@@ -1198,9 +1226,12 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
 	wchar_t wcmd[MAX_PATH], wdir[MAX_PATH], *wargs, *wenvblk = NULL;
 	unsigned flags = CREATE_UNICODE_ENVIRONMENT;
 	BOOL ret;
+	HANDLE cons;
+
+	do_unset_environment_variables();
 
 	/* Determine whether or not we are associated to a console */
-	HANDLE cons = CreateFile("CONOUT$", GENERIC_WRITE,
+	cons = CreateFile("CONOUT$", GENERIC_WRITE,
 			FILE_SHARE_WRITE, NULL, OPEN_EXISTING,
 			FILE_ATTRIBUTE_NORMAL, NULL);
 	if (cons == INVALID_HANDLE_VALUE) {
@@ -2437,6 +2468,8 @@ void mingw_startup(void)
 	/* fix Windows specific environment settings */
 	setup_windows_environment();
 
+	unset_environment_variables = xstrdup("PERL5LIB");
+
 	/* initialize critical section for waitpid pinfo_t list */
 	InitializeCriticalSection(&pinfo_cs);
 
diff --git a/t/t0029-core-unsetenvvars.sh b/t/t0029-core-unsetenvvars.sh
new file mode 100755
index 000000000..24ce46a6e
--- /dev/null
+++ b/t/t0029-core-unsetenvvars.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description='test the Windows-only core.unsetenvvars setting'
+
+. ./test-lib.sh
+
+if ! test_have_prereq MINGW
+then
+	skip_all='skipping Windows-specific tests'
+	test_done
+fi
+
+test_expect_success 'setup' '
+	mkdir -p "$TRASH_DIRECTORY/.git/hooks" &&
+	write_script "$TRASH_DIRECTORY/.git/hooks/pre-commit" <<-\EOF
+	echo $HOBBES >&2
+	EOF
+'
+
+test_expect_success 'core.unsetenvvars works' '
+	HOBBES=Calvin &&
+	export HOBBES &&
+	git commit --allow-empty -m with 2>err &&
+	grep Calvin err &&
+	git -c core.unsetenvvars=FINDUS,HOBBES,CALVIN \
+		commit --allow-empty -m without 2>err &&
+	! grep Calvin err
+'
+
+test_done
-- 
gitgitgadget
