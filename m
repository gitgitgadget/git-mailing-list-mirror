Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FBFC433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 21:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2507460698
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 21:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbhDKViP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 17:38:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59430 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235320AbhDKViP (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Apr 2021 17:38:15 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D051860744;
        Sun, 11 Apr 2021 21:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618177048;
        bh=kzh5NgzTChKVBr3oEWk5NLehNFKo1OdhalfF3j+5xIY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=BnHT8MvLBkZYnPhZ7D2EnWs26o3vlVyI4jhb6r53l34Nvybg0lFFLz+O9KmFemxEv
         2JE11cTroBcFZLJMQeuTPDZnyflppiwXo7lgNu2uHkC4IEV3Awn9SzoPcPz2oKW8kr
         w7u3RirDoicLJsKIiqUy6uAL7n4KxCDvYvkVqR9VoIjilquH7muGF7RdmhYvFyDpil
         fSmtroToyY+SrKDE4XUIggdeXLQGTzl0D6yGzafx/3A4bP6/rAQdQP9XWp6JibWJIu
         miVNzpgm2k8VlVD0cR3ct0aK+rNH6E+h2RE2LSupIzeNnLvYevX7WC/EVziMcz4SgQ
         t8+pOytXK4MHWxoCQq5hib0WJFzQY8/A+ubq0pfuDhxzHc3oTTpHDUT/ZUtMP9QskH
         tqFhwwiOMUyjHHcF2N8lOxCVz/dNupct6/oYMnpZSzJfkM34gI5w/AHHUhEC6IEKB0
         DqheSdcRa8gPBiA7iilF9OQPpp/rsLORMaq8VuoY9J9HurFY0Kp
Date:   Sun, 11 Apr 2021 21:37:21 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 03/15] cache: add an algo member to struct object_id
Message-ID: <YHNsEVMs2lRmycOx@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
 <20210410152140.3525040-4-sandals@crustytoothpaste.net>
 <87mtu5f31u.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cgDqQtSE66olCjXX"
Content-Disposition: inline
In-Reply-To: <87mtu5f31u.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cgDqQtSE66olCjXX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-11 at 11:55:57, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Sat, Apr 10 2021, brian m. carlson wrote:
>=20
> > Now that we're working with multiple hash algorithms in the same repo,
> > it's best if we label each object ID with its algorithm so we can
> > determine how to format a given object ID. Add a member called algo to
> > struct object_id.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  hash.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hash.h b/hash.h
> > index 3fb0c3d400..dafdcb3335 100644
> > --- a/hash.h
> > +++ b/hash.h
> > @@ -181,6 +181,7 @@ static inline int hash_algo_by_ptr(const struct git=
_hash_algo *p)
> > =20
> >  struct object_id {
> >  	unsigned char hash[GIT_MAX_RAWSZ];
> > +	int algo;
>=20
> Curiosity since I'm not as familiar as you with the multi-hash support
> by far:
>=20
> So struct object_id is GIT_MAX_RAWSZ, not two types of structs for
> GIT_SHA1_RAWSZ and GIT_SHA256_RAWSZ. That pre-dates this series because
> we'd like to not deal with two types of objects everywhere for SHA-1 and
> SHA-256. Makes sense.
>=20
> Before this series we'd memcmp them up to their actual length, but the
> last GIT_MAX_RAWSZ-GIT_SHA1_RAWSZ would be uninitialized
>=20
> Now we pad them out, so the last 96 bits of every SHA1 are 0000...;
> Couldn't we also tell which hash an object is by memcmp-ing those last N
> bits and see if they're all zero'd?

That makes a lot of assumptions about the security of the hash
algorithm that I don't want to make here.  If anyone can ever find a
SHA-256 hash with trailing 96 bits zero, then they can confuse it with a
SHA-1 hash.  That means that our security level goes from 128 bits to 96
bits.  It's also a nonstandard construction.

More importantly, it results in the null OID being treated as a SHA-1
OID.  Because we do print the null OID in some cases, we're going to
break a lot of output formats if we print all the rest of the OIDs with
64 characters and then the null OID with 40.  That's to say nothing of
the problems in binary formats.

The reason we pad these objects is because our hashmaps are broken if we
don't.  I don't remember all the gory details, but it was obvious to me
that if they weren't consistently equal, things were going to be broken.
That's the only reason, not theoretical purity.

> Feels a bit hackish, and we'd need to reconsider that method if we'd
> ever support other same-length hashes.

My hope is that we don't need to do this, but we do have SHA-3 to serve
as a backup for SHA-2.  If quantum computers don't progress
substantially, SHA-3-256 is definitely a viable candidate for
replacement if anything ever happens to SHA-256.

> But OTOH having these objects all padded out in memory to the same
> length, but having to carry around a "what hash algo" is it yields the
> arguably weird hack of having a per-hash NULL_OID, which has never been
> an actual object of any hash type, but just a pseudo-object.

Unfortunately, as I mentioned above, we need to have two null OIDs to
handle printing things out.  It's inconvenient, I agree.

> I abandoned it as insany sillyness after playing with it for about a
> day, but it did reveal that much of the hash code now can assume
> internal length =3D=3D formatting length, which is why I'm 3 paragraphs i=
nto
> this digression, i.e. maybe some of the code structure also makes having
> a NULL_OID always be 256-bits when we want to format it as 160/256
> painful...

We'll always format based on the algorithm in the OID.  That's the
simplest way to make things work because unfortunately we may end up
with both types of OIDs in the same code paths (as we're converting one
to the other) and otherwise our printing functions need a lot of special
handling and even more variants than they have today.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--cgDqQtSE66olCjXX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHNsEAAKCRB8DEliiIei
gdIdAQD3wLiEhbv/38YSixQF0PvD6F6hFP1bhgOyjxEHbfwe3wEAwEmIoPzMkQff
xvuwWPLDqTiSPFnat9ddp9gFos+o+AE=
=nPJI
-----END PGP SIGNATURE-----

--cgDqQtSE66olCjXX--
