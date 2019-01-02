Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABD051F770
	for <e@80x24.org>; Wed,  2 Jan 2019 15:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbfABPim (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 10:38:42 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44505 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbfABPik (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 10:38:40 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so26462987edd.11
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 07:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C97zR+st24mQM2pxP2jIXHlYBZWjfw9KHcCYOEL1fqI=;
        b=q+NHDkd5mbljKB0H52jy1AvRIrEwyA8+b4pDAij4y+WnGlrHegdgP9LE/7EBZVOa/q
         x+mUvaoKnBHgU1hlSCcU4aXOlcvGMfiuH9W93ksiV6/AOgiJFrZwgWJqHh0fi05fXvh/
         +R38seg5mjqKkEiDDAf6RJFPEkD0PEUZ8OpsbzL1rsl7mom0QLkLiK/8Q62jXMxxuxkT
         Yx9aSA5x8ue9Rl5jhy8NGgiXk+t08gg4rD16rrBPQcABz1tYbLDgIi2vdSqVfHt1PBFD
         9wCYoth8PxdcLXcDrdqNjtrwWGOYVlTbJ7JHIBDn7tPfhNT0Xnid52EsL7KeC/Xh51P9
         i0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C97zR+st24mQM2pxP2jIXHlYBZWjfw9KHcCYOEL1fqI=;
        b=KJl0fmdbKjM7h3X+8JdMKQalcEuJFv6lJ8gFwpKvYNzhSwklalhuIBNmLRKI7x6mCL
         K8bWbcTgKlFK6MhTCWL8hECysnnwF5zVLQb7UkKtVv4EQENLu4ElEZ1aVn+7r9cWC+Vm
         4vCJWjQGtKqmEsjsvCJTl249wIKIt7/ZZkyiv5njRDQqoJFcXxZRGcVyF6pjWsff1/T/
         PJ3o6sQZLz+Xr117chGvhljiKc3dEakLdpC5PBp4HvBfMvwzb4ih05Xg5mAUFLxneE44
         k63TefuSLjxl+RCcgqiGYTD8Mh1bLSKzwP3ugIw4WvJkkHlsYJEzQRaFtE+1+/RY3saC
         qvuA==
X-Gm-Message-State: AA+aEWb8Zzg7BLT6CO744hhOecqGDcLa6gQWHmHfIi1VJexufeA0p8wx
        CTAxRdHtSgCZ/KGjYaZF6h+cUEPS
X-Google-Smtp-Source: AFSGD/VgG5W4DykxJ/xKJ9LiTnoCslH4Dvxvmjv+J9ZCo1tdzDuRR1aOF28gOyNDDvScsA0CuQQkng==
X-Received: by 2002:a50:9b1d:: with SMTP id o29mr37622267edi.246.1546443516130;
        Wed, 02 Jan 2019 07:38:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h47sm22119808eda.8.2019.01.02.07.38.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 07:38:35 -0800 (PST)
Date:   Wed, 02 Jan 2019 07:38:35 -0800 (PST)
X-Google-Original-Date: Wed, 02 Jan 2019 15:38:27 GMT
Message-Id: <f2b1706e5be93d8481dfd99fcb4c0a705fd36784.1546443509.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.101.v17.git.gitgitgadget@gmail.com>
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
        <pull.101.v17.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v17 6/7] bisect--helper: `get_terms` & `bisect_terms` shell
 function in C
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

Reimplement the `get_terms` and `bisect_terms` shell function in C and
add `bisect-terms` subcommand to `git bisect--helper` to call it from
git-bisect.sh .

Using `--bisect-terms` subcommand is a temporary measure to port shell
function in C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired but its implementation will
be called by some other methods.

Also use error() to report "no terms defined" and accordingly change the
test in t6030.

We need to use PARSE_OPT_KEEP_UNKNOWN here to allow for parameters that
look like options (e.g --term-good) but should not be parsed by
cmd_bisect__helper(). This change is safe because all other cmdmodes have
strict argc checks already.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c    | 62 +++++++++++++++++++++++++++++++++++--
 git-bisect.sh               | 35 ++-------------------
 t/t6030-bisect-porcelain.sh |  2 +-
 3 files changed, 63 insertions(+), 36 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 38ae825b9a..d61edd3c91 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -23,6 +23,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
+	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	NULL
 };
 
@@ -339,6 +340,55 @@ static int bisect_next_check(const struct bisect_terms *terms,
 	return retval;
 }
 
