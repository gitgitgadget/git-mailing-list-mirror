Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3E071F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 15:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbeKMBFa (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 20:05:30 -0500
Received: from mout.gmx.net ([212.227.15.15]:55807 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbeKMBFa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 20:05:30 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mdafs-1g7yHN0SOS-00PK65; Mon, 12
 Nov 2018 16:11:45 +0100
Date:   Mon, 12 Nov 2018 16:11:44 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, predatoramigo@gmail.com
Subject: Re: [PATCH v2 1/2] git-rebase, sequencer: extend --quiet option for
 the interactive machinery
In-Reply-To: <20181108060158.27145-2-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811121610350.39@tvgsbejvaqbjf.bet>
References: <20181108060158.27145-1-newren@gmail.com> <20181108060158.27145-2-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Ha+9QuOp1Mr69dZjSWgdo0V9DKJ2mnlCVf9X/mZgy+RhdA438cy
 ZT5Xde6W0HEbT8mU6mjmoDE1qSsdorkRcAbtdzQdxXJ0H5e/bD7OuFJLmkZuMKxQICYfeX9
 Q4F2eJPlNnpxSxXUpYRhMtPegFWFUITqtflmLvb0x6QaG5f8WyehPr9D5zmHvP1N1vgpEH0
 PmikS0ecwOIgn/Puw/Ilw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BL1RCAscoXI=:oDKmOP4RspeyRNxslw50FP
 0rUmlAWYn6piXh5a6cAsUdyHs/65XLWGVcDa+QiSjG7e6BZtmxMtPrgKPXO40sdktLtM3T5cd
 TGNAQgmZAR88rOXxn6e5XnJvKSfGmewFl1bs/C7myAQDvYPOEP+MxpjP9TVlezSGoOz/dQQGV
 QHOuNom5+BDM0fUaWIsVtL9B0zSpGzfx4kNhOEWSRrxhFwIyxBqHxO7Pvb0j/s8YeUJLxKziN
 AUoeHWfvXlB4kb5BfMUKrfND5pxfb6rYG5tPAPCCQLMlD8cMhtMZEEfnPyB7klDuH9IDXO2sY
 NAmg+RHUhbEaORdZNTsko4tMTecJ5U/ezygwKbVrGLLsOElk/Q3uVqfQSfvjibFapGzJxwaAD
 bA7Mcg1Dhgcuw9NgmA0P1dJH1J3wU/XnYYayzt3rPd9wRad5OCdrpeGApKv98aNUQmXoqcger
 su9dveaiODyHbduEwyLBzzxVGMdwg7HkPu5QAluMUcA7gcNsQqQDkewu1JKPGdecXDWIivEsP
 1YdFvlKnRBySFufWu0RB/FWBBwCtUIxmFJCJDtVKXa+BVFM99ZyjgK1vEXOvqBdSWneHSvz34
 MghBsMI9TDgzGMmyIo+ju0nw+GcYFIm/SPC0IHGv2hKlJMzdYZPhV1eNLdUMW1A2CIJjqhIPp
 q8+3R246gl5XGfeE7KeLe7WB8zOn1qri1KjF9o/HN2zAoxO81XZ/ztIkKDY078riYM7zkNDPn
 m8EtmdAQ9RLdQl8AcvDr7h2yHVm8z8tKZPcSb0vmXPcwp7VttcjCyM86PKpIt0mBP+S7N1Tt7
 Oz9XAy+Chbm/+HhHeGJ94cS5r3bTv914kyhvm36MROFDTmTXghX9h2sRgsiZoJKlZaClZQ2jM
 1ibXbyD52oXWs2JFNuB6fT0s0XrO0YzTwBJt8rVXJcnVfTYy3XomRhup/UuW+tUbNVKKXiiMT
 ZX3UAWsNi1Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 7 Nov 2018, Elijah Newren wrote:

> While 'quiet' and 'interactive' may sound like antonyms, the interactive
> machinery actually has logic that implements several
> interactive_rebase=implied cases (--exec, --keep-empty, --rebase-merges)
> which won't pop up an editor.  The rewrite of interactive rebase in C
> added a quiet option, though it only turns stats off.  Since we want to
> make the interactive machinery also take over for git-rebase--merge, it
> should fully implement the --quiet option.
> 
> git-rebase--interactive was already somewhat quieter than
> git-rebase--merge and git-rebase--am, possibly because cherry-pick has
> just traditionally been quieter.  As such, we only drop a few
> informational messages -- "Rebasing (n/m)" and "Succesfully rebased..."

Makes sense.

> Also, for simplicity, remove the differences in how quiet and verbose
> options were recorded.  Having one be signalled by the presence of a
> "verbose" file in the state_dir, while the other was signalled by the
> contents of a "quiet" file was just weirdly inconsistent.  (This
> inconsistency pre-dated the rewrite into C.)  Make them consistent by
> having them both key off the presence of the file.

I am slightly concerned that some creative power user could have written
scripts that rely on this behavior.

But only *slightly* concerned.

The patch looks correct.

Ciao,
Dscho

> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/rebase.c      |  5 +----
>  git-legacy-rebase.sh  |  2 +-
>  git-rebase--common.sh |  2 +-
>  sequencer.c           | 23 +++++++++++++----------
>  sequencer.h           |  1 +
>  5 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 0ee06aa363..be004406a6 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -181,10 +181,7 @@ static int read_basic_state(struct rebase_options *opts)
>  	if (get_oid(buf.buf, &opts->orig_head))
>  		return error(_("invalid orig-head: '%s'"), buf.buf);
>  
> -	strbuf_reset(&buf);
> -	if (read_one(state_dir_path("quiet", opts), &buf))
> -		return -1;
> -	if (buf.len)
> +	if (file_exists(state_dir_path("quiet", opts)))
>  		opts->flags &= ~REBASE_NO_QUIET;
>  	else
>  		opts->flags |= REBASE_NO_QUIET;
> diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
> index 75a08b2683..da27bfca5a 100755
> --- a/git-legacy-rebase.sh
> +++ b/git-legacy-rebase.sh
> @@ -113,7 +113,7 @@ read_basic_state () {
>  	else
>  		orig_head=$(cat "$state_dir"/head)
>  	fi &&
> -	GIT_QUIET=$(cat "$state_dir"/quiet) &&
> +	test -f "$state_dir"/quiet && GIT_QUIET=t
>  	test -f "$state_dir"/verbose && verbose=t
>  	test -f "$state_dir"/strategy && strategy="$(cat "$state_dir"/strategy)"
>  	test -f "$state_dir"/strategy_opts &&
> diff --git a/git-rebase--common.sh b/git-rebase--common.sh
> index 7e39d22871..dc18c682fa 100644
> --- a/git-rebase--common.sh
> +++ b/git-rebase--common.sh
> @@ -10,7 +10,7 @@ write_basic_state () {
>  	echo "$head_name" > "$state_dir"/head-name &&
>  	echo "$onto" > "$state_dir"/onto &&
>  	echo "$orig_head" > "$state_dir"/orig-head &&
> -	echo "$GIT_QUIET" > "$state_dir"/quiet &&
> +	test t = "$GIT_QUIET" && : > "$state_dir"/quiet
>  	test t = "$verbose" && : > "$state_dir"/verbose
>  	test -n "$strategy" && echo "$strategy" > "$state_dir"/strategy
>  	test -n "$strategy_opts" && echo "$strategy_opts" > \
> diff --git a/sequencer.c b/sequencer.c
> index 9e1ab3a2a7..bd8337dbf1 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -150,6 +150,7 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
>  static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
>  static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
>  static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
> +static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
>  static GIT_PATH_FUNC(rebase_path_signoff, "rebase-merge/signoff")
>  static GIT_PATH_FUNC(rebase_path_head_name, "rebase-merge/head-name")
>  static GIT_PATH_FUNC(rebase_path_onto, "rebase-merge/onto")
> @@ -157,7 +158,6 @@ static GIT_PATH_FUNC(rebase_path_autostash, "rebase-merge/autostash")
>  static GIT_PATH_FUNC(rebase_path_strategy, "rebase-merge/strategy")
>  static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
>  static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
> -static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
>  
>  static int git_sequencer_config(const char *k, const char *v, void *cb)
>  {
> @@ -2307,6 +2307,9 @@ static int read_populate_opts(struct replay_opts *opts)
>  		if (file_exists(rebase_path_verbose()))
>  			opts->verbose = 1;
>  
> +		if (file_exists(rebase_path_quiet()))
> +			opts->quiet = 1;
> +
>  		if (file_exists(rebase_path_signoff())) {
>  			opts->allow_ff = 0;
>  			opts->signoff = 1;
> @@ -2374,9 +2377,6 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
>  
>  	if (quiet)
>  		write_file(rebase_path_quiet(), "%s\n", quiet);
> -	else
> -		write_file(rebase_path_quiet(), "\n");
> -
>  	if (opts->verbose)
>  		write_file(rebase_path_verbose(), "%s", "");
>  	if (opts->strategy)
> @@ -3450,10 +3450,11 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  					fprintf(f, "%d\n", todo_list->done_nr);
>  					fclose(f);
>  				}
> -				fprintf(stderr, "Rebasing (%d/%d)%s",
> -					todo_list->done_nr,
> -					todo_list->total_nr,
> -					opts->verbose ? "\n" : "\r");
> +				if (!opts->quiet)
> +					fprintf(stderr, "Rebasing (%d/%d)%s",
> +						todo_list->done_nr,
> +						todo_list->total_nr,
> +						opts->verbose ? "\n" : "\r");
>  			}
>  			unlink(rebase_path_message());
>  			unlink(rebase_path_author_script());
> @@ -3684,8 +3685,10 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  		}
>  		apply_autostash(opts);
>  
> -		fprintf(stderr, "Successfully rebased and updated %s.\n",
> -			head_ref.buf);
> +		if (!opts->quiet)
> +			fprintf(stderr,
> +				"Successfully rebased and updated %s.\n",
> +				head_ref.buf);
>  
>  		strbuf_release(&buf);
>  		strbuf_release(&head_ref);
> diff --git a/sequencer.h b/sequencer.h
> index 660cff5050..45fd977bef 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -39,6 +39,7 @@ struct replay_opts {
>  	int allow_empty_message;
>  	int keep_redundant_commits;
>  	int verbose;
> +	int quiet;
>  
>  	int mainline;
>  
> -- 
> 2.19.1.858.g526e8fe740.dirty
> 
> 
