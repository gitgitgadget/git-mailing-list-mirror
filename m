Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707B1C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiCINV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiCINV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:21:28 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F52714FBF1
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646832024;
        bh=h+9jc7oQNuoNX/EyTm/MpyOaPwgm3Y1IvPXp6CDE8b0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=l3GZNW4BK5y0QKx8ZgElSjbIaQ+G8UglHqFQr+Tz1aDzSIFX99UUwPTiZWg1PYcJc
         VSDWAAS0jQQSq/7H7wtKFazFRdTybvVVSVV5YXAZjq2muMOyUbQg509GnXbQ/AW+lN
         spbi9SNCGvYUZ6Db091bekE9L9HnJpZFbDS+FAV0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.147.135] ([89.1.212.224]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQ5vc-1no1UW24Lw-00M4BM; Wed, 09
 Mar 2022 14:20:24 +0100
Date:   Wed, 9 Mar 2022 14:20:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 0/9] ci: make Git's GitHub workflow output much more
 helpful
In-Reply-To: <220307.86tuc9yc4b.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203091404470.357@tvgsbejvaqbjf.bet>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com> <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com> <220302.86mti87cj2.gmgdl@evledraar.gmail.com> <nycvar.QRO.7.76.6.2203071655070.11118@tvgsbejvaqbjf.bet>
 <220307.86tuc9yc4b.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1376950763-1646832024=:357"
X-Provags-ID: V03:K1:6W9+VEfxntlDMIXDm2w8msKU3SCQyQZBQnw1nyXoGo4Pu5V/gfL
 wzY2H80FpMNjC81+iKJjhj/wPSSFHQVXZ1stKOocm1QDDiu2bm1knxHM6ZNsXd1ZsNdnapt
 /Ao1x+xi4NM80I/XewTGVv1rpsG8vpYOle81wdwIQuJawku3HFKZup8YBHQFWBesQanwUZK
 +gFelS5B7nwJLoa3F9Guw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t8Ub/cJTBf0=:JRrkqw4GsOk3JEmMLbNyAk
 G2uD8IiaDm7iKQhEJHAh40zQYu971BkBpO1iTWPhztOBkQn4duLU+TNYF2Ghifi5zXpcjlx7F
 nNfaJhqbKrs1913gTOvqOaCOYPjbAQJ0q2ukKNVA1QLw3IE+IGOYhck4q/Zx1RA0qaKe/rl8D
 QoO3BnDpVshdLVG1qHniJwqdbjomASIze4ioe2YYXovwlZMLcxOAYaZvAMlFwLQokEMFsS8lZ
 p8jm6wQDiQWVomGQj2cFnRgk7emcuLButyNI+Sit9VLyENPbOfbMNvhkhodah9XOCvQ3w4PAF
 pxSHb3EpfXEiNAFQa5S5YDHUwcPPeCBZHsw9fxVGvrmNvmwRZSYHnTUoPLgHjhj+toUwDsXV/
 StblUsbcHfIKMRk2qLpnsIzxhoctO6excN+kMSK+fUAgV4RsIxy3uEaPH0paYEwsNeBIBFhGT
 14wHSNDGQUmO1+s20cuqGzJxiBTB33woPVQlFlJXsmrKk6g6yvdlQIwTgyt1ljB87YIw9IqDl
 4tpLrh3Pv4Nx+UDUs9wHNqJ4kvHvGg8yJFZEhcGd4Mvqns4k0TN42bmMxN9XS914gTe1D8wzy
 /ropihUR8lGohMmogJphn6GZMbaH7v8xRm8UfXfGb+PfuENEpE1ItL33hByUDq/pO8cFCTzbj
 rA6xlyhrWt7XDTOw2wv09fPXfYeUlFtXieIPhpiCzpt95jIpRWrZP7Gm4sl1ASKZ473Lb/4xa
 +YEKVCtY4MRi+8gzr/9PF+xBeEYa8KSHvkM9qMPELhHVrZ6k1QbDxkGTpaJO2QcA4SEj6jxz5
 LfAnP7KE2Zo/c0567H8INZIsNBjYoAtwEeUn2Zd00YFoWJtWFJgpQstqtq38dGv5Di16NeJKM
 GqNFf0B9Yst2g+gjKkW5/3bdvKoMeVtgjF5FW5xPsmc2euzKG1SBNn0PSNKGrRvE/cifZj0eZ
 oSAvH609jEEtleX9nLE0VcTrYVA2atZ7uSFhiZOAriVQCl36BEKtjxLM9kHfJl/MXQnE5ZRQK
 dxgTn9R7OOj7770jXXCCII2RGhRkU4BWmu4p+G5f9uecA0m72fLCn0nsU5EvOF0qdgSC9iiI0
 +oNXnWJ0OcOh+U=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1376950763-1646832024=:357
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 7 Mar 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Mar 07 2022, Johannes Schindelin wrote:
>
> > On Wed, 2 Mar 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> >>
> >> On Tue, Mar 01 2022, Johannes Schindelin via GitGitGadget wrote:
> >>
> >> > Changes since v1:
> >> >
> >> >  * In the patch that removed MAKE_TARGETS, a stale comment about th=
at
> >> >    variable is also removed.
> >> >  * The comment about set -x has been adjusted because it no longer =
applies
> >> >    as-is.
> >> >  * The commit message of "ci: make it easier to find failed tests' =
logs in
> >> >    the GitHub workflow" has been adjusted to motivate the improveme=
nt
> >> >    better.
> >>
> >> Just briefly: Much of the feedback I had on v1 is still unanswered,
> >
> > Yes, because I got the sense that your feedback ignores the goal of ma=
king
> > it easier to diagnose test failures.
>
> I think that's a rather strange conclusion given that I've submitted a
> parallel series that makes some of those failures easier to diagnose
> than the same changes in this series. I.e. the failures in build
> v.s. test phases, not the individual test format output (but those are
> orthagonal).

