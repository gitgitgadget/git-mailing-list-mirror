Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D42111F453
	for <e@80x24.org>; Thu, 17 Jan 2019 20:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbfAQUOw (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 15:14:52 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33858 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729542AbfAQUOw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 15:14:52 -0500
Received: by mail-ed1-f68.google.com with SMTP id b3so9443872ede.1
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 12:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+4zG3NZpGnGyKZ2HkyBTbXE907dFiolVpB0qgQGwUXo=;
        b=VMO2BHb1Pt3AjfD06DIqDlPJDi31fEoAwpWH8eoHvLMzV4FBih44gaEaZe1jVXG7kx
         GrMKGclkHRp43tT9s9NYil5TJrEzFPUtANbPrupto2IbfNHCVi2FphbDKI3UdHPciMRH
         s8krb3K0Q29NgUx3rA8w/H+F76fVnBy6bCn96uaw8v74R+KFktRrQ0/tOrWDPANoKvz1
         ucBCPGpXDkI8b6qqVbc3/ZnycM2coZzV8mw9T1PTmiHlys7h8s8kGmub9TlcB33S0CqD
         IfdugDwqCi2tzYNmpxJBPEnbJlSafsxCO+wUUsq1uGoxNEg4dA9QHd1BRs3tHGR16hLK
         AaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+4zG3NZpGnGyKZ2HkyBTbXE907dFiolVpB0qgQGwUXo=;
        b=EU4RQ75pq7Ff3pxh1OarxA0Yu9Ui9JMVOM9EbLK7GLVJ3sA2KasqLoWcRpOzsctrgU
         JwjloyP3Dj9z19qaOie0rOdejh6ZBI/6xlkb/Q6YZkNH6Bvj3enlAX6pjzQG5ThEzCNZ
         tKiXZn4mGlXn4y9G9ekV0ebTpLbNMzxohyibtEzPDqX7GbGGZTThNocAohMQ7frgzUPh
         nGsGyA7vFhSx9spLDI+7YHDf0EcTm7Hk2CxzABquaQGOv93Asxn9J9dKyKRYnwXyajBi
         4wrY0Qomk+gU/bSAjFCWJa/5DvSmPOr5ULwy1rtAYD3JPZwi+Ls8QTr0EuK2P6zjJ63q
         XaXw==
X-Gm-Message-State: AJcUukeAc0goQ+bcB1k5H1xZeFSsSbgtYls+c7qa5E+Q80TnHIETaq9Z
        9VGLl0dIhJA+gfGriCRJulX1n+V0
X-Google-Smtp-Source: ALg8bN7uKGfVAhIbSUCWIXC9zBLL8ynKrlDEKfeKjzpHPrpK+0Vmyu6Ittytd5YsjSO8KId0D+YnGw==
X-Received: by 2002:a17:906:41cc:: with SMTP id g12-v6mr11931831ejl.219.1547756088968;
        Thu, 17 Jan 2019 12:14:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d5sm6479423edb.48.2019.01.17.12.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 12:14:48 -0800 (PST)
Date:   Thu, 17 Jan 2019 12:14:48 -0800 (PST)
X-Google-Original-Date: Thu, 17 Jan 2019 20:14:45 GMT
Message-Id: <d58c3ca9f1f988e4ee17c1ddccdae3d739ab7818.1547756085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.94.git.gitgitgadget@gmail.com>
References: <pull.94.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] mingw: special-case arguments to `sh`
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

The MSYS2 runtime does its best to emulate the command-line wildcard
expansion and de-quoting which would be performed by the calling Unix
shell on Unix systems.

Those Unix shell quoting rules differ from the quoting rules applying to
Windows' cmd and Powershell, making it a little awkward to quote
command-line parameters properly when spawning other processes.

In particular, git.exe passes arguments to subprocesses that are *not*
intended to be interpreted as wildcards, and if they contain
backslashes, those are not to be interpreted as escape characters, e.g.
when passing Windows paths.

Note: this is only a problem when calling MSYS2 executables, not when
calling MINGW executables such as git.exe. However, we do call MSYS2
executables frequently, most notably when setting the use_shell flag in
the child_process structure.

There is no elegant way to determine whether the .exe file to be
executed is an MSYS2 program or a MINGW one. But since the use case of
passing a command line through the shell is so prevalent, we need to
work around this issue at least when executing sh.exe.

Let's introduce an ugly, hard-coded test whether argv[0] is "sh", and
whether it refers to the MSYS2 Bash, to determine whether we need to
quote the arguments differently than usual.

That still does not fix the issue completely, but at least it is
something.

Incidentally, this also fixes the problem where `git clone \\server\repo`
failed due to incorrect handling of the backslashes when handing the path
to the git-upload-pack process.

Further, we need to take care to quote not only whitespace and
backslashes, but also curly brackets. As aliases frequently go through
the MSYS2 Bash, and as aliases frequently get parameters such as
HEAD@{yesterday}, this is really important. As an early version of this
patch broke this, let's make sure that this does not regress by adding a
test case for that.

