Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC580211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 08:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeK2Th2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 14:37:28 -0500
Received: from mout.gmx.net ([212.227.17.20]:38821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbeK2Th2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 14:37:28 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LaKaw-1fgH0T2tag-00m3XS; Thu, 29
 Nov 2018 09:32:47 +0100
Date:   Thu, 29 Nov 2018 09:32:48 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul Morelle <paul.morelle@gmail.com>
cc:     Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] rebase -i: introduce the 'test' command
In-Reply-To: <25e07b91-3089-153c-2ecf-7d2d66bc3b65@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811281935310.41@tvgsbejvaqbjf.bet>
References: <3fb5a7ff-a63a-6fac-1456-4dbc9135d088@gmail.com> <nycvar.QRO.7.76.6.1811281600240.41@tvgsbejvaqbjf.bet> <25e07b91-3089-153c-2ecf-7d2d66bc3b65@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Xotf4LTARli7hosc5vdhRM1Q0Nq0gE9rwm+HtFBfCIPk8OmXuk6
 k0anEGqF/iCK5NiluadxsKtjMSXRfnLQ0iLOUExCtevU6zLh872Yyx1lXfwRKXgEIVpt9hY
 8zhXIZDLFud2fn7lJgxa7Tg/eyqrecZktF32cyOdf2oxF5SSr9gC7MgvKxYmylFooJnadvP
 IZ8G/dx0HBK1elFT89Y4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rzFBpp2QGN8=:FmvDKX6YBMSzdNUDBjFTz0
 WyefZUMk/XZStAiCopZH1oqd82PS4aLK6ItNcdnL00zM1Af1BM/gkg6FyVVn7QPvK4LPSO9RG
 awf9ldZSh4KBVNsoicUbZxH73Yu3tv8AloKC5BzVN3LUqhh0I9pTf0eOOXIq9b/HDVKVMipo1
 oTm9GYipPWZv5xViZ07FFoMT+68mK+gPnOhM3FF2C6x+cKcEASOnQaVt4F7jqKNNCMkbFyEW9
 /kp8tIlo/rJz7Ot7DHioyPO+AX47LuULOqLd5V1gAEAySC59ANw+rfdqIbsc4PWqT7RNLbuIs
 BwdIb2w5KWP7LrFZOHr2AQEl2VouW0NEq/eFmD+N166E0VpkZdRuKRcZgEkBS4JmAo4+tXvO8
 gAvyLPhev4hTdGrnDlLO844crUPX2/7v3yiw/I9TDLPfgcHsFe6+YWJ622FsaTJzq/bYinh6T
 jxJjuBmtXSXLoDWhSBccrTfYjF/J2qItT5+E615Hl1LZ2SfbOvHG/ccoISsITbaOmOz/YlV99
 wXP11ksHiYvGXYnGYC0Q0q4P0vB+yK/H9ETcsksFMP6E1UojXQmne3B2uRf2zaJsJTfKeotpp
 XhbkxpFY6lENF+hdGrQ997+bMRebtQXfxPp0OHkgnEgDuC3daI3nfoXDFZ65R1AJz6n4D5EN4
 61O5uOuLo6a4utV2CvhCllWfr2MNmIM3wcizz6v6FDoWlcnrks4+DBtOvXrrrrPzk9NIdzosq
 jNjj14i14XnfL3X0hQd+zrvk2oLQla8JBhan4D72hWkTey4mCoO55YEbu8AV1aBI93amM/EVh
 CD1DUOo0rLbAoZ2nrKdCxZ+Aytr/ZQrdK02L1xBmUmJY0WBb1Nj7i/eH6Mpoggcv8UiePp+3d
 JnSO0X3WBCQuc6CUMBhF6iBNYv/Xrv67WS4IpMZP86GaJzaw/0QeLhwiA6QyIyMaRho9LgqQf
 SxkCXktc7rg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Wed, 28 Nov 2018, Paul Morelle wrote:

