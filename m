Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30A5C35240
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 03:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA29D20CC7
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 03:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="y2+oYwTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgA2Dxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 22:53:40 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49216 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgA2Dxj (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jan 2020 22:53:39 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D90E260482;
        Wed, 29 Jan 2020 03:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1580270018;
        bh=EroFG9xbG3v4ZqASwii47zxGyu9H+cfYbXxa7w1KAyI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=y2+oYwTKrJ7i/nMZLWxq5Ankqky45sugO/Ohso4WeeLG8Ol60uPc+gLWx1VGaGbRS
         v+RRR7AqGbYMDOqmXw+cd27y4ANSmWUkc/r21UD5Jt/HhpZN3PIHbktXnLnqVtopV+
         jrb0DMghTHshpW1jjBT6wO+Zx4JzyyNZFQuMrIEw6haOcdUraZBD3A5KXJeTsueWfG
         6BhWLD10mgL5GXBQdtzJWqDUWGCELJQmgMgHN6+t+wsYiqqpr4CdOpv8lkG/yO59HP
         /EhzEk46wS5vCSWl00J9NsAnZCErsmV5fNzKcWaABbRfT8PFOCsWYPMKGphfsbZyqh
         XyX1wmef9IrOR6iP9S/Ubm3I0T9g/0Yt4aQLyyQ5WtBJp9CWd+Us1gLJ+uGTU4r1Bz
         Nj/cRnLOcqW1JQrL4jzcGEGfstnCvLpROu0+doTgBcyQjizIq0l6tyLa9wu1oiUFP3
         PP8byZd6Urpg6n1cM/WwNYwyT4iyZ2/bf7eYsJaSO4xDaJrbKMs
Date:   Wed, 29 Jan 2020 03:53:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 17/23] t5616: use correct filter syntax
Message-ID: <20200129035333.GL4113372@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
 <20200125230035.136348-19-sandals@crustytoothpaste.net>
 <xmqqftfz8kpy.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y+Z5jE7Arku/2GrR"
Content-Disposition: inline
In-Reply-To: <xmqqftfz8kpy.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Y+Z5jE7Arku/2GrR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-28 at 19:06:01, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > In the setup steps for the promisor remote tests, we clone a repository
> > and filter out all trees with depth greater than or equal to zero, which
> > also filters out all blobs.
> >
> > With SHA-1, this test passes because the object we happen to request
> > from the server is the blob that the promisor remote has.  However, due
> > to a different ordering with SHA-256, we request the tree containing
> > that blob, which the promisor remote does not have.  As a consequence,
> > we fail with a "not our ref" error.
>=20
> Sorry, but I do not understand this part.
>=20
> The object name of the original blob (which is the only thing
> "promisor-remote" is given) may sort earlier or later than other
> objects that are missing in the "client" repository, but it is not
> clear how it makes difference in the final outcome---even if the
> blob is asked first (in the SHA-1 version), wouldn't we need to
> fetch the tree after that, and wouldn't that fail?  If the SHA-256
> version that happens to ask for the tree first and fails, wouldn't
> that mean we need to fetch both anyway?
>=20
> Is it that the current test with SHA-1 is broken in that it lets the
> lazy fetch fail (due to missing tree) but because the failure happens
> after the blob gets feteched, and it ignores the failure of the lazy
> fetch, and only checks if the blob got fetched, it happens to "pass"?

I think Jonathan Tan figured out that my analysis was wrong, and that
the issue is that the larger object ID length causes deltification to
happen.  The test assumes that the tree is sent as a non-delta object,
and when it's sent as a deltaed object instead, we fail.  He explains
this quite well in <20200113202823.228062-1-jonathantanmy@google.com>,
which you seem to have picked up.

Since my analysis was wrong here and he's provided a patch which fixes
the issue in a much more robust way, I'm dropping this patch in v3.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Y+Z5jE7Arku/2GrR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4xAb0ACgkQv1NdgR9S
9otSthAAt//+ck2TxQGAXUTjwrRRsZnJ/xklqI+Df8EFLZ67d04ZPipvfzx7Mwr/
VeiwJVTMf98nAJ7n4wmtgaDnthCIyxO3E3+wtn1tMCvG5+GpSx6UGijxilZTQ3Xf
W0qWIgwp0xwIbF/5RaY4j0q3CqKWdfzRtoTzGdlC/N3xVyuyb+qquDOrnZ9DZLb5
P7eGXL7oBeOp8VK+ESxwrDQTk6z3Fxo1S+iyyCDV8zxflnUtnEV2e6rT0Z3CAEnd
It4N3Ll98gCMvNz1dr22H8JJ9uMcJp240FOlI8/Po9m1IUEV/uxIMGGvcfb6K71H
GcE3ewT0tftR/CCZP6Of9aBNlS6ZmEVF1lJpTwkIuQEy326Alr1rV+6Sas3/3ckj
DgHIzAY+Sv89ScWGoPPjg8ozcUC16Bw5wwICo8fIm4BgIS6ohTYDddmmsw37P2Nb
/Pd+Yutg321v8ub/FqIiE5Tfa04uF6c85VqNxUaFO+sXpKtEpdMW2FpxDipVa8Eo
RQ8EeFqhwBzpQp83y5i8gnju4NNmRxu5oYRzJPb4FdkWPTsLEvXShPkds8+8XVPP
jSQL8CbQtLj5p05CKRu1uQa3BsBbclGW8piwdF0ygUrzjrDIkzWhghlYBpbnOvhD
gWEbIlbHGv+qdqln8xuZEr5SCirFxdRqlvxzTMVE5lIl6zAqaq8=
=pbZG
-----END PGP SIGNATURE-----

--Y+Z5jE7Arku/2GrR--
