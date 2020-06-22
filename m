Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F44C433E0
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 17:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC51B20732
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 17:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="bCQ5a+YX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbgFVRqr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:46:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39958 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730005AbgFVRqr (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Jun 2020 13:46:47 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EB7C760436;
        Mon, 22 Jun 2020 17:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592847976;
        bh=m5kMKFngCOtNQW/ijZreH7UNRyYPtQSBUOkPyXfX96o=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=bCQ5a+YXDSlOpxCUyb+FyBjOL2E8q8rdP+JxMgsLE0SiO2C/i3bKvJ6alqhv6EAkC
         eDIb5l4oEU9jl9FyFJ+qHRlW174FpwP0dDAiykS2w5sRLbdgShLnt+RVx60Hf8zEZg
         FUwrcED8EU40zyJbyb9Oca3e0K4YjFRvhfVWZH5poWMN7wWL1Igm8/azyaV+n9f55e
         LWAypvRgjKqWGF7rY0G0/9xqZkn5ryInX/ewavudns176k4DPVeFLyuBCZzQIgs01s
         CcmjMENIoEe1Un8MSFHLtRNI7Ppr/mPiVV43WbhjPnuzVp9pUumzFDvOcdE+NtTjpJ
         ViedzBnNerUGpvB1DRy0lKqz/WQrg9GemIaref3dD9Wi03mPsPMNVIYTFezRanqOuD
         wCVQs+CMb2aItfQW5nkaDr2ZvnJ4QH1S3Pt+c8XsJ1wcqJoyFriIFFC2Ympm0uzCxw
         nB2J9Y7KOSKmpX3IVsURhswiEs9aLpCFkZpDB9bO8kqmHSC56EY
Date:   Mon, 22 Jun 2020 17:46:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Matthew DeVore <matvore@google.com>,
        Eric Wong <e@80x24.org>, Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: [PATCH 00/14] SHA-256 CVS and SVN patches
Message-ID: <20200622174611.GM6531@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Matthew DeVore <matvore@google.com>, Eric Wong <e@80x24.org>,
        Matthieu Moy <git@matthieu-moy.fr>
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
 <xmqqbllbdoym.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z/kiM2A+9acXa48/"
Content-Disposition: inline
In-Reply-To: <xmqqbllbdoym.fsf@gitster.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Z/kiM2A+9acXa48/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-22 at 16:50:41, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > I recently sent out part 2/3 of the SHA-256 work and then I realized
> > that I hadn't built with the CVS and SVN adapters.  So this is part
> > 2.5/3 (or, to be pedantic, 3/4).
>=20
> OK.  It seems that at least the early test-only parts depends only
> on what is already in 'master' (there are uses of "test_oid algo"
> and "test_oid rawsz"), but let's queue it on top of 3716d50d
> (remote-testgit: adapt for object-format, 2020-06-19), and merge the
> part 2 to 'next' soonish.

Sounds fine.  I'm about to send out a v2 with Andreas's suggestion (and
therefore a slightly smaller diff), but it should be a straightforward
replacement.

And yes, that it was based off master was intentional.  There are no
more test structure changes before the final series.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Z/kiM2A+9acXa48/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXvDuYgAKCRB8DEliiIei
gRekAQDZP/jFCkanqm0a+UyFDm6GsV2i3MIKBVGgrC6c2OlUOgEAnJUbsv08EzuJ
wysuhr5O4GHpRMTkbiFaG1JPvi418w8=
=ed3R
-----END PGP SIGNATURE-----

--Z/kiM2A+9acXa48/--
