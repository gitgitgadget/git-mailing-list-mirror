Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A30581F453
	for <e@80x24.org>; Mon, 18 Feb 2019 19:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfBRTJ2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 14:09:28 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34560 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728391AbfBRTJ2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 14:09:28 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C0C26603C6;
        Mon, 18 Feb 2019 19:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550516966;
        bh=SO5NDuVPHchKUVSnC9OyS3fe+1hUwnGeJ70Bnl58ZPc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=i4LPLiWYaC7tXigs368jLLT3lNvD7NfT64SjFFwbXpbpE96J+qaiv9qWcuSi3VJD2
         5DFuebDh5LtlBdxEuoivp2pTdProekuxKJdUaafWDim0JMsW48FNZZehEI31TYU07n
         19rTAxRw1yugXVXzbu56pusJalU3bRp0tXhSxM+5yuK4mse4dW2iiSdL8FEmIH1yCB
         EXeFYvpVO6d4aStnk1WYiMfs3v4G/KGP5qwheZBMc42njol643w7sjUlKiaM12l+P+
         si+jNXnS7qHdDnkG2QchW1fv6qLGMqBRGNFtvJHAgyMbL4m1PL/+FKUZ2DALz/cd6S
         4XOvRwd6pcQarki6rI2AmI8/E0p/Rj4c2ZMliWc/mIEZcDvRCVBaC9h8T+xmnuW4uY
         FiGKyK8Rwd9gJBTT02XlV8hFwNDYNjNDYtNk1e9sNkTiEhCEpUeULAR+RC8Lg88s27
         /JrCNsI0wqjKufrUz4JUW/xpHWJb/T6dCYZQnlAGWO9n4xnVyo2
Date:   Mon, 18 Feb 2019 19:09:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 30/31] Git.pm: make hash size independent
Message-ID: <20190218190920.GL684736@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
 <20190212012256.1005924-31-sandals@crustytoothpaste.net>
 <87zhr1jmr4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="umrsQkkrw7viUWFs"
Content-Disposition: inline
In-Reply-To: <87zhr1jmr4.fsf@evledraar.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--umrsQkkrw7viUWFs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 11:59:27AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> The gitweb code doesn't load Git.pm now, but does anyone know a reason
> for why we'd avoid any perl/* dependency in the gitweb code? If not the
> regex here & in gitweb could be factored into e.g. a tiny Git::OID
> library which would either just expose a $GIT::OID_REGEX, or something
> like the sort of interface (might not be worth it) that I suggested in
> my feedback to 31/31.

I think one potential issue here is that some distributors bundle the
Perl modules with git send-email and not gitweb, and they're packaged
independently. I'm not opposed to seeing a patch to do that, but it
probably belongs in its own series.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--umrsQkkrw7viUWFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxrAuAACgkQv1NdgR9S
9osjBw/9GhslZDaZDbE5oPm/hMXutIAJZv9FwFRBtKzHVyJXKh1Ng48XVN2mtsvX
IBhxWNWlPKUzH/NUZLF/p1rhSjNiCaVilMKJLm0FMqXtlY8neIMTMbn9cNOcrSag
remo8UyabYUWRYRzWj4QZaL8zCWEWVw5OODVUFOMDiuyhtK5/4QJRFUcssEpnznm
8Zl7cwZcVKlBP51sQwFVBiCyxvUHo5INYeqcNPtYBrw8ykgimQuLsvWonRp4eIt5
9v0KFhX5LJctQrNlemwL2M/lU4nCH0ctl3MXVV+TWsbwQ5FhGTlIcZzFkkb2HVnb
5v2MHTup01OTKsm/ashk0Na+up9lct7gzSmuVOmbBo2wtWtF8O5hCw3H9/FDrN3G
+n2d3hwM7ixR0qpYCTZrQ2Zqv4zxq30h4lpU3kaT+e0CuZPXMNGfnbFEdzKGAI3L
iAhl7Vx99QeQXmVQqIVravWDAsMZOexAiJTG2zEev7/w+oa/zpZItOdWJ8PCcqGH
GJf2XfmeOnMeSi9du0B2O3JlTVOkvpe+FidbKQaHCSB6P/gKkjZagS35z/JYaQHi
fTSNVT+CARk59MoXXjayl7IBYjSeIEI85sq1e6LNegKq+m5q62Qn4WBf9wYcUd+e
xIS6FSlBIY9T3YhtzBs1ErF+z8ynTWYGF67csFy0QKi7rqBqors=
=sfA2
-----END PGP SIGNATURE-----

--umrsQkkrw7viUWFs--
