Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37C9120A1E
	for <e@80x24.org>; Sun, 23 Dec 2018 23:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbeLWXSm (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Dec 2018 18:18:42 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57922 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725911AbeLWXSm (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Dec 2018 18:18:42 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c537:b034:2963:7e8f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 81B8E6042C;
        Sun, 23 Dec 2018 23:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1545607119;
        bh=7VqVuM5BoqJqFZe4Y95OrZ8aPd/EQF7EtdMAnNKDJUA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=VaMCI04dmo6kAbfEQkx6ceOx/+DMvE3DsKLlN3n3z3HsanzjfFPJjbeo8kuBMfFxZ
         87e88kuOBYLG8XBRJoXAWaHAPSuio7FeYCqFizTra0XbQWHObiBI4v09YGY/OQS737
         31Dfa2S01qq6j4VxDRhXAQVD2c4neZ5PWbn2BXx+UyWBcneAH0nc8dsIdwpyk4ilCg
         QY6ykDxfMJEzAuzYMWbv34K8dcvumx2X7hSJCBsXqJuyYpaoQuEZCQFIXVqb0LYGJL
         ztlevCYgnqxsKGtzLoqCMsUIk+saK0osECtggiZLU6hJ0hsUrMQYXlOSzV454yOc2N
         Ec50lGIryHNTV31lJcsPP3w039n3wnzPVf30irzt3DZMFo8MHTgpsvFHfMpkVlvAtF
         bEG1Fnsiy83VHFmfWugvQH9ptiideVwbq7bIQMZSxxRsrtmu+r7T3vMsA96DVuVgjX
         MSXzXmcMY0+mbBrG5NCXh/f5XnKkQ8XkE94UqDT/v/km2KY4cYf
Date:   Sun, 23 Dec 2018 23:18:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     John Passaro <john.a.passaro@gmail.com>, git@vger.kernel.org
Subject: Re: Can git choose perl at runtime?
Message-ID: <20181223231834.GD26554@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Passaro <john.a.passaro@gmail.com>, git@vger.kernel.org
References: <CAJdN7Kioa22xrDP2ssZXmBbu7KDkcr2MQCUDW=Tzm5ydzeChBQ@mail.gmail.com>
 <20181221234231.GB10611@genre.crustytoothpaste.net>
 <87y38few5h.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G6nVm6DDWH/FONJq"
Content-Disposition: inline
In-Reply-To: <87y38few5h.fsf@evledraar.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--G6nVm6DDWH/FONJq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 23, 2018 at 11:05:46PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
>=20
> On Fri, Dec 21 2018, brian m. carlson wrote:
> > How do git send-email and git svn work in such a case? They depend on
> > the Git and Git::SVN modules being in place, so if you use a Perl other
> > than the one you built Git with, they won't be present (or they'll be
> > present, but potentially with the wrong version).
>=20
> Yeah this is one of the things I was alluding to in
> <87a7l1fx8x.fsf@evledraar.gmail.com>.
>=20
> We don't ship any C bindings, so our libs end up in
> e.g. /usr/share/perl5, some custom-built perls will have that in their
> @INC still, no idea if any of this OSX stuff does.
>=20
> But otherwise we'd either need to give the user a way to override
> PERL5LIB (or they can do it themselves...), or better yet continue what
> I started in 20d2a30f8f ("Makefile: replace perl/Makefile.PL with simple
> make rules", 2017-12-10) and make our perl stuff entirely decoupled from
> the system install.
>=20
> E.g. Linux distros would probably still override that and install our
> *.pm stuff in their usual Perl places, but by default we could just have
> a libexec/perl directory with all this stuff, and find our libraries
> there, then it won't matter if we chainload to a new Perl interpreter,
> we'll still find the libs in the same place.

This wouldn't fix the fact that we still need modules like Net::SMTP,
Authen::SASL, and IO::Socket::SSL (because these days every provider
forces TLS on the submission port). Since those are going to come from
the distributor, letting people override the Perl path to some arbitrary
path will mean that those modules may not be installed.

I also think that the situation you want with relocatable modules is
only going to be useful for people who custom-install their own Git,
which is not most people. Nobody shipping a packaged version of Git is
going to install modules in a custom Git-specific path (since they can't
be loaded by other software), so everyone who want to use a custom Perl
will already be compiling a custom Git and can just specify the Perl
they want to use.

My concern is, more generally, that this situation is going to lead to
hard-to-troubleshoot user support issues. I routinely answer questions
on Stack Overflow and I see all sorts of cases where users who may be
great programmers but are mostly unfamiliar with Git end up in bad
situations.

For example, at a previous job, we shipped a newer Git and Perl, which
were installed in a custom path (so definitely not using relocatable
modules). If this option were enabled and user used the newer Git, which
was installed in a custom path, but the system Perl, things would
definitely be broken, since the system Perl would almost certainly have
none of the right modules (or, if it did, they'd be grossly out of
date). A lot of the users who would run into this issue are less
technical, and so wouldn't know how to fix it.

We've traditionally shied away from specifying things like
"#!/usr/bin/env perl" specifically for this reason: because people will
often have custom-compiled versions of interpreters that don't meet our
needs. I'm not seeing how this is significantly different.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--G6nVm6DDWH/FONJq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwgF8kACgkQv1NdgR9S
9otKkA//bbkDklu9kLIQll9xCGTWJKV6Hw4WTAidDEfS7hygSXIeZp6MkZXvdnTk
ik2fbBtDIdN4imyEemwF75lANdC0FNA/VHCM9P4C0YIsMQJaMKjcS1LcY5vvEFow
Qm1A2aY6GmQFIQuqdtUPa5FPJyC+ai3kUKM/L3Zszdp7pLaOpqE5Tktu5S7nuNDV
1VHmy+K4fpQttPqL2xfER9q9kmLEngVG6m/pxxfrMrOLDTk2jJvuw0OYPo7ZpN8g
gcY+W9shjVB2MgYyUc8rA6rA58Ks7NIdpmw8r5WLf4Xp6oW7yWKaV207TbiJ2wRl
gs9JdWwOdZb0x3wcbJLSY6SXzHgXHLxgKFsVm2xb80kowpuTUcYZF9gs6dSrBo3s
Yc6qvHssDFhE/bPqeJ6+ZI+9QZQ33H7PLj1mbU5w4HgffkawBm1OKvLAf1AXeLE3
Huxq0yAX+3NGuYip+Dil8ao/8LBykRRMeA9+24IvAlU9qPZyDiXYLC6va0uOgVGb
bYLTKh6lCpMsluxQ8fMVn5I9Z4MIeK4UpJ7mfe7XstLM8dLHxI6Gwk7P+fSMd5p5
U1W0GedM9fasUt+0fCEJV4YSWx3dA9RfjhF3gKD1tBatpCLJwYF/8ysmNImN6oNn
JuGxcjIahV+cyn0gukmTyUEVMFt67anWqPGsGy3P56ubv3q+OCA=
=e2dM
-----END PGP SIGNATURE-----

--G6nVm6DDWH/FONJq--
