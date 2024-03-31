Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB20757EF
	for <git@vger.kernel.org>; Sun, 31 Mar 2024 21:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711921442; cv=none; b=CNG47t/Cj8pjCw+N01TtLERkyqHYBTTeKAtuPGHDe0FncTMLTBTkbABqNWNClfXuxUB+V8cZqRG8DMYQJ85HOMiQj/Wuofhzqb90rcgwiNmyNT/JKgHE38HvRfcYA73WbKOdM5bDg+n9DFLLaXctqaw+uOnw2LziOU6ndMOeDow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711921442; c=relaxed/simple;
	bh=3delPXyKThWm3GsHwsrtU4puYCKj3GO/EmMg/QRdVqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuIH+PybLYg/C9TjbQzgHg8gvQhagAqz5W/BfX/U1Ba4nnZOcSxMd+1sQQqJvgB1W7YugA86zZRS+Feerc2zSxf8VhldD7yqyMt/Ug1LmhjS7pBCblI7Omk1SLqTXVf/Lc8pdUjGLD2LvGza9eLGsVserTtHF3KnF43lpMCWdgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=iHkjlPKH; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="iHkjlPKH"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 15A405D4AB;
	Sun, 31 Mar 2024 21:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1711921432;
	bh=3delPXyKThWm3GsHwsrtU4puYCKj3GO/EmMg/QRdVqc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=iHkjlPKH5KhmIC4IzxRLQPtqG9N36YBtmlerM60mwjMd2z+MLCOW7GZakX9nNxxCC
	 7XvisntOYgwPsmJVzY9h8qPa9QkfO5CFUQfxqaJuuH5l7IV0PHtXCyUoNPBufnaydo
	 Vsv7IW0INgD7QmPvJ1Kt+AAvxJ/se8KWfT0BlikX7/Gns8OhN35C1dAFcc9YrMcnwF
	 SYCodE/WV5TB17ipE+VHBFVnHaScM9v/mCCIQu7/LiVRWLZnPAclyVtW2upPH+pOGX
	 tPfghv+D3LEChdXA1rQUMAQE85tqNB+ky/LNx2Z9TuOOJ4JuYGsn9XjRWRVk5yEYo4
	 znitVXcnA3R8LZxjAitjY2mN3t8UxFaT0yEKSwFeGBYfAptMd/udeDb97CuSwmjR9L
	 Oc1UbaUaI9fH/UmRYdeXEelwINbz9Fq7yB2KiwctJdS0YwW+HTLaQtzPTR1BStg/nr
	 vpLBmidc6Yu1GpJMdUi3zmRVy9YB1iOz9ftcZ/q48V8vhbgEP0h
Date: Sun, 31 Mar 2024 21:43:49 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: M Hickford <mirth.hickford@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, mjcheetham@outlook.com
Subject: Re: [PATCH 06/13] docs: indicate new credential protocol fields
Message-ID: <ZgnZFTvNyInFGn7Q@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, mjcheetham@outlook.com
References: <20240324011301.1553072-7-sandals@crustytoothpaste.net>
 <20240325231609.284-1-mirth.hickford@gmail.com>
 <ZgIKqJaE79-Erzif@tapette.crustytoothpaste.net>
 <CAGJzqs=QkoAU300V-6-w7VqQgG01rY-h5N43WkTy+sJgGV5W2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RWWQHBvYTOHfhmdJ"
Content-Disposition: inline
In-Reply-To: <CAGJzqs=QkoAU300V-6-w7VqQgG01rY-h5N43WkTy+sJgGV5W2Q@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--RWWQHBvYTOHfhmdJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-30 at 13:00:00, M Hickford wrote:
> Would it be accurate to add "For HTTP, Git concatenates the authtype
> and credential attributes to determine the Authorization header"?

Yes, I think that would be accurate.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--RWWQHBvYTOHfhmdJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZgnZFQAKCRB8DEliiIei
gTqSAP97hzFLGhZ1WNiBJtAWgoMnZslm5DZ40dfzwKmSYhQfyQEAoUNysyVqrGYY
ngNjNK46o5BYUuDnirWAeR5eLDgyXQc=
=Ro0C
-----END PGP SIGNATURE-----

--RWWQHBvYTOHfhmdJ--
