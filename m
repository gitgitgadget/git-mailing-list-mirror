Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD1615AD90
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231074; cv=none; b=apWZ1bxClOP/3S8gi+GC6hCro/wD9dF6qP1Jd66gZ6Ykf6dF331SOUg472RSW260uoPKs9GJiZnmUqfNDGDJsye0IOiSPOYDriO6OtvGoGREIsBZcgObSy93uGjdiSaAvqkm2AnJXXkz2TWOY/80oXq/O7WSuw6IDSaT8fVJzks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231074; c=relaxed/simple;
	bh=QMNrRygeBQ68nKyw6pyYUvTxBMSgN7XOAQqoH8E3I1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jm+UF5iyBCsMtrGt9y2ejc/p/CcZDm4uUCsjfLVTh4aPEVsbSqrCnAvJosKax552qWTgKlsKbY5niLvsn63Bade3aijxEelOxxfMfSNdjYToxS+0wioJZxVSqy4lk+fJ6YwgGi70S/d2x69eaq8ig6//0lntW5UKw+eEQcWUiYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=W7dwxWPd; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="W7dwxWPd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1723231063;
	bh=QMNrRygeBQ68nKyw6pyYUvTxBMSgN7XOAQqoH8E3I1o=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=W7dwxWPdmq+bV3mMkigUTy9Ae2JGUObai1jj2y2siTBYtWfwlitFo1FgydUEo1+BD
	 FlIGXDc1EZbEPTqKRmZg5oqK7C45KQy84IFzpQEmLzhHlu15q+91Sc5TRlZvAjZSCw
	 eEZCh0SpiwqW2b8TDoGplbPT4aDc6f/sqa8ObCtNWwjtyQHHKhmiTVra4cG5ssF5EC
	 HKJ7ZXE0lmV2aaOvJWWbDVEprAvpt7e1cTGau8LYTQ5UmysrKqwqvds+ihRi2dkqdj
	 QuJ8Uvkwn+MbKP4mJe3AMITRBVNwYTgwqV56ncNEBgjr85/2fU24v/FYjloCHnY6P0
	 jUqK3uUJ0FTRzxV5/iaqRlb54+GZy0HBZPDxa83KKinufEfVRqHJBkA/Q+As1GKWQn
	 NS6Dbwlc1Mgd1XsAo+J+y1YFsx/Yzo7xKxm59K9jNtDfgtX520FULjIF1TlyubP4Wz
	 Q77cz2h6SDMNvNA9CBjwmrrXW36pOCBSEQuNi3p7GvWTpe2eXMK
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E9819209C0;
	Fri,  9 Aug 2024 19:17:43 +0000 (UTC)
Date: Fri, 9 Aug 2024 19:17:42 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: =?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>
Cc: git@vger.kernel.org
Subject: Re: git send-email with =?utf-8?Q?ancient_?=
 =?utf-8?B?U01UUCBzZXJ2ZXIg4oCm?= dh key too smalll
Message-ID: <ZrZrVpYdSPb731_p@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>, git@vger.kernel.org
References: <D3BAXOA4NL74.29XYKS0IO8UFC@cepl.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZWsHA/5QPjOSR5rw"
Content-Disposition: inline
In-Reply-To: <D3BAXOA4NL74.29XYKS0IO8UFC@cepl.eu>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ZWsHA/5QPjOSR5rw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-09 at 10:17:14, Mat=C4=9Bj Cepl wrote:
> When using git send-email sending to very ancient SMTP server
> (postfix 2.6.6 on CentOS 6), I get this error:
>=20
> STARTTLS failed! SSL connect attempt failed error:0A00018A:SSL routines::=
dh key too small at /usr/libexec/git/git-send-email line 1638.

This probably means that the DH key is insecure, so sending mail to this
server with TLS probably won't provide sufficient security.  You may
want to reconsider using this mail server, especially since it hasn't
had security updates for well over 3.5 years.

If you're using level 2, then the requirement is the equivalent of 112
bits of security, which is still inadequate by today's standards (which
suggest 128 bits of security, or level 3).  Level 1 is 80 bits, which is
probably attackable by government agencies.

> When looking what seems like a similar error at
> https://github.com/symfony/symfony/issues/44393 it seems I need
> to set `security_level` (whatever it is) to 1. Is it possible
> to do it just with configuration of git or do I need to patch
> something somewhere?

What you're looking for is an OpenSSL configuration on your system.  On
my Debian system, the configuration file is in `/etc/ssl/openssl.cnf`.
The steps for what you need to set are available at several different
places online.
https://askubuntu.com/questions/1233186/ubuntu-20-04-how-to-set-lower-ssl-s=
ecurity-level
is an example you can use.

I don't believe that Git provides a set of TLS configuration options for
`git send-email`, but if it did, you could control the configuration by
specifying cipher suites as `DEFAULT@SECLEVEL=3D1`.  You might, but
probably would not, need to configure the minimum protocol to something
lower as well.  I believe CentOS 6 does support TLS 1.2, so that should
be a fine default and shouldn't need to be modified.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--ZWsHA/5QPjOSR5rw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZrZrVQAKCRB8DEliiIei
gYNuAQCU4Ol7sEjD+cj1Rkla/7nlCVl/Sqy44nwv8+iDMjHx7wD/dYYHMuM0X+u/
Pk5n/q6StDJF/KVmX9EZuAGKthL93A8=
=5EQ+
-----END PGP SIGNATURE-----

--ZWsHA/5QPjOSR5rw--
