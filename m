Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18D3C1F770
	for <e@80x24.org>; Wed,  2 Jan 2019 15:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbfABPik (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 10:38:40 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38406 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbfABPij (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 10:38:39 -0500
Received: by mail-ed1-f68.google.com with SMTP id h50so26533020ede.5
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 07:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dVitApexVh1yIyMGg7IfQDHYEPOK2WpLDzgwOoR7t8A=;
        b=Y6DirkTZBG9SX14+S7gEVeZDDUo58f+34Z78ChH0jeq3bRLtgeoGM2O9nUa5zDGEhk
         XA9Tykt6bb+r6SoB4Ke4dYZMjjDgXutSKyixSuJ56h+cUvZZAOT5JWaD85AQXOSDVSWO
         VQylofQixGXtXDhDH55qeWeu3jKT+cRzfK8XmAjlFkBpZdvhw+cbdsZlOxvBLKt06b2f
         W5CfTbOQKZDVTrc4F8gWA5O+463HiO9sFXE5Itk9TEOhZ3skDMM76sP6jkhcBdArjCFB
         R3m09YdP2nBrQ1Xp5B2SP1EknTkJhNKv2c62fH7zSC9OS16TK1oWIEY+EVrNDhc0Lq8i
         PD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dVitApexVh1yIyMGg7IfQDHYEPOK2WpLDzgwOoR7t8A=;
        b=HS7oFiczdxyNYDC76opB1Y9gh4yg8OmLB5WqzxS2caydVHa7GveRvTf8R7qhFFfOOk
         Z52Leco5J4AC1nbKqzCoLb3vuU2OoETOcnEXkMl7w6oflJGevlYrffig1KWVNHXdeFJf
         JILFxLhnCZA9Dr1zWTXliLCle6MDVgjV73Ksc37ueoG8kVO83t8NOGtMWlI7yzzjCR/G
         T4iK66OZdIRVxqX6JwIj7DWXr/sv57KYTuBa4WKosK9GPFx+l4HI6m2mVWxeaAfZRXhm
         SuTCKjHHQekkmwt8wIHHHoTwVKz4tmEHmw89Y69K99cmkmUX6ikvfBLaPBtc9v7+EWW9
         U2Mw==
X-Gm-Message-State: AA+aEWaolrPdGqm/iex9jdfWRDyTdiwhIjsggmD3EhukCxyrc+dJGkBR
        NK5jmrb+Ki5eQHVgng9RuyYXS6FG
X-Google-Smtp-Source: AFSGD/XnLVEsGZzEELiQw2pFl30jE20+Slj532+atbemCF9ivhFyUTL+grwpO/rc411Z371k2IiuAA==
X-Received: by 2002:a50:b1af:: with SMTP id m44mr39145050edd.47.1546443516991;
        Wed, 02 Jan 2019 07:38:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a27sm24865296eda.65.2019.01.02.07.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 07:38:36 -0800 (PST)
Date:   Wed, 02 Jan 2019 07:38:36 -0800 (PST)
X-Google-Original-Date: Wed, 02 Jan 2019 15:38:28 GMT
Message-Id: <87a033b858d7e6acba2671339f6bdded03dcdc3a.1546443509.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.101.v17.git.gitgitgadget@gmail.com>
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
        <pull.101.v17.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v17 7/7] bisect--helper: `bisect_start` shell function
 partially in C
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

Reimplement the `bisect_start` shell function partially in C and add
`bisect-start` subcommand to `git bisect--helper` to call it from
git-bisect.sh .

The last part is not converted because it calls another shell function.
`bisect_start` shell function will be completed after the `bisect_next`
shell function is ported in C.

Using `--bisect-start` subcommand is a temporary measure to port shell
function in C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and will be called by some
other methods.

Also introduce a method `bisect_append_log_quoted` to keep things short
and crisp.

Note that we are a bit lax about command-line parsing because the helper
is not supposed to be called by the user directly (but only from the git
bisect script).

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Stephan Beyer <s-beyer@gmx.net>
Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 230 ++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 132 +---------------------
 2 files changed, 230 insertions(+), 132 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index d61edd3c91..22e669e3b1 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -7,6 +7,7 @@
 #include "argv-array.h"
 #include "run-command.h"
 #include "prompt.h"
+#include "quote.h"
 
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
@@ -14,6 +15,8 @@ static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
 static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_head, "BISECT_HEAD")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
