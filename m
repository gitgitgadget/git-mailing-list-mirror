Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 854721F454
	for <e@80x24.org>; Mon, 11 Nov 2019 21:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfKKV2c (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 16:28:32 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:36770 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfKKV2X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 16:28:23 -0500
Received: by mail-wm1-f49.google.com with SMTP id c22so807199wmd.1
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 13:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/PO5ldRR2YoiDCqj0UPTwyP6OQfpd5MeTgzqeMp74EM=;
        b=icVS34Vbhml2tlfbuXA6zO0uyUN21Qfj23ZQ/JjcLKECUwCfiUvs3mKJpm071JjpGX
         tTVHA928DD68LBFC9OL0UJBTmK+bDBnushhOvXQWPS9mpECsodTtD0pVowkCREYe0djc
         RAux5wU7Ec6gQbAsxXI0Vmn+iqJOD+wzmrsIIlUyICG1KXhkVc34fqcike8Ofv04R7wU
         DBP7PdLYCtjR9qa/hOg8L/319sCMeYl03OxzhmtVY/SXqRKqrvOGK3hwFp7ysi+SAqA4
         DnYHshAY+JGlbcXttGUgSda1S+sOZsqv7l+ag7REhBxPv4az4LaIYD/DYvHjD1M5/u9J
         doYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/PO5ldRR2YoiDCqj0UPTwyP6OQfpd5MeTgzqeMp74EM=;
        b=pvSoQ2oltWP/F74zNAzSV0MgYJGIHbmOYxh7woZuLq5aoHZI3AoCkJW8xIDzCOiWa+
         2ZlQCb15OASTBDaSmAJLmQREX8F607QQNznWVzIT2pkSgcDEUC6iILSOBMlc6TaAeuel
         J6a/1WQsoczs2xcaahD0fSU0m8R909qRfQoQmjRRjrXwlN5+TZlQQAwvA3kg9bh5/Lsf
         Wc9ruJhPuDgXeAXuP+oJ9pWNzAkszjqYggqh9iH91baN3Y3I4adXLcsq74HgDEvJM+kF
         oUGpyOl/8zpQ7+gGnxO7Ju48atgiSw8pluNe74ckAgE0xgRmwVtOvfwqKu88/eRm0AN3
         Grqw==
X-Gm-Message-State: APjAAAXtsktob7Lpxi8jHH7O4H88E6CuAMRFUto6phLpRhF83N9IiTJF
        WY9oKCSUA1hjFTMLLvvt0rMaJkXV
X-Google-Smtp-Source: APXvYqy1IA2Z+8ylTXAc6E6w38ErbMH3VBrthQL3dyrl6NizQyhwqIoLk4Aw0FY4jZ5ysTBDG16yTw==
X-Received: by 2002:a05:600c:3cc:: with SMTP id z12mr918763wmd.151.1573507697997;
        Mon, 11 Nov 2019 13:28:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o189sm1302455wmo.23.2019.11.11.13.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 13:28:17 -0800 (PST)
Message-Id: <1dca77cd27d3fbbe924102b1872047f747f78f73.1573507684.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
References: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
        <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 Nov 2019 21:27:58 +0000
Subject: [PATCH v3 15/21] parse-options: move doc to parse-options.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Move the documentation from Documentation/technical/api-parse-options.txt
to parse-options.h as it's easier for the developers to find the usage
information beside the code instead of looking for it in another doc file.

Documentation/technical/api-parse-options.txt is removed because the
information it has is now redundant and it'll be hard to keep it up to
date and synchronized with the documentation in the header file.

Documentation/MyFirstContribution.txt now link
to parse-options.h instead of Documentation/technical/api-parse-options.txt for
details about parsing options.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/MyFirstContribution.txt         |   2 +-
 Documentation/technical/api-parse-options.txt | 313 -----------------
 parse-options.h                               | 329 ++++++++++++++++++
 3 files changed, 330 insertions(+), 314 deletions(-)
 delete mode 100644 Documentation/technical/api-parse-options.txt

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 5e9b808f5f..a2a91d92e2 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -487,7 +487,7 @@ Try and run `./bin-wrappers/git psuh -h`. Your command should crash at the end.
 That's because `-h` is a special case which your command should handle by
 printing usage.
 
-Take a look at `Documentation/technical/api-parse-options.txt`. This is a handy
+Take a look at `parse-options.h`. This is a handy
 tool for pulling out options you need to be able to handle, and it takes a
 usage string.
 
diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
deleted file mode 100644
index 2e2e7c10c6..0000000000
--- a/Documentation/technical/api-parse-options.txt
+++ /dev/null
@@ -1,313 +0,0 @@
-parse-options API
-=================
-
-The parse-options API is used to parse and massage options in Git
-and to provide a usage help with consistent look.
-
-Basics
-------
-
-The argument vector `argv[]` may usually contain mandatory or optional
-'non-option arguments', e.g. a filename or a branch, and 'options'.
-Options are optional arguments that start with a dash and
-that allow to change the behavior of a command.
-
-* There are basically three types of options:
-  'boolean' options,
-  options with (mandatory) 'arguments' and
-  options with 'optional arguments'
-  (i.e. a boolean option that can be adjusted).
-
-* There are basically two forms of options:
-  'Short options' consist of one dash (`-`) and one alphanumeric
-  character.
-  'Long options' begin with two dashes (`--`) and some
-  alphanumeric characters.
-
-* Options are case-sensitive.
-  Please define 'lower-case long options' only.
-
-The parse-options API allows:
-
-* 'stuck' and 'separate form' of options with arguments.
-  `-oArg` is stuck, `-o Arg` is separate form.
-  `--option=Arg` is stuck, `--option Arg` is separate form.
-
-* Long options may be 'abbreviated', as long as the abbreviation
-  is unambiguous.
-
-* Short options may be bundled, e.g. `-a -b` can be specified as `-ab`.
-
-* Boolean long options can be 'negated' (or 'unset') by prepending
-  `no-`, e.g. `--no-abbrev` instead of `--abbrev`. Conversely,
-  options that begin with `no-` can be 'negated' by removing it.
-  Other long options can be unset (e.g., set string to NULL, set
-  integer to 0) by prepending `no-`.
-
-* Options and non-option arguments can clearly be separated using the `--`
-  option, e.g. `-a -b --option -- --this-is-a-file` indicates that
-  `--this-is-a-file` must not be processed as an option.
-
-Steps to parse options
-----------------------
-
-. `#include "parse-options.h"`
-
-. define a NULL-terminated
-  `static const char * const builtin_foo_usage[]` array
-  containing alternative usage strings
-
-. define `builtin_foo_options` array as described below
-  in section 'Data Structure'.
-
-. in `cmd_foo(int argc, const char **argv, const char *prefix)`
-  call
-
-	argc = parse_options(argc, argv, prefix, builtin_foo_options, builtin_foo_usage, flags);
-+
-`parse_options()` will filter out the processed options of `argv[]` and leave the
-non-option arguments in `argv[]`.
-`argc` is updated appropriately because of the assignment.
-+
-You can also pass NULL instead of a usage array as the fifth parameter of
-parse_options(), to avoid displaying a help screen with usage info and
-option list.  This should only be done if necessary, e.g. to implement
-a limited parser for only a subset of the options that needs to be run
-before the full parser, which in turn shows the full help message.
-+
-Flags are the bitwise-or of:
-
-`PARSE_OPT_KEEP_DASHDASH`::
-	Keep the `--` that usually separates options from
-	non-option arguments.
-
-`PARSE_OPT_STOP_AT_NON_OPTION`::
-	Usually the whole argument vector is massaged and reordered.
-	Using this flag, processing is stopped at the first non-option
-	argument.
-
-`PARSE_OPT_KEEP_ARGV0`::
-	Keep the first argument, which contains the program name.  It's
-	removed from argv[] by default.
-
-`PARSE_OPT_KEEP_UNKNOWN`::
-	Keep unknown arguments instead of erroring out.  This doesn't
-	work for all combinations of arguments as users might expect
-	it to do.  E.g. if the first argument in `--unknown --known`
-	takes a value (which we can't know), the second one is
-	mistakenly interpreted as a known option.  Similarly, if
-	`PARSE_OPT_STOP_AT_NON_OPTION` is set, the second argument in
-	`--unknown value` will be mistakenly interpreted as a
-	non-option, not as a value belonging to the unknown option,
-	the parser early.  That's why parse_options() errors out if
-	both options are set.
-
-`PARSE_OPT_NO_INTERNAL_HELP`::
-	By default, parse_options() handles `-h`, `--help` and
-	`--help-all` internally, by showing a help screen.  This option
-	turns it off and allows one to add custom handlers for these
-	options, or to just leave them unknown.
-
-Data Structure
---------------
-
-The main data structure is an array of the `option` struct,
-say `static struct option builtin_add_options[]`.
-There are some macros to easily define options:
-
-`OPT__ABBREV(&int_var)`::
-	Add `--abbrev[=<n>]`.
-
-`OPT__COLOR(&int_var, description)`::
-	Add `--color[=<when>]` and `--no-color`.
-
-`OPT__DRY_RUN(&int_var, description)`::
-	Add `-n, --dry-run`.
-
-`OPT__FORCE(&int_var, description)`::
-	Add `-f, --force`.
-
-`OPT__QUIET(&int_var, description)`::
-	Add `-q, --quiet`.
-
-`OPT__VERBOSE(&int_var, description)`::
-	Add `-v, --verbose`.
-
-`OPT_GROUP(description)`::
-	Start an option group. `description` is a short string that
-	describes the group or an empty string.
-	Start the description with an upper-case letter.
-
-`OPT_BOOL(short, long, &int_var, description)`::
-	Introduce a boolean option. `int_var` is set to one with
-	`--option` and set to zero with `--no-option`.
-
-`OPT_COUNTUP(short, long, &int_var, description)`::
-	Introduce a count-up option.
-	Each use of `--option` increments `int_var`, starting from zero
-	(even if initially negative), and `--no-option` resets it to
-	zero. To determine if `--option` or `--no-option` was encountered at
-	all, initialize `int_var` to a negative value, and if it is still
-	negative after parse_options(), then neither `--option` nor
-	`--no-option` was seen.
-
-`OPT_BIT(short, long, &int_var, description, mask)`::
-	Introduce a boolean option.
-	If used, `int_var` is bitwise-ored with `mask`.
-
-`OPT_NEGBIT(short, long, &int_var, description, mask)`::
-	Introduce a boolean option.
-	If used, `int_var` is bitwise-anded with the inverted `mask`.
-
-`OPT_SET_INT(short, long, &int_var, description, integer)`::
-	Introduce an integer option.
-	`int_var` is set to `integer` with `--option`, and
-	reset to zero with `--no-option`.
-
-`OPT_STRING(short, long, &str_var, arg_str, description)`::
-	Introduce an option with string argument.
-	The string argument is put into `str_var`.
-
-`OPT_STRING_LIST(short, long, &struct string_list, arg_str, description)`::
-	Introduce an option with string argument.
-	The string argument is stored as an element in `string_list`.
-	Use of `--no-option` will clear the list of preceding values.
-
-`OPT_INTEGER(short, long, &int_var, description)`::
-	Introduce an option with integer argument.
-	The integer is put into `int_var`.
-
-`OPT_MAGNITUDE(short, long, &unsigned_long_var, description)`::
-	Introduce an option with a size argument. The argument must be a
-	non-negative integer and may include a suffix of 'k', 'm' or 'g' to
-	scale the provided value by 1024, 1024^2 or 1024^3 respectively.
-	The scaled value is put into `unsigned_long_var`.
-
-`OPT_EXPIRY_DATE(short, long, &timestamp_t_var, description)`::
-	Introduce an option with expiry date argument, see `parse_expiry_date()`.
-	The timestamp is put into `timestamp_t_var`.
-
-`OPT_CALLBACK(short, long, &var, arg_str, description, func_ptr)`::
-	Introduce an option with argument.
-	The argument will be fed into the function given by `func_ptr`
-	and the result will be put into `var`.
-	See 'Option Callbacks' below for a more elaborate description.
-
-`OPT_FILENAME(short, long, &var, description)`::
-	Introduce an option with a filename argument.
-	The filename will be prefixed by passing the filename along with
-	the prefix argument of `parse_options()` to `prefix_filename()`.
-
-`OPT_ARGUMENT(long, &int_var, description)`::
-	Introduce a long-option argument that will be kept in `argv[]`.
-	If this option was seen, `int_var` will be set to one (except
-	if a `NULL` pointer was passed).
-
-`OPT_NUMBER_CALLBACK(&var, description, func_ptr)`::
-	Recognize numerical options like -123 and feed the integer as
-	if it was an argument to the function given by `func_ptr`.
-	The result will be put into `var`.  There can be only one such
-	option definition.  It cannot be negated and it takes no
-	arguments.  Short options that happen to be digits take
-	precedence over it.
-
-`OPT_COLOR_FLAG(short, long, &int_var, description)`::
-	Introduce an option that takes an optional argument that can
-	have one of three values: "always", "never", or "auto".  If the
-	argument is not given, it defaults to "always".  The `--no-` form
-	works like `--long=never`; it cannot take an argument.  If
-	"always", set `int_var` to 1; if "never", set `int_var` to 0; if
-	"auto", set `int_var` to 1 if stdout is a tty or a pager,
-	0 otherwise.
-
-`OPT_NOOP_NOARG(short, long)`::
-	Introduce an option that has no effect and takes no arguments.
-	Use it to hide deprecated options that are still to be recognized
-	and ignored silently.
-
-`OPT_PASSTHRU(short, long, &char_var, arg_str, description, flags)`::
-	Introduce an option that will be reconstructed into a char* string,
-	which must be initialized to NULL. This is useful when you need to
-	pass the command-line option to another command. Any previous value
-	will be overwritten, so this should only be used for options where
-	the last one specified on the command line wins.
-
-`OPT_PASSTHRU_ARGV(short, long, &argv_array_var, arg_str, description, flags)`::
-	Introduce an option where all instances of it on the command-line will
-	be reconstructed into an argv_array. This is useful when you need to
-	pass the command-line option, which can be specified multiple times,
-	to another command.
-
-`OPT_CMDMODE(short, long, &int_var, description, enum_val)`::
-	Define an "operation mode" option, only one of which in the same
-	group of "operating mode" options that share the same `int_var`
-	can be given by the user. `enum_val` is set to `int_var` when the
-	option is used, but an error is reported if other "operating mode"
-	option has already set its value to the same `int_var`.
-
-
-The last element of the array must be `OPT_END()`.
-
-If not stated otherwise, interpret the arguments as follows:
-
-* `short` is a character for the short option
-  (e.g. `'e'` for `-e`, use `0` to omit),
-
-* `long` is a string for the long option
-  (e.g. `"example"` for `--example`, use `NULL` to omit),
-
-* `int_var` is an integer variable,
-
-* `str_var` is a string variable (`char *`),
-
-* `arg_str` is the string that is shown as argument
-  (e.g. `"branch"` will result in `<branch>`).
-  If set to `NULL`, three dots (`...`) will be displayed.
-
-* `description` is a short string to describe the effect of the option.
-  It shall begin with a lower-case letter and a full stop (`.`) shall be
-  omitted at the end.
-
-Option Callbacks
-----------------
-
-The function must be defined in this form:
-
-	int func(const struct option *opt, const char *arg, int unset)
-
-The callback mechanism is as follows:
-
-* Inside `func`, the only interesting member of the structure
-  given by `opt` is the void pointer `opt->value`.
-  `*opt->value` will be the value that is saved into `var`, if you
-  use `OPT_CALLBACK()`.
-  For example, do `*(unsigned long *)opt->value = 42;` to get 42
-  into an `unsigned long` variable.
-
-* Return value `0` indicates success and non-zero return
-  value will invoke `usage_with_options()` and, thus, die.
-
-* If the user negates the option, `arg` is `NULL` and `unset` is 1.
-
-Sophisticated option parsing
-----------------------------
-
-If you need, for example, option callbacks with optional arguments
-or without arguments at all, or if you need other special cases,
-that are not handled by the macros above, you need to specify the
-members of the `option` structure manually.
-
-This is not covered in this document, but well documented
-in `parse-options.h` itself.
-
-Examples
---------
-
-See `test-parse-options.c` and
-`builtin/add.c`,
-`builtin/clone.c`,
-`builtin/commit.c`,
-`builtin/fetch.c`,
-`builtin/fsck.c`,
-`builtin/rm.c`
-for real-world examples.
diff --git a/parse-options.h b/parse-options.h
index 38a33a087e..eda2a52289 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -1,6 +1,103 @@
 #ifndef PARSE_OPTIONS_H
 #define PARSE_OPTIONS_H
 
+/**
+ * The parse-options API is used to parse and massage options in Git
+ * and to provide a usage help with consistent look.
+ *
+ * Basics
+ * ------
+ *
+ * The argument vector `argv[]` may usually contain mandatory or optional
+ * 'non-option arguments', e.g. a filename or a branch, and 'options'.
+ * Options are optional arguments that start with a dash and
+ * that allow to change the behavior of a command.
+ *
+ * - There are basically three types of options:
+ *   'boolean' options,
+ *   options with (mandatory) 'arguments' and
+ *   options with 'optional arguments'
+ *   (i.e. a boolean option that can be adjusted).
+ *
+ * - There are basically two forms of options:
+ *   'Short options' consist of one dash (`-`) and one alphanumeric
+ *   character.
+ *   'Long options' begin with two dashes (`--`) and some
+ *   alphanumeric characters.
+ *
+ * - Options are case-sensitive.
+ *   Please define 'lower-case long options' only.
+ *
+ * The parse-options API allows:
+ *
+ * - 'stuck' and 'separate form' of options with arguments.
+ *   `-oArg` is stuck, `-o Arg` is separate form.
+ *   `--option=Arg` is stuck, `--option Arg` is separate form.
+ *
+ * - Long options may be 'abbreviated', as long as the abbreviation
+ *   is unambiguous.
+ *
+ * - Short options may be bundled, e.g. `-a -b` can be specified as `-ab`.
+ *
+ * - Boolean long options can be 'negated' (or 'unset') by prepending
+ *   `no-`, e.g. `--no-abbrev` instead of `--abbrev`. Conversely,
+ *   options that begin with `no-` can be 'negated' by removing it.
+ *   Other long options can be unset (e.g., set string to NULL, set
+ *   integer to 0) by prepending `no-`.
+ *
+ * - Options and non-option arguments can clearly be separated using the `--`
+ *   option, e.g. `-a -b --option -- --this-is-a-file` indicates that
+ *   `--this-is-a-file` must not be processed as an option.
+ *
+ * Steps to parse options
+ * ----------------------
+ *
+ * - `#include "parse-options.h"`
+ *
+ * - define a NULL-terminated
+ *   `static const char * const builtin_foo_usage[]` array
+ *   containing alternative usage strings
+ *
+ * - define `builtin_foo_options` array as described below
+ *   in section 'Data Structure'.
+ *
+ * - in `cmd_foo(int argc, const char **argv, const char *prefix)`
+ *   call
+ *
+ * 	argc = parse_options(argc, argv, prefix, builtin_foo_options, builtin_foo_usage, flags);
+ *
+ * `parse_options()` will filter out the processed options of `argv[]` and leave the
+ * non-option arguments in `argv[]`.
+ * `argc` is updated appropriately because of the assignment.
+ *
+ * You can also pass NULL instead of a usage array as the fifth parameter of
+ * parse_options(), to avoid displaying a help screen with usage info and
+ * option list. This should only be done if necessary, e.g. to implement
+ * a limited parser for only a subset of the options that needs to be run
+ * before the full parser, which in turn shows the full help message.
+ *
+ * Sophisticated option parsing
+ * ----------------------------
+ *
+ * If you need, for example, option callbacks with optional arguments
+ * or without arguments at all, or if you need other special cases,
+ * that are not handled by the macros here, you need to specify the
+ * members of the `option` structure manually.
+ *
+ * Examples
+ * --------
+ *
+ * See `test-parse-options.c` and
+ * `builtin/add.c`,
+ * `builtin/clone.c`,
+ * `builtin/commit.c`,
+ * `builtin/fetch.c`,
+ * `builtin/fsck.c`,
+ * `builtin/rm.c`
+ * for real-world examples.
+ *
+ */
+
 enum parse_opt_type {
 	/* special types */
 	OPTION_END,
@@ -25,11 +122,47 @@ enum parse_opt_type {
 };
 
 enum parse_opt_flags {
+
+	/**
+	 * Keep the `--` that usually separates options from non-option arguments.
+	 */
 	PARSE_OPT_KEEP_DASHDASH = 1,
+
+	/**
+	 * Usually the whole argument vector is massaged and reordered.
+	 * Using this flag, processing is stopped at the first non-option
+	 * argument.
+	 */
 	PARSE_OPT_STOP_AT_NON_OPTION = 2,
+
+	/**
+	 * Keep the first argument, which contains the program name.  It's
+	 * removed from argv[] by default.
+	 */
 	PARSE_OPT_KEEP_ARGV0 = 4,
+
+	/**
+	 * Keep unknown arguments instead of erroring out.  This doesn't
+	 * work for all combinations of arguments as users might expect
+	 * it to do. E.g. if the first argument in `--unknown --known`
+	 * takes a value (which we can't know), the second one is
+	 * mistakenly interpreted as a known option.  Similarly, if
+	 * `PARSE_OPT_STOP_AT_NON_OPTION` is set, the second argument in
+	 * `--unknown value` will be mistakenly interpreted as a
+	 * non-option, not as a value belonging to the unknown option,
+	 * the parser early. That's why parse_options() errors out if
+	 * both options are set.
+	 */
 	PARSE_OPT_KEEP_UNKNOWN = 8,
+
+	/**
+	 * By default, parse_options() handles `-h`, `--help` and
+	 * `--help-all` internally, by showing a help screen. This option
+	 * turns it off and allows one to add custom handlers for these
+	 * options, or to just leave them unknown.
+	 */
 	PARSE_OPT_NO_INTERNAL_HELP = 16,
+
 	PARSE_OPT_ONE_SHOT = 32
 };
 
@@ -56,6 +189,30 @@ enum parse_opt_result {
 };
 
 struct option;
+
+/**
+ * Option Callbacks
+ * ----------------
+ *
+ * The function must be defined in this form:
+ *
+ * 	int func(const struct option *opt, const char *arg, int unset)
+ *
+ * The callback mechanism is as follows:
+ *
+ * - Inside `func`, the only interesting member of the structure
+ *   given by `opt` is the void pointer `opt->value`.
+ *   `*opt->value` will be the value that is saved into `var`, if you
+ *   use `OPT_CALLBACK()`.
+ *   For example, do `*(unsigned long *)opt->value = 42;` to get 42
+ *   into an `unsigned long` variable.
+ *
+ * - Return value `0` indicates success and non-zero return
+ *   value will invoke `usage_with_options()` and, thus, die.
+ *
+ * - If the user negates the option, `arg` is `NULL` and `unset` is 1.
+ *
+ */
 typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
 
 struct parse_opt_ctx_t;
@@ -137,6 +294,36 @@ struct option {
 	intptr_t extra;
 };
 
+/**
+ * Data Structure
+ * --------------
+ *
+ * The main data structure is an array of the `option` struct, say
+ * `static struct option builtin_add_options[]`.
+ * The following macros can be used to easily define options.
+ * The last element of the array must be `OPT_END()`.
+ *
+ * If not stated otherwise, interpret the arguments as follows:
+ *
+ * - `short` is a character for the short option
+ *   (e.g. `'e'` for `-e`, use `0` to omit),
+ *
+ * - `long` is a string for the long option
+ *   (e.g. `"example"` for `--example`, use `NULL` to omit),
+ *
+ * - `int_var` is an integer variable,
+ *
+ * - `str_var` is a string variable (`char *`),
+ *
+ * - `arg_str` is the string that is shown as argument
+ *   (e.g. `"branch"` will result in `<branch>`).
+ *   If set to `NULL`, three dots (`...`) will be displayed.
+ *
+ * - `description` is a short string to describe the effect of the option.
+ *   It shall begin with a lower-case letter and a full stop (`.`) shall be
+ *   omitted at the end.
+ */
+
 #define OPT_BIT_F(s, l, v, h, b, f) { OPTION_BIT, (s), (l), (v), NULL, (h), \
 				      PARSE_OPT_NOARG|(f), NULL, (b) }
 #define OPT_COUNTUP_F(s, l, v, h, f) { OPTION_COUNTUP, (s), (l), (v), NULL, \
@@ -150,44 +337,158 @@ struct option {
 #define OPT_INTEGER_F(s, l, v, h, f)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h), (f) }
 
 #define OPT_END()                   { OPTION_END }
+
+/**
+ * Introduce a long-option argument that will be kept in `argv[]`.
+ * If this option was seen, `int_var` will be set to one (except
+ * if a `NULL` pointer was passed).
+ */
 #define OPT_ARGUMENT(l, v, h)       { OPTION_ARGUMENT, 0, (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, 1 }
+
+/**
+ * Start an option group. `description` is a short string that describes the
+ * group or an empty string. Start the description with an upper-case letter.
+ */
 #define OPT_GROUP(h)                { OPTION_GROUP, 0, NULL, NULL, NULL, (h) }
+
+/**
+ * Introduce a boolean option. If used, `int_var` is bitwise-ored with `mask`.
+ */
 #define OPT_BIT(s, l, v, h, b)      OPT_BIT_F(s, l, v, h, b, 0)
+
 #define OPT_BITOP(s, l, v, h, set, clear) { OPTION_BITOP, (s), (l), (v), NULL, (h), \
 					    PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, \
 					    (set), NULL, (clear) }
+
+/**
+ * Introduce a boolean option. If used, `int_var` is bitwise-anded with the
+ * inverted `mask`.
+ */
 #define OPT_NEGBIT(s, l, v, h, b)   { OPTION_NEGBIT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (b) }
+
+/**
+ * Introduce a count-up option.
+ * Each use of `--option` increments `int_var`, starting from zero
+ * (even if initially negative), and `--no-option` resets it to
+ * zero. To determine if `--option` or `--no-option` was encountered at
+ * all, initialize `int_var` to a negative value, and if it is still
+ * negative after parse_options(), then neither `--option` nor
+ * `--no-option` was seen.
+ */
 #define OPT_COUNTUP(s, l, v, h)     OPT_COUNTUP_F(s, l, v, h, 0)
+
+/**
+ * Introduce an integer option. `int_var` is set to `integer` with `--option`,
+ * and reset to zero with `--no-option`.
+ */
 #define OPT_SET_INT(s, l, v, h, i)  OPT_SET_INT_F(s, l, v, h, i, 0)
+
+/**
+ * Introduce a boolean option. `int_var` is set to one with `--option` and set
+ * to zero with `--no-option`.
+ */
 #define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
+
 #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
+
+/**
+ * Define an "operation mode" option, only one of which in the same
+ * group of "operating mode" options that share the same `int_var`
+ * can be given by the user. `enum_val` is set to `int_var` when the
+ * option is used, but an error is reported if other "operating mode"
+ * option has already set its value to the same `int_var`.
+ */
 #define OPT_CMDMODE(s, l, v, h, i)  { OPTION_CMDMODE, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
+
+/**
+ * Introduce an option with integer argument. The integer is put into `int_var`.
+ */
 #define OPT_INTEGER(s, l, v, h)     OPT_INTEGER_F(s, l, v, h, 0)
+
+/**
+ * Introduce an option with a size argument. The argument must be a
+ * non-negative integer and may include a suffix of 'k', 'm' or 'g' to
+ * scale the provided value by 1024, 1024^2 or 1024^3 respectively.
+ * The scaled value is put into `unsigned_long_var`.
+ */
 #define OPT_MAGNITUDE(s, l, v, h)   { OPTION_MAGNITUDE, (s), (l), (v), \
 				      N_("n"), (h), PARSE_OPT_NONEG }
+
+/**
+ * Introduce an option with string argument. The string argument is put
+ * into `str_var`.
+ */
 #define OPT_STRING(s, l, v, a, h)   OPT_STRING_F(s, l, v, a, h, 0)
+
+/**
+ * Introduce an option with string argument.
+ * The string argument is stored as an element in `string_list`.
+ * Use of `--no-option` will clear the list of preceding values.
+ */
 #define OPT_STRING_LIST(s, l, v, a, h) \
 				    { OPTION_CALLBACK, (s), (l), (v), (a), \
 				      (h), 0, &parse_opt_string_list }
+
 #define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, &parse_opt_tertiary }
+
+/**
+ * Introduce an option with expiry date argument, see `parse_expiry_date()`.
+ * The timestamp is put into `timestamp_t_var`.
+ */
 #define OPT_EXPIRY_DATE(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), N_("expiry-date"),(h), 0,	\
 	  parse_opt_expiry_date_cb }
