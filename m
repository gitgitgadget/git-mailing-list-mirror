Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD2BB1F424
	for <e@80x24.org>; Sat, 20 Jan 2018 20:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756652AbeATUpF (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 15:45:05 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58172 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756615AbeATUpD (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 20 Jan 2018 15:45:03 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0E5C860402;
        Sat, 20 Jan 2018 20:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1516481102;
        bh=xKIopeUL0QS0jg+bmY0hf2WCkMFjpybttts9s6xogA0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Ak0ZLILhuigA42TYJcaN25ejOUlmFTPiMyX5auMr0CW3kx+lnBX+4hClrJBwEAp+7
         8rzlgwE8mN3U2NHUXKEuATyWnhW9emdAdyn2/ZZ/dRjIPqG2dc7uA7nRHM2oU7gkHB
         3ocPugU+eXAtUa7aDJju8ByQZvymMqJnvCx9lAJFj49/98bXLOjUszSR/KOwUB1RjH
         nClfyXjLvp8Y4Ttp/EMgTwZgRADcX1GMh/OGtEeJchRQ5gCsSeYnYrLLpC6CHVke7z
         ARCVZsn5R4Uq7Nn+jIffhAAhci/Rb9SNEO4ij9ls6yXJ4eT/ZrNzc+tKDRg8gsb177
         rh+q1gW5rF4k2UPMSrfkIjS7fi4Y17C3333P0bap5I5jKVwuqfDAfdEcRDTemmUTCL
         o7HUFuJ0dGI6jt+BS0AiRbab6WjEpVlQfSCruN7c2OARBccAOZiUKnOf/fexxaeu1B
         wNNRSvVGtVEoFmWAX/1KY/rX+RO+dGjGVSN5fR3uZZpqfKQYBhP
Date:   Sat, 20 Jan 2018 20:44:57 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 11/11] sha1_file: convert write_sha1_file to object_id
Message-ID: <20180120204456.GB8965@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patryk Obara <patryk.obara@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
 <0d554b5efb35b7570fc1e762c9035556423d3da3.1516282880.git.patryk.obara@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <0d554b5efb35b7570fc1e762c9035556423d3da3.1516282880.git.patryk.obara@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 03:51:03PM +0100, Patryk Obara wrote:
> diff --git a/sha1_file.c b/sha1_file.c
> index 88b960316c..b7baf69041 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1420,8 +1420,8 @@ void *read_object_with_reference(const unsigned cha=
r *sha1,
>  }
> =20
>  static void write_sha1_file_prepare(const void *buf, unsigned long len,
> -                                    const char *type, unsigned char *sha=
1,
> -                                    char *hdr, int *hdrlen)
> +				    const char *type, struct object_id *oid,
> +				    char *hdr, int *hdrlen)

It looks like the indentation has changed here.  Was that intentional?
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlpjqkgACgkQv1NdgR9S
9otW/w/8CECXmj67aNU4R7VvzotiCYWwwqb9YOjaTqv0y+upPVUF+3d4Uxt0XNub
lFU2Ym//Clh1psi93a+CjHuLcWDiPcaSb7iI0u4ouGTVWhHOnJB+NnnI+NP+RhS9
PUy02SQ9gA7HjwKXS+S9hpuOsxU54/Buk86iXHIXFGH6mq1ToNA76oEhHi8/ZrGI
b/T/knKT5uhxQ2xHDLA178UNxcZtEzZ8Ut2u0QjsszQ1yKFJJ3xHPx9KDmpRYCdg
qh4vn6Ft3FJhqP2uJwAE8umt6lpEIybMlYAmczN3y0J2sKI9+VV26DFLVUbvPRn/
3KQd6A91kJd+Xr7ZHUiqaAwinWTrMq2Luej6NN2z2q+lU2zDXVamfHGipLyfrgVq
ljmYuIOO3ojwsLqaNeiArdlnf2ju95J7nQuzW8R8GQqt1AVSyBedlOGI5IB3U3Oq
RziMvr2MA6GatNTaR30GP6iRsBb4s0xDZv7FDxXEWmVy3/CnESYMZoutewClh4ML
oqW3ce8NU8aAq8KJLy4HQbVOzrwckSxzJ2k2CD40XEHsftgBWNIYFkcnRLK/7dSz
3NDchTdfs9rloxRalyBRPe1V+yBz+xsNnUVEBHpSnvRlemYMpf6M6+S3STPmMHbB
m5p/t2X5eIn9euPoBG002CuJhgR3wSymVoUKH0hK17D6roluVvA=
=kwkS
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
