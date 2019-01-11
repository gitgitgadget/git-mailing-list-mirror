Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59EE41F803
	for <e@80x24.org>; Fri, 11 Jan 2019 00:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfAKAR7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 19:17:59 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58460 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726745AbfAKAR6 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Jan 2019 19:17:58 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c537:b034:2963:7e8f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2739D60736;
        Fri, 11 Jan 2019 00:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1547165875;
        bh=2Ab9gAR4o04gce/tYPU+DWR1yQINrZm/o8Tk2gOsYqM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=znHGyf7esT8KCJMnNJs5ShOi7gbmxTKUIrzZPvhIdVrWzWI7hOTnqAUxKOKwyIg6t
         bk3OwJ2JF7/cDqKiPL45E434hlMw5P+GOGabHy54+9LHWwW5F108/YXiFmj++cqITO
         BXCI8jEy+6svTYNdnDq4GVHcL0jLzaATb4b2HLXDq+D91JlE0SNhkZ2H2VOfsbDz19
         x4S0OqrcC93oLJKu7mnblS6HFjIREiDscFBv8bEKASmMIQdzX/oezJsP4+IHff5ds2
         UzajUs3oYtQazWNYZO1ZVU8jh2HVDQ+5HiKEJKTRBYUt3/9jPxJnhis3Y+ozEKSRzZ
         e7uGBDWzkXDV6wE3bgZDLzGdNW4VNbCwcfWDd+sT3erRMB+9adlFFJAjfPkMKih1Wy
         ggHPYVXRs9El93aVKMWz2sWjtmTUQ+SludS9QIjQ1xxNXPyiey+QPx2EEwE1dKxZUv
         Abc1OVOcVIt4j7I/kpjVHTdvqTa7CkjNWdgmZOxx7XXKunURUTJ
Date:   Fri, 11 Jan 2019 00:17:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] tree-walk object_id refactor
Message-ID: <20190111001750.GO423984@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
 <20190110042551.915769-1-sandals@crustytoothpaste.net>
 <20190110064030.GB20497@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oCBD0SPT9UHZkBMO"
Content-Disposition: inline
In-Reply-To: <20190110064030.GB20497@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oCBD0SPT9UHZkBMO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2019 at 01:40:31AM -0500, Jeff King wrote:
> On Thu, Jan 10, 2019 at 04:25:46AM +0000, brian m. carlson wrote:
>=20
> > There are a small number of places in our codebase where we cast a
> > buffer of unsigned char to a struct object_id pointer. When we have
> > GIT_MAX_RAWSZ set to 32 (because we have SHA-256), one of these places
> > (the buffer for tree objects) can lead to us copying too much data when
> > using SHA-1 as the hash, since there are only 20 bytes to read.
> >=20
> > This was not expected to be a problem before future code was introduced,
> > but due to a combination of series the issue became noticeable.
> >=20
> > This series introduces a refactor to avoid referencing the struct
> > object_id directly from a buffer and instead storing an additional
> > struct object_id (and an int) in struct name_entry and referring to
> > that.
>=20
> I think this is really the only safe and sane solution. We resisted it
> because of the cost of the extra copies (especially the
> update_tree_entry() one). But I don't know that anybody actually
> measured it. Do you have any performance numbers before/after this
> series?

Unfortunately, I don't. I'm not really sure in what situations we hit
this code path a lot, so I'm not sure what exactly we should performance
test. If you have suggestions, I can set up some perf tests.

I will say that I resisted writing this series for a long time, since I
knew it was going to be a difficult slog to get everything working (and
it was). If there had been a way to avoid it, I would have done it.
However, writing this series led to about ten tests in my SHA-256 work
suddenly passing where they hadn't before.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--oCBD0SPT9UHZkBMO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlw34K4ACgkQv1NdgR9S
9ouB+w/5AYJIkxd4xcX4GS0G9mpBYplHwTGZjrgGNemIrRtsGFuBEOPluYV24rS/
socyGEB6Q+5AbTaeO1OC4SnJHycuCWMc9r4CvEDQR6FP5vg9WbVMj7+/cqt4z0A4
vfqDIfEye6GPamlqO9bGOg6Qsn4mnH5ZepbZPYktKIgBhyL7DycdH2A1uRArdY0p
oeJYdNc5i2RFr9Fzf9vKYfBd/3z3AGODjM8nEmCMiuWhsuXsODcMFiWR5bmD0qSC
J+N4zWs3ukPv+9tPxsK4wPpQ8rG1mLsHLczd9Qb615AB/hikH083Uvkx+GqtpHj5
OQwVu6feaYgBXSctxnbJKZZyBduksVz/0+2uwSSa/PWglpROtfcN1nY5xW7y9OL4
JCiLuAVzmSqoZuBZypj7a/heiUdEliJnak0xDeJKjomBUT8dIHEbW7VbOuJfYVxL
0DHZ2+e4poS9hCt5N0cYrawc4XHI+5TqqgkNmoGb6xO1AIvebgOgeCdQsnB2MHDf
71zdw0CjQmEpOrrGqlQKBZyp3JCBXmSkrX19ZCsBxg5SK2jci+w6Thw6CPV1wx/X
h/TxmFQzbRGGRGiN5IipqyyZSPaT3YKriamKL71+uwplfYPEQM1jSMxEdkRmuAyl
uZHR0oQ0l9wPsrW68LCsfFWIhiRxnDowedrpRuM6uiZ3a2SN7CE=
=n29S
-----END PGP SIGNATURE-----

--oCBD0SPT9UHZkBMO--
