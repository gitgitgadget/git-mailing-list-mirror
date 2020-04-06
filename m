Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B2DC2BA17
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 15:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075522488B
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 15:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Xk8RwdCM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgDFPRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:17:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51590 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728667AbgDFPRk (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Apr 2020 11:17:40 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1352960734;
        Mon,  6 Apr 2020 15:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1586186259;
        bh=ggxnRw6pLw5s7XTsBe6dzaXcum/AFROqzR7AKDzgWfI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Xk8RwdCM00HnTlHqlGk4O3Xn9oN2c9Cyzt2pyDLwYApFyIZN/X4dQ7H5BHvOFbWdt
         LnuNEMTKh/DBzUgV/rVuYBLyDRJjjfJwPozyzdSVG4ewhRwJaKzK4CY6D1x0wE8XtN
         cdRDA9yRG+J9R+FHn40lXfEO4bsP6LKs5nafBqsjic1NZy9Dm4jFAPofYQbCGt0Js3
         krsswtq4gqEf1f/VbthBmcsw8RfME3ceBZFXFiqOgV4BYeu0eA/SZ9RS1fGK+X8cxA
         Be1kqgFAb/kgvrB7dCcqBFf5RCJFX6ZbAvDCx9N7hZMBXvHx6fHDYqufqu4i0nmICu
         YXiL91KfcD/5wOed0jyct6QrJE5+mAUWbMJc8FmTDAJ2d9Tb5aZIYpXe9zVHLSNJBV
         9YHG4OjYekb4m26/uynVv9nl0Bc/HLSznSZ+KZWAOmPjkZ+8hdsFVbLik/MnlZeIGa
         5HM3agVXG4EC/Lkkaj9vZJECig8KERvC8JpeBqQJ+sWySNdoAT5
Date:   Mon, 6 Apr 2020 15:17:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Emma Brooks <me@pluvano.com>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] format-patch: teach --no-encode-headers
Message-ID: <20200406151734.GH6369@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Emma Brooks <me@pluvano.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20200405231109.8249-1-me@pluvano.com>
 <20200406030444.GG6369@camp.crustytoothpaste.net>
 <20200406133040.GB1276@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YrlhzR9YrZtruaFS"
Content-Disposition: inline
In-Reply-To: <20200406133040.GB1276@coredump.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YrlhzR9YrZtruaFS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-06 at 13:30:40, Jeff King wrote:
> I suspect this is mostly orthogonal, as that deals only with the
> SMTP-level addresses, which include only the actual email part (not the
> name) and aren't RFC2047-encoded anyway. It looks like we already leave
> characters in addresses untouched (I'm not even 100% sure that RFC2047
> allows modifying within the local part of an addr):
>=20
>   $echo foo >file
>   $ git add file
>   $ git -c user.email=3Dp=C3=A9ff@peff.net commit -m foo
>   $ git format-patch -1 --stdout | grep From:
>   From: Jeff King <p=C3=A9ff@peff.net>
>=20
> I did wonder if there are any standards around 8bit headers. Certainly
> the de facto standard for local tools (e.g., mutt reading a message
> you've edited in vim) is that they can be treated like a stream of
> ASCII-compatible bytes, and that works pretty well in practice. But if
> there's an IETF-endorsed method for 8bit headers, it would be nice to
> use it. For 8bit bodies, we're able to give a content-transfer-encoding
> and a content-type with the charset. But I don't know of an equivalent
> for headers.

That's RFC 6532, Internationalized Email Headers, the companion document
to RFC 6531.  (The RFC editor has cleverly kept the last digits in sync
between the RFC 532x and 653x series).

The basic summary is that header field names are not internationalized,
but the field values do allow UTF-8 if they contain unstructured text
(e.g., Subject), anything using atoms (e.g., Message-ID), quoted strings
(e.g., local-parts of an email address), domains, and a few other
constructs.  RFC 2047 (MIME encoded words) is allowed "only in a subset
of the places allowed by" RFC 6532, so just not encoding should be safe
here, as long as it's UTF-8.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--YrlhzR9YrZtruaFS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXotIDgAKCRB8DEliiIei
gYAxAQDuxQxzQBpt+SgY2wq8tbEhM5QsiJgQLs1RF7s4fYBoqQD+Nty0LSrbD7Xg
Ko3RZHJH82EXCt+eEGPgBKs+sxDzLwg=
=rQgQ
-----END PGP SIGNATURE-----

--YrlhzR9YrZtruaFS--
