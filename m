Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC34E1F462
	for <e@80x24.org>; Tue, 28 May 2019 18:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfE1SQt (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 14:16:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:34953 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbfE1SQt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 14:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559067407;
        bh=BMdhm602hn3/geQ/Dw0nkzwb719/x2eILSB7Sqtz7b0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fqcDnJmjF9SwRcA67EpzP0C5GDBst5yYGUTHcvH39kSTmFojY3euyvcXSx2DGCEzn
         kb3z+/ks6G3lbF1Vvrw2VXFi1yXwpCs1b1Oo068cAqIJYJ1N0GlEl+gHqn+ze6xMFH
         x6G8aS+LqkqtN0eOwyRlqItIWEDlS4/MkXVTPEZk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYLa-1gynkE3YPQ-00fwT1; Tue, 28
 May 2019 20:16:46 +0200
Date:   Tue, 28 May 2019 20:16:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Subject: Re: [GSoC] Some #leftoverbits for anyone looking for little
 projects
In-Reply-To: <CAHd-oW7BFYd=LQBF4mF5QTpce9YtXj1WDf85AyO+CLwC9GMqDg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905282014270.44@tvgsbejvaqbjf.bet>
References: <87in9ucsbb.fsf@evledraar.gmail.com> <20190520182353.22221-1-matheus.bernardino@usp.br> <nycvar.QRO.7.76.6.1905281235280.44@tvgsbejvaqbjf.bet> <CAHd-oW7BFYd=LQBF4mF5QTpce9YtXj1WDf85AyO+CLwC9GMqDg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BXNUOl4fkpQIPipKg1ePDXSorXDuTs5N9kLEUQiFJHeEZwVx8rE
 ZsMSI9g0y1NgXXYD/GPzVXjce4rPnYRSA3kKFS3ikRo1cWGX0fY97DuL4/oC9MIhX8RTSNk
 vT0E/4jnug5BdVjkOw7aqpmOBuQNC5xT9EVPBDCHySM//j910FQ31p1WSex4o7FtthgI+BN
 fD3mjUoWH6rFH+lwjjtpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3WwLQFkAA7c=:ESgJgr1lQvXwl/cPhKx/rS
 9almsWm9k+rSysvW3ekloLvTRo479UW54kjx27W7mDheEauht9dMRjRK4Kf++wLL7rU1Mcr+3
 lv5VPxheFs1YQlPd0sD63C9Bx7fwYBlk1VDM2Qi8qgxSV2zw+f5LzpDCeuKO478pkv7HgsHi1
 kLKF4XL2/uEvCJlx6+HRL3Ot2k9eszSu2XeggKfJoyeBYfhKJlY7ShiTMMioT177l7GECDnrb
 ih7IgdxrTQQTGntnFvUNlbdqKvV07rQhLnkp2VXn+7c4G4feHkBDDvSo0wLdhdQgRuASU8GFr
 gDAtNHi/qgEAsCfApqFthfh0g0sCW5e+53o6i74l5wTaRbkROsNKFFl6HIZh0NSvFrX4yMmmU
 5Duwi1W/TI32QHVywUVoVHdNwC9W9UbSCVS7zebToHSXdoA5gn5LwAGf3JC1QXcD+FFU0qh7Q
 Z3tvAV6MpDpq79Kavg/6PFzls82qohGGNJN5Q6I4czgY64MFxe57ni2AnJ94v4rCSqAQyNlhI
 d+xFBI4KafStg+BK0N0MZ9CtNwmPWC6yqAaBovTCvv/J6Yvuhdt3059SodPWQXU5ELgkSaq3d
 c9tGePBYSQ/s7yAQ57ce0cfrH/hbvwy5IbgxV3Az5r8L5rVpLkiQ+XFoy/Y9VrquJXYyf9Vk8
 FnMocTKnsWbOwhHnqeX6DLjduRZfgHLfKQBtcXPr68fj1tsqlgaCBLTz4TWelrYHQPQaSEzth
 msLxNF3SGh6vauvJx0J5YpaX8+Gs8js0wNd0Pf2gtX0bpTOybx4iPfDY8blL+URxDTOCssMgI
 vcSHx+ADYcZufXIY9c2gEHwL8g+y8Opyd+VJT7ZOi58atF8jw+AkbTdfoykuxd0yfcu2hp1bf
 3+PScXUgt5fdp+cUsvCJixG19WSkbESVsv+beBN7QKaY6guxLj6DskjkX7P3P+yswRPwes9e0
 qwuI7Ik3bWo3GdD0subeIHppkFQYVV4RIGvH0W+CVWrPlkk04z4KH
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Tue, 28 May 2019, Matheus Tavares Bernardino wrote:

> On Tue, May 28, 2019 at 7:37 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Mon, 20 May 2019, Matheus Tavares wrote:
> >
> > > > Give "rebase -i" some option so when you "reword" the patch is
> > > > included in the message.
> > > >
> > > > I keep going to the shell because I have no idea what change I'm
> > > > describing.
> > >
> > > I have the same problem, so I wanted to try solving this. The patch
> > > bellow creates a "rebase.verboseCommit" configuration that includes =
a
> > > diff when rewording or squashing. I'd appreciate knowing your though=
ts
> > > on it.
> > >
> > > As Christian wisely pointed out to me, though, we can also achieve t=
his
> > > behavior by setting "commit.verbose" to true. The only "downside" of=
 it
> > > is that users cannot choose to see the diff only when rebasing.
> >
> > You could of course add an alias like
> >
> >         [alias]
> >                 myrebase =3D -c commit.verbose=3Dtrue rebase
>
> Hmm, I didn't know about `alias`. Thanks for the information.
>
> > which *should* work.
> >
> > However, I am actually slightly in favor of your patch because it *doe=
s*
> > make it more convenient to have this on during rebases only.
>
> Another option we were discussing is to document that rebase obeys all
> commit.* options, instead of adding the rebase.verboseCommit config.
> Yes, this way we won't be able to toggle diff for rebase only, but I'm
> not sure if that's something users would want to do...

It is rather unintuitive that the `commit.*` options apply to a rebase.
Sure, you could document it. But realistically, how many users will read
it? Yes, I agree, that is a very low percentage.

Also: you yourself mentioned the rather convincing use case of `reword`.

Personally, I never really thought that I'd need `commit.verbose`. But
your report made me think that I could use it *just* for `reword`, too.

So now you already have two active Git contributors wishing for that
feature.

Ciao,
Dscho
