Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4B6C64E90
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 00:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00C2F204FD
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 00:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgLBAh0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 19:37:26 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51848 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbgLBAhZ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 Dec 2020 19:37:25 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 07C8660422;
        Wed,  2 Dec 2020 00:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1606869374;
        bh=UWS7Sj+PrTz+csFoxid81pW017nodMoe+1uKh+w8h2Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=jB0sZzKwxd/yG07SIO46XFIdJkHmi4+RO14blJPAwmLvwo3FZWffRj719aTNvNqn7
         Mb+/UGGI9FUVA88fDKEUukDQXXJWfemt3T+drJOe1HIdyDxx9TK9xkz0Zx+Eb5DLg+
         CuJZ6Kca9i3TDePpIvCsV6sFBOipXMYJkpX2i1QHLnbEX5gJKyfWyt+Xvw+VDB4nUY
         rn8w1TMW5ejMaDPT8TK+SssiClhz71LAq5MiThDYZPpz2kGXYTO3xD7MaYskiLoIJ9
         E1Vw7XGgZVtwl3jrnnAIMDz0t9NCd90eBrerlQ/w8zB0MYzx1qqmsHpo01XiHYdorz
         YvKwDD/pJXKY+4fU4JXN4GkQyS1pGvKFh26z8x73XU8oLpec2AB3dq/GqBPbbVagPr
         60nA7njbg6GpRREvb5q4y7cM4jakvVQ4or9QCKuaBccd1TcMEK35nX07zBpUL80624
         v2lUVE2LU7jh6V8fJtMs32zm2D6T9e6vZcAvpaYVPW+zhAdIeWg
Date:   Wed, 2 Dec 2020 00:36:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Arnout Engelen <arnout@bzzt.net>, git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] doc: make HTML manual reproducible
Message-ID: <X8bhdyu/OlscI1ME@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Todd Zullinger <tmz@pobox.com>, Arnout Engelen <arnout@bzzt.net>,
        git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
References: <20201201095037.20715-1-arnout@bzzt.net>
 <20201201154115.GP748@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="94WkJK3koBdw7FGn"
Content-Disposition: inline
In-Reply-To: <20201201154115.GP748@pobox.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--94WkJK3koBdw7FGn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-12-01 at 15:41:15, Todd Zullinger wrote:
> I think this would raise the minimum supported version of
> docbook-xsl to 1.77.1.  That might be fine, but we'd
> probably want to make sure it doesn't negatively impact
> OS/distributions which build the docs as a likely group who
> care about reproducible builds.  And we'd want to update the
> requirement in INSTALL, of course.

I don't think that's necessarily the case.  I just tested using a random
name with another DocBook project I have and it seems to work fine, so
there shouldn't be a problem with specifying a name undefined in the
stylesheet using xsltproc.

If we want this to be effective, then yes, people will need to upgrade.
But if they're happy with the old behavior on ancient systems, that
shouldn't be a problem.

Regardless, I think this is a valuable change, since there's no good
reason not to use consistent IDs and at least Debian is switching to all
reproducible builds so vendors will appreciate this change.

> AFAICT, the generate.consistent.ids param was added in
> docbook-xsl-1.77.1 which was released in June 2012.  The
> commit which added it is 74735098e (New param to support
> replacing generate-id() with xsl:number for more consistent
> id values., 2011-10-24).

If this was released in 2012, we should be fine.

> In any case, a minimum of 1.77.1 is present in the supported
> releases of CentOS/RHEL and Debian/Ubuntu, at least (most
> have 1.79.x).  Those are certainly not the only systems Git
> cares about; they're simply the systems with which I am at
> least mildly familiar.

Yeah, CentOS 6 went EOL on November 30, which is very convenient.  I'm
pretty sure nobody else is using such an old version, and even so, I
don't see a backwards compatibility problem with this change.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--94WkJK3koBdw7FGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX8bhdwAKCRB8DEliiIei
gUL/AP4vkBchx1z71x/uRnrp7naHqUXainkN75pVRqZKn9oVRAEA7w03UacYcUt/
kIg+scKIoyGhUuCCsxXTVrnRqgV0WwI=
=7+uf
-----END PGP SIGNATURE-----

--94WkJK3koBdw7FGn--