> On 28/11/18 16:19, Johannes Schindelin wrote:
> >
> > On Wed, 28 Nov 2018, Paul Morelle wrote:
> >
> >> The 'exec' command can be used to run tests on a set of commits,
> >> interrupting on failing commits to let the user fix the tests.
> >>
> >> However, the 'exec' line has been consumed, so it won't be ran again by
> >> 'git rebase --continue' is ran, even if the tests weren't fixed.
> >>
> >> This commit introduces a new command 'test' equivalent to 'exec', except
> >> that it is automatically rescheduled in the todo list if it fails.
> >>
> >> Signed-off-by: Paul Morelle <paul.morelle@gmail.com>
> > Would it not make more sense to add a command-line option (and a config
> > setting) to re-schedule failed `exec` commands? Like so:
> 
> Your proposition would do in most cases, however it is not possible to
> make a distinction between reschedulable and non-reschedulable commands.

True. But I don't think that's so terrible.

What I think is something to avoid is two commands that do something very,
very similar, but with two very, very different names.

In reality, I think that it would even make sense to change the default to
reschedule failed `exec` commands. Which is why I suggested to also add a
config option.

> Do you think that we can ignore the distinction between reschedulable
> and non-reschedulable commands in the same script?

Yes, I think that there *should not* be any distinction. It would just
make it harder to use the feature (users would have to keep in mind that
one version reschedules, one version does not).

> In this case, I would add some tests to your patch below, and propose
> the result on this mailing list.

I already added a test... See the reschedule-failed-exec branch on
https://github.com/dscho/git.

And I had another idea. To make this feature more useful for *myself*, I
would like to introduce the `-X` option as a shortcut for
`--reschedule-failed-exec -x`, e.g.

	git rebase -X "make -j15 test" <base>

What do you think?
Johannes

