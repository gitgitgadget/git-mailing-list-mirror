Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E62C32771
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 21:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28F922522
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 21:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kiLAe7ns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgATVl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 16:41:26 -0500
Received: from mout.gmx.net ([212.227.17.20]:54237 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbgATVl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 16:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579556483;
        bh=dvIJx27f6aDQ0a9KPEUd+okVYTlNmSbe0cagTLaOC10=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kiLAe7nsImOXoL4ZUQ6GQo9NKfQniOg+6/OJetUTBO3aiumK1zuk8aUXcEC2TCENP
         dFmqNDeKmXTyRSIpKrpPaRHZysRG/qJGDxXs0rTavReQCzwcm/bRejexlkIOWypMM3
         Nm2vD8mNXtUmyw/K4nEy54zLbzeSv5CaPR6K88KQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MF3DM-1irSx92BCq-00FVqA; Mon, 20
 Jan 2020 22:41:23 +0100
Date:   Mon, 20 Jan 2020 22:41:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [Outreachy][PATCH 00/29] Finish converting git bisect to C part
 1
In-Reply-To: <20200120143800.900-1-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001202237140.46@tvgsbejvaqbjf.bet>
References: <20200120143800.900-1-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1482613308-1579556483=:46"
X-Provags-ID: V03:K1:Oqt78TK2OB1gAwXOq/9cpWVLT3V6E5jz4AhOEflIggO7iU5bfOV
 sx9lyx4DVvlKLVKt5IGMLKByJVOftODe7OeYMsBkp4+kfcsC6Pw9UI5wKR5Ykm8TRD7zcfX
 /wLJS+lB4scsLtm6pfbybK0Famp8ANLWDFIjRZnRGc4VoEDKTsZ4U8+G0GQ/FZ1OFddfBfz
 80nxvDJZow1oDMYfouPnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m6fXMHjYGkk=:MXmTzwS5Wvm1wqo4JcjD5P
 KMnS+I+qWTEMpG3MoJbGY0tfrl3JYKXJDPwVigh2HTrIgs4tD9yWUK2ArkL/1zFpmVjFsToA4
 2pntpORsVj7YHLXI5O8mbjcupyBnaaKVr2SK6lUT2dT+8xWjLJckr0t2ATbVIrGcJbtZkPFo0
 oj0fueZrNqHi3euDswt7kkS7eoai+hPYrHTadkRhQCNgoZ7RjnL55U6g+L1Sf4jDypYPvKwqQ
 laZjc90IXTSGGooZeBE3E9AaB+OWottKko63s/vvsmfeEvrcjqJTlgTQ2WI0iVeKwLlpE/Rf+
 b/61YsmXeuTaFbR1dSRw/jkHKqUjXShdjkEhabuAVy90r7KyWZU9F8Fth2/Ps8GNvRv7CxHdE
 RANhe5A56aZA/csDl8EVktIPn3+3AxQV77ucqkvHR2pfYG1y02xJNOS7f0DTsfnciz85ToE17
 QSAj1HJULK5Q7tU1sObh+pdCVa8715mygzaBdZyXzOBd76KG27xX/jk23yFadkoRT9zhXDLPM
 3R2EkthSIoj9bjwVE2YUzxYfpTYEnG7sl8f9UhpfttlFE6BxNd9yDCO/utvoCxsgYHIHJf9jw
 fb3s0j197iGNjzmcpRGHDlY/KXi2wyo1HjbxKPGUAb8aZTPq/Om6xFGwkAlRWIuKnMOh0C979
 LKn+DfCoJXsW2s0uGY6UxdUTwWfvEFU/khJR6WOM+yNPfejDYgwyvF1W8MP9DS8C6E6/QUTt4
 9tjs7jNyvucwQwjjtQjSwtjW5MfOpAylm0/5LFWOoRSMeN4HvqJ1XO0O8do8K8/seL2EsyiHm
 U1zZr037PKUuDkw0w9pPtlnE3GApdO/mR37hkTFBUCLrz6mXh6W7kKRDKrWZzm9pSqxskNUb0
 GaSsYo4OPNDp48k/jU/pZiza58ifbROx5r7bvcDQS2pcBCCJdz90NvQc0q3rPtO+AHk6wnzVF
 shS+PNqZxdyfZTFP7sSw93XkZM6RhWQ2VVpxFiFDSm82l5dFFTRwjw52puu8MwpHuPWLlMcRx
 CVKeGYqSDIeP8xhY41ZNAThOz74jBkGd4xr4vn8AK5NDoMalv3o5stYzMHSQBTUoVcVoD0Yjh
 a0f8ZqHccG4Nj02ioPw0peMqXNeOwLsk99ivkwkykVexcI1O7FxVUpJpp7HfJmcpyTtuH0wQn
 YoO9vVPUBmJN6Os7Zn16zv9ldXH8hDABYSrWsspi0QhVdR7CtcFnb7P7ymvM4rGSEFJnazrlb
 8+EI8C/9Mbi/nXIQW/TCMhf21kX//VPtauiOgIuvhcL2njJtnIOQdEYMdG9s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1482613308-1579556483=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Miriam,

On Mon, 20 Jan 2020, Miriam Rubio wrote:

> --- Changes since Tanushree=E2=80=99s pr117 sent patch series:
> https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) ---
>
> General changes
> ---------------
>
> * Rebase on master branch.
> * Improve commit messages.
> * Amend patch series titles.
> * Reorder commits: first clean-up/preparatory commits, squash or split
> commits.

