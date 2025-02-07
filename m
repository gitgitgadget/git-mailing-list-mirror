Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA721B040E
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968889; cv=none; b=ujRBxpjZDwfg1MSn6S2qLvP79mlXwUSvGJtgpaYWlQ+1hFdpZaCoEkO1We2uxrRh1oOX6hSW4uXTSqlcTSgGV3insXvWBq3H6bl0IY8XvyQ3TEPjxsNwlIrjhdPLsirssl0JS7a0eRi1uV9bWyIBZw5DmRNeIFPjnEG57lidnHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968889; c=relaxed/simple;
	bh=lpHNWFr8WM1ihLaGaBVO+UNKZo4Y+KoWOAdKQLwgs9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzqRWTTt0W0DC+PZMDDM3K62to10BTVwpzDtwcjQE+pwtnCKspYSEMhz1j9D4KJkQdcitFCPFO5FlnfUZYtdLMKDwx7Aq5dwlNmdXVu4gAH6CsM9+xd+xvxnotp4yJkS0JBAZ+zYPUZL/m7+sjQ3HXiceXZ7/tSXTUBJeNS+Kuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=H9hrU6O9; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="H9hrU6O9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1738968885;
	bh=lpHNWFr8WM1ihLaGaBVO+UNKZo4Y+KoWOAdKQLwgs9w=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=H9hrU6O9XU9W4Bs0X5/rfUhsOvMoNbxNNSPctOYc4TDCfJJlAC4IhQruJs/Jh0bgu
	 Qsy34eXIGZaHMGULZMIRG1hW2541HWNQeSDyU3TovA9GCoGLfHjrHIgmZ32A7cERP4
	 R/XQ5SA8tk4lcx8LPmzqqInV926easKb4+bWhjM/0rh3Wj1vLcyuj2rN6YiMvJQ/0g
	 cn/rGGf0lZPK+Qv+YXVoGHTfUiNz8YNLdrqkqZeZB0MsovtNjfzVPrhui/iT34Caeu
	 DtPVy/Lh2eLRs3v4xUK2SCFmMOyOrjFmLACB4U5tToVs0xclZYtzDDPeHgmAREdjIz
	 cO3NAtfcH4xlKZ33iYhImWtxX16HtWUzs6qeN9kMMA5BxzqfA/Y25b9gHwnudINjQh
	 NfjWHFZl/b6V4aivThSFGCdYieXoRQps8FdHIyecMWRrs6TVqTvwZEWLlKQVdEk5U4
	 REVZazH0C7RieoYzqRAAljjgdk9o8FJ5BSvm2xOJw1Wike5LA5P
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 802A220076;
	Fri,  7 Feb 2025 22:54:45 +0000 (UTC)
Date: Fri, 7 Feb 2025 22:54:44 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/5] doc: use .adoc extension for AsciiDoc files
Message-ID: <Z6aPNL0R99FL2_2k@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org
References: <20250120015603.1980991-1-sandals@crustytoothpaste.net>
 <20250120015603.1980991-5-sandals@crustytoothpaste.net>
 <CAGJzqsnFNfK6DEcbRQsUB4S8qVBnQ2PcJBgbvCPYLd-xAVVQBA@mail.gmail.com>
 <xmqqo6zeixnk.fsf@gitster.g>
 <CALnO6CAa+6xx885TdKFrpruxHbN80S3RE=STaswnaUz_3QZQ=Q@mail.gmail.com>
 <xmqqtt95fx62.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xX46rEMqG5E8NhbP"
Content-Disposition: inline
In-Reply-To: <xmqqtt95fx62.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--xX46rEMqG5E8NhbP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-07 at 18:05:09, Junio C Hamano wrote:
> I was wondering why we remove SubmittingPatches.txt with "make
> clean" there the other day.  There is a Documentation/Makefile
> target to create %.txt from % applied for SubmittingPatches.

Some time back I converted SubmittingPatches to AsciiDoc with a variety
of anchors because it's easier to link to the portions of the document
=66rom the website.  For example, many projects want to use our advice to
use logically separate commits or to describe changes well, and it's
much easier (and honours the license better) to just link to our
documentation than to copy it elsewhere.

> > for CodingGuidelines, though. (We also package
> > ReviewingGuidelines.{html,txt}, but it has a .txt extension.)
>=20
> Thanks for noticing an annoying inconsistency that must be rectified
> independent of brian's topic to help it easier for Editors to
> identify the files that are written in AsciiDoc.  If we are shipping
> documents that are exclusively meant for Git developers, we should
> be shipping all of them together.

I agree.  My apologies for missing that.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--xX46rEMqG5E8NhbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ6aPMwAKCRB8DEliiIei
gefgAP0ZKMxoKq7q2oPjBz17hdrN7mho7Tbz0cd2sllLkqyuVwD+IwGAe1jdDFMu
JJ9K+i++Z4Ym08lOvrv5ulP+0zmApA8=
=/UQB
-----END PGP SIGNATURE-----

--xX46rEMqG5E8NhbP--
