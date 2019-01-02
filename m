Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03EEA1F775
	for <e@80x24.org>; Wed,  2 Jan 2019 15:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbfABPig (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 10:38:36 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36218 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfABPif (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 10:38:35 -0500
Received: by mail-ed1-f65.google.com with SMTP id f23so26532445edb.3
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 07:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8ZPSBc0gYWvYsRASDqFtn/0WKWvQjsL66y/MDZtXQ5k=;
        b=JmXmTcRU6kM7kRKoVhp7N0ys+Fr0ZYDeySkb/W+cZ2o7JUNPlI8MPjm0PX2XUg2Q6M
         koLtWeE2NTQF9JeJFlT+b2dfHy235N2BBHtrEN3y6XVkBGasDmUzc9MfFkjY6A2tyNnb
         11dRPD30eK+wINmMH5+Tz1ATG4ViZ+QBbGDGdJ/W5vj+7obEeh0VkIc8uB0kf3W0t/K6
         nrGOdgC6kCCsVW2zXdJRO2GLigJRpDUOXcGVpePW4lQinlpEb/Jwg2FPgY5KzR0dtaSj
         NrrM/8hHZbDPteqkMm1yMuqetxK1XPJ3cWqdbR6p0WBovhkFJ3hl7QXump7ZH9Cyh4xi
         JujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8ZPSBc0gYWvYsRASDqFtn/0WKWvQjsL66y/MDZtXQ5k=;
        b=pHYuXB8qPLDTUS+N4aaOGMOrLPU+u3EeNhdr4lxZqRvtR9usgb+hP7syxPNU2rDMA+
         EC5DqDjkujC2WIpZCk0tPeSvvIAlUxRRkf1AfQVFzwCuRii0IQmO0oqQy6Xg40E+VyaO
         I7clKYf6D+egZaxaMJVvCTua19dvvilfIUbge+1B2IEYrCp1jn2JldBIpqoFKzdK4lXC
         LfUkVDKIs2IacQ0Da+n6iJhaniRvxyRomMqus3rX3rzNU6grCAd7omBqYgyd5zykkXMx
         mjtmHAkIJHZw3oFVzy7u4YhuaADZ4dbJQAbw6mG/CJsJIy7IZBwFJHFwPs70AsHMus1V
         TAwQ==
X-Gm-Message-State: AA+aEWaMyhZRUbon2f0TYHIovygMUVdG+xmydZj7WIc59mMwnBMKMcmV
        EY2rB/aHDyCfAP5XaOl9G+pZfngc
X-Google-Smtp-Source: AFSGD/VtbZYjpA4cRaR2ysG5iNkH3PWqemKAR69z/EZLTl14yExOom5Z4skbXRUDYqI2MPS5eQ+VJg==
X-Received: by 2002:a50:a8a4:: with SMTP id k33mr39956317edc.109.1546443512532;
        Wed, 02 Jan 2019 07:38:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3sm21141057edm.31.2019.01.02.07.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 07:38:32 -0800 (PST)
Date:   Wed, 02 Jan 2019 07:38:32 -0800 (PST)
X-Google-Original-Date: Wed, 02 Jan 2019 15:38:23 GMT
Message-Id: <7d6291d9dda2531646b2a64941338adb98f60dee.1546443509.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.101.v17.git.gitgitgadget@gmail.com>
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
        <pull.101.v17.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v17 2/7] bisect--helper: `bisect_write` shell function in C
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

Reimplement the `bisect_write` shell function in C and add a
`bisect-write` subcommand to `git bisect--helper` to call it from
git-bisect.sh

Using `--bisect-write` subcommand is a temporary measure to port shell
function in C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired but its implementation will
be called by some other methods.

Note: bisect_write() uses two variables namely TERM_GOOD and TERM_BAD
from the global shell script thus we need to pass it to the subcommand
using the arguments. We then store them in a struct bisect_terms and
pass the memory address around functions.

Add a log_commit() helper function to write the contents of the commit message
header to a file which will be re-used in future parts of the code as
well.

Also introduce a function free_terms() to free the memory of `struct
bisect_terms` and set_terms() to set the values of members in `struct
bisect_terms`.

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 105 +++++++++++++++++++++++++++++++++++++--
 git-bisect.sh            |  25 ++--------
 2 files changed, 106 insertions(+), 24 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index aa6495dc84..df821be4b2 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -12,15 +12,37 @@ static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
 static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
 static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_head, "BISECT_HEAD")
+static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-clean-state"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
+	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	NULL
 };
 