+static GIT_PATH_FUNC(git_path_head_name, "head-name")
+static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
@@ -24,6 +27,8 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
+	N_("git bisect--helper --bisect-start [--term-{old,good}=<term> --term-{new,bad}=<term>]"
+					     "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
 	NULL
 };
 
@@ -389,6 +394,219 @@ static int bisect_terms(struct bisect_terms *terms, const char *option)
 	return 0;
 }
 
+static int bisect_append_log_quoted(const char **argv)
+{
+	int retval = 0;
+	FILE *fp = fopen(git_path_bisect_log(), "a");
+	struct strbuf orig_args = STRBUF_INIT;
+
+	if (!fp)
+		return -1;
+
+	if (fprintf(fp, "git bisect start") < 1) {
+		retval = -1;
+		goto finish;
+	}
+
+	sq_quote_argv(&orig_args, argv);
+	if (fprintf(fp, "%s\n", orig_args.buf) < 1)
+		retval = -1;
+
+finish:
+	fclose(fp);
+	strbuf_release(&orig_args);
+	return retval;
+}
+
+static int bisect_start(struct bisect_terms *terms, int no_checkout,
+			const char **argv, int argc)
+{
+	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
+	int flags, pathspec_pos, retval = 0;
+	struct string_list revs = STRING_LIST_INIT_DUP;
+	struct string_list states = STRING_LIST_INIT_DUP;
+	struct strbuf start_head = STRBUF_INIT;
+	struct strbuf bisect_names = STRBUF_INIT;
+	struct object_id head_oid;
+	struct object_id oid;
+	const char *head;
+
+	if (is_bare_repository())
+		no_checkout = 1;
+
+	/*
+	 * Check for one bad and then some good revisions
+	 */
+	for (i = 0; i < argc; i++) {
+		if (!strcmp(argv[i], "--")) {
+			has_double_dash = 1;
+			break;
+		}
+	}
+
+	for (i = 0; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!strcmp(argv[i], "--")) {
+			break;
+		} else if (!strcmp(arg, "--no-checkout")) {
+			no_checkout = 1;
+		} else if (!strcmp(arg, "--term-good") ||
+			 !strcmp(arg, "--term-old")) {
+			must_write_terms = 1;
+			free((void *) terms->term_good);
+			terms->term_good = xstrdup(argv[++i]);
+		} else if (skip_prefix(arg, "--term-good=", &arg) ||
+			   skip_prefix(arg, "--term-old=", &arg)) {
+			must_write_terms = 1;
+			free((void *) terms->term_good);
+			terms->term_good = xstrdup(arg);
+		} else if (!strcmp(arg, "--term-bad") ||
+			 !strcmp(arg, "--term-new")) {
+			must_write_terms = 1;
+			free((void *) terms->term_bad);
+			terms->term_bad = xstrdup(argv[++i]);
+		} else if (skip_prefix(arg, "--term-bad=", &arg) ||
+			   skip_prefix(arg, "--term-new=", &arg)) {
+			must_write_terms = 1;
+			free((void *) terms->term_bad);
+			terms->term_bad = xstrdup(arg);
+		} else if (starts_with(arg, "--") &&
+			 !one_of(arg, "--term-good", "--term-bad", NULL)) {
+			return error(_("unrecognized option: '%s'"), arg);
+		} else {
+			char *commit_id = xstrfmt("%s^{commit}", arg);
+			if (get_oid(commit_id, &oid) && has_double_dash)
+				die(_("'%s' does not appear to be a valid "
+				      "revision"), arg);
+
+			string_list_append(&revs, oid_to_hex(&oid));
+			free(commit_id);
+		}
+	}
+	pathspec_pos = i;
+
+	/*
+	 * The user ran "git bisect start <sha1> <sha1>", hence did not
+	 * explicitly specify the terms, but we are already starting to
+	 * set references named with the default terms, and won't be able
+	 * to change afterwards.
+	 */
+	if (revs.nr)
+		must_write_terms = 1;
+	for (i = 0; i < revs.nr; i++) {
+		if (bad_seen) {
+			string_list_append(&states, terms->term_good);
+		} else {
+			bad_seen = 1;
+			string_list_append(&states, terms->term_bad);
+		}
+	}
+
+	/*
+	 * Verify HEAD
+	 */
+	head = resolve_ref_unsafe("HEAD", 0, &head_oid, &flags);
+	if (!head)
+		if (get_oid("HEAD", &head_oid))
+			return error(_("bad HEAD - I need a HEAD"));
+
+	/*
+	 * Check if we are bisecting
+	 */
+	if (!is_empty_or_missing_file(git_path_bisect_start())) {
+		/* Reset to the rev from where we started */
+		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
+		strbuf_trim(&start_head);
+		if (!no_checkout) {
+			struct argv_array argv = ARGV_ARRAY_INIT;
+
+			argv_array_pushl(&argv, "checkout", start_head.buf,
+					 "--", NULL);
+			if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
+				retval = error(_("checking out '%s' failed."
+						 " Try 'git bisect start "
+						 "<valid-branch>'."),
+					       start_head.buf);
+				goto finish;
+			}
+		}
+	} else {
+		/* Get the rev from where we start. */
+		if (!get_oid(head, &head_oid) &&
+		    !starts_with(head, "refs/heads/")) {
+			strbuf_reset(&start_head);
+			strbuf_addstr(&start_head, oid_to_hex(&head_oid));
+		} else if (!get_oid(head, &head_oid) &&
+			   skip_prefix(head, "refs/heads/", &head)) {
+			/*
+			 * This error message should only be triggered by
+			 * cogito usage, and cogito users should understand
+			 * it relates to cg-seek.
+			 */
+			if (!is_empty_or_missing_file(git_path_head_name()))
+				return error(_("won't bisect on cg-seek'ed tree"));
+			strbuf_addstr(&start_head, head);
+		} else {
+			return error(_("bad HEAD - strange symbolic ref"));
+		}
+	}
+
+	/*
+	 * Get rid of any old bisect state.
+	 */
+	if (bisect_clean_state())
+		return -1;
+
+	/*
+	 * In case of mistaken revs or checkout error, or signals received,
+	 * "bisect_auto_next" below may exit or misbehave.
+	 * We have to trap this to be able to clean up using
+	 * "bisect_clean_state".
+	 */
+
+	/*
+	 * Write new start state
+	 */
+	write_file(git_path_bisect_start(), "%s\n", start_head.buf);
+
+	if (no_checkout) {
+		get_oid(start_head.buf, &oid);
+		if (update_ref(NULL, "BISECT_HEAD", &oid, NULL, 0,
+			       UPDATE_REFS_MSG_ON_ERR)) {
+			retval = -1;
+			goto finish;
+		}
+	}
+
+	if (pathspec_pos < argc - 1)
+		sq_quote_argv(&bisect_names, argv + pathspec_pos);
+	write_file(git_path_bisect_names(), "%s\n", bisect_names.buf);
+
+	for (i = 0; i < states.nr; i++)
+		if (bisect_write(states.items[i].string,
+				 revs.items[i].string, terms, 1)) {
+			retval = -1;
+			goto finish;
+		}
+
+	if (must_write_terms && write_terms(terms->term_bad,
+					    terms->term_good)) {
+		retval = -1;
+		goto finish;
+	}
+
+	retval = bisect_append_log_quoted(argv);
+	if (retval)
+		retval = -1;
+
+finish:
+	string_list_clear(&revs, 0);
+	string_list_clear(&states, 0);
+	strbuf_release(&start_head);
+	strbuf_release(&bisect_names);
+	return retval;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -400,7 +618,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
-		BISECT_TERMS
+		BISECT_TERMS,
+		BISECT_START
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -422,6 +641,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
 		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
 			 N_("print out the bisect terms"), BISECT_TERMS),
