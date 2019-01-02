Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 345B01F770
	for <e@80x24.org>; Wed,  2 Jan 2019 15:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbfABPie (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 10:38:34 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40674 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbfABPie (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 10:38:34 -0500
Received: by mail-ed1-f66.google.com with SMTP id g22so26491376edr.7
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 07:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f+Lp5yA6cYQ8q8Hw7HiQG9LxYGO4tjrF4aTD72+9En0=;
        b=cxdvQ2yYvpAluMIZ2LX2MVTRZTecHme/PXPxJd4FV/vGJ0s/xR/og/P3wEqkoq25I6
         l0tc1fu6UA2kgmwJi+EjyuHs4qm9cYcSACT1DbBfV60qYhxaNDFJTkw4ncBMl29H5io7
         7eqOGkQUrsb1A9YXeeZMKxwG9msIuTjmUG+aamaT2dhU5B/j10efr53qMF5cYsmG+nfs
         mRuojfu0N2H4dPrtN1xaVOTYa7/hzoCnGMinmx7leL1RHu6jW3UFuVtJ/jU0H5ip04g5
         0ARvQjat3AlAKuxYlmnpFfjhMkKHzO+VQLR+A95aJkoASPQ1R35xWXSYhCQ0h9KMqSO3
         mVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f+Lp5yA6cYQ8q8Hw7HiQG9LxYGO4tjrF4aTD72+9En0=;
        b=X4w2bzyP+WrzHXKOF1S+mHYx/zcaXq9WyRZKVV5jHUA1qT7CrRfgCH11RTW2AgeQf6
         xOQOJsse5x8gjiUct17EY9sa6H4AwnikG/CBDdsCn2KWnXvmBPHW9ZtsUPal6lL0+CJ9
         hRyodLu3yS8jzRFezB0BLfWWaRJTvjpuH4jWvAZ3EtbpgcPRGQAgjhvtHvD117g6N/Yd
         fUB0NxHKoMCFitBwQXdEKQ1M9kHK0smdEXWiqEn3uYuNagb+O44cEVgsWrKErgy0FvSm
         5Tyj9BwyoEFlHEWVavhjoAQU/HCHUCJw6bJK6aWCRUwsgtXoy83EX7a2G0Cw9ZNsmUKe
         nfWw==
X-Gm-Message-State: AA+aEWYnT2D/1rYeHJOTIrYGETgop/s+qOYIVPxjx6wJtfKI83YcHvXk
        s8avURf7bH2Oiu1I5vgRFl3F5riT
X-Google-Smtp-Source: AFSGD/W8l4yUUJA73bTPsB4wqf6RFThW4PoBycdXDRXVdIRA5lknS/6yx6+4norxAJda2Lm0MLlVzg==
X-Received: by 2002:aa7:c605:: with SMTP id h5mr40162433edq.9.1546443511602;
        Wed, 02 Jan 2019 07:38:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k20sm22461634eda.71.2019.01.02.07.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 07:38:31 -0800 (PST)
Date:   Wed, 02 Jan 2019 07:38:31 -0800 (PST)
X-Google-Original-Date: Wed, 02 Jan 2019 15:38:22 GMT
Message-Id: <338ebdc97a86295495fa9da638e0b96c2ea746ee.1546443509.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.101.v17.git.gitgitgadget@gmail.com>
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
        <pull.101.v17.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v17 1/7] bisect--helper: `bisect_reset` shell function in C
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Reimplement `bisect_reset` shell function in C and add a `--bisect-reset`
subcommand to `git bisect--helper` to call it from git-bisect.sh .

Using `bisect_reset` subcommand is a temporary measure to port shell
functions to C so as to use the existing test suite. As more functions
are ported, this subcommand would be retired but its implementation will
be called by some other method.

Note: --bisect-clean-state subcommand has not been retired as there are
still a function namely `bisect_start()` which still uses this
subcommand.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 51 +++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 28 ++--------------------
 2 files changed, 52 insertions(+), 27 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 4b5fadcbe1..aa6495dc84 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -3,15 +3,21 @@
 #include "parse-options.h"
 #include "bisect.h"
 #include "refs.h"
+#include "dir.h"
+#include "argv-array.h"
+#include "run-command.h"
 
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
 static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
+static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
+static GIT_PATH_FUNC(git_path_bisect_head, "BISECT_HEAD")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-clean-state"),
+	N_("git bisect--helper --bisect-reset [<commit>]"),
 	NULL
 };
 
