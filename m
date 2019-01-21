Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2567C1F453
	for <e@80x24.org>; Mon, 21 Jan 2019 21:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfAUVBi (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 16:01:38 -0500
Received: from mout.gmx.net ([212.227.15.15]:41579 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfAUVBh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 16:01:37 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0ML6qP-1glxg81bQf-000M4e; Mon, 21
 Jan 2019 22:01:29 +0100
Date:   Mon, 21 Jan 2019 22:01:13 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, predatoramigo@gmail.com,
        phillip.wood@talktalk.net
Subject: Re: [PATCH v4 0/8] Reimplement rebase --merge via interactive
 machinery
In-Reply-To: <nycvar.QRO.7.76.6.1901211702380.41@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1901212200400.41@tvgsbejvaqbjf.bet>
References: <20181122044841.20993-1-newren@gmail.com> <20181211161139.31686-1-newren@gmail.com> <nycvar.QRO.7.76.6.1901211702380.41@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:623EbwBc3zw0iymdh50Bq8OoXokEbZQxlkftb09tX3y6KCY0Dmt
 ehLQpr4MeSDzfUb7UjWu9gZmZkcm/fGyxtgHZ8XQl4KxR2evPhaHQclybAWbrZMbjXznNAB
 5MN8q7wDV6EwjBfFjhAEoFe2VJ1BwxCyLRJbJYOnXRYv4up2MN3YsAl6pKDzDp6EoS/+4Nn
 BJSavb3yLLa5gTB1WRF0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Og0S2i6GFM4=:vjME8rjyJXZAmvwRvGCJHm
 3NV9hzpVs72qgaWNDw2v0+GUE41Uv75kWTixbpjRsls8K7Je6typsSSXiu/C4kVGQgwgN/eK6
 t0mVsh/wZjB+SmrbClwl9+TJ8Z44vz7H0omFDQ9FjwjbsO0qNYvhf8Z2bJQWct+CeVwwnvQxv
 CxOTJJocobabRMIVhtdcFfx/BP+Frrw4XhysztOMQadrq+IHjcVgGjnoZgtcKjoR1rtoGUjg7
 3nh3+Xemuazh50NfKOwjG71H3Y0xB2sx97tE/aBu0VjOjkntE2bXhOOxx1PASYdD/aVzD2XJA
 tOxhvR0do2u0DtFOytnho9i/EC3Eb8DhSO/bKIOhxWCcIF3ytNOmVORc++TWKDuDN1w2qy7h5
 6yhZ/R9Ogo27/p1Ggi0yUyWGkVkqbU+XCYQJKfiphHtCo1zZOL1AZikJ1N5eFn+SSitlqkx1d
 YSxTYPGnJkSgn2VMU2zWGLkphreWVzksVPGEmowdavxCFBwXE3myh37oXzmizFgFVLTRV1qql
 l8evwuLl8BSKRKk/T80wMALAWBtskcl+1McjwbfBZ10t/yprjZdb5s+kKPRqtR+7/vuoJo92Z
 iAMezFi/wrNg62Od9EvL5GMP+zTBuu777CNo/AxLBE5OCyNQNtgiFlr8W/T5PAlkFR2pUlSgW
 bwJuVS81AfKeYVanbrxS1fLMYnZbfB8IhX1e6lYU1Vlu9fh116Cs6WnNvS8wGcunpvQqFaiPt
 YcjWH09KWqjXiPQPBVqT9kRSt9FhnHsoHtgkh3T/KZzlWZTjawmSiy2EsRL0iTuR1awF01Q25
 O/xHhINqTBuJ7esRhR1viY0IH9xeaUv0saYQJsK/vDyB4JzjlfEyStEaBpcXHSECSv0DGYl7e
 8RmN8k1F9dltGQ6u/WYj22/eXjRVktZQdJS3daB9MFgn7a/IRWYBrULPCRcffMIK5SB2YhZzr
 95SRvFBCo2A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 21 Jan 2019, Johannes Schindelin wrote:

> On Tue, 11 Dec 2018, Elijah Newren wrote:
> 
> > Differences since v3 (full range-diff below):
> >   - Fixed the redundant "fatal: error:" error message prefixes, as pointed
> >     out by Duy
> >   - Rebased on 2.20.0
> 
>     - Fixed the "comptable" tyop
> 
> This, and the range-diff, look reasonable to me.

And now that I looked through all 8 patches, those look reasonable to me,
too. I think this is ready for `next`.

Ciao,
Dscho

> 
> Thanks,
> Dscho
> 
> > Elijah Newren (8):
> >   rebase: make builtin and legacy script error messages the same
> >   rebase: fix incompatible options error message
> >   t5407: add a test demonstrating how interactive handles --skip
> >     differently
> >   am, rebase--merge: do not overlook --skip'ed commits with post-rewrite
> >   git-rebase, sequencer: extend --quiet option for the interactive
> >     machinery
> >   git-legacy-rebase: simplify unnecessary triply-nested if
> >   rebase: define linearization ordering and enforce it
> >   rebase: Implement --merge via the interactive machinery
> > 
> >  .gitignore                        |   1 -
> >  Documentation/git-rebase.txt      |  17 +---
> >  Makefile                          |   1 -
> >  builtin/am.c                      |   9 ++
> >  builtin/rebase.c                  |  30 ++----
> >  git-legacy-rebase.sh              |  65 ++++++------
> >  git-rebase--am.sh                 |   2 +-
> >  git-rebase--common.sh             |   2 +-
> >  git-rebase--merge.sh              | 164 ------------------------------
> >  sequencer.c                       |  23 +++--
> >  sequencer.h                       |   1 +
> >  t/t3406-rebase-message.sh         |   7 +-
> >  t/t3420-rebase-autostash.sh       |  78 ++------------
> >  t/t3421-rebase-topology-linear.sh |  10 +-
> >  t/t3425-rebase-topology-merges.sh |  15 ++-
> >  t/t5407-post-rewrite-hook.sh      |  34 +++++++
> >  t/t9903-bash-prompt.sh            |   2 +-
> >  17 files changed, 121 insertions(+), 340 deletions(-)
> >  delete mode 100644 git-rebase--merge.sh
> > 
> > Range-diff:
> > -:  ---------- > 1:  2e8b1bcb8b rebase: make builtin and legacy script error messages the same
> > 1:  2f4bdd1980 ! 2:  eba87828c6 rebase: fix incompatible options error message
> >     @@ -9,12 +9,12 @@
> >          understood by separate backends were used:
> >      
> >          $ git rebase --keep --ignore-whitespace
> >     -    fatal: error: cannot combine interactive options (--interactive, --exec,
> >     +    fatal: cannot combine interactive options (--interactive, --exec,
> >          --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with
> >          am options (.git/rebase-apply/applying)
> >      
> >          $ git rebase --merge --ignore-whitespace
> >     -    fatal: error: cannot combine merge options (--merge, --strategy,
> >     +    fatal: cannot combine merge options (--merge, --strategy,
> >          --strategy-option) with am options (.git/rebase-apply/applying)
> >      
> >          Note that in both cases, the list of "am options" is
> >     @@ -33,18 +33,17 @@
> >       				break;
> >       
> >       		if (is_interactive(&options) && i >= 0)
> >     --			die(_("error: cannot combine interactive options "
> >     +-			die(_("cannot combine interactive options "
> >      -			      "(--interactive, --exec, --rebase-merges, "
> >      -			      "--preserve-merges, --keep-empty, --root + "
> >      -			      "--onto) with am options (%s)"), buf.buf);
> >     -+			die(_("error: cannot combine am options "
> >     ++			die(_("cannot combine am options "
> >      +			      "with interactive options"));
> >       		if (options.type == REBASE_MERGE && i >= 0)
> >     --			die(_("error: cannot combine merge options (--merge, "
> >     +-			die(_("cannot combine merge options (--merge, "
> >      -			      "--strategy, --strategy-option) with am options "
> >      -			      "(%s)"), buf.buf);
> >     -+			die(_("error: cannot combine am options "
> >     -+			      "with merge options "));
> >     ++			die(_("cannot combine am options with merge options "));
> >       	}
> >       
> >       	if (options.signoff) {
> >     @@ -56,15 +55,15 @@
> >       	then
> >       		if test -n "$incompatible_opts"
> >       		then
> >     --			die "$(gettext "error: cannot combine interactive options (--interactive, --exec, --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with am options ($incompatible_opts)")"
> >     -+			die "$(gettext "error: cannot combine am options with interactive options")"
> >     +-			die "$(gettext "fatal: cannot combine interactive options (--interactive, --exec, --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with am options ($incompatible_opts)")"
> >     ++			die "$(gettext "fatal: cannot combine am options with interactive options")"
> >       		fi
> >       	fi
> >       	if test -n "$do_merge"; then
> >       		if test -n "$incompatible_opts"
> >       		then
> >     --			die "$(gettext "error: cannot combine merge options (--merge, --strategy, --strategy-option) with am options ($incompatible_opts)")"
> >     -+			die "$(gettext "error: cannot combine am options with merge options")"
> >     +-			die "$(gettext "fatal: cannot combine merge options (--merge, --strategy, --strategy-option) with am options ($incompatible_opts)")"
> >     ++			die "$(gettext "fatal: cannot combine am options with merge options")"
> >       		fi
> >       	fi
> >       fi
> > 2:  cc33a8ccc1 = 3:  15d929edb2 t5407: add a test demonstrating how interactive handles --skip differently
> > 3:  f5838ef763 = 4:  c9d6d5141e am, rebase--merge: do not overlook --skip'ed commits with post-rewrite
> > 4:  50dc863d9f = 5:  0b19ad8e2d git-rebase, sequencer: extend --quiet option for the interactive machinery
> > 5:  35cf552f27 ! 6:  5ded8654ec git-legacy-rebase: simplify unnecessary triply-nested if
> >     @@ -18,7 +18,7 @@
> >          moving the innermost conditional to the outside, allowing us to remove
> >          the test on git_am_opt entirely and giving us the following form:
> >      
> >     -    if incomptable_opts:
> >     +    if incompatible_opts:
> >            if interactive:
> >              show_error_about_interactive_and_am_incompatibilities
> >            if rebase-merge:
> >     @@ -44,18 +44,18 @@
> >       	then
> >      -		if test -n "$incompatible_opts"
> >      -		then
> >     --			die "$(gettext "error: cannot combine am options with interactive options")"
> >     +-			die "$(gettext "fatal: cannot combine am options with interactive options")"
> >      -		fi
> >     -+		die "$(gettext "error: cannot combine am options with interactive options")"
> >     ++		die "$(gettext "fatal: cannot combine am options with interactive options")"
> >       	fi
> >      -	if test -n "$do_merge"; then
> >      -		if test -n "$incompatible_opts"
> >      -		then
> >     --			die "$(gettext "error: cannot combine am options with merge options")"
> >     +-			die "$(gettext "fatal: cannot combine am options with merge options")"
> >      -		fi
> >      +	if test -n "$do_merge"
> >      +	then
> >     -+		die "$(gettext "error: cannot combine am options with merge options")"
> >     ++		die "$(gettext "fatal: cannot combine am options with merge options")"
> >       	fi
> >       fi
> >       
> > 6:  2a3d8ff1c1 = 7:  bb8e5a4527 rebase: define linearization ordering and enforce it
> > 7:  58371d377a ! 8:  5de428d695 rebase: Implement --merge via the interactive machinery
> >     @@ -142,14 +142,15 @@
> >       		imply_interactive(&options, "--root without --onto");
> >       
> >      @@
> >     + 				break;
> >       
> >       		if (is_interactive(&options) && i >= 0)
> >     - 			die(_("error: cannot combine am options "
> >     +-			die(_("cannot combine am options "
> >      -			      "with interactive options"));
> >      -		if (options.type == REBASE_MERGE && i >= 0)
> >     --			die(_("error: cannot combine am options "
> >     --			      "with merge options "));
> >     -+			      "with either interactive or merge options"));
> >     +-			die(_("cannot combine am options with merge options "));
> >     ++			die(_("cannot combine am options with either "
> >     ++			      "interactive or merge options"));
> >       	}
> >       
> >       	if (options.signoff) {
> >     @@ -205,13 +206,13 @@
> >       then
> >      -	if test -n "$interactive_rebase"
> >      -	then
> >     --		die "$(gettext "error: cannot combine am options with interactive options")"
> >     +-		die "$(gettext "fatal: cannot combine am options with interactive options")"
> >      -	fi
> >      -	if test -n "$do_merge"
> >      +	if test -n "$actually_interactive" || test "$do_merge"
> >       	then
> >     --		die "$(gettext "error: cannot combine am options with merge options")"
> >     -+		die "$(gettext "error: cannot combine am options with either interactive or merge options")"
> >     +-		die "$(gettext "fatal: cannot combine am options with merge options")"
> >     ++		die "$(gettext "fatal: cannot combine am options with either interactive or merge options")"
> >       	fi
> >       fi
> >       
> >     @@ -225,7 +226,7 @@
> >       	# linear history?
> >       	! (git rev-list --parents "$onto".."$orig_head" | sane_grep " .* ") > /dev/null
> >      @@
> >     - 	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
> >     + 	GIT_PAGER='' git diff --stat --summary "$mb_tree" "$onto"
> >       fi
> >       
> >      +if test -z "$actually_interactive" && test "$mb" = "$orig_head"
> > -- 
> > 2.20.0.8.g5de428d695
> > 
> > 
> 