+struct bisect_terms {
+	char *term_good;
+	char *term_bad;
+};
+
+static void free_terms(struct bisect_terms *terms)
+{
+	FREE_AND_NULL(terms->term_good);
+	FREE_AND_NULL(terms->term_bad);
+}
+
+static void set_terms(struct bisect_terms *terms, const char *bad,
+		      const char *good)
+{
+	free((void *)terms->term_good);
+	terms->term_good = xstrdup(good);
+	free((void *)terms->term_bad);
+	terms->term_bad = xstrdup(bad);
+}
+
 /*
  * Check whether the string `term` belongs to the set of strings
  * included in the variable arguments.
@@ -148,6 +170,70 @@ static int bisect_reset(const char *commit)
 	return bisect_clean_state();
 }
 
+static void log_commit(FILE *fp, char *fmt, const char *state,
+		       struct commit *commit)
+{
+	struct pretty_print_context pp = {0};
+	struct strbuf commit_msg = STRBUF_INIT;
+	char *label = xstrfmt(fmt, state);
+
+	format_commit_message(commit, "%s", &commit_msg, &pp);
+
+	fprintf(fp, "# %s: [%s] %s\n", label, oid_to_hex(&commit->object.oid),
+		commit_msg.buf);
+
+	strbuf_release(&commit_msg);
+	free(label);
+}
+
+static int bisect_write(const char *state, const char *rev,
+			const struct bisect_terms *terms, int nolog)
+{
+	struct strbuf tag = STRBUF_INIT;
+	struct object_id oid;
+	struct commit *commit;
+	FILE *fp = NULL;
+	int retval = 0;
+
+	if (!strcmp(state, terms->term_bad)) {
+		strbuf_addf(&tag, "refs/bisect/%s", state);
+	} else if (one_of(state, terms->term_good, "skip", NULL)) {
+		strbuf_addf(&tag, "refs/bisect/%s-%s", state, rev);
+	} else {
+		retval = error(_("Bad bisect_write argument: %s"), state);
+		goto finish;
+	}
+
+	if (get_oid(rev, &oid)) {
+		retval = error(_("couldn't get the oid of the rev '%s'"), rev);
+		goto finish;
+	}
+
+	if (update_ref(NULL, tag.buf, &oid, NULL, 0,
+		       UPDATE_REFS_MSG_ON_ERR)) {
+		retval = -1;
+		goto finish;
+	}
+
+	fp = fopen(git_path_bisect_log(), "a");
+	if (!fp) {
+		retval = error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
+		goto finish;
+	}
+
+	commit = lookup_commit_reference(the_repository, &oid);
+	log_commit(fp, "%s", state, commit);
+
+	if (!nolog)
+		fprintf(fp, "git bisect %s %s\n", state, rev);
+
+finish:
+	if (fp)
+		fclose(fp);
+	strbuf_release(&tag);
+	return retval;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -155,9 +241,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		WRITE_TERMS,
 		BISECT_CLEAN_STATE,
 		CHECK_EXPECTED_REVS,
-		BISECT_RESET
+		BISECT_RESET,
+		BISECT_WRITE
 	} cmdmode = 0;
-	int no_checkout = 0;
+	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
 		OPT_CMDMODE(0, "next-all", &cmdmode,
 			 N_("perform 'git bisect next'"), NEXT_ALL),
@@ -169,10 +256,15 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
+		OPT_CMDMODE(0, "bisect-write", &cmdmode,
+			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
+		OPT_BOOL(0, "no-log", &nolog,
+			 N_("no log for BISECT_WRITE ")),
 		OPT_END()
 	};
+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
 
 	argc = parse_options(argc, argv, prefix, options,
 			     git_bisect_helper_usage, 0);
@@ -198,8 +290,15 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
 		return !!bisect_reset(argc ? argv[0] : NULL);
+	case BISECT_WRITE:
+		if (argc != 4 && argc != 5)
+			return error(_("--bisect-write requires either 4 or 5 arguments"));
+		set_terms(&terms, argv[3], argv[2]);
+		res = bisect_write(argv[0], argv[1], &terms, nolog);
+		break;
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
-	return 0;
+	free_terms(&terms);
+	return !!res;
 }
diff --git a/git-bisect.sh b/git-bisect.sh
index afbfbc1f8e..ebf445223c 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -144,7 +144,7 @@ bisect_start() {
 		0) state=$TERM_BAD ; bad_seen=1 ;;
 		*) state=$TERM_GOOD ;;
 		esac
-		eval="$eval bisect_write '$state' '$rev' 'nolog' &&"
+		eval="$eval git bisect--helper --bisect-write '$state' '$rev' '$TERM_GOOD' '$TERM_BAD' 'nolog' &&"
 	done
 	#
 	# Verify HEAD.
@@ -220,23 +220,6 @@ bisect_start() {
 	trap '-' 0
 }
 
-bisect_write() {
-	state="$1"
-	rev="$2"
-	nolog="$3"
-	case "$state" in
-		"$TERM_BAD")
-			tag="$state" ;;
-		"$TERM_GOOD"|skip)
-			tag="$state"-"$rev" ;;
-		*)
-			die "$(eval_gettext "Bad bisect_write argument: \$state")" ;;
-	esac
-	git update-ref "refs/bisect/$tag" "$rev" || exit
-	echo "# $state: $(git show-branch $rev)" >>"$GIT_DIR/BISECT_LOG"
-	test -n "$nolog" || echo "git bisect $state $rev" >>"$GIT_DIR/BISECT_LOG"
-}
-
 bisect_skip() {
 	all=''
 	for arg in "$@"
@@ -263,7 +246,7 @@ bisect_state() {
 		bisected_head=$(bisect_head)
 		rev=$(git rev-parse --verify "$bisected_head") ||
 			die "$(eval_gettext "Bad rev input: \$bisected_head")"
-		bisect_write "$state" "$rev"
+		git bisect--helper --bisect-write "$state" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit
 		git bisect--helper --check-expected-revs "$rev" ;;
 	2,"$TERM_BAD"|*,"$TERM_GOOD"|*,skip)
 		shift
@@ -276,7 +259,7 @@ bisect_state() {
 		done
 		for rev in $hash_list
 		do
-			bisect_write "$state" "$rev"
+			git bisect--helper --bisect-write "$state" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit
 		done
 		git bisect--helper --check-expected-revs $hash_list ;;
 	*,"$TERM_BAD")
@@ -413,7 +396,7 @@ bisect_replay () {
 			cmd="bisect_start $rev"
 			eval "$cmd" ;;
 		"$TERM_GOOD"|"$TERM_BAD"|skip)
-			bisect_write "$command" "$rev" ;;
+			git bisect--helper --bisect-write "$command" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit;;
 		terms)
 			bisect_terms $rev ;;
 		*)
-- 
gitgitgadget

