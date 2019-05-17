Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DCD41F461
	for <e@80x24.org>; Fri, 17 May 2019 19:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfEQTjx (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 15:39:53 -0400
Received: from mout.gmx.net ([212.227.15.18]:32801 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728560AbfEQTjw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 15:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558121987;
        bh=VHPF30+10flbaT7VpKrnr2W8XOQ4fF1XcTm00ks1l5I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RyANaQRWhdMRIGPycAXxi3uMuH54pM8wo5get4KqyQJdpKcLKEdHhka1AGeOayo2O
         Kt5Ru+6eNC7+qR6ETotU8CF0miMLsa9hOFTy1QiaDqceCy4g6ZaMo8+VdnuYuFkYSK
         5wFf/CVIbbj3jyQCx+WYYj3E2DMuBwVdUwTEgvdo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVui8-1hCQvK3hBw-00X3hB; Fri, 17
 May 2019 21:39:46 +0200
Date:   Fri, 17 May 2019 21:39:55 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git ransom campaign incident report - May 2019
In-Reply-To: <20190516042739.GH4596@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1905172121130.46@tvgsbejvaqbjf.bet>
References: <CACPiFCJdXsrywra8qPU3ebiiGQP3YPC6g-_Eohbfwu_bQgfyVg@mail.gmail.com> <8736lfwnks.fsf@evledraar.gmail.com> <20190516042739.GH4596@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-173282728-1558121996=:46"
X-Provags-ID: V03:K1:HtLUTqNsAUSMK9Ta1HlVnfNzm88ks4GOHSNr9ihLr9ZV7keAqdQ
 VT/YYwODDL7gxqUKGAGtKxcwg/OdELaMT07I0gYRY9mgzAqi+q0x1CVkmgTRd9NbMBz3yCh
 ECHrF2StqMdl/KNaKDLVVmf+f9Lc800i6+T2coC2hoDkUVFhzB8XSdRdz1iWw1GEr3GOAmK
 Euf4197x7VPOL/fo+F6VQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jD0aO9oEyw0=:FZLiwNRWndZTjXvJBordKm
 WL+cDKjnXS4s8xY37gpjcac1mMluI2mGP31Inoyiiv3/JO7cj137q0jI8y3jaLhalCOw5o7sE
 yC8EfdShNFLy7Nv3p3qAbWFp6JSfqt0y4VnkDs/ULmKIftTkRlwm+UxBXpLrPgoBcHzRLmgKt
 jJy8HCneX9JCQcM0IuZ33GpNGAzOSyxRaMTYnLkFfTlieXgLmKq5jfOaNpagGBnDxhj0lqkgL
 jP8dfShlDIiOA78bv49Q7Szqbsl40ucGP9st/srQp1V0iD9Ug22lODaLjW1YFBKlU0gfqg1G4
 XLW3pQsOkKpeTOdv1Fv91deLem3vS7bQyFOlls5LxR2NxqNKjN4O5S5thfhqCL3aZD0m9/cVV
 eLgHXf2Fj/70SPuqLOrlJpLVBirBGssO5jynQ99DPO3KFA6yrsr4vMaBL0xkbqLz/LH3xdRJL
 BGyYQY59H+fvnp1gO8fvQyFxRcLMUlCkbQSVe3QtD6QubeZQo4aVMaCPJYRgHn6oLW7i1ugXZ
 KD172zwSPZKOX6exwrAtOJICiHKzNij09Z9YYzYsg5NCwAkx0NEQ0Z0RgS+mIec3Sz/bWGRb3
 DYkpm9DNkCROl5iSUHvy069LlXy82si+72B9TkR3OBke1HVPcanOLc+yE4+E6q82PhYP385yq
 JG+MA/Vj6vYZ0e/b5vNSgRDrD6BQj23eBrYhh9lLmlW8h9T3eo3iQG0azicZyPB6UEDSb5gD+
 4Cluqy3CreArSrVp7i6OKdHYcbyCI3pxvWk+9qT2zmd63/q8Q3uqw1lw2aNGI5EBjsbE0QSSg
 TygXC+CdLEuA8/yZzmQ84gb2YwRFfcWTEDri36HRAH/tGQPFa5O9EEM2mEPW2076KN2A+ep9c
 LQrA5m1dyW9IOst/ZnMc7mi2CQoOMdg+5ZcrkpzmJR5ZTcIpHvV4DeOiQCnA43dqdPWN0FKFT
 Z8sk0QWNIRQYdingrVMjF0P61tacvdslUZqgwLNoTsDU1VckWvXhm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-173282728-1558121996=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 16 May 2019, Jeff King wrote:

> On Wed, May 15, 2019 at 08:59:47PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>
> >
> > On Wed, May 15 2019, Martin Langhoff wrote:
> >
> > > Spotted this on the internet...
> > >
> > > https://github.blog/2019-05-14-git-ransom-campaign-incident-report/
> > >
> > > Haven't hacked on git for a while, and I am not affiliated with any =
of
> > > the stakeholders. However, reading it, I wanted to slam my head on t=
he
> > > desk.
> > >
> > > IIRC, git will sanely store a password elsewhere if it gets to promp=
t
> > > for it. Should we be trying to unpack usernames/passwords from HTTP
> > > urls, and DTRT with them?
> > >
> > > Are there other ways this could be made better?
> >
> > I think we should do nothing.
>
> I think so, too.
>
> But just brainstorming, one thing we _could_ do is issue a warning when
> we see a password in a URL and say "hey, what you're doing isn't
> fantastic; considering using a credential helper".
>
> Of course I suspect there are many cases where people _do_ need to store
> the password in plaintext, because an automated system needs to fetch
> with it. They can use the plaintext git-credential-store, but it's
> slightly more hassle. And it doesn't really _solve_ the problem (though
> perhaps it would be harder to accidentally expose it with your web
> server!).

One thing that we actually *could* do here is to anonymize the URLs stored
under remote.origin.url when cloning. In no other circumstance that I can
think of do we take an URL from some command-line parameter that is not
*explicitly* intended for storing in the config.

Combined with that warning "You cloned via a URL that contains
credentials; for security reasons, the credentials were scrubbed before
storing this in your Git config. Please consider using a credential
manager instead of storing secrets in your Git config." this should
provide a reasonable compromise.

Judging from looking at my own automated jobs, it does not appear that you
would *ever* need to store such credentials in the Git config, anyway. If
you need to, say, push to a repository, you can always store the full URL
(or the credentials) in a secret variable.

Ciao,
Dscho

--8323328-173282728-1558121996=:46--
