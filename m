Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 895541F453
	for <e@80x24.org>; Mon, 21 Jan 2019 16:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbfAUQKy (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 11:10:54 -0500
Received: from mout.gmx.net ([212.227.17.22]:37115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729415AbfAUQKx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 11:10:53 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXllr-1ggISp2w2Z-00WkhQ; Mon, 21
 Jan 2019 17:10:44 +0100
Date:   Mon, 21 Jan 2019 17:10:28 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, predatoramigo@gmail.com,
        phillip.wood@talktalk.net
Subject: Re: [PATCH v4 5/8] git-rebase, sequencer: extend --quiet option for
 the interactive machinery
In-Reply-To: <20181211161139.31686-6-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901211709090.41@tvgsbejvaqbjf.bet>
References: <20181122044841.20993-1-newren@gmail.com> <20181211161139.31686-1-newren@gmail.com> <20181211161139.31686-6-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:w7MB8u0Hfb16F3eCHYCyXeM/DxERHw8BPIbcPmBEXKoRTUeRY2g
 RrDKnJA1iYT/JO665ecghDDf6LaMbMrBa85A1aCPi5bEQ/ny1ZsEv8n68LUCBOwsPcLwupz
 JZ68LhSv1tLDrof8aZ/VNxvBkVwVcDw3so4q0XvTMIvmX+alSWXfj8ikR0zihePFba9LT0p
 lfji/1Gj2sqvBt0n8qecA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FVcMjSRZWLk=:QnkAYamxvvzq+OouEa25uJ
 tHALtYI+AitGYVGRET/DNmARIfMVz9+eA/x/ezQ1xtCpyEu/kXqYAVqf2CB1UR7iyFZbCfTT8
 urBMe2ueA6s13/HmAgkKcNJU4LAMu7z/12wIJ7bvAZgEgtHPsRIfGv1iEPq4WJfTzMezT3qgV
 Th3Nhm6SoVusYjjm6E2N8aXohwwgrqQZFys7d17j7HccAydDg7vaT57UREPkolYX5xrLO8nf8
 kz8MeFT36NHzRyLGO9JVT/SaeVagLJYOk6OCtncZFTdtTQTDrCzKhJn+fI7naNNA9qwcuRFgc
 /UWsxCL8sqM82y1e5fdNPYO3arB3ACvrMqRnfOCVHfO4pAKmvYYMEO7L+djAliZGxETCir0VR
 8u6mGfr2UQdJX5s1EaVuA1mYVK55xHTjAphQXl8l1xBssJcmBun+sg7lCkZPmwBWFNkilMjTF
 y6lkKUIz8qQ9rTehqkU+Js5H5LjBELn4r4omeH/KxI7euesBZT0DtcvpmZLYxPh0wsDCrTUI/
 rp/2a1pHR/tG60qExGlhWQZ8HdVt9obfIvaZ9LCRQsbzhJ46qzYieIR/HlyfGEKPyFpiaQG5w
 36hpszP2dRX4fPhHrvFreHtW0F+scmvX3JE0awcKOpNA6pxrq/PmG9Mwxpj6DQzLDrzZrFTlQ
 a1z3JYjU7jR11IJbXgJAkvRPbCYEWW0N/GHgsq5yqu8vpp3t5TtT03L6qEmwjFLDvUUfGKA8J
 G39TE9alSM4ug5idfcX8u/W3Y2sFWEE3YXdnizreP3Cp0TbAR+ptgLarcLXGwReNJsHCxRHEp
 /bxzbInlzylXvqNfkpFujM2GuIlUHR/3AR0UOxL9XGOfjZNKaFkEDjJiPvRyTabjzFWqoTcko
 T8aK6odYjSs+fne0xW6ay0uxU4r+pCc8fZ9xK+25fQ0pJJOXR2KtW/uOYp+OoSywQkH5yMyR5
 b4jXTpBywLA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 11 Dec 2018, Elijah Newren wrote:

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
> informational messages -- "Rebasing (n/m)" and "Successfully rebased..."
> 
> Also, for simplicity, remove the differences in how quiet and verbose
> options were recorded.  Having one be signalled by the presence of a
> "verbose" file in the state_dir, while the other was signalled by the
> contents of a "quiet" file was just weirdly inconsistent.  (This
> inconsistency pre-dated the rewrite into C.)  Make them consistent by
> having them both key off the presence of the file.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>

This is convincing. I would like to point out, though...

> ---
>  builtin/rebase.c      |  5 +----
>  git-legacy-rebase.sh  |  2 +-
>  git-rebase--common.sh |  2 +-
>  sequencer.c           | 23 +++++++++++++----------
>  sequencer.h           |  1 +
>  5 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 78e982298f..ec2e5fbf23 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -185,10 +185,7 @@ static int read_basic_state(struct rebase_options *opts)
>  	if (get_oid(buf.buf, &opts->orig_head))
>  		return error(_("invalid orig-head: '%s'"), buf.buf);
>  
> -	strbuf_reset(&buf);
> -	if (read_one(state_dir_path("quiet", opts), &buf))
> -		return -1;
> -	if (buf.len)
> +	if (file_exists(state_dir_path("quiet", opts)))

This changes the behavior. AFAIR the `quiet` file was always written, but
contained `t` in quiet mode. I have to interrupt my review here, and will
continue later, but maybe you will beat me to looking into that.

Ciao,
Dscho

>  		opts->flags &= ~REBASE_NO_QUIET;
>  	else
>  		opts->flags |= REBASE_NO_QUIET;
> diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
> index fccb33b959..f4088b7bda 100755
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
> index e1a4dd15f1..bc25615050 100644
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
> @@ -2357,6 +2357,9 @@ static int read_populate_opts(struct replay_opts *opts)
>  		if (file_exists(rebase_path_verbose()))
>  			opts->verbose = 1;
>  
> +		if (file_exists(rebase_path_quiet()))
> +			opts->quiet = 1;
> +
>  		if (file_exists(rebase_path_signoff())) {
>  			opts->allow_ff = 0;
>  			opts->signoff = 1;
> @@ -2424,9 +2427,6 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
>  
>  	if (quiet)
>  		write_file(rebase_path_quiet(), "%s\n", quiet);
> -	else
> -		write_file(rebase_path_quiet(), "\n");
> -
>  	if (opts->verbose)
>  		write_file(rebase_path_verbose(), "%s", "");
>  	if (opts->strategy)
> @@ -3503,10 +3503,11 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
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
> @@ -3738,8 +3739,10 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
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
> index 5071a73563..729222b583 100644
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
> 2.20.0.8.g5de428d695
> 
> 
