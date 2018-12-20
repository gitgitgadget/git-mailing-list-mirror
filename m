Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1864D1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 23:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbeLTXyq (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 18:54:46 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57830 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725385AbeLTXyp (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 20 Dec 2018 18:54:45 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b469:672:eccb:defe])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0CC4D6042F;
        Thu, 20 Dec 2018 23:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1545350083;
        bh=oYN/H2VnOemL7g9HMmb8BD0IsITlHV7HfxKdqvWkTf8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=i5SDQZxq284bdkXVdpPPMyaw6JIUZrUFm9MfOKpdR/6VraFZ3w/lf0bvB5gwSTGqy
         N6ZQLLdor2dTXDlkEcT7r1UW8Y2h+iOTSTZvApDQLQq+JUkrFK+h1dE66TBepJB5NQ
         1ebnd3S9Oy1WGPZGi2Icx2ux6C6loyLVRq8UO5HezhPRucOpe/vK6w+NmTRBrbWtkt
         I5Y9ONXQ1fUwyY5R8pRHuiYLlSPkNDTCMBQQtaFwUs1IDIU5RvWRXvI/fYXa9MjU5m
         zb4QS8KQrhIgz7wqx7rbT5DxHYcmxL8uc8dS7uc71onh3ZWUZivexCEbYXZSD7lxWE
         SpLXcFg25z98ZRPWluQcMotCkkK2HfWTOF6O7kRohd35tkSBfT0vumYqzmNpQ53Qbj
         0ZACJ/+g1tM0cVkyqP4m+PY1/2N6ceRMKQZllW5HlUdX8bmLCXcQ3kx6lU6yGEhRI7
         +286CJ+3wHxnPrSXAgyn8ZV4vBSCdcqCakvZGn/9EtCB9b03qqQ
Date:   Thu, 20 Dec 2018 23:54:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] diff: add support for reading files literally with
 --no-index
Message-ID: <20181220235438.GE35965@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
References: <20181220002610.43832-1-sandals@crustytoothpaste.net>
 <871s6bg9hx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZRyEpB+iJ+qUx0kp"
Content-Disposition: inline
In-Reply-To: <871s6bg9hx.fsf@evledraar.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZRyEpB+iJ+qUx0kp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 20, 2018 at 10:43:06PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
>=20
> On Thu, Dec 20 2018, brian m. carlson wrote:
>=20
> > We don't include a test for the pipe scenario because I couldn't get
> > that case to work in portable shell (although of course it works in
> > bash). I have, however, tested it on both macOS and Linux. No clue how
> > this works on Windows.
>=20
> You can (and should) add tests using the PROCESS_SUBSTITUTION prereq
> Dennis used in an earlier version of this:
> https://public-inbox.org/git/20170113102021.6054-3-dennis@kaarsemaker.net/

I'm happy to steal that code. I didn't know this had come up before, so
I didn't think of it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ZRyEpB+iJ+qUx0kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwcK74ACgkQv1NdgR9S
9osgaBAArW12sz5BB1Ipf3XjHk4ldVu0pGsbLkyVurYYFnLS3wJaiCzodcN3intW
su1BE0KmMpdfWCssuwucHaW5zLRYk1qVqrDF1VY9qGkSir07feNEb6LSFtNfFg+V
ffM7k+EjjvG1nxu5Z5djSJnFf7Ys9eXxQcK2ZT8WLO6PX8DT2Z9CeRFng/UyCnUQ
U+fHnRi/pIBX74FGDiz08+y8OW4G5NFLejQ7aNvla8eaAEmqturzFwDKCifBmljT
EUybjBaMIUQQ5tA68R6tT+xiPQPvAYGL+UZ7nWv5AuRMN7KnPtbwEJ30jBf7xb59
ihyZpdkFGhfIS+Ekq0qqYmtfQN7RcTYF23UOQ5oQ3iIN2+I5BDlKRrcr6guARJqY
8T33UA0+8WgGdZq3WLBP7GhqiIjpSEBKoMyqtTx6+PrIa2Z00FboFz9vHNWF/7nP
opiheKrUu1EPtfJka4fIzO35yehTlmvNV7nH3avXkdOd0WamllljygKiNI0rX4tx
RmFAK/zRyVIz4DCNtTnq9oyG2RlMea6t/H4YkWWXyjHq3YBXJRzSvL3B1c6rTPCt
WXNuLTqG+zhe1IO2TO6I6RjzVnWPsTao1KssxMklGJm0TIhQ4supL1ywkTqB7TT1
5ChyBJKVEBAchSAaWaOkhccMJN42X6zpnpSbC+n1twPw+VVT7kc=
=Giig
-----END PGP SIGNATURE-----

--ZRyEpB+iJ+qUx0kp--
