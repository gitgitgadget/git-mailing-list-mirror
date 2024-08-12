Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E86316B3A5
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723497421; cv=none; b=tpjfpOfwJkKsP5VqD2/qvpsWJxr7yzuo9EGkgw/rnWR7PhaFtNZe9hAK+hI+FA060Z87axP1LzMdeaBKDpmdCgmXJU/wdKYEIda8GOpO1GfjwOS+o4Td574UOQFsDzRR+9HvCUeUStBz2akHFuutK+ZM/w5DTpK+rnJ6K/ii2oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723497421; c=relaxed/simple;
	bh=ijZeQzCmBiWLRg24irBi/gFDj4kaAKSrIrSvVRAHtPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjjrQTPChkYTSih2LFwff6hFY57xQFCYWtPl2UGBz3NsXMB1ErQ+XMTLDu2D0aq6PqwuAIx7CCwOt0TWzY9jolvz2JqtUINR+b5aBUQdXGMef0B5AWC1vfSlxyCkUvTrl3RT+Z7XEia9/bYPD4pwtgIwnWC5tc2hjWNu1ky0MSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=P5a37Eyz; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="P5a37Eyz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1723497417;
	bh=ijZeQzCmBiWLRg24irBi/gFDj4kaAKSrIrSvVRAHtPM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=P5a37Eyz0XPNZtKHDpVn9RNEuBg1Ul343tJKaHiWqQytU0yLPlohpp036z1ZfK2Uk
	 ZsAvK0rbaRw3B8YKBTtfgtPCZXYdQrenC4sxl9Ecwm3kMoyhvK8wOE0depTmSOZAZv
	 nE7Yv8rSESzZSlpmUgcUTn6COxCbvqtZLCQrvxqwO0T633jFGW19BN3k6zr7x9IlhW
	 v68LaAMFdvS9AH2MLgzju3+jOU4iHIeL890EvCahmG4g43Pwjqo9YC8bsOelh5Xlfy
	 nlqsSSdpRPcLmMHiUkVv3w78nFDddsL45M2gCvovxK9T9S7iJmir7BnJO1IpJuRXBk
	 KwE1pgIChZoDGcTVNwSEmHCUTJjxV1uoYJc/W8bdr2FMAi9dRvLwd5flABtJrCVkDK
	 2FHITKvlfHnW0fC4UHAFnYY9cnbmfwAvG8AJY6qNZzA8KL9HGxc0lyELvAh+MPnchV
	 xsZkKiXqEKFwhrOwCwQeawErubGKyly/0igHUiFFzr7iJ8MuTAp
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E8A40209C4;
	Mon, 12 Aug 2024 21:16:57 +0000 (UTC)
Date: Mon, 12 Aug 2024 21:16:56 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Mike Castle <dalgoda@gmail.com>
Cc: git <git@vger.kernel.org>
Subject: Re: Heads up: GMail regularly marking list messages as spam
Message-ID: <Zrp7yNKMxhPk6Tyt@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Mike Castle <dalgoda@gmail.com>, git <git@vger.kernel.org>
References: <CA+t9iMyT8fAR_fvQXOer=ivLnNKDnH8g_M8iQiq7gdrnfG7aCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XlcrKCVN48HRdL+X"
Content-Disposition: inline
In-Reply-To: <CA+t9iMyT8fAR_fvQXOer=ivLnNKDnH8g_M8iQiq7gdrnfG7aCg@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--XlcrKCVN48HRdL+X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-12 at 15:10:23, Mike Castle wrote:
> If you read the list via GMail, you may want to regularly check your
> Spam label for messages from the git list.
>=20
> I'm not sure what's up with that.  A handful of real spam had made it
> through vger, but GMail seems to be hitting a fair number of false
> positives lately.
>=20
> Sometimes it is just one message in a patch set.  Others, it is whole
> sets of patches.  I didn't check to see if there was anything in
> common across the messages.  Maybe if anyone has a large batch, they
> can check?
>=20
> It would be interesting to see if this affects domain specific users
> as well (e.g., Google itself).

Gmail and Yahoo have both set up new requirements for senders[0].  This
requires that all senders have SPF and DKIM, and senders sending more
than 5000 messages per day have DMARC set up.  One-click unsubscribe in
RFC 8058 is also obligatory, as is TLS for sending messages.  These
changes came into effect in February 2024.

I don't believe vger uses DKIM (at least, it doesn't appear to add DKIM
headers) and doesn't support RFC 8058 one-click unsubscribe.  Perhaps
adding support for those, as well as any other relevant requirements,
would improve things.

[0] https://support.google.com/a/answer/81126?sjid=3D9729987135322685176-NC=
&visit_id=3D638590935924706038-3386441869&rd=3D1
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--XlcrKCVN48HRdL+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZrp7yAAKCRB8DEliiIei
gbb9AP9Y8i5KG3lCcaF/t0LhoKISyBiIYXnHVmEKwcK/5mJ5PgD/dUyXM2iViXl4
+riUfMMfzWpk2Zv9r6y1nw56sib95Qk=
=ok+U
-----END PGP SIGNATURE-----

--XlcrKCVN48HRdL+X--
