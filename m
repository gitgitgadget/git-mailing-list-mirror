Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5425A1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 23:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfKDXws (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 18:52:48 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60852 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729714AbfKDXws (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Nov 2019 18:52:48 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 54AB96046C;
        Mon,  4 Nov 2019 23:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572911566;
        bh=ZuWnyV9UwsR2Ov6DKQZWcQUrSjvhhuKueZPoM1uI3Aw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0os5Xsj11Ttu/aoOmdEHBr8Gxuvq8YafRR+n1FGQ0SPfE6cJ70vRlD4I2Olp9Lz24
         SUAjCeXSmIIM2E7uyFkiaDkWFnplg/PF28OoJOdt1z9i/SfttRiA+1SM/Ye5igg+uz
         cFi8+MfdYif0eCovJf9bO5nxyFXhX94WLQCmvIFnXBWTEcrWvczXl2Ko6PF3KFseJ5
         orT12zVfWbf9xbj/gzwVcRhPChG4r3T+exo+LkTrVrdKrwy7ZSDkF/o5RP6htQ7X5C
         r7gxypiODTpkKYDbKjGkhlbUqwLHs3DWVT+W42Tvcd4nujafDMkBOGj9lzvL7iwoQm
         dmqqveln4wCd4HNNWtSGvjE8PxJqGQ6xAnVq71xlpiXILmxEC+RYNPxIczCKVu3N4C
         0rWASImBfcQIkRe9lJinQa4vJk4+wcwZI59V7PrlLrAn8VyyfVtKbGBxCRAbGddQNl
         sj430qXkJgcDU+cQd9XzARW0OHb6ePOa6Cnuf6kyd/2xb3+5cp3
Date:   Mon, 4 Nov 2019 23:52:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] doc: dissuade users from trying to ignore tracked
 files
Message-ID: <20191104235242.GD32531@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20191102192615.10013-1-sandals@crustytoothpaste.net>
 <20191102192615.10013-4-sandals@crustytoothpaste.net>
 <86h83lhugj.fsf@gmail.com>
 <20191103185908.GA32531@camp.crustytoothpaste.net>
 <20191104222416.GB22367@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Content-Disposition: inline
In-Reply-To: <20191104222416.GB22367@sigill.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-1-amd64)
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-04 at 22:24:16, Jeff King wrote:
> On Sun, Nov 03, 2019 at 06:59:08PM +0000, brian m. carlson wrote:
>=20
> > > I would really like to see a simple example of such template, so that
> > > even people who are unfamiliar with Ruby's ERB can think of equivalent
> > > solution for their language or toolchain of choice.
> >=20
> > I hesitated to mention ERB, but I wasn't sure that folks would know what
> > we meant by a "templating mechanism".  The reason I had chosen to
> > mention it is that someone could search for "Ruby ERB" and find out what
> > it looked like and then look for an option in their own language.
>=20
> I don't mind what is here, but I might even suggest going slightly in
> the opposite direction. Say something like:
>=20
>   For example, you the repository can include a sample config file that
>   can then be copied into the ignored name and modified.
>=20
> which points people in the right direction without giving specifics. But
> if you did want to go further, you can then say:
>=20
>   The repository can even include a script to treat the sample file as a
>   template, modifying and copying it automatically (e.g., a Ruby script
>   using an ERB template).
>=20
> or something.

I think this is a nice change.  It summarizes the proposed solution
without needing to be specific.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl3AuckACgkQv1NdgR9S
9ovmeg//Wp3aovuta4vfUxTdF/Il1e+0X9LcOWTriWFavKGEFyR1wCH1VsKJRdGX
sW40Kb+O2JwcFtMzIe/IYc4a2TcXIa6HZn1qfu/aXv8pGcQueofOLqMQpb//j0KS
5QHnFxDUTOdk+ekTf+iHOYxUG/MoWDeyDQiVTNaIHl+IccAaTrFUTUj11w+KG3xY
W8ytqe2A6eMhDSxv5uaDw/064pLIrJtS7R2rZiZ2TOf/GbHtd8APkGf6FtdsnreC
QhcXjs4Y18+fhWE2RlT/0xCBwDpwk1f8g3Q2BoI5/49lyh0DI4Vc+ijjDQletsGk
2b12WgCvG4uLzZajZg19k0MlQYTY5vcu7mNj7DbU0/ZfK+eqc2HrRwALkaKviUpA
iTXu228Oq+ya7N/bJ+PRLfBq5Xraiw9y2BihHYMd622PpCExaHdWmLAXtFUSqDKV
OhIv3QgA07Y+DtBlnprMEPmDldJGA6l9HWiFk1tepKti6/p32bUefssda1RRwJ5L
OsyuDMS8NLjKLxe37HrX37tsu7bb3ei7i4u5N2fsRlqeBaZkwaJXR6dkWMwJCrmQ
x9qWpUO7ws746tOrIaJH/eJ6dMBG2qAqp/RdNfFXJ/tE7YeCJXI2EuEx0i8XxmFF
8NpyylAYK3kjMi3WfwoZzNEVztD51lYkH5JB9CH2nB7wZ63SaF8=
=/7Wn
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
