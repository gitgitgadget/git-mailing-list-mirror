Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEAC1E47D8
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728597149; cv=none; b=XGiC4irjuXkkrV19TrTxr1QAbiVp0f4ywiUiB3IOWl7c9YRrj20iw2w9NX2fp0z0t4XXMD9qZKGObyRl5hmjM0A2AIwn8E9fBcciBfIBrJg9rJAP3ntXkpyxDdnDvy6VLrYWLBygYT7fB0SvRlWaG12u+eFkukNsugRNZaL4alc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728597149; c=relaxed/simple;
	bh=w+PnXrIhv7+3J9sKr+ho/xoFMySemsVFX6HVONxGNks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaU3amd81HYyHx5hcrMw424AOIhChfVTDodWW/oC2k72n83yu0HEbRkhJPB04tmgBPSzvbFO1YaEligxPOj4q5gUNbHUO3FurldQ8KWk/dKszL9z7XY3LjP63EfTlM0O1KEHeux5UQy0lkkY6OCRukZx8MuTRQAHjVSv8Jj0O3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=FkQ6Oxm5; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FkQ6Oxm5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1728597145;
	bh=w+PnXrIhv7+3J9sKr+ho/xoFMySemsVFX6HVONxGNks=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=FkQ6Oxm5ZAKzgtNAyXq/wDSQlf+CJ0F6B/+GJPf+mRWKt+W0VBDgOkIktNE1LHlNV
	 YMl/+XYgvEa7mgjnDArqmB80FuOHqamsrnFJIMDauYXeDradUJYOR1m14n3rRe7mKN
	 z0EIv3ntesPH1M5topwG5D0iCVs7rhp0FNWl+iwF4q0iAURRma8eWm/u0kDAMijjyy
	 1r39nZwRDtIGXnV3ozBtaJmfM5kwQwrufqdC2eOyDlWm4woMbsGNsSvr/d4Y1nhhvr
	 0OUbAIBflE4U8vwc6wws1tmUE2/RRt1vLhpgaw4+4VzPEtQoWqm764ilRAcdNpx3gX
	 A6o06IAEFk95L+fTrh/ou8v/RY1rUN8u7gqmgGeNpZAyv2dBmGMgA8eM9Ek77pPejN
	 RuSUZLA+sA+XC202ZsUAM2bUrnT6ExBBUsw5F5uVvraDUgbe4HTg5FfTqM2XFP10aK
	 kWngR0UMBQVR0DmTTPz8u3W/eo23lTK1kyhsQu2qVkvBD0m11SW
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id EE1A32008B;
	Thu, 10 Oct 2024 21:52:25 +0000 (UTC)
Date: Thu, 10 Oct 2024 21:52:24 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Cc: Git List <git@vger.kernel.org>
Subject: Re: minimum curl version effectively changed
Message-ID: <ZwhMmGt0kZvaSzSL@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
	Git List <git@vger.kernel.org>
References: <CAOO-Oz0NUA-YeyFT1MJ=XKyLWJvQoFH1b-F0EFOzvy8iWka3KA@mail.gmail.com>
 <ZwhF0OZ2gpLWUfHD@tapette.crustytoothpaste.net>
 <CAOO-Oz1KhFcyErVx1Qb142PtPJS=UpgSD-FacckqNS4_okAtFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vRYKmIbwWX5+0WIN"
Content-Disposition: inline
In-Reply-To: <CAOO-Oz1KhFcyErVx1Qb142PtPJS=UpgSD-FacckqNS4_okAtFQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--vRYKmIbwWX5+0WIN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-10 at 21:30:04, Alejandro R. Sede=C3=B1o wrote:
> I have a patch I plan to send in tomorrow that will properly
> conditionalize using the symbol on versions of curl that have it, and
> emitting a warning otherwise. It will also follow up with some
> corrections to errors in git-curl-compat.h.
>=20
> I don't think a new feature should unilaterally change the minimum
> requirements of git without some announcement and forethought.

We already have a platform support policy, which guides our behaviour
here, and it was discussed very recently.  It says this:

  Uses versions of dependencies which are generally accepted as stable and
  supportable, e.g., in line with the version used by other long-term-suppo=
rt
  distributions

No major Linux distributions are still using such an old version of
libcurl.  CentOS 7 is dead, and we don't typically support extended
long-term support because it comes at a cost, and it's not fair to
Git developers to require them to pay for a secure system to test
against.  I don't know of any other major OS which is providing support
for such an old version of curl either.  Usually the BSDs have a much
shorter life span for versions, for example.

So I think the oldest supported version we're going to be willing to
accept is in a clone of RHEL 8, which would be curl 7.61.  It's
certainly a mistake on our part that we neglected to update INSTALL
accordingly, but it's not a mistake that we unconditionally added
support for a feature from over a decade ago.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--vRYKmIbwWX5+0WIN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZwhMmAAKCRB8DEliiIei
gZYKAP9yTFKI/vQrLns0I1K5Yc1HQFcmehAs5nx+K8gvAXdYCQD/ao00LviDiK8w
ZuuSWcBuOV/veyGbaFZ75XHvbFyCWQY=
=GzYD
-----END PGP SIGNATURE-----

--vRYKmIbwWX5+0WIN--