+		OPT_CMDMODE(0, "bisect-start", &cmdmode,
+			 N_("start the bisect session"), BISECT_START),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -431,7 +652,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_bisect_helper_usage, PARSE_OPT_KEEP_UNKNOWN);
+			     git_bisect_helper_usage,
+			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN);
 
 	if (!cmdmode)
 		usage_with_options(git_bisect_helper_usage, options);
@@ -477,6 +699,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			return error(_("--bisect-terms requires 0 or 1 argument"));
 		res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
 		break;
+	case BISECT_START:
+		set_terms(&terms, "bad", "good");
+		res = bisect_start(&terms, no_checkout, argv, argc);
+		break;
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index bdb614e3c2..efee12b8b1 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -71,122 +71,7 @@ bisect_autostart() {
 }
 
 bisect_start() {
-	#
-	# Check for one bad and then some good revisions.
-	#
-	has_double_dash=0
-	for arg; do
-		case "$arg" in --) has_double_dash=1; break ;; esac
-	done
-	orig_args=$(git rev-parse --sq-quote "$@")
-	bad_seen=0
-	eval=''
-	must_write_terms=0
-	revs=''
-	if test "z$(git rev-parse --is-bare-repository)" != zfalse
-	then
-		mode=--no-checkout
-	else
-		mode=''
-	fi
-	while [ $# -gt 0 ]; do
-		arg="$1"
-		case "$arg" in
-		--)
-			shift
-			break
-		;;
-		--no-checkout)
-			mode=--no-checkout
-			shift ;;
-		--term-good|--term-old)
-			shift
-			must_write_terms=1
-			TERM_GOOD=$1
-			shift ;;
-		--term-good=*|--term-old=*)
-			must_write_terms=1
-			TERM_GOOD=${1#*=}
-			shift ;;
-		--term-bad|--term-new)
-			shift
-			must_write_terms=1
-			TERM_BAD=$1
-			shift ;;
-		--term-bad=*|--term-new=*)
-			must_write_terms=1
-			TERM_BAD=${1#*=}
-			shift ;;
-		--*)
-			die "$(eval_gettext "unrecognised option: '\$arg'")" ;;
-		*)
-			rev=$(git rev-parse -q --verify "$arg^{commit}") || {
-				test $has_double_dash -eq 1 &&
-				die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
-				break
-			}
-			revs="$revs $rev"
-			shift
-			;;
-		esac
-	done
-
-	for rev in $revs
-	do
-		# The user ran "git bisect start <sha1>
-		# <sha1>", hence did not explicitly specify
-		# the terms, but we are already starting to
-		# set references named with the default terms,
-		# and won't be able to change afterwards.
-		must_write_terms=1
-
-		case $bad_seen in
-		0) state=$TERM_BAD ; bad_seen=1 ;;
-		*) state=$TERM_GOOD ;;
-		esac
-		eval="$eval git bisect--helper --bisect-write '$state' '$rev' '$TERM_GOOD' '$TERM_BAD' 'nolog' &&"
-	done
-	#
-	# Verify HEAD.
-	#
-	head=$(GIT_DIR="$GIT_DIR" git symbolic-ref -q HEAD) ||
-	head=$(GIT_DIR="$GIT_DIR" git rev-parse --verify HEAD) ||
-	die "$(gettext "Bad HEAD - I need a HEAD")"
-
-	#
-	# Check if we are bisecting.
-	#
-	start_head=''
-	if test -s "$GIT_DIR/BISECT_START"
-	then
-		# Reset to the rev from where we started.
-		start_head=$(cat "$GIT_DIR/BISECT_START")
-		if test "z$mode" != "z--no-checkout"
-		then
-			git checkout "$start_head" -- ||
-			die "$(eval_gettext "Checking out '\$start_head' failed. Try 'git bisect reset <valid-branch>'.")"
-		fi
-	else
-		# Get rev from where we start.
-		case "$head" in
-		refs/heads/*|$_x40)
-			# This error message should only be triggered by
-			# cogito usage, and cogito users should understand
-			# it relates to cg-seek.
-			[ -s "$GIT_DIR/head-name" ] &&
-				die "$(gettext "won't bisect on cg-seek'ed tree")"
-			start_head="${head#refs/heads/}"
-			;;
-		*)
-			die "$(gettext "Bad HEAD - strange symbolic ref")"
-			;;
-		esac
-	fi
-
-	#
-	# Get rid of any old bisect state.
-	#
-	git bisect--helper --bisect-clean-state || exit
+	git bisect--helper --bisect-start $@ || exit
 
 	#
 	# Change state.
@@ -198,23 +83,10 @@ bisect_start() {
 	trap 'git bisect--helper --bisect-clean-state' 0
 	trap 'exit 255' 1 2 3 15
 
-	#
-	# Write new start state.
-	#
-	echo "$start_head" >"$GIT_DIR/BISECT_START" && {
-		test "z$mode" != "z--no-checkout" ||
-		git update-ref --no-deref BISECT_HEAD "$start_head"
-	} &&
-	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
-	eval "$eval true" &&
-	if test $must_write_terms -eq 1
-	then
-		git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD" || exit
-	fi &&
-	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
 	# Check if we can proceed to the next bisect state.
 	#
+	get_terms
 	bisect_auto_next
 
 	trap '-' 0
-- 
gitgitgadget
