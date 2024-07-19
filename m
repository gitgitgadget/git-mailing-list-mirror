Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD1B4174C
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721420042; cv=none; b=gAKHkR21hSIcs7Ja2SjHHDVG3XKRgzu7Pwh6Zolh8xAT508uZlbPUhlSF7ux9JPpRhzEYhHuLuai32TCi/X5EOHfQ5IuyHLxZkE1k9ki//hNxhdRL9JpffLRbqcZ49n2a5LjFw5RI34VzSl8RXIDLeW56c814UGo+fb/pzS/r7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721420042; c=relaxed/simple;
	bh=R5mqM0zs0e/PKGrNTqA+Gj/typw0alU83m/RtwXjSuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeL3TWK3fRMkFrp1JUarTykJw3R9CDb1EewLX/m6QSlu6uYEGRDp6/oJTvSyvK4/p2DX6Ln0L5TgaBu8H7byVKyO39xFdAvJq9eBcc4FxW5qaABKYlKWSRVl7AgTVremORtMbDOy47TVPUvDBsk1fBjqPSKwUNNA65w+x0c8jEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=X07fLN1H; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="X07fLN1H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1721420033;
	bh=R5mqM0zs0e/PKGrNTqA+Gj/typw0alU83m/RtwXjSuI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=X07fLN1HBnuqQKFMEOahkp86Sved5juX6+EuvXBX2XG1fVbzejk3RxVkVjs8gcl+p
	 tvSrJMiXp9lFc6V9yQdsTjMNaNINYX9DrgXQnEv1zbrd5S59r0Sgrj3RITd74nesyt
	 ArABLh4uemB5H6P1UAw0SNFdu2y9Sh66UyG4UJ/aUgZ6sp3cwNYgSkvIG7GS0oDbbN
	 fwGeobNLvyedvjGMnMzcex/iA+CAU1zWHm7O7iAUcmHCaPY/dagwIuZtzKMsBdbFz9
	 mZy1l9bmMM02aLMBJksyaVWNexfuUMk0qAymaeERV6R6+ZgNGWa/uTa8tqgq2qR4X5
	 xOyS4hJk+iVbSJaDkH6WGxN3c5IWdPwlByK0YGvbdJTZuqNAHXDGRw3Pr92U/ZuGBq
	 bMShIu1bXRn112oQD9m9flmILYrTvQIScrjoDKDPeh42KbA9cHPcgpYEXEufLXRg3x
	 lO2JlRx4T8G2eX4Ej+DPbmFH57iNNOUFywkvsCxjw51/kPyjDm6
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9A801209B3;
	Fri, 19 Jul 2024 20:13:53 +0000 (UTC)
Date: Fri, 19 Jul 2024 20:13:51 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Roman Dvoskin <rdvoskin@mytechnologyco.com>
Cc: git@vger.kernel.org
Subject: Re: Bug report
Message-ID: <ZprI_wP1km8eA7HA@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Roman Dvoskin <rdvoskin@mytechnologyco.com>, git@vger.kernel.org
References: <CAKexjB-+6VXE8YXrc1YaOVE6bKs05Ty4XHMSBPRHUcUrxpp31w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zHL/A/dqcavunPUL"
Content-Disposition: inline
In-Reply-To: <CAKexjB-+6VXE8YXrc1YaOVE6bKs05Ty4XHMSBPRHUcUrxpp31w@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--zHL/A/dqcavunPUL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On 2024-07-19 at 18:34:29, Roman Dvoskin wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
> I renamed an existing branch to a new name
> What did you expect to happen? (Expected behavior)
> When I git push I expected the new name to be used to match the remote br=
anch
> What happened instead? (Actual behavior)
> I was prompted to use git push HEAD:<old_branch_name>
> What's different between what you expected and what actually happened?
> I expected for the new branch name to be used, as if it was always the br=
anch name
> Anything else you want to add:

I'm not sure I understand exactly the message that you saw here, and I
suspect if I don't understand, it's possible other people on the list
don't either. Could you copy and paste the exact output you saw here so
that we can see what the prompt looks like and the exact response you
saw? That would help us understand whether the behaviour you saw is a
bug or not, or if perhaps maybe the documentation is unclear.

Also, to be sure I understand, you did something like this:

----
git branch -m foo bar
git push origin bar
----

and you expected the local branch `bar` to be pushed to the remote branch
`bar`, correct?
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--zHL/A/dqcavunPUL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZprI/wAKCRB8DEliiIei
gamDAQDGcmwsHhryl7D/fp5X3/Mc6DURUauJdbNgEPvc2CIH1AD/WvFejSjy2c4l
8iPZFH6L1ujMzIlUG7+ojLBClfr6TQQ=
=nFBB
-----END PGP SIGNATURE-----

--zHL/A/dqcavunPUL--
