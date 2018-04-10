Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE2A11F404
	for <e@80x24.org>; Tue, 10 Apr 2018 12:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752925AbeDJM3i (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 08:29:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:50507 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752829AbeDJM3h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 08:29:37 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M08ia-1eBhPd1R5o-00uMBE; Tue, 10 Apr 2018 14:29:25 +0200
Date:   Tue, 10 Apr 2018 14:29:23 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v6 00/15] rebase -i: offer to recreate commit topology
In-Reply-To: <cover.1519680483.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1523362469.git.johannes.schindelin@gmx.de>
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tKpq8unb7Psx7zxOYJzR/Ah58xbhYm9gmSz/kbTgBPbu5GNUGtZ
 i++kxsSIYPYMljb6cHSDE7F64v7sGJTjOsWRTHWRQUyZy6/cK5siaBErsiu1jQA4J7RHYAD
 vle8pAAaIJbms1xntDUmJvOLPudHnRftOm9aVpqhS290GRFiEr6/20tvG1c9xaOWggGYDLS
 l1CBfkr7XHb6ZdvPdqHEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YnNZ6HurnyY=:q4yWDprwvLlWpShflTnIy9
 OgJdNeRin1aofIV67GC0n/1rZL5Qq2RuUMuLwp6IIMsUGzPj5bMBGy6ILwjQse2nGTgPLk906
 Vl3kZiDtcfBR/xYLqrj6NFMmafdacP53jd3cm7vcur58tqxodPch25bBxg+7hPjlcgYRkYDxS
 zf6we4oCF8alGwkHQ7iEwcQc1sQ1eaVtXI2t/+6WWCI/c0Xj2FiCF/tOL9qGigiOdiewmOf86
 zlyM8LAuwifG+sWnzqmm3fOriZvvVrD/4Stjf8y1mSSO8ita+4i8OVRPEChuUTbuZLd83kCuG
 zSI+3zxi5EdJkYj6rjrJq5V6wEO9R5921C8KJrFT7hKM390xZdxxaMhUGeXsVQlyxIW9k4B0h
 W3oZnPXf41bLg66m8k7v+L6dfsVqhG6aX+KXqMZtW62vtFNGNX93v9dbJob30u4vNooig1idk
 LFk3aRJEfKZbA5FSJKQpjm444fXErOBfvnhILmKmLk7IG2rATZRaeIw8gzZEjEoKRi92y+x4k
 p8jY042vRddEeopgrwU4TAX3MZpwCE3k0e4dP4NK8Hf0eJzBJq0sBvX6FC60RC38EuxcN7fFJ
 YThtmqWk/B/o7SmBtQzLhEd7Bl8Vm0yO4RC+M8SJ5A90uJDEtjSjgfqGC+l6/jZPEfWyX9ztj
 QYy9vhVanEPgDAu67jw68zmayU5k6xTjVSzrixdB0LyWxAW1MpCfzWXOw4zrUermVKyo3LvIY
 Fr1SP3GjyOaT0JQltN3ybLYRPYg77gHG2qbD9X0Hc/fe0kO6fC5azr7QdxL5qyih4in2fYyfx
 mxjtn8vC47ZCHs2SHC5QkTAP43yNsT/FSkKz2Fqg1iv/zVoS2I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once upon a time, I dreamt of an interactive rebase that would not
flatten branch structure, but instead recreate the commit topology
faithfully.

My original attempt was --preserve-merges, but that design was so
limited that I did not even enable it in interactive mode.

Subsequently, it *was* enabled in interactive mode, with the predictable
consequences: as the --preserve-merges design does not allow for
specifying the parents of merge commits explicitly, all the new commits'
parents are defined *implicitly* by the previous commit history, and
hence it is *not possible to even reorder commits*.

This design flaw cannot be fixed. Not without a complete re-design, at
least. This patch series offers such a re-design.

Think of --rebase-merges as "--preserve-merges done right". It
introduces new verbs for the todo list, `label`, `reset` and `merge`.
For a commit topology like this:

            A - B - C
              \   /
                D

the generated todo list would look like this:

            # branch D
            pick 0123 A
            label branch-point
            pick 1234 D
            label D

            reset branch-point
            pick 2345 B
            merge -C 3456 D # C

There are more patches in the pipeline, based on this patch series, but
left for later in the interest of reviewable patch series: one mini
series to use the sequencer even for `git rebase -i --root`, and another
one to add support for octopus merges to --rebase-merges. And then one
to allow for rebasing merge commits in a smarter way (this one will need
a bit more work, though, as it can result in very complicated, nested
merge conflicts *very* easily).

Changes since v5 (sorry, this one is big, and so is the interdiff):

- rebased to `master`, resolving conflicts with `ws/rebase-p` and
  `pw/rebase-keep-empty-fixes` (these changes are not reflected in the
  interdiff because I still did not find a good way to represent such
  fixups).

- just like `git merge` refuses to merge ancestors of HEAD, so does now
  the todo command `merge`.

- `git remote -v`'s output now differs when pulling with --rebase-merges
  vs pulling with --interactive.

- the `merge` command now also gives rerere a chance (just like `pick`
  already does).

- simplified test for rebase-cousins (no need to run --rebase-merges
  interactively, so there is no need to override the editor either).

- fixed `safe_append()` to roll back the lock file even when *reading*
  failed.

- used `reflog_message()` in `do_reset()` rather than duplicating the
  logic.

- reworded misleading commit message talking about fast-forwarding merge
  commits, when we just fast-forward `merge` commands *to* those merge commits
  whenever possible.

- removed duplicate `if (can_fast_forward)` clause.

- stopped promising support for octopus merges in --make-script in this patch
  series (it will be added in a later patch series).

- fixed grammar error in the message of the commit adding support for
  post-rewrite hooks to handle commits processed via the `merge` command.

