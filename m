Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A7381F954
	for <e@80x24.org>; Thu, 23 Aug 2018 03:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeHWHP2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 03:15:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58912 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727473AbeHWHP2 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Aug 2018 03:15:28 -0400
Received: from genre.crustytoothpaste.net (108-60-118-130.static.wiline.com [108.60.118.130])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BC85560745;
        Thu, 23 Aug 2018 03:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1534996070;
        bh=uuTvqKENyjWgK8MNLQhfAB5mX5ex4tfDQrSDx8Aswpw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=YGZLAraRY+TlgHAK9ZWVdnX5z2fqnvX6VUs7WXb2a3J7D+6azja5uj0/ud4YV+MKk
         c5SpVyjjpb2gm3Zat2XakHNAisnvY98shtxxyeZOy7yZ5gOcVH6Yyysvq/uPasxgDv
         i7q2D330zbY3n7C/nQ2eOlUmOwSueyXHM++y4kHtz5oAtcsDE5kIpkWyveZrVODP9C
         mozZw3cgWPQpCX+PDI1ZBP7edJd5RzDqQjfzDjcH5i/QhEBihMp8L6qAfnpaznLpII
         IyQ0EFg6bdUeyV144273J8ajtGGyTVp1JL14mw2cUqfnLzvvjptdiHt2EUqo5Ii3md
         HG/s3CZMguVaxGVPZCcWCp14sjVDjrLHz8qlM0+N5rv6DYmAJGcoewhgUFipFLQUb/
         qPYLMBz0YCQZhQKSlbHvKqLfq+xv8gkq2FWQU/IjjFpdlL8uOc6N+eS6P7uKPHnHPW
         J1DpPoVh9LMwwVsjE7KR1b84kVSyUZZiibzc59NFyM7DRY2S4V6
Date:   Thu, 23 Aug 2018 03:47:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180823034707.GD535143@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
 <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
 <20180822152306.GC32630@sigill.intra.peff.net>
 <20180823012343.GB92374@aiede.svl.corp.google.com>
 <20180823021618.GA12052@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GpGaEY17fSl8rd50"
Content-Disposition: inline
In-Reply-To: <20180823021618.GA12052@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 22, 2018 at 10:16:18PM -0400, Jeff King wrote:
> FWIW, it's not 10%. The best I measured was ~4% on a very
> hashcmp-limited operation, and I suspect even that may be highly
> dependent on the compiler. We might be able to improve more by
> sprinkling more asserts around, but there are 75 mentions of
> the_hash_algo->rawsz. I wouldn't want to an assert at each one.
>=20
> I don't mind doing one or a handful of these asserts as part of v2.19 if
> we want to try to reclaim those few percent. But I suspect the very
> first commit in any further hash-transition work is just going to be to
> rip them all out.

I expect that's going to be the case as well.  I have patches that
wire up actual SHA-256 support in my hash-impl branch.

However, having said that, I'm happy to defer to whatever everyone else
thinks is best for 2.19.  The assert solution would be fine with me in
this situation, and if we need to pull it out in the future, that's okay
with me.

I don't really have a strong opinion on this either way, so if someone
else does, please say so.  I have somewhat more limited availability
over the next couple days, as I'm travelling on business, but I'm happy
to review a patch (and it seems like Peff has one minus the actual
commit message).
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--GpGaEY17fSl8rd50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlt+LjsACgkQv1NdgR9S
9ove3BAAkA7ytiLn82FsHyNkwWfEOSEGCK624weS/edT0J9CH0zS8zhR09RSqAHd
oC0g4SyKQhTH8jNgN98SaR00fGOH7PfhoQBwKBbGTwZDu+0SOLpeEm3byXi/1D7x
gN34oLLWQsJ1EVsIjvHX0k/M7lF+NNquuqrXkR2EKasXEPX03lPb/xfcWQISGzqW
12eOYIHXNKmTEGm46ft2bd7bSiwAp5qZ0qHVdpZTLCFlFq6Ltz8SLc8NVhFBknBw
xct8JNtD/qrvr+oIUA4Lzeqhn52yJnJ7v8Wvo5Hb2HT7tioOD/2dN6TpkTIhouSY
kWwege4XjNAK6sA/pqDyQ+8+LVQigviWEwk3vuzvsopd4zhL6+Xxaw2BTIgQVAKm
nXlbflxljx53i6rSF/N5FjPwOJboT0vi8U8sDQw/Q0KtMgnHDUwgC1CB3qz7IM+u
b4hN88dWwyS0DZKIDzJfxGP1K1eLhmbiqTcEq0GU29yBcdslEIRmnCzHF0bgvfWd
4OkYFAPbnxAebMq0sQh9pPDlGaqZ1CEyyzpl3+5ZpHOTwFWbCjH41HPZTRAUi/t9
m37Gn6IcFEMKiL5dbyOLpwviSoKdW2LtWjK62E7jL6/itMaUMpu7nO2dPDXricGJ
FHbp6leF8EACHH/EIaQkBZSIQysMZvmZ3H2zUkG61bsZA5v9gM4=
=9kHK
-----END PGP SIGNATURE-----

--GpGaEY17fSl8rd50--
