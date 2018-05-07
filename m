Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D79E0200B9
	for <e@80x24.org>; Mon,  7 May 2018 23:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752919AbeEGXG5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 19:06:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41952 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752755AbeEGXG4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 May 2018 19:06:56 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A693760444;
        Mon,  7 May 2018 23:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525734415;
        bh=MsEwBlo7FPgCGc0AKdZ8Kg9n5KychkzpSSRQhBN7jiY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zcLyfIg5EHWRm4+9H+Gfy4Bx84zDqFxPNlUweYdEbLGpECC0Oe680chZgj0ar033k
         +tK07Q+J+A33iGQ4cq2M1t22QtY2NESTeoHzPl1U+tfGlEN6Kv4Nl69D2cIpK00ryj
         JVB1jIsIEaIfqOs7Vg+BktPLsXTW+wYdyDR7lCNr0abLsPvQM4rA3OtFasaOBVO8qc
         AhYPRCRnzCj5kJCn69f8Ledt5obE+DGsVqx9pEIClag/Fo2duF7x9DVONOqPe+1QyL
         OJT6z2NjnfmQXQs2EgcHAXnQ35JdfAPsBaIOdBJImlTWwqTHIPzweuDd7t2ZhdmJcC
         S4FSuqLMg7aDBX68QiwGgLXL0wUVzaz3Px7xQTUITHzOKKwHfdfgqDgbqMczGAmgla
         +m7o5/4sBLHful6iKAgj4y8/MB1ErJcpIv8FFyKl1e6k2uiCOvBK6x9FhR226HxTmG
         I3uzA1vjXKYWVnVS2/DwValarTUZxslOSOM+0RMdE36ZM4lyjEE
Date:   Mon, 7 May 2018 23:06:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Ben Toews <btoews@github.com>
Subject: Re: [PATCH 8/8] gpg-interface: handle alternative signature types
Message-ID: <20180507230650.GH953644@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ben Toews <mastahyeti@gmail.com>, Git List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>, Ben Toews <btoews@github.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com>
 <20180409204129.43537-9-mastahyeti@gmail.com>
 <CAPig+cT3AobThgZ15iquyRQG0Qes1ZzQxycXcgHYuwQCuDEDBQ@mail.gmail.com>
 <20180414195954.GB14631@genre.crustytoothpaste.net>
 <xmqqbmejyc4j.fsf@gitster-ct.c.googlers.com>
 <20180417001212.GC14631@genre.crustytoothpaste.net>
 <20180507094459.GA3412@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7SrMUQONj8Rl9QNG"
Content-Disposition: inline
In-Reply-To: <20180507094459.GA3412@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7SrMUQONj8Rl9QNG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2018 at 05:45:00AM -0400, Jeff King wrote:
> Isn't that basically what this patch is, though? Or at least a step in
> that direction? For generic signing support, you need:
>=20
>   1. A way to tell Git to recognize that a signature exists, and what
>      type it is.
>=20
>   2. A way to tell Git how to invoke the signing tool.
>=20
> Let me discuss (2) first.  In your git-sign-* world, then (2) requires
> us to define a set interface to those helpers, including which action to
> perform, which key to use, etc. And then the logic is inside the helper
> to translate that to the tool's interface.
>=20
> The direction I anticipated for this patch was more like:
>=20
>  - for now, we just piggy-back on gpg's interface for interacting with
>    sub-programs. That makes gpgsm Just Work, and it means that you can
>    plug in any other tool by writing a wrapper which converts from gpg
>    options to the tool's interface. I.e., gpg's "-bsau" becomes the
>    lingua franca, rather than us inventing a new one.
>=20
>  - the config schema leaves room for adding new properties to each tool.
>    So eventually we could support other option microformats by adding
>    signingtool.foo.interface =3D "signify" or whatever.
>=20
>    That still leaves room if we want to design our own helper interface.
>    One thing we could do that this patch doesn't is require the user to
>    explicitly ask for "interface =3D gpg" (and set it by default for the
>    gpg tool stanza). And then leave it as an error if you have a tool
>    config that doesn't specify its interface type, which leaves room for
>    us later to make that default our generic interface.
>=20
> Getting back to (1), how do we tell Git to recognize a signature? I
> think we have to use config here, since it would not know to invoke a
> helper without recognizing the type (and we certainly do not want to
> speculatively invoke each helper saying "do you understand this?" for
> efficiency reasons).

I think my main objection to this series is that it is generic in a way
that isn't necessarily useful.  We know there are essentially only two
formats of PEM-style signatures: OpenPGP and CMS[0].  Even if there are
more, they aren't intrinsically useful, because our codebase can only
handle GnuPG-style tools, and those are the only formats GnuPG-style
tools really support (although, as you point out, other tools could
mimic the interface).

I think if we aren't going to implement some sort of interface that's
generically useful for all signing tools, it would be better to simply
say that we support gpg and gpgsm and have signingtool.gpg.program and
signingtool.gpgsm.program and hard-code the logic for those two formats.
That way we don't have a generic interface that's really only useful for
PEM-style tools, when we know it likely won't be useful for other tools
as well.  We can add a more generic interface when we have more varied
tools to support and we know more about what the requirements will be.

This doesn't address Junio's concern about whether adding CMS support is
the right direction to go.  I personally think OpenPGP is the right
direction for most open-source projects, but I know some companies want
to use CMS internally and I'm not intrinsically opposed to that[1].
That decision is ultimately up to Junio, though.

[0] I'm ignoring the original PEM, which specifies MD2 and MD5,
algorithms that nobody should be using these days.
[1] I would welcome, though, if one could configure only one type of
signature verification by, say, setting the signing program to
/bin/false in the config.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--7SrMUQONj8Rl9QNG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrw3AoACgkQv1NdgR9S
9ovDAxAAkqNFMnsIi7ZdWE+t0suf+ieoXso4hxUK1EWCygyOmNX8NMhQSNsdbXKO
EdmfYyrTcYBfD8Vljoh5tGt2sOhF0hS32RdnFwszND24xfLZ3slt0mwi+8gU4eF7
RgPqngiQLEUR2OFMRRr3Q1gmj1CUIQWKLYJJlEhC+XBTJ+XYfyV0hs31DDHN79sM
6tt0U+tBZlQkiBCMF3LickOF1L0WP348INXJwae9PakGUS3hIhsBkTVNqaVfIDsW
NHP7JMD9naGLeRWavA5hQeBvmxw83LX6+ldXDz2J8rZ3oN1NXehvtdvkzKRrpYpQ
FQHpLyzw/PHtBvHOT+slqM3pQRF8d/VcrC7hx0w3swUB5N49NMBoqosDiKN5hi/8
QRZzeD+gk9yJ2St28/UNaLkFLfjVsWw+cJh3zL1dRaQmJf5InDETfkR2R10NYDJD
J96T9xkDdkoGzeaR7k5ChSFSJQjjzZH4hypCI6vlVa0fe3g1J8w/acVTw01PYGWs
8oYfeEgN98ZygDG91Bdcb1dBH3Cuc87REqqirGBCl7WbPgH3pXEfu4FGVr5re/h6
sHf0dT/9QkTEDVjChxxO/OKBn0i+/KNRkxGkoaIZeak/0AQrEWYKAGf30Pwiakw+
sHs9xGYzIj9AkLqhyaii4T6gDpo57Kpfs1R1hY/9CO/klPfKdPE=
=2Xz8
-----END PGP SIGNATURE-----

--7SrMUQONj8Rl9QNG--
