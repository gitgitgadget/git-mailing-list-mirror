Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E25A3207F8
	for <e@80x24.org>; Wed,  3 May 2017 23:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751467AbdECXeK (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 19:34:10 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:36840 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751216AbdECXeJ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 3 May 2017 19:34:09 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 38186280AD;
        Wed,  3 May 2017 23:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493854448;
        bh=dlABhmvQc6VoUTLZqxYhgxYH5A+43154H824VpnBJBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UFqDAUU6vlEOic3tWyWPkOHNVrnDjq6qvR1U58zNNqDiBZ0XVWJbsPyitVCa/j4Sm
         Zm/MWrGTOLUK6itFLuJT7QnZCBxEd4xMqR/MNiNf9CosRDz2cHsxz8NPmQMrKByqOk
         2XWP0LJpSYy5ds5+wQuQIF7nFhMQMQ+S9/gPAMKOk0UVN+j/Kicm3hh/AC3Ob6VLbV
         gzgY4Or3wUy9kH7xuwN5CL+eqQzbim5mL3HrpLTlobkIiF1m4LDbfOxsIhWMHCVAAS
         l+5mOpqVOfEE5SkYJWzELSvNw+P+p0LS0zt8NXUi4iakqrv4Ra6Tuwj3PPDnP+/wht
         YrsPpj7IILz8Cidr09oonizvld9WZV4R9IKrvpmKT2zimxMdhP7HPtJxuZ+i/knLyW
         tFMpXwgUO3nm9jCpoYu1UIk1EeRpAStD8lNdy5DpS+W5JjKw/dxbcYLLeTLgxr4ydZ
         VZmvmm1HcUl8iVc+p8nZP5rIJ0JCqcWKA6OeMr2Ytpn42nj8Qzu
Date:   Wed, 3 May 2017 23:34:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 11/53] fast-import: convert to struct object_id
Message-ID: <20170503233404.muovcgxkopot5j7r@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
 <20170501022946.258735-12-sandals@crustytoothpaste.net>
 <165f4108-267b-f522-d78d-36b0064ee48c@google.com>
 <20170501222758.fzhrwg4w3p3ayxhg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ugu3f6q5xt4ams5v"
Content-Disposition: inline
In-Reply-To: <20170501222758.fzhrwg4w3p3ayxhg@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ugu3f6q5xt4ams5v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 01, 2017 at 06:27:58PM -0400, Jeff King wrote:
> If you have 40 hex digits, then you have 20 hex pairs. But delimiting
> them all takes only 19 slashes, since they only go in between pairs[1].
>=20
> So the fully expanded formula is:
>=20
>   GIT_MAX_HEXSZ +               (1) actual hex bytes
>   (GIT_MAX_HEXSZ / 2) - 1 +     (2) internal slashes between pairs
>   1                             (3) NUL terminator
>=20
> which simplifies to 3/2 GIT_MAX_HEXSZ. It may be better to write it out
> (the compiler can simplify) or explain that in the comment, though. It
> took me a minute to figure out that it was correct, too.

I did simplify it like that, but I can improve the comment and the
computation, sure.  Clearly my comment wasn't good enough to avoid
confusion, so I appreciate the feedback.  I probably didn't think about
because I've touched the notes code recently, where the use of "19" made
it more obvious.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--ugu3f6q5xt4ams5v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlkKaOwACgkQv1NdgR9S
9oujwg//V5nrZidcIJEWvkeePFhhMp4LaSIJhi3C7BNKtEc//R8yuGBVHew0K5Am
zbvDY+hOthLf6uFbhi9aGksb9E8WAv/cGN02BQ45kCZ9p8Pf60UtVkXfz0u5a5KD
vyEqJJP1xsh2FfaFFBuFb5hwmHBaXmXdEpcILKwRP0347qbJ89kbeZN+yrvHu/Hk
MKScgWOjgHuJpZSlmCHoAUhEf/lWn6mURDiTXQL3dQOz+/WdYfbxlZykxs9zD3h7
gpZULeilA7iexz8tqwjF2Nei5KkikEXpLiLjYc93wwjFcydQY4YnT0/jCdKI9H1l
UTXlQ4gpgCt4KKgA8DczeGys8lKQWBBRsvp0IqG5kd79g+OofVezue0/adT+Roff
+shk7gV/hMVgChIX6x+S88Z7n/cO9XD0AKJqZ8cW/o1FP4l5/IXh4JktpqT8T/Tw
zCWaU5F3MrUmeC21pawvCPnPlo0Xkqm2zIxVKu5uZ7kAPx9+sYKLLIE5eVAolTo3
iaQ0MINmLBWbyGuh/z1iKF1BFdXZVsOzouiU5gurYftiLNJ2nYuAfN29KfzwB+2J
pUSx7T4V9OLx2pa+rMC5JHkTBqRPIesJvhq2IJHfw9DquFv0kVP/wTGj+QSgS6Q0
IoUn3s2twVUhRaZdnaLDAS1XFHZjwbrQNdbs89QsUNIC/ohgBQI=
=J318
-----END PGP SIGNATURE-----

--ugu3f6q5xt4ams5v--
