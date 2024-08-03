Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F6710A11
	for <git@vger.kernel.org>; Sat,  3 Aug 2024 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722706493; cv=none; b=nLZyjBKfGzTxRhNloj2SBzUNkmq7KftnZkdUZY1Q8xS/l+E7P477MsgzFe7OcVhmkOaOPdiaS7K7Jq13+VQV9mzk00hZB/OaglYFDyH5LgxnFd6v3DyEe//m9Z64P69ZKdKdajD+okom5OQEXKvI4D3hOKSM1l9/HfPf8S8b9Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722706493; c=relaxed/simple;
	bh=1ndvqN5tjQLcwpS5U6Gh42IfczWTadWHu/IF9TWGNV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3JTAgu3qsq4p3iq9dMSi+whhE8h81WLbOBBQbvBrUOdcjxGnG9HcykX2OtnFDIdF7N+4FRMrvfpeG7P39FAIo4WRfI2gKM7wFHukCHA56CoxwSe2BHHFeYisLgu8i1KEtqeVwV+Rzdo6VJ15CSM5CRyvdmu7TBFLCUmrBSaUP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=hbERbypU; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hbERbypU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1722706489;
	bh=1ndvqN5tjQLcwpS5U6Gh42IfczWTadWHu/IF9TWGNV4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=hbERbypUi2tP7ONsbbcDAWEbkzjzKwi7jLTzWRmMo1SK9fgCo43K2Zrhq3D8G4QEy
	 U4yQIM2TEyQzb/gkBzCj2m4LWCWgmQsLRGunokM4HjMaSsGbo87PF6wt3VVPZpf8V8
	 HgFVHpKia6795gDlKgpkYQyUKVDvyq+jQknq7OrZgPCBZ30x+tIZj7s38uTzLAtXYi
	 rnXHqZQ+kYd1ZtuZOpClVTM53+3fO8t//MzAxkOw0bF9cBbu7i0pvERblZCVIJx6rf
	 ljoNYSmYwUFlWSetvq7mogniXeHXr5X1VqRfAOquDRIhWNXYlI4O0B0Wj1DOsarf1/
	 fWwPD8gngpXB4H/oiMgXB+hah9Ao1HW9J5ZEC52neZRpn17z6qpfXAHGVUWZchJlIG
	 uJh6ZrJmDT8J4XfMQAzBiFZYMop3tpFwA0V25dm/rXrycRcrz/0hV0GffNLSHe3p02
	 3c3YoGoucRcvHr1x0x8nc2Az2FO01KJyuWGJI9gBXuh6SmVLkDM
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2091A209BD;
	Sat,  3 Aug 2024 17:34:49 +0000 (UTC)
Date: Sat, 3 Aug 2024 17:34:47 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Kim Scarborough <kim@scarborough.kim>
Cc: git@vger.kernel.org
Subject: Re: Git and gettext
Message-ID: <Zq5qNwmTpL1H5LH0@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Kim Scarborough <kim@scarborough.kim>, git@vger.kernel.org
References: <bf5a7771-f616-47d9-a014-f9d3e0afaa08@scarborough.kim>
 <Zq5UFYnWL1jdgDaH@tapette.crustytoothpaste.net>
 <7d507ea2-08e1-4597-bff8-8a2b40a01747@scarborough.kim>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S+pfQlGMQLjiaJ94"
Content-Disposition: inline
In-Reply-To: <7d507ea2-08e1-4597-bff8-8a2b40a01747@scarborough.kim>
User-Agent: Mutt/2.2.12 (2023-09-09)


--S+pfQlGMQLjiaJ94
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-03 at 17:24:43, Kim Scarborough wrote:
> > I believe you can use NO_GETTEXT=3D1 and NO_MSGFMT=3D1 (both must be se=
t) to
> > remove the need for gettext and msgfmt.  The latter can be omitted if
> > you're not building git-gui.  You can see other configuration options at
> > the top of the Makefile.
>=20
> I tried setting both but it still errors out. A little later in the build,
> though.

Hmm, I can't remove msgfmt from my system, but if I put a `msgfmt`
script in `$TMP/path` that contains just a shebang and `exit 1` and do
this, the build succeeds:

---
PATH=3D"$TMP/path:$PATH" make -j12 NO_GETTEXT=3D1 NO_MSGFMT=3D1
---

Note that `config.mak` is not read by git-gui, so you do really have
to set `NO_MSGFMT=3D1` on the command line.

Can you show exactly the commands you're running and exactly the output
you're getting?  Also, what OS and version are you running this on?
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--S+pfQlGMQLjiaJ94
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZq5qNwAKCRB8DEliiIei
gZsFAP4uWoETwDXUNqN55f0TfmR/UA0vol6IgMyrc6CgoxLprQD6A318IXw1YyYZ
6bJ+Kb8XVQfXxfxqw+QjldgNg38BfwA=
=qoh7
-----END PGP SIGNATURE-----

--S+pfQlGMQLjiaJ94--
