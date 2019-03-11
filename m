Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95E6120248
	for <e@80x24.org>; Mon, 11 Mar 2019 19:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfCKTcO (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 15:32:14 -0400
Received: from mout.gmx.net ([212.227.15.19]:59769 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727147AbfCKTcO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 15:32:14 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVe87-1hZ4Ps1qyl-00YvR4; Mon, 11
 Mar 2019 20:32:03 +0100
Date:   Mon, 11 Mar 2019 20:31:47 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] rebase: deprecate --preserve-merges
In-Reply-To: <3a418266-6506-d2c0-45d3-5f1c6f0375c6@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903112025470.41@tvgsbejvaqbjf.bet>
References: <pull.158.git.gitgitgadget@gmail.com> <6407430da7f75cb2385d243c9820ac8c2ea7fee3.1551952855.git.gitgitgadget@gmail.com> <3a418266-6506-d2c0-45d3-5f1c6f0375c6@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qlq6KTCyLmVNGiC2dJKD+XEqeZFEnDSCAFC6I6GipdwKdffv5Sc
 iaRUn9t08kC2+s5ZU03Y3+87KI9pIFpCxrEcOhoH+nX0c6CmIGqm0mLc9+Bwla5UDEZVgp0
 nuXkU9PZJmRRq5KdlaMKvycuEImqKq8g0jgv2tgZDY2qkzdP5XCcoH/zfGTw0NFGgpVa2Y7
 x7snM+lXbQKnhrp2yu0cg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OdFowlmRuzI=:Jybiun9RpCz2GSPCKrpCMc
 gCXiVLfxJg4ODWIZkDupKlBfqRXflXr4Cq/+nxiAUm25yYAsGZAt9UaWXc7gqFvqGM1Idlv8k
 qz9L0ene7P7VuPF5iDToChgSVMMloe+EFNNlusjYUXUH5h090FqHwc4DEZF33wDrYX/mFE2wJ
 5DLI1CdKWzyagsBqNdrtfEYHQ/WLW9pvIvFKBE51fzP4ZlgbylCgpEtwj98lANCd2koSDq/YC
 2nlBQLCOxIRazCkwWoEDD92pMgpFaUY3RNPsZJMI3/xUB02perq4fEUbOzwaaH7QyqOrBlXg4
 78bdIgEX21YNNGnkDYeaWy5WQvS+YJ619TQ/0A+OXTJuuTHqh4AEtBCCNaes8s+T00JvmyZmp
 9hMeVT2XgdYiTty4MkLYDty/NPyfOEEKO/Dcw3giEb+I9DZP8lgPLS7dXRjnot2437LPBGnrg
 6RG8hmSQmjOjAjvdkRDHdIaP+isYiY98YTATcSL/Tj7hWHBTJ/KKquvdnBxMfAc2mo0C6Fos6
 whujOk5DTNh/U7O9syBNV7cFa1T7aI7X/iL8bQ4x2lrFtySa/76wrvxClZo8dKs/tS25GEMg3
 fJMTNwX+5eXbUgYTdyLDCVLJumIzuN3v6XnkQGI0bnVrRRCXTwPwRERktVN4LG3yAG1G7t9ho
 qEuY4dlGttCzRyDVEAriX303m6IaGCE5skD2rz5Yz21bS6Qk1g5dBRurzzxiSQnSdDHWNqpo/
 peVVozKOfrcXsd7QkvQJQQPNekC9yIHE/TkoGIBNB5rliCA3d7cP0JNh+iLB0zWMqwTWaw5Hr
 g9px8IC2s3Q4EIeFne4YMZz89fKoDXDhQ0VCsLse2Nt7Me1XVw/UyxhhTYgDsD3H6rRJHsKy7
 ABOSlU7I8i1uwb1QV7dXxRdX/FHMpz2C1MN2mAB+Be1d0EK2r8Jnzw1K4VtDrs/PT6GewG/fQ
 YX3gFPhaI0A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 7 Mar 2019, Phillip Wood wrote:

> It's great to see this. Do we need the deprecation warning in both
> builtin/rebase.c and rebase--preserve-merges.sh? Won't that end up warning
> twice - maybe that's a good thing but if we go for only one I prefer the
> wording in rebase--preserve-merges.sh

Good point.

I also considered adding a warning to the todo list, in case the rebase is
run interactively, but that would have required way too many changes in
the test suite (the test cases using `FAKE_LINES` select lines from the
todo list based on their line number, not their content, which does not
play well with inserting 3 lines with a warning at the beginning of the
todo list).

Ciao,
Dscho

> 
> Best Wishes
> 
> Phillip
> 
> On 07/03/2019 10:00, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > We have something much better now: --rebase-merges (which is a
> > complete re-design --preserve-merges, with a lot of issues fixed such as
> > the inability to reorder commits with --preserve-merges).
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >   Documentation/config/branch.txt |  6 +++---
> >   Documentation/config/pull.txt   |  6 +++---
> >   Documentation/git-rebase.txt    | 23 ++++++++++++-----------
> >   builtin/rebase.c                |  8 ++++++--
> >   git-rebase--preserve-merges.sh  |  2 ++
> >   5 files changed, 26 insertions(+), 19 deletions(-)
> > 
> > diff --git a/Documentation/config/branch.txt
> > b/Documentation/config/branch.txt
> > index 019d60ede2..8f4b3faadd 100644
> > --- a/Documentation/config/branch.txt
> > +++ b/Documentation/config/branch.txt
> > @@ -85,9 +85,9 @@ When `merges`, pass the `--rebase-merges` option to 'git
> > rebase'
> >   so that the local merge commits are included in the rebase (see
> >   linkgit:git-rebase[1] for details).
> >   +
> > -When preserve, also pass `--preserve-merges` along to 'git rebase'
> > -so that locally committed merge commits will not be flattened
> > -by running 'git pull'.
> > +When `preserve` (deprecated in favor of `merges`), also pass
> > +`--preserve-merges` along to 'git rebase' so that locally committed merge
> > +commits will not be flattened by running 'git pull'.
> >   +
> >   When the value is `interactive`, the rebase is run in interactive mode.
> >   +
> > diff --git a/Documentation/config/pull.txt b/Documentation/config/pull.txt
> > index bb23a9947d..b87cab31b3 100644
> > --- a/Documentation/config/pull.txt
> > +++ b/Documentation/config/pull.txt
> > @@ -18,9 +18,9 @@ When `merges`, pass the `--rebase-merges` option to 'git
> > rebase'
> >   so that the local merge commits are included in the rebase (see
> >   linkgit:git-rebase[1] for details).
> >   +
> > -When preserve, also pass `--preserve-merges` along to 'git rebase'
> > -so that locally committed merge commits will not be flattened
> > -by running 'git pull'.
> > +When `preserve` (deprecated in favor of `merges`), also pass
> > +`--preserve-merges` along to 'git rebase' so that locally committed merge
> > +commits will not be flattened by running 'git pull'.
> >   +
> >   When the value is `interactive`, the rebase is run in interactive mode.
> >   +
> > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> > index 5629ba4c5d..89202dbb93 100644
> > --- a/Documentation/git-rebase.txt
> > +++ b/Documentation/git-rebase.txt
> > @@ -415,9 +415,9 @@ i.e. commits that would be excluded by
> > gitlink:git-log[1]'s
> >   the `rebase-cousins` mode is turned on, such commits are instead rebased
> >   onto `<upstream>` (or `<onto>`, if specified).
> >   +
> > -The `--rebase-merges` mode is similar in spirit to `--preserve-merges`, but
> > -in contrast to that option works well in interactive rebases: commits can
> > be
> > -reordered, inserted and dropped at will.
> > +The `--rebase-merges` mode is similar in spirit to the deprecated
> > +`--preserve-merges`, but in contrast to that option works well in
> > interactive
> > +rebases: commits can be reordered, inserted and dropped at will.
> >   +
> >   It is currently only possible to recreate the merge commits using the
> >   `recursive` merge strategy; Different merge strategies can be used only
> >   via
> > @@ -427,9 +427,10 @@ See also REBASING MERGES and INCOMPATIBLE OPTIONS
> > below.
> >   
> >   -p::
> >   --preserve-merges::
> > -	Recreate merge commits instead of flattening the history by replaying
> > -	commits a merge commit introduces. Merge conflict resolutions or
> > manual
> > -	amendments to merge commits are not preserved.
> > +	[DEPRECATED: use --rebase-merges instead] Recreate merge commits
> > +	instead of flattening the history by replaying commits a merge commit
> > +	introduces. Merge conflict resolutions or manual amendments to merge
> > +	commits are not preserved.
> >   +
> >   This uses the `--interactive` machinery internally, but combining it
> >   with the `--interactive` option explicitly is generally not a good
> > @@ -1020,11 +1021,11 @@ merge cmake
> >   
> >   BUGS
> >   ----
> > -The todo list presented by `--preserve-merges --interactive` does not
> > -represent the topology of the revision graph.  Editing commits and
> > -rewording their commit messages should work fine, but attempts to
> > -reorder commits tend to produce counterintuitive results. Use
> > -`--rebase-merges` in such scenarios instead.
> > +The todo list presented by the deprecated `--preserve-merges --interactive`
> > +does not represent the topology of the revision graph (use
> > `--rebase-merges`
> > +instead).  Editing commits and rewording their commit messages should work
> > +fine, but attempts to reorder commits tend to produce counterintuitive
> > results.
> > +Use `--rebase-merges` in such scenarios instead.
> >   
> >   For example, an attempt to rearrange
> >   ------------
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 7c7bc13e91..c5f5edf321 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -1092,8 +1092,8 @@ int cmd_rebase(int argc, const char **argv, const char
> > *prefix)
> >      PARSE_OPT_NOARG | PARSE_OPT_NONEG,
> >      parse_opt_interactive },
> >   		OPT_SET_INT('p', "preserve-merges", &options.type,
> > -			    N_("try to recreate merges instead of ignoring "
> > -			       "them"), REBASE_PRESERVE_MERGES),
> > +			    N_("(DEPRECATED) try to recreate merges instead of
> > "
> > +			       "ignoring them"), REBASE_PRESERVE_MERGES),
> >     OPT_BOOL(0, "rerere-autoupdate",
> >       &options.allow_rerere_autoupdate,
> >       N_("allow rerere to update index with resolved "
> > @@ -1204,6 +1204,10 @@ int cmd_rebase(int argc, const char **argv, const
> > char *prefix)
> >     usage_with_options(builtin_rebase_usage,
> >          builtin_rebase_options);
> >   +	if (options.type == REBASE_PRESERVE_MERGES)
> > +		warning(_("--preserve-merges is deprecated in favor of "
> > +			  "--rebase-merges"));
> > +
> >    if (action != NO_ACTION && !in_progress)
> >    	die(_("No rebase in progress?"));
> >   	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
> > diff --git a/git-rebase--preserve-merges.sh b/git-rebase--preserve-merges.sh
> > index afbb65765d..eab2e40dc6 100644
> > --- a/git-rebase--preserve-merges.sh
> > +++ b/git-rebase--preserve-merges.sh
> > @@ -105,6 +105,8 @@ warn () {
> >   	printf '%s\n' "$*" >&2
> >   }
> >   
> > +warn "git rebase --preserve-merges is deprecated. Use --rebase-merges
> > instead."
> > +
> >   # Output the commit message for the specified commit.
> >   commit_message () {
> >    git cat-file commit "$1" | sed "1,/^$/d"
> > 
> 