Great!

> Specific changes
> ----------------
>
> [1/29] bisect--helper: convert `vocab_*` char pointers to char arrays
>
> * New patch to convert `vocab_bad` and `vocab_good` char pointers
> to char arrays

29 patches is _a lot_ to review. I would have preferred a series of
smaller patch series.

For example, the first three patches would have made for a fine "some
cleanups" patch series, from my point of view.

Also, as the mail's subject says "part 1", it would be good to have an
overview how this part fits into the overall story of converting `git
bisect` into a built-in.

Finally, it would be nice to have a link to a public repository with the
branch from which these mails were generated.

I will try to review this patch series in its entirety, but it will take
me a while.

Ciao,
Johannes

>
> --
>
> [2/29] bisect--helper: change `retval` to `res`
>
> * Replace one last variable `retval` to `res`.
>
> --
>
> [3/29] bisect: use the standard 'if (!var)' way to check for 0
>
> * New patch to use '!var' and make 'bisect.c' more consistent with the
> rest of the code
>
> --
>
> [4/29] run-command: make `exists_in_PATH()` non-static
>
> * Add comment before function declaration.
> * Move function declaration in `run-command.h`.
>
> --
>
> [6/29] bisect: libify `exit_if_skipped_commits` to `error_if_skipped*`
> and its dependents
>
> * Fix `mark_edges_uninteresting()` and `show_diff_tree()` calls after
> rebase on master.
>
> --
>
> [7/29] bisect: libify `bisect_checkout`
>
> * Fix `memcpy()` call after rebase on master.
> * Introduce `res` variable to return `bisect_checkout()` output.
> * Fix `get_commit_reference()` declaration after rebase on master.
>
> --
>
> [8/29] bisect: libify `check_merge_bases` and its dependents
>
> State: Previously sent
>
> * Fix `check_ancestors()` declaration after rebase on master.
> * Fix `get_bad_and_good_commits()` call after rebase on master.
>
> --
>
> [9/29] bisect: libify `check_good_are_ancestors_of_bad` and its
> dependents
>
> State: Previously sent
>
> * Fix `check_good_are_ancestors_of_bad()` declaration after rebase on
> master.
> * Fix `check_good_are_ancestors_of_bad()`, `bisect_next_all()`
> and `bisect_rev_setup()` calls after rebase on master.
>
> --
>
> [11/29] bisect: libify `bisect_next_all`
>
> State: Previously sent
>
> * Fix `show_diff_tree()` call after rebase on master.
>
> --
>
> [12/29] bisect--helper: reimplement `bisect_next` and `bisect_auto_next`
> shell functions in C
>
> * Fix `repo_init_revisions()` and `bisect_next_all()` calls after rebase
> on master.
> * Remove `goto` statement in `bisect_skipped_commits()`
>
> --
>
> [13/29] bisect--helper: finish porting `bisect_start()` to C
>
> * Change `return` statement instead of `die` in error handling.
> * Remove `goto` statements in `bisect_skipped_commits()`.
>
> --
>
> [21/29] bisect--helper: reimplement `bisect_replay` shell function in C
>
> * Add blank line in `get_next_word()`.
> * Remove `goto` statements in `bisect_replay()`.
>
> --
>
> [23/29] bisect--helper: use `res` instead of return in BISECT_RESET case
> option
>
> * New patch to split previous commit in two.
>
> --
>
> [26/29] bisect--helper: reimplement `bisect_skip` shell function in C
>
> State: Previously sent
>
> * Add blank line.
>
> --
>
> [28/29] bisect--helper: reimplement `bisect_visualize()`shell function
> in C
>
> New patch:
>
> * Reimplement the `bisect_visualize()` shell function in C.
> * Add `--bisect-visualize` subcommand.
> * Fix long code line.
>
> --
>
> [29/29] bisect--helper: reimplement `bisect_run` shell function in C
>
> New patch:
>
> * Reimplement the `bisect_run()` shell function in C.
> * Add `--bisect-run` subcommand.
> * Remove blank line.
>
> --
>
> Miriam Rubio (2):
>   bisect--helper: convert `vocab_*` char pointers to char arrays
>   bisect: use the standard 'if (!var)' way to check for 0
>
> Pranit Bauva (24):
>   run-command: make `exists_in_PATH()` non-static
>   bisect: libify `exit_if_skipped_commits` to `error_if_skipped*` and
>     its dependents
>   bisect: libify `bisect_checkout`
>   bisect: libify `check_merge_bases` and its dependents
>   bisect: libify `check_good_are_ancestors_of_bad` and its dependents
>   bisect: libify `handle_bad_merge_base` and its dependents
>   bisect: libify `bisect_next_all`
>   bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell
>     functions in C
>   bisect--helper: finish porting `bisect_start()` to C
>   bisect--helper: retire `--bisect-clean-state` subcommand
>   bisect--helper: retire `--next-all` subcommand
>   bisect--helper: reimplement `bisect_autostart` shell function in C
>   bisect--helper: reimplement `bisect_state` & `bisect_head` shell
>     functions in C
>   bisect--helper: retire `--check-expected-revs` subcommand
>   bisect--helper: retire `--write-terms` subcommand
>   bisect--helper: reimplement `bisect_log` shell function in C
>   bisect--helper: reimplement `bisect_replay` shell function in C
>   bisect--helper: retire `--bisect-write` subcommand
>   bisect--helper: use `res` instead of return in BISECT_RESET case
>     option
>   bisect--helper: retire `--bisect-autostart` subcommand
>   bisect--helper: retire `--bisect-auto-next` subcommand
>   bisect--helper: reimplement `bisect_skip` shell function in C
>   bisect--helper: retire `--check-and-set-terms` subcommand
>   bisect--helper: reimplement `bisect_visualize()`shell function in C
>
> Tanushree Tumane (3):
>   bisect--helper: change `retval` to `res`
>   bisect--helper: introduce new `decide_next()` function
>   bisect--helper: reimplement `bisect_run` shell function in C
>
>  bisect.c                 | 146 +++++---
>  builtin/bisect--helper.c | 776 +++++++++++++++++++++++++++++++++------
>  git-bisect.sh            | 279 +-------------
>  run-command.c            |   2 +-
>  run-command.h            |  11 +
>  5 files changed, 793 insertions(+), 421 deletions(-)
>
> --
> 2.21.1 (Apple Git-122.3)
>
>

--8323328-1482613308-1579556483=:46--