- folded TODO_MERGE_AND_EDIT into TODO_MERGE by using a new `flags`
  field.

- the code of `do_merge()` has been made more obvious by using a variable
  `oneline_offset` instead of the non-descriptive `p`.

- renamed the option to `rebase-merges`, in preparation for doing it
  smarter using Phillip Wood's strategy (this will be contributed in a
  follow-up patch series after two others that add support for octopus
  merges and for handling --root via the sequencer).

- included Phillip Wood's test for --keep-empty with the new mode (and folded
  in a fix into the code of the `merge` command).

- added -r as shortcut for --rebase-merges

- added an entire section about "REBASING MERGES" to git-rebase's man page.


Johannes Schindelin (13):
  sequencer: avoid using errno clobbered by rollback_lock_file()
  sequencer: make rearrange_squash() a bit more obvious
  sequencer: introduce new commands to reset the revision
  sequencer: introduce the `merge` command
  sequencer: fast-forward `merge` commands, if possible
  rebase-helper --make-script: introduce a flag to rebase merges
  rebase: introduce the --rebase-merges option
  sequencer: make refs generated by the `label` command worktree-local
  sequencer: handle post-rewrite for merge commands
  rebase --rebase-merges: avoid "empty merges"
  pull: accept --rebase=merges to recreate the branch topology
  rebase -i: introduce --rebase-merges=[no-]rebase-cousins
  rebase -i --rebase-merges: add a section to the man page

Phillip Wood (1):
  rebase --rebase-merges: add test for --keep-empty

Stefan Beller (1):
  git-rebase--interactive: clarify arguments

 Documentation/config.txt               |   8 +
 Documentation/git-pull.txt             |   5 +-
 Documentation/git-rebase.txt           | 140 ++++-
 builtin/pull.c                         |  14 +-
 builtin/rebase--helper.c               |  13 +-
 builtin/remote.c                       |  18 +-
 contrib/completion/git-completion.bash |   4 +-
 git-rebase--interactive.sh             |  22 +-
 git-rebase.sh                          |  16 +
 refs.c                                 |   3 +-
 sequencer.c                            | 775 ++++++++++++++++++++++++-
 sequencer.h                            |   7 +
 t/t3421-rebase-topology-linear.sh      |   1 +
 t/t3430-rebase-merges.sh               | 211 +++++++
 14 files changed, 1203 insertions(+), 34 deletions(-)
 create mode 100755 t/t3430-rebase-merges.sh


base-commit: 0b0cc9f86731f894cff8dd25299a9b38c254569e
Published-As: https://github.com/dscho/git/releases/tag/recreate-merges-v6
Fetch-It-Via: git fetch https://github.com/dscho/git recreate-merges-v6

