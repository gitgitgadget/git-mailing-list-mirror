Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B80C91F461
	for <e@80x24.org>; Tue, 20 Aug 2019 03:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfHTDFw (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 23:05:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58136 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728647AbfHTDFw (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Aug 2019 23:05:52 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F0E4F60425;
        Tue, 20 Aug 2019 03:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566270349;
        bh=ZuMOQEkKHART1xRxQyiAgM7Q5jA8/BLoUSmjIxpp6jY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0zSI91O/MutpnYwErrhxui2g5v0KcjgKO3g4FuubiPIFIW18dWtW0jQmE09gGRUUS
         Bf13epHRYl4ifv1nato+p5BZFTC1ZDA+UFlsxN+s2z11GlAPnWDzMk6Sumk/s7OiZO
         z891REGKxJN/e3KuXe0sm8mPCBixyESTTyRZA842Cy3ODdN1cUohZBpPBsdT1Tjbzi
         WeDQgdUVQpEsX1qBadxC8nuk3dNwzufGh5KN1ePlNWIYhFodZqzmzjgihtIO1Vtq6V
         msRC0I2hs+f7ZQD2DGjDPFsxLoyi/dPFN8s3mu8PKYJA+uqtJ8YdEAV1J90yV4WFXK
         npHQovLYHmY7d6biGl7zaFsA6ALPW87ocHcE6jDhyxxpI5yP5dJ8Zt5xQL6AxJfiPo
         0y3LICdjlBcsT+171jhj4ZIoOuBVUi3q3mX8dJApZmdzysavC75flYuZeQoxDFm7lE
         9RJA+WiMUsUkZJ/DtnpaB5jLsiUF/3PBykRYC5cHuHfUW7vxJGe
Date:   Tue, 20 Aug 2019 03:05:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] apply: reload .gitattributes after patching it
Message-ID: <20190820030544.GI365197@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190818184403.861907-1-sandals@crustytoothpaste.net>
 <20190818184403.861907-3-sandals@crustytoothpaste.net>
 <9b940950-666a-0c4c-58c0-1e61ac9e654c@gmail.com>
 <2c33a668-4c7d-2114-41b1-8907c4384a15@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9aCKuHbn5v2q3RVc"
Content-Disposition: inline
In-Reply-To: <2c33a668-4c7d-2114-41b1-8907c4384a15@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 5.2.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9aCKuHbn5v2q3RVc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-19 at 09:55:27, Phillip Wood wrote:
> On 19/08/2019 10:41, Phillip Wood wrote:
> > [...]
> > > diff --git a/convert.c b/convert.c
> > > index 94ff837649..030e9b81b9 100644
> > > --- a/convert.c
> > > +++ b/convert.c
> > > @@ -1293,10 +1293,11 @@ struct conv_attrs {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *working_tree_encoding; /* =
Supported encoding or
> > > default encoding if NULL */
> > > =C2=A0 };
> > > +static struct attr_check *check;
> >=20
> > I was concerned about the impact adding a file global if we ever want to
> > multi-thread this for submodules, but looking through the file there are
> > a couple of others already so this isn't creating a new problem.
>=20
> Doh, I've just realized it was static already - ignore that.

And I just realized that I didn't read the entire thread before
responding.  Sorry about that.

> One thing did occur to me though - does this patch reset attributes like =
the
> merge marker length (they're less critical though if there is a conflict
> after an attribute change it would be nice to have the correct length) or
> just the ones for filtering files?

It resets "crlf", "ident", "filter", "eol", "text", and
"working-tree-encoding".  Things it doesn't reset include "whitespace",
"export-ignore", "export-subst", "merge", and "conflict-marker-size".
Of these, I think only the latter two are relevant.

I'll update that in v5.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--9aCKuHbn5v2q3RVc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1bY4gACgkQv1NdgR9S
9ovH+RAAnuGFMEbM7veXOTlm3sqbhWdS84hIeKdvm9IKEX7MAFAP9bBUI+e6n2Ve
+pJEaPmwgnUnFsnYkcCDCw2o1Z/g8xyyrxNZW9c1grm+Kqb6vxx3F6esWO19bJEB
h7xmdFCo0c5xW2x428+APznknic6Z2yGrIwxh0CzJNsvShq3ifv7SKOtBasCrBUS
deGAnvtLOfe4dR3c7DNQx51/sNzbb9HhRS2kh0iDKzdVfdp1O55zEG0nmaLHy4tg
H21nFCaIq2lDhemr4bkKJbYKnhR2OncmDywp8H/YTzvntfyFwh1JbDZ34dPx/rWi
s5yxlX2QBjaXJQOpilhmc22Ez1+GKxKagUQhba9G2n5JWlOyI0eIS8tpsp17Ix+j
7t/yY+lV/Svb1QKALO+SarHdZV0TIDOJFueIeDwdhhB3e5GvrHHF7e/SAaWHksX4
UzpJT3onbP+XwFZCLbWiP1wqLxEOzUeKRx1qIKERC8GlPP5bIpfhA3lvgpb2khWk
7IeSnEyfwVynAgZIp6Qkl7IuNP5K4/q9IS0F4LLUjqFPPujbD0tlEvckq/gzS0/O
nM6vPCAlWIuMxppZQ2m4pbmMe8Lm60F6uavfC1PwhMtKTCMfryFBrDQ+2ApGP6ry
k4VYTJKOp/S2JQc7k/CTzdb5eCynKc9kJQG6VSzaiWWqTQMjYs0=
=DbGQ
-----END PGP SIGNATURE-----

--9aCKuHbn5v2q3RVc--
