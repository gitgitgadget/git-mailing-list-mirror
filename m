Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36754962B
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 22:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717624906; cv=none; b=GVMN7eX5atW9exQJzH+FCifrtssImj0Qsivk7WFtcPF0zMpNsKYufFRNY74Pxs/I8JAHfcnfAY+xMnDarhTWmYIToTv5gUpVXPZ4RIIcZKu1zUUu0s3fUE1Gq64TpvaAieqA5hcblRBfhBbhmwfJ+PFPwAEtkaie+zZRx3EP4bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717624906; c=relaxed/simple;
	bh=XBfj+dP3dY6/B1vhA8nZ0hiFgLQ6MzrMKbX8bDtyNfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZ8plgnXuGEYYJ/+xmgPqdrMtq0sc/PqTaoE3Y3iCygokfa3KBAFS0v7qTK6+1LwFU5jDDUOInhj71GlTbnbgXEXSanFAzNisokNPQG48z48BaNwDob35oR4pmR9BDyDQlgXTIpGvNVZaieqyt6q8/bWqV3h4AwmXCgkwvZT504=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=paqN/FOy; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="paqN/FOy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1717624897;
	bh=XBfj+dP3dY6/B1vhA8nZ0hiFgLQ6MzrMKbX8bDtyNfI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=paqN/FOyGpU6yo09Q9RjDRvCJV+rctYLLOETfMca3D4g4eKbaYcvbiB/HqLO57AeV
	 flR7vc89PWBF+0nUYleDZ6/ouAwirSv8KEE/S8gYijrDxImZW5/CTY2RdT0z5zHAzu
	 3/8Xc9hync5oWE/Kysqfx/X/9YnET4oB7l74NqPv8SVoTRdaYnDv2j/7sygtkZxxaF
	 xL+dZDJfJcJUYrPBwo4VJKSWBFkdHBZ7PIQiOhCvSdCNRm4QHkdO2Aqs1w71qIQ+bZ
	 VWjo2+rmM7VdFZlMiOjN7wUo7nryBIScjwkK6NBq6YI5kZgMxJsv6y/gi/ErwkCnSr
	 Q8LdvxAV4p43t0bt1jQcnYKJYo5uth5Uav6UsO0pY/rNOD5/EyeoegDvJB5SZipBK7
	 E7edQ6rb10v2SGK3B4lo3ZecGKuMu2DerGng7/LE84UuX+bc+4V5hSJwAAeXhtEcuG
	 bsjZfnGEVI1D10w7Wzz1B+QvgtbDQb633nsdMTVbJ5wiWvV4WO4
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A291826392;
	Wed,  5 Jun 2024 22:01:37 +0000 (UTC)
Date: Wed, 5 Jun 2024 22:01:35 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Thomas Gemmrich <Thomas.Gemmrich@vzch.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git clone error : RPC failed; curl 56 OpenSSL SSL_read:
 SSL_ERROR_SYSCALL, errno 0
Message-ID: <ZmDgP57-5AS8B6Pc@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Thomas Gemmrich <Thomas.Gemmrich@vzch.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <80a4c8c85415406c947ee588ef223ce6@vzch.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2uqs2e1UZ1MQC5GG"
Content-Disposition: inline
In-Reply-To: <80a4c8c85415406c947ee588ef223ce6@vzch.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--2uqs2e1UZ1MQC5GG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-06-05 at 06:06:33, Thomas Gemmrich wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
> git clone from azure.devops.com - server behind corporate proxy
>=20
> What did you expect to happen? (Expected behavior)
> clone of repository gets created locally
>=20
> What happened instead? (Actual behavior)
> git clone fails with an error message :  http.c:868              =3D=3D I=
nfo: OpenSSL SSL_read: SSL_ERROR_SYSCALL, errno 0
>=20
> What's different between what you expected and what actually happened?
> The connection should not be aborted and the git clone process should com=
plete

Usually this error means that the connection was interrupted.  I'd
normally expect a non-zero errno in this case, but this is Windows, so
all bets are off.

Since you've mentioned that you're using a corporate proxy, is it one
that intercepts TLS?  We often see those kinds of proxies break
connections for reasons that are unclear to me.  Perhaps the proxy found
some undesirable pattern in the compressed data and dropped the
connection, or it could have become overloaded and dropped a connection
for that reason.  In any event, you should try to reproduce without
that, because in my experience that's very frequently the cause.

It could also be a simple network problem, a flaky wireless or wired
network driver, a non-default antivirus or firewall (which often also do
TLS interception), monitoring software, or a bad ISP or network
connection.  None of these are really a Git bug, so there's nothing for
us to fix here.  You may want to talk to your corporate IT department if
need be.

Also, just as a side note, I'll mention that using NTLM over HTTP is
insecure and can, in some cases, expose your credentials in a form that
costs about $20 to crack, with just one request.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--2uqs2e1UZ1MQC5GG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZmDgPgAKCRB8DEliiIei
gVdeAQDMV+C8JJBaLuMgF6B2LP7eOGQ3Y61UEp7I4vHutKluJAD/ab9ERIvT5fNM
O3x1q7iT+4UTMospuWOBvH8an95wBAc=
=Wpv9
-----END PGP SIGNATURE-----

--2uqs2e1UZ1MQC5GG--
