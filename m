Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C952DC33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 04:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACD3207FF
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 04:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="jCuHtYj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgA2EEv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 23:04:51 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49220 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726346AbgA2EEv (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Jan 2020 23:04:51 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id ABA7C60482;
        Wed, 29 Jan 2020 04:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1580270690;
        bh=tisQt9cm1VIOAgzR8I0HHi5xbFr8HxwnNswhzk6j3Rw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=jCuHtYj3xJzUt80k/yvRscPU+exOJFPiNARZLHrBP3ErmsK15qW3Oz+KxM4ej4wX8
         rf2KV2jMNbYvtEddo8FjvH3qwHWdJEJfhf1vXF29Di/gjxZb4FHnos0xs+GCeheI/w
         ZUyGW/0iZ0eapiY/3ptahf+J7CjiDs5D1tAirz1QtKnmm8+leMxaCireg2uyr4j/Uv
         2UksuJPj+HxU/tQ9K3AEIGUIPyxBA7SaLGlwvA3hZkYwgh2Wk0383QjOu8tvsHjeeb
         +oPTrw3saj6/enpl03C4+wiM34HfE/TWnhcjJeVsyo38QTkxzZZiGOPx3x/Uw/b6iG
         dkd6Uj5l6OABpHX/6Dgyb8d6eEDl7BWvTckJhfM8MM0JmZMw7VEvOP9SQcfu3LeD7c
         3iRNpJFYh9WEvhvGmY3gA7TIh36UkVVC+mykO8GK7R/8Vg3zs/ghlGHyhtbprR7k+w
         gFi/ufouGHNnLTLXSAbg4tZZwPP119tRqLyCVG7sM9LFzsnR9Pn
Date:   Wed, 29 Jan 2020 04:04:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 15/22] t5515: make test hash independent
Message-ID: <20200129040445.GM4113372@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
 <20200125230035.136348-16-sandals@crustytoothpaste.net>
 <xmqqk15b8mfs.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nrXiCraHbXeog9mY"
Content-Disposition: inline
In-Reply-To: <xmqqk15b8mfs.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nrXiCraHbXeog9mY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-28 at 18:28:55, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > +convert_expected () {
> > +	file=3D"$1" &&
> > +	for i in one three_file master master2 one_tree three two two2 three2
> > +	do
> > +		sed -e "s/$(test_oid --hash=3Dsha1 "$i")/$(test_oid "$i")/g" \
> > +			"$file" >"$file.tmp" &&
> > +		mv "$file.tmp" "$file"
> > +	done
> > +}
>=20
> Perhaps we can avoid rewriting the same file that many times, by
> feeding the mapping to a single invocation of sed?  E.g.
>=20
> 	sedScript=3D
> 	for i in one three_file master master2 one_tree three two two2 three2
> 	do
> 		i=3D"s/$(test_oid --hash=3Dsha1 $i/$(test_oid $i)/g"
> 		sedScript=3D$sedScript${sedScript:+;}$i"
> 	done &&
> 	sed -e "$sedScript" "$file" >"$file.new" &&
> 	mv "$file.new" "$file"

This is a good idea.  We could also write a small sed script to a file
at the beginning and invoke it with sed -f.  That's portable (POSIX
supports it) and should be easy and efficient to do.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--nrXiCraHbXeog9mY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4xBF0ACgkQv1NdgR9S
9osQfg//V0pD4A866vBVjkGWUpEytHb3H4gRTwH3F/cSUZ0ryvZgoK+NVYUCweNr
t6TaRH9+e9VsOSa+gaTgrLYyresTipGvmYCp/b2BjBz0V1SMoJ7QID62ezqm9Hs+
WAMy3mrdgofdQXDYErcBUJOnaoFUJoSp8U1wZrYqN5KvaDLAufknVCtSuiVC88DM
OOPrY3wCBFmpR4ArQH+vlfFSs4koNQ2lwUVIoJVGlFn08s42Cr7lR0qUZqcOLIT+
V9F6EeNGW5z49YQipkISp+4UHNQte+UNWfT+zUNIRLse+DiieScCSNnolYnqEInI
5mzencxF48Swu4VhbM0hWVhe4BvtuMC49XBr1QCMMCxBIqDnrtPg6eG/mozxcyLT
BdRfdp2V/jtWuAomIjiqWzno3hFEyUW0GmwlFA8ea03V5INnKLnspitEHarxxsc4
meVNz3Gnh9fveWIGTIR2sy4R0p1/alGvplScDXIMAy3TTcH7fwoVv7nrdFb8W4ER
7PQq3H8zlj7mVkSULA57p397zCE++6i5N//jDIWLCj8lYC0J8CBCD+McqFiiqATJ
mteruXB/4KfKVXv1LdnP1xyWFKZfHY3SCtdgJt9kRbawKRQOyYRSgHD9vVWi8S7Q
z+9DyhrklBSF64BqxKCjLb0SkdfQ70UHfWrDe/D8vZPkuDG1jUw=
=N20V
-----END PGP SIGNATURE-----

--nrXiCraHbXeog9mY--
