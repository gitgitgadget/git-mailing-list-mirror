Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C1B9211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 01:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfANBaY (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Jan 2019 20:30:24 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59038 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726640AbfANBaY (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 13 Jan 2019 20:30:24 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c162:ac20:e47c:bd21])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C7E736042D;
        Mon, 14 Jan 2019 01:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1547429422;
        bh=/LcPFx2Hw0SpNmAOEymNoHGkdsPS98KDzpIIPbuc4HA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=jhLhUsuxd7JkCyaB7plLmLIjuOZ1garB/gl44j2eJQZgJ2i3ziHyGl2u8ED4/oj1T
         pQ3rrGrIfPIIKngxHKljz+LHIIMatiSgUIsnZqHxIGr+2Ll5Mv7YsqDi7pQxZzxE6k
         jYmZ9iOmm+l9aqEJjZfxphQCCspG9A5KQVfetJYWQuBSBeDYZ0ZffzbcGcEKJfQsN8
         YexmIlY4ZdvtX+jxH7k+HdzBINGWfphmc5uP1Nzf4KJYxFk6i1//ic7RhKoJMNWCYw
         Pl4qZ1Sd+ivunOfZkt7wSa6DvJ//B6rXZ/+NNfAvlIedq+I+1Z83wIAa12gRosVb+Q
         vw0Fgq3MG3XcyJHghKgpNy9FDDmE+SLdea9UNO+7gEMM7AF62yukPw0jWIgt7r9S2+
         Ss8k06wxIQgi0HRxiF/Ehh2SEOqoqjoIz6SqYwSuSizl+J+trimz6uEztoxLbP+3CM
         Jo/PByKqhF/TZRJRNEECMkMjyAAjiqRP2LUTyUqG3Nw/yCixjmX
Date:   Mon, 14 Jan 2019 01:30:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] match-trees: use hashcpy to splice trees
Message-ID: <20190114013017.GP423984@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
 <20190110042551.915769-1-sandals@crustytoothpaste.net>
 <20190110042551.915769-4-sandals@crustytoothpaste.net>
 <20190110064520.GC20497@sigill.intra.peff.net>
 <20190110235551.GM423984@genre.crustytoothpaste.net>
 <20190111145106.GB16754@sigill.intra.peff.net>
 <20190111145446.GA31518@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DMLl6fZPX8o7hGmc"
Content-Disposition: inline
In-Reply-To: <20190111145446.GA31518@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DMLl6fZPX8o7hGmc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2019 at 09:54:46AM -0500, Jeff King wrote:
> On Fri, Jan 11, 2019 at 09:51:06AM -0500, Jeff King wrote:
>=20
> > I think rewrite_here needs to be a direct pointer into the buffer, since
> > we plan to modify it.
> >=20
> > I think rewrite_with is correct to be an object_id. It's either the oid
> > passed in from the caller, or the subtree we generated (in which case
> > it's the result from write_object_file).
> >=20
> > So the "most correct" thing is probably something like this:
>=20
> Of course, it would be nice if what I sent compiled. ;)
>=20
> rewrite_here does double duty: it's the pointer in the tree that we need
> to rewrite, and it's also the oid we pass down recursively. So we have
> to handle both cases, like so:

Since I took most of the patch you wrote, may I apply your sign-off to
the resulting patch I send out?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--DMLl6fZPX8o7hGmc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlw75igACgkQv1NdgR9S
9ovz5w//TsWURBuPCpJ1DfcNPC0cr6lTDSvDypZpXmMdn1DKoZYrpLm7gOWQB4i3
oyFYq53j8s0t4VD80RNddZOZVN7Ut7amQHBFPlqUUZm7jfHanw7KTmFhYUJsCUyv
5a2PWn8mX5s65wCxd7MVxxmiEQgJUplGR5Bh6iMYYfptJVKnweke5zzHw7WUT9O8
5y+S7qMNizGDKMzNTm0M+vG6gYWdADeS7Zp0q5AAai0p788FU3Wl+dCT5Mxct/79
4TkmA+ue9BXgz3wcx6FA1qULKSHhZQQDl+mIvByFegPgwnImDkAGSFr5U3zBmBgE
D2IBqXa6KkGCRuTFVlRHhoq9e/4bO/s3HfZDWxeco+YZUBM29EwL45wPOBPcCRij
EhQjyh3gZs/XF/Psle9kG9ONtlDjem/feZqpCFNEnuxriejBI670yCz396EeiOf+
fadBHmVb5Njlir0UOh8tUDWi1PuWS9MPtVpQwpUO1DqHVJxTAmtT1RU1WiwPhsgq
Ue5xlJStlW3r4XFQe6oJMAMLIG7+XCCoAJU2v4WGgtQsdcoEYWcfbdKkgY4pmeyo
0TJ6kRr57hS3APIqniEZfdfDmajjFHdqBTBAxNHai2PgX1pLyYmaUIMGm6HV3Uyd
9isj1m5vHcAJ4OC5xod5uK8xsptcAwJZsxCe3mAWuTAoNOaB0zg=
=qBOn
-----END PGP SIGNATURE-----

--DMLl6fZPX8o7hGmc--
