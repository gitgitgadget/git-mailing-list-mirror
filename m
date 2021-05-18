Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F13C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 23:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 944646113C
	for <git@archiver.kernel.org>; Tue, 18 May 2021 23:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbhERXvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 19:51:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47280 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229969AbhERXvF (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 18 May 2021 19:51:05 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B9BD560479;
        Tue, 18 May 2021 23:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1621381786;
        bh=5yU7URgTsojw0CSyNf5WoYbIyi2oCZcC1zytXp8EYEk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ntYZTlEjC4CMM86tklY5KFOOjZx6eRJJwFaH7U8YO9rJbndDr//MweIjF0Ri2JdP4
         KwEDgQOO8SDEEmrwe+Q/EMgJA9vZLU2+UAxbGAagZRnqzqjVnXqhYAvpFLDBEwv3oq
         Z2u5OUy4ta4QFOiPU7YpIZw3/7tp+XlMNN8WT2Zic7q3TZ4YRJ3zsDDX4m7bo5t/xm
         0yvmBbfTIbnJHuR8YTvpxx+OoiUUEY4Cnd0ETDauIdFETuEJxVsFFBkPiAbgVXDXto
         LQMYI/OXruZz2Rd/KrayWJSAfzciyg1+uliy5EdTS3pkufR6H7+u6OLVEeDF3WTIQl
         u2fJIR9O/2pfESjMoEKEaTGkoAuSAki1i+tEX0gfFuTt4xmapqgzUtMVMq2jdyNGUJ
         bc7vk5D+WeKi88O81K+T6dK44FNQuFRBGiRMuF0mm9tMuHyfvsFRYSzGH5QPDXDVPH
         4imwfumwskcz+s7SRZSn//5R3S4uUsHMd2gmZwNxqxaY7Ej8PBc
Date:   Tue, 18 May 2021 23:49:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] help: colorize man pages
Message-ID: <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Al4ADeQKEOTDzgVQ"
Content-Disposition: inline
In-Reply-To: <60a332fd22dad_14c8d4208ed@natae.notmuch>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Al4ADeQKEOTDzgVQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-18 at 03:22:37, Felipe Contreras wrote:
> brian m. carlson wrote:
> > I think we should let the user decide whether they want to set this
> > feature themselves instead of setting it for them.  For example, I have
> > specific colors set up with these environment variables, and I'd like
> > Git to honor them without having to configure Git independently of less.
> > I expect other users will expect Git's rendering of the manual pages to
> > work like other instances of man(1) on their system as well.
>=20
> It does respect them.
>=20
> This would render the man page with the color specified in the
> environment, not the default of git.
>=20
>   LESS_TERMCAP_md=3D$'\e[1;33m' LESS_TERMCAP_me=3D$'\e[m' git help git

It still doesn't work like other instances of man(1) on the system.
While you claimed that "that's a preference others don't share", I'm
pretty certain that I'm not the only person who feels this way.

There's a big difference between Git coloring a Git UI, like a diff, and
Git coloring a separate program that already has sensible, standard
defaults.  A user who has not configured any color settings would
probably not want Git to render manual pages one way, cargo to render
manual pages a second way, and still other programs to render manual
pages in other, incompatible ways.  We need to consider not only the
impact that our decisions have in a vacuum, but what results similar
decisions from other projects would produce in the software ecosystem as
a whole.

Would you consider various projects coloring their respective manual
pages differently to be a desirable state of affairs?

> > Additionally, using colors poses accessibility problems.  I know someone
> > who, due to his colorblindness, finds terminal colors distracting and
> > hard to read, and prefers not to use them at all.
>=20
>   git -c color.ui=3Dnever help git

Yes, but unfortunately, since you've colored the manual pages, they may
be hard to read for the user who needs to read them to learn about your
configuration.  This is great for you and me, who are already very
familiar with Git and know how to do that without looking, but not great
for the novice colorblind user.

For similar reasons, colorizing help output in general is unhelpful
because users cannot find the options to disable it.

In general, this is made worse because Git doesn't honor the unofficial
but widely supported NO_COLOR[0], so reading the documentation is
obligatory.

> > Even users who want to use them might find some colors to be too
> > similar, and this patch doesn't permit them to be configured.
>=20
> Yes it does:
>=20
>   LESS_TERMCAP_md=3D$'\e[01;38;5;33m' git help git

I should clarify that the patch doesn't permit them to be configured
using the normal Git mechanisms.  For example, unless the user sets the
environment variables, which take effect globally, they're stuck with
the colors that we've chosen here.  Yes, they can specify a single
environment variable before the command, but practically nobody will do
that.

It's my argument that the user doesn't want Git manual pages to be
colored differently than other manual pages on the system, but if you
believe differently, then we should allow the user to configure the
colors that are used in the Git-specific context using Git standard
mechanisms.

> > In my particular case, despite having normal color vision, because I use
> > a transparent terminal which often results in a grey background, I find
> > the standard terminal red to be difficult to read, and so this patch
> > would result in a significant decrease in the readability of the manual
> > pages for me.
>=20
> If you have LESS_TERMCAP_md set in your environment, it won't.

The problem is, I don't always.  I am on call for a set of hundreds of
servers, only one of which has my shell configuration set up, so
defaults here matter.  Moreover, because there are many novice users of
Git, we should consider that for a decent number of users, they
literally won't know where to look in our documentation to make
changes, and therefore the defaults matter for them, too.

[0] https://no-color.org/
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--Al4ADeQKEOTDzgVQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYKRSkwAKCRB8DEliiIei
gUqDAP95XpBh3DefJzAeRi7LrYKjrY57az2LYuyMySV1DXqLLgEA86FJS5rYyojj
dklKgsTlhO6pPVFjNgnKIvMB98RvUQI=
=5rIV
-----END PGP SIGNATURE-----

--Al4ADeQKEOTDzgVQ--
