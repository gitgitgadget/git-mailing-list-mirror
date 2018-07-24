Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88B8B1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 22:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388686AbeGXXZy (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 19:25:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36376 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388538AbeGXXZy (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Jul 2018 19:25:54 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f1fc:eee3:60de:bdd8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 915BE6042C;
        Tue, 24 Jul 2018 22:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1532470638;
        bh=bIJhJZKuRkqm3rnE8QamKIlo9fQ25cTpqoW78Y4r5ao=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Ulgawt1BmSwimTfUv4NJtN+wboXvs8/s2+AS/3FCAHT3uT0orAeYVLxYQU5KyqkMv
         MYhl5WkkADSc46lw4B1L8bHiAB4IqqV/P0Y9ZBkHDNi+/LCMaPturN+Bx5WHA++EKa
         Bm0cEBdIAbEtWfrGyIGlCHWS2gMDJDchIDGPPCDFS0wkv8q7UJTRo3L6ft+NAEhvlk
         Mbpj0SV1NcunDqiOQrm+oO1dHORsxwXnCU/LQKr3sygGKDKsR0f0RI4VtF3t2SMNbN
         SGH7+FU+zus6RE82W85GTE/2cvWQnKymIyKe/HuPIYZeZvwfBlOkbLMMs45u/PlYBl
         KX1xO0F5M7a/6o1A1BfKUyD4zzGdlbtXyg1wV+BlPzFilJk4v4js6sT00d5pL0FnOq
         R/A4kEt7Sd8xzpGdU2U/1ObcuGwO6ukwwqKWSv0gDPPovRIwDQiOscyFgJnCH2HV+8
         hJ9K+Mg4A+OFw6U8hncsmUqXdF/onAoFpJvKPeo2mzQi8zW9qn4
Date:   Tue, 24 Jul 2018 22:17:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 01/10] t: add tool to translate hash-related values
Message-ID: <20180724221712.GJ18502@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
References: <20180604235229.279814-1-sandals@crustytoothpaste.net>
 <20180604235229.279814-2-sandals@crustytoothpaste.net>
 <20180611074743.GA24066@flurp.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KZLWU/9q3evlN4nQ"
Content-Disposition: inline
In-Reply-To: <20180611074743.GA24066@flurp.local>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KZLWU/9q3evlN4nQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 03:47:43AM -0400, Eric Sunshine wrote:
> Here's what I had envisioned when reading your emails about OID lookup
> table functionality:
>=20
> --- >8 ---
> test_detect_hash () {
>     test_hash_algo=3D...
> }
>=20
> test_oid_cache () {
>     while read tag rest
>     do
>         case $tag in \#*) continue ;; esac
>=20
>         for x in $rest
>         do
>             k=3D${x%:*}
>             v=3D${x#*:}
>             if test "$k" =3D $test_hash_algo
>             then
>                 eval "test_oid_$tag=3D$v"
>                 break
>             fi
>         done
>     done
> }
>=20
> test_oid () {
>     if test $# -gt 1
>     then
>         test_oid_cache <<-EOF
>         $*
>         EOF
>     fi
>     eval "echo \$test_oid_$1"
> }
> --- >8 ---

I'd like to use this as a basis for my v2, but I would need your
sign-off in order to do that.  Would that be okay?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--KZLWU/9q3evlN4nQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltXpWgACgkQv1NdgR9S
9osBIhAAgzQbBMQBrDHzaT22XeOg8Mdh+dcrcf287Bey17g+S+qHeT0ZBo5ONbLF
Zg9PDHF/HNWbts4HN8Z4kubPF2bD/WAYfxEMrlTHV9edHKqPZTYv02+Sa3eyCdiK
bG+0k03PGqQ/XZv8r3uYasxTN1DsWp3gpZc9wwqZLHslMEtXaEWNnaTE8c/nDZb9
JZX5WuwgfO4C/YY5QiI3oT7XOnn30puF/geVlmKTsm4Qo5UlIQXQzTIsmlhq0X/W
6xWjUjmLRrlw4fK/gawG2ZrgVDeSze/BLCk3ydZe3hLgsDSzpdZ08C/xl5wOYL+h
3G/oh9t8ZU6OINufr6+kgsYdPKAvj26+v3ly3tkYHPfuZtcbGfJATwBIvdNegwTC
PRmbKYzf085l+WVJURo/XUqG4W9oVglmJfygFHl5Frf276SZ5MzMSx8aUh9IxxC2
oh0QVHwLQuIsLgKMIYjuN1RhiijWstqHErtTJ0C9JQPYeC1/yZtcoNpGONU6LVCk
R92F5dBOOy7gtRK/9+SMo9JcViJ4xACnvEwf5kLmRPWCiM+JpzIEnzl8PoxkstN5
Q1gDA1SqgNE862c241t9QIRx4gqiy67gVMyC0hGXdOMtfEGFn0MBLapa8adQ+Z5w
2MYNZ15f5yZLAHtMwkqp1PPEo37g5xvc13abc3l9MEyuf42g5t0=
=WZlP
-----END PGP SIGNATURE-----

--KZLWU/9q3evlN4nQ--
