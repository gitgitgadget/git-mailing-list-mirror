Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 598811F597
	for <e@80x24.org>; Sat, 21 Jul 2018 22:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbeGUW7C (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 18:59:02 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:38383 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeGUW7C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 18:59:02 -0400
Received: by mail-pl0-f43.google.com with SMTP id b1-v6so6621697pls.5
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 15:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q2Wwq+PkZajKugWtQEhq/7J0+l4z3hDhMsdLonwE9FE=;
        b=of87PSH1OP1/FK4nEWDzCiaoIPsl9DICpqzsgl2V/E2AImfTTuyy8OclRFljKDrA2o
         RDjHifz8k13rTbKPNOpthuYjc7jVNCwmG07rT7iwLuCWW9TEPj36dsh9/v+CRnCnW/es
         x/WbKT1pYKxGfXuxnjm0LPX6DmEJgNZDsfIeqlBypcVJI1aWpbBEEfTQMhNaGpqwdU0w
         7qTTfPS0xVpipfbv6eB1bzOxmT5yZxqAWjKsFlOwsP+KoArFhicpFtaJgviRQWR7Of28
         OoVK51KcJy8mn0fhCgK1IlgBj2sNkH2wzDxveSZDRVt2ZoHAllVSCyrc4BM2Fe2gzPcj
         jNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q2Wwq+PkZajKugWtQEhq/7J0+l4z3hDhMsdLonwE9FE=;
        b=L7cORJUTxB3lFqiry4AZX/4YLp5/q9r8kE709VdbFh9EuFXWWptxmQjumKhXgprCTs
         43BAXl4yVBh4Ov93ZrpOepv0hj8oVRCDvbij4lhtACVjp/Ljqj/xFeS1aWI0IuNStBkq
         X6iMVU4KKi/1WUURgYJTsydUedgLHAMi5tINM2AUsR+23WD1CJdY11djDbfZZk7VUR7w
         /8xiUwpB4mFsXs5ioOzS1E0qTwzuRvdJ0zTMgG2AxJE7CswsB45EmJWXUpXM0H0dSb79
         Oy6lIxGv0y9Lh35lQfGpVczlLU0urigaM6jkIG3fqWZfXVtrHeXG1/q9iFslD9HWVPSc
         +jpw==
X-Gm-Message-State: AOUpUlGwSxbhTZlwF50F0g3vPrby4gSIiicH0tygJw8x2LPNIFXlOdY0
        YItHuZ8SuRJIEaXlLDgiE3zS1Dx2
X-Google-Smtp-Source: AAOMgpfGnXRTqANYLqTH+dd9+b/VWIqVOzMhEY2f1q640tHBA63wkIgW9IkNw+tEtZsshAIFWsvEEQ==
X-Received: by 2002:a17:902:bb8d:: with SMTP id m13-v6mr7017383pls.46.1532210685532;
        Sat, 21 Jul 2018 15:04:45 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id 64-v6sm7826412pfi.89.2018.07.21.15.04.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 15:04:44 -0700 (PDT)
Date:   Sat, 21 Jul 2018 15:04:44 -0700 (PDT)
X-Google-Original-Date: Sat, 21 Jul 2018 22:04:21 GMT
Message-Id: <pull.1.v4.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v3.git.gitgitgadget@gmail.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 00/21] Add `range-diff`, a `tbdiff` lookalike
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The incredibly useful [`git-tbdiff`](https://github.com/trast/tbdiff) tool to compare patch series (say, to see what changed between two iterations sent to the Git mailing list) is slightly less useful for this developer due to the fact that it requires the `hungarian` and `numpy` Python packages which are for some reason really hard to build in MSYS2. So hard that I even had to give up, because it was simply easier to re-implement the whole shebang as a builtin command.

The project at https://github.com/trast/tbdiff seems to be dormant, anyway. Funny (and true) story: I looked at the open Pull Requests to see how active that project is, only to find to my surprise that I had submitted one in August 2015, and that it was still unanswered let alone merged.

While at it, I forward-ported AEvar's patch to force `--decorate=no` because `git -p tbdiff` would fail otherwise.

Side note: I work on implementing range-diff not only to make life easier for reviewers who have to suffer through v2, v3, ... of my patch series, but also to verify my changes before submitting a new iteration. And also, maybe even more importantly, I plan to use it to verify my merging-rebases of Git for
Windows (for which I previously used to redirect the pre-rebase/post-rebase diffs vs upstream and then compare them using `git diff --no-index`). And of course any interested person can see what changes were necessary e.g. in the merging-rebase of Git for Windows onto v2.17.0 by running a command like:

```sh
        base=^{/Start.the.merging-rebase}
        tag=v2.17.0.windows.1
        pre=$tag$base^2
        git range-diff $pre$base..$pre $tag$base..$tag
```

The command uses what it calls the "dual color mode" (can be disabled via `--no-dual-color`) which helps identifying what *actually* changed: it prefixes lines with a `-` (and red background) that correspond to the first commit range, and with a `+` (and green background) that correspond to the second range. The rest of the lines will be colored according to the original diffs.

Changes since v3:

- The cover letter was adjusted to reflect the new reality (the command is called `range-diff` now, not `branch-diff`, and `--dual-color` is the default).
- The documentation was adjusted a bit more in the patch that makes `--dual-color` the default.
- Clarified the calculation of the cost matrix, as per Stefan Beller's request.
- The man page now spells out that merge *commits* are ignored in the commit ranges (not merges per se).
- The code in `linear-assignment.c` was adjusted to use the `SWAP()` macro.
- The commit message of the patch introducing the first rudimentary implementation no longer talks about the "Hungarian" algorithm, but about the "linear assignment algorithm" instead.
- A bogus indentation change was backed out from the patch introducing the first rudimentary implementation.
- Instead of merely warning about missing `..` in the 2-parameter invocation, we now exit with the error message.
- The `diff_opt_parse()` function is allowed to return a value larger than 1, indicating that more than just one command-line parameter was parsed. We now advance by the indicated value instead of always advancing exactly 1 (which is still correct much of the time).
- A lengthy `if...else if...else if...else` was simplified (from a logical point of view) by reordering it.
- The unnecessarily `static` variable `dashes` was turned into a local variable of the caller.
- The commit message talking about the new man page still referred to `git branch --diff`, which has been fixed.
- A forgotten t7910 reference was changed to t3206.
- An unbalanced double-tick was fixed in the man page.
- Fixed grammar both of the commit message and the description of the `--no-dual-color` option.
- To fix the build, a blank man page is now introduced together with the new `range-diff` command, even if it is populated for real only at a later patch (i.e. at the same time as before).
- The headaches Junio fears would be incurred by that simple workaround to avoid bogus white-space error reporting are fended off: a more complex patch is now in place that adds (and uses) a new white-space flag. Sadly, as is all too common when Junio "encourages" me to replace a simple workaround by something "proper", it caused all kinds of headaches to get this right, so I am rather less certain that the "proper" fix will cause us less headaches than the simple workaround would have done. But whatever.
- The dual color mode now also dims the changes that are exclusively in the first specified commit range, and uses bold face on the changes exclusively in the second one. This matches the intuition when using `range-diff` to compare an older iteration of a patch series to a newer one: the changes from the previous iteration that were replaced by new ones "fade", while the changes that replace them are "shiny new".

Changes since v2:

- Right-aligned the patch numbers in the commit pairs.
- Used ALLOC_ARRAY() in hungarian.c instead of xmalloc(sizeof()*size).
- Changed compute_assignment()s return type from int to void, as it always succeeds.
- Changed the Hungarian Algorithm to use an integer cost matrix.
- Changed the --creation-weight <double> option to --creation-factor <percent> where <percent> is an integer.
- Retitled 1/19 and 2/19 to better conform with the current conventions, as pointed out (and suggested) by Junio.
- Shut up Coverity, and at the same time avoided passing the unnecessary `i` and `j` parameters to output_pair_header().
- Removed support for the `--no-patches` option: we inherit diff_options' support for `-s` already (and much more).
- Removed the ugly `_INV` enum values, and introduced a beautiful GIT_COLOR_REVERSE instead. This way, whatever the user configured as color.diff.new (or .old) will be used in reverse in the dual color mode.
- Instead of overriding the fragment header color, the dual color mode will now reverse the "outer" fragment headers, too.
- Turned the stand-alone branch-diff command into the `--diff` option of `git branch`. Adjusted pretty much *all* commit messages to account for this. This change should no longer be visible: see below.
- Pretty much re-wrote the completion, to support the new --diff mode of git-branch. See below: it was reverted for range-diff.
- Renamed t7910 to t3206, to be closer to the git-branch tests.
- Ensured that git_diff_ui_config() gets called, and therefore color.diff.* respected.
- Avoided leaking `four_spaces`.
- Fixed a declaration in a for (;;) statement (which Junio had as a fixup! that I almost missed).
- Renamed `branch --diff`, which had been renamed from `branch-diff` (which was picked to avoid re-using `tbdiff`) to `range-diff`.
- Renamed `hungarian.c` and its header to `linear-assignment.c`
- Made `--dual-color` the default, and changed it to still auto-detect whether color should be used rather than forcing it

Johannes Schindelin (20):
  linear-assignment: a function to solve least-cost assignment problems
  Introduce `range-diff` to compare iterations of a topic branch
  range-diff: first rudimentary implementation
  range-diff: improve the order of the shown commits
  range-diff: also show the diff between patches
  range-diff: right-trim commit messages
  range-diff: indent the diffs just like tbdiff
  range-diff: suppress the diff headers
  range-diff: adjust the output of the commit pairs
  range-diff: do not show "function names" in hunk headers
  range-diff: use color for the commit pairs
  color: add the meta color GIT_COLOR_REVERSE
  diff: add an internal option to dual-color diffs of diffs
  range-diff: offer to dual-color the diffs
  range-diff --dual-color: fix bogus white-space warning
  range-diff: populate the man page
  completion: support `git range-diff`
  range-diff: left-pad patch numbers
  range-diff: make --dual-color the default mode
  range-diff: use dim/bold cues to improve dual color mode

Thomas Rast (1):
  range-diff: add tests

 .gitignore                             |   1 +
 Documentation/config.txt               |   6 +-
 Documentation/git-range-diff.txt       | 252 +++++++++++
 Makefile                               |   3 +
 builtin.h                              |   1 +
 builtin/range-diff.c                   | 106 +++++
 cache.h                                |   3 +-
 color.h                                |   7 +
 command-list.txt                       |   1 +
 contrib/completion/git-completion.bash |  14 +
 diff.c                                 | 119 ++++-
 diff.h                                 |  16 +-
 git.c                                  |   1 +
 linear-assignment.c                    | 201 ++++++++
 linear-assignment.h                    |  22 +
 range-diff.c                           | 440 ++++++++++++++++++
 range-diff.h                           |   9 +
 t/.gitattributes                       |   1 +
 t/t3206-range-diff.sh                  | 145 ++++++
 t/t3206/history.export                 | 604 +++++++++++++++++++++++++
 ws.c                                   |  11 +-
 21 files changed, 1932 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/git-range-diff.txt
 create mode 100644 builtin/range-diff.c
 create mode 100644 linear-assignment.c
 create mode 100644 linear-assignment.h
 create mode 100644 range-diff.c
 create mode 100644 range-diff.h
 create mode 100755 t/t3206-range-diff.sh
 create mode 100644 t/t3206/history.export


base-commit: b7bd9486b055c3f967a870311e704e3bb0654e4f
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-1%2Fdscho%2Fbranch-diff-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1/dscho/branch-diff-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1

Range-diff vs v3:

  1:  39272eefc !  1:  f7e70689e linear-assignment: a function to solve least-cost assignment problems
     @@ -223,9 +223,7 @@
      +				BUG("negative j: %d", j);
      +			i = pred[j];
      +			column2row[j] = i;
     -+			k = j;
     -+			j = row2column[i];
     -+			row2column[i] = k;
     ++			SWAP(j, row2column[i]);
      +		} while (i1 != i);
      +	}
      +
  2:  7f15b26d4 !  2:  88134121d Introduce `range-diff` to compare iterations of a topic branch
     @@ -10,6 +10,10 @@
          At this point, we ignore tbdiff's color options, as they will all be
          implemented later using diff_options.
      
     +    Since f318d739159 (generate-cmds.sh: export all commands to
     +    command-list.h, 2018-05-10), every new command *requires* a man page to
     +    build right away, so let's also add a blank man page, too.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/.gitignore b/.gitignore
     @@ -24,6 +28,22 @@
       /git-rebase
       /git-rebase--am
      
     +diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
     +new file mode 100644
     +--- /dev/null
     ++++ b/Documentation/git-range-diff.txt
     +@@
     ++git-range-diff(1)
     ++==================
     ++
     ++NAME
     ++----
     ++git-range-diff - Compare two commit ranges (e.g. two versions of a branch)
     ++
     ++GIT
     ++---
     ++Part of the linkgit:git[1] suite
     +
      diff --git a/Makefile b/Makefile
      --- a/Makefile
      +++ b/Makefile
  3:  076e1192d !  3:  4e3fb47a1 range-diff: first rudimentary implementation
     @@ -4,7 +4,7 @@
      
          At this stage, `git range-diff` can determine corresponding commits
          of two related commit ranges. This makes use of the recently introduced
     -    implementation of the Hungarian algorithm.
     +    implementation of the linear assignment algorithm.
      
          The core of this patch is a straight port of the ideas of tbdiff, the
          apparently dormant project at https://github.com/trast/tbdiff.
     @@ -51,19 +51,17 @@
      +	int res = 0;
      +	struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
       
     --	argc = parse_options(argc, argv, NULL, options,
     --			     builtin_range_diff_usage, 0);
     -+	argc = parse_options(argc, argv, NULL, options, builtin_range_diff_usage,
     -+			     0);
     + 	argc = parse_options(argc, argv, NULL, options,
     + 			     builtin_range_diff_usage, 0);
       
      -	return 0;
      +	if (argc == 2) {
      +		if (!strstr(argv[0], ".."))
     -+			warning(_("no .. in range: '%s'"), argv[0]);
     ++			die(_("no .. in range: '%s'"), argv[0]);
      +		strbuf_addstr(&range1, argv[0]);
      +
      +		if (!strstr(argv[1], ".."))
     -+			warning(_("no .. in range: '%s'"), argv[1]);
     ++			die(_("no .. in range: '%s'"), argv[1]);
      +		strbuf_addstr(&range2, argv[1]);
      +	} else if (argc == 3) {
      +		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
     @@ -195,17 +193,21 @@
      +			continue;
      +		} else if (starts_with(line.buf, "@@ "))
      +			strbuf_addstr(&buf, "@@");
     -+		else if (line.buf[0] && !starts_with(line.buf, "index "))
     ++		else if (!line.buf[0] || starts_with(line.buf, "index "))
      +			/*
      +			 * A completely blank (not ' \n', which is context)
      +			 * line is not valid in a diff.  We skip it
      +			 * silently, because this neatly handles the blank
      +			 * separator line between commits in git-log
      +			 * output.
     ++			 *
     ++			 * We also want to ignore the diff's `index` lines
     ++			 * because they contain exact blob hashes in which
     ++			 * we are not interested.
      +			 */
     -+			strbuf_addbuf(&buf, &line);
     -+		else
      +			continue;
     ++		else
     ++			strbuf_addbuf(&buf, &line);
      +
      +		strbuf_addch(&buf, '\n');
      +		util->diffsize++;
  4:  e98489c8c =  4:  47bee09b0 range-diff: improve the order of the shown commits
  5:  935cad180 !  5:  94afaeaf2 range-diff: also show the diff between patches
     @@ -55,21 +55,22 @@
      +	int i, j, res = 0;
       	struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
       
     --	argc = parse_options(argc, argv, NULL, options, builtin_range_diff_usage,
     --			     0);
      +	git_config(git_diff_ui_config, NULL);
      +
      +	diff_setup(&diffopt);
      +	diffopt.output_format = DIFF_FORMAT_PATCH;
      +
     -+	argc = parse_options(argc, argv, NULL, options,
     -+			builtin_range_diff_usage, PARSE_OPT_KEEP_UNKNOWN);
     + 	argc = parse_options(argc, argv, NULL, options,
     +-			     builtin_range_diff_usage, 0);
     ++			     builtin_range_diff_usage, PARSE_OPT_KEEP_UNKNOWN);
      +
     -+	for (i = j = 0; i < argc; i++) {
     ++	for (i = j = 0; i < argc; ) {
      +		int c = diff_opt_parse(&diffopt, argv + i, argc - i, prefix);
      +
      +		if (!c)
     -+			argv[j++] = argv[i];
     ++			argv[j++] = argv[i++];
     ++		else
     ++			i += c;
      +	}
      +	argc = j;
      +	diff_setup_done(&diffopt);
  6:  93ac1931d =  6:  41ab875a3 range-diff: right-trim commit messages
  7:  ca5282815 !  7:  a3dd99509 range-diff: indent the diffs just like tbdiff
     @@ -39,7 +39,7 @@
      +	diffopt.output_prefix_data = &four_spaces;
       
       	argc = parse_options(argc, argv, NULL, options,
     - 			builtin_range_diff_usage, PARSE_OPT_KEEP_UNKNOWN);
     + 			     builtin_range_diff_usage, PARSE_OPT_KEEP_UNKNOWN);
      @@
       
       	strbuf_release(&range1);
  8:  80622685f =  8:  61b2ff2f7 range-diff: suppress the diff headers
  9:  6b31cbf72 !  9:  9641ab5c0 range-diff: adjust the output of the commit pairs
     @@ -26,25 +26,22 @@
       
      -static const char *short_oid(struct patch_util *util)
      +static void output_pair_header(struct strbuf *buf,
     ++			       struct strbuf *dashes,
      +			       struct patch_util *a_util,
      +			       struct patch_util *b_util)
       {
      -	return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
     -+	static char *dashes;
      +	struct object_id *oid = a_util ? &a_util->oid : &b_util->oid;
      +	struct commit *commit;
      +
     -+	if (!dashes) {
     -+		char *p;
     -+
     -+		dashes = xstrdup(find_unique_abbrev(oid, DEFAULT_ABBREV));
     -+		for (p = dashes; *p; p++)
     -+			*p = '-';
     -+	}
     ++	if (!dashes->len)
     ++		strbuf_addchars(dashes, '-',
     ++				strlen(find_unique_abbrev(oid,
     ++							  DEFAULT_ABBREV)));
      +
      +	strbuf_reset(buf);
      +	if (!a_util)
     -+		strbuf_addf(buf, "-:  %s ", dashes);
     ++		strbuf_addf(buf, "-:  %s ", dashes->buf);
      +	else
      +		strbuf_addf(buf, "%d:  %s ", a_util->i + 1,
      +			    find_unique_abbrev(&a_util->oid, DEFAULT_ABBREV));
     @@ -59,7 +56,7 @@
      +		strbuf_addch(buf, '=');
      +
      +	if (!b_util)
     -+		strbuf_addf(buf, " -:  %s", dashes);
     ++		strbuf_addf(buf, " -:  %s", dashes->buf);
      +	else
      +		strbuf_addf(buf, " %d:  %s", b_util->i + 1,
      +			    find_unique_abbrev(&b_util->oid, DEFAULT_ABBREV));
     @@ -84,7 +81,7 @@
       static void output(struct string_list *a, struct string_list *b,
       		   struct diff_options *diffopt)
       {
     -+	struct strbuf buf = STRBUF_INIT;
     ++	struct strbuf buf = STRBUF_INIT, dashes = STRBUF_INIT;
       	int i = 0, j = 0;
       
       	/*
     @@ -94,7 +91,7 @@
       		if (i < a->nr && a_util->matching < 0) {
      -			printf("%d: %s < -: --------\n",
      -			       i + 1, short_oid(a_util));
     -+			output_pair_header(&buf, a_util, NULL);
     ++			output_pair_header(&buf, &dashes, a_util, NULL);
       			i++;
       			continue;
       		}
     @@ -103,7 +100,7 @@
       		while (j < b->nr && b_util->matching < 0) {
      -			printf("-: -------- > %d: %s\n",
      -			       j + 1, short_oid(b_util));
     -+			output_pair_header(&buf, NULL, b_util);
     ++			output_pair_header(&buf, &dashes, NULL, b_util);
       			b_util = ++j < b->nr ? b->items[j].util : NULL;
       		}
       
     @@ -113,7 +110,7 @@
      -			printf("%d: %s ! %d: %s\n",
      -			       b_util->matching + 1, short_oid(a_util),
      -			       j + 1, short_oid(b_util));
     -+			output_pair_header(&buf, a_util, b_util);
     ++			output_pair_header(&buf, &dashes, a_util, b_util);
       			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
       				patch_diff(a->items[b_util->matching].string,
       					   b->items[j].string, diffopt);
     @@ -122,6 +119,7 @@
       		}
       	}
      +	strbuf_release(&buf);
     ++	strbuf_release(&dashes);
       }
       
       int show_range_diff(const char *range1, const char *range2,
 10:  ef997bb8b = 10:  0a52f8878 range-diff: do not show "function names" in hunk headers
 11:  3d9e5b0ba ! 11:  2b8d09020 range-diff: add tests
     @@ -3,8 +3,8 @@
          range-diff: add tests
      
          These are essentially lifted from https://github.com/trast/tbdiff, with
     -    light touch-ups to account for the command now being an option of `git
     -    branch`.
     +    light touch-ups to account for the command now being names `git
     +    range-diff`.
      
          Apart from renaming `tbdiff` to `range-diff`, only one test case needed
          to be adjusted: 11 - 'changed message'.
     @@ -22,12 +22,13 @@
      --- a/t/.gitattributes
      +++ b/t/.gitattributes
      @@
     - /t5515/* eol=lf
     - /t556x_common eol=lf
     - /t7500/* eol=lf
     -+/t7910/* eol=lf
     - /t8005/*.txt eol=lf
     - /t9*/*.dump eol=lf
     + t[0-9][0-9][0-9][0-9]/* -whitespace
     + /diff-lib/* eol=lf
     + /t0110/url-* binary
     ++/t3206/* eol=lf
     + /t3900/*.txt eol=lf
     + /t3901/*.txt eol=lf
     + /t4034/*/* eol=lf
      
      diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
      new file mode 100755
 12:  7273cc647 ! 12:  fb83ce71a range-diff: use color for the commit pairs
     @@ -20,11 +20,12 @@
       }
       
      -static void output_pair_header(struct strbuf *buf,
     -+static void output_pair_header(struct diff_options *diffopt, struct strbuf *buf,
     ++static void output_pair_header(struct diff_options *diffopt,
     ++			       struct strbuf *buf,
     + 			       struct strbuf *dashes,
       			       struct patch_util *a_util,
       			       struct patch_util *b_util)
       {
     - 	static char *dashes;
       	struct object_id *oid = a_util ? &a_util->oid : &b_util->oid;
       	struct commit *commit;
      +	char status;
     @@ -34,11 +35,10 @@
      +	const char *color_commit = diff_get_color_opt(diffopt, DIFF_COMMIT);
      +	const char *color;
       
     - 	if (!dashes) {
     - 		char *p;
     -@@
     - 			*p = '-';
     - 	}
     + 	if (!dashes->len)
     + 		strbuf_addchars(dashes, '-',
     + 				strlen(find_unique_abbrev(oid,
     + 							  DEFAULT_ABBREV)));
       
      +	if (!b_util) {
      +		color = color_old;
     @@ -57,7 +57,7 @@
       	strbuf_reset(buf);
      +	strbuf_addstr(buf, status == '!' ? color_old : color);
       	if (!a_util)
     - 		strbuf_addf(buf, "-:  %s ", dashes);
     + 		strbuf_addf(buf, "-:  %s ", dashes->buf);
       	else
       		strbuf_addf(buf, "%d:  %s ", a_util->i + 1,
       			    find_unique_abbrev(&a_util->oid, DEFAULT_ABBREV));
     @@ -77,7 +77,7 @@
      +		strbuf_addf(buf, "%s%s", color_reset, color_new);
       
       	if (!b_util)
     - 		strbuf_addf(buf, " -:  %s", dashes);
     + 		strbuf_addf(buf, " -:  %s", dashes->buf);
      @@
       		const char *commit_buffer = get_commit_buffer(commit, NULL);
       		const char *subject;
     @@ -99,24 +99,27 @@
       
       		/* Show unmatched LHS commit whose predecessors were shown. */
       		if (i < a->nr && a_util->matching < 0) {
     --			output_pair_header(&buf, a_util, NULL);
     -+			output_pair_header(diffopt, &buf, a_util, NULL);
     +-			output_pair_header(&buf, &dashes, a_util, NULL);
     ++			output_pair_header(diffopt,
     ++					   &buf, &dashes, a_util, NULL);
       			i++;
       			continue;
       		}
       
       		/* Show unmatched RHS commits. */
       		while (j < b->nr && b_util->matching < 0) {
     --			output_pair_header(&buf, NULL, b_util);
     -+			output_pair_header(diffopt, &buf, NULL, b_util);
     +-			output_pair_header(&buf, &dashes, NULL, b_util);
     ++			output_pair_header(diffopt,
     ++					   &buf, &dashes, NULL, b_util);
       			b_util = ++j < b->nr ? b->items[j].util : NULL;
       		}
       
       		/* Show matching LHS/RHS pair. */
       		if (j < b->nr) {
       			a_util = a->items[b_util->matching].util;
     --			output_pair_header(&buf, a_util, b_util);
     -+			output_pair_header(diffopt, &buf, a_util, b_util);
     +-			output_pair_header(&buf, &dashes, a_util, b_util);
     ++			output_pair_header(diffopt,
     ++					   &buf, &dashes, a_util, b_util);
       			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
       				patch_diff(a->items[b_util->matching].string,
       					   b->items[j].string, diffopt);
 13:  96a3073fb = 13:  9ccb9516a color: add the meta color GIT_COLOR_REVERSE
 14:  6be4baf60 = 14:  9de5bd229 diff: add an internal option to dual-color diffs of diffs
 15:  02e13c0c6 ! 15:  21b2f9e4b range-diff: offer to dual-color the diffs
     @@ -40,4 +40,4 @@
      +
       	if (argc == 2) {
       		if (!strstr(argv[0], ".."))
     - 			warning(_("no .. in range: '%s'"), argv[0]);
     + 			die(_("no .. in range: '%s'"), argv[0]);
 16:  dfa7b1e71 <  -:  --------- range-diff --dual-color: work around bogus white-space warning
  -:  --------- > 16:  f4252f2b2 range-diff --dual-color: fix bogus white-space warning
 17:  799da25ef ! 17:  9e09c6be6 range-diff: add a man page
     @@ -1,6 +1,6 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    range-diff: add a man page
     +    range-diff: populate the man page
      
          The bulk of this patch consists of a heavily butchered version of
          tbdiff's README written by Thomas Rast and Thomas Gummerer, lifted from
     @@ -9,17 +9,12 @@
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
      diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
     -new file mode 100644
     ---- /dev/null
     +--- a/Documentation/git-range-diff.txt
      +++ b/Documentation/git-range-diff.txt
      @@
     -+git-range-diff(1)
     -+==================
     -+
     -+NAME
     -+----
     -+git-range-diff - Compare two commit ranges (e.g. two versions of a branch)
     -+
     + ----
     + git-range-diff - Compare two commit ranges (e.g. two versions of a branch)
     + 
      +SYNOPSIS
      +--------
      +[verse]
     @@ -31,13 +26,13 @@
      +-----------
      +
      +This command shows the differences between two versions of a patch
     -+series, or more generally, two commit ranges (ignoring merges).
     ++series, or more generally, two commit ranges (ignoring merge commits).
      +
      +To that end, it first finds pairs of commits from both commit ranges
      +that correspond with each other. Two commits are said to correspond when
      +the diff between their patches (i.e. the author information, the commit
      +message and the commit diff) is reasonably small compared to the
     -+patches' size. See ``Algorithm` below for details.
     ++patches' size. See ``Algorithm`` below for details.
      +
      +Finally, the list of matching commits is shown in the order of the
      +second commit range, with unmatched commits being inserted just after
     @@ -150,6 +145,10 @@
      +The general idea is this: we generate a cost matrix between the commits
      +in both commit ranges, then solve the least-cost assignment.
      +
     ++The cost matrix is populated thusly: for each pair of commits, both
     ++diffs are generated and the "diff of diffs" is generated, with 3 context
     ++lines, then the number of lines in that diff is used as cost.
     ++
      +To avoid false positives (e.g. when a patch has been removed, and an
      +unrelated patch has been added between two iterations of the same patch
      +series), the cost matrix is extended to allow for that, by adding
     @@ -245,6 +244,6 @@
      +--------
      +linkgit:git-log[1]
      +
     -+GIT
     -+---
     -+Part of the linkgit:git[1] suite
     + GIT
     + ---
     + Part of the linkgit:git[1] suite
 18:  d05b54c60 ! 18:  9b3632324 completion: support `git range-diff`
     @@ -4,17 +4,11 @@
      
          Tab completion of `git range-diff` is very convenient, especially
          given that the revision arguments to specify the commit ranges to
     -    compare are typically more complex than, say, your grandfather's `git
     -    log` arguments.
     +    compare are typically more complex than, say, what is normally passed
     +    to `git log`.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    squash! WIP completion: support `git range-diff`
     -
     -    Revert "WIP completion: support `git range-diff`"
     -
     -    This reverts commit 2e7af652af9e53a19fd947f8ebe37a78043afa49.
     -
      diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
      --- a/contrib/completion/git-completion.bash
      +++ b/contrib/completion/git-completion.bash
 19:  144363006 <  -:  --------- range-diff: left-pad patch numbers
  -:  --------- > 19:  07ec215e8 range-diff: left-pad patch numbers
 20:  4a68b95ce ! 20:  b370468e7 range-diff: make --dual-color the default mode
     @@ -4,7 +4,7 @@
      
          After using this command extensively for the last two months, this
          developer came to the conclusion that even if the dual color mode still
     -    leaves a lot of room for confusion what was actually changed, the
     +    leaves a lot of room for confusion about what was actually changed, the
          non-dual color mode is substantially worse in that regard.
      
          Therefore, we really want to make the dual color mode the default.
     @@ -14,6 +14,15 @@
      diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
      --- a/Documentation/git-range-diff.txt
      +++ b/Documentation/git-range-diff.txt
     +@@
     + --------
     + [verse]
     + 'git range-diff' [--color=[<when>]] [--no-color] [<diff-options>]
     +-	[--dual-color] [--creation-factor=<factor>]
     ++	[--no-dual-color] [--creation-factor=<factor>]
     + 	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
     + 
     + DESCRIPTION
      @@
       
       OPTIONS
     @@ -25,7 +34,7 @@
      -	change in what exact lines were added.
      +--no-dual-color::
      +	When the commit diffs differ, `git range-diff` recreates the
     -+	original diffs' coloring, and add outer -/+ diff markers with
     ++	original diffs' coloring, and adds outer -/+ diff markers with
      +	the *background* being red/green to make it easier to see e.g.
      +	when there was a change in what exact lines were added. This is
      +	known to `range-diff` as "dual coloring". Use `--no-dual-color`
     @@ -34,6 +43,31 @@
       
       --creation-factor=<percent>::
       	Set the creation/deletion cost fudge factor to `<percent>`.
     +@@
     + show`'s output, and the third line colors the old commit red, the new
     + one green and the rest like `git show`'s commit header.
     + 
     +-The color-coded diff is actually a bit hard to read, though, as it
     +-colors the entire lines red or green. The line that added "What is
     +-unexpected" in the old commit, for example, is completely red, even if
     +-the intent of the old commit was to add something.
     ++A naive color-coded diff of diffs is actually a bit hard to read,
     ++though, as it colors the entire lines red or green. The line that added
     ++"What is unexpected" in the old commit, for example, is completely red,
     ++even if the intent of the old commit was to add something.
     + 
     +-To help with that, use the `--dual-color` mode. In this mode, the diff
     +-of diffs will retain the original diff colors, and prefix the lines with
     +--/+ markers that have their *background* red or green, to make it more
     +-obvious that they describe how the diff itself changed.
     ++To help with that, `range` uses the `--dual-color` mode by default. In
     ++this mode, the diff of diffs will retain the original diff colors, and
     ++prefix the lines with -/+ markers that have their *background* red or
     ++green, to make it more obvious that they describe how the diff itself
     ++changed.
     + 
     + 
     + Algorithm
      
      diff --git a/builtin/range-diff.c b/builtin/range-diff.c
      --- a/builtin/range-diff.c
  -:  --------- > 21:  d8498fb32 range-diff: use dim/bold cues to improve dual color mode

-- 
gitgitgadget