@@ -106,13 +112,50 @@ static void check_expected_revs(const char **revs, int rev_nr)
 	}
 }
 
+static int bisect_reset(const char *commit)
+{
+	struct strbuf branch = STRBUF_INIT;
+
+	if (!commit) {
+		if (strbuf_read_file(&branch, git_path_bisect_start(), 0) < 1) {
+			printf(_("We are not bisecting.\n"));
+			return 0;
+		}
+		strbuf_rtrim(&branch);
+	} else {
+		struct object_id oid;
+
+		if (get_oid_commit(commit, &oid))
+			return error(_("'%s' is not a valid commit"), commit);
+		strbuf_addstr(&branch, commit);
+	}
+
+	if (!file_exists(git_path_bisect_head())) {
+		struct argv_array argv = ARGV_ARRAY_INIT;
+
+		argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
+		if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
+			strbuf_release(&branch);
+			argv_array_clear(&argv);
+			return error(_("could not check out original"
+				       " HEAD '%s'. Try 'git bisect"
+				       "reset <commit>'."), branch.buf);
+		}
+		argv_array_clear(&argv);
+	}
+
+	strbuf_release(&branch);
+	return bisect_clean_state();
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		NEXT_ALL = 1,
 		WRITE_TERMS,
 		BISECT_CLEAN_STATE,
-		CHECK_EXPECTED_REVS
+		CHECK_EXPECTED_REVS,
+		BISECT_RESET
 	} cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
@@ -124,6 +167,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
 			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
+		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
+			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -149,6 +194,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	case CHECK_EXPECTED_REVS:
 		check_expected_revs(argv, argc);
 		return 0;
+	case BISECT_RESET:
+		if (argc > 1)
+			return error(_("--bisect-reset requires either no argument or a commit"));
+		return !!bisect_reset(argc ? argv[0] : NULL);
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 54cbfecc5a..afbfbc1f8e 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -393,35 +393,11 @@ bisect_visualize() {
 	eval '"$@"' --bisect -- $(cat "$GIT_DIR/BISECT_NAMES")
 }
 
-bisect_reset() {
-	test -s "$GIT_DIR/BISECT_START" || {
-		gettextln "We are not bisecting."
-		return
-	}
-	case "$#" in
-	0) branch=$(cat "$GIT_DIR/BISECT_START") ;;
-	1) git rev-parse --quiet --verify "$1^{commit}" >/dev/null || {
-			invalid="$1"
-			die "$(eval_gettext "'\$invalid' is not a valid commit")"
-		}
-		branch="$1" ;;
-	*)
-		usage ;;
-	esac
-
-	if ! test -f "$GIT_DIR/BISECT_HEAD" && ! git checkout "$branch" --
-	then
-		die "$(eval_gettext "Could not check out original HEAD '\$branch'.
-Try 'git bisect reset <commit>'.")"
-	fi
-	git bisect--helper --bisect-clean-state || exit
-}
-
 bisect_replay () {
 	file="$1"
 	test "$#" -eq 1 || die "$(gettext "No logfile given")"
 	test -r "$file" || die "$(eval_gettext "cannot read \$file for replaying")"
-	bisect_reset
+	git bisect--helper --bisect-reset || exit
 	while read git bisect command rev
 	do
 		test "$git $bisect" = "git bisect" || test "$git" = "git-bisect" || continue
@@ -613,7 +589,7 @@ case "$#" in
 	visualize|view)
 		bisect_visualize "$@" ;;
 	reset)
-		bisect_reset "$@" ;;
+		git bisect--helper --bisect-reset "$@" ;;
 	replay)
 		bisect_replay "$@" ;;
 	log)
-- 
gitgitgadget

