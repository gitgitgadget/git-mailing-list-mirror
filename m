Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601CBC2D0DB
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 21:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CA020702
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 21:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="l9Ne1kiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgAZVuW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 16:50:22 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47602 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726252AbgAZVuW (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jan 2020 16:50:22 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CCD886044F;
        Sun, 26 Jan 2020 21:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1580075421;
        bh=9AZYF4XkfD83x7d8o9NUPgWHPXGPNsbkJqW10Jjddb8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=l9Ne1kiWoGgm+eP9l6tcTOZrp+qYCBhxCucIJ8yZ86lA2CCNrTBHBpqIPEuiai96D
         xcygpqWsj3iUqJzCUSOa5kGw+DwM7JhLWw/JOtv+C+LGatK7C4ZvVOL4BvthRsb1N7
         3vh8L3Cla+qN2LI9GmVL3qeGQyUIWe2COE3VkoY2IOMZYC12Pp+c5o6x676IOGs6I/
         oBHvJuzJob/vCo73MpnhTiaveuceCp2xWhoZLieLRi/7WKay+5sQSuYTCR2LLadUKw
         mNpnZh23geWkJmg3WeOLM/Q/feAMuGN+q4zAn6kMqJXBgwCf7witwfinFzvFaHRXnc
         1eQ5kLeUfiYhWivTI5dnIx0B5F/VusGY8hZb8eo5oYCVMDwGSHTg1v9IVVHMWzwd/N
         487fnPCbeMA8VJds6b+hmOMgnjZIQq0qias58w1WW1txZRVUCl5nNX6sS8LP7LbdYn
         kT/iAAaOs6iskIGCbWVD7J323u+VAqRoKg19QvtxvrrBsVwm2uW
Date:   Sun, 26 Jan 2020 21:50:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johan Herland <johan@herland.net>,
        Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 03/22] t3305: annotate with SHA1 prerequisite
Message-ID: <20200126215015.GF4113372@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johan Herland <johan@herland.net>,
        Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
 <20200125230035.136348-4-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2001261209590.46@tvgsbejvaqbjf.bet>
 <CALKQrgcF0KK1gEvyKe3th2w0YJBbmv+grgbCeN4fOzHKo=H1UA@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001261957060.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2001261957060.46@tvgsbejvaqbjf.bet>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-26 at 21:28:58, Johannes Schindelin wrote:
> brian, would you mind adopting this patch into your patch series? For your
> convenience, I pushed it up as `t3305-sha256-fanout` (based on your
> `transition-stage-4`) to https://github.com/dscho/git.

Absolutely.  Thanks so much for both of your work on this, and for
confirming that it's just a heuristic difference and not a bug in the
code.

I'll send out a v3 soon.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4uCZYACgkQv1NdgR9S
9ouJ6g//UoXIEFFKIg3FOmIuUCWMUzzlgfqRGrTmkveoRShHYBuasgRIWR2XgQsF
jMOA09aOZoJHh1j5PBBGxV5DO39NTs4EQkcvs7I/1mSIIHPgRYZsCBW73WOzeoks
ZwFQVgEPEDVmibgu+HABotCZHjTVHiqgtXgf3ohacXOGYcDL70GYihR6z+Wtd9SJ
oB0znXlR6/6Qd8uvd3iXMnV3/wR0DZjH7jtPpENZsMRt6qf/St32RJbXXGnRHX2s
5Cm1Hko8mp+A5m60weoif+iLZHcYOhDK67BVN3aoIar9Xz853NOP5SmwOl92Jzte
QteJK3rmtjDDWATdglbG/uTThG9ylcvw85RQ1XVPgL3AMbqFWjv5USyeKMwvndlN
Wg8oyJ/JXQaMVWNrOm73feMnuId68hC5YtupnI3A7IfXQ0gNh7Br0EuOXaFDNWll
jh3p3yR9a8QzVrftnXRyj2ZGEiROnCNSNLg8h7kPDjz1+TyIwQSfrjSEfEevQyTB
v45ACyYYLLD7pQbn7W7pV8mJq8QKhA/KhPpoAAXUT+THUrUcIldnNBwl6TV/KTlI
UOY2Qckx8YZE6hyHvgxp77OxrL0cYxigyTj4gsuFPLW7bLacRyPI/R2FwzyQKkLi
jDfkrmy0pTPBOD0g9km0wnNWDyvq3zpBaeUTGmQuOZJmZ+kjTF4=
=qfHm
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--
