Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEEA41F404
	for <e@80x24.org>; Wed,  7 Feb 2018 17:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932109AbeBGRgP (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 12:36:15 -0500
Received: from mout.gmx.net ([212.227.17.21]:65229 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753828AbeBGRgN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 12:36:13 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx101 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 0MfzEP-1eOMI90sMf-00NQ19; Wed, 07 Feb 2018 18:36:08 +0100
Date:   Wed, 7 Feb 2018 18:36:06 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Sergey Organov <sorganov@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
In-Reply-To: <87k1vpqq85.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1802071818240.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de> <87k1vpqq85.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:CrQBmR4nZycErbDMCtey7S720OIBtrN2WNgTfAVALuOKypgjQGU
 VVnNYoZMj32x0G/HgwWOnsKlMwULQYokiTG4r32qH52V513jDiBcMoqmVMltiFSkO0xpmSz
 LsQeDxhtn9xNXyF2Do+GV+f13tokNRo9brXrKWgQsRbK0InS0GuBV5y9zIQIJejRTlyqvoF
 REyVQnpBxDE+E7GdBUEaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UMaaqJMN9To=:RS2R9u9sgkfx5ah0aKBieh
 PG2BkQLlr2wflmiGtAUACbKHatzFpsdj9hAC4Cc6dcgi2ontpLNwMhOaRvI+5D4pJrjN1oC4J
 IfqL6qrfs/zj03Eaku4qOArol2bZ1cE//xXbLJFS3G6BbuetA2mbn/j/egXkrEk+hXb8V5AUu
 MvwLEgatHqF5wyQaLm6QaCafYwbRUjBbeFeWwlPBL6ODa33lHyiaypabPhgXQ7jIwgSF6G8zJ
 kUUhoMvEX6gy32Gl1DsN/JN2ZAGnCu5U+vQToIb2OJtdt7G9/ZweiVjodBIRKJBein2m27mpc
 Ro87G4l/SRKroidrztmLkfcasvTfDOd2jrynKyCeJgYWH6DT2Bgy1s6R3dXajNQvIr+cAzzZ2
 LJj/4I3KlQdTrJQ0BQJlOWEFJ0D4icwdWggkuB3DbdN4nc+RHi68c8/zyJNuQcBpXLCtMMX/i
 x4EM2QchdcIxx7EMswf8WBBYXesLPBW6eo+8xwdNx/k/ehJ6bSOyHUaSIRY52JNj8bqEzzSul
 WO+LqDNkeSI+4jTCqOqucdP3Kr4qC5QxvppQ1KOInHBr/yhZkR9E9aggME2soY1JsIq44ps3x
 VC7etNvQIjqIMeSJ8+UGPigAzh4cKamSFrCtfKxdVRQGkIZaIyT1S+Y9YJK99u0OvTx8F0s6W
 rDMfUXPUIkXkJvrLMqkb92yOrlFQhsOYvjNC3hff67k8cZMZIqE1VzlsKvZhdf+GWDyyvoA93
 GPF79+kNh7Pao0pYeLdxXfFFdhFNamni2RqK/yuby1oSjsCXJDmItFj89kn+lUhSuGdB+WJcR
 d5T+HhjpNiuU4Q9I4fHnRW9r0E3VwWarPAKqV2motJSrF8Dyus=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 7 Feb 2018, Sergey Organov wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> [...]
> 
> > +--recreate-merges::
> > +	Recreate merge commits instead of flattening the history by replaying
> > +	merges. Merge conflict resolutions or manual amendments to merge
> > +	commits are not preserved.
> 
> I wonder why you guys still hold on replaying "merge-the-operation"
> instead of replaying "merge-the-result"?

This misses the point of rebasing: you want to replay the changes.

> The latter, the merge commit itself, no matter how exactly it was
> created in the first place, is the most valuable thing git keeps about
> the merge, and you silently drop it entirely!

You miss another very crucial point. I don't blame you, as you certainly
have not used the Git garden shears for years.

Let me explain the scenario which comes up plenty of times in my work with
Git for Windows. We have a thicket of some 70 branches on top of git.git's
latest release. These branches often include fixup! and squash! commits
and even more complicated constructs that rebase cannot handle at all at
the moment, such as reorder-before! and reorder-after! (for commits that
really need to go into a different branch).

Even if you do not have such a complicated setup, it is quite possible
that you need to include a commit in your development that needs to be
dropped before contributing your work. Think e.g. removing the `-O2` flag
when compiling with GCC because GDB gets utterly confused with executables
compiled with `-O2` while single-stepping. This could be an initial commit
called `TO-DROP` or some such.

And guess what happens if you drop that `pick` line in your todo list and
then the `merge` command simply tries to re-create the original merge
commit's changes?

Exactly. The merge will become an evil merge, and will introduce that very
much not-wanted and therefore-dropped changes.

> OTOH, git keeps almost no information about "merge-the-operation", so
> it's virtually impossible to reliably replay the operation
> automatically, and yet you try to.

That is true. However, the intended use case is not to allow you to
recreate funny merges. Its use case is to allow you to recreate merges.

At a later stage, I might introduce support to detect `-s ours` merges,
because they are easy to detect. But even then, it will be an opt-in.

> IMHO that was severe mistake in the original --preserve-merges, and you
> bring with you to this new --recreate-merges... It's sad.

Please refrain from drawing this discussion into an emotional direction.
That is definitely not helpful.

> Even more sad as solution is already known for years:
> 
>     bc00341838a8faddcd101da9e746902994eef38a
>     Author: Johannes Sixt <j6t@kdbg.org>
>     Date:   Sun Jun 16 15:50:42 2013 +0200
>     
>         rebase -p --first-parent: redo merge by cherry-picking first-parent change
> 
> and it works like a charm.

It might work for you, as you probably used --preserve-merges, and dealt
with the fact that you could neither drop nor reorder commits.

So --preserve-merges --first-parent is probably what you were looking for.

Instead, --recreate-merges is all about allowing the same level of freedom
as with regular interactive rebases, but recreating the original commit
topology (and allowing to change it, too).

Therefore, I think that it would be even harmful to allow
--recreate-merges --first-parent *because it would cause evil merges*!

And I totally could see myself being vexed again about options that worked
perfectly well (just like --preserve-merges) being completely messed up by
allowing it to be combined with options *that they cannot work with* (just
like --preserve-merges --interactive, a *huge* mistake causing so many
annoying "bug" reports: I *never intended it that way because I knew it
would not work as users expect*).

So no, I do not think that --recreate-merges --first-parent is a good idea
at all. Unless you try to do that non-interactively only, *and disallow it
in interactive mode*. Because the entire point of the interactive rebase
is to allow reordering and dropping commits, in --recreate-merges even
moving, introducing and dropping merge commits. The --first-parent option
flies in the face of this idea.

Ciao,
Johannes