I do not know what your parallel series implements, as I did not have the
time to read it yet (and it contains about double the number of patches of
my series, hopefully not intended to make it impossible for me to spare
the time to even taking a glimpse at it).

Also: I thought we had the rule of trying to be mindful of other
contributors and avoid interfering with patch series that are in flight?
It could be viewed as unnecessarily adversarial.

> I think it's a fair summary of our differences that we're just placing
> different values on UX responsiveness. I'm pretty sure there's some
> amount of UX slowdown you'd consider unacceptable, no matter how much
> the output was improved.
>
> Clearly we just use it differently.

I would gladly trade my convenience in return for making it easier for
others to diagnose why their PR builds fail.

At the moment, the way our CI/PR builds present test failures very likely
makes every new contributor feel stupid for not knowing how to proceed.
But they are not stupid. The failure is not theirs. The fault lies
squarely with us, for making it so frigging hard.

> >> or in the case of the performance issues I think just saying that thi=
s
> >> output is aimed at non-long-time-contributors doesn't really justify =
the
> >> large observed slowdowns.
> >
> > What good is a quickly-loading web site when it is less than useful?
>
> For all the flaws in the current output there are cases now where you
> can click on a failure, see a summary of the 1-2 tests that failed, and
> even find your way through the right place in the rather verbose raw log
> output in 1/4 or 1/2 the time it takes the initial page on the new UX to
> loda.

I wonder where the hard data is that backs up these numbers.

I do not have hard data, either, except for one: apart from you and Junio,
I have yet to talk to any contributor who said "oh yeah, I found the logs
right away" rather than things like "when I finally figured out that the
logs were in `print-test-failures`, I had a chance to make sense of the
failures" or even "zOMG _that_ is where the logs are?". And let me tell
you that I heard this from a lot of people. Way more than a mere two.
Far, far more.

> > I'd much rather have a slow-loading web site that gets me to where I n=
eed
> > to be than a fast-loading one that leaves me as puzzled as before.
>
> I think it's clear that we're going to disagree on this point, but I'd
> still think that:
>
>  * In a re-roll, you should amend these patches to clearly note that's a
>    UX trade-off you're making, perhaps with rough before/after timings
>    similar to the ones I've posted.
>
>    I.e. now those patches say nothing about the UX change resulting in
>    UX that's *much* slower than before. Clearly noting that trade-off
>    for reviewers is not the same as saying the trade-off can't be made.

Sure, I can do that.

>  * I don't see why the changes here can't be made configurable (and
>    perhaps you'd argue they should be on by default) via the ci-config
>    phase.

I do see why. If my goal is to unhide the logs by default, so that new
contributors can find them more easily, I will not hide that new behavior
behind a hard-to-find config option, an option that new contributors are
even less likely to find. That would be highly counterproductive. If your
goal is to help new contributors, I am certain that you will agree.

Ciao,
Johannes

--8323328-1376950763-1646832024=:357--
