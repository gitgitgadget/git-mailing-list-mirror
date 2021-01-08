Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCB6C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 14:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98E6A23A00
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 14:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbhAHO55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 09:57:57 -0500
Received: from mout.gmx.net ([212.227.17.22]:39763 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbhAHO55 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 09:57:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610117781;
        bh=KPwX67VKuoikBb+ll2Tn3kSiilKroTSruKqxB9XMCJ0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=M/4scz5TNwhHRtf2GjVOJN81nEPDVMthFl8YbY8JzFcqIHWupzUnWSoRbFjFb36eq
         pfvgkSCjgKFBEGJmN/MmfRK6xEbytUcnQG8rwUTvhmqrWc1oTn8Mebj+U8AKS6STCO
         xegUMy26oDMk4/a1hnW2zKfiud9paNSemQQrUMoM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.251.4] ([213.196.212.28]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIMfc-1klk6j1Pim-00EMKa; Fri, 08
 Jan 2021 15:56:21 +0100
Date:   Fri, 8 Jan 2021 15:56:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Nika Layzell via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nika Layzell <nika@thelayzells.com>
Subject: Re: Cc'ing the Git maintainer on GitGitGadget contributions, was
 Re: [PATCH 0/1] add--interactive: skip index refresh in reset patch mode
In-Reply-To: <xmqqft3cl9rw.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2101081534380.2213@tvgsbejvaqbjf.bet>
References: <pull.475.git.1574539001.gitgitgadget@gmail.com> <xmqqwobpzubw.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1911251523530.31080@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1911251543430.31080@tvgsbejvaqbjf.bet> <xmqqpnhfwibn.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.2101071517260.2213@tvgsbejvaqbjf.bet> <87wnwordzh.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.2101071718470.2213@tvgsbejvaqbjf.bet> <xmqqft3cl9rw.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9DADTRlsYHDshC+yWG0qd28GdaI+2FblP8tV0HTBdThqdSiEWDt
 i7x/lgxN2niZ5gmktV31ZRxyunNszaBMWNEZPTElNfL5Wa6E2knnp1OkhSJjlv8SyG/lNxb
 PxCYpXEKJeo94ELuWsONkU15vadzWvrbbyH3c1Vgg1oTyEXzSKGZ23tSESr3CRuY5sjmeQH
 R9kHykJFV47RhdLGY8nbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:anUvcKXCv2Y=:Tr7tIuNeKaLr7Q2rEWy/UM
 9BpXLH81lKasrL1H8LGBGYz2Nb8myHmc26DJ7Di7aZJ6PhSlFLkgrLF5apNUeHtn/rMS+IySb
 nQb1eZsOAPKotcfJ8lJX1k5BsZJMt51tsTVc68SDJz4dIyIiqR4sq0B6JPXMAjZEmjlhAnX6w
 NMiLi7ZzYK71tsshX+Mp93bzMkbW1XDF3Wod5ztmXVLFnRiQ70Q9zEHBEOQ/sDg3DR+BlMmXD
 J5BdfJF48W6QSWRuLo7jAYQbNBKWZ1184/jx4dKwmN1QIQyjLr7FayDPQJxEjJTC0VBgDINLL
 Ca5ENl/Opvb9h9wUJkgprkQ30g5aUDnXlW384fGfg40MRMxitsEWLa6xmshJzR70cQCqjUsCJ
 CIiv0BJWk7aO2NVUTSyjFxw7M4uF76MM+Pd7y1j/lwdDmObyKuUwjWkiS0zGRu7Y3UF6Ai2aa
 L2883/zgN4/3xXDVmAlvF+4MvEcfCD/u/EzTCgrgFZH96yZkZacqQ/wtDdVUetRvkdyroHIHA
 7etHmmoVNM9F719KI0Jr6ftOZsdKvpLyncJDaQqlYsGyPose5Xg3ukVhYbsddWdbHwXm8sNoh
 o2alteT9NDo3EUlgqb2jH28LAJYxMuQtJcrkUI9XxH6PwfVGm4T0EY0+PijMJPOWug+aTyYTG
 XTZ0FjioaxFEqSqMBRIkYHtKhjzpGZy4yI0grF6voPEJvSsd6auQN0gG4w77C2xZ210qzHC5t
 jRQmxtGDfGoYOPJF8DdRSu1YkOEf7TgYk3Pe3vevrOBTPBZ4hjmLgvu08Om816aOI83+j0RD4
 cyIyAdgj2dAUNC5TFXMlgL0aCcyr3uYyRfZrRGQzxLe2CfNvPiGSwrLjmaz1+LdY2OmC19ZgF
 PeIChFWGskH9IV/qzibFo7KJ1pZxGSbjX8T3Wlxys=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 7 Jan 2021, Junio C Hamano wrote:

> We may not be able to automate the thinking part to decide when
> submitter may want to get help, but an automation can help by giving
> the submitter cues and clues when to ask for help and from whom.

I fear that we're striking the balance on the side of expecting too much
knowledge about project-specific lore from contributors.

My goal with GitGitGadget was to allow competent contributors to focus on
addressing their pet peeve with Git, to produce a stellar patch with an
outstanding description and get that integrated into the next major Git
version, and not have to learn about the culture and mechanics of our
patch review process for what may very well be their single contribution
to Git.

Just look at the wall of text GitGitGadget first-time users _already_ have
to read through, and it does not even catch half of what is relevant for
every single contributor:
https://github.com/gitgitgadget/gitgitgadget/blob/HEAD/res/WELCOME.md

Note that this wall of text does not even begin to answer questions such
as "how do I know when this patch is accepted?".

The suggestion that the contributor should Cc: you explicitly when the
contribution is supposedly ready to advance (according to a set of rules
that is not formalized anywhere that I know of) could potentially be added
to that wall of text, but I doubt that it will make it easier to
contribute even for the most advanced and dedicated software engineers.

> Is there a point in the end-user experience flow, starting at the
> time when they push their proposed change to their repository, throw
> a pull request at GitHub, say "/submit", and then GGG finally sends
> out a patch e-mail, where the GGG machinery can inspect the change
> and give the user (preferrably before the user says /submit) a hint
> that says "you may want to add Cc: to these people in such and such
> case, and if you think the situation falls into these cases, tell me
> so by saying /submit-with-suggested-cc instead of the usual
> /submit"?
>
> And "these people" may include those who touched the affected code
> within the past 6 months, and it may also include the maintainer
> when the pull request is in its second or later iteration.

We already have a ticket suggesting to add reviewers:
https://github.com/gitgitgadget/gitgitgadget/issues/219

With this suggestion, too, we could go and extend that wall of text even
further and expect contributors to just know what they are supposed to do.
But I don't see how that would make this process more inviting to new
contributors.

BTW I get the sense that many Git mailing list regulars have this idea
that making the review process easier for one-time contributors would
invite too many low-quality contributions. However, I see the exact
opposite: professional software engineers I talk to refuse to jump through
all those hoops, even if they would be quite capable of producing a
stellar patch within no time. At the same time I see a lot of less
experienced developers delighting in the struggle^Wchallenge to set up
`git send-email` correctly _just_ to earn bragging rights to have their
typo fix in Git's commit history. I am exaggerating here, of course, to
make a point. And I think this is a very valid point. We lose
contributions (and potential future reviewers) because we make it harder
than necessary to contribute to Git.

Ciao,
Dscho
