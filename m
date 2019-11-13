Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 849FA1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 12:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfKMMFC (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 07:05:02 -0500
Received: from mout.gmx.net ([212.227.15.18]:47129 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbfKMMFC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 07:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573646691;
        bh=M8fjV76k/znv9dsg/iNuu5un1EgSWwXm7PpVJNIIQl0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QCofWNzZCYn4Neoed2jfsILb8vdHirwb90VSTZsu04VZfEpU/htFWsJIDtYMCnB69
         F7GsvmFenHVffAM8BD93pk6t3aLjxFbZkfLJdOjOYHvy01Z1t8L3/93t3k1Ndghekw
         pobkCwMejKUNrTFmwIpDpoYN4dE3eA1G7Soza5cY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJE6L-1iAB2m1mEl-00Kcvw; Wed, 13
 Nov 2019 13:04:51 +0100
Date:   Wed, 13 Nov 2019 13:04:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: Should we auto-close PRs on git/git?
In-Reply-To: <20191113011020.GB20431@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1911131234380.46@tvgsbejvaqbjf.bet>
References: <20191109020037.GB60198@google.com> <nycvar.QRO.7.76.6.1911121946480.46@tvgsbejvaqbjf.bet> <20191113011020.GB20431@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MZoLH6PSJd27lLHNq2DR9Zy10KI3/jOb8w6MWrMOjt8bWmI16TT
 t1JZ7Ee5Zf6drQ8RvMXZUcGhiI2sHyEzz2cU3xAkcCgD3rUJt3cYDhmWPpFmqiAOq7/kpyO
 FAhTfq+hsc33+OtW6R8a/jBBs/vIaFKyy4pEAsHEAFfzcYSg5Goq9/MXVPx4kh6FXjfl3p9
 A1gCF9UsqRtqIrh13TTbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yByu/rTwA9w=:tPJPaSxHzUosysPGK3OxR7
 1qJZtkVXd1Th9nEWi0u672x5w+EypuSzcR74UVgqkZH+wzpp3Z7OPnh1Wgp2qCieX5rWl/dpk
 3X3cSs2+Q1WCs7/TFSlaWnzgcjhWg5BkoCh80RFKgLtO6wxYIPTWo3wQvLzO3Wvazlj6PS+mt
 GDT6clI2CRMWuPErXBGdMKB/YGJvysfWwBqztnJ6H++rt26gAjISwN+6M72ocn2nEUerHpyNX
 ZF1+9d/QiasAnNLNsrIXlIcGSp3Zy96Xf4oXXhytbAlbOjTF5uH6Gkfi3HZTpgaOG9F5eLf7V
 I3JGznvr6qmrrtYyHA3CO+YVF/cfUZ77WuzJvwcfG8WppP4cB1OcFbTJPL4Y4xZiDLZCr8VCn
 7yQl3nGJs/tzIfMVkYRqbbQ4D6idNe2pezG1FiCRqdmpw35DCWhfA68/dOSY6b6zMbiXwyBOH
 nTOh7uSmIkPYvRaofNMF+XbAre0ftjdOBY7/N49IGLWiiupn4eFm7Bx3PxoF7VR9jGhCh9evB
 eLuUXdPnlBOdaJEbe51AsrJr4twBrd2Gif0/sG9RqKJ9Z4WPG53fDL+4xbCACsAvUL/0wQl9y
 +PJpN5gCh7x94yUH2tYzjmbf+cBW7W8srHWCzIOHS4DtGoYjGgf3sZp5NGRcq2GR6YitLZk4w
 +XTBJ5AFknNgYUCO69uwLCNRRF2OOhsXY5fcOTMyymsSm/ndclYI1ipKyjqS8RGBJJ+D1RwQ6
 rEl3rTqXokfQoDPeMiRXGcSeksObH8XW+VNq649NyGiOINv9kZjqnghTZhm7d5eH6OguktdE8
 pqGkUrB22228kt/h2+jVtK3Xq5ETMWlfXZPESy0WcWSyUniuBWx50Z1ZW90ExiAcYqwXo9GBS
 C0gOgK3zPOmGsyxPczgIBFRg66yNAjIx84UG+kD7TS4iSq2ldmK4zhTGvU+UreBf//gomThqW
 D4pVLzEyA66viG8S6F0NLQc11svBJKFqzNkBV+TKeq1a0LIYTAWObFDuSCztQ8YQ9T9xR9r+f
 KQSc5b+jYfup0XScTKtAOGqaMOs86S8FJLewpXIg+JCZsYjAqr84lxxaN3oYb0nuwbqoyPKGW
 lfGvwLnFrOEZcJ23wVRb6QdM2XC1u9YWEEp+otH5WUUdGcoeaDpY7rqZstvzEMx5dGsceyUHq
 d+hwjCjjyH9c3LeBoU1+fynSj4fUUoszLZpRjGNYvQoSZJ+RszssNzYIoXAod/3yy7xTaCt+I
 dDNjC2uhwfA0LxuAbaiRG3xBWz2PbV6dlt3TXvNajMIQx1tK4URG7YzdkryA=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 12 Nov 2019, Jeff King wrote:

> On Tue, Nov 12, 2019 at 08:11:06PM +0100, Johannes Schindelin wrote:
>
> > > To that end, I wonder if we should add an Action to automatically
> > > close PRs on that repo. It looks like
> > > https://github.com/dessant/repo-lockdown would do the trick. We coul=
d
> > > close incoming PRs automatically with a kind, maybe more succinct or
> > > prescriptive version of the prefill text encouraging folks to open t=
he
> > > exact same PR against gitgitgadget/git instead.
> >
> > I am rather certain that that would not be a good thing to do.
> >
> > There are some people who open git/git PRs solely for the PR builds,
> > others to facilitate code review, and yet others just because it is th=
e
> > intuitively obvious way to contribute to Git.
>
> We talked a while ago about having GitGitGadget operate on git/git,
> rather than on a separate mirror. That would automatically help at least
> one class of PR-opener: people who want their patches to reach the list
> but didn't realize they should be using gitgitgadget/git.
>
> I don't remember what the technical blockers are for getting that set
> up, but it seems like a strictly nicer outcome than auto-closing their
> PR.

Okay, here are a couple of technical challenges, off the top of my head:

# The permission problem

GitGitGadget needs code write permission on
https://github.com/gitgitgadget/git so that it can push those tags that
correspond to delivered patch series iterations. It also needs
permission to write to Pull Requests (so that it can comment and add
labels).

But on https://github.com/git/git, Junio offered a strong preference
for restricting access so that GitGitGadget cannot just push code. I
do agree with this, but there is the complication that we cannot ask
for a different permission sets depending on which repository we
install the GitHub App.

I just verified that I cannot add a PR comment on git/git using the
existing App (which is installed only on gitgitgadget/git).

Possible workaround: I could register a second GitGitGadget app
(e.g. gitgitgadget2) and install that on git/git, then use that set of
permissions to interact with PRs on git/git.

This, however, will require a change in GitGitGadget's code,
as it now potentially needs to use either the GitGitGadget App's token
or the GitGitGadget2's. And for pushing the tags it always needs to use
the GitGitGadget's token.

BTW I do not like the name `gitgitgadget2` very much (it suggests an
upgraded version to me), if you have any ideas, I'm all ears.

# Disentangling the tagging part from the rest

As I said, GitGitGadget pushes tags to gitgitgadget/git that correspond
to each sent iteration. This is not only to allow for fetching directly
(rather than trying to find an appropriate base commit and then applying
the patches manually, which I find very tedious) but also for the
range-diff for v2 and later.

I would like to keep doing this even when letting GitGitGadget handle
git/git's PRs.

To avoid clashes, I would suggest to invent a new tag format. The
current one is `pr-<number>/<author>/<branch-name>-v<iteration>`.
Instead of the prefix `pr-`, we could easily use `git-` and be fine.

However, that requires changes in GitGitGadget: so far, the URL prefix
`https://github.com/gitgitgadget/git/` is pretty hard-coded. In theory,
it would matter only when fetching the commits that need to be
`/submit`ed, of course, but that will take some careful analysis right
there.

# The Checks

To have the same nice integration with the GitHub Checks, where you can
easily see when GitGitGadget is running, and get to the logs, we will
need to install a separate CI/PR pipeline.

For technical reasons, this will have to live in
https://dev.azure.com/gitgitgadget/git/_build, as I want to have only
one available agent for these runs: GitGitGadget is not _really_ able to
run concurrently. Neither does it have to. It's not like contributors
try to send multiple patch series in parallel. This saves me a lot of
headache about locking.

# The commit mappings

One of the things that irks me the most with the mailing list driven
development is that it is super hard to go from mail to commit, or for
that matter, from commit to commit: _my_ commit in _my_ PR will have a
completely different hash than Junio's commit in gitster/git. To help
with that, GitGitGadget adds "Checks" to the commits in the PR that
link to the corresponding ones in gitster/git.

This should still be possible even in git/git, I think, provided that
the second App would be equipped with permissions to write those checks.

# The PR labels

Whenever `pu` is updated, GitGitGadget tries to figure out what has been
merged where, and add labels `pu`, `next`, `master` or `maint` to the
PRs, closing the ones that made it to `master`.

This should be equally possible on git/git, again contingent on the
appropriate permission.

# Reacting to `/submit`, `/preview`, etc

We can probably reuse the same Azure Function that we have right now,
provided that GitHub Apps can share the same webhook URL with other
Apps.

That's just the stuff off the top of my head.

To start with this project, if I had the time, I would probably register
that second app, install it on my fork and then pretend that my fork is
git/git, and start testing what goes wrong (trying to re-route the mails
away from the Git mailing list, of course).

Not an easy, nor a small project, I am afraid.

Ciao,
Dscho
