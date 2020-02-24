Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3A7C11D2F
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 15:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D2020866
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 15:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YCObhRXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgBXPst (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:48:49 -0500
Received: from mout.gmx.net ([212.227.17.22]:44181 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbgBXPss (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 10:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582559323;
        bh=MOYWqiczfhpvc97g/6XtrC57wygga3FIMnBjCxqTRqc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YCObhRXfarM6+J2JMeU3K9f9tZ+V/RZLW7ASTRC8ekMNROgEHhkJbTNgkhPnRfnYT
         FdWUCSh9OhyCQ0HvQrKilS34sKdAMrEJlVNLRlGemLq5c3rOh8j/TSXX1KdpAm5NMs
         PHo3t2re3qH80fLO55WqOXmFTDwuwNRrKpkbFfM0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5fIQ-1j3V4q3w9S-007FTp; Mon, 24
 Feb 2020 16:48:43 +0100
Date:   Mon, 24 Feb 2020 16:48:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Heba Waly <heba.waly@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: GSoC and Outreachy Summer 2020?
In-Reply-To: <20200223214433.GA564650@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2002241648000.46@tvgsbejvaqbjf.bet>
References: <20200122053455.GA51054@coredump.intra.peff.net> <CAP8UFD1-cswU0gSX3a2KqiExhYgY_qMZ6Sz7FHdxs7mrb_hh-w@mail.gmail.com> <CAP8UFD2_qmB1q9vhz=BJo3XG4jnLWDPhCVVb4gAh_pfKoGnZJQ@mail.gmail.com> <20200204163716.GA7308@coredump.intra.peff.net>
 <CAP8UFD3UewcZ3oid_SiUYuFEO49JTzaSigHDTP8OPs2yh6s6zA@mail.gmail.com> <CACg5j25_098i=rU++OB=YSbAFjCQdgUX7gP6D-9yo6F_A_yn0w@mail.gmail.com> <CAP8UFD1QbOK9g2oAhfTm2npoNF9Ay_HiAfFai9rJwZzc73cBbw@mail.gmail.com> <20200221183003.GA9786@coredump.intra.peff.net>
 <CACg5j24mH0LRHXbhgf16f+7KqOnrsh7BRovh8mR6AzHG=y5gFA@mail.gmail.com> <20200223214433.GA564650@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bm++78R2M8r92dv7lqixMeYri4jONcSmvkYbV24d4rzwo4TwtW2
 d//pTmpbTo0309m1Je75/vOefvaWnqnzNf6spjvgqLGR3EEK0+O8yjSKzM1FcWsqGs+Wz7i
 aU6KAHVBhALh7D+Oxm2srNSDFwRobGvRzhvppNruPkjSJKfSAzCry1VYB1BJcrOz6n2f4cR
 x0q9KKcRecGDwIFL3yxLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0KlttNUmu98=:L9jb9ONZeQrzRqXmTG2S5R
 lFGuuehyWgQbSfqzAk2m+U2mZmKWA3a5qaC5Uij/6yZ2rZkIDnGZuL8ailgqs63qzDrmKY7in
 yF+EqUtcJBBHmmHf4/P50sCrHvyZw/osXUfgAkpsnbAh33AofvSP2HF+08nQdHdgZv6ttXCBg
 0lYNW4wjo4/EUjffQ8gjZjFjhVmuvpUdm8OrO6bouxC6rRREkIF1Vu+cgmNAQ+RVMxVkPyotF
 MDn3rRQJKcUI1TIw8fBa2pDZwf9AX9KBMiWBYZR844JSaOLZiYxOJRZGByxd10MvH7+KInW07
 tqEzAVy7EwURz9OLydFvpwK4xATgTeP2aqs36jPXCjhNpq0rDDZ+ahUXNpWdSQ6FbGKNvsI7o
 PQb1j5DTwNE9Uc/7NVrpUb6LmjnrT2ymAOzG2VbLNHh5DSROAuJTXh2Bo9BxhlbqdSzZ83D1a
 Uqyd3Mv7qrQGShBRebtF2fEOzhM9z0Q4gQoBMqfqvt2eIKwKgSiykNM642qha5f3o7P+B0uaF
 4FL57/Eg+djOYO5Nk5SBgF3M2finUGerFmyAKpyhqNKDXRnDXx0DGXzMXua3P+L9scVQRWHyP
 0YoZ00KLAHeole7YrKlQ62eLQNtLQxlNh2Ktq/h7Ns6mGauEj+HLwhi/7jBe6QXalf95TItgE
 3bTvbQImtURHjDtam7KUFGTvrMvodCOC2AdVfQztczu4a9UxZ87XyctBN6shmZEobPr90C4re
 ZSTbXy1b8U70E6z7ErIEwtkoiRqKqylqkQWMZtK3/Z5hOQ5baPAYlN+jBXsL/S2yoc+N0FcxY
 ZjaMLJGWcUyuhuhQePCmgiFw8gJUmCMoRLc3nCrfMX5tj8pCSuZXiumrjhqyA8ZQwBeUQn6q7
 OBeTkdlwl4n0Azdy9+QajPYjXjhRcTDZ0fvSPJhlDMd9HD0M5Nkh9Wxoj2VEgZMDjyfwOy6p4
 fPq+e6yKJpJTQg6TsDlTHQ4Cuf/AtM3+cc8yHODC7o8+OuCK7Een27vUxzlUTT2/hxIdgQWlF
 f+3tOKge+VGGbOylXlmr2PjtKi9baUhd3f9m+BlefjBqFLynIv39gN+/GycQR72KVjqBO8tDL
 Q6vIhvPgdYHl40movW+/CAK4uWJ0UA4lhuKrPU1kcL2FdpJ7fV0Gy6HW26vypw1yOW+gg7AZB
 TuFJ4fgnnb+e8WGvO9BeHh24wExWiCT2FnpUjcfdaXWd+65BrA0zBVYqxQD8QPb6Sc/xfKWRa
 hzjd06VGCh4qu0YNI
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, 23 Feb 2020, Jeff King wrote:

> On Sat, Feb 22, 2020 at 08:20:04PM +1300, Heba Waly wrote:
>
> > > I think it is too late. That's the deadline for mentor project
> > > submission, but the signup for orgs was Feb 18th.
> >
> > You're right, but they mentioned on the website that Feb 18th is for
> > new communities who haven't participated before. I double checked with
> > the Outreachy organizers and they can still add Git if there's funding
> > and a mentor is interested.
>
> OK. It's a bit tight to line up funding, but we might be able to make it
> work. The big question is: do we have a mentor with a proposed project?
>
> Dscho mentioned a willingness to mentor, but I don't know if he's got a
> project proposal ready.

I would be willing to co-mentor, but I have no good project lined up, so
it feels a bit rushed to me. Maybe take it easy and apply this fall?

Ciao,
Dscho
