Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2E12201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 23:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934505AbdBVXpy (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 18:45:54 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40264 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933644AbdBVXpw (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Feb 2017 18:45:52 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C3ECD280AD;
        Wed, 22 Feb 2017 23:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487807140;
        bh=MQL6S1clWPxoojVL9iCoS+SGhpL3UGHyNi9hcEXrD3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=umIQho2os9DrhC4y/I1XVSAAFThvdHO7Gv4bxsuIlrc0xXIoSsXX91+mQ53iPjT7h
         cOcomqMupFHhM1TabN+inI1/4jRXqpxW3agWTTQCBhBjWtm//EeBrhlZ+llcbR/r7M
         pCdORcIygC98Lq2OsKWmnsVmBkIPgzVoSA9+YCpzg7I8eq0rNq9NjHFACFvCw1AQMW
         Rvl3I6iOAfJrQYhwVPYr/bh5ERwknDH5K4ShBT4hcZCRD6l6vfVPr364+/Z/gjxF/0
         XA3+yQxzeZrvoDz2D5Lzke7BjBf0W1YcclZpKWebivouVPx4ZkJTAD212P/+77Euwl
         WhCt2D0ptxxxL6MX+BtCuAr9EfXsPfUCUcPKod+2aWieyYZdxGE/lQFkZlpoAsOz0g
         sxXXDIBfjKVvW7Li+YckuEhZVEfWdwxHYWakSQ7tUqtKBqjI6M+GIHEbhQPXtb475G
         RG7+g9bVH88cGRVFHLqr/dbrqiqODUf9vNatimfeIefeMSGXj0c
Date:   Wed, 22 Feb 2017 23:45:37 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] t: add multi-parent test of diff-tree --stdin
Message-ID: <20170222234536.3x7crjodoyb7jrfu@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <20170222232215.u2agozagwsyy2ooe@genre.crustytoothpaste.net>
 <20170222233838.925157-1-sandals@crustytoothpaste.net>
 <xmqqfuj5aj32.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pyzsm7imbye3ps5l"
Content-Disposition: inline
In-Reply-To: <xmqqfuj5aj32.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pyzsm7imbye3ps5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2017 at 03:42:25PM -0800, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > We were lacking a test that covered the multi-parent case for commits.
> > Add a basic test to ensure we do not regress this behavior in the
> > future.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  t/t4013-diff-various.sh | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > It's a little bit ugly to me that this test hard-codes so many values,
> > and I'm concerned that it may be unnecessarily brittle.  However, I
> > don't have a good idea of how to perform the kind of comprehensive test
> > we need otherwise.
>=20
> Hmph, perhaps the expectation can be created out of the output from
> 'git diff-tree master^ master' or something?

Okay.  I'll try that in a reroll.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--pyzsm7imbye3ps5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAliuIqAACgkQv1NdgR9S
9osS+w//ciNTO0yzrGMEtLGMiHvQOLm/zgjlzg7ba3kuwdSZ3GutqadspWdhQ++V
dQkzl9pEEqjAWxFgFGqDhB4ais3OZZ0+COtb64DUqSShayKT/USvDYFooEiXP2FK
RuAvtqmkdtQnCZ/BBfK6Zfpn+7I8K/kaJgX++CiPXRKbOoMlDmgbsjRsGbF66mUF
eK+OjkfRuasUPJUODOPLIlHFuFMEp8C+0HGIEchMldz8YJvVpKke9HFRqLmrUtSD
N2tHFbjhoARmJOXTqFV9sowo6h8EV0RcpnNhZl709pBUVhNWFrQ9+Y525i9tApJs
UB3miJUmVPvR9ul0zjRpctuI2WhaYn1Hp41vbYdZM62AazFB3T1uBse0cZpPiGGd
+O8E1UdDMOYWkzdWuRlZJAKKpZQicSoW330HESnMAvnZ0o6juhAO6JzHnOryOzhz
0xjtZSZdSWICsXkAQbynyx15lyJplNrBEa8fpG0hhu/Am0bXSOFb/CHv88I7oQmU
oj4tw/VdS8o18UO3raZf2Ugpx0SKLiPXdNDXGkAbhyVrQ2JtidMdHwDRO5cB78KN
uw2HbxozL4JqjVNEFXuJFPO+wXk2tqoAFkgdHTkNzguD1J/O9RS7mLYvIxmE19DX
io1Uo+M3AnEb0GcQmIaAuvheyRegVGFAfdgkWl9uP6HPdaK+lWM=
=R29S
-----END PGP SIGNATURE-----

--pyzsm7imbye3ps5l--
