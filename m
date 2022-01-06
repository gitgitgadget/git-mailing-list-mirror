Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14595C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 01:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344486AbiAFB6j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 20:58:39 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:59836 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344555AbiAFB6d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 20:58:33 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 2CBBA5B24E;
        Thu,  6 Jan 2022 01:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1641434311;
        bh=0CTZSCw9LJsq5MCtj/KPfQE8Y+CoUvBVyvp2J0qxTd0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=pBHMZbox1GLvoPNWBY2BFj7rj5Y9kGr4QyDNKGGi2N+TI6n4f7d5+qf7l44PBnjgV
         oGmlDLg0K4o7DUS/2nTEhRxojKWkfjiBU43UFqvJoR+Ezx8SG2N/zxW6aaB0JmWmN4
         p9N8zDR2OMCSNSBucRTyTuCvKFPA0tRFsJ0J8QFO7iH9w1PotsTv8boYdwQsDit4Uw
         Nx+0JQkG8T2aYfxnSdYypkMIqN1OdRmhXAKy6ViqnyfR4kRbWk55MGWM4KQdEqkIqA
         utDXGQRSPBVRK4AHYNL6Z/dHcYyIspi4IZDChfhPJcT/2Wbh0og1PrDzqVZkaOy23U
         858Jw0XcSTsb3DtSSCgDVNGGPRFhIYwvRFBCFeKDnu5+0/PZM/6PsWvuCoRJD9GRjQ
         NIe+d1nYVfiDT/GYGRcLI8/NZnWGr16JNr6y1Nt+v6yn6BVoowvq0SHBGk7SjA5UeQ
         mwVhIye761WpNhcn5vs8psqGRb/8qFuv/ZQCMGU2Jh+ft58y71H
Date:   Thu, 6 Jan 2022 01:58:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 0/3] Additional FAQ entries
Message-ID: <YdZMxeOSFQPYBmZY@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20211107225525.431138-1-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2201041453540.7076@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4a5Sh+S5DZxvolQw"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2201041453540.7076@tvgsbejvaqbjf.bet>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4a5Sh+S5DZxvolQw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-04 at 13:54:52, Johannes Schindelin wrote:
> Hi brian,
>=20
> On Sun, 7 Nov 2021, brian m. carlson wrote:
>=20
> > This series introduces some additional Git FAQ entries on various
> > topics.  They are all things I've seen in my professional life or on
> > Stack Overflow, so I've written documentation.
> >
> > I've opted not to include backing up repositories in the syncing patch
> > because I think they're separate topics.  We could well end up with an
> > additional FAQ entry on that topic, which is left as an exercise for the
> > reader.
>=20
> Makes sense.
>=20
> You hinted in the thread that you were planning on submitting a v3. I hope
> that my feedback regarding `core.gitproxy` is still in time for that.

I can definitely include that in v3.  I'm hoping I can get to it later
this week or during the weekend before my schedule becomes busy again.

I appreciate the thoughtful comments.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--4a5Sh+S5DZxvolQw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYdZMxQAKCRB8DEliiIei
ge1fAP9syaPHG3NWz4WDuc6iRbLCmWc43BOznqx6IvwLZoxc1gEAuiXg14rz3OwN
onh8TtsU4bnwgyIMFC25bea4hS75qAo=
=5C8r
-----END PGP SIGNATURE-----

--4a5Sh+S5DZxvolQw--
