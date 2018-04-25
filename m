Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BDC41F424
	for <e@80x24.org>; Wed, 25 Apr 2018 02:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751244AbeDYCAW (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 22:00:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33288 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751233AbeDYCAV (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Apr 2018 22:00:21 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1947860129;
        Wed, 25 Apr 2018 02:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524621618;
        bh=B7D3OeSfyJrdvkZlp0qvkGre5FvDi34Q84rUv3uwYDY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=OM8szGxQLL7LxbszYtB+xCOY+aWRK8HjTXBFT76DEwoBxHAoEUN7V/PK2lg65o4aI
         8HJ1WspojmCovu83UIctwqBuKGrJ+KuH3/LPwWWjTMMaDSAG1d7O0VTyZ3t1A9hdkX
         4Gf2R0sTlmdK7orcRLC4Ifj2J43Y1/4Z5pWDtifcu2s7V3wg1nbjkyXERKEpidR1DV
         gMJAoFAAccs/efzCYeP+HeT+ptxqe08USiSNa8iMeEzRXXbNdePo2atamWFv16S1pQ
         Ht5Bxa3TbUW4VnlELhQBVL9o8pYsoIJHm5dq6wRmnz+dlf9OjegroWY7jLpIoES75e
         J803wnzTcHQOY7QPeSy3gZxk0SECHBYJwFi33I/7TPOXZnB7vmswxjQTkNob9uZ9yA
         HWbLfgI/eN3VH565WTJhMrDuUCnBQ62xwALeKbUtdmV2Nvsulc5On+XG0Lz/CJC6DN
         LRabSCo/MX7dZwyfUD9G+v4Xx/O2nMwdSJ0Y4JEdCG61YInymkl
Date:   Wed, 25 Apr 2018 02:00:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 25/41] builtin/receive-pack: avoid hard-coded constants
 for push certs
Message-ID: <20180425020013.GF245996@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <20180423233951.276447-26-sandals@crustytoothpaste.net>
 <CAN0heSoU4wDAcfF_EGYSA4gjbpCgTyk0fGPsmPTwv65FfZCQcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GLp9dJVi+aaipsRk"
Content-Disposition: inline
In-Reply-To: <CAN0heSoU4wDAcfF_EGYSA4gjbpCgTyk0fGPsmPTwv65FfZCQcg@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-trunk-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GLp9dJVi+aaipsRk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 11:58:17AM +0200, Martin =C3=85gren wrote:
> On 24 April 2018 at 01:39, brian m. carlson
> > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> > index c4272fbc96..5f35596c14 100644
> > --- a/builtin/receive-pack.c
> > +++ b/builtin/receive-pack.c
> > @@ -454,21 +454,21 @@ static void hmac_sha1(unsigned char *out,
> >         /* RFC 2104 2. (6) & (7) */
> >         git_SHA1_Init(&ctx);
> >         git_SHA1_Update(&ctx, k_opad, sizeof(k_opad));
> > -       git_SHA1_Update(&ctx, out, 20);
> > +       git_SHA1_Update(&ctx, out, GIT_SHA1_RAWSZ);
> >         git_SHA1_Final(out, &ctx);
> >  }
>=20
> Since we do HMAC with SHA-1, we use the functions `git_SHA1_foo()`. Ok.
> But then why not just use "20"? Isn't GIT_SHA1_RAWSZ coupled to the
> whole hash transition thing? This use of "20" is not, IMHO, the "length
> in bytes [...] of an object name" (quoting cache.h).

Originally, GIT_SHA1_RAWSZ was a good stand-in for the hard-coded uses
of 20 (and GIT_SHA1_HEXSZ for 40) for object IDs.  Recently, we've
started moving toward using the_hash_algo for the object ID-specific
hash values, so I've started using those constants only to identify
SHA-1 specific items.

In this case, using the constant makes it more obvious that what we're
passing is indeed an SHA-1 hash.  It also makes it easier to find all
the remaining instances of "20" in the codebase and analyze them
accordingly.

I agree that this isn't an object name strictly, but it's essentially
equivalent.  If you feel strongly, I can leave this the way it is.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--GLp9dJVi+aaipsRk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrf4SwACgkQv1NdgR9S
9oulzQ/+MJdDP0oTjOfLTiMlNH1FLJBOD8YwaF44gQ3Y5MzVuqACFqCeMM9HG1Gc
NMvSTs2DChBh1gC2zKOUSKzPf7trT0nNQ1KT4Jt1Xc13Wkq886ig90f2NZADTfeN
tKpGrDca8ZBIFwY8nS4JM+0ghK1lk8DX15Nm4GI/gnTV8HiDxE9SY37EZwy36fEj
cB1nymkWXfi4U3HDlSbNkhyc6N7RwQdJAcpA5uwJrpMcWZ7ovECGUpDQxi/RcXHN
LYFcWKsPlxtC1cDZ/TJ47sbp5YuXCIRLzlh1Qa2r2/Y7aIoTy5ZEtXMOClWd3f+z
n6PCjS0D+gAYJtvL9WWHeEkDZmYbfyS6NGxLRVYcl/CF/E3RpphwaJKUt8mVvfy5
qvkzIcfohlTdo3kF23bgkhT4n1UsCSwuqzVT/pQZy260ESthkThWcSzfwNEo7D0G
rB6NAFkqy/qFA1DCl4r17ylQ9/FhcF9lvNtazwlB8gUUV8tjHxpV9clLZt7hJGYW
o9ssd8oVkreNoBxC3vfgyk8r9MIStuD3mwz/5x0fBC+jx4YdR9Gm6TscSLU5aMt/
vlW7EwUewXoRN8xOMJ5VesW1mkJUuwiRKcxSJ41Hcs0U0zasrXN30A/+fxGT9s76
DCb0kD8aYTa4mu0lMcpXSVnDiVGJF/dvDmFVN5kszkQoxZ5ELdA=
=vchv
-----END PGP SIGNATURE-----

--GLp9dJVi+aaipsRk--
