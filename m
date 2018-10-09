Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52EFF1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 23:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbeJJGT7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 02:19:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49690 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726479AbeJJGT6 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Oct 2018 02:19:58 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EE9966077F;
        Tue,  9 Oct 2018 23:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539126043;
        bh=ls3c16+NWibAbksgMgKSUtv9BH8ecbDjlPuQESxPqUI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=da5pZIttP6fatLYO6Cfxp2ANMMeWHwpgs6C5ywaij1DrowiFm7Zt3OMoYDP+ROWWH
         IcAfIpG7QZnhTIE51L/+wPKFRfZPQoauBDSYpTv/r8kur42Zl81zKAzkQ+h5vvRl6S
         Ono1mh7HxwvPhbOgBWN0pKHWQ/8qDTzuQ7eYBgY/E5DhGLBsXV8zqjRcg2bHULeYYS
         fN7hQ/eAJzmCw5jXyfUxUDTV65DqHfGfZqsZqbZc913hLdl50J1sZaZjWT9UME0g8e
         kQmDgcYLdFCytu6t2OSUxDjf0Sfor5sq9kNEnLoj4h5SGM1Gu15sMzndo4Z03+2CL2
         zAfSQAkKlfNJjAZhbyhR4Gg5T4+AFB0q8ommB9MrQanNSGXcQqLDST+eSsxTuoa9/U
         Wa4SIzDVFGq6dc+5g813+JyqQUJTTRlhulaRuXzpAwVrjxeWSWOUT6GwcGJKGCbB6Z
         FWdZdY47i+X3WkCTnGtCNr2zvYGDPQVkn/Mz2HwfVwrLjX5o29N
Date:   Tue, 9 Oct 2018 23:00:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 02/14] builtin/repack: replace hard-coded constant
Message-ID: <20181009230038.GU432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
References: <20181008215701.779099-1-sandals@crustytoothpaste.net>
 <20181008215701.779099-3-sandals@crustytoothpaste.net>
 <CAGZ79kYvW2PFdLfvd3W_t6rPs=oMBDxgMEgDRLtC4MHyo6MXVQ@mail.gmail.com>
 <CAPig+cS5VdYq1ZOrP9oPwpXZ3ZmSV3_QdQAHiz5fV1Tc1uEF9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zMXjX+MeVRpM4hLZ"
Content-Disposition: inline
In-Reply-To: <CAPig+cS5VdYq1ZOrP9oPwpXZ3ZmSV3_QdQAHiz5fV1Tc1uEF9A@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zMXjX+MeVRpM4hLZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 07:01:27PM -0400, Eric Sunshine wrote:
> On Mon, Oct 8, 2018 at 6:27 PM Stefan Beller <sbeller@google.com> wrote:
> > On Mon, Oct 8, 2018 at 2:57 PM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > > -               if (line.len !=3D 40)
> > > -                       die("repack: Expecting 40 character sha1 line=
s only from pack-objects.");
> > > +               if (line.len !=3D the_hash_algo->hexsz)
> > > +                       die("repack: Expecting full hex object ID lin=
es only from pack-objects.");
> >
> > This is untranslated as it is plumbing? If so, maybe
> >
> >     if (is_sha1(the_hash_algo)
> >         die("repack: Expecting 40 character sh...
> >     else
> >         die(repack: Expecting full hex object ID in %s, of length %d",
> >             the_hash_algo->name,
> >             the_hash_algo->hexsz);
>=20
> Special-casing for SHA-1 seems overkill for an error message. A script
> expecting this particular error condition and this particular error
> message would be fragile indeed.

Yeah, I don't think a special case is needed here.  Moreover, since we
just invoked pack-objects ourselves and are now reading the output of
it, seeing this error message means that someone has broken Git in a
significant way.  The end user should never see this message.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--zMXjX+MeVRpM4hLZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlu9MxYACgkQv1NdgR9S
9otmxQ/6A2zMTQLbCRtOT6yI+JVpbVie84uN7gqA1htvjyodZOaesO3W1iUCD2Hu
yuhTDJD/B2Q0F5+9gvIxNJ5JtRVBZAsAAPg1IEhuypWPxmUoxaEjnaDTSqhhOXVU
ajG0pESsxwfMeLZqSnKUrBlfypb5wAHcPxSBf8vAtWoc6nWz4+vWMfPrb1h/5GU5
KoHTNTgyuHyB5Y+H/7M4RspeJUyx/DAwSzpRWqzIhfciutN3tCixLgcgriqz9FHn
YNC9t7rHYecUSDRm9hpIWg0PPpEZ0LSzj+nROzJ0jILbKHBBtDHqLBXGmhttjTyh
UKBWcn4EC+M6skcUz7Y+2LE1nnK1oiBf5C97k1Sq6PHdZ1/kzNLNpQoQnBL+FInl
QUDVTZinL6vL52sCjRv9Y5A1dh7voIhgbn4gfyNRw1h+AHzHx3y01C8Md0x2gqCc
pbxBD5s+hOjnqZIR4DVk2O/1Zc8tGWIGWpdaDvhi7dY4mO1zGEUUzVG2qupYQz3s
gOC/PQOUMrkBFALcQkiOMWvJU5uhfoot1T7hFFtZ3FVkHh4yfZoDfz0RNyVSSH/8
AL9xELMGuSEIXrVGAe1ljMZxEdXG3cuAGGMLWm6k3HyHRS1DbMkeyKVahef7qJt1
PrCXYBGF8eIot5GGPgMuW1GrBZ+y05AEe4KY5+DQZH2d9ODd8dM=
=hyj1
-----END PGP SIGNATURE-----

--zMXjX+MeVRpM4hLZ--
