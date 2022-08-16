Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B657C32772
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 09:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiHPJ6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 05:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbiHPJ5b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 05:57:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71BD98
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 01:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660639864;
        bh=zyzZYFtCFYyV3gZwsJ4Pv72pcrDVTOK3qZmitMeY1zU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EwZaUX11eiXQk/FjpTzW3pykfL61l64R6/3PZCL7/siMM8y7Ne7S5zkdm/rt5dMDn
         +EfIRuftFQ/+RxtuMroCzRxBsjWblKqhScOY9l5l5LYNxGW9S2+hNAoUeZn0rkQW12
         1xTW5rcUFpLaPINddTCUgELMBEgRTefTz+DlN0HI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.214.151]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwZ4-1nW2iK0o04-00uLRU; Tue, 16
 Aug 2022 10:51:04 +0200
Date:   Tue, 16 Aug 2022 10:51:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: js/bisect-in-c, was Re: What's cooking in git.git (Jul 2022,
 #03; Mon, 11)
In-Reply-To: <220714.86mtdb1jmp.gmgdl@evledraar.gmail.com>
Message-ID: <8o63pp64-4s00-1000-42s1-38so68398337@tzk.qr>
References: <xmqqo7xufee7.fsf@gitster.g> <s3726r9p-r96o-7793-0qrq-o54rs4npr972@tzk.qr> <220713.865yk1456z.gmgdl@evledraar.gmail.com> <xmqqtu7ldmrz.fsf@gitster.g> <p8srrprq-s23s-711n-n452-34qr856qso29@tzk.qr> <220714.86mtdb1jmp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-307542921-1660636832=:241"
Content-ID: <o3935q70-r9p0-s5r1-s014-76pqr9o752q2@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:nF4DxaAG/drnYgGNvasOxGggCBfzbqLITvPcMvM+vUkUyDZhRFQ
 jZelZ+ogZNbTu1RToBEeMmkCha7YLylszsym1SNgX6pFmIcHiqf0XyuReZ+KuWge9Q6hHgv
 rEpBZ8hlrUrF1ei6XOSF8vE/S4hF0mAGJCqARqhaZZiCDJeAjENVq/Xb9LhirbPW9mqRmiI
 zV9IqlMYVGiy8R5BWlBzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jhdOEVeZz+4=:obxS1sJA2WNux5FN42sI/m
 z7AWfQI9+OthKmYvdPQJHHQiC+cuaVsXS6o/YYNAgI+gAx5frfOWPyPXFFEQ8yoAqlLL+WXku
 58MQPPBlxUi9NYDzpI0lciVNvLcN+mZVNhYSEa87Gfahd4OhFZHYVj0Edz81rGPozMxivxVyX
 4uznynsuTYZsn+PvPFiG9rpnOutRimSTNh25qNNhe/aeaGURMS0Pe4jm0pqLBj5JyOR/gvru+
 Kg6fJrJctCLLnzNxTLrz/wGtwvi05LfqhYb3OfefslJKVREV4mbsF3Qw6wDKXsl5Aegtaxr7M
 anP7WQvClBsZaYu3v73JMSOb5dEkuR71Uav8GmqXwOZrpuVAELeP8TrMUUN/rCkmITkmKNecE
 tcPoMBsh1O/nw1+09UO74gh/VD0cstJb9QMwyG4RqmFUAPw9PHqDHpc9bl/07LQp7iroUdAvM
 JT5sowDaMrGEDaIfUjrCeM2zOMzAvXAMaBm79U75jstMNYzx3z81xmPCm/UxLCP6gLD1+ffhQ
 fFwRxWsoJ+oKbCJdPfFRF1RLe0hr/HccnazByyTZHE6nUESwYpwOpuPBttwKXo9lNudScOcOl
 j1d58yxzKJHxYr8BVHM9ix1cm8yQjIFVgQKpZqFmfsyvpxAnOol3XbyW2cz4hWbkZG0NAgQzk
 wuEIoEZ9UHSToDNrGDlFvjQp6O8uV5P+pPvHltLO2aGYxbRX8Atd+CHuwsCZmYFLiJqL0dcf/
 vgzY8URZzicdKplWEq/MRToutcuXZE1zwSfoGR4SPCGfIWbfBDKaX4QI3xznQiDZB6eePbRJO
 n45wpAWsM2c4rdu/vnVnmT++jCBhMEm9yL5jk6QM9hi/SOaOe8h0C5gqI9Z21vF5Zsbz6aMkJ
 DFE/V9s7LEe5nLuIxgG//i8R/Ynz1NDCgS9D/Vs3TSzvY5WM6Yx9qvmC8WoeFZ2B+VcHswbMt
 0tIQ6DH/wFOMtYEnmOmvfI0JXiEMApXkVUX6UQP8GIzlFsB6phoKj+95LtkFJZQT+hWXjhHpX
 WoUyAlvt8HVDTjS0liY8+1VG6ePyGS8iaUxtirZgqhtzfCtYP4G6nuclzMMuDp8JHKZv1ra7Q
 fBSWSuU7qxTsctSLAnAD37+68AJtC6VfH6nJtAcTN5TmsJPl7pWa2hgfw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-307542921-1660636832=:241
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <s9916nrs-nq87-6620-4713-p1o8np8ors5s@tvgsbejvaqbjf.bet>

