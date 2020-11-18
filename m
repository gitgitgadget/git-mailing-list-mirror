Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007E5C56202
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 00:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B3B624198
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 00:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgKRAuY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 19:50:24 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42882 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726592AbgKRAuW (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 17 Nov 2020 19:50:22 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CB0806044F;
        Wed, 18 Nov 2020 00:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1605660621;
        bh=T7B5bxJBDDBadzOd//Nl9zVnIdecCiqUep+/+fLRR8k=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=sBo40/Uxb2NjnZ5c7EkPUfEvs85lsXlyq6iZAKqg9rckq3jMQb/dCo+YaXEvw6xDa
         dq2vvPzZPedpNn/CwMZV/Qpt0D49p58U4jXtUXMyJcJF3EDGC4kNOgs2GnW7V8kPia
         KDX/CNC8QKmWazC4NBmhdy2bFMn3BPKaiv43z5LQkyEKbqATKK5SsGp8E48lLSTNeY
         MpbhY7F9EvmZNUCwOUdd+s+bbIEtnGJ8SJkqR625v7nm758vgI9jZQn2PBIm0Mxax+
         XqZ9Ki0+ocahOzd2yL4mKNs8VPkCVSKrbABXouDrzu3Rlf4JvPZ0th9Gb6HScAOtDH
         8VKYW0IpkTIr/nkybKFa/sfvHvKPMmM8Aj3jy4ohZIwVYHFUvLKinpwME/m8IDoC1k
         H85eU2/wNcR2KPL8uJj1o0rZUgDRA6f1sVe08TSbGkFJLIG0lA/GBDriJuEQp3lnli
         VK9+1R94TouSX8XtGKKBb7/eamYd1C8ZZwhHbAfp2bp2+7ovlb+
Date:   Wed, 18 Nov 2020 00:50:14 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: allow specifying config entries via envvar
 pairs
Message-ID: <20201118005014.GC389879@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1605269465.git.ps@pks.im>
 <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im>
 <87mtzlflw7.fsf@evledraar.gmail.com>
 <xmqqy2j1851k.fsf@gitster.c.googlers.com>
 <20201117023454.GA34754@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Content-Disposition: inline
In-Reply-To: <20201117023454.GA34754@coredump.intra.peff.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-17 at 02:34:54, Jeff King wrote:
> On Mon, Nov 16, 2020 at 11:39:35AM -0800, Junio C Hamano wrote:
>=20
> > >> While not document, it is currently possible to specify config entri=
es
> > >> [in GIT_CONFIG_PARAMETERS]
> > [...]
> >
> > "While not documented" yes, for sure, but we do not document it for
> > a good reason---it is a pure implementation detail between Git
> > process that runs another one as its internal implementation detail.
>=20
> I have actually been quite tempted to document and promise that it will
> continue to work. Because it really is useful in some instances. The
> thing that has held me back is that the documentation would reveal how
> unforgiving the parser is. ;)
>=20
> It insists that key/value pairs are shell-quoted as a whole. I think if
> we made it accept a some reasonable inputs:
>=20
>   - do not require quoting for values that do not need it
>=20
>   - allow any amount of shell-style single-quoting (whole parameters,
>     just values, etc).
>=20
>   - do not bother allowing other quoting, like double-quotes with
>     backslashes. However, document backslash and double-quote as
>     meta-characters that must not appear outside of single-quotes, to
>     allow for future expansion.
>=20
> then I'd feel comfortable making it a public-facing feature. And for
> most cases it would be pretty pleasant to use (and for the unpleasant
> ones, I'm not sure that a little quoting is any worse than the paired
> environment variables found here).

What if we didn't document it but provided a command that produced a
suitable value?  Maybe something like this:

  GIT_CONFIG_PARAMETERS=3D$(git rev-parse --quote-parameters a.b.c ENV_VAR =
d.e.f OTHER_ENV_VAR)

Or whatever we decide.

I don't personally love shell quoting as an interchange mechanism; I'd
prefer something like URI-encoding, which is a bit more standardized and
easier to reason about from a security perspective.  But if we decide to
change it, it doesn't matter, since it's still undocumented and this
would be the only acceptable way to pass config through the environment.

Alternatively, we could just do this:

  git with-config --key a.b.c --value ENV_VAR --key d.e.f --value OTHER_ENV=
_VAR --command git foo

That would also leave it undocumented, but make it easier to work with.

> > I especially do not think we want to read from unbounded number of
> > GIT_CONFIG_KEY_<N> variables like this patch does.  How would a
> > script cleanse its environment to protect itself from stray such
> > environment variable pair?  Count up from 1 to forever?  Run "env"
> > and grep for "GIT_CONFIG_KEY_[0-9]*=3D" (the answer is No.  What if
> > some environment variables have newline in its values?)
>=20
> Yeah, scripts can currently assume that:
>=20
>   unset $(git rev-parse --local-env-vars)
>=20
> will drop any config from the environment. In some cases, having
> rev-parse enumerate the GIT_CONFIG_KEY_* variables that are set would be
> sufficient. But that implies that rev-parse is seeing the same
> environment we're planning to clear. As it is now, a script is free to
> use rev-parse to generate that list, hold on to it, and then use it
> later.

I'm also uncomfortable with an arbitrary number of keys and values.  It
becomes very tricky to cleanse the environment, and even if the code
stops at the first gap, if you then add more entries, then you have to
cleanse again or risk a security problem.  I feel like this is only
going to bite us in the future.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX7RvxQAKCRB8DEliiIei
gcbXAQCMa6Zlr0m2P43R63cZSScETvsVmUvaQbLFUVQKpsn5/QEA9RSALHW7oyii
PURgjRtoafhb1wNdN6Hxts1duJ2TTAU=
=RMbn
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
