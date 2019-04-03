Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5682420248
	for <e@80x24.org>; Wed,  3 Apr 2019 18:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfDCSss (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 14:48:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:53463 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfDCSsr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 14:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554317324;
        bh=fPwLqjnUMQdjODWwBQIwiEtCDMzh8mstaXJfsBI8fU0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UQdqkTRLOlJL0ly6PVflTTrJay1hojNpwbmK2oWjSRpg7tqBSFTMoHhfN39e+6HTy
         vnPxMwiYLkL4JQsuvDlooZXUzIUO2eOkHCffTYMB0xqg6562FKKa0CHHOzL4xsUY2X
         Vv9XE1CzIx6ZtC1gmYE1/tnbZTldVcWfIftIHcdQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvzF3-1gqr5C3OqT-017pCg; Wed, 03
 Apr 2019 20:48:43 +0200
Date:   Wed, 3 Apr 2019 20:48:28 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Khalid Ali <khalludi123@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [GSoC][RFC] proposal: convert git-submodule to builtin script
In-Reply-To: <CAD8q83SifH-7mKOet-Uuf_KHCqvO2mkxiZgEyQhoNRhshFG_Lg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904031957480.41@tvgsbejvaqbjf.bet>
References: <CAD8q83SifH-7mKOet-Uuf_KHCqvO2mkxiZgEyQhoNRhshFG_Lg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7+4IwTrcfdFon4Yawlc6/lxGPWYXRPDKvZv0wTQwY3GsHEfi2rU
 PjpX5z9VmRXlPIdRHjRfbqMIBCQQu2mQ32acsIvsFFQ76AHmxlcS6z7O3hypTAnABs1RY2M
 ItpZvbiSovftg3iprj5AC1VQ0zNuOHAVvmJT5qvJ/Jl7IAKGZwS8g2DrQpaqavv92iEmxu+
 3Nppb6uPYse2WfXZ6f+DA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KEoGKokiXQI=:SE4IjSg9HaxvCRpz6ZmVT0
 JKEUr6GwuCTNdyj1a1Fsegr0dOG6Pex5m+018GMZyI8N2Ndj+1E1vSZBPQvcwWqUSaSJ3d2zr
 jR8Q6cStzz0XHuNnaTxbw1dcDKouUkUBHb9tvCFV/kc2QfTxx4By+AJujqovP3Ku2GaLYi/ND
 ij64eLRdQJFMA/+KVotYNBq+l1TTFZtEUL4wHIa7aGTiXeHlL7PbJC3KAE3NSqauZjy7opwuB
 YYtXxNFoEBvhNXnmAPYZmccym1hpvova6rC81+EY3xf69u5iISp6/7cE8bHox807h9w8jzhc8
 Pt8ZpJHilfJ/bD37kOeoI/IzmDXaP8bSThymHY3hB74Og+vyPXUWDfD4zlDuChWziJW1Hz/yN
 kNzBZnj+4zJpU3W9jQvu4ghh2H9zzwcgetSuk10uJ3VGjFCz72mpggIgVt4S8vkmYRI3QG0tS
 WSawc7hyLj3vH0Oi59Zou2GLMo88ZXnAP+CdSNlzv9DEXa43Tt35rxDtNyEBHPQI0ExDUaiAP
 sH4ZcPjntc5Mi6Q7d0kJHiO8kb4FFxGP1uG9f9GWRCsGBh8lNKUxiFAFFsM5382F3SDLdn00u
 nrmyWA9NXpjLoevGzGyZlxaU1XkTJlA+RB/V63ghmppxXKMOGBwrSwNgz51c/MN8PD1sg7FNQ
 Mv8fwfQttj9fwPS29744q5xvfEO8WqHdbrjZ4gF2QSr55ty4o0+2yzMbCOZNhE9nVTlaHb/wQ
 aOvKRSBSGsEVdqzAGtOT/UGxFLR6wc31yfhA1s5HyNIFgink4/c/D5jFVP8TFqILTiW8y42AF
 wtWJsNYffMU3JixF7EaudhVYnS736zHw990zO6Dd+2dnnNtUasC1TWvt7G+tSrKtURYzyusiv
 pdS5eWdNuU9GlsJyywssztz1C8iMqgkTtPShKjvOfhxEOuWEsxOe09gxEbg1QNnHY8jjbM1AO
 iM/CaP6odFg==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 2 Apr 2019, Khalid Ali wrote:

> My name is Khalid Ali and I am looking to convert the git-submodule to
> a builtin C script. The link below contains my first proposal draft
> [1] and my microproject is at [2]. My main concern is that my second
> task is not verbose enough. I am not sure if I should add a specific
> breakdown of large items within the submodule command.

Nice!

Please note that while I used to be the mentor who basically helped all of
the GSoC/Outreachy students through their "convert to built-in" projects
in the recent years, I am not available to mentor this year.

Having said that, I think I can help you to improve your proposal.

When you talk about "Convert each main task in git-submodule into a C
function." and "If certain functionality is missing, add it to the correct
script.", it is a good idea to back that up by concrete examples.

Like, study `git-submodule.sh` and extract the list of "main tasks", and
then mention that in your proposal. I see that you listed 9 main tasks,
but it is not immediately clear whether you extracted that list from the
usage text, from the manual page, or from the script itself. If the latter
(which I think would be the best, given the goal of converting the code in
that script), it would make a ton of sense to mention the function names
and maybe add a permalink to the corresponding code (you could use e.g.
GitHub's permalinks).

And then look at one of those main tasks, think of something that you
believe should be covered in the test suite, describe it, then figure out
whether it is already covered. If it is, mention that, together with the
location, otherwise state which script would be the best location, and
why.

Further, I would like to caution you about "If there is still some
time"... The `git-submodule.sh` script weighs in with just over 1,000
lines. We had three GSoC projects to convert scripts last year, and they
converted scripts' weights (at the time) were 750 lines for
`git-stash.sh`, 674 lines for `git-rebase.sh` and 1,036 lines for
`git-rebase--interactive.sh`, respectively. That last number should be
taken with a big grain of salt, as is not quite the number of lines that
were converted: as part of the GSoC project, the
`git-rebase--preserve-merges.sh` script was split out, never intended to
be converted, but to be deprecated instead (in favor of `git rebase -r`),
and there were "only" some 283 lines to be converted to C remaining after
that.

Out of those three, the project converting the smallest number of lines
clearly got integrated first (and there was actually time to do more stuff
in that project, and those things are partially still being cooked). The
converted `git stash` is still not in `master`...

So... converting 1,000 lines of code is quite a challenge for 3 months.

Having said that, I would not consider your project a failure if even
"only" as much as half of the lines of code were converted to C.

Besides, if you care to have a bit of a deeper look into the
`git-submodule.sh` script, you will see a peculiar pattern in some of the
subcommands, e.g. in `cmd_foreach`:
https://github.com/git/git/blob/v2.21.0/git-submodule.sh#L320-L349

Essentially, it spends two handfuls of lines on option parsing, and then
the real business logic is performed by the `submodule--helper`, which is
*already* a built-in.

Even better: most of that business logic is implemented in a file that has
the very file name you proposed already: `submodule.c`.

So if I were you, I would add a section to your proposal (which in the end
would no doubt dwarf the existing sections) that has as subsections each
of those commands in `git-submodule.sh` that do *not* yet follow this
pattern "parse options then hand off to submodule--helper".

I would then study the commit history of the ones that *do* use the
`submodule--helper` to see how they were converted, what conventions were
used, whether there were recurring patterns, etc.

In each of those subsections, I would then discuss what the
still-to-be-converted commands do, try to find the closest command that
already uses the `submodule--helper`, and then assess what it would take
to convert them, how much code it would probably need, whether it could
reuse parts that are already in `submodule.c`, etc.

> Outside of the draft, I was wondering whether this should be
> implemented through multiple patches to the master branch or through a
> separate, long-running feature branch that will be merged at the end
> of the GSoC timeline?

Judging from past projects to convert scripts to C, I would say that the
most successful strategy was to chomp off manageable parts and move them
from the script to C. I am sure that you will find tons of good examples
for this strategy by looking at the commit history of `git-submodule.sh`
and then searching for the corresponding patches in the Git mailing list
archive (e.g. https://public-inbox.org/git/).

Do not expect those "chomped off" parts to hit `master` very quickly,
though. Most likely, you would work on one patch series (very closely with
your mentor at first, to avoid unnecessary blocks and to get a better feel
for the way the Git community works right from the start), then, when that
patch series is robust and solid and ready to be contributed, you would
send it to the Git mailing list and immediately start working on the next
patch series, all the while the reviews will trickle in. Those reviews
will help you to improve the patch series, and it is a good idea to
incorporate the good suggestions, and to discuss the ones you think are
not necessary, for a few days before sending the next patch series
iteration.

Essentially, you will work in parallel on a few patch series at all times.
Those patch series stack on top of each other, and they should, one after
the other, make it into `pu` first, then, when they are considered ready
for testing into `next`, and eventually to `master`. Whenever you
contribute a new patch series iteration, you then rebase the remaining
patch series on top. Ideally it will look a bit like a fern, with the
first patch series being along the farthest, and each subsequent patch
series at an earlier stage than its predecessor.

Phew. Long mail. Hopefully this amount of information does not scare you.
And maybe some of it will help you with the proposal and/or the project.

Ciao,
Johannes

> Feedback is greatly appreciated!
>
> [1] https://docs.google.com/document/d/1olGG8eJxFoMNyGt-4uMiTD3LjRYx15pt=
tg67AJYliu8/edit?usp=3Dsharing
> [2] https://public-inbox.org/git/20190402014115.22478-1-khalludi123@gmai=
l.com/
>
