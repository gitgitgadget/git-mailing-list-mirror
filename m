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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E1F91F454
	for <e@80x24.org>; Thu,  7 Nov 2019 08:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfKGIKG (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 03:10:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38045 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKGIKG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 03:10:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id z19so1302503wmk.3
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 00:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cMForQHZzMQRHy8I3Tt1E+Ayg8a1f47l4qlo8jjQ6SA=;
        b=HtpdNWoLtBToQu/TdBbsRurNtaV6rqKxQG2+XF7Tp5XvIRd5yE6oPqQuS/o9n/VgFM
         fFZTQ82g6pzw3pPEb57S9VU9AfbzC5ji5WzLjpaG0K21tWAUk5uoCwCPM1Wbcf9MnAkk
         RG+/zMyhXVlNC/L7Hcdlck4JqxbX7AxGdrb3mU2MKA2+ryuGxvOGcEpXOK9OMTwj1rFe
         /zwAZMQwvyFFbtIXSynl9LvNp+RbFaPCAz1uh4vpP+jKISP15/yfdiqieemgCgNSj4Lq
         YcoNS6XoSNUm54YMX8hgyBCZhtnUkuf02x/VtXaUcjeKJ8tnFiWZwnJ8E3yRYtZVavAh
         r5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cMForQHZzMQRHy8I3Tt1E+Ayg8a1f47l4qlo8jjQ6SA=;
        b=BdrEFn/6itql5fQ0FNfzLR9zW9zSOMbWwDY2/afkSk6FePzUJUdKp0EoPJ7wERYpIr
         q2WwpaYgCB8R9Eu8TCLtY/qg5Bt06kM+MZIYMksfnqR1h28U6E2k2/D/NeAB8gqpyXwk
         Ae8d6GmT44gG0NMVSJpxteHesvXKIyD/nLDXB2kcArfcEnHzOl9h4ZWrt0fRNiqEj6/3
         1QjqFYjtrXEUaOuoJruJs7iVCCiq4YxD5C6xtZcayzP4PrRiPbeVuIj5z2KMotEWcck9
         w++jpSajtWyZtSuUZg0xeUk9w6/IK+woEK6GacR4b8mG0WiJl6RqQcbEusJkFfFDfR7n
         dzwA==
X-Gm-Message-State: APjAAAVvJWd9pDavRgAZHh3iqJkZUMvSSkFoO8oPdvavg9hDANp1Ujfz
        Z5Q4Fvi91J4G5PS+tfK+4r4zzGbZ
X-Google-Smtp-Source: APXvYqymDy/WhpY4VFA6oOh4ioAMM5+40TY2/DTofmXwJj2W297Qcfxu4GiiOaIM3qWyBwYtugTU2g==
X-Received: by 2002:a05:600c:2945:: with SMTP id n5mr1709581wmd.80.1573114203498;
        Thu, 07 Nov 2019 00:10:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b1sm1152495wrs.74.2019.11.07.00.10.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 00:10:03 -0800 (PST)
Message-Id: <e8bca0910e7ba7582a50115eeeb66406d965a52a.1573114201.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.449.git.1573114201.gitgitgadget@gmail.com>
References: <pull.449.git.1573114201.gitgitgadget@gmail.com>
From:   "george espinoza via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Nov 2019 08:09:56 +0000
Subject: [PATCH 2/6] [Outreachy] check-ref-format: parse-options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     George Espinoza <gespinoz2019@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        george espinoza <gespinoz2019@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: george espinoza <gespinoz2019@gmail.com>

This command currently handles its own argv so by teaching it to
use parse-options instead we can standardize the way commands
handle user input across the project.

As a consequence of using OPT_BOOL data structure on --normalize &
--refspec-pattern, --no-normalize & --no-refspec-pattern has been
can now be used.

NO_PARSEOPT flag was also removed to update git.c with the
conversion of the structure in this command.

This is a rough draft and I need some advice if I'm doing this
correctly since its being built but it is failing tests.

Helped by: emily shaffer <emilyshaffer@google.com>
Helped by: johannes schindelin <johannes.schindelin@gmx.de>

Signed-off-by: george espinoza <gespinoz2019@gmail.com>
---
 builtin/check-ref-format.c | 49 +++++++++++++++++++-------------------
 git.c                      |  2 +-
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index bc67d3f0a8..3fe0b5410a 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -6,10 +6,13 @@
 #include "refs.h"
 #include "builtin.h"
 #include "strbuf.h"
+#include "parse-options.h"
 
-static const char builtin_check_ref_format_usage[] =
-"git check-ref-format [--normalize] [<options>] <refname>\n"
-"   or: git check-ref-format --branch <branchname-shorthand>";
+static const char * const builtin_check_ref_format_usage[] = {
+	N_("git check-ref-format [--normalize] [<options>] <refname>\n"),
+	N_("   or: git check-ref-format --branch <branchname-shorthand>"),
+	NULL,
+};
 
 /*
  * Return a copy of refname but with leading slashes removed and runs
@@ -53,31 +56,29 @@ static int check_ref_format_branch(const char *arg)
 
 int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 {
-	int i;
-	int normalize = 0;
+	enum {
+		CHECK_REF_FORMAT_BRANCH,
+	};
+
+	int i = 0;
+	int verbose;
+	int normalize;
+	int allow_onelevel;
+	int refspec_pattern;
 	int flags = 0;
 	const char *refname;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(builtin_check_ref_format_usage);
-
-	if (argc == 3 && !strcmp(argv[1], "--branch"))
-		return check_ref_format_branch(argv[2]);
+	struct option options[] = {
+		OPT__VERBOSE(&verbose, N_("be verbose")),
+		OPT_GROUP(""),
+		OPT_CMDMODE( 0 , "branch", &check_ref_format_branch, N_("branch"), CHECK_REF_FORMAT_BRANCH),
+		OPT_BOOL( 0 , "normalize", &normalize, N_("normalize tracked files")),
+		OPT_BOOL( 0 , "allow-onelevel", &allow_onelevel, N_("allow one level")),
+		OPT_BOOL( 0 , "refspec-pattern", &refspec_pattern, N_("refspec pattern")),
+		OPT_END(),
+	};
 
-	for (i = 1; i < argc && argv[i][0] == '-'; i++) {
-		if (!strcmp(argv[i], "--normalize") || !strcmp(argv[i], "--print"))
-			normalize = 1;
-		else if (!strcmp(argv[i], "--allow-onelevel"))
-			flags |= REFNAME_ALLOW_ONELEVEL;
-		else if (!strcmp(argv[i], "--no-allow-onelevel"))
-			flags &= ~REFNAME_ALLOW_ONELEVEL;
-		else if (!strcmp(argv[i], "--refspec-pattern"))
-			flags |= REFNAME_REFSPEC_PATTERN;
-		else
-			usage(builtin_check_ref_format_usage);
-	}
-	if (! (i == argc - 1))
-		usage(builtin_check_ref_format_usage);
+	argc = parse_options(argc, argv, prefix, options, builtin_check_ref_format_usage, PARSE_OPT_KEEP_ARGV0);
 
 	refname = argv[i];
 	if (normalize)
diff --git a/git.c b/git.c
index ce6ab0ece2..13dbfde31c 100644
--- a/git.c
+++ b/git.c
@@ -478,7 +478,7 @@ static struct cmd_struct commands[] = {
 	{ "check-attr", cmd_check_attr, RUN_SETUP },
 	{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
 	{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
-	{ "check-ref-format", cmd_check_ref_format, NO_PARSEOPT  },
+	{ "check-ref-format", cmd_check_ref_format },
 	{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
 	{ "checkout-index", cmd_checkout_index,
 		RUN_SETUP | NEED_WORK_TREE},
-- 
gitgitgadget

