Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD07C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 10:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8954D60EC0
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 10:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhKDK2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 06:28:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:40719 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhKDK2c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 06:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636021537;
        bh=7ojE7ANA5ShQO94NMHuRHrOuioWtyoaTHe92hyIFCSo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ODt6jfvu1ynphBeGQiDKWIB9rtFPscxqmxs+EIqST2zoISZEeYK/ca6yC8edISMgd
         2ual5MCL5sxQ9qD/oSz/Fm88zYX4i9j4c7utYsHWyCi5MT1uFanGWftbBazZpeWxZa
         QMT8rbyaS+HTw2LUApN5zfbahOqFeDI6xY/5PUbg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([89.1.212.10]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXp5Q-1nGhLh1fOG-00Y6jd; Thu, 04
 Nov 2021 11:25:37 +0100
Date:   Thu, 4 Nov 2021 11:25:34 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Victoria Dye <vdye@github.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [Discussion] The architecture of Scalar (and others) within
 Git
In-Reply-To: <xmqqbl33a2fr.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111031833580.56@tvgsbejvaqbjf.bet>
References: <b67bbef4-e4c3-b6a7-1c7f-7d405902ef8b@gmail.com> <xmqqbl33a2fr.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1495840233-1636021537=:56"
X-Provags-ID: V03:K1:wSBFoLG/Y06TpthxU6mq2i2AocJOe9LJaTKxK1Q9ImQ/h5/8N9C
 Iv/23he4IFWGcmY1INjha8wuORGjraGmGygLkybLWlU4nTA6w+Mj+r7XZLyu6L6O39eu/R/
 /BPtbVyrmpDBsNc6nmoyoWW6prVXzwnlHfLA6dwGrPOVgdyRAWhFHup/8CvilECHh036SDR
 1sOHB5VfijaLok/uC9G8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kj/0kd6xSjs=:TapXKVasyzavFFFnSZSCEq
 0JubEfWTkzLcA5TTBnRxTHMbgK5YjRzbxdbMyun3Jb5800tDqpyNieg0jwmLX35uVjCgJPJdt
 FPpmgOJrG5zOC8qrj8zAdqX7OwCmYeoHPO0m5F88ddFKEjtFLqGESg7WTsAkdrTDsHLolMqoO
 QPPiJ+IUtIdO36g2A/t7vpIqIari0eMIyCqG0k2Cm4fmo2zDmdKE567Y79K7n6kEhs9LjdQz1
 zI+JGpQWes4sQX5ONJaPahGSrJN6yHks67Z9bP1X5AxHfi+ngUtCR3oh8pY1OadSt0A7zMZCg
 UShlMiu3giyfQrOZeY9E5xZFP5jTlXzxvDgBRCT6koQTk7jNmoPPGzabke/hxJzEqiO18V5qf
 4JGiUPv57zVq0a/0WD4HzX9vyHzZCoCfDymaLktczXbpkn1SQVfBHPdM24oIRlbiFbSeeCNbq
 Hqsc5AFqGgqGo22eC0fyK/w1AHHV1Puw8aAwQ5mKYp+J8dEFb6Weo5nODIoRKkg8Alv0PInus
 URCAVaHniTE0EoxV1/CqN+ClnlvPbIhkl6G52BUqrVNKhVhy3wSZBdfrE+jEO21/aZ7o0pTFu
 JyzTifxy6/AjUAqK4k0K0TZbwIxrt9eHorTTJGYOzOldwBN6HVX2iKHGtFNbGxNIvil4EdboH
 L5iyT6WHcJDPvqSMBU4hjCNvStq+k8ZBk/PZh9JLHCzXZ4FNVeMhjY5qCsUmLqPWUYlnRN0bH
 h14nuVFGkbhACaKafyXj4XPJO/xoPUaD54yhdPgze5n44twIXRg94TUIXWceKCZtYSUrvAIru
 lLxCwAqQgkoMFCmucQ9mDJ/avjEM59r+bhl1VaHj2sOjtR767olUsQUuJ4QF9XZYXLcDrC7u3
 CqYzbjTj8cvuR6D5NUnYx2o9FPhfhL+wG7REgTDpelg/MgFBh+Z6rXhmW9NndUOL5tt/u5TdH
 Pd1MLcx6Tnsef+IQ2OGYPQkFTQIC9aZ5ynihmejbPuhicFJAW/snHQnjlDFfoJVz8ymv7qJAl
 We0i6YjUzjUiBSt+ST9oxcll46yi64q05tZWHIYn9EM6hwPJwdrqACyOmvYNMsS7R1BCGgf5s
 wksROKUP3wPySs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1495840233-1636021537=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 1 Nov 2021, Junio C Hamano wrote:

> Derrick Stolee <stolee@gmail.com> writes:
>
> > Optimization Factors
> > --------------------
> >
> > There are multiple factors involved that we wish to optimize. Here is
> > my understanding of the most-important factors and how they interact:
> >
> > ### Value
> >
> > The main reason to include Scalar within the Git codebase is to make
> > it available to more users. This should have downstream effects based
> > on user feedback about what they like or dislike about the Scalar CLI
> > that can inform future features in core Git that simplify repository
> > management at scale.
>
> In other words, Scalar wants to piggyback on Git's popularity, yet wants
> to retain total control of how its end-user experience should look like,
> eating the cake and having it at the same time?
>
> I do not think it is fair to proceed with this discussion without having
> "Scalar lives in its own tree, uses this mailing list to discuss how it
> should evolve, drawing expertise from the contributors found here, but
> otherwise would stay to be a spearate project" as another option and
> debating its pros-and-cons, next to the spectrum among contrib/scalar,
> scalar/, and scalar.c approaches.

If that was indeed the intention with Scalar, I would totally agree.

We don't want Scalar to piggy-back onto Git. In fact, we don't even want
it to be separate from Git, which is why we are contributing it here. I
firmly believe that Scalar has a lot of value and will benefit the Git
project and community. That is my motivation behind contributing these
patches.

> IIUC, cgit has one-directional coupling to depend on libgit.a just like
> the Scalar wants to link with it---I am not saying Scalar should do the
> same, but just raising it as an example that you do *not* have to live
> in my tree anywhere to be able to link with libgit.a; that would
> probably count as an "**Option 0:** A separate project that borrows from
> Git by having it as a submodule".

I did consider keeping Scalar/C in its own repository, and I, too, had
cgit in mind (and cinnabar). In fact, Scalar/C does live in its own
repository right now, and would remain there if the community doesn=E2=80=
=99t want
it: in the microsoft/git fork of git/git.

However, just like partial clone, scheduled maintenance, sparse-checkout
cone mode and sparse-index, the remainder of Scalar can benefit Git by
moving its functionality to `libgit.a`, or reimplementing it there.

> I can think of only one obvious advantage going that route, and that is
> why I said "I am not saying Scalar should do the same", which is that
> the Scalar project will then retain total control over how it is built
> and how its end-user experience should stay the same.
>
> I do not think it is an option to refuse to take any input from others
> on this list on parts of what you have already done, if you want to be
> in my tree, anywhere, not even in contrib/.
>
> Just like we say "the plumbing command X has behaved this way forever,
> and we cannot break the backward compatibility" to some possible changes
> to any of our tools, however, "Scalar has been used with that subcommand
> behaving this particular way even before the code was donated to Git
> project, so we cannot lightly change it" would equally be a good input
> when we evaluate when some things in it may need to be changed, so I do
> not think it would pose a great backward compatibility issue (after all,
> we do not change things lightly just for the sake of changing it).

That's a really good point.

> But approaching our developers with a new piece of code, saying "I want
> to piggyback on your popularity.  Among the stuff given to you, some are
> out of limit and you may not even discuss about modifying it" upfront,
> is a problematic attitude.

Yes, I agree, that would be a problematic attitude. I apologize for giving
you the impression that that was my attitude. I want to contribute Scalar
to Git because I believe that Git will benefit from it, not because I want
to abuse Git=E2=80=99s popularity to advance Scalar.

> Now, the goal from purely Git project's point of view would be to
> improve Git's user experience, not necessarily Scalar's, by exposing
> more of our users to the way its opinionated (which is *not* necessarily
> a bad thing) decisions work to help its users, and our developers to the
> scalar codebase.  Some of our developers may not even agree with the
> design decisions Scalar made and that is expected and is fine; based on
> such a reaction, the lesson Git learns from Scalar to solve a similar
> issue may turn out to be solve it differently.
>
> I do not know how much Options 1-3 would help such cross pollination
> more over the Option 0, offhand, though.

I am still of the opinion that having the code in the same tree will make
cross pollination much easier.

> > Possible approaches to land in our final target
> > -----------------------------------------------
>
> Here I sense the "final target" is somehow Scalar is delivered to
> end-users through my tree and being maintained there, but from my point
> of view, that is merely an early step.  Wasn't the final target for
> "git" to learn from Scalar's successes and mistakes and give native
> support to itches Scalar wanted to scratch?

I think we are very much in alignment here, and I believe Stolee's goal
was to reach such an alignment.

> And if that is indeed the goal, when it is achieved, Scalar would become
> a historical curiosity just like Cogito is today.  With Cogito, we
> cross-pollinated just fine without having both in the same tree at all,
> and when Cogito outlived its usefulness, we did not have to remove
> anything from our tree.  With cgit, we did not cross-pollinate at all,
> unfortunately, and gitweb more or less stays the same way as it was
> years ago, and cgit is still a project with a useful product.  We can
> reach both extremes even if we take Option 0.  But it would have been
> messy for something like Cogito, which was an early UI and workflow
> experiment, if we took a more integrated approach.

Scalar is more similar to cgit than to gitweb or Cogito in this context:
gitweb and Cogito are scripted users of Git, whereas Scalar and cgit link
to libgit.a, are written in C, and it is easy to refactor code from Scalar
into libgit.a. That was never the case with gitweb nor with Cogito.

> > **Phase 1.** Keep code in contrib/ while we contribute the Scalar
> > features.
> >
> > Since the current patches on the mailing list are not feature
> > complete, it can be beneficial to move forward with the code in
> > `contrib/scalar/` until we reach feature parity. At that point, we
> > could move the source into its final resting place.
> >
> > This leans into the fact that `contrib/` contains "interesting
> > tools... maybe even experimental ones". While Scalar is not feature
> > complete, it can be isolated as experimental here until it is ready
> > for promotion to non-experimental.
>
> I personally have no problem with this approach, but with less scrutiny,
> being in contrib/ longer, with "some stuff are not subject to
> discussion" attitude, would inevitably lower the code quality of the
> product, and it is dubious it would become "ready for promotion" ever.

To be clear, I'm not pushing for promotion of Scalar to a top-level
command delivered via the Git project at all. I _might_ push for it in the
future, _iff_ a wider audience has used Scalar _and_ finds it useful.

In any case, pushing for Scalar to be such a top-level command would be
premature at this stage: to avoid overwhelming reviewers, the Scalar patch
series is not yet feature-complete, there are other patch series I intend
to contribute on top, when the first patch series has settled down.

> The contrib/ hierarchy, especially in early days when we wanted a way to
> grow the ecosystem, as a place to host "these are done externally, and
> we only carry them for convenience", was a successful model, but I do
> not think of anything that successfully used contrib/ as a nursery to
> later graduate to the core and to be seen as the same quality as other
> things that started their life in core.  I am pessimistic to the model
> that uses contrib/ as such a place.

After seeing `vcs-svn`'s fate, I understand the trepidation. I, too, would
have loved to see it being cooked to perfection and then graduate.

Even so, I targeted `contrib/` with my patch series because
`contrib/README` says:

    The intention is to keep interesting tools around git here, maybe
    even experimental ones, to give users an easier access to them,
    and to give tools wider exposure, so that they can be improved
    faster.

Does this README's intent still apply, or has the purpose of contrib/
changed?

> > Depending on the final goal, we could drop some of the work that is
> > currently built within the `contrib/scalar/` directory, such as
> > `-c`/`-C` parsing or documentation builds. These features would be
> > reimplemented in the new location, so we can prevent that duplicate
> > effort if we have a different final location in mind.
>
> > **Phase 2.** Establish community standards on optional components
> >
> > While the work in `contrib/scalar/` continues to reach feature parity,
> > we can work as a community to set some ground rules about these kinds
> > of optional features (depending on how "optional" we land). This can
> > include standards such as how the files are laid out in the repository
> > and how they interact with the `Makefile`. Whatever we do for Scalar
> > is likely to form an example for a future contribution that we can't
> > predict today. Many of the questions we are asking today can be
> > written for posterity:
> >
> > * What is an appropriate level of coupling with the Git codebase?
> > * Where should code custom to the component live?
> > * How should documentation and tests be organized?
> > * How do we initialize builds of a component?
> > * Who is responsible for supporting the component? Who fixes the bugs?
> > * Who is responsible for reviewing changes to the component?
>
> I am afraid that the answer to the first four are "it depends" (but the
> remaining two would fall out naturally out of them).

Would you like me to organize the code and patches such that they more
clearly fall under your maintenance once the patches are merged? If that
is your preference, I will gladly put in the work.

When I submitted the Scalar patches, I did not want to burden you with
maintaining it, I expected to maintain Scalar going forward, but maybe
that is not your preference? I assumed it to be my maintenance burden, we
aim to support backward compatibility for existing Scalar users, after
all. Absolutely everything else, however, is up for discussion, subject to
the full scrutiny of the community and to the same standards of a
submission to the core of the project.

And I see your point about backward compatibility: The Git project has
plenty of experience with maintaining backward compatibility and _still_
improving on initial designs. I therefore can easily give up my hard =E2=
=80=9Cthis
command-line interface must not be changed=E2=80=9D stance.

> Thanks.  My brain is fried with the -rc work, rereading the material
> that went to -rc0 since the last release, so I may have more to add
> later, but for now, the above is what came to my mind.

Thank you for taking the time to respond, especially during the -rc cycle.
I look forward to continuing this thread when you have time.

Ciao,
Dscho



--8323328-1495840233-1636021537=:56--
