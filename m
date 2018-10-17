Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 235271F453
	for <e@80x24.org>; Wed, 17 Oct 2018 22:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeJRGvG (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 02:51:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51284 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726412AbeJRGvF (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Oct 2018 02:51:05 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 179F761B72;
        Wed, 17 Oct 2018 22:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539816791;
        bh=F7STugXhLnXaLZ0sTcgYQeRXiaPtvHD98fdlddbNpPk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=YYoRj5j7QIE8WAv3Me4+/PSb48K4JNeUdHbcF5vi+sM3vH8NNf9kS16ca1n+1U/Wx
         OXddLO/wsZkMvbOfCGpDIVnLlrCBFczMc3zJQY8xLV0ROnKf5mbn/MUiHuMfO7cp3W
         38CCK3G7glI5GpBa6W4de+N9Ab5Lj60D/B5CyZHktBSu01/0+aUCJSb3B40q0UUjkZ
         rnO+M66IgoI1P6mkoN113Y4i61lnnO9Mz4Yhi64hAe+pI3KygZIoBgOJNNiXjMbPtl
         17iYJXMTFIxO9LV8gzPpJn14eRnmm+ueDPzVAEleefj/KcEydQjKtMwo6tmQ6MlwRI
         NlsiuVJa31CZgFsAi1XkP22GeSs+ytnGJ5uro17Js9ijVYfOoxYkDvj5rFMcy4gbQl
         iI6Fi4DjgAXA1AVsXbKJLLSR2jjhVbnkqQOKGkapDMK8+6iii3CChrvABMKTo1wCtK
         jVCNDxdXltPq3v5B2rCYVEKFegxBksUhF87m+PdaXGB5DegHhjf
Date:   Wed, 17 Oct 2018 22:53:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 01/13] sha1-file: rename algorithm to "sha1"
Message-ID: <20181017225306.GJ432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
 <20181015021900.1030041-2-sandals@crustytoothpaste.net>
 <CACsJy8DPBkRyPYF7Vfh0bQHJDvDZcmp54wjzRxG4Ho40SkMTSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u5h+kxyd0mPeN+64"
Content-Disposition: inline
In-Reply-To: <CACsJy8DPBkRyPYF7Vfh0bQHJDvDZcmp54wjzRxG4Ho40SkMTSg@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--u5h+kxyd0mPeN+64
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 05:17:53PM +0200, Duy Nguyen wrote:
> On Mon, Oct 15, 2018 at 4:21 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > The transition plan anticipates us using a syntax such as "^{sha1}" for
> > disambiguation.  Since this is a syntax some people will be typing a
> > lot, it makes sense to provide a short, easy-to-type syntax.  Omitting
> > the dash doesn't create any ambiguity, but it does make it shorter and
>=20
> "but" or "and"? I think both clauses are on the same side ... or did
> you mean omitting the dash does create ambiguity?

I think "but" is correct here.  This is a standard "This doesn't make it
worse, but it does make it better" phrase.  The "but" creates a contrast
between what it doesn't do and what it does.

I'm trying to come up with a different way to say this that may be
easier to understand, but I'm failing to do so in a natural-sounding
way.  Does the following sound better?

  Omitting the dash doesn't introduce any ambiguity; however, it does
  make the text shorter and easier to type, especially for touch
  typists.

> > easier to type, especially for touch typists.  In addition, the
> > transition plan already uses "sha1" in this context.
> >
> > Rename the name of SHA-1 implementation to "sha1".
> >
> > Note that this change creates no backwards compatibility concerns, since
> > we haven't yet used this field in any serialized data formats.
>=20
> But we're not going to use this _string_ in any data format either
> because we'll stick to format_id field anyway, right?

We'll use it in extensions.objectFormat and other config files.  But in
anything binary, we'll use format_id.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--u5h+kxyd0mPeN+64
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvHvVIACgkQv1NdgR9S
9oujMRAAjGAXjPnQkjtlQhB+o/++UulsULV4R2/dEhJVQvjp0nQxYYRIRdGzm7AJ
A1a3riEZVa3Tlqb0NgH8xyAV3AVnh9iRd3hjXkq6Ve+y1/8cR0Nlh0MF6XV7Js35
xrvtfEIPAAxHaXsVEwTjcBZlLKe0iSF7rVkSzHU4pNrME/qtRZ3tT1JYBOTK57nQ
a4yFBApfFPyoH8fdxV0ZZqDp7eHyCY9FWsmWK/DpJOmVvEkMCLxL+UN+WjhRKtJL
UMnFk5iFIO+frBRLxuF7BwpaB8nkP+41g/S/QxM7QvMA8KlMC2tU4pMus3Kn5A1b
9fffbo/DjUW4uC+2b0wvzfgxVJDLLUvfuThPjecMLVbBMzjIwt9rLvEuvK1NfUXT
12o+H6NAvzv8gbx9UWb3p1JcKTiaCsJM+gFLIjDZnqCDk4qq2CcQS0v8g9mqvRMM
EiSljCgUCVkLHjsZfnpa4LwAHek/ZrclTXWSI0fLo3bB4VuCr+/PNvkyrDUR0CYT
dYhcuPrkhR3TVprguDHaOp1yTxfgOW7W/xWHeCBP3lIiwiSqBWvFDf+1H+pz1PjL
fihzNYV1s6m9q1MvmEEBYmZKIUNxNQKVuPs2R9HKa6qmK5NG+/2rvoZAnZi4LTr4
tF6It0l0NL9HWiyb5NgUiWqOWrx1ZZ6W39/BntwVfHnkVQ7L0hc=
=zw6L
-----END PGP SIGNATURE-----

--u5h+kxyd0mPeN+64--
