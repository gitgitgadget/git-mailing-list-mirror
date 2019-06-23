Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B5591F461
	for <e@80x24.org>; Sun, 23 Jun 2019 16:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfFWQ6o (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jun 2019 12:58:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56186 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726399AbfFWQ6n (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Jun 2019 12:58:43 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:d086:4612:2ae:a31e])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6EED360428;
        Sun, 23 Jun 2019 16:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1561309122;
        bh=rhDxQgUctgofnXpVB/I1QkZURHXOtt+YDDSujz4bfb0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=MjhFewlKK4s/0vo//8Y32fQu0Ik2z3nX6Qa6VAT4KwYDq7K0QlLBgT/3OpFNjpmvV
         28TSoi/c8OLHkrIMvjAUUSwk0b4TxbikGhyzAklhVZL/dgVPel1g4OTzMRVQ2QCqrP
         p3ZHJ2Z/CIlLJy/xQ7eUWmQCfpY+3+2ofEXnF12eMsVUzgDZxWgSToIjx4ZYyXPV03
         tGw/hbitGjXr1XegWq3XiMqZuEJelv2n+JNIBvViffEPO/x/YkSMDNsBOzZBpDNo/n
         I7089yfR6/IUrMdA5048AFd/LkYbCMt3PXtlsLJ5NdtsSFmW3q2Jz6BPXOBRroXLNM
         l2jwjlNSJZps9sXzrypgbQLHKQxg/XWqCmtl5Fnj6WABG3WacqDZTHHa18bWznazqh
         7Y74B70dukZaS08a2qFCzZusJKlrgTRYZwuMQvPq3q7eLO3/HgK0djUahVmc3AuNcS
         DJ14TJic5rrblDTzokrlZCKpMtDvAyerGyZQXBAMoZcW2BfXiNy
Date:   Sun, 23 Jun 2019 16:58:35 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Dimitriy <dimitriy.ryazantcev@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3] l10n: localizable upload progress messages
Message-ID: <20190623165835.GD965782@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Dimitriy <dimitriy.ryazantcev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20190622093655.80092-2-dimitriy.ryazantcev@gmail.com>
 <65cf1cfd-bb5f-dba0-17d6-7fee0ed1f51f@kdbg.org>
 <20190623010311.GC965782@genre.crustytoothpaste.net>
 <CAPUT4mSHK8bD-TGf9QOM2O2ChxTvwScCvmmQH37pedGDVR2w-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
Content-Disposition: inline
In-Reply-To: <CAPUT4mSHK8bD-TGf9QOM2O2ChxTvwScCvmmQH37pedGDVR2w-g@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--W5WqUoFLvi1M7tJE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-06-23 at 08:28:41, Dimitriy wrote:
> brian m. carlson <sandals@crustytoothpaste.net> wrote:
> > In my view, the translation is less important for the prefixes and more
> > important for the unit: at least French prefers the term "octet" over
> > "byte"[0], so instead of writing "MB", you'd write "Mo".
>=20
> Localization according to local rules is important for every unit part.
> There is a Russian adoption of IEC 80000-13:2008 called
> GOST R IEC 80000-13-2016[0].
> And in this document there is national translations for these units\prefi=
xes.
> So 'KiB' should become '=D0=9A=D0=B8=D0=91' according to this national st=
andard.
> Same story with Ukrainian adoption called DSTU IEC 80000-13:2016[1]:
> 'KiB' -> '=D0=9A=D1=96=D0=91'.
> Also according to ISO website seems that there is French version of
> IEC 80000-13:2008 exist. Not sure about French translation through.

I figured the impetus for this change was something like this.

> > In general, I think it's better to keep the prefixes and units together,
> > since trying to translate a single letter runs the risk of collisions
> > with other places in the code. It's likely to be easier for translators
> > as well.
>=20
> I agree with you in this part.
> I searched for similar code in other codebases and found such in KDE
> codebase[2]. I'll update patch if there is no objections.

Yeah, that sounds good. It's probably sufficient in this case to simply
mark the existing format strings for translation, since we know
translators can already handle other format strings we have. Also,
perhaps translators will want to switch the period for a comma, as is
common in some languages.

> > [0] Technically, as in English, they have different meanings, but I've
> > always seen French units written with "o" for "octet", not "B" for
> > "byte".
>=20
> To solve this ambiguity IEC standard in subclause 13-9.=D1=81 says
> that 'byte' implies 'octet' (8-bit byte).

French Wikipedia also tells me that "B" is the symbol for the bel, so
"o" is preferable because it doesn't conflict. I have no strong opinions
either way.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.16 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl0Pr7sACgkQv1NdgR9S
9ov1+g//Z5wYKN66TzWmJ5KQ5zgO+vGoMxUe0Pll0S+7H2pqzyO01ZA/0zcDOpJw
+kBE6vKPIYrLSm1ziYDk4fdgPlkxr9GkR7YB/K6BD23mA3examuGbs/NaCfCCL9Z
V53aEOk0oOdn2EJ2I5FqtKG+/V5uPEljLaD76sKWRX8a7toDT4ZwNzMiaH46pWfE
pHi5HDEu8e2shHfh/KGzFdZVdUPn7o9TXClKvYzmhGrGatosEtzBk0SqNdmyDE2K
dNU96253ppxwO6y+CNMlfydedLtgyVjDm89M7Oy0gQsYctqmqBmVfEdGZXdLHTvM
KZ04reCcUiPYowiEYRvFVdUMjuw5fhOQrEPLLtkGauAz8VWSOEl3dh3rgyrc+67t
/GBcZ/mv2Fgp+pq4LX3+0cyfZ+Mo5iSvECnkc6bnF4t8gB71NXZ5sm68722bEFCO
QTJvIr4pxgflcTgvQGmgiHCss+LlMPyP3cWvdr2Etwf14S4MGn1ozQZLOJ9GXj5Q
JJ+oaC0o7rspDS2QHpgcOEELQBQYNW/NnWNTkjUQT7PIKJxM/dGPm7JdTL1AwGMy
hk728rpN7xUV1FtDSOeppKhuBbQnI0CrWTFTLu+uU+3qHlNGbI7PvPtRh/sviFMO
52ppBXq/nTZ4a0qlZW693AC7gEDh6lFsL98cXeOd5XQAhY2j2Jg=
=T5+4
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--
