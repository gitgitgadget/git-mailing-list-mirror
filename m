Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE17C433DB
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 21:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF24622AAB
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 21:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbhAJV1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 16:27:48 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50382 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726394AbhAJV1s (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jan 2021 16:27:48 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CF75C60781;
        Sun, 10 Jan 2021 21:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1610313997;
        bh=MPLMT9N7ktARjvR7sy6Y6pEm60/JRnzv/Dex1WNnqtE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ZNyEzK3MOFhHpdbxvuYs5j2cZyjfWt62/YqI1qHAP/czsim4VARD9n/uqb2ItRtDY
         Ss5ulx5BoeCUkr3wXwO9JrxVC1Kk4YpJcwKLTHK7pUv0sxTd/+4YonRYSQdcaFcun6
         WEYgQJMtvlUFeMC1VMtmzGB2DiczynglIsrGDigaa0z/vXeNJCvNSxFA3uhuVNAE/d
         prjLGwdKSZNg6dn5kFBNU2SgxxvRPZzB4xglITestabZ9rRmxXhEnKNLQHa72yUIYC
         +NERX7/CfgL9+CkXAEx+qJy+N0vdWgUW8ORgIiC23v396jUZbdGpio37tEGnnS3OXK
         0q/bk3gfNRf35Hb9Dz99I+Z5bjc5hHntYD14orBWDABAobJok29Xzq8MMSFJzMr4Ky
         Sy4KWIGMCEmcWgIUMc7WMzFvY7oYWLK0JsfenGRlwf1uxuO0RjrY0gofkrjtc1DEOx
         7cqbj6MaCCGWSQywgy0cf/eQBEhnyb+5CuGgS8v/wBwiWh5VJUH
Date:   Sun, 10 Jan 2021 21:26:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 5/5] mailmap: support hashed entries in mailmaps
Message-ID: <X/txB8b3/qqbwbmC@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
 <20210103211849.2691287-6-sandals@crustytoothpaste.net>
 <875z4bsbuz.fsf@evledraar.gmail.com>
 <X/UDT/oLKNQmxBXR@camp.crustytoothpaste.net>
 <87sg7861e5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lNeFylX1ikylw0Ju"
Content-Disposition: inline
In-Reply-To: <87sg7861e5.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lNeFylX1ikylw0Ju
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-10 at 19:24:34, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Doesn't the difference in some sense boil down to either an implicit
> promise or an implicit assumption that the hashed version is forever
> going to be protected by some security-through-obscurity/inconvenience
> when it comes to git.git & its default tooling?
>=20
> And would those users be as comfortable with the difference between
> encoded v.s. hashed if e.g. "git check-mailmap" learned to read the
> .mailmap and search-replace all the hashed versions with their
> materialized values, or if popular tools like Emacs learned to via a Git
> .mailmap in a "need translation" similar to *.gpg and *.gz. How about if
> popular web views of Git served up that materialized "check-mailmap"
> output by default?
>=20
> None of which I think is implausible that we'll get as follow-up
> patches, I might even submit some at some point, not out of some spite.
> Just because I don't want to maintain out-of-tree code for an
> out-of-tree program that understands a Git .mailmap today, but where I'd
> need to search-replace the hashed versions.

Yes, I think we do rely on this being inconvenient.  If you plan to
submit such a patch, I'm going to let this series drop.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--lNeFylX1ikylw0Ju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX/txBwAKCRB8DEliiIei
gf10AQDjTS3Cx877CyxuxPiuIjvrGJdPmgis0VLKHJrsblnuXQD/SE4DYTiVsTrm
enyDmsGNVoqsH4o3G3M6geQels4/Pg8=
=ZRrV
-----END PGP SIGNATURE-----

--lNeFylX1ikylw0Ju--