+
+/**
+ * Introduce an option with argument.
+ * The argument will be fed into the function given by `func_ptr`
+ * and the result will be put into `var`.
+ */
 #define OPT_CALLBACK(s, l, v, a, h, f) OPT_CALLBACK_F(s, l, v, a, h, 0, f)
+
+/**
+ * Recognize numerical options like -123 and feed the integer as
+ * if it was an argument to the function given by `func_ptr`.
+ * The result will be put into `var`.  There can be only one such
+ * option definition.  It cannot be negated and it takes no
+ * arguments.  Short options that happen to be digits take
+ * precedence over it.
+ */
 #define OPT_NUMBER_CALLBACK(v, h, f) \
 	{ OPTION_NUMBER, 0, NULL, (v), NULL, (h), \
 	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, (f) }
+
+/**
+ * Introduce an option with a filename argument.
+ * The filename will be prefixed by passing the filename along with
+ * the prefix argument of `parse_options()` to `prefix_filename()`.
+ */
 #define OPT_FILENAME(s, l, v, h)    { OPTION_FILENAME, (s), (l), (v), \
 				       N_("file"), (h) }
+
+/**
+ * Introduce an option that takes an optional argument that can
+ * have one of three values: "always", "never", or "auto".  If the
+ * argument is not given, it defaults to "always".  The `--no-` form
+ * works like `--long=never`; it cannot take an argument.  If
+ * "always", set `int_var` to 1; if "never", set `int_var` to 0; if
+ * "auto", set `int_var` to 1 if stdout is a tty or a pager,
+ * 0 otherwise.
+ */
 #define OPT_COLOR_FLAG(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), N_("when"), (h), PARSE_OPT_OPTARG, \
 		parse_opt_color_flag_cb, (intptr_t)"always" }
 
