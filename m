Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A16F182D2
	for <git@vger.kernel.org>; Sun,  2 Feb 2025 01:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738460687; cv=none; b=jY8kOIcEwpPKZOxxBj7cC8e7/8ndl9vCqae2hRuOiMU8fpxYRIWhsoNQJIApUhc1kArz9Q332ZS0PywsZ3a2U487bgtMe45tVEUNBlvNpxxV/kokdh9ezysX8x/RF1KIZ3zXitR8lKDccdTyt09fMH+g+IadXnysefUmnAsPtdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738460687; c=relaxed/simple;
	bh=jO+HLkFtoQmj5efEugd6jzvAN/IzJAVuDznq4P0qDnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEcs9g2a8LOMMi5gQ6ybYIejIubGNdKR+CnPmx16s9RFe/bquvFanKFWQse9FAstODHDSoeQtseeL6pWfalK3M9ZuhnIWmXRJt0aAOAP7Sf7THZB0ZwDZNlxAbD7E2xcBEIGgRigIAMXyS0+w42FVGHZPFaXKC1gk0BoVPvasu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=03hoz5DY; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="03hoz5DY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1738460682;
	bh=jO+HLkFtoQmj5efEugd6jzvAN/IzJAVuDznq4P0qDnI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=03hoz5DYB6Ln7TnIB/tcM78Y2By5IK4uKjcE5fpgqOe3XmD+QqNYO9bWvsFrOmz8j
	 0FePGYYlBdjfdZn5rLVBBaKh8Thw6s2QoK/pVykQEFylQGNZQHsvICA9D2/5GhHN14
	 di82EsZhF9MLDuMVO/iIIqsUoqZP/YZkkDvHHD2SDgL/LT1wTdlgODlR4StP+W4krQ
	 /juZYej8BZG7eOqt2VcbzrZHFIaPuOILFIZqNc/W+55kbSacuL+5kLzxOn1Sg0FNXj
	 bZMHmpIxOBmi3HnUG+Guhuj6AYIWfqceUQ1vmny8jN21gO17KI5Jz2m8Tjve8jWHwJ
	 sULXNdfEN83+QeJJIHzxbBoOPMbqJeHI1XB3DusJFJhL4gnspTRuxHhyYD6G9qb8Gk
	 pxg+0bm54BiWy76msfrkzvRq9YvC5n18Jk+vNKddEB6x5jvVqQsrHwOj81yHh7EP99
	 2Kjy6ARnv3JCEid1LWiwrE8YbPohHuJEXq59ZNfozbBhMEihnMo
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 93C9020068;
	Sun,  2 Feb 2025 01:44:42 +0000 (UTC)
Date: Sun, 2 Feb 2025 01:44:40 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Moumita <dhar61595@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] Renamed all *.txt files to .adoc of Documentation
Message-ID: <Z57OCCqtQ0JK2I6Y@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Moumita <dhar61595@gmail.com>, git@vger.kernel.org
References: <20250201131331.23233-1-dhar61595@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+CVVPqsMqJUqpOea"
Content-Disposition: inline
In-Reply-To: <20250201131331.23233-1-dhar61595@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--+CVVPqsMqJUqpOea
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-01 at 13:13:27, Moumita wrote:
> All the .*txt  files of the Documentation directory has been
> renamed to .adoc except the files of the RelNotes directory , the
> includes directory . The needed changes are also made to Makefile and
> the meason.build of the respective folders inside the Documentation
> directory.

Hi,

You've sent me 11 copies of this patch, which I've explained on the list
is not needed, and the way you've done so (in violation of the list
convention) has caused it to end up in my inbox, which notifies my
phone.

Could you please refrain from sending me anything related to this
series, effective immediately?
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--+CVVPqsMqJUqpOea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ57OCAAKCRB8DEliiIei
gSvzAP4tTF+yJoclUNmwMm9/Oqu6pcw9MR29CC+Qmm3pnlv0BgD+OyLtaZvFlDZR
isVFJwBGnJc5IaX4haTUw9cr00lbhA0=
=x3nH
-----END PGP SIGNATURE-----

--+CVVPqsMqJUqpOea--