Interdiff vs v5:
 diff --git a/Documentation/config.txt b/Documentation/config.txt
 index 85dc3a0c429..45916ea8104 100644
 --- a/Documentation/config.txt
 +++ b/Documentation/config.txt
 @@ -1058,7 +1058,7 @@ branch.<name>.rebase::
  	"git pull" is run. See "pull.rebase" for doing this in a non
  	branch-specific manner.
  +
 -When recreate, also pass `--recreate-merges` along to 'git rebase'
 +When `merges`, pass the `--rebase-merges` option to 'git rebase'
  so that locally committed merge commits will not be flattened
  by running 'git pull'.
  +
 @@ -2620,7 +2620,7 @@ pull.rebase::
  	pull" is run. See "branch.<name>.rebase" for setting this on a
  	per-branch basis.
  +
 -When recreate, also pass `--recreate-merges` along to 'git rebase'
 +When `merges`, pass the `--rebase-merges` option to 'git rebase'
  so that locally committed merge commits will not be flattened
  by running 'git pull'.
  +
 diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
 index b4f9f057ea9..6f76d815dd3 100644
 --- a/Documentation/git-pull.txt
 +++ b/Documentation/git-pull.txt
 @@ -101,15 +101,15 @@ Options related to merging
  include::merge-options.txt[]
  
  -r::
 ---rebase[=false|true|recreate|preserve|interactive]::
 +--rebase[=false|true|merges|preserve|interactive]::
  	When true, rebase the current branch on top of the upstream
  	branch after fetching. If there is a remote-tracking branch
  	corresponding to the upstream branch and the upstream branch
  	was rebased since last fetched, the rebase uses that information
  	to avoid rebasing non-local changes.
  +
 -When set to recreate, rebase with the `--recreate-merges` option passed
 -to `git rebase` so that locally created merge commits will not be flattened.
 +When set to `merges`, rebase using `git rebase --rebase-merges` so that
 +locally created merge commits will not be flattened.
  +
  When set to preserve, rebase with the `--preserve-merges` option passed
  to `git rebase` so that locally created merge commits will not be flattened.
 diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
 index 2b85416f969..be946de2efb 100644
 --- a/Documentation/git-rebase.txt
 +++ b/Documentation/git-rebase.txt
 @@ -378,16 +378,19 @@ The commit list format can be changed by setting the configuration option
  rebase.instructionFormat.  A customized instruction format will automatically
  have the long commit hash prepended to the format.
  
 ---recreate-merges[=(rebase-cousins|no-rebase-cousins)]::
 -	Recreate merge commits instead of flattening the history by replaying
 +-r::
 +--rebase-merges[=(rebase-cousins|no-rebase-cousins)]::
 +	Rebase merge commits instead of flattening the history by replaying
  	merges. Merge conflict resolutions or manual amendments to merge
 -	commits are not recreated automatically, but have to be recreated
 +	commits are not rebased automatically, but have to be applied
  	manually.
  +
  By default, or when `no-rebase-cousins` was specified, commits which do not
 -have `<upstream>` as direct ancestor keep their original branch point.
 +have `<upstream>` as direct ancestor will keep their original branch point.
  If the `rebase-cousins` mode is turned on, such commits are rebased onto
  `<upstream>` (or `<onto>`, if specified).
 ++
 +See also REBASING MERGES below.
  
  -p::
  --preserve-merges::
 @@ -786,13 +789,136 @@ The ripple effect of a "hard case" recovery is especially bad:
  'everyone' downstream from 'topic' will now have to perform a "hard
  case" recovery too!
  
 +REBASING MERGES
 +-----------------
 +
 +The interactive rebase command was originally designed to handle
 +individual patch series. As such, it makes sense to exclude merge
 +commits from the todo list, as the developer may have merged the
 +current `master` while working on the branch, only to eventually
 +rebase all the commits onto `master` (skipping the merge commits).
 +
 +However, there are legitimate reasons why a developer may want to
 +recreate merge commits: to keep the branch structure (or "commit
 +topology") when working on multiple, inter-related branches.
 +
 +In the following example, the developer works on a topic branch that
 +refactors the way buttons are defined, and on another topic branch
 +that uses that refactoring to implement a "Report a bug" button. The
 +output of `git log --graph --format=%s -5` may look like this:
 +
 +------------
 +*   Merge branch 'report-a-bug'
 +|\
 +| * Add the feedback button
 +* | Merge branch 'refactor-button'
 +|\ \
 +| |/
 +| * Use the Button class for all buttons
 +| * Extract a generic Button class from the DownloadButton one
 +------------
 +
 +The developer might want to rebase those commits to a newer `master`
 +while keeping the branch topology, for example when the first topic
 +branch is expected to be integrated into `master` much earlier than the
 +second one, say, to resolve merge conflicts with changes to the
 +DownloadButton class that made it into `master`.
 +
 +This rebase can be performed using the `--rebase-merges` option.
 +It will generate a todo list looking like this:
 +
 +------------
 +label onto
 +
 +# Branch: refactor-button
 +reset onto
 +pick 123456 Extract a generic Button class from the DownloadButton one
 +pick 654321 Use the Button class for all buttons
 +label refactor-button
 +
 +# Branch: report-a-bug
 +reset refactor-button # Use the Button class for all buttons
 +pick abcdef Add the feedback button
 +label report-a-bug
 +
 +reset onto
 +merge -C a1b2c3 refactor-button # Merge 'refactor-button'
 +merge -C 6f5e4d report-a-bug # Merge 'report-a-bug'
 +------------
 +
 +In contrast to a regular interactive rebase, there are `label`, `reset` and
 +`merge` commands in addition to `pick` ones.
 +
 +The `label` command puts a label to whatever will be the current
 +revision when that command is executed. Internally, these labels are
 +worktree-local refs that will be deleted when the rebase finishes or
 +when it is aborted. That way, rebase operations in multiple worktrees
 +linked to the same repository do not interfere with one another.
 +
 +The `reset` command is essentially a `git reset --hard` to the specified
 +revision (typically a previously-labeled one).
 +
 +The `merge` command will merge the specified revision into whatever is
 +HEAD at that time. With `-C <original-commit>`, the commit message of
 +the specified merge commit will be used. When the `-C` is changed to
 +a lower-case `-c`, the message will be opened in an editor after a
 +successful merge so that the user can edit the message.
 +
 +At this time, the `merge` command will *always* use the `recursive`
 +merge strategy, with no way to choose a different one. To work around
 +this, an `exec` command can be used to call `git merge` explicitly,
 +using the fact that the labels are worktree-local refs (the ref
 +`refs/rewritten/onto` would correspond to the label `onto`).
 +
 +Note: the first command (`reset onto`) labels the revision onto which
 +the commits are rebased; The name `onto` is just a convention, as a nod
 +to the `--onto` option.
 +
 +It is also possible to introduce completely new merge commits from scratch
 +by adding a command of the form `merge <merge-head>`. This form will
 +generate a tentative commit message and always open an editor to let the
 +user edit it. This can be useful e.g. when a topic branch turns out to
 +address more than a single concern and wants to be split into two or
 +even more topic branches. Consider this todo list:
 +
 +------------
 +pick 192837 Switch from GNU Makefiles to CMake
 +pick 5a6c7e Document the switch to CMake
 +pick 918273 Fix detection of OpenSSL in CMake
 +pick afbecd http: add support for TLS v1.3
 +pick fdbaec Fix detection of cURL in CMake on Windows
 +------------
 +
 +The one commit in this list that is not related to CMake may very well
 +have been motivated by working on fixing all those bugs introduced by
 +switching to CMake, but it addresses a different concern. To split this
 +branch into two topic branches, the todo list could be edited like this:
 +
 +------------
 +label onto
 +
 +pick afbecd http: add support for TLS v1.3
 +label tlsv1.3
 +
 +reset onto
 +pick 192837 Switch from GNU Makefiles to CMake
 +pick 918273 Fix detection of OpenSSL in CMake
 +pick fdbaec Fix detection of cURL in CMake on Windows
 +pick 5a6c7e Document the switch to CMake
 +label cmake
 +
 +reset onto
 +merge tlsv1.3
 +merge cmake
 +------------
 +
  BUGS
  ----
  The todo list presented by `--preserve-merges --interactive` does not
  represent the topology of the revision graph.  Editing commits and
  rewording their commit messages should work fine, but attempts to
  reorder commits tend to produce counterintuitive results. Use
 ---recreate-merges for a more faithful representation.
 +--rebase-merges for a more faithful representation.
  
  For example, an attempt to rearrange
  ------------
 diff --git a/builtin/pull.c b/builtin/pull.c
 index 3d1cc60eed6..70b44146ce4 100644
 --- a/builtin/pull.c
 +++ b/builtin/pull.c
 @@ -27,14 +27,14 @@ enum rebase_type {
  	REBASE_FALSE = 0,
  	REBASE_TRUE,
  	REBASE_PRESERVE,
 -	REBASE_RECREATE,
 +	REBASE_MERGES,
  	REBASE_INTERACTIVE
  };
  
  /**
   * Parses the value of --rebase. If value is a false value, returns
   * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value is
 - * "recreate", returns REBASE_RECREATE. If value is "preserve", returns
 + * "merges", returns REBASE_MERGES. If value is "preserve", returns
   * REBASE_PRESERVE. If value is a invalid value, dies with a fatal error if
   * fatal is true, otherwise returns REBASE_INVALID.
   */
 @@ -49,8 +49,8 @@ static enum rebase_type parse_config_rebase(const char *key, const char *value,
  		return REBASE_TRUE;
  	else if (!strcmp(value, "preserve"))
  		return REBASE_PRESERVE;
 -	else if (!strcmp(value, "recreate"))
 -		return REBASE_RECREATE;
 +	else if (!strcmp(value, "merges"))
 +		return REBASE_MERGES;
  	else if (!strcmp(value, "interactive"))
  		return REBASE_INTERACTIVE;
  
 @@ -134,7 +134,7 @@ static struct option pull_options[] = {
  	/* Options passed to git-merge or git-rebase */
  	OPT_GROUP(N_("Options related to merging")),
  	{ OPTION_CALLBACK, 'r', "rebase", &opt_rebase,
 -	  "false|true|recreate|preserve|interactive",
 +	  "false|true|merges|preserve|interactive",
  	  N_("incorporate changes by rebasing rather than merging"),
  	  PARSE_OPT_OPTARG, parse_opt_rebase },
  	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 @@ -804,8 +804,8 @@ static int run_rebase(const struct object_id *curr_head,
  	argv_push_verbosity(&args);
  
  	/* Options passed to git-rebase */
 -	if (opt_rebase == REBASE_RECREATE)
 -		argv_array_push(&args, "--recreate-merges");
 +	if (opt_rebase == REBASE_MERGES)
 +		argv_array_push(&args, "--rebase-merges");
  	else if (opt_rebase == REBASE_PRESERVE)
  		argv_array_push(&args, "--preserve-merges");
  	else if (opt_rebase == REBASE_INTERACTIVE)
 diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
 index 5d1f12de57b..f7c2a5fdc81 100644
 --- a/builtin/rebase--helper.c
 +++ b/builtin/rebase--helper.c
 @@ -12,7 +12,7 @@ static const char * const builtin_rebase_helper_usage[] = {
  int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
  {
  	struct replay_opts opts = REPLAY_OPTS_INIT;
 -	unsigned flags = 0, keep_empty = 0, recreate_merges = 0;
 +	unsigned flags = 0, keep_empty = 0, rebase_merges = 0;
  	int abbreviate_commands = 0, rebase_cousins = -1;
  	enum {
  		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 @@ -24,7 +24,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
  		OPT_BOOL(0, "keep-empty", &keep_empty, N_("keep empty commits")),
  		OPT_BOOL(0, "allow-empty-message", &opts.allow_empty_message,
  			N_("allow commits with empty messages")),
 -		OPT_BOOL(0, "recreate-merges", &recreate_merges, N_("recreate merge commits")),
 +		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
  		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
  			 N_("keep original branch points of cousins")),
  		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 @@ -60,13 +60,13 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
  
  	flags |= keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
  	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
 -	flags |= recreate_merges ? TODO_LIST_RECREATE_MERGES : 0;
 +	flags |= rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
  	flags |= rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
  	flags |= command == SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
  
 -	if (rebase_cousins >= 0 && !recreate_merges)
 +	if (rebase_cousins >= 0 && !rebase_merges)
  		warning(_("--[no-]rebase-cousins has no effect without "
 -			  "--recreate-merges"));
 +			  "--rebase-merges"));
  
  	if (command == CONTINUE && argc == 1)
  		return !!sequencer_continue(&opts);
 diff --git a/builtin/remote.c b/builtin/remote.c
 index 210890c8a8e..45c9219e07a 100644
 --- a/builtin/remote.c
 +++ b/builtin/remote.c
 @@ -245,7 +245,9 @@ static int add(int argc, const char **argv)
  struct branch_info {
  	char *remote_name;
  	struct string_list merge;
 -	enum { NO_REBASE, NORMAL_REBASE, INTERACTIVE_REBASE } rebase;
 +	enum {
 +		NO_REBASE, NORMAL_REBASE, INTERACTIVE_REBASE, REBASE_MERGES
 +	} rebase;
  };
  
  static struct string_list branch_list = STRING_LIST_INIT_NODUP;
 @@ -306,8 +308,8 @@ static int config_read_branches(const char *key, const char *value, void *cb)
  				info->rebase = v;
  			else if (!strcmp(value, "preserve"))
  				info->rebase = NORMAL_REBASE;
 -			else if (!strcmp(value, "recreate"))
 -				info->rebase = NORMAL_REBASE;
 +			else if (!strcmp(value, "merges"))
 +				info->rebase = REBASE_MERGES;
  			else if (!strcmp(value, "interactive"))
  				info->rebase = INTERACTIVE_REBASE;
  		}
 @@ -965,9 +967,15 @@ static int show_local_info_item(struct string_list_item *item, void *cb_data)
  
  	printf("    %-*s ", show_info->width, item->string);
  	if (branch_info->rebase) {
 -		printf_ln(branch_info->rebase == INTERACTIVE_REBASE
 -			  ? _("rebases interactively onto remote %s")
 -			  : _("rebases onto remote %s"), merge->items[0].string);
 +		const char *msg;
 +		if (branch_info->rebase == INTERACTIVE_REBASE)
 +			msg = _("rebases interactively onto remote %s");
 +		else if (branch_info->rebase == REBASE_MERGES)
 +			msg = _("rebases interactively (with merges) onto "
 +				"remote %s");
 +		else
 +			msg = _("rebases onto remote %s");
 +		printf_ln(msg, merge->items[0].string);
  		return 0;
  	} else if (show_info->any_rebase) {
  		printf_ln(_(" merges with remote %s"), merge->items[0].string);
 diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
 index 7d2e7062919..6af65155c59 100644
 --- a/contrib/completion/git-completion.bash
 +++ b/contrib/completion/git-completion.bash
 @@ -1949,7 +1949,7 @@ _git_rebase ()
  	--*)
  		__gitcomp "
  			--onto --merge --strategy --interactive
 -			--recreate-merges --preserve-merges --stat --no-stat
 +			--rebase-merges --preserve-merges --stat --no-stat
  			--committer-date-is-author-date --ignore-date
  			--ignore-whitespace --whitespace=
  			--autosquash --no-autosquash
 @@ -2120,7 +2120,7 @@ _git_config ()
  		return
  		;;
  	branch.*.rebase)
 -		__gitcomp "false true recreate preserve interactive"
 +		__gitcomp "false true merges preserve interactive"
  		return
  		;;
  	remote.pushdefault)
 diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
 index 4c21faaccb1..b4ad130e8b1 100644
 --- a/git-rebase--interactive.sh
 +++ b/git-rebase--interactive.sh
 @@ -970,7 +970,7 @@ git_rebase__interactive () {
  	init_revisions_and_shortrevisions
  
  	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
 -		${recreate_merges:+--recreate-merges} \
 +		${rebase_merges:+--rebase-merges} \
  		${rebase_cousins:+--rebase-cousins} \
  		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
  	die "$(gettext "Could not generate todo list")"
 diff --git a/git-rebase.sh b/git-rebase.sh
 index dd39dfb1112..157705d2a72 100755
 --- a/git-rebase.sh
 +++ b/git-rebase.sh
 @@ -17,7 +17,7 @@ q,quiet!           be quiet. implies --no-stat
  autostash          automatically stash/stash pop before and after
  fork-point         use 'merge-base --fork-point' to refine upstream
  onto=!             rebase onto given branch instead of upstream
 -recreate-merges?   try to recreate merges instead of skipping them
 +r,rebase-merges?   try to rebase merges instead of skipping them
  p,preserve-merges! try to recreate merges instead of ignoring them
  s,strategy=!       use the given merge strategy
  no-ff!             cherry-pick all commits, even if unchanged
 @@ -89,7 +89,7 @@ type=
  state_dir=
  # One of {'', continue, skip, abort}, as parsed from command line
  action=
 -recreate_merges=
 +rebase_merges=
  rebase_cousins=
  preserve_merges=
  autosquash=
 @@ -273,12 +273,12 @@ do
  	--allow-empty-message)
  		allow_empty_message=--allow-empty-message
  		;;
 -	--recreate-merges)
 -		recreate_merges=t
 +	--rebase-merges)
 +		rebase_merges=t
  		test -z "$interactive_rebase" && interactive_rebase=implied
  		;;
 -	--recreate-merges=*)
 -		recreate_merges=t
 +	--rebase-merges=*)
 +		rebase_merges=t
  		case "${1#*=}" in
  		rebase-cousins) rebase_cousins=t;;
  		no-rebase-cousins) rebase_cousins=;;
 diff --git a/sequencer.c b/sequencer.c
 index 0b6aaced9a5..809df1ce484 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -1308,7 +1308,6 @@ enum todo_command {
  	TODO_LABEL,
  	TODO_RESET,
  	TODO_MERGE,
 -	TODO_MERGE_AND_EDIT,
  	/* commands that do nothing but are counted for reporting progress */
  	TODO_NOOP,
  	TODO_DROP,
 @@ -1330,7 +1329,6 @@ static struct {
  	{ 'l', "label" },
  	{ 't', "reset" },
  	{ 'm', "merge" },
 -	{ 0, "merge" }, /* MERGE_AND_EDIT */
  	{ 0,   "noop" },
  	{ 'd', "drop" },
  	{ 0,   NULL }
 @@ -1758,9 +1756,14 @@ static int read_and_refresh_cache(struct replay_opts *opts)
  	return 0;
  }
  
 +enum todo_item_flags {
 +	TODO_EDIT_MERGE_MSG = 1
 +};
 +
  struct todo_item {
  	enum todo_command command;
  	struct commit *commit;
 +	unsigned int flags;
  	const char *arg;
  	int arg_len;
  	size_t offset_in_buf;
 @@ -1795,6 +1798,8 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
  	char *end_of_object_name;
  	int i, saved, status, padding;
  
 +	item->flags = 0;
 +
  	/* left-trim */
  	bol += strspn(bol, " \t");
  
 @@ -1849,9 +1854,9 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
  			bol += strspn(bol, " \t");
  		else if (skip_prefix(bol, "-c", &bol)) {
  			bol += strspn(bol, " \t");
 -			item->command = TODO_MERGE_AND_EDIT;
 +			item->flags |= TODO_EDIT_MERGE_MSG;
  		} else {
 -			item->command = TODO_MERGE_AND_EDIT;
 +			item->flags |= TODO_EDIT_MERGE_MSG;
  			item->commit = NULL;
  			item->arg = bol;
  			item->arg_len = (int)(eol - bol);
 @@ -2511,8 +2516,11 @@ static int safe_append(const char *filename, const char *fmt, ...)
  	if (fd < 0)
  		return -1;
  
 -	if (strbuf_read_file(&buf, filename, 0) < 0 && errno != ENOENT)
 -		return error_errno(_("could not read '%s'"), filename);
 +	if (strbuf_read_file(&buf, filename, 0) < 0 && errno != ENOENT) {
 +		error_errno(_("could not read '%s'"), filename);
 +		rollback_lock_file(&lock);
 +		return -1;
 +	}
  	strbuf_complete(&buf, '\n');
  	va_start(ap, fmt);
  	strbuf_vaddf(&buf, fmt, ap);
 @@ -2574,6 +2582,9 @@ static int do_label(const char *name, int len)
  	return ret;
  }
  
 +static const char *reflog_message(struct replay_opts *opts,
 +	const char *sub_action, const char *fmt, ...);
 +
  static int do_reset(const char *name, int len, struct replay_opts *opts)
  {
  	struct strbuf ref_name = STRBUF_INIT;
 @@ -2638,33 +2649,50 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
  		ret = error(_("could not write index"));
  	free((void *)desc.buffer);
  
 -	if (!ret) {
 -		struct strbuf msg = STRBUF_INIT;
 -
 -		strbuf_addf(&msg, "(rebase -i) reset '%.*s'", len, name);
 -		ret = update_ref(msg.buf, "HEAD", &oid, NULL, 0,
 -				 UPDATE_REFS_MSG_ON_ERR);
 -		strbuf_release(&msg);
 -	}
 +	if (!ret)
 +		ret = update_ref(reflog_message(opts, "reset", "'%.*s'",
 +						len, name), "HEAD", &oid,
 +				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
  
  	strbuf_release(&ref_name);
  	return ret;
  }
  
  static int do_merge(struct commit *commit, const char *arg, int arg_len,
 -		    int run_commit_flags, struct replay_opts *opts)
 +		    int flags, struct replay_opts *opts)
  {
 -	int merge_arg_len;
 +	int run_commit_flags = (flags & TODO_EDIT_MERGE_MSG) ?
 +		EDIT_MSG | VERIFY_MSG : 0;
  	struct strbuf ref_name = STRBUF_INIT;
  	struct commit *head_commit, *merge_commit, *i;
 -	struct commit_list *common, *j, *reversed = NULL;
 +	struct commit_list *bases, *j, *reversed = NULL;
  	struct merge_options o;
 -	int can_fast_forward, ret;
 +	int merge_arg_len, oneline_offset, can_fast_forward, ret;
  	static struct lock_file lock;
 +	const char *p;
  
 -	for (merge_arg_len = 0; merge_arg_len < arg_len; merge_arg_len++)
 -		if (isspace(arg[merge_arg_len]))
 -			break;
 +	oneline_offset = arg_len;
 +	merge_arg_len = strcspn(arg, " \t\n");
 +	p = arg + merge_arg_len;
 +	p += strspn(p, " \t\n");
 +	if (*p == '#' && (!p[1] || isspace(p[1]))) {
 +		p += 1 + strspn(p + 1, " \t\n");
 +		oneline_offset = p - arg;
 +	} else if (p - arg < arg_len)
 +		BUG("octopus merges are not supported yet: '%s'", p);
 +
 +	strbuf_addf(&ref_name, "refs/rewritten/%.*s", merge_arg_len, arg);
 +	merge_commit = lookup_commit_reference_by_name(ref_name.buf);
 +	if (!merge_commit) {
 +		/* fall back to non-rewritten ref or commit */
 +		strbuf_splice(&ref_name, 0, strlen("refs/rewritten/"), "", 0);
 +		merge_commit = lookup_commit_reference_by_name(ref_name.buf);
 +	}
 +	if (!merge_commit) {
 +		error(_("could not resolve '%s'"), ref_name.buf);
 +		strbuf_release(&ref_name);
 +		return -1;
 +	}
  
  	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
  		return -1;
 @@ -2697,7 +2725,6 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
  		}
  		unuse_commit_buffer(commit, message);
  	} else {
 -		const char *p = arg + merge_arg_len;
  		struct strbuf buf = STRBUF_INIT;
  		int len;
  
 @@ -2705,12 +2732,10 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
  		write_author_script(buf.buf);
  		strbuf_reset(&buf);
  
 -		p += strspn(p, " \t");
 -		if (*p == '#' && isspace(p[1]))
 -			p += 1 + strspn(p + 1, " \t");
 -		if (*p)
 -			len = strlen(p);
 -		else {
 +		if (oneline_offset < arg_len) {
 +			p = arg + oneline_offset;
 +			len = arg_len - oneline_offset;
 +		} else {
  			strbuf_addf(&buf, "Merge branch '%.*s'",
  				    merge_arg_len, arg);
  			p = buf.buf;
 @@ -2728,25 +2753,24 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
  	}
  
  	/*
 -	 * If HEAD is not identical to the parent of the original merge commit,
 -	 * we cannot fast-forward.
 +	 * If HEAD is not identical to the first parent of the original merge
 +	 * commit, we cannot fast-forward.
  	 */
  	can_fast_forward = opts->allow_ff && commit && commit->parents &&
  		!oidcmp(&commit->parents->item->object.oid,
  			&head_commit->object.oid);
  
 -	strbuf_addf(&ref_name, "refs/rewritten/%.*s", merge_arg_len, arg);
 -	merge_commit = lookup_commit_reference_by_name(ref_name.buf);
 -	if (!merge_commit) {
 -		/* fall back to non-rewritten ref or commit */
 -		strbuf_splice(&ref_name, 0, strlen("refs/rewritten/"), "", 0);
 -		merge_commit = lookup_commit_reference_by_name(ref_name.buf);
 -	}
 -	if (!merge_commit) {
 -		error(_("could not resolve '%s'"), ref_name.buf);
 -		strbuf_release(&ref_name);
 -		rollback_lock_file(&lock);
 -		return -1;
 +	/*
 +	 * If the merge head is different from the original one, we cannot
 +	 * fast-forward.
 +	 */
 +	if (can_fast_forward) {
 +		struct commit_list *second_parent = commit->parents->next;
 +
 +		if (second_parent && !second_parent->next &&
 +		    oidcmp(&merge_commit->object.oid,
 +			   &second_parent->item->object.oid))
 +			can_fast_forward = 0;
  	}
  
  	if (can_fast_forward && commit->parents->next &&
 @@ -2763,10 +2787,18 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
  		      git_path_merge_head(), 0);
  	write_message("no-ff", 5, git_path_merge_mode(), 0);
  
 -	common = get_merge_bases(head_commit, merge_commit);
 -	for (j = common; j; j = j->next)
 +	bases = get_merge_bases(head_commit, merge_commit);
 +	if (bases && !oidcmp(&merge_commit->object.oid,
 +			     &bases->item->object.oid)) {
 +		strbuf_release(&ref_name);
 +		rollback_lock_file(&lock);
 +		/* skip merging an ancestor of HEAD */
 +		return 0;
 +	}
 +
 +	for (j = bases; j; j = j->next)
  		commit_list_insert(j->item, &reversed);
 -	free_commit_list(common);
 +	free_commit_list(bases);
  
  	read_cache();
  	init_merge_options(&o);
 @@ -2775,6 +2807,8 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
  	o.buffer_output = 2;
  
  	ret = merge_recursive(&o, head_commit, merge_commit, reversed, &i);
 +	if (!ret)
 +		rerere(opts->allow_rerere_auto);
  	if (ret <= 0)
  		fputs(o.obuf.buf, stdout);
  	strbuf_release(&o.obuf);
 @@ -2986,11 +3020,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
  			res = do_label(item->arg, item->arg_len);
  		else if (item->command == TODO_RESET)
  			res = do_reset(item->arg, item->arg_len, opts);
 -		else if (item->command == TODO_MERGE ||
 -			 item->command == TODO_MERGE_AND_EDIT) {
 +		else if (item->command == TODO_MERGE) {
  			res = do_merge(item->commit, item->arg, item->arg_len,
 -				       item->command == TODO_MERGE_AND_EDIT ?
 -				       EDIT_MSG | VERIFY_MSG : 0, opts);
 +				       item->flags, opts);
  			if (item->commit)
  				record_in_rewritten(&item->commit->object.oid,
  						    peek_command(todo_list, 1));
 @@ -3404,7 +3436,7 @@ static const char *label_oid(struct object_id *oid, const char *label,
  		strbuf_grow(&state->buf, GIT_SHA1_HEXSZ);
  		label = p = state->buf.buf;
  
 -		find_unique_abbrev_r(p, oid->hash, default_abbrev);
 +		find_unique_abbrev_r(p, oid, default_abbrev);
  
  		/*
  		 * We may need to extend the abbreviated hash so that there is
 @@ -3508,11 +3540,13 @@ static int make_script_with_merges(struct pretty_print_context *pp,
  		int is_octopus;
  		const char *p1, *p2;
  		struct object_id *oid;
 +		int is_empty;
  
  		tail = &commit_list_insert(commit, tail)->next;
  		oidset_insert(&interesting, &commit->object.oid);
  
 -		if ((commit->object.flags & PATCHSAME))
 +		is_empty = is_original_commit_empty(commit);
 +		if (!is_empty && (commit->object.flags & PATCHSAME))
  			continue;
  
  		strbuf_reset(&oneline);
 @@ -3522,7 +3556,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
  		if (!to_merge) {
  			/* non-merge commit: easy case */
  			strbuf_reset(&buf);
 -			if (!keep_empty && is_original_commit_empty(commit))
 +			if (!keep_empty && is_empty)
  				strbuf_addf(&buf, "%c ", comment_line_char);
  			strbuf_addf(&buf, "%s %s %s", cmd_pick,
  				    oid_to_hex(&commit->object.oid),
 @@ -3698,11 +3732,11 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
  	struct commit *commit;
  	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
  	const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
 -	int recreate_merges = flags & TODO_LIST_RECREATE_MERGES;
 +	int rebase_merges = flags & TODO_LIST_REBASE_MERGES;
  
  	init_revisions(&revs, NULL);
  	revs.verbose_header = 1;
 -	if (recreate_merges)
 +	if (rebase_merges)
  		revs.cherry_mark = 1;
  	else {
  		revs.max_parents = 1;
 @@ -3731,7 +3765,7 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
  	if (prepare_revision_walk(&revs) < 0)
  		return error(_("make_script: error preparing revisions"));
  
 -	if (recreate_merges)
 +	if (rebase_merges)
  		return make_script_with_merges(&pp, &revs, out, flags);
  
  	while ((commit = get_revision(&revs))) {
 @@ -3823,10 +3857,12 @@ int transform_todos(unsigned flags)
  					  short_commit_name(item->commit) :
  					  oid_to_hex(&item->commit->object.oid);
  
 -			if (item->command == TODO_MERGE)
 -				strbuf_addstr(&buf, " -C");
 -			else if (item->command == TODO_MERGE_AND_EDIT)
 -				strbuf_addstr(&buf, " -c");
 +			if (item->command == TODO_MERGE) {
 +				if (item->flags & TODO_EDIT_MERGE_MSG)
 +					strbuf_addstr(&buf, " -c");
 +				else
 +					strbuf_addstr(&buf, " -C");
 +			}
  
  			strbuf_addf(&buf, " %s", oid);
  		}
 diff --git a/sequencer.h b/sequencer.h
 index 739dd0fa92b..d9570d92b11 100644
 --- a/sequencer.h
 +++ b/sequencer.h
 @@ -59,9 +59,9 @@ int sequencer_remove_state(struct replay_opts *opts);
  #define TODO_LIST_KEEP_EMPTY (1U << 0)
  #define TODO_LIST_SHORTEN_IDS (1U << 1)
  #define TODO_LIST_ABBREVIATE_CMDS (1U << 2)
 -#define TODO_LIST_RECREATE_MERGES (1U << 3)
 +#define TODO_LIST_REBASE_MERGES (1U << 3)
  /*
 - * When recreating merges, commits that do have the base commit as ancestor
 + * When rebasing merges, commits that do have the base commit as ancestor
   * ("cousins") are *not* rebased onto the new base by default. If those
   * commits should be rebased onto the new base, this flag needs to be passed.
   */
 diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
 index 68fe2003ef5..fbae5dab7e2 100755
 --- a/t/t3421-rebase-topology-linear.sh
 +++ b/t/t3421-rebase-topology-linear.sh
 @@ -217,6 +217,7 @@ test_run_rebase success ''
  test_run_rebase failure -m
  test_run_rebase failure -i
  test_run_rebase failure -p
 +test_run_rebase success --rebase-merges
  
  #       m
  #      /
 diff --git a/t/t3430-rebase-recreate-merges.sh b/t/t3430-rebase-merges.sh
 similarity index 87%
 rename from t/t3430-rebase-recreate-merges.sh
 rename to t/t3430-rebase-merges.sh
 index 9a59f12b670..ee006810573 100755
 --- a/t/t3430-rebase-recreate-merges.sh
 +++ b/t/t3430-rebase-merges.sh
 @@ -1,9 +1,9 @@
  #!/bin/sh
  #
 -# Copyright (c) 2017 Johannes E. Schindelin
 +# Copyright (c) 2018 Johannes E. Schindelin
  #
  
 -test_description='git rebase -i --recreate-merges
 +test_description='git rebase -i --rebase-merges
  
  This test runs git rebase "interactively", retaining the branch structure by
  recreating merge commits.
 @@ -19,6 +19,13 @@ Initial setup:
  . ./test-lib.sh
  . "$TEST_DIRECTORY"/lib-rebase.sh
  
 +test_cmp_graph () {
 +	cat >expect &&
 +	git log --graph --boundary --format=%s "$@" >output &&
 +	sed "s/ *$//" <output >output.trimmed &&
 +	test_cmp expect output.trimmed
 +}
 +
  test_expect_success 'setup' '
  	write_script replace-editor.sh <<-\EOF &&
  	mv "$1" "$(git rev-parse --git-path ORIGINAL-TODO)"
 @@ -63,17 +70,10 @@ merge -C H second
  merge onebranch # Merge the topic branch 'onebranch'
  EOF
  
 -test_cmp_graph () {
 -	cat >expect &&
 -	git log --graph --boundary --format=%s "$@" >output &&
 -	sed "s/ *$//" <output >output.trimmed &&
 -	test_cmp expect output.trimmed
 -}
 -
  test_expect_success 'create completely different structure' '
  	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
  	test_tick &&
 -	git rebase -i --recreate-merges A &&
 +	git rebase -i -r A &&
  	test_cmp_graph <<-\EOF
  	*   Merge the topic branch '\''onebranch'\''
  	|\
 @@ -132,7 +132,7 @@ test_expect_success 'with a branch tip that was cherry-picked already' '
  
  	git checkout already-upstream &&
  	test_tick &&
 -	git rebase -i --recreate-merges upstream-with-a2 &&
 +	git rebase -i -r upstream-with-a2 &&
  	test_cmp_graph upstream-with-a2.. <<-\EOF
  	*   Merge branch A
  	|\
 @@ -144,18 +144,13 @@ test_expect_success 'with a branch tip that was cherry-picked already' '
  '
  
  test_expect_success 'do not rebase cousins unless asked for' '
 -	write_script copy-editor.sh <<-\EOF &&
 -	cp "$1" "$(git rev-parse --git-path ORIGINAL-TODO)"
 -	EOF
 -
 -	test_config sequence.editor \""$PWD"/copy-editor.sh\" &&
  	git checkout -b cousins master &&
  	before="$(git rev-parse --verify HEAD)" &&
  	test_tick &&
 -	git rebase -i --recreate-merges HEAD^ &&
 +	git rebase -r HEAD^ &&
  	test_cmp_rev HEAD $before &&
  	test_tick &&
 -	git rebase -i --recreate-merges=rebase-cousins HEAD^ &&
 +	git rebase --rebase-merges=rebase-cousins HEAD^ &&
  	test_cmp_graph HEAD^.. <<-\EOF
  	*   Merge the topic branch '\''onebranch'\''
  	|\
 @@ -196,7 +191,7 @@ test_expect_success 'post-rewrite hook and fixups work for merges' '
  	echo "cat >actual" | write_script .git/hooks/post-rewrite &&
  
  	test_tick &&
 -	git rebase -i --autosquash --recreate-merges HEAD^^^ &&
 +	git rebase -i --autosquash -r HEAD^^^ &&
  	printf "%s %s\n%s %s\n%s %s\n%s %s\n" >expect $(git rev-parse \
  		$fixup^^2 HEAD^2 \
  		$fixup^^ HEAD^ \
 @@ -205,4 +200,12 @@ test_expect_success 'post-rewrite hook and fixups work for merges' '
  	test_cmp expect actual
  '
  
 +test_expect_success 'refuse to merge ancestors of HEAD' '
 +	echo "merge HEAD^" >script-from-scratch &&
 +	test_config -C wt sequence.editor \""$PWD"/replace-editor.sh\" &&
 +	before="$(git rev-parse HEAD)" &&
 +	git rebase -i HEAD &&
 +	test_cmp_rev HEAD $before
 +'
 +
  test_done
-- 
2.17.0.windows.1.4.g7e4058d72e3

