Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 481741F770
	for <e@80x24.org>; Wed,  2 Jan 2019 15:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbfABPii (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 10:38:38 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35159 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729426AbfABPih (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 10:38:37 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so26557529edx.2
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 07:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S3Xv3WYIz1cREaYUBvIr2+ale6eyjlaJXZsnFQzdS04=;
        b=GPH5TYoLP/8Apv1RRFPJnR2mHMrRmV7nNAxdl7tn9LoSkEea4o7iznJfq0s8xvD6Wv
         dUznhtdn+ZJWrlajHMBcUkzG1mXAGkCrV12HPJvAwAJ0feUJ4hl0Rxhq5ZLMd5931p0R
         ECWUdj9IYje1EXoM+Rxm4YMGvBctTTrcNfjQ6A4q5kbKE1VVHnpVhqxaDkRkPFxGNF+M
         WF1TTC9NlbRqEz7I4tsv6kiqgeRw5+EC8M2YVDjuXqDxb+uNIbF1EnfhyzCvwDNxww7Y
         4lto6aU/pCvZ21UdAHTr8HG/pb2j0GyTGhHfJYXjvxhpf5H5vAj2sTM5Iiz72Epj3ocW
         IZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S3Xv3WYIz1cREaYUBvIr2+ale6eyjlaJXZsnFQzdS04=;
        b=nOjs2eCZdBwn37D7JiG2dqMiR4DQd6bjJuA4+y6PK/uB9VRWeIovXRcne+RrWdB7l+
         +ZDUO6GC5PRt3blcRPQAWn6OArhvvOQlWlIn4zR2iDz1SWcbRwnwfs+gOJyPTTzyWouD
         tvxIMG4U/jJLpBDBC2SogpPn8IpfrQAFwUz+4GA/D3JaOcyrNS3u7E4QlC4rkWEhXKoj
         mIOJG2a/4PTewejD54UZvTf5h5EFf6x7vg4szbpbXloAMcAeReox9u0BaJ7Ey0Q6XI+v
         1MkFjeaPae6luRiTbZFN3P2eM8doPRrzIU7QeM++O+sO5sBtllIhYTz9tw4yGAHJtsP1
         HDmw==
X-Gm-Message-State: AA+aEWZpBhjdxa3BbytGZ2ArV55pvP4I/cSFEqX/AZCipT6lI0hJtN4h
        AE7UlhqQeiCP3vq1mJ13lKuzId1I
X-Google-Smtp-Source: AFSGD/VbUhQby6ltqL+ikmqGvrdIisM0F3fSiX/rOGep4rOo0WbUx2mbtb5xO5F4rYs6lXboC4SsAw==
X-Received: by 2002:a17:906:3488:: with SMTP id g8-v6mr33301470ejb.11.1546443514942;
        Wed, 02 Jan 2019 07:38:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e53sm21879135ede.90.2019.01.02.07.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 07:38:34 -0800 (PST)
Date:   Wed, 02 Jan 2019 07:38:34 -0800 (PST)
X-Google-Original-Date: Wed, 02 Jan 2019 15:38:26 GMT
Message-Id: <e9f400b1d6e091798d9444046cfbcb67f7afd1b3.1546443509.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.101.v17.git.gitgitgadget@gmail.com>
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
        <pull.101.v17.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v17 5/7] bisect--helper: `bisect_next_check` shell function in
 C
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

Reimplement `bisect_next_check` shell function in C and add
`bisect-next-check` subcommand to `git bisect--helper` to call it from
git-bisect.sh .

`bisect_voc` shell function is no longer useful now and is replaced by
using a char *[] of "new|bad" and "good|old" values.

Using `--bisect-next-check` is a temporary measure to port shell
function to C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired but its implementation will
be called by some other methods.

Helped-by: Stephan Beyer <s-beyer@gmx.net>
Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 88 +++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 60 ++-------------------------
 2 files changed, 91 insertions(+), 57 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 02ea5a9611..38ae825b9a 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -6,6 +6,7 @@
 #include "dir.h"
 #include "argv-array.h"
 #include "run-command.h"
+#include "prompt.h"
 
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
@@ -21,6 +22,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
+	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
 	NULL
 };
 
@@ -44,6 +46,9 @@ static void set_terms(struct bisect_terms *terms, const char *bad,
 	terms->term_bad = xstrdup(bad);
 }
 
