Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B71841F770
	for <e@80x24.org>; Wed,  2 Jan 2019 15:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbfABPig (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 10:38:36 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39009 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbfABPif (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 10:38:35 -0500
Received: by mail-ed1-f68.google.com with SMTP id b14so26504104edt.6
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 07:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=Pi6lAfisQE4cvq4pCvRbgpdY4izOS8pOwDZYv8Py2yI=;
        b=ciggROYbDzW/jEOO/PXNtqnhcbEr1bOc8nyUGzniojMQI26SXtGCtSsnBfgagtyxjZ
         /eG3sxcojP4hLYVyLB/KypUSX2USp3cAlFVuMRZ+bYQmg7Q8z/0kyyeFRRUr+yU8joVu
         Vjw65aiBCNRSIDA+z29EsdwNY2/trCTn6XMU0s22BF4/4UJWCh0vn+wdQk/Ik72qz9GQ
         xzeL35YwHHY+2b/GQo0WYtEFkpVR2LGscjClAPD9bYifYMOcMF3NKGbCRzGoeyfmeRO5
         CPwgKgd7xjLAsxFY4KXirV40Vp3S4W41n4ibjd4e+e0VKiCWUDaNl9TOttBPWOgRC7KX
         n73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=Pi6lAfisQE4cvq4pCvRbgpdY4izOS8pOwDZYv8Py2yI=;
        b=PyqL6wbWcR2wlrJ6LRaKdXv+mXMSrYjOjt0DT2pdpYoXg+v8OwZq1IO90ae3w60FnM
         akW7CnRlo3axmSpl190EKXuxhrdgmyNIXD/HMQhI8JOmCfDY3qB+8lpkFYlOuB2lT9Ik
         hpVLP24N/cl2F6azp1w2kf9Cl0jEoC75XK7i7ia1bNu3FwmjItfnt9gVezsdUWzPHW9m
         dUzvRRVztMLeNK3JlluypBYhXqf0eRU9+o1gvOrE/yn9lGs9/RtozyarNV6zk+gmdyqD
         qEx7uSoIF7QEy/3ZFz3WJO8nSYqcYRB7JKyLol9lYqrm1GSEmInG+fbxLV1AIWBdGm47
         H3NA==
X-Gm-Message-State: AA+aEWZS29pimcu1OElA5UX8hsYWJFB0+A9yH7bPirhaYXC/Q4d9AeiC
        1QlMoC8zC8zQlPcmYN6bJjdjjjnB
X-Google-Smtp-Source: AFSGD/XZnJp4RZI1rLkdhg/L8muK5lUYpJbX3YJQv8k26b2jQRLi6Krb9j9izg/1nIfQZjlbR2WPNw==
X-Received: by 2002:a17:906:a281:: with SMTP id i1-v6mr32721768ejz.86.1546443510868;
        Wed, 02 Jan 2019 07:38:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g13-v6sm12846208ejr.1.2019.01.02.07.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 07:38:29 -0800 (PST)
Date:   Wed, 02 Jan 2019 07:38:29 -0800 (PST)
X-Google-Original-Date: Wed, 02 Jan 2019 15:38:21 GMT
Message-Id: <pull.101.v17.git.gitgitgadget@gmail.com>
In-Reply-To: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
From:   "Tanushree Tumane via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v17 0/7] git bisect: convert from shell to C
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since Pranit's v16:
===========================

bisect--helper: bisect_reset shell function in C
================================================

 * The return !printf(...); construct was considered unsafe and disentangled
   into printf(...); return 0;
 * It is more elegant to release branch and argv first, and then return
   error(...) than to error(...); release branch; clear argv; return -1;
 * Prefix !! to bisect_reset(...) function call in cmd_bisect__helper(...) 
   because its return value will be given to exit()

bisect--helper: bisect_write shell function in C
================================================

 * The option [--no-log] is passed before <state>.
 * Remove const from struct bisect_terms variables because const pointers
   refers to memory owned by another code path.
 * Use FREE_AND_NULL(...) in free_terms(...).
 * It makes more sense to free terms before set in set_terms(...) to avoid
   memory leak.
 * Remove fail: retval = -1; for cleaner code flow, replace goto fail; with 
   retval = -1; goto finish; or retval = error(...); goto finish;
 * It is more consistent to introduce --no-log as option like --no-checkout.
 * Initialize struct bisect_terms terms in cmd_bisect__helper(...).
 * The return res; in cmd_bisect__helper(...) may return -1, so prefixed !! 
   to handle such cases.

bisect--helper: check_and_set_terms shell function in C
=======================================================

 * free_terms() before set_terms() is obsolete as set_terms() frees terms
   before set.

bisect--helper: bisect_next_check shell function in C
=====================================================

 * [<term>] is first argument of bisect-next-check.
 * vocab_good and vocab_bad for easier readability.
 * Declare *_warning char pointers.
 * Remove fail: label, its only job was to set retval = -1;.

bisect--helper: get_terms & bisect_terms shell function in C
============================================================

 * Remove fail: label, its only job was to set res = -1;.
 * Parse the argv in cmd_bisect__helper() and pass option to bisect_terms().

bisect--helper: bisect_start shell function partially in C
==========================================================

 * Remove fail: label, its only job was to set retval = -1;.
 * Spell correction unrecognised to unrecognized.
 * if (revs.nr) must_write_terms = 1; is more readable than must_write_terms
   |= !!revs.nr;.
 * error() messages starts with small letters.
 * sha1_to_hex() is old practice.
 * sq_quote_argv() now requires only two args.
 * Instead of nesting ifs, use &&.

Pranit Bauva (7):
  bisect--helper: `bisect_reset` shell function in C
  bisect--helper: `bisect_write` shell function in C
  wrapper: move is_empty_file() and rename it as
    is_empty_or_missing_file()
  bisect--helper: `check_and_set_terms` shell function in C
  bisect--helper: `bisect_next_check` shell function in C
  bisect--helper: `get_terms` & `bisect_terms` shell function in C
  bisect--helper: `bisect_start` shell function partially in C

 builtin/am.c                |  20 +-
 builtin/bisect--helper.c    | 563 +++++++++++++++++++++++++++++++++++-
 cache.h                     |   3 +
 git-bisect.sh               | 314 ++------------------
 t/t6030-bisect-porcelain.sh |   2 +-
 wrapper.c                   |  13 +
 6 files changed, 595 insertions(+), 320 deletions(-)


base-commit: 7f4e64169352e03476b0ea64e7e2973669e491a2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-101%2Ftanushree27%2Fgit-bisect_part2_fixup-v17
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-101/tanushree27/git-bisect_part2_fixup-v17
Pull-Request: https://github.com/gitgitgadget/git/pull/101

Range-diff vs v16:

 1:  f1e89ba517 ! 1:  338ebdc97a bisect--helper: `bisect_reset` shell function in C
     @@ -16,8 +16,9 @@
      
          Mentored-by: Lars Schneider <larsxschneider@gmail.com>
          Mentored-by: Christian Couder <chriscool@tuxfamily.org>
     +    Mentored by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
          Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     +    Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
      
       diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
       --- a/builtin/bisect--helper.c
     @@ -53,8 +54,10 @@
      +	struct strbuf branch = STRBUF_INIT;
      +
      +	if (!commit) {
     -+		if (strbuf_read_file(&branch, git_path_bisect_start(), 0) < 1)
     -+			return !printf(_("We are not bisecting.\n"));
     ++		if (strbuf_read_file(&branch, git_path_bisect_start(), 0) < 1) {
     ++			printf(_("We are not bisecting.\n"));
     ++			return 0;
     ++		}
      +		strbuf_rtrim(&branch);
      +	} else {
      +		struct object_id oid;
     @@ -69,11 +72,11 @@
      +
      +		argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
      +		if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
     -+			error(_("Could not check out original HEAD '%s'. Try "
     -+				"'git bisect reset <commit>'."), branch.buf);
      +			strbuf_release(&branch);
      +			argv_array_clear(&argv);
     -+			return -1;
     ++			return error(_("could not check out original"
     ++				       " HEAD '%s'. Try 'git bisect"
     ++				       "reset <commit>'."), branch.buf);
      +		}
      +		argv_array_clear(&argv);
      +	}
     @@ -110,7 +113,7 @@
      +	case BISECT_RESET:
      +		if (argc > 1)
      +			return error(_("--bisect-reset requires either no argument or a commit"));
     -+		return bisect_reset(argc ? argv[0] : NULL);
     ++		return !!bisect_reset(argc ? argv[0] : NULL);
       	default:
       		return error("BUG: unknown subcommand '%d'", cmdmode);
       	}
 2:  da4ac60ad4 ! 2:  7d6291d9dd bisect--helper: `bisect_write` shell function in C
     @@ -27,8 +27,9 @@
          Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
          Mentored-by: Lars Schneider <larsxschneider@gmail.com>
          Mentored-by: Christian Couder <chriscool@tuxfamily.org>
     +    Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
          Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     +    Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
      
       diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
       --- a/builtin/bisect--helper.c
     @@ -44,27 +45,27 @@
       	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
       	N_("git bisect--helper --bisect-clean-state"),
       	N_("git bisect--helper --bisect-reset [<commit>]"),
     -+	N_("git bisect--helper --bisect-write <state> <revision> <good_term> <bad_term> [<nolog>]"),
     ++	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
       	NULL
       };
       
      +struct bisect_terms {
     -+	const char *term_good;
     -+	const char *term_bad;
     ++	char *term_good;
     ++	char *term_bad;
      +};
      +
      +static void free_terms(struct bisect_terms *terms)
      +{
     -+	if (!terms->term_good)
     -+		free((void *) terms->term_good);
     -+	if (!terms->term_bad)
     -+		free((void *) terms->term_bad);
     ++	FREE_AND_NULL(terms->term_good);
     ++	FREE_AND_NULL(terms->term_bad);
      +}
      +
      +static void set_terms(struct bisect_terms *terms, const char *bad,
      +		      const char *good)
      +{
     ++	free((void *)terms->term_good);
      +	terms->term_good = xstrdup(good);
     ++	free((void *)terms->term_bad);
      +	terms->term_bad = xstrdup(bad);
      +}
      +
     @@ -105,35 +106,33 @@
      +	} else if (one_of(state, terms->term_good, "skip", NULL)) {
      +		strbuf_addf(&tag, "refs/bisect/%s-%s", state, rev);
      +	} else {
     -+		error(_("Bad bisect_write argument: %s"), state);
     -+		goto fail;
     ++		retval = error(_("Bad bisect_write argument: %s"), state);
     ++		goto finish;
      +	}
      +
      +	if (get_oid(rev, &oid)) {
     -+		error(_("couldn't get the oid of the rev '%s'"), rev);
     -+		goto fail;
     ++		retval = error(_("couldn't get the oid of the rev '%s'"), rev);
     ++		goto finish;
      +	}
      +
      +	if (update_ref(NULL, tag.buf, &oid, NULL, 0,
     -+		       UPDATE_REFS_MSG_ON_ERR))
     -+		goto fail;
     ++		       UPDATE_REFS_MSG_ON_ERR)) {
     ++		retval = -1;
     ++		goto finish;
     ++	}
      +
      +	fp = fopen(git_path_bisect_log(), "a");
      +	if (!fp) {
     -+		error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
     -+		goto fail;
     ++		retval = error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
     ++		goto finish;
      +	}
      +
     -+	commit = lookup_commit_reference(&oid);
     ++	commit = lookup_commit_reference(the_repository, &oid);
      +	log_commit(fp, "%s", state, commit);
      +
      +	if (!nolog)
      +		fprintf(fp, "git bisect %s %s\n", state, rev);
      +
     -+	goto finish;
     -+
     -+fail:
     -+	retval = -1;
      +finish:
      +	if (fp)
      +		fclose(fp);
     @@ -153,7 +152,7 @@
      +		BISECT_WRITE
       	} cmdmode = 0;
      -	int no_checkout = 0;
     -+	int no_checkout = 0, res = 0;
     ++	int no_checkout = 0, res = 0, nolog = 0;
       	struct option options[] = {
       		OPT_CMDMODE(0, "next-all", &cmdmode,
       			 N_("perform 'git bisect next'"), NEXT_ALL),
     @@ -162,31 +161,24 @@
       		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
       			 N_("reset the bisection state"), BISECT_RESET),
      +		OPT_CMDMODE(0, "bisect-write", &cmdmode,
     -+			 N_("update the refs according to the bisection state and may write it to BISECT_LOG"), BISECT_WRITE),
     ++			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
       		OPT_BOOL(0, "no-checkout", &no_checkout,
       			 N_("update BISECT_HEAD instead of checking out the current commit")),
     ++		OPT_BOOL(0, "no-log", &nolog,
     ++			 N_("no log for BISECT_WRITE ")),
       		OPT_END()
       	};
     -+	struct bisect_terms terms;
     ++	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
       
       	argc = parse_options(argc, argv, prefix, options,
       			     git_bisect_helper_usage, 0);
     -@@
     - 		usage_with_options(git_bisect_helper_usage, options);
     - 
     - 	switch (cmdmode) {
     -+	int nolog;
     - 	case NEXT_ALL:
     - 		return bisect_next_all(prefix, no_checkout);
     - 	case WRITE_TERMS:
      @@
       		if (argc > 1)
       			return error(_("--bisect-reset requires either no argument or a commit"));
     - 		return bisect_reset(argc ? argv[0] : NULL);
     + 		return !!bisect_reset(argc ? argv[0] : NULL);
      +	case BISECT_WRITE:
      +		if (argc != 4 && argc != 5)
      +			return error(_("--bisect-write requires either 4 or 5 arguments"));
     -+		nolog = (argc == 5) && !strcmp(argv[4], "nolog");
      +		set_terms(&terms, argv[3], argv[2]);
      +		res = bisect_write(argv[0], argv[1], &terms, nolog);
      +		break;
     @@ -195,7 +187,7 @@
       	}
      -	return 0;
      +	free_terms(&terms);
     -+	return res;
     ++	return !!res;
       }
      
       diff --git a/git-bisect.sh b/git-bisect.sh
 3:  8874ae1a3a ! 3:  5f24e7cef2 wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
     @@ -9,14 +9,13 @@
          Mentored-by: Lars Schneider <larsxschneider@gmail.com>
          Mentored-by: Christian Couder <chriscool@tuxfamily.org>
          Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       diff --git a/builtin/am.c b/builtin/am.c
       --- a/builtin/am.c
       +++ b/builtin/am.c
      @@
     - #include "string-list.h"
       #include "packfile.h"
     + #include "repository.h"
       
      -/**
      - * Returns 1 if the file is empty or does not exist, 0 otherwise.
     @@ -61,7 +60,7 @@
       +++ b/cache.h
      @@
        */
     - void safe_create_dir(const char *dir, int share);
     + extern int print_sha1_ellipsis(void);
       
      +/* Return 1 if the file is empty or does not exists, 0 otherwise. */
      +extern int is_empty_or_missing_file(const char *filename);
 4:  7e9fdedc45 ! 4:  4e97a08a10 bisect--helper: `check_and_set_terms` shell function in C
     @@ -20,8 +20,9 @@
      
          Mentored-by: Lars Schneider <larsxschneider@gmail.com>
          Mentored-by: Christian Couder <chriscool@tuxfamily.org>
     +    Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
          Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     +    Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
      
       diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
       --- a/builtin/bisect--helper.c
     @@ -29,7 +30,7 @@
      @@
       	N_("git bisect--helper --bisect-clean-state"),
       	N_("git bisect--helper --bisect-reset [<commit>]"),
     - 	N_("git bisect--helper --bisect-write <state> <revision> <good_term> <bad_term> [<nolog>]"),
     + 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
      +	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
       	NULL
       };
     @@ -53,12 +54,10 @@
      +
      +	if (!has_term_file) {
      +		if (one_of(cmd, "bad", "good", NULL)) {
     -+			free_terms(terms);
      +			set_terms(terms, "bad", "good");
      +			return write_terms(terms->term_bad, terms->term_good);
      +		}
     -+		else if (one_of(cmd, "new", "old", NULL)) {
     -+			free_terms(terms);
     ++		if (one_of(cmd, "new", "old", NULL)) {
      +			set_terms(terms, "new", "old");
      +			return write_terms(terms->term_bad, terms->term_good);
      +		}
     @@ -78,17 +77,17 @@
      +		BISECT_WRITE,
      +		CHECK_AND_SET_TERMS
       	} cmdmode = 0;
     - 	int no_checkout = 0, res = 0;
     + 	int no_checkout = 0, res = 0, nolog = 0;
       	struct option options[] = {
      @@
       			 N_("reset the bisection state"), BISECT_RESET),
       		OPT_CMDMODE(0, "bisect-write", &cmdmode,
     - 			 N_("update the refs according to the bisection state and may write it to BISECT_LOG"), BISECT_WRITE),
     + 			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
      +		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
      +			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
       		OPT_BOOL(0, "no-checkout", &no_checkout,
       			 N_("update BISECT_HEAD instead of checking out the current commit")),
     - 		OPT_END()
     + 		OPT_BOOL(0, "no-log", &nolog,
      @@
       		set_terms(&terms, argv[3], argv[2]);
       		res = bisect_write(argv[0], argv[1], &terms, nolog);
 5:  ca12543868 ! 5:  e9f400b1d6 bisect--helper: `bisect_next_check` shell function in C
     @@ -17,8 +17,9 @@
          Helped-by: Stephan Beyer <s-beyer@gmx.net>
          Mentored-by: Lars Schneider <larsxschneider@gmail.com>
          Mentored-by: Christian Couder <chriscool@tuxfamily.org>
     +    Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
          Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     +    Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
      
       diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
       --- a/builtin/bisect--helper.c
     @@ -33,9 +34,9 @@
       static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
      @@
       	N_("git bisect--helper --bisect-reset [<commit>]"),
     - 	N_("git bisect--helper --bisect-write <state> <revision> <good_term> <bad_term> [<nolog>]"),
     + 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
       	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
     -+	N_("git bisect--helper --bisect-next-check [<term>] <good_term> <bad_term>"),
     ++	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
       	NULL
       };
       
     @@ -43,10 +44,8 @@
       	terms->term_bad = xstrdup(bad);
       }
       
     -+static const char *voc[] = {
     -+	"bad|new",
     -+	"good|old"
     -+};
     ++static const char *vocab_bad = "bad|new";
     ++static const char *vocab_good = "good|old";
      +
       /*
        * Check whether the string `term` belongs to the set of strings
     @@ -63,6 +62,15 @@
      +	return 1;
      +}
      +
     ++static const char *need_bad_and_good_revision_warning =
     ++	N_("You need to give me at least one %s and %s revision.\n"
     ++	   "You can use \"git bisect %s\" and \"git bisect %s\" for that.");
     ++
     ++static const char *need_bisect_start_warning =
     ++	N_("You need to start by \"git bisect start\".\n"
     ++	   "You then need to give me at least one %s and %s revision.\n"
     ++	   "You can use \"git bisect %s\" and \"git bisect %s\" for that.");
     ++
      +static int bisect_next_check(const struct bisect_terms *terms,
      +			     const char *current_term)
      +{
     @@ -79,18 +87,19 @@
      +	if (!missing_good && !missing_bad)
      +		goto finish;
      +
     -+	if (!current_term)
     -+		goto fail;
     ++	if (!current_term) {
     ++		retval = -1;
     ++		goto finish;
     ++	}
      +
     -+	if (missing_good && !missing_bad && current_term &&
     ++	if (missing_good && !missing_bad &&
      +	    !strcmp(current_term, terms->term_good)) {
      +		char *yesno;
      +		/*
      +		 * have bad (or new) but not good (or old). We could bisect
      +		 * although this is less optimum.
      +		 */
     -+		fprintf(stderr, _("Warning: bisecting only with a %s commit\n"),
     -+			terms->term_bad);
     ++		warning(_("bisecting only with a %s commit"), terms->term_bad);
      +		if (!isatty(0))
      +			goto finish;
      +		/*
     @@ -100,28 +109,17 @@
      +		 */
      +		yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
      +		if (starts_with(yesno, "N") || starts_with(yesno, "n"))
     -+			goto fail;
     -+
     ++			retval = -1;
      +		goto finish;
      +	}
      +	if (!is_empty_or_missing_file(git_path_bisect_start())) {
     -+		error(_("You need to give me at least one %s and "
     -+			"%s revision. You can use \"git bisect %s\" "
     -+			"and \"git bisect %s\" for that.\n"),
     -+			voc[0], voc[1], voc[0], voc[1]);
     -+		goto fail;
     ++		retval = error(_(need_bad_and_good_revision_warning),
     ++			       vocab_bad, vocab_good, vocab_bad, vocab_good);
      +	} else {
     -+		error(_("You need to start by \"git bisect start\". You "
     -+			"then need to give me at least one %s and %s "
     -+			"revision. You can use \"git bisect %s\" and "
     -+			"\"git bisect %s\" for that.\n"),
     -+			voc[1], voc[0], voc[1], voc[0]);
     -+		goto fail;
     ++		retval = error(_(need_bisect_start_warning),
     ++			       vocab_good, vocab_bad, vocab_good, vocab_bad);
      +	}
     -+	goto finish;
      +
     -+fail:
     -+	retval = -1;
      +finish:
      +	free((void *) good_glob);
      +	free((void *) bad_ref);
     @@ -139,17 +137,17 @@
      +		CHECK_AND_SET_TERMS,
      +		BISECT_NEXT_CHECK
       	} cmdmode = 0;
     - 	int no_checkout = 0, res = 0;
     + 	int no_checkout = 0, res = 0, nolog = 0;
       	struct option options[] = {
      @@
     - 			 N_("update the refs according to the bisection state and may write it to BISECT_LOG"), BISECT_WRITE),
     + 			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),
       		OPT_CMDMODE(0, "check-and-set-terms", &cmdmode,
       			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
      +		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
      +			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
       		OPT_BOOL(0, "no-checkout", &no_checkout,
       			 N_("update BISECT_HEAD instead of checking out the current commit")),
     - 		OPT_END()
     + 		OPT_BOOL(0, "no-log", &nolog,
      @@
       		set_terms(&terms, argv[2], argv[1]);
       		res = check_and_set_terms(&terms, argv[0]);
     @@ -245,8 +243,8 @@
      -	bisect_next_check fail
      +	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
       
     - 	while true
     - 	do
     + 	test -n "$*" || die "$(gettext "bisect run failed: no command provided.")"
     + 
      @@
       	fi
       }
 6:  db7b281c8c ! 6:  f2b1706e5b bisect--helper: `get_terms` & `bisect_terms` shell function in C
     @@ -14,18 +14,24 @@
          Also use error() to report "no terms defined" and accordingly change the
          test in t6030.
      
     +    We need to use PARSE_OPT_KEEP_UNKNOWN here to allow for parameters that
     +    look like options (e.g --term-good) but should not be parsed by
     +    cmd_bisect__helper(). This change is safe because all other cmdmodes have
     +    strict argc checks already.
     +
          Mentored-by: Lars Schneider <larsxschneider@gmail.com>
          Mentored-by: Christian Couder <chriscool@tuxfamily.org>
     +    Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
          Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     +    Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
      
       diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
       --- a/builtin/bisect--helper.c
       +++ b/builtin/bisect--helper.c
      @@
     - 	N_("git bisect--helper --bisect-write <state> <revision> <good_term> <bad_term> [<nolog>]"),
     + 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
       	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
     - 	N_("git bisect--helper --bisect-next-check [<term>] <good_term> <bad_term>"),
     + 	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
      +	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
       	NULL
       };
     @@ -41,18 +47,17 @@
      +	int res = 0;
      +
      +	fp = fopen(git_path_bisect_terms(), "r");
     -+	if (!fp)
     -+		goto fail;
     ++	if (!fp) {
     ++		res = -1;
     ++		goto finish;
     ++	}
      +
      +	free_terms(terms);
      +	strbuf_getline_lf(&str, fp);
      +	terms->term_bad = strbuf_detach(&str, NULL);
      +	strbuf_getline_lf(&str, fp);
      +	terms->term_good = strbuf_detach(&str, NULL);
     -+	goto finish;
      +
     -+fail:
     -+	res = -1;
      +finish:
      +	if (fp)
      +		fclose(fp);
     @@ -60,32 +65,26 @@
      +	return res;
      +}
      +
     -+static int bisect_terms(struct bisect_terms *terms, const char **argv, int argc)
     ++static int bisect_terms(struct bisect_terms *terms, const char *option)
      +{
     -+	int i;
     -+
      +	if (get_terms(terms))
      +		return error(_("no terms defined"));
      +
     -+	if (argc > 1)
     -+		return error(_("--bisect-term requires exactly one argument"));
     -+
     -+	if (argc == 0)
     -+		return !printf(_("Your current terms are %s for the old state\n"
     -+				 "and %s for the new state.\n"),
     -+				 terms->term_good, terms->term_bad);
     -+
     -+	for (i = 0; i < argc; i++) {
     -+		if (!strcmp(argv[i], "--term-good"))
     -+			printf(_("%s\n"), terms->term_good);
     -+		else if (!strcmp(argv[i], "--term-bad"))
     -+			printf(_("%s\n"), terms->term_bad);
     -+		else
     -+			error(_("BUG: invalid argument %s for 'git bisect terms'.\n"
     -+				  "Supported options are: "
     -+				  "--term-good|--term-old and "
     -+				  "--term-bad|--term-new."), argv[i]);
     ++	if (option == NULL) {
     ++		printf(_("Your current terms are %s for the old state\n"
     ++			 "and %s for the new state.\n"),
     ++		       terms->term_good, terms->term_bad);
     ++		return 0;
      +	}
     ++	if (one_of(option, "--term-good", "--term-old", NULL))
     ++		printf("%s\n", terms->term_good);
     ++	else if (one_of(option, "--term-bad", "--term-new", NULL))
     ++		printf("%s\n", terms->term_bad);
     ++	else
     ++		return error(_("invalid argument %s for 'git bisect terms'.\n"
     ++			       "Supported options are: "
     ++			       "--term-good|--term-old and "
     ++			       "--term-bad|--term-new."), option);
      +
      +	return 0;
      +}
     @@ -101,7 +100,7 @@
      +		BISECT_NEXT_CHECK,
      +		BISECT_TERMS
       	} cmdmode = 0;
     - 	int no_checkout = 0, res = 0;
     + 	int no_checkout = 0, res = 0, nolog = 0;
       	struct option options[] = {
      @@
       			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
     @@ -111,9 +110,9 @@
      +			 N_("print out the bisect terms"), BISECT_TERMS),
       		OPT_BOOL(0, "no-checkout", &no_checkout,
       			 N_("update BISECT_HEAD instead of checking out the current commit")),
     - 		OPT_END()
     + 		OPT_BOOL(0, "no-log", &nolog,
      @@
     - 	struct bisect_terms terms;
     + 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
       
       	argc = parse_options(argc, argv, prefix, options,
      -			     git_bisect_helper_usage, 0);
     @@ -128,7 +127,7 @@
      +	case BISECT_TERMS:
      +		if (argc > 1)
      +			return error(_("--bisect-terms requires 0 or 1 argument"));
     -+		res = bisect_terms(&terms, argv, argc);
     ++		res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
      +		break;
       	default:
       		return error("BUG: unknown subcommand '%d'", cmdmode);
     @@ -142,7 +141,7 @@
       			git bisect--helper --bisect-write "$command" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit;;
       		terms)
      -			bisect_terms $rev ;;
     -+			git bisect--helper --bisect-terms $rev  || exit;;
     ++			git bisect--helper --bisect-terms $rev || exit;;
       		*)
       			die "$(gettext "?? what are you talking about?")" ;;
       		esac
 7:  e14e913797 ! 7:  87a033b858 bisect--helper: `bisect_start` shell function partially in C
     @@ -6,7 +6,7 @@
          `bisect-start` subcommand to `git bisect--helper` to call it from
          git-bisect.sh .
      
     -    The last part is not converted because it calls another shell function
     +    The last part is not converted because it calls another shell function.
          `bisect_start` shell function will be completed after the `bisect_next`
          shell function is ported in C.
      
     @@ -18,12 +18,17 @@
          Also introduce a method `bisect_append_log_quoted` to keep things short
          and crisp.
      
     +    Note that we are a bit lax about command-line parsing because the helper
     +    is not supposed to be called by the user directly (but only from the git
     +    bisect script).
     +
          Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
          Helped-by: Stephan Beyer <s-beyer@gmx.net>
          Mentored-by: Lars Schneider <larsxschneider@gmail.com>
          Mentored-by: Christian Couder <chriscool@tuxfamily.org>
     +    Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
          Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     +    Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
      
       diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
       --- a/builtin/bisect--helper.c
     @@ -47,10 +52,10 @@
       	N_("git bisect--helper --next-all [--no-checkout]"),
      @@
       	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
     - 	N_("git bisect--helper --bisect-next-check [<term>] <good_term> <bad_term>"),
     + 	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
       	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
      +	N_("git bisect--helper --bisect-start [--term-{old,good}=<term> --term-{new,bad}=<term>]"
     -+					      "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
     ++					     "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
       	NULL
       };
       
     @@ -67,17 +72,15 @@
      +	if (!fp)
      +		return -1;
      +
     -+	if (fprintf(fp, "git bisect start") < 1)
     -+		goto fail;
     ++	if (fprintf(fp, "git bisect start") < 1) {
     ++		retval = -1;
     ++		goto finish;
     ++	}
      +
     -+	sq_quote_argv(&orig_args, argv, 0);
     ++	sq_quote_argv(&orig_args, argv);
      +	if (fprintf(fp, "%s\n", orig_args.buf) < 1)
     -+		goto fail;
     ++		retval = -1;
      +
     -+	goto finish;
     -+
     -+fail:
     -+	retval = -1;
      +finish:
      +	fclose(fp);
      +	strbuf_release(&orig_args);
     @@ -138,7 +141,7 @@
      +			terms->term_bad = xstrdup(arg);
      +		} else if (starts_with(arg, "--") &&
      +			 !one_of(arg, "--term-good", "--term-bad", NULL)) {
     -+			return error(_("unrecognised option: '%s'"), arg);
     ++			return error(_("unrecognized option: '%s'"), arg);
      +		} else {
      +			char *commit_id = xstrfmt("%s^{commit}", arg);
      +			if (get_oid(commit_id, &oid) && has_double_dash)
     @@ -157,7 +160,8 @@
      +	 * set references named with the default terms, and won't be able
      +	 * to change afterwards.
      +	 */
     -+	must_write_terms |= !!revs.nr;
     ++	if (revs.nr)
     ++		must_write_terms = 1;
      +	for (i = 0; i < revs.nr; i++) {
      +		if (bad_seen) {
      +			string_list_append(&states, terms->term_good);
     @@ -173,7 +177,7 @@
      +	head = resolve_ref_unsafe("HEAD", 0, &head_oid, &flags);
      +	if (!head)
      +		if (get_oid("HEAD", &head_oid))
     -+			return error(_("Bad HEAD - I need a HEAD"));
     ++			return error(_("bad HEAD - I need a HEAD"));
      +
      +	/*
      +	 * Check if we are bisecting
     @@ -188,10 +192,11 @@
      +			argv_array_pushl(&argv, "checkout", start_head.buf,
      +					 "--", NULL);
      +			if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
     -+				error(_("checking out '%s' failed. Try 'git "
     -+					"bisect start <valid-branch>'."),
     -+				      start_head.buf);
     -+				goto fail;
     ++				retval = error(_("checking out '%s' failed."
     ++						 " Try 'git bisect start "
     ++						 "<valid-branch>'."),
     ++					       start_head.buf);
     ++				goto finish;
      +			}
      +		}
      +	} else {
     @@ -199,7 +204,7 @@
      +		if (!get_oid(head, &head_oid) &&
      +		    !starts_with(head, "refs/heads/")) {
      +			strbuf_reset(&start_head);
     -+			strbuf_addstr(&start_head, sha1_to_hex(head_oid.hash));
     ++			strbuf_addstr(&start_head, oid_to_hex(&head_oid));
      +		} else if (!get_oid(head, &head_oid) &&
      +			   skip_prefix(head, "refs/heads/", &head)) {
      +			/*
     @@ -211,7 +216,7 @@
      +				return error(_("won't bisect on cg-seek'ed tree"));
      +			strbuf_addstr(&start_head, head);
      +		} else {
     -+			return error(_("Bad HEAD - strange symbolic ref"));
     ++			return error(_("bad HEAD - strange symbolic ref"));
      +		}
      +	}
      +
     @@ -236,31 +241,33 @@
      +	if (no_checkout) {
      +		get_oid(start_head.buf, &oid);
      +		if (update_ref(NULL, "BISECT_HEAD", &oid, NULL, 0,
     -+			       UPDATE_REFS_MSG_ON_ERR))
     -+			goto fail;
     ++			       UPDATE_REFS_MSG_ON_ERR)) {
     ++			retval = -1;
     ++			goto finish;
     ++		}
      +	}
      +
      +	if (pathspec_pos < argc - 1)
     -+		sq_quote_argv(&bisect_names, argv + pathspec_pos, 0);
     ++		sq_quote_argv(&bisect_names, argv + pathspec_pos);
      +	write_file(git_path_bisect_names(), "%s\n", bisect_names.buf);
      +
      +	for (i = 0; i < states.nr; i++)
      +		if (bisect_write(states.items[i].string,
     -+				 revs.items[i].string, terms, 1))
     -+			goto fail;
     ++				 revs.items[i].string, terms, 1)) {
     ++			retval = -1;
     ++			goto finish;
     ++		}
      +
     -+	if (must_write_terms)
     -+		if (write_terms(terms->term_bad, terms->term_good))
     -+			goto fail;
     ++	if (must_write_terms && write_terms(terms->term_bad,
     ++					    terms->term_good)) {
     ++		retval = -1;
     ++		goto finish;
     ++	}
      +
      +	retval = bisect_append_log_quoted(argv);
      +	if (retval)
     -+		goto fail;
     -+
     -+	goto finish;
     ++		retval = -1;
      +
     -+fail:
     -+	retval = -1;
      +finish:
      +	string_list_clear(&revs, 0);
      +	string_list_clear(&states, 0);
     @@ -280,7 +287,7 @@
      +		BISECT_TERMS,
      +		BISECT_START
       	} cmdmode = 0;
     - 	int no_checkout = 0, res = 0;
     + 	int no_checkout = 0, res = 0, nolog = 0;
       	struct option options[] = {
      @@
       			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
     @@ -290,9 +297,9 @@
      +			 N_("start the bisect session"), BISECT_START),
       		OPT_BOOL(0, "no-checkout", &no_checkout,
       			 N_("update BISECT_HEAD instead of checking out the current commit")),
     - 		OPT_END()
     + 		OPT_BOOL(0, "no-log", &nolog,
      @@
     - 	struct bisect_terms terms;
     + 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
       
       	argc = parse_options(argc, argv, prefix, options,
      -			     git_bisect_helper_usage, PARSE_OPT_KEEP_UNKNOWN);
     @@ -303,7 +310,7 @@
       		usage_with_options(git_bisect_helper_usage, options);
      @@
       			return error(_("--bisect-terms requires 0 or 1 argument"));
     - 		res = bisect_terms(&terms, argv, argc);
     + 		res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
       		break;
      +	case BISECT_START:
      +		set_terms(&terms, "bad", "good");
 8:  161bbaced1 < -:  ---------- t6030: make various test to pass GETTEXT_POISON tests

-- 
gitgitgadget