Helped-by: Kim Gybels <kgybels@infogroep.be>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c            | 77 ++++++++++++++++++++++++++++++++++++++-
 t/t0061-run-command.sh    | 10 +++++
 t/t5580-clone-push-unc.sh |  2 +-
 3 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index b459e1a291..0af8684019 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -7,6 +7,7 @@
 #include "../cache.h"
 #include "win32/lazyload.h"
 #include "../config.h"
+#include "dir.h"
 
 #define HCAST(type, handle) ((type)(intptr_t)handle)
 
@@ -1031,7 +1032,7 @@ char *mingw_getcwd(char *pointer, int len)
  * See "Parsing C++ Command-Line Arguments" at Microsoft's Docs:
  * https://docs.microsoft.com/en-us/cpp/cpp/parsing-cpp-command-line-arguments
  */
-static const char *quote_arg(const char *arg)
+static const char *quote_arg_msvc(const char *arg)
 {
 	/* count chars to quote */
 	int len = 0, n = 0;
@@ -1086,6 +1087,37 @@ static const char *quote_arg(const char *arg)
 	return q;
 }
 
+#include "quote.h"
+
+static const char *quote_arg_msys2(const char *arg)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const char *p2 = arg, *p;
+
+	for (p = arg; *p; p++) {
+		int ws = isspace(*p);
+		if (!ws && *p != '\\' && *p != '"' && *p != '{')
+			continue;
+		if (!buf.len)
+			strbuf_addch(&buf, '"');
+		if (p != p2)
+			strbuf_add(&buf, p2, p - p2);
+		if (!ws && *p != '{')
+			strbuf_addch(&buf, '\\');
+		p2 = p;
+	}
+
+	if (p == arg)
+		strbuf_addch(&buf, '"');
+	else if (!buf.len)
+		return arg;
+	else
+		strbuf_add(&buf, p2, p - p2),
+
+	strbuf_addch(&buf, '"');
+	return strbuf_detach(&buf, 0);
+}
+
 static const char *parse_interpreter(const char *cmd)
 {
 	static char buf[100];
@@ -1317,6 +1349,47 @@ struct pinfo_t {
 static struct pinfo_t *pinfo = NULL;
 CRITICAL_SECTION pinfo_cs;
 
+/* Used to match and chomp off path components */
+static inline int match_last_path_component(const char *path, size_t *len,
+					    const char *component)
+{
+	size_t component_len = strlen(component);
+	if (*len < component_len + 1 ||
+	    !is_dir_sep(path[*len - component_len - 1]) ||
+	    fspathncmp(path + *len - component_len, component, component_len))
+		return 0;
+	*len -= component_len + 1;
+	/* chomp off repeated dir separators */
+	while (*len > 0 && is_dir_sep(path[*len - 1]))
+		(*len)--;
+	return 1;
+}
+
+static int is_msys2_sh(const char *cmd)
+{
+	if (cmd && !strcmp(cmd, "sh")) {
+		static int ret = -1;
+		char *p;
+
+		if (ret >= 0)
+			return ret;
+
+		p = path_lookup(cmd, 0);
+		if (!p)
+			ret = 0;
+		else {
+			size_t len = strlen(p);
+
+			ret = match_last_path_component(p, &len, "sh.exe") &&
+				match_last_path_component(p, &len, "bin") &&
+				match_last_path_component(p, &len, "usr");
+			free(p);
+		}
+		return ret;
+	}
+	return 0;
+}
+
 static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaenv,
 			      const char *dir,
 			      int prepend_cmd, int fhin, int fhout, int fherr)
@@ -1328,6 +1401,8 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
 	unsigned flags = CREATE_UNICODE_ENVIRONMENT;
 	BOOL ret;
 	HANDLE cons;
+	const char *(*quote_arg)(const char *arg) =
+		is_msys2_sh(*argv) ? quote_arg_msys2 : quote_arg_msvc;
 
 	do_unset_environment_variables();
 
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 99a614bc7c..9c7604dcab 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -199,4 +199,14 @@ test_expect_success 'GIT_TRACE with environment variables' '
 	)
 '
 
+test_expect_success MINGW 'verify curlies are quoted properly' '
+	: force the rev-parse through the MSYS2 Bash &&
+	git -c alias.r="!git rev-parse" r -- a{b}c >actual &&
+	cat >expect <<-\EOF &&
+	--
+	a{b}c
+	EOF
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
index c3703765f4..217adf3a63 100755
--- a/t/t5580-clone-push-unc.sh
+++ b/t/t5580-clone-push-unc.sh
@@ -40,7 +40,7 @@ test_expect_success clone '
 	git clone "file://$UNCPATH" clone
 '
 
-test_expect_failure 'clone with backslashed path' '
+test_expect_success 'clone with backslashed path' '
 	BACKSLASHED="$(echo "$UNCPATH" | tr / \\\\)" &&
 	git clone "$BACKSLASHED" backslashed
 '
-- 
gitgitgadget
