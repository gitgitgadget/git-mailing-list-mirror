Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA8681F461
	for <e@80x24.org>; Sun, 23 Jun 2019 01:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfFWBDU (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jun 2019 21:03:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56170 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725844AbfFWBDU (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Jun 2019 21:03:20 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:d086:4612:2ae:a31e])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 54F0D6048E;
        Sun, 23 Jun 2019 01:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1561251797;
        bh=CRBblBEIqYk/RD+2skXPv5lLRVF8LUvg7Y/IAc9sKZw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TJbUrE9hQBzB+PMwTjzZctG/Z1h0L2apl7Zfhh+HzrNKA5yZxmso34siRvw7nyS2+
         Owj+2uJhVN4tDY6u+Gie/0SfB4ueYsuiMX+ztErpfZPQOM0+cuGFT4I97JSj25OzzW
         PIYCNmQ9AYGaSN9+2tHqxOh65o6p6JJrSTcQuoo8VlVQdN2rNZ6Ldyof+pHMnNe+bK
         9LBqOG0TD15tRkg7HgviTMsk8/cab2AyldY4hWT8E3DN8z2pu6wisqboswm9j3ZWOG
         JNaD37sgz6YL00iyDPnBKRth23IyTI0DxJvBQ3X6H/O+4zN9yfY9qlDQOKYMQQck4j
         4KiyvQBHlhiPn68YFLrC3DUELAAk6pL8rm+bITWq4XpMYA9m/jTPpU5b9IaNCC1Y97
         ViaU0dvCEhufjomtZ3fG0hIo8LAtvRp01nboTZMwmYU21m/oTY7ISVZnQYI6JAE1FF
         tAVGyOTOAZJS+oI+mUzsa8A2bi/GLaYdyku/dm82qdvxvJHVNt0
Date:   Sun, 23 Jun 2019 01:03:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3] l10n: localizable upload progress messages
Message-ID: <20190623010311.GC965782@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20190622093655.80092-2-dimitriy.ryazantcev@gmail.com>
 <65cf1cfd-bb5f-dba0-17d6-7fee0ed1f51f@kdbg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline
In-Reply-To: <65cf1cfd-bb5f-dba0-17d6-7fee0ed1f51f@kdbg.org>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-06-22 at 21:42:33, Johannes Sixt wrote:
> Am 22.06.19 um 11:36 schrieb Dimitriy Ryazantcev:
> > diff --git a/strbuf.c b/strbuf.c
> > index 0e18b259ce..0a3ebc3749 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -814,20 +814,28 @@ void strbuf_addstr_urlencode(struct strbuf *sb, c=
onst char *s,
> >  void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
> >  {
> >  	if (bytes > 1 << 30) {
> > -		strbuf_addf(buf, "%u.%2.2u GiB",
> > +		strbuf_addf(buf, "%u.%2.2u ",
> >  			    (unsigned)(bytes >> 30),
> >  			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
> > +		/* TRANSLATORS: ISO/IEC 80000-13:2008, clause 4: gibi */
> > +		strbuf_addstr(buf, _("Gi"));
> >  	} else if (bytes > 1 << 20) {
> >  		unsigned x =3D bytes + 5243;  /* for rounding */
> > -		strbuf_addf(buf, "%u.%2.2u MiB",
> > +		strbuf_addf(buf, "%u.%2.2u ",
> >  			    x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
> > +		/* TRANSLATORS: ISO/IEC 80000-13:2008, clause 4: mebi */
> > +		strbuf_addstr(buf, _("Mi"));
> >  	} else if (bytes > 1 << 10) {
> >  		unsigned x =3D bytes + 5;  /* for rounding */
> > -		strbuf_addf(buf, "%u.%2.2u KiB",
> > +		strbuf_addf(buf, "%u.%2.2u ",
> >  			    x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
> > +		/* TRANSLATORS: ISO/IEC 80000-13:2008, clause 4: kibi */
> > +		strbuf_addstr(buf, _("Ki"));
> >  	} else {
> > -		strbuf_addf(buf, "%u bytes", (unsigned)bytes);
> > +		strbuf_addf(buf, "%u ", (unsigned)bytes);
> >  	}
> > +	/* TRANSLATORS: ISO/IEC 80000-13:2008, subclause 13-9.c: byte */
> > +	strbuf_addstr(buf, _("B"));
> >  }
> > =20
> >  void strbuf_add_absolute_path(struct strbuf *sb, const char *path)
> >=20
>=20
> All of the prefixes are in ISO/IEC, i.e., standardized. Why do they have
> to be translated?
>=20
> Isn't the way of presentation of magnitudes with a unit also
> standardized, and should not need to be translated?

In my view, the translation is less important for the prefixes and more
important for the unit: at least French prefers the term "octet" over
"byte"[0], so instead of writing "MB", you'd write "Mo".

In general, I think it's better to keep the prefixes and units together,
since trying to translate a single letter runs the risk of collisions
with other places in the code. It's likely to be easier for translators
as well.

[0] Technically, as in English, they have different meanings, but I've
always seen French units written with "o" for "octet", not "B" for
"byte".
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.16 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl0Oz88ACgkQv1NdgR9S
9ouOFg/+PF0bjtdD1bsiCWdRGSb/LDDra3PcvtCgvOeSTO+eZDG0CoLi0P6yt4JO
cOxPO+t3xzgLtklAR0EiCUV2NyUiS1JXYDwJZGwyfs+PwafQzB/9WrneL0Dt1svH
J62z96Rp2U4DbQCU8cN7LmPJdZ1c8aZBIQoMkLyYUvfNt3GcIRsRef+x0BS3/lTm
FZLedUZTDj04jtc2kYBI9BUoTnU4yvAecEpZNWjtriKbNnwnXqlB1Flkl0KHPvgr
PVwo36fXjjz5qHiZEWZowFInRh7CD/GcLOQeLS0QFOZF3YmpVTQM1GH+tzmGL8jU
QkNnpLjeNAk1mhper1Q+9N+fFnNAkv8SIxvMNRFg/aTC3vPjA0YPvyITdcml0KlD
Di2+TUTp8QU+UM50aLvl3bxNKku1JO8IGV2NYvtbc8QuKr4MAabDNdv3Lffi0XhY
I2iRuuZEQDrYwDiLuGChqPN0kLINiy2NwvNlqj+XdaSGlG52QDnvF/KO+QdgCiUA
IPXzuGpsQ+XUP03poFAKmBLfaRpd+MPbIsHIeyFTsSc5Pl1p0vF0f36pi6T+Ln4R
nk9vdYrej7DbzfGkyKGCDncB6FhiL9GydNEvZpEOyRd/RbqdC6u7q84k6KDow0Sd
Fk48A4a3gulSDAcJ5q6zSrWY/vnnr2bM0/42dnQuCMiL4V7fIDg=
=bbLL
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
