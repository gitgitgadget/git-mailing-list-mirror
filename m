Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4ECE1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 22:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJQGig (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 02:38:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50934 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726697AbeJQGig (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 Oct 2018 02:38:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id ABFD861B72;
        Tue, 16 Oct 2018 22:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539729960;
        bh=IxjVJPrpsZFCm8n7JGwsVEIum9fdjVhv+fqdukXsQUY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=iRiq2KS+C6nxDas/Kfxl/8h4AZIPd6+4OKC2RfvszmiK1wAkuvKx4qYcXS1NFprzQ
         aLsaLrni6SyRscSMojANFyKQJPwd4SCHTT6vW82tc/bzbuPoDNg5jhqDBI91xTZ1qP
         GgnRXEtRN0xDhrhqb0wvleSVGwEj/T6Bktt/nMxZzsYAiWhWbq906riJn2yokEz4dQ
         2/n+wYo6XNR3nihjNnqR3lKGlqCFwHI36LPY6vrUhi2HiRhIYrfaZ4jjNdU00paTMu
         SSGKPEmkTRmj/v1rk5EYCDsz2itqgvZ/oXgXKhbnJT+KM9mIdDJ2JqGu6Av1nX6/o8
         u7vXX1AQuZYvO7leWcIoHjBUSOtRdIg0pyRe+R0ZN6L0R3dDUJj9M3i2DuF9q7aY5v
         PVV/rwq3idpxJDwL2Nfk8srkSLxuOPljueDUea1Xa1fywAkojlyobo63M5m01h2WVd
         hBgbF/X9OGNWbUhe/6wdiVFuF48Wz6hkBqHw/ZUqsgRJeRPKEaD
Date:   Tue, 16 Oct 2018 22:45:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 00/13] Base SHA-256 implementation
Message-ID: <20181016224555.GE432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
 <xmqq7eii35h8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0tV5B2PPHN9RaBP7"
Content-Disposition: inline
In-Reply-To: <xmqq7eii35h8.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0tV5B2PPHN9RaBP7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 01:01:07PM +0900, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> >  t/t0014-hash.sh                       |  54 ++++++++
> >  create mode 100755 t/t0014-hash.sh
>=20
> If I am not mistaken, 0014 is already used by another topic in
> flight, and will cause test-lint failure on 'pu'.

This series was written a while back.  I'll rename it.  Feel free to
wait for v3 before picking it up.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--0tV5B2PPHN9RaBP7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvGaiMACgkQv1NdgR9S
9ovmAg//fdexpa0Jxl35IBKNu/eVs5qhbPeJlJROB6MzsF9MHQmqzBSzQ0AdS/Kw
Yss1WNFv8RIaIq1bClAa+32OxlzciBQ7cPBcN2JG/oH1fKGvcB6+BX2YajkHY4Ap
1sIyB2478VzCXab2itja1j69Mzx3NeaFzkqwtosiLn99Q4xZEEh4H3HPUfQgqubG
PFmj05nsIXLm6FJ9uT0sf77Phtz2elaWfFZEnOfwrAIu7UbMfBecSLsT/rfd0+lp
6EJeSiZqjinNxz9gHXqP1rjOaGygebBATzUiq0kLwIKxKFG/ijYCzn2g1B5lUkFk
3AIK2qYKIBk63Hfl1WlraPxwdEcA1UQj/scz0XCs91ZC1c2W6zp559GsHj5ksVVM
2rSIGUFjMlTKOWl+3532OcoDp6sQkcoCT73PxRyGh6cnw/xIQEOnEdi+Q8eJnztw
VVo1bQIT7q/1/vddy4sVK/KftG7mOawWiUepdcUwziPj5fn91gMTkHRjDj9lo0dG
EFUPub+gSoQbL+HLdB12BzEQIbJlds+u9st0zXqn+Ok8awguxVLy5MMzaI5ds6nF
0KMDoEAUW/aeARLfj9HHwUjxwagIlJYV2wwgWDJ1AmFmC4pqwU++NKKHhnudtw4s
gQ6lDUOnElqMDQXT620RL1wOBmFbXkqxljoCqtnFvw51/AyE8EA=
=wBQG
-----END PGP SIGNATURE-----

--0tV5B2PPHN9RaBP7--
