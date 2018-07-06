Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 150661F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 01:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753497AbeGFBSm (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 21:18:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52376 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753439AbeGFBSl (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Jul 2018 21:18:41 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:294b:af98:ff6d:ed6])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3C7C860102;
        Fri,  6 Jul 2018 01:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1530839919;
        bh=5QTkUP/DcWWEN/DO459Bip3Hun7BqZ2b1284quw+MdY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HEwDrUloFmYfWDOq0q6vXhs2JVkBDNPutdJGwF2zvGcUB7vgSHKR4w8OLji5j9PXA
         1YGtitkVeSDP7w2kkVTEq+Dr2tPt9HyFnv62S7CU4mtusqqeN8IIBrifP3LAv9/DVt
         QYGBZDcYrTJSlIBwAfwtr03U+Ql8yndXh+lf+dwiho69W7OwsGAZ3Q40Mc5/uiQNw2
         tkX1TWtcXZXCx3EyB0Pe8TTs7c1UXvEvphip5H4NOPvsxfG+VFMEmoqz7mx7T+EKh8
         9ydKIIr1z9y9fHy0efGGH43NdnIWyGY+mFpyQv2mDIF5qHbpsNLRMufMZfyyYUn6+Z
         u9C8o1W7R7Rf0rEzGMPnr6HfyLLnSkWHJeyl3BPW56a8aEELlxDkEl8Yb7JDrKv/dQ
         ifCytKlJRSSBuDEgpcalLzipxLbZinTE0xhTvhk25lqDMK0PAyxFa9s2Z+O25w5LWw
         2hpjxzNdAqWZMofOrpSzkUFGW5EyKVojuaqyvO4zLUZJki+nyfW
Date:   Fri, 6 Jul 2018 01:18:35 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Ben Toews <mastahyeti@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/8] X509 (gpgsm) commit signing support
Message-ID: <20180706011834.GD7697@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>, git@vger.kernel.org,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1530616446.git.henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Content-Disposition: inline
In-Reply-To: <cover.1530616446.git.henning.schild@siemens.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 02:38:12PM +0200, Henning Schild wrote:
> This series adds support for signing commits with gpgsm.
>=20
> The first two patches are cleanups of gpg-interface, while the next
> four prepare for the introduction of the actual feature in patch 7.
> Finally patch 8 extends the testsuite to cover the new feature.
>=20
> This series can be seen as a follow up of a series that appeared under
> the name "gpg-interface: Multiple signing tools" in april 2018 [1]. After
> that series was not merged i decided to get my patches ready. The
> original series aimed at being generic for any sort of signing tool, while
> this series just introduced the X509 variant of gpg. (gpgsm)
> I collected authors and reviewers of that first series and already put th=
em
> on cc.

Overall, I think this is heading in a good direction.  I left a few
comments, but it seemed pretty sane.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAls+w2oACgkQv1NdgR9S
9ouIjQ/+L2Zth+CL9pmHSkY8IP45kvZ294dsjHlMPYc6foSKHx5RDIcUbWpxrsTU
dQDXXlAzQvF5UA8j8VkzYpLnIsmHD2eTD2qyEVeE9/6EekCypNjNIcj8XK4SlAQg
BqYtV5LaykIvN9ZXm8z0G+V726KJ/nYkyOCMHhDjJxzJYYDOuKpXZCYtNNDEid61
Tv2weePPpmu9soKsgKiGYl2xg7tdXcCQ6LYO0xKAmE0kQy4uy3JcfmeXxbZk2SNZ
uxlohOaCqrFzUVjEss4oPe50FRqnWQJirKyNACQNwTlOCzhGKXehHc0oVpyx6SU3
7EVQl/adJ9VikPoEezK7OwCwOH0WcIScRrheBDczrGtfnTzYJoLxJNDERxxUAuPa
53CcLeCF3UIJ+Xn45Us+Hc0u2mxL1m4L8UsRgAsl1zkIFyVUrzF9sOk8vlvfVGC8
+8q/qS9XCax+L38nzXVNGkUQDFRxdmnwNtVrfE17NRxafDyNZnsUFEDlGuyrUhMB
FitAIdyHsdccyMFE7Z1JPT1E4w2Uc2N80QIr9CHck3YBcLpvKmfJX8oA2EIpDz8A
N6fCxwGs37nlsGTE1LfHwSMYvD8/8hgtuHGeMjnBSNbbDxx81H7ewSwCR0GQapyt
yhSq2EImEBhYbkrzhf3V8BqYfvwiYNqyFQpU4B0vjl+nDNZ2izs=
=5nRw
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
