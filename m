Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22DDE1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 04:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfBGEHY (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 23:07:24 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33792 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726393AbfBGEHY (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 Feb 2019 23:07:24 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:d42:63e7:5548:1ee8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A855060129;
        Thu,  7 Feb 2019 04:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549512442;
        bh=oHm/WJ5NN0vTug/RylfmZWQbRDI08dtcWVjX+MsEm6E=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qEeBYkh67X/rYKNhWU7JWK05LL+nAljfBCnqriHWtPg/tn3Fo1LXFoiHeR+gJeXDM
         mD6qNgjSzD8+UU08Lpq+OKwPHrBvpyYVu8p0m/3raa3w8WEHbiNVKiTNTOWI4+8GCS
         sY3RNFOtBdjKakQGgROX772x1TfGpp7ui++tzRprtMeU6aS01iI2h0lFWoYscrW82P
         EKW8VLJJ10XsrOE3zMti6cGzg2ij/vgfUX/Z5pidV1SUa6XQESKvcSAc+F5vRrHqC/
         Jk93nEiTH2xygoWh0KWY/ekAlpUudMGi+JspmWEvcoHvHfHD/UTT5wczuPRMQzFsAi
         jOB9piX26PbUe/sZGOpnwMyc9cpzzoh3pyP0SOKRQH7yemF8jTaBzJeeCIcexL9n6C
         GxCYOZoRjKm5lYc3pmmoHEeRCy9DKlr6IY0G33nSzdt/7X0R1emgJppshHcT7PzQUG
         dJmtJjyqtzc9DWM3b+f+QTI8kJZy+sPRgV0sedD7dRIFPJyn4WX
Date:   Thu, 7 Feb 2019 04:07:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2] fetch-pack: clear alternate shallow when complete
Message-ID: <20190207040717.GA11927@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20190204000650.686175-1-sandals@crustytoothpaste.net>
 <20190206235937.201663-1-sandals@crustytoothpaste.net>
 <CACsJy8Ae0ZZjh8+f+TwbfJ-V9SzrHpDFyfjwScwKJj+kc7FDTQ@mail.gmail.com>
 <xmqq4l9gs49w.fsf@gitster-ct.c.googlers.com>
 <xmqqzhr8qpfl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <xmqqzhr8qpfl.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 06:53:50PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> >> The patch looks good to me.
> >
> > Thanks, all.
>=20
> Oops, spoke a bit too fast.  As the previous one is already in
> 'next', let's do this instead.

That's fine with me. Sorry about the delay getting the reroll in.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxbrvQACgkQv1NdgR9S
9ouqvQ//ZwxO9ZTze1C3LLcTccJsTmmbjRHAmxThh3MP3ACvSyE8RO/GMzXRJs4Y
l9k8GFKSXlC06+YjS3jNanjlNr6Blfo1A3ROHnQdcZbnP2FmDEBU7BC7nMT7T59c
XQ71XIf2WBihcEdOK+X4FbSqSu2drev3n4jw0C2R317BL5rKuAu0l1dm9XnECa3P
aeVIEkERoPHUtALwKdvBlQwuPdI/5GZFW/dObAT5ci37gaTvMZXpt9TOzTXYb5DU
d6yoApJ7XSsOdlQCoi0o32eV1PpQE3kPTiCSfdE8mJ7uDDgkiXY2nmhUCmo0Th8Y
PjSxgUS0Kyk4DOi5hWly/iBcsv1QwqNiNPZHh6oiQfocBcNOpRF5QzQor/71cWQ5
pTXI27jLmT+80iSOILDYoQIcEzQUqemoMkTLA9y1NAoUJpP8ifXy9JpjUgiUKb+M
XHBqasNthOkxBBdvCIUF9go2hUIW4vexWw3dSk24bHNA5EUQAHJNbt19B0jUtGgW
M/9BT5oWOjUHTSxT21ux1D7zwOi6lUz7rQXpyhXWz4/O0sdRZmkVMSLA7mayQ11H
p9UA9a7UkwXs6Qg/FWXNKYHjg9R85b1nYbpc8KecQQZF7101abQH+AIzqPLK3HO0
8V/rnCgNra0TrU7JlrI8WeObLeuO3iOpq7jyjwFkJ48ou7MmklE=
=I25n
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
