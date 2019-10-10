Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A40D01F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 23:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfJJXHX (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 19:07:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40466 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbfJJXHX (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Oct 2019 19:07:23 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9ED5D61C69;
        Thu, 10 Oct 2019 23:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1570748842;
        bh=qR7eO36XRPNe6f12sf2dM+yJ+MDiB8yv16K3pqpVu8Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=oannhLO1+vRKvVmvs9IVDKnL6cHkoGc3cDWAzSjUxb+EMsn+St8FAZeDyzs9NAPWV
         axvPboSZn6ElYk6NKYZRIlXZ2VGHb/Ll9fsgHgi5atz58doT/9piP5z9g/9uKCQV3g
         i6gj7ExLXwX+q+5zVcCOqYaj4F2d5DAJtWfGk7bT9a2jtmYK+xKK9nJzh+4bDM+QO3
         cStuH4URN+wOGCwdYhrbOTQBm2mPjU42icW1Z7g4noUvMlRX1Sy3GAphwK0PHoRx0R
         sguqeNZK2VUCgDiUA7rtM+0FleG0AcInuAEx09b7VCVt8G7B9DLEjYc3pz5+AIlgYg
         EzoiunDv4nqvE9quME/ZKgBAYwn2VWCocZ7m35w/NtFcvpLq2pNPofv5U1Guy1DqHI
         vEtwZLvTwoBj6mdQVYxpQi8FaWeQyv1jtaqhRqthBrkw8VJP/RYgF/9iNi7s71BnVE
         UPemqh/wsXmPl3JxEZrc+tAntbHggPPo0jE1v8qUqKT3sejWWmn
Date:   Thu, 10 Oct 2019 23:07:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Toon Claes <toon@iotcl.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Zeger-Jan van de Weg <git@zjvandeweg.nl>
Subject: Re: [PATCH 1/1] commit: add support to provide --coauthor
Message-ID: <20191010230716.rylvyiyqu4gv4zcc@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Toon Claes <toon@iotcl.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Zeger-Jan van de Weg <git@zjvandeweg.nl>
References: <20191008074935.10972-1-toon@iotcl.com>
 <20191009014039.GA10802@szeder.dev>
 <xmqqr23mlkxo.fsf@gitster-ct.c.googlers.com>
 <20191009203105.GA7007@sigill.intra.peff.net>
 <87sgo1q92k.fsf@iotcl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vng4ghznpwuw2lks"
Content-Disposition: inline
In-Reply-To: <87sgo1q92k.fsf@iotcl.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-trunk-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vng4ghznpwuw2lks
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-10 at 08:49:23, Toon Claes wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > Yeah, I'd agree that we should start first with a generic trailer line.
>=20
> IIUC you are suggesting something like this?
>=20
>  git commit --trailer=3D"Co-authored-by: <coauthor>"
>=20
> I really want to consider this, but I do not understand how that improves
> the user experience compared to adding that trailer manually when typing =
the
> commit message in your $EDITOR?

The --trailer option to git interpret-trailers knows how to interpret
configuration options and expand them.  For example, you could
abbreviate "Co-authored-by" as "cab", and if you used that alias, you
could write "git commit --trailer=3D'cab=3Dpeff'" and then have your command
look up "peff" and find the proper identification either from your repo
or from your Git hosting solution of choice (or wherever).
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--vng4ghznpwuw2lks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl2fuaQACgkQv1NdgR9S
9otNVQ//QxKv675Wfu0uHlW/5oig1QNDSGqbKtV1XoQ+wGXWYjgIaGKISoq0xw4f
Q13ZjJNMhGGjPJ5ANVypoOdpvSuSy5m/iaKzZHxC9ZXi8eR8H2YwKqGw+Thu/RN1
9ILfcYEhzY8U6kWTLRMJsrsKMck0Zjtl3yGHgHDNV65XgmvFaV87K6mfuZmSxgQd
i+8enmXeLKJJEOkkulKS/lQha1410DDQNaDlI4LVRKlS3vbrenudR0AysG7rJcT3
G7NafD6WbE+UR+LNOcmJS6eGhDGpq5TfN3MDGnykSJSqIX7nathY1IAO86s+lq8R
bwOVomA8JoMR82qpq/tJyP3E4EGjq9WTl2FUSGOqjSHJYXihlfcVwEnm++yDfDYM
1XGxsuXpCEzUZLi8rtv6rgrR7JtFYAriaF07GTXdgKMLQk8naIe8xS8W+5QOxdXG
Ff9drufpDTbJ3SBFDG6gTLUAjGiDvtq402a+FHfECK3Kht85TNZBX4nJ/IPHW2ZY
4f3qqc7diP4PkdiLju92+yiR5w0aYWE16wVlkcmhPcaemfZxOuZymVele+mQdQHC
5AlG71KZN6bvMijkGMzw97VcLa4EhiCmKPwg7UK7UK0Eulc2k0PRyxqT2xokzwGH
U78DWUmCpytlXhUJjr2PX0Vo+Yig08+qa7R9V94xEMfzrDJZPYI=
=nWf/
-----END PGP SIGNATURE-----

--vng4ghznpwuw2lks--
