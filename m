Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A0DC433E0
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 22:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F6A52074F
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 22:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="C+SvFlY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGZW7q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 18:59:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40810 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbgGZW7q (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 18:59:46 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9F55D607A2;
        Sun, 26 Jul 2020 22:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595804354;
        bh=GmJ9RnDxVSPtTFJwjLrVHkDHfsVy6+LqWU3TxUzgmC0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=C+SvFlY01JM2rllF/UzAylV7S0eel0DI9ZfIX4S+xUnGkZ0/Yp1lRO3wLvTrWOvHr
         6vgvUfibJI1xJbShHliCRVHSrYsZvvdhuJ+ohEMcLB4raxNEWkQWbiRnQWlwtrlxXY
         1Jab/fl8Fb3cENM+AxW9WqwjRbVwKGw7vcJnfCGOLHOP+Sr0GQopOrocpBfkuwQn3B
         VtoRWiosFdp4d/hsrcveVVGxijUnq+NoZ/1vLsere8yskwgjTwdFwfmHFAis9ClxNL
         lOyvV7zkP8LVpWUFwf9tpyKTyU/Rn4SF/pgp5Ed34LRfMafPsCJxlHjvUxMZYzxE03
         Jen8d1bY1V4cZW5CHJL3VdeqUqmPY1PrA5us3KFBeIPYdb+jL5GaMgDGd3ovqYX98F
         3Wz4CSOIwGr/YizLoWmQkRFrUx46bVJ/HUoJ9WKVXzmqgJTD2Y4gdxm2jQuE8J0ATh
         8SKerfYXE3+Lm+USLweoQ7BMlOZCigKW7T0Ny7YlHD1+C+7u9Eg
Date:   Sun, 26 Jul 2020 22:59:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v4 31/39] bundle: add new version for use with SHA-256
Message-ID: <20200726225910.GD6540@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
 <20200726195424.626969-32-sandals@crustytoothpaste.net>
 <CAPig+cR+e9XGNCgtDMHUsaAgbKDi=-bztwtd64fVZj7S05ppKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Content-Disposition: inline
In-Reply-To: <CAPig+cR+e9XGNCgtDMHUsaAgbKDi=-bztwtd64fVZj7S05ppKQ@mail.gmail.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-07-26 at 22:18:23, Eric Sunshine wrote:
> This error message would be more helpful if it provided more context,
> such as the name it tried looking up. For instance:
>=20
>     return error(_("unrecognized bundle header hash algorithm: "
>         "@object-format=3D%s"), arg);
>=20
> or something.

I've improved it somewhat.

> The reader has to think through this unconditional NUL-termination
> more carefully than would be the case if...
> ... you just moved this strbuf_rtrim() call above the capability check
> conditional.

That is indeed much easier.

>=20
> This conditional will become fragile when bundle version v4 is
> introduced and the git-bundle invocation somehow triggers v4 to be
> assigned to 'default_version', in which case:
>=20
>     git bundle --version=3D3 ...
>=20
> will complain:
>=20
>     cannot write bundle version 3 with algorithm sha256
>=20
> which is clearly wrong and misleading.

I've changed this variable to min_version.  There is one place we use it
as the default, but I think it's easy to change that if we want it to be
something different in the future, and all the rest of the uses are of a
minimum version.

> Do you still need the "head -n 4 ... &&" check at the very top of this
> list? Is that providing something that we don't get from the new code
> which uses test_cmp with 'expect' and 'actual' files?

Removed.

> In my earlier review when I suggested using an "expect" file and
> converting the object ID to some literal string such as "OID", the
> example I gave did indeed also use literal "message", though my use of
> "message" was meant as a placeholder that you would fill in with the
> real values, like this:
>=20
>     -OID updated by origin
>     OID refs/heads/master
>=20
> I probably should have been clearer about "message" being a
> placeholder (since I was too lazy to look up the actual values). I
> suppose the generic "message" you use here is no worse than the
> original code with its 'grep' invocations which didn't care about the
> message either. It makes me a bit uncomfortable for the test to
> unnecessarily be loose like this when it doesn't have to be, but it's
> not necessarily worth a re-roll.

Fixed.
--=20
brian m. carlson: Houston, Texas, US

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXx4KvgAKCRB8DEliiIei
gawVAP9QgOzpJg5ZEJcOqwV8WhP0kVIzGroaKzjYPNShTGCP5wEAk2U2CItwoum9
RqShJmxOzLGllBjpWkH18oMTnt5BJQg=
=nCcO
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--
