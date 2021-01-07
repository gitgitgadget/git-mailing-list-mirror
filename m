Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C4AC433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE8C233A0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbhAGQWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 11:22:00 -0500
Received: from mout.gmx.net ([212.227.17.20]:60815 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbhAGQWA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 11:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610036423;
        bh=OEqz+O/wkEiJDizwbMY1+gAXYi21xOZaB6XqNQM/TKM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hktvhm+/i7DI9Zbt/OjjA2J3f8EfNftNiz1SxM9V7dwUyf0fBwWwxzG12xEDBpG7s
         37CIdYQjz6DgMg1LlyeQSzeZdicSaUeQ1pFH0grZkiXhAfq+A8sacATLmTIhahcqbw
         km0dQqm7mDrZLzUm/FEqxXx5ZY6yS6ZnqGlphHyM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.251.4] ([213.196.212.28]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJVDM-1kiE3z1hqC-00Jr8w; Thu, 07
 Jan 2021 17:20:23 +0100
Date:   Thu, 7 Jan 2021 17:20:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Nika Layzell via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nika Layzell <nika@thelayzells.com>
Subject: Re: Cc'ing the Git maintainer on GitGitGadget contributions, was
 Re: [PATCH 0/1] add--interactive: skip index refresh in reset patch mode
In-Reply-To: <87wnwordzh.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2101071718470.2213@tvgsbejvaqbjf.bet>
References: <pull.475.git.1574539001.gitgitgadget@gmail.com> <xmqqwobpzubw.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1911251523530.31080@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1911251543430.31080@tvgsbejvaqbjf.bet> <xmqqpnhfwibn.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.2101071517260.2213@tvgsbejvaqbjf.bet> <87wnwordzh.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1168004566-1610036425=:2213"
X-Provags-ID: V03:K1:Auf4Nw0n/GPXx1ZykUa+cPTgdPFUQH8RQeXR3oAJpmjHK2GXWQf
 I7AZ4kNZ3Qsafn5E6TaDTuxGFu9dxO++ZDBDC3ohwcG+EL3ZcsTQuYJf7lMJJYZF/P4oUzS
 DaIzPugq7jZNrNgz6FYXKqi3xpRI2wOrmGsK28IEmJ1ukjLDwJLum3zTPBL7s4dSMCydrrN
 N/qnrnkEjnQhfjr87c9+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WVpJ5PpNWOQ=:gmTROXyzsfPNQ4h5Hi9hjN
 IjV/pZxwm5urR1PThySqGqkLbiN6714kSueKAp0vE5EQWlBG2e/15QJLAS9Iq7XqJo1M9hTCH
 8ZCQKY5Q0gEg+cyH9q92ddxbIjksPrcuivLCGgcKV0bwTM6ZhqjL4Isvf7uJvrhst36Exz7xY
 pRwoc7Qc8VoqDMlQcpXaWA/FjFyuy+EpI/kDBTJ4qXw2En1BBzz1KayET0+pp+ktbTLTFD+Yl
 ke05nD3y0LlUGGWBbhjkUMn9p+nMYu+jAeAZS42NYaJcy5NXJHUPvaeNULtyvzUCcs/leb+wJ
 +EmGsl7RxiOaDXWKzlCBIZK8XG8gEaqMuqtBGTbJRyI04cUAnx6mV7CwQNr3mU64IJhMthrBe
 rqljkIqtYzfzr6y3hIQbTatGg+HR2Ul+/QZD9N0/6TtKI6lTro7TMTupPpMZY35qhuD0tlNza
 +0JmJ0cbUHxTYXK3uK38UzUy/mY9ICP58dgPBos53tQvbQOYROO5Ax90/zSgsPr+VpDe2Xgmt
 qLdK9DqjbpcCtpPNuqFH6D7dfrPsxIhIHsFD1Fg7mAOBujXtqdUPGhjTu0FNJOCJ7KS4NEPvJ
 YJdC3CeR5SJPlCfNT85OLjAY1U4Uf/xNtU5ZdyW8XPwWyVZWV+x+4QuUMCZ1QErHlSEOwW+47
 fxAt3JRxDxbyvNPNCmZrrRScy4wGkp85NFWwzQqu8Zsl3ufVTE9U3KawGh2sAnGNGAgwM2l9B
 55JHeIHn9H89zDj+gKWBP4BEdcrItT1/h+eSZXFtYzjAQjcw75BTZZWxkIZsze7Lx39Y2lCU7
 dcGciNccFhmEdaLHsh6zrBHB+aNBxig0zXL8Cg7QoU+IJspgmGf96UYKLmr+udFRtjknKPeJe
 L3uciDaN8CkJ6Veg7kUjF+KK1HnhSOfyo2m9HnVrE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1168004566-1610036425=:2213
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 7 Jan 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Jan 07 2021, Johannes Schindelin wrote:
>
> > Hi Junio,
> >
> > On Tue, 26 Nov 2019, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >>
> >> >> > Hmph, I wonder why this was sent my way.  How does GGG determine
> >> >> > whom to send patches to?  I, like other reviewers, prefer not to=
 see
> >> >> > earlier rounds of patches sent directly to me unless they are ab=
out
> >> >> > areas that I am mostly responsible for (other patches I'll see t=
hem
> >> >> > and review them on the copies sent to the mailing list anyway).
> >> >
> >> > Oops, I forgot to address this. The reason why this is sent your wa=
y is
> >> > that you are the Git maintainer, and as such, GitGitGadget sends _a=
ll_ Git
> >> > patches your way (except the Git GUI ones).
> >> >
> >> > The reason for this is that this is the suggested way, as per
> >> > https://git-scm.com/docs/SubmittingPatches#patch-flow:
> >> >
> >> >> 5. The list forms consensus that the last round of your patch is g=
ood. Send
> >> >>    it to the maintainer and cc the list.
> >>
> >> Yeah, but as far as I can tell, this is the _first_ round the list
> >> sees this topic, which by definition would not have any consensus
> >> ;-)
> >
> > I thought about it for over a year and still have no clue how we could
> > teach GitGitGadget to Cc: you when it is appropriate, not without putt=
ing
> > the burden on any human being.
>
> That message is from November 2019, didn't you later fix this in January
> 2020 here: https://github.com/gitgitgadget/gitgitgadget/commit/b2221f4 ?

I would not call that a fix. As mentioned, I could not come up with a way
to Cc: Junio only when appropriate in a way that wouldn't surprise new
users. So yes, I disabled the auto-Cc:ing, with no appropriate
replacement.

> I.e. now users need to explicitly add "cc: gitster@pobox.com" to the
> description, no? So isn't in the same as for us who use the
> format-patch/send-email flow in this regard?

Right. And that is... intuitive? If you have to read the manual, the
design is broken.

Ciao,
Dscho

--8323328-1168004566-1610036425=:2213--
