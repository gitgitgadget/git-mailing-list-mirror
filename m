Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D345C2D0C3
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 21:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D30320828
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 21:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JRLTN/en"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfL0Vff (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 16:35:35 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52580 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbfL0Vfe (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Dec 2019 16:35:34 -0500
Received: from camp.crustytoothpaste.net (wsip-174-77-115-162.ri.ri.cox.net [174.77.115.162])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1D8BE607E8;
        Fri, 27 Dec 2019 21:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1577482534;
        bh=UfNMgdJP80ux7w4stu0XNthcwCjHXiceop3cLJXNeOQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=JRLTN/enuUKwzb41KA3ugfDnkKR9qMxVWLO1TxKTY2Iq0GH2Vl9XVFxRhjEhrtGYe
         t4oyDniE6TYy6a62xT5h7uwkY22eq3FKEsRS0HZ9ZcDQ55dWJGujuEpPsPbpX7rn/k
         7Bfug2al1A1ok7Y5wK92XWdGw1LybLVbz80I9O5pi0iaNZ+bBxrZaImppEEYOV7yBs
         qd6BM3Di1RzN19Kp4nUvUgyskRBdNucFuWfzuGK3aJTHpGk9rQCGWGpc4LJmLFyzoo
         OeVi3SKGTuijfKxjvY0+cm92ZUXT/hqAFo8/0lTMUC1nEFpHzVTzA6i0xn4tmvS49J
         Ym2uCTbSEgb5ZFLCj54xmLoFfDfx+4NJTZ7IUiyV80XjQiPYMav/1s3byXsap6byJG
         PItedKbNIT6RI6ASgftmG2OTp+2rXhbBrnXoTHmtX1ZeXQtpkDFaic4c8JNvDtwc4j
         YdwLjZNX11qefS3gUGw5ggS0c9XZrmVrgULfiNmVqC/n7gWVY0R
Date:   Fri, 27 Dec 2019 21:35:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/20] t5319: make test work with SHA-256
Message-ID: <20191227213528.GB6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
 <20191221194936.1346664-11-sandals@crustytoothpaste.net>
 <54d80d36-f9b9-1c92-faf0-41bbcbe0a133@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline
In-Reply-To: <54d80d36-f9b9-1c92-faf0-41bbcbe0a133@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-12-26 at 14:50:09, Derrick Stolee wrote:
> On 12/21/2019 2:49 PM, brian m. carlson wrote:
> > @@ -387,7 +401,7 @@ test_expect_success 'force some 64-bit offsets with=
 pack-objects' '
> >  	pack64=3D$(git pack-objects --index-version=3D2,0x40 objects64/pack/t=
est-64 <obj-list) &&
> >  	idx64=3Dobjects64/pack/test-64-$pack64.idx &&
> >  	chmod u+w $idx64 &&
> > -	corrupt_data $idx64 2999 "\02" &&
> > +	corrupt_data $idx64 $(test_oid idxoff) "\02" &&
>=20
> Sorry that this was not a better-calculated value, but
> your approach works well here.

That's okay.  I appreciate that you attempted to make things robust, and
the documentary value of the variables was helpful in fixing these
tests.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4GeSAACgkQv1NdgR9S
9otUhxAAkRTKg/UE2kPgY0mziV4R5ninhlWo2OikODTyR8JlreVA6PRX+lZXt2H9
biIRVD8zKmQDi0NokrN+XIxzRcngfxZRr7Db9wVHs1C3zfMCJsZnoYccotCWfd8D
Lrj1Pr+VzwJAUToOzFrbOSI2CC6jdRQQ+H/UFSjEJD5CEezYKOjfdljGg4EabjXP
2KPpXoVWT2LT1h+iLwFU8bxXUj2l6rSvo6hfzV8gxG0+IHfbNcG5mB9Zwdc5y568
R0opx5ukEak4E9v3jYpq5dtCiX9f7mRVieHF12ePk2A0jA/LyLJ0GkaPA9/zCGbv
mXIX2YZmUahuB3q3G189gx0p8rAtrP7YsOFnKxqGqVIU4mN1ZiNgHr/TiIM03maG
fwExAFgOzeOmQteT8IQ1mfZ7UxjRQAhJMRil6uaknm3Ssb3TuUqW67EIHHRmcs/I
zUpamhT91HrhM8PPlde796np5tqhMcV66mKlTO7l+PJx1LQAubI9Zr5N2GdWYWnF
AAzZeLC9JNqRgn6l01aW93Phn0wH0XaFsOhV+zaCcIVlR+6Ro0DPS2WOdaF8Or//
cMtGweMXbgfOleeQxP0n9oZeeRB30YxIyBLIUeqVwqk3WZ3qVRoee5baAtB+87hF
VdS4Of0dcWyedNXqWORExaet7ZrolS05d3XgYnY3dvzwvi+sw4Q=
=neZx
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
