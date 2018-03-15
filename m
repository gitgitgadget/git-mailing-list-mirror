Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E92D1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 00:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751428AbeCOAxX (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 20:53:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35870 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751357AbeCOAxW (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Mar 2018 20:53:22 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7F0DC60426;
        Thu, 15 Mar 2018 00:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1521075201;
        bh=rLi2pEfWPzJwDN/tLHAWCijTEUlopkutogb4R98FFrE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=I2/SS9YmXLTqeP1g5RSgmfyuThAvB5JkYMR9d/SrA35ajx996svCTn3zyVEEEWckS
         X/CC6oCDrXr3PeCOZbf7lWQa0j8deGcUdg9G8r7LO8Ga6Bj3s+ecjmceUtYkO4NDE0
         /0zENhae8yESdEWuFZxSlzZdrv83PYAq8m8KKxkyn/fVyW/Iqks5IGhm3YE+yc+pu3
         /U8slqWRs+mJbEmERdiQqehRnnCHK9z2Elc7zmMPpZ8FVTjCGRyuV8rdQ5itiLxgDS
         CVqn4PODpB1dBOaJlz77OxYlSTfs4n+elKK6QUUiO+brA7r8fKF+lA9YMEHJyriZLf
         nxh+aUVhy+UQ4QpM3AoVyHg0Xqbh3oe1VMKECJuDSYSgIHxnBx7TQ6pTAN8OklMJj1
         uBiqy++6axU2usJqjRq4Q4KEDJ2DXE3Pp9ibwi2u1VV0DGmQBS6VN+TdwVHf6WjMH+
         o5zvpsOBvr9lT4iwtM4yPwEj7N1giLfYnu1sR102ds3Kmzh18Po
Date:   Thu, 15 Mar 2018 00:53:14 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/36] object_id part 12
Message-ID: <20180315005314.GB330384@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Patryk Obara <patryk.obara@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
 <xmqqlgeuzhqe.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <xmqqlgeuzhqe.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-1-amd64)
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2018 at 10:31:37AM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> >     -+		buf +=3D the_hash_algo->rawsz;
> >     -+		size -=3D the_hash_algo->rawsz;
> >     ++		memcpy(it->oid.hash, (const unsigned char*)buf, rawsz);
> >     ++		buf +=3D rawsz;
> >     ++		size -=3D rawsz;
> >       	}
>=20
> Using memcpy() to stuff the hash[] field of oid structure with a
> bare byte array of rawsz bytes appears twice as a pattern in these
> patches.  I wonder if this is something we want to abstract behind
> the API, e.g.
>=20
> 	size_t oidstuff_(struct object_id *oid, const unsigned char *buf)
> 	{
> 		size_t rawsz =3D the_hash_algo->rawsz;
> 		memcpy(oid->hash, buf, rawsz);
>                 return rawsz;
> 	}
>=20
> It just felt a bit uneven to be using a bare-metal memcpy() when
> oidcpy() abstraction releaves the callers from having to be aware of
> the rawsz all the time.

Duy suggested oidread and oidwrite, which I can certainly implement.
I'm also comfortable with just keeping hashcpy around for these cases if
we want.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlqpw/oACgkQv1NdgR9S
9ouoPhAAuK2fIopQTrNCxvcR3yr4kav3L2rJ17SmsFqHfAVBOjObL7FLNoVYcWfU
6cz0sz88Qbo2ae4DzLACYJIoagI/osMPLaDjoaiRQaaxBmkeVId72lR2AWif73Hs
OX9bG/nW1d0UQWNEOVpGHxHdL5KiHVj7C23hDRMTYtitk7C/Oavq/KiGfoxAROs9
zWj52d1e/FtBw+RmTc9237+FpqhqO32ahiyVWptPqEuaHRldhLR7aO6HpeawEkxc
l6XYpgV+ASkCxpZgUvDtwUmTDQrZCCkvXysDRtZU2r7tCXs7olJibaVNJoLIDHIR
tM5elgiY7sar8QxqKC4G4JsRz7+vmyt5bmsLttlsttC079DYGuMJBzakkNtujI/8
Oa5oZwb5YxpsB2caAzXPX5mHYRnnRZ9+FB6lXjUdU4ayXx3D++AxbfeMVVPu/9PZ
2RWFAwDGn9AytJQ/DvJ15aTAfnvHraZSxEHAQsHmDuo2SvO4R6bzijmYtIK8OTK7
XApj8DO5F9xpZYyS7oUlb0B+emLIXj0uvu6jIUuKUboWcFGKQcCI0XQwVa5z5RFY
PwsfmgGuikWL30bwz3BvLBwYrj1jwnfMMLn2HYNTBXs5eeqwqrY1t2nH43Tt+Wee
PuCKZxBHQZtLrMtinjn6I/U9W/VisTnCksaAUUHTUPiq+g761/A=
=OQH3
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