> 
> > -- snip --
> > diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
> > index a2ab68ed0632..a9ab009fdbca 100644
> > --- a/builtin/rebase--interactive.c
> > +++ b/builtin/rebase--interactive.c
> > @@ -192,6 +192,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
> >  		OPT_STRING(0, "onto-name", &onto_name, N_("onto-name"), N_("onto name")),
> >  		OPT_STRING(0, "cmd", &cmd, N_("cmd"), N_("the command to run")),
> >  		OPT_RERERE_AUTOUPDATE(&opts.allow_rerere_auto),
> > +		OPT_BOOL(0, "reschedule-failed-exec", &opts.reschedule_failed_exec,
> > +			 N_("automatically re-schedule any `exec` that fails")),
> >  		OPT_END()
> >  	};
> >  
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 5b3e5baec8a0..700cbc4e150e 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -104,6 +104,7 @@ struct rebase_options {
> >  	int rebase_merges, rebase_cousins;
> >  	char *strategy, *strategy_opts;
> >  	struct strbuf git_format_patch_opt;
> > +	int reschedule_failed_exec;
> >  };
> >  
> >  static int is_interactive(struct rebase_options *opts)
> > @@ -415,6 +416,8 @@ static int run_specific_rebase(struct rebase_options *opts)
> >  			argv_array_push(&child.args, opts->gpg_sign_opt);
> >  		if (opts->signoff)
> >  			argv_array_push(&child.args, "--signoff");
> > +		if (opts->reschedule_failed_exec)
> > +			argv_array_push(&child.args, "--reschedule-failed-exec");
> >  
> >  		status = run_command(&child);
> >  		goto finished_rebase;
> > @@ -903,6 +906,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >  				   "strategy")),
> >  		OPT_BOOL(0, "root", &options.root,
> >  			 N_("rebase all reachable commits up to the root(s)")),
> > +		OPT_BOOL(0, "reschedule-failed-exec",
> > +			 &options.reschedule_failed_exec,
> > +			 N_("automatically re-schedule any `exec` that fails")),
> >  		OPT_END(),
> >  	};
> >  	int i;
> > @@ -1195,6 +1201,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >  		break;
> >  	}
> >  
> > +	if (options.reschedule_failed_exec && !is_interactive(&options))
> > +		die(_("--reschedule-failed-exec requires an interactive rebase"));
> > +
> >  	if (options.git_am_opts.argc) {
> >  		/* all am options except -q are compatible only with --am */
> >  		for (i = options.git_am_opts.argc - 1; i >= 0; i--)
> > diff --git a/sequencer.c b/sequencer.c
> > index e1a4dd15f1a8..69bee63e116f 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -158,6 +158,7 @@ static GIT_PATH_FUNC(rebase_path_strategy, "rebase-merge/strategy")
> >  static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
> >  static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
> >  static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
> > +static GIT_PATH_FUNC(rebase_path_reschedule_failed_exec, "rebase-merge/reschedule-failed-exec")
> >  
> >  static int git_sequencer_config(const char *k, const char *v, void *cb)
> >  {
> > @@ -2362,6 +2363,9 @@ static int read_populate_opts(struct replay_opts *opts)
> >  			opts->signoff = 1;
> >  		}
> >  
> > +		if (file_exists(rebase_path_reschedule_failed_exec()))
> > +			opts->reschedule_failed_exec = 1;
> > +
> >  		read_strategy_opts(opts, &buf);
> >  		strbuf_release(&buf);
> >  
> > @@ -2443,6 +2447,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
> >  		write_file(rebase_path_gpg_sign_opt(), "-S%s\n", opts->gpg_sign);
> >  	if (opts->signoff)
> >  		write_file(rebase_path_signoff(), "--signoff\n");
> > +	if (opts->reschedule_failed_exec)
> > +		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
> >  
> >  	return 0;
> >  }
> > @@ -3586,9 +3592,10 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
> >  			*end_of_arg = saved;
> >  
> >  			/* Reread the todo file if it has changed. */
> > -			if (res)
> > -				; /* fall through */
> > -			else if (stat(get_todo_path(opts), &st))
> > +			if (res) {
> > +				if (opts->reschedule_failed_exec)
> > +					reschedule = 1;
> > +			} else if (stat(get_todo_path(opts), &st))
> >  				res = error_errno(_("could not stat '%s'"),
> >  						  get_todo_path(opts));
> >  			else if (match_stat_data(&todo_list->stat, &st)) {
> > diff --git a/sequencer.h b/sequencer.h
> > index 5071a73563f1..1f865dae2618 100644
> > --- a/sequencer.h
> > +++ b/sequencer.h
> > @@ -39,6 +39,7 @@ struct replay_opts {
> >  	int allow_empty_message;
> >  	int keep_redundant_commits;
> >  	int verbose;
> > +	int reschedule_failed_exec;
> >  
> >  	int mainline;
> >  
> > -- snap --
> >
> > That would avoid your having to add a `--test` option accompanying the `--exec`
> > option (which is missing from your patch).
> 
> You are right about the missing `--test` option, which I could also add
> to a new version of this patch.
> 
> Cheers,
> Paul
> 
> > Ciao,
> > Johannes
> >
> >> ---
> >>  Documentation/git-rebase.txt  |  9 ++++++---
> >>  rebase-interactive.c          |  1 +
> >>  sequencer.c                   | 23 +++++++++++++++--------
> >>  t/lib-rebase.sh               |  4 +++-
> >>  t/t3404-rebase-interactive.sh | 16 ++++++++++++++++
> >>  5 files changed, 41 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> >> index 80793bad8..c8f565637 100644
> >> --- a/Documentation/git-rebase.txt
> >> +++ b/Documentation/git-rebase.txt
> >> @@ -693,8 +693,8 @@ $ git rebase -i -p --onto Q O
> >>  Reordering and editing commits usually creates untested intermediate
> >>  steps.  You may want to check that your history editing did not break
> >>  anything by running a test, or at least recompiling at intermediate
> >> -points in history by using the "exec" command (shortcut "x").  You may
> >> -do so by creating a todo list like this one:
> >> +points in history by using the "exec" command (shortcut "x") or the
> >> +"test" command.  You may do so by creating a todo list like this one:
> >>   -------------------------------------------
> >>  pick deadbee Implement feature XXX
> >> @@ -702,7 +702,7 @@ fixup f1a5c00 Fix to feature XXX
> >>  exec make
> >>  pick c0ffeee The oneline of the next commit
> >>  edit deadbab The oneline of the commit after
> >> -exec cd subdir; make test
> >> +test cd subdir; make test
> >>  ...
> >>  -------------------------------------------
> >>  @@ -715,6 +715,9 @@ in `$SHELL`, or the default shell if `$SHELL` is
> >> not set), so you can
> >>  use shell features (like "cd", ">", ";" ...). The command is run from
> >>  the root of the working tree.
> >>  +The "test" command does the same, but will remain in the todo list as
> >> +the next command, until it succeeds.
> >> +
> >>  ----------------------------------
> >>  $ git rebase -i --exec "make test"
> >>  ----------------------------------
> >> diff --git a/rebase-interactive.c b/rebase-interactive.c
> >> index 78f3263fc..4a408661d 100644
> >> --- a/rebase-interactive.c
> >> +++ b/rebase-interactive.c
> >> @@ -14,6 +14,7 @@ void append_todo_help(unsigned edit_todo, unsigned
> >> keep_empty,
> >>  "s, squash <commit> = use commit, but meld into previous commit\n"
> >>  "f, fixup <commit> = like \"squash\", but discard this commit's log
> >> message\n"
> >>  "x, exec <command> = run command (the rest of the line) using shell\n"
> >> +"   test <command> = same as exec command, but keep it in TODO if it
> >> fails\n"
> >>  "b, break = stop here (continue rebase later with 'git rebase
> >> --continue')\n"
> >>  "d, drop <commit> = remove commit\n"
> >>  "l, label <label> = label current HEAD with a name\n"
> >> diff --git a/sequencer.c b/sequencer.c
> >> index e1a4dd15f..c3dde6910 100644
> >> --- a/sequencer.c
> >> +++ b/sequencer.c
> >> @@ -1508,6 +1508,7 @@ enum todo_command {
> >>  	TODO_SQUASH,
> >>  	/* commands that do something else than handling a single commit */
> >>  	TODO_EXEC,
> >> +	TODO_TEST,
> >>  	TODO_BREAK,
> >>  	TODO_LABEL,
> >>  	TODO_RESET,
> >> @@ -1530,6 +1531,7 @@ static struct {
> >>  	{ 'f', "fixup" },
> >>  	{ 's', "squash" },
> >>  	{ 'x', "exec" },
> >> +	{ 0,   "test" },
> >>  	{ 'b', "break" },
> >>  	{ 'l', "label" },
> >>  	{ 't', "reset" },
> >> @@ -2072,7 +2074,7 @@ static int parse_insn_line(struct todo_item *item,
> >> const char *bol, char *eol)
> >>  			     command_to_string(item->command));
> >>   	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
> >> -	    item->command == TODO_RESET) {
> >> +	    item->command == TODO_RESET || item->command == TODO_TEST) {
> >>  		item->commit = NULL;
> >>  		item->arg = bol;
> >>  		item->arg_len = (int)(eol - bol);
> >> @@ -3576,7 +3578,7 @@ static int pick_commits(struct todo_list
> >> *todo_list, struct replay_opts *opts)
> >>  						item->arg, item->arg_len, opts,
> >>  						res, to_amend);
> >>  			}
> >> -		} else if (item->command == TODO_EXEC) {
> >> +		} else if (item->command == TODO_EXEC || item->command == TODO_TEST) {
> >>  			char *end_of_arg = (char *)(item->arg + item->arg_len);
> >>  			int saved = *end_of_arg;
> >>  			struct stat st;
> >> @@ -3586,9 +3588,12 @@ static int pick_commits(struct todo_list
> >> *todo_list, struct replay_opts *opts)
> >>  			*end_of_arg = saved;
> >>   			/* Reread the todo file if it has changed. */
> >> -			if (res)
> >> +			if (res) {
> >>  				; /* fall through */
> >> -			else if (stat(get_todo_path(opts), &st))
> >> +				if (item->command == TODO_TEST) {
> >> +					reschedule = 1;
> >> +				}
> >> +			} else if (stat(get_todo_path(opts), &st))
> >>  				res = error_errno(_("could not stat '%s'"),
> >>  						  get_todo_path(opts));
> >>  			else if (match_stat_data(&todo_list->stat, &st)) {
> >> @@ -3622,10 +3627,12 @@ static int pick_commits(struct todo_list
> >> *todo_list, struct replay_opts *opts)
> >>  			return error(_("unknown command %d"), item->command);
> >>   		if (reschedule) {
> >> -			advise(_(rescheduled_advice),
> >> -			       get_item_line_length(todo_list,
> >> -						    todo_list->current),
> >> -			       get_item_line(todo_list, todo_list->current));
> >> +			if (item->command != TODO_TEST) {
> >> +				advise(_(rescheduled_advice),
> >> +				       get_item_line_length(todo_list,
> >> +							    todo_list->current),
> >> +				       get_item_line(todo_list, todo_list->current));
> >> +			}
> >>  			todo_list->current--;
> >>  			if (save_todo(todo_list, opts))
> >>  				return -1;
> >> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> >> index 7ea30e500..7d36f00bd 100644
> >> --- a/t/lib-rebase.sh
> >> +++ b/t/lib-rebase.sh
> >> @@ -19,6 +19,8 @@
> >>  #
> >>  #   "exec_cmd_with_args" -- add an "exec cmd with args" line.
> >>  #
> >> +#   "test_cmd_with_args" -- add a "test cmd with args" line.
> >> +#
> >>  #   "#" -- Add a comment line.
> >>  #
> >>  #   ">" -- Add a blank line.
> >> @@ -49,7 +51,7 @@ set_fake_editor () {
> >>  		case $line in
> >>  		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d)
> >>  			action="$line";;
> >> -		exec_*|x_*|break|b)
> >> +		exec_*|x_*|break|b|test_*)
> >>  			echo "$line" | sed 's/_/ /g' >> "$1";;
> >>  		"#")
> >>  			echo '# comment' >> "$1";;
> >> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> >> index 7a440e08d..14c60b14d 100755
> >> --- a/t/t3404-rebase-interactive.sh
> >> +++ b/t/t3404-rebase-interactive.sh
> >> @@ -1453,4 +1453,20 @@ test_expect_success 'valid author header when
> >> author contains single quote' '
> >>  	test_cmp expected actual
> >>  '
> >>  +test_expect_success 'rebase -i keeps test until it passes' '
> >> +	git checkout master &&
> >> +	(
> >> +	set_fake_editor &&
> >> +	FAKE_LINES="1 test_false 2 3 4 5" &&
> >> +	export FAKE_LINES &&
> >> +	test_must_fail git rebase -i A &&
> >> +	test_cmp_rev B HEAD &&
> >> +	test_must_fail git rebase --continue &&
> >> +	test_cmp_rev B HEAD &&
> >> +	FAKE_LINES="test_true 2 3 4" git rebase --edit-todo &&
> >> +	git rebase --continue
> >> +	) &&
> >> +	test_cmp_rev master HEAD
> >> +'
> >> +
> >>  test_done
> >> -- 
> >> 2.19.1
> >>
> >>
> 
