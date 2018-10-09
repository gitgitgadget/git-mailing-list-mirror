Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C11751F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 22:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeJJFp3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 01:45:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49660 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbeJJFp3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Oct 2018 01:45:29 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 707946077F;
        Tue,  9 Oct 2018 22:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539123981;
        bh=M1LcTseoha+AholUJKMkoO7VXXvcDVFMNy/JVGyLu8M=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uCtNCFEIjB8aItd98WpDr7eLUEPksj539Qf9OZb4QS3coHm8si9Vq002zw0LPxuls
         hozEF2+hz3DhkDr+b1HEUaTZlhEt1GKhGpEfiCZaAK+wZeaCaVD/OBlj8HRXOh+tUx
         Gdq1sP3E9SUXJYdzwZIcp39guqwpN70b/gzW4ZlmehgHfx2+8tvqMVqoUC5M+2MHVf
         DSmM+y5bRhNVGE0GJ1hM8qj4wQci+t0dT2V1gmBVIqWz5TyvRg6kZrPUGpu8Z5koOJ
         LrzjbYXZJ1BsaHmRtF/Q7pu/W8iaMZiDwHHcDL1YKxM8L3R2CU6pJNobMj4pOxD+KQ
         adAMGdOL731uxvYXht8ZIc5gHHXk93uUdF7gVoOZk1mt/gBn7vEjjWLUk8fqjRfdJO
         ZbUno2ED+U70lFNO18wkHoUDGJIQKvku0XJ/dzNDL1XELV96D5HEvDC/HWE9EHxrV5
         L4ABWTrYEQLMdEMJwUMuOAIOuOwVJ1YFdTZiZHNg6vuvamFvNs/
Date:   Tue, 9 Oct 2018 22:26:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 05/14] pack-revindex: express constants in terms of
 the_hash_algo
Message-ID: <20181009222616.GS432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
References: <20181008215701.779099-1-sandals@crustytoothpaste.net>
 <20181008215701.779099-6-sandals@crustytoothpaste.net>
 <CAGZ79ka97gq5Vc_rp675=o0V+kJgZXhkTX3Da72QRCZwQWcM=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/ZPAxgSw4JMezHmq"
Content-Disposition: inline
In-Reply-To: <CAGZ79ka97gq5Vc_rp675=o0V+kJgZXhkTX3Da72QRCZwQWcM=g@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/ZPAxgSw4JMezHmq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 03:44:36PM -0700, Stefan Beller wrote:
> > -       /* This knows the pack format -- the 20-byte trailer
> > +       /* This knows the pack format -- the hash trailer
> >          * follows immediately after the last object data.
>=20
> While at it, fix the comment style?

Sure, I can do that.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--/ZPAxgSw4JMezHmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlu9KwgACgkQv1NdgR9S
9oud7A//S359S9sntTKaP5qzasX7NDsqXhU4FlHMXY1KcLVq6DhrctbfemZ09qiF
aSZTEujPKhxh/7vJ6TKiPQopZIpEOnhOecr5IF6bxgb2fWFzO1GzLNqmGy11DO8T
sDd2Q7LqObpcDpiqBQa6CVFJhsDfd1UPlmJ0lY7bk6qa2DxStc5bQ3wph8qFKGEs
T3jzgH7iqPA7FzKtrO/yLqpnpm2p0JWwl+efpldBiJyLiJs1H9161NzZ0O2Ruh1v
XplepNwI2+K3muFy3emT9WqVYX1mtTUAHz6+VOtEUe3n/qLv19xcf5YnY9NM5jzD
VEyPEri0kWhRezgsAdSjqiasgJ3qFqlU7gAoT5BVTQr392wHRaMmEyH6IJdAF5n+
4EKrGxIkYy/TBP1RmBYNY4zUBKAmPEPrRLmJG5jAsrxK/Jk5vL9yL5jphzmVxaOz
ziz4qWqH3mQqHqQA4NV/0Mf1YJEBKuNtdEMphDf6CuIictbj1IIyNRj78TADxc3s
cqibQ8zvToM+oMNUPyeoKkRf6CtozKF5qmafL/3v/w0zTK2SbLcCsU9QTbDA8Xuq
hQm09EN5LYSYMgBKVr4AjkwL1RqdYdwSuAfs9cMRzSnIeVquZLQEA2BI/ozUjiuM
4V9K3EE0OzsM1hssRpYE+Gar/55ODP0rIcMeXNqmS5KJ5Hl8NJE=
=jIjC
-----END PGP SIGNATURE-----

--/ZPAxgSw4JMezHmq--