+/**
+ * Introduce an option that has no effect and takes no arguments.
+ * Use it to hide deprecated options that are still to be recognized
+ * and ignored silently.
+ */
 #define OPT_NOOP_NOARG(s, l) \
 	{ OPTION_CALLBACK, (s), (l), NULL, NULL, \
 	  N_("no-op (backward compatibility)"),		\
@@ -296,24 +597,52 @@ int parse_opt_noop_cb(const struct option *, const char *, int);
 enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
 					   const struct option *,
 					   const char *, int);
+
+/**
+ * Introduce an option that will be reconstructed into a char* string,
+ * which must be initialized to NULL. This is useful when you need to
+ * pass the command-line option to another command. Any previous value
+ * will be overwritten, so this should only be used for options where
+ * the last one specified on the command line wins.
+ */
 int parse_opt_passthru(const struct option *, const char *, int);
+
+/**
+ * Introduce an option where all instances of it on the command-line will
+ * be reconstructed into an argv_array. This is useful when you need to
+ * pass the command-line option, which can be specified multiple times,
+ * to another command.
+ */
 int parse_opt_passthru_argv(const struct option *, const char *, int);
 
+/* Add `-v, --verbose`. */
 #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
+
+/* Add `-q, --quiet`. */
 #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
+
 #define OPT__VERBOSITY(var) \
 	{ OPTION_CALLBACK, 'v', "verbose", (var), NULL, N_("be more verbose"), \
 	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }, \
 	{ OPTION_CALLBACK, 'q', "quiet", (var), NULL, N_("be more quiet"), \
 	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }
+
+/* Add `-n, --dry-run`. */
 #define OPT__DRY_RUN(var, h)  OPT_BOOL('n', "dry-run", (var), (h))
+
+/* Add `-f, --force`. */
 #define OPT__FORCE(var, h, f) OPT_COUNTUP_F('f', "force",   (var), (h), (f))
+
+/* Add `--abbrev[=<n>]`. */
 #define OPT__ABBREV(var)  \
 	{ OPTION_CALLBACK, 0, "abbrev", (var), N_("n"),	\
 	  N_("use <n> digits to display SHA-1s"),	\
 	  PARSE_OPT_OPTARG, &parse_opt_abbrev_cb, 0 }
+
+/* Add `--color[=<when>]` and `--no-color`. */
 #define OPT__COLOR(var, h) \
 	OPT_COLOR_FLAG(0, "color", (var), (h))
+
 #define OPT_COLUMN(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), N_("style"), (h), PARSE_OPT_OPTARG, parseopt_column_callback }
 #define OPT_PASSTHRU(s, l, v, a, h, f) \
-- 
gitgitgadget

