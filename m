Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C13C2018B
	for <e@80x24.org>; Mon, 18 Jul 2016 23:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbcGRXDb (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 19:03:31 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59486 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752195AbcGRXD3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2016 19:03:29 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:395:747d:98e1:fc48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8210A282AF;
	Mon, 18 Jul 2016 23:03:28 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1468883008;
	bh=zFxDsnVG23lWDv9dqhD++XkDnW0Vt9WtqArWfuLzRrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RjvcIlihiOWnjff/te2TfFwOW0/1ITwLFLre0ThOj9vzmb+EqMK6Tx+pckvpS1Bwh
	 ZJyi+AtYITMKlnIEuHCSITlnxlnozGYxKcfw/BXMOtShoHfUUEYXsO1nnL5GczhGB0
	 YBbFs1HSuOeGRqXIrHG8CTC2VTc3n/lHJ4KpIEDk7HKhg9diFdGATSauZp8NSeUvvc
	 Mf2gZ9frdfIdXozcSaCAR50YfG3PZN5DRt2NVqoRMobjxy2ZD0pjCWxzpycmF+f8h6
	 sjGvtnDUYnGYVMPTHR8Rj1rA8UDjc2gjbhrEmsFhEOKDV17+1ocn/hCu2Sk5h0NA6o
	 Q0hRNWECBVBIypavMPh78A98VhAxjW92HfGeKILwekxkGaoe6T4jkrSpT/4SqDV6Q8
	 J451PVTH8M5Whw5rxlIqCuQkMy/OBodtFYnQqaH8g4/sH+hyOMubH7m+OdGrivu/Tb
	 4E9vlpy5Gsu9bAWCFQVbVycvn7ZHkJKVInEjWig8PM8pnCUyEHX
Date:	Mon, 18 Jul 2016 23:03:25 +0000
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Theodore Ts'o <tytso@mit.edu>, Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Herczeg Zsolt <zsolt94@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git and SHA-1 security (again)
Message-ID: <20160718230324.GG6644@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Theodore Ts'o <tytso@mit.edu>,
	Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Herczeg Zsolt <zsolt94@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160716201313.GA298717@vauxhall.crustytoothpaste.net>
 <alpine.DEB.2.20.1607170949360.28832@virtualbox>
 <20160717142157.GA6644@vauxhall.crustytoothpaste.net>
 <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com>
 <20160717154234.GC6644@vauxhall.crustytoothpaste.net>
 <20160717162349.GB11276@thunk.org>
 <20160717220417.GE6644@vauxhall.crustytoothpaste.net>
 <xmqq4m7mltbw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nhYGnrYv1PEJ5gA2"
Content-Disposition: inline
In-Reply-To: <xmqq4m7mltbw.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-rc4-amd64)
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--nhYGnrYv1PEJ5gA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 18, 2016 at 11:00:35AM -0700, Junio C Hamano wrote:
> Continuing this thought process, I do not see a good way to allow us
> to wean ourselves off of the old hash, unless we _break_ the pack
> stream format so that each object in the pack carries not just the
> data but also the hash algorithm to be used to _name_ it, so that
> new objects will never be referred to using the old hash.

I think for this reason, I'm going to propose the following approach
when we get there:

* We serialize the hash in the object formats, using multihash or
  something similar.  This means that it is minimally painful if we ever
  need to change in the future[0].
* Each repository carries exactly one hash algorithm, except for
  submodule data.  If we don't do this, then some people will never
  switch because the submodules they depend on haven't.
* If people on the new format need to refer to submodule commits using
  SHA-1, then they have to use a prefix on the hash form; otherwise,
  they can use the raw hash value (without any multihash prefix).
* git fsck verifies one consistent algorithm (excepting submodule
  references).

This preserves the security benefits, avoids future-proofing problems,
and minimizes performance impacts due to naming like you mentioned.

[0] We are practically limited to 256-bit hashes because anything longer
will wrap on an 80-column terminal when in hex form.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--nhYGnrYv1PEJ5gA2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.13 (GNU/Linux)

iQIcBAEBCgAGBQJXjWA8AAoJEL9TXYEfUvaLNw4QAKvATaBlLdseuRtEf/67a22P
GBV+DtlErwoupZyWLqFqCBZ7yM+LHjbIbYbblGHL+QrYOun7bL8Vw+4xP+GGF2xx
9jnN2DND1vTKJhbXRzXpLOkuK6K6yQm3BodImaHVJGYy5SBTyAn0Xr7RWhnGq01E
ZgqHQ+n3c0r/lV5oY3cha/0J/ugpJT2oK3j9MMECnGOD1NiDgSrOIzweyKnWWtED
5wgR/3jUKPWuuXPDXBqydUqL6B4dQeSjqmn0AkTBl4X9NBA8i3N2mCgJh8xtbx6J
9weKlFjAHgHiXp25zP/BjlQzTO9dG3hkQwM1OK0MZaE4yO2bRfYnbmt3xam6eUC7
xTr3iFOe3qp0/vLojLHBFFe4133K1TS9J0+ssWT0D5VLEp3SkiB4KEnlQ22HMOb/
uaNVopqZMhMIdXNctK5ZHFKFWc0i4cMFIOLIDITCtjFTn3ALPYSKB5UZO5Ryv+G3
mDAmUd7i2F3ku4aUrO14iwtP9l8yf4XLlCkV3rvh+xYnvdSvhGmq73GoGTbhYlo2
DvfqxcZqSyNYHE1ahadABUmkNSLjcqlqlUJChDEZCHFcD1gx/gllXj/Gf4xPFwDi
HbHyFMyW3Dijn2IsL8nzgx9vUTwFWaj/awG8RfXVTNPq6TpwNW244cnxtABBCMRH
IJ2JnoAPCE46mQNkgql1
=pb+A
-----END PGP SIGNATURE-----

--nhYGnrYv1PEJ5gA2--