+static int get_terms(struct bisect_terms *terms)
+{
+	struct strbuf str = STRBUF_INIT;
+	FILE *fp = NULL;
+	int res = 0;
+
+	fp = fopen(git_path_bisect_terms(), "r");
+	if (!fp) {
+		res = -1;
+		goto finish;
+	}
+
+	free_terms(terms);
+	strbuf_getline_lf(&str, fp);
+	terms->term_bad = strbuf_detach(&str, NULL);
+	strbuf_getline_lf(&str, fp);
+	terms->term_good = strbuf_detach(&str, NULL);
+
+finish:
+	if (fp)
+		fclose(fp);
+	strbuf_release(&str);
+	return res;
+}
+
+static int bisect_terms(struct bisect_terms *terms, const char *option)
+{
+	if (get_terms(terms))
+		return error(_("no terms defined"));
+
+	if (option == NULL) {
+		printf(_("Your current terms are %s for the old state\n"
+			 "and %s for the new state.\n"),
+		       terms->term_good, terms->term_bad);
+		return 0;
+	}
+	if (one_of(option, "--term-good", "--term-old", NULL))
+		printf("%s\n", terms->term_good);
+	else if (one_of(option, "--term-bad", "--term-new", NULL))
+		printf("%s\n", terms->term_bad);
+	else
+		return error(_("invalid argument %s for 'git bisect terms'.\n"
+			       "Supported options are: "
+			       "--term-good|--term-old and "
+			       "--term-bad|--term-new."), option);
+
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -349,7 +399,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_RESET,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
-		BISECT_NEXT_CHECK
+		BISECT_NEXT_CHECK,
+		BISECT_TERMS
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -369,6 +420,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
 		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
 			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
+		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
+			 N_("print out the bisect terms"), BISECT_TERMS),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -378,7 +431,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_bisect_helper_usage, 0);
+			     git_bisect_helper_usage, PARSE_OPT_KEEP_UNKNOWN);
 
 	if (!cmdmode)
 		usage_with_options(git_bisect_helper_usage, options);
@@ -419,6 +472,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, argv[1], argv[0]);
 		res = bisect_next_check(&terms, argc == 3 ? argv[2] : NULL);
 		break;
+	case BISECT_TERMS:
+		if (argc > 1)
+			return error(_("--bisect-terms requires 0 or 1 argument"));
+		res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
+		break;
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 5ef3e25621..bdb614e3c2 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -355,7 +355,7 @@ bisect_replay () {
 		"$TERM_GOOD"|"$TERM_BAD"|skip)
 			git bisect--helper --bisect-write "$command" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit;;
 		terms)
-			bisect_terms $rev ;;
+			git bisect--helper --bisect-terms $rev || exit;;
 		*)
 			die "$(gettext "?? what are you talking about?")" ;;
 		esac
@@ -439,37 +439,6 @@ get_terms () {
 	fi
 }
 
-bisect_terms () {
-	get_terms
-	if ! test -s "$GIT_DIR/BISECT_TERMS"
-	then
-		die "$(gettext "no terms defined")"
-	fi
-	case "$#" in
-	0)
-		gettextln "Your current terms are $TERM_GOOD for the old state
-and $TERM_BAD for the new state."
-		;;
-	1)
-		arg=$1
-		case "$arg" in
-			--term-good|--term-old)
-				printf '%s\n' "$TERM_GOOD"
-				;;
-			--term-bad|--term-new)
-				printf '%s\n' "$TERM_BAD"
-				;;
-			*)
-				die "$(eval_gettext "invalid argument \$arg for 'git bisect terms'.
-Supported options are: --term-good|--term-old and --term-bad|--term-new.")"
-				;;
-		esac
-		;;
-	*)
-		usage ;;
-	esac
-}
-
 case "$#" in
 0)
 	usage ;;
@@ -500,7 +469,7 @@ case "$#" in
 	run)
 		bisect_run "$@" ;;
 	terms)
-		bisect_terms "$@" ;;
+		git bisect--helper --bisect-terms "$@" || exit;;
 	*)
 		usage ;;
 	esac
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index f84ff941c3..55835ee4a4 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -802,7 +802,7 @@ test_expect_success 'bisect terms needs 0 or 1 argument' '
 	test_must_fail git bisect terms only-one &&
 	test_must_fail git bisect terms 1 2 &&
 	test_must_fail git bisect terms 2>actual &&
-	echo "no terms defined" >expected &&
+	echo "error: no terms defined" >expected &&
 	test_i18ncmp expected actual
 '
 
-- 
gitgitgadget

