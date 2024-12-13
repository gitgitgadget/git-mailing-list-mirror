Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6030E748D
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 03:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734061743; cv=none; b=Gw/aATzilQW3Zf5bw3F7mDfK36rD5ylnVEvm94cC5LpQJcRKylJ5CCh+/QKHJlV4Zfn0lrbjz6AsddAR5uCQpl5itdIBaiXBT4T7p7xgvjMGMTP3B9jn+0uGlrl4BypHw+lRBqy3lSlQlE/z23L6cOWnj+k25SyEY35K7/ZULGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734061743; c=relaxed/simple;
	bh=lbOyOuMfXHeeqWYSgeJ/bwGkcGD/YEgJb1E9/KviWlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkrPGPea8xnKYT3LMgOQsvZObFYkGFamByaiHQQpEVGqflkXQX8oYoNqFPidQpPc/lvbiMhdcUVU7MNtSL2YP7agSggzg0XE/s4B7A3jTvLoE9dE3f6/n2Zt/5d4S/rp/1VORT6B7x5aowJmgPNZ1BTSobskvCspyljWFd4cJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Om0RRepu; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Om0RRepu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1734061739;
	bh=lbOyOuMfXHeeqWYSgeJ/bwGkcGD/YEgJb1E9/KviWlY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Om0RRepu5+84fRWwQmlGx21IixHgqo1APe+SgyAcVF+m4b9od8t2v8RVbBSjuBFHy
	 VtM+lLTRjpbHAJ2fVDN9bw2G1JKqP7Yf/6rnIYGOtVAffJnhIHGCbSaNXiFxUeE1g8
	 c43VBeQUzrVALuxnhXntS+HHP2JDdKqJLuguPzSCc3YJo+3uB16/+iTWlbP/8tmgef
	 bPZy563KqZG/9QooTxT1QLgupNQsjml/VkZ7XME1ZJpZTAtYvMG/it8eMFvqUX0DFc
	 dsUIihlbeAjUcUWYBI9Q/16+rqgqLrzOJLtTSSjz1/nzvpzN2J3sXaGcIlv8FgRG5z
	 mz2PmBSHoshJq0prOI2xDMaeRCaSy5umGqkQ/uY5SrgMnKWwJKIftcqzybueas5NNf
	 u1VAryfZllm/V9tYcCsXbCBz182/aj56eW4adOjcYILBtreFyndqK1W1JzCJFIaj/O
	 +w3+GeHdP2VB2WUuoU3kwv/ouF/HcJ+6qBXO4v0nDAvTlhr6n+1
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 56480209AD;
	Fri, 13 Dec 2024 03:48:59 +0000 (UTC)
Date: Fri, 13 Dec 2024 03:48:56 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Francesco Occhipinti <Francesco.Occhipinti@tracsis.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: New checkout --track behaviour?
Message-ID: <Z1uuqKI_2rb0HXhP@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Francesco Occhipinti <Francesco.Occhipinti@tracsis.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <DB9PR08MB7194822B81F17420B2D3C149903F2@DB9PR08MB7194.eurprd08.prod.outlook.com>
 <DB9PR08MB71949D21F5F0E81911F0D50F903F2@DB9PR08MB7194.eurprd08.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TsHs1XlbwCY4yce0"
Content-Disposition: inline
In-Reply-To: <DB9PR08MB71949D21F5F0E81911F0D50F903F2@DB9PR08MB7194.eurprd08.prod.outlook.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--TsHs1XlbwCY4yce0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-12-12 at 10:29:59, Francesco Occhipinti wrote:
> Hello,
>=20
> Did the interface change in recent git versions? I am pretty sure i
> used to git checkout -tb new_branch, now getting error: option
> `--track' expects "direct" or "inherit".
>=20
> User `geirha` on libera#git helped me troubleshooting. They noticed that:
>=20
> - git help checkout differs in its description of --track between
> =C2=A0 2.34.1 (ubuntu 22.04) and 2.43.0 (ubuntu 24.04), so looks like it
> =C2=A0 did change recently
>=20
> - according to the commit message at
> =C2=A0 https://github.com/git/git/commit/6327f0efed36c64d98a140110171362b=
7cb75a52,
> =C2=A0 -t is supposed to be equivalent to --track=3Ddirect, so likely a b=
ug
> =C2=A0 rather than intentional change

`-t`, or `--track`, now takes an optional argument.  Before, it didn't,
so `-tb` was interpreted as `--track -b`.  Now, it's interpreted as
`--track=3Db`, since the `b` is interpreted as the option value to
`--track`.  That's not a valid value, so you get the error message.

This is indeed a subtle incompatibility in command-line option parsing,
but it's not really avoidable and it does occur in pretty much any case
where a short option learns to take an optional argument (for any
software, not just Git).  So what you probably want to do is `git
checkout -t -b new_branch`, and it will work as before.  That will also
work on older versions as well, so if you have scripts or aliases that
need to work across versions, that should be a safe syntax to use.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--TsHs1XlbwCY4yce0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ1uupwAKCRB8DEliiIei
gbZhAPwLk9lvga/akM3ieCH+RpDvNNYEKzI6nvbGMVAo3EX4XAEAiKIDHtjeJZ3D
68pAzD9HI3OUhnDqcybEeDCrdr+40w0=
=2Fpt
-----END PGP SIGNATURE-----

--TsHs1XlbwCY4yce0--
