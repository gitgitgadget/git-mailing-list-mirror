Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DEE0211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 23:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733287AbeL0Xpo (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 18:45:44 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58042 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727601AbeL0Xpn (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Dec 2018 18:45:43 -0500
Received: from genre.crustytoothpaste.net (S0106ac1f6b61f856.vc.shawcable.net [50.64.113.123])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 31C3D60736;
        Thu, 27 Dec 2018 23:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1545954341;
        bh=2TrmGcxeNy2myNbZFZnvkc03vgeNI2pHOGijom1x9xk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zxSK1cSAo++ToZaR2I2Iv5M1p7ziKI+Xjvv6n1MiMqJOKZ6d8m9gSd6U5Jus7k7hA
         lRVHPSlFn8sY2TswfO29CvzzvgH/jFsKqe4zNwKaQIunPL7737nFpmLU+8G6CFQ4Md
         RBOnXkSKGoCrgtaumiu1XY+twtomg/On9wLhRelQ4WNDGdWcCD7H9zQJkwZAtXU1Wv
         /LxjLTZKcQZdIo8KY/PCcHfq3uNP/kMvkQkaiuQamrIyedYLv4EPDW1CtFwNrfyb2Z
         AKaGzImKgEOwsDOLTnJnskTS2Ae0h9iTXtL3ak+R0CWuzOMM9mWl6IJGhtra+LbS5i
         OMFr4tgR3KJBtr85wbW0+RmhxtW9Wo4VbPAQYRweEMubWRX6AXL32T/ZOl543vaqnt
         0b/g6kHs8ngwRB5cIuUc/fMDaKTQVQabNAoWGTTFy923/5q/nFyZPwRABRK/+VQwmd
         GXoeipSkap4kQk5zTcCd6G7fx5qhGq0kixnY8yq3LNsAOOBZg33
Date:   Thu, 27 Dec 2018 23:45:35 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 0/2] Improve documentation on UTF-16
Message-ID: <20181227234535.GD423984@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Lars Schneider <larsxschneider@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
References: <20181227021734.528629-1-sandals@crustytoothpaste.net>
 <93f0a854-9b8d-500c-b015-59c50ecdb0f3@kdbg.org>
 <20181227164353.GC423984@genre.crustytoothpaste.net>
 <435b6870-379c-7183-da99-35aec5cf1137@kdbg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
Content-Disposition: inline
In-Reply-To: <435b6870-379c-7183-da99-35aec5cf1137@kdbg.org>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 27, 2018 at 08:55:27PM +0100, Johannes Sixt wrote:
> Am 27.12.18 um 17:43 schrieb brian m. carlson:
> > You've got part of this. For UTF-16LE and UTF-16BE, a U+FEFF is part of
> > the text, as would a second one be if we had two at the beginning of a
> > UTF-16 or UTF-8 sequence. If someone produces UTF-16LE and places a
> > U+FEFF at the beginning of it, when we encode to UTF-8, we emit only one
> > U+FEFF, which has the wrong semantics.
> >=20
> > To be correct here and accept a U+FEFF, we'd need to check for a U+FEFF
> > at the beginning of a UTF-16LE or UTF-16BE sequence and ensure we encode
> > an extra U+FEFF at the beginning of the UTF-8 data (one for BOM and one
> > for the text) and then strip it off when we decode. That's kind of ugly,
> > and since iconv doesn't do that itself, we'd have to.
>=20
> But why do you add another U+FEFF on the way to UTF-8? There is one in the
> incoming UTF-16 data, and only *that* one must be converted. If there is =
no
> U+FEFF in the UTF-16 data, the should not be one in UTF-8, either.
> Puzzled...

So for UTF-16, there must be a BOM. For UTF-16LE and UTF-16BE, there
must not be a BOM. So if we do this:

  $ printf '\xfe\xff\x00\x0a' | iconv -f UTF-16BE -t UTF-16 | xxd -g1
  00000000: ff fe ff fe 0a 00                                ......

That U+FEFF we have in the input is part of the text as a ZWNBSP; it is
not a BOM. We end up with two U+FEFF values. The first is the BOM that's
required as part of UTF-16. The second is semantically part of the text
and has the semantics of a zero-width non-breaking space.

In UTF-8, if the sequence starts with U+FEFF, it has the semantics of a
BOM just like in UTF-16 (except that it's optional): it's not part of
the text, and should be stripped off. So when we receive a UTF-16LE or
UTF-16BE sequence and it contains a U+FEFF (which is part of the text),
we need to insert a BOM in front of the sequence that's part of the text
to keep the semantics.

Essentially, we have this situation:

Text (in memory):  U+FEFF U+000A
Semantics of text: ZWNBSP NL
UTF-16BE:          FE FF  00 0A
Semantics:         ZWNBSP NL
UTF-16:            FE FF FE FF  00 0A
Semantics:         BOM   ZWNBSP NL
UTF-8:             EF BB BF EF BB BF 0A
Semantics:         BOM      ZWNBSP   NL

If you don't have a U+FEFF, then things can be simpler:

Text (in memory):  U+0041 U+0042 U+0043
Semantics of text: A      B      C
UTF-16BE:          00 41 00 42 00 43
Semantics:         A     B     C
UTF-16:            FE FF 00 41 00 42 00 43
Semantics:         BOM   A     B     C
UTF-8:             41 42 43
Semantics:         A  B  C
UTF-8 (optional):  EF BB BF 41 42 43
Semantics:         BOM      A  B  C

(I have picked big-endian UTF-16 here, but little-endian is fine, too;
this is just easier for me to type.)

This is all a huge edge case involving correctly serializing code
points. By rejecting U=3DFEFF in UTF-16BE and UTF-16LE, we don't have to
deal with any of it.

As mentioned, I think patching Git for Windows's iconv is the smallest,
most achievable solution to this, because it means we don't have to
handle any of this edge case ourselves. Windows and WSL users can both
write "UTF-16" and get a BOM and little-endian behavior, while we can
delegate all the rest of the encoding stuff to libiconv.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwlZB4ACgkQv1NdgR9S
9ouwsw/8DtkqRUOhNHVHQjmUi6k9tEftWILmJiDjajIX9NvQWVpk5Shv0yxk7slk
ardqxcCkyewaa2OeWlM1Fg+B1GhgNQDIAUz4FLX/PDVG/kwEMFmTR4Mp8u6fqcJz
dHts+o9um8aZ+jaTpDuj6SlyxVgkJ/7mWyaYB1VdTYjYlYNUvJZ5wWBz3AU1ZozJ
c4mJQOzOr/5qacdoX4SDSUwFvgocfz1ZDn7jjF9FxniB7Bkk4sXXLAhqWpqEs7N6
dMKFH6YUfaRccblDQmqZQPbamSkyWNUhJFX9Savv6nBYem/wvowKnkdAOMGIqlwY
JIDRemce/1i2koRFrAGjV0hHq5FybKVdyLfnKpFPZ9OAqt96hzPSzjqebkE1/HCi
BnwssdStnfKKM8TzeV4xxxM1H5LaLXHOajemSWwex1EAtRtfxkhz/5uxhGB5kWLL
mFEOEpqn8/fKq07Y6i2W9S1bdj5kwSnAARiuZZBGDpb7P/G8N4djtep0evLz9ugF
yc5BgoiGN7V8nPheHqdMetQm9+LzmGZJkjw2FhriB7Uko+7cB6aR+iB9aq0KCoq1
G16jko4s0Q1RoUImyhDY2OVeQG+8Snd+byVOyjkgxuyQ2z222FugMKXBnXnjJK2O
E8oxWkS175dMTSya86by71uxAo+SE7KSQoRziWXUUyfX5ygkxmw=
=L0ww
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--