Hi =C3=86var,

On Thu, 14 Jul 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Jul 14 2022, Johannes Schindelin wrote:
>
> > On Wed, 13 Jul 2022, Junio C Hamano wrote:
> >
> >> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> >>
> >> > I'm not claiming that we always use 129 when we're fed bad options =
etc.,
> >> > but rather that that's what parse_options() does, so at this point =
most
> >> > commands do that consistently.
> >> >
> >> > 	./git --blah >/dev/null 2>&1; echo $?
> >> > 	129
> >> > 	./git status --blah >/dev/null 2>&1; echo $?
> >> > 	129
> >> >
> >> > But yes, you can find exceptions still, e.g. try that with "git log=
" and
> >> > it'll return 128.
> >>
> >> Yup, that was my understanding as well.  We may have existing
> >> breakage that we shouldn't be actively imitating when we do not have
> >> to.
> >
> > This patch series already implements `git bisect` in the desired way:
> >
> > 	$ ./git bisect --invalid; echo $?
> > 	usage: git bisect [help|start|bad|good|new|old|terms|skip|next|reset|=
visualize|view|replay|log|run]
> > 	129
>
> It doesn't, the claim isn't that there's no way to have it return exit
> code 129 on *some* invalid usage. In this case we do the "right" thing.
>
> Rather that as noted in [1] there's other cases where we call die() and
> should call usage_msg_opt().

It would have been better to take the time to spell out clearly that you
are taking offense in `git bisect start -h` not behaving in the way you
think is the rule in Git: to print a _subcommand_ usage and exit with code
129.

However, this feedback fails to recognize the scope of this patch series.

The patch series' intention is not to fix anything that is currently
broken. And it is already broken, my patch series does not introduce that
breakage (and it would make more sense to address this breakage _after_
the conversion, to avoid doubling the effort): The current output of `git
bisect start -h` shows the usage of `bisect--helper`!

Instead, the scope of the patch series is to finalize converting the
`bisect` command to a full built-in, implemented in C, and avoiding the
portability cost of running a POSIX shell script.

Note: I agree with you that it would be nice for `git bisect start -h` to
output a proper usage. There will be a time to discuss that, that time is
just simply not right now.

Since the scope is so different from what your feedback suggests, I have
to admit that it taxes my patience to see that laser focus on aspects that
are almost irrelevant compared to the aspects that should concern any
good review of this series: the correctness of the conversion, with a
heavy focus on the non-failure modes.

No user would care about the exit code of a failure mode (as long as it is
non-zero), if there are regressions e.g. in how `git bisect start
=2D-good=3D=C3=86var --bad=3DDscho` behaves.

So this hyper focus on what look like less relevant aspects is not only
irritating, it actively distracts me, others and even yourself from the
thorough review I would like to get: There have not been any thorough
reviews of this patch series so far, and I think it is because of this
here distraction.

The cost of this distraction is quite real: not only is there a
performance penalty of running POSIX shell scripts on Windows, there are
also problems with anti-malware disliking the way the POSIX emulation
layer works that we currently have to use on Windows to run `git bisect`,
which would be fixed by `bisect` being a full built-in. This distracting
feedback that prevents a thorough code review delays that fix for those
users.

To understand what I am aiming for, look at the deep analysis of the
rot13 filter conversion from Perl to C in
https://lore.kernel.org/git/4n20476q-6ssr-osp8-q5o3-p8ns726q4pn3@tzk.qr/,
where I carefully compared the behavior of the scripted code with the C
code that was designed to replace it.

At this point, it is good to recall Parkinson's law of triviality:

	Parkinson observed and illustrated that a committee whose job was
	to approve plans for a nuclear power plant spent the majority of
	its time with pointless discussions on relatively trivial and
	unimportant but easy-to-grasp issues, such as what materials to
	use for the staff bike-shed, while neglecting the less-trivial
	proposed design of the nuclear power plant itself, which is far
	more important but also a far more difficult and complex task to
	criticise constructively.

We've seen quite a few regressions as of recent that would have likely
been prevented by thorough reviews that do not distract themselves with
tangents, pet peeves and personal taste.

It would do good if we the reviewers on the Git mailing list took to heart
that Git is a software that millions of users depend on, not just our toy
to play with, and therefore the purpose of our reviews should aim to keep
Git working and safe. We will achieve that only if we avoid what Parkinson
called pointless discussions and instead put in the effort to provide
high-quality feedback that helps improve the design and the correctness of
the code.

In this instance, the discussion about exit codes and usage messages
should be postponed, in favor of focusing on the actual scope of this
patch series.

Ciao,
Johannes

--8323328-307542921-1660636832=:241--