+static const char *vocab_bad = "bad|new";
+static const char *vocab_good = "good|old";
+
 /*
  * Check whether the string `term` belongs to the set of strings
  * included in the variable arguments.
@@ -262,6 +267,78 @@ static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
 	return 0;
 }
 
+static int mark_good(const char *refname, const struct object_id *oid,
+		     int flag, void *cb_data)
+{
+	int *m_good = (int *)cb_data;
+	*m_good = 0;
+	return 1;
+}
+
+static const char *need_bad_and_good_revision_warning =
+	N_("You need to give me at least one %s and %s revision.\n"
+	   "You can use \"git bisect %s\" and \"git bisect %s\" for that.");
+
+static const char *need_bisect_start_warning =
+	N_("You need to start by \"git bisect start\".\n"
+	   "You then need to give me at least one %s and %s revision.\n"
+	   "You can use \"git bisect %s\" and \"git bisect %s\" for that.");
+
+static int bisect_next_check(const struct bisect_terms *terms,
+			     const char *current_term)
+{
+	int missing_good = 1, missing_bad = 1, retval = 0;
+	const char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
+	const char *good_glob = xstrfmt("%s-*", terms->term_good);
+
+	if (ref_exists(bad_ref))
+		missing_bad = 0;
+
+	for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
+			     (void *) &missing_good);
+
+	if (!missing_good && !missing_bad)
+		goto finish;
+
+	if (!current_term) {
+		retval = -1;
+		goto finish;
+	}
+
+	if (missing_good && !missing_bad &&
+	    !strcmp(current_term, terms->term_good)) {
+		char *yesno;
+		/*
+		 * have bad (or new) but not good (or old). We could bisect
+		 * although this is less optimum.
+		 */
+		warning(_("bisecting only with a %s commit"), terms->term_bad);
+		if (!isatty(0))
+			goto finish;
+		/*
+		 * TRANSLATORS: Make sure to include [Y] and [n] in your
+		 * translation. The program will only accept English input
+		 * at this point.
+		 */
+		yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
+		if (starts_with(yesno, "N") || starts_with(yesno, "n"))
+			retval = -1;
+		goto finish;
+	}
+	if (!is_empty_or_missing_file(git_path_bisect_start())) {
+		retval = error(_(need_bad_and_good_revision_warning),
+			       vocab_bad, vocab_good, vocab_bad, vocab_good);
+	} else {
+		retval = error(_(need_bisect_start_warning),
+			       vocab_good, vocab_bad, vocab_good, vocab_bad);
+	}
+
+finish:
+	free((void *) good_glob);
+	free((void *) bad_ref);
+	return retval;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -271,7 +348,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
-		CHECK_AND_SET_TERMS
+		CHECK_AND_SET_TERMS,
+		BISECT_NEXT_CHECK
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -289,6 +367,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
 		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
 			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
+		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
+			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -333,6 +413,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, argv[2], argv[1]);
 		res = check_and_set_terms(&terms, argv[0]);
 		break;
+	case BISECT_NEXT_CHECK:
+		if (argc != 2 && argc != 3)
+			return error(_("--bisect-next-check requires 2 or 3 arguments"));
+		set_terms(&terms, argv[1], argv[0]);
+		res = bisect_next_check(&terms, argc == 3 ? argv[2] : NULL);
+		break;
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 9e993a8187..5ef3e25621 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -271,59 +271,14 @@ bisect_state() {
 	bisect_auto_next
 }
 
-bisect_next_check() {
-	missing_good= missing_bad=
-	git show-ref -q --verify refs/bisect/$TERM_BAD || missing_bad=t
-	test -n "$(git for-each-ref "refs/bisect/$TERM_GOOD-*")" || missing_good=t
-
-	case "$missing_good,$missing_bad,$1" in
-	,,*)
-		: have both $TERM_GOOD and $TERM_BAD - ok
-		;;
-	*,)
-		# do not have both but not asked to fail - just report.
-		false
-		;;
-	t,,"$TERM_GOOD")
-		# have bad (or new) but not good (or old).  we could bisect although
-		# this is less optimum.
-		eval_gettextln "Warning: bisecting only with a \$TERM_BAD commit." >&2
-		if test -t 0
-		then
-			# TRANSLATORS: Make sure to include [Y] and [n] in your
-			# translation. The program will only accept English input
-			# at this point.
-			gettext "Are you sure [Y/n]? " >&2
-			read yesno
-			case "$yesno" in [Nn]*) exit 1 ;; esac
-		fi
-		: bisect without $TERM_GOOD...
-		;;
-	*)
-		bad_syn=$(bisect_voc bad)
-		good_syn=$(bisect_voc good)
-		if test -s "$GIT_DIR/BISECT_START"
-		then
-
-			eval_gettextln "You need to give me at least one \$bad_syn and one \$good_syn revision.
-(You can use \"git bisect \$bad_syn\" and \"git bisect \$good_syn\" for that.)" >&2
-		else
-			eval_gettextln "You need to start by \"git bisect start\".
-You then need to give me at least one \$good_syn and one \$bad_syn revision.
-(You can use \"git bisect \$bad_syn\" and \"git bisect \$good_syn\" for that.)" >&2
-		fi
-		exit 1 ;;
-	esac
-}
-
 bisect_auto_next() {
-	bisect_next_check && bisect_next || :
+	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD && bisect_next || :
 }
 
 bisect_next() {
 	case "$#" in 0) ;; *) usage ;; esac
 	bisect_autostart
-	bisect_next_check $TERM_GOOD
+	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD $TERM_GOOD|| exit
 
 	# Perform all bisection computation, display and checkout
 	git bisect--helper --next-all $(test -f "$GIT_DIR/BISECT_HEAD" && echo --no-checkout)
@@ -355,7 +310,7 @@ bisect_next() {
 }
 
 bisect_visualize() {
-	bisect_next_check fail
+	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
 
 	if test $# = 0
 	then
@@ -409,7 +364,7 @@ bisect_replay () {
 }
 
 bisect_run () {
-	bisect_next_check fail
+	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
 
 	test -n "$*" || die "$(gettext "bisect run failed: no command provided.")"
 
@@ -484,13 +439,6 @@ get_terms () {
 	fi
 }
 
-bisect_voc () {
-	case "$1" in
-	bad) echo "bad|new" ;;
-	good) echo "good|old" ;;
-	esac
-}
-
 bisect_terms () {
 	get_terms
 	if ! test -s "$GIT_DIR/BISECT_TERMS"
-- 
gitgitgadget

