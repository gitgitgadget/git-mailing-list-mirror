Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 798211F403
	for <e@80x24.org>; Thu, 14 Jun 2018 00:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935843AbeFNAWN (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 20:22:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38862 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935725AbeFNAWM (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Jun 2018 20:22:12 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b0c3:20dd:704c:b59d])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C2EDF60129;
        Thu, 14 Jun 2018 00:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528935731;
        bh=nuQnapyaFhL34ySPdVvd+9XgcgzlKpjJuQTJQNsHlzU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=PjYhlnShssG4YEf20orYTWltm+oYj7mPyb1rKEsI8i5S8lKXmVu3B3LHLfvPY5LLM
         tMPP5dmhwfQtAdwIAYiiU+n9m5SwdMkvs/I8eO11iDQoieHZSH/MnsaXkPJwZR1hzp
         NktOPylVKAyJNBtZiaMu7g4nJMGhhAEZXVbspSDgZybgfHM50x421NAoLnPnYcfhBK
         Pb0c/H/o7+e6eusWFbXKboD+vQFTVbUg+CzBL5Y9z1FM/76O5m/cyDP02P0gInHFcQ
         720E3yFSsInCldTa6nvAbT1ULQdiypFNjtz0B0whsJroUSnDkQg0YnjLduECNdT4LA
         obp2FJoONmyk1WntOFfszaqhDJ3PfuHy/HEbMV6lAzsI0o3a06on7STRo8YAepq+WQ
         CeAUvsZibGj7D9H5I+2+BwEDIaE26U3px8N6ps+fTrkg0nbc2b92VLW7uCv7vYNGXH
         WWj27XCHacdFJ/w6nmzLA/WjoJ6vGmU0B08NFjMNUe/LrtlxJB3
Date:   Thu, 14 Jun 2018 00:22:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 01/10] t: add tool to translate hash-related values
Message-ID: <20180614002205.GN38834@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
References: <20180604235229.279814-1-sandals@crustytoothpaste.net>
 <20180604235229.279814-2-sandals@crustytoothpaste.net>
 <20180611074743.GA24066@flurp.local>
 <20180612010513.GH38834@genre.crustytoothpaste.net>
 <CAPig+cSEpCTg+rYQYNQ5wUz3PL+51dr7bQdn-2cOWgg2ScdXNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0u4QAjBqqw4+MLTw"
Content-Disposition: inline
In-Reply-To: <CAPig+cSEpCTg+rYQYNQ5wUz3PL+51dr7bQdn-2cOWgg2ScdXNA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-2-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0u4QAjBqqw4+MLTw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2018 at 03:29:47AM -0400, Eric Sunshine wrote:
> On Mon, Jun 11, 2018 at 9:05 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > test_oid would be fine.  One note is that this doesn't always produce
> > OIDs; sometimes it will produce other values, but as long as you don't
> > think that's too confusing, I'm fine with it.
>=20
> It was surprising to see it used for non-OID's (such as hash
> characteristics), but not hard to deal with.
>=20
> One could also view this as a generic key/value cache (not specific to
> OID's) with overriding super-key (the hash algorithm, in this case),
> which would allow for more generic name than test_oid(), but we don't
> have to go there presently.

It is essentially that.  I'm happy with the test_oid name provided
others are.  My only concern is that it would be confusing.

I opted to use the same mechanism for hash characteristics because it
seemed better than creating a lot of one-off functions that might have
duplicative implementations.  But I'm open to arguments that having
test_oid_rawsz, test_oid_hexsz, etc. is better.

> > I agree perl would be expensive if it were invoked frequently, but
> > excepting SHA1-prerequisite tests, this function is invoked 32 times in
> > the entire testsuite.
> >
> > One of the reasons I chose perl was because we have a variety of cases
> > where we'll need spaces in values, and those tend to be complex in
> > shell.
>=20
> Can you give examples of cases in which values will contain spaces? It
> wasn't obvious from this patch series that such a need would arise.
>=20
> Are these values totally free-form? If not, some character (such as
> "_", "-", ".", etc.) could act as a stand-in for space. That shouldn't
> be too hard to handle.

t6030, which tests the bisect porcelain, is sensitive to the hash
algorithm because hash values are used as a secondary sort for the
closest commit.  Without totally gutting the test and redoing it, some
solution to produce something resembling a sane commit message would be
helpful.  We will also have cases where we need to provide strings to
printf(1), such as in some of the pack tests.

I have a minor modification to your code which handles that at the cost
of restricting us to one hash-key-value tuple on a line, which I think
is an acceptable tradeoff.

> > Using shell variables like this does have the downside that we're
> > restricted to only characters allowed in shell variables.  That was
> > something I was trying to avoid, but it certainly isn't fatal.
>=20
> Is that just a general concern or do you have specific "weird" keys in mi=
nd?

I had originally thought of providing only the SHA-1 value instead of a
named key, which would have necessitated allowing arbitrary inputs, but
I ultimately decided that named keys were better.  I also tend to prefer
dashes in inputs over underscores, since it's a bit easier to type, but
that's really a secondary concern.

I think the benefits of an implementation closer to your outweigh the
downsides.

> My original version of test_oid_cache() actually allowed for that by
> caching _all_ information from the tables rather than only values
> corresponding to $test_hash_algo. It looked like this:
>=20
> --- >8 ---
> test_oid_cache () {
>     while read tag rest
>     do
>         case $tag in \#*) continue ;; esac
>=20
>         for x in $rest
>         do
>             eval "test_oid_${tag}_${x%:*}=3D${x#*:}"
>         done
>     done
> }
> --- >8 ---
>=20
> The hash algorithm is incorporated into the cache variable name like
> this: "test_oid_hexsz_sha256"

Yeah, I basically reimplemented something similar to that based off your
code.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--0u4QAjBqqw4+MLTw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlshtS0ACgkQv1NdgR9S
9os8Dg//f0WEJUy+OFTNa0Lnjv4D+qaBCiHf4AswWEnxeAR5JaPL1tGKYsF1pnNr
YJM/+l4QVLBQ2rem9MfUG8qn6W1HzgKmd+/MPXUsvHtjWaTkhLNegtB346QBZtvy
NkXJeuznUi5yj2r56tQpSMFONgkkRkp6SU5hNHwU6uonIvsRRcvJu4h+n2MlJ+n6
nNp3vJDDy/PwVRUHxFlIwqRHefzeyqrNp1+sLS9GCva2yH4ZDR/9gdNV1k6DRFff
GOO7K9X5KV1XWIkqM8YDcOVIXEFM2Wls1CWHjob6NA7jsPKwIZsLXq3FPx40hmxV
H6IDyCo0vSFE3cghg/LdfBFClKDzNe+TOjoZ0Mtn/CdqevIOImfURRT5Y+qPu4la
qnxl2pBAU36zEEegLcvWy1eZ/JD2HHWFobgA1Bai+nYbBQUX/n5hX9vhWhwlLElU
evh50tyxg+MeNGw6qrJJR3RakGmHmRfE3txXtymPCuNRkuJynyz/Y7XUd4zM1447
+IhkC6LlW6HmCBiNEDPOfTxShbPPcRsk9KH9xWSxt6IRShBCIJwWJij1muKVCusj
dp7EuYoYXVBVkSYoBD6g72MRLyqo1z5xTwqVloV2OkpiVl/kSUFyHr0gHxU1Zpiw
v/KwYBMw7l4VqdV4fmzym2nHGYVeTSAZmsEcKOpBWRI7bI8JNIY=
=K3sa
-----END PGP SIGNATURE-----

--0u4QAjBqqw4+MLTw--
