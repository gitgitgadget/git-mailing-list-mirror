Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0769D83A0F
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 23:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711409844; cv=none; b=Dce26p7IQiAI4v1TzeOHZ3frRyGNoaRMTdWJeKrpnHaPJf6ojsXCh/oTa6gMUsAj8b+csWr+TvOwO7K9sBX5xfF9Pi9Th74mOzG/KDW4dnjfi0NvroytZJRUXyW5TEKci5js4ugoMX5ntHfem27xN7Uk1pvXKZyhDzQiQTJIFMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711409844; c=relaxed/simple;
	bh=LHN/Y2h+tEvcgRH6wG4yGMNs8JKoPHcdLkmz+NA1/Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+n1+RFppv7Dno4Djm4YghKP693hraRSbz6DB8aDerDfLbZ1hFzfjGmu15gwFVhCE7kLKZCZGElnocWkclQdzYqDOZxuv6pHfudjMmGfWm6Iu6sHx23PpOyve02jjfDvM975/LD+hxewTKFYeV1e+uUWKR+7NsulGqTBo0gLeEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=1JRO6+9T; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="1JRO6+9T"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D1AF25CBB4;
	Mon, 25 Mar 2024 23:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1711409834;
	bh=LHN/Y2h+tEvcgRH6wG4yGMNs8JKoPHcdLkmz+NA1/Gk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=1JRO6+9TX6fbLHG/OVO6HR72nL/Q1KeFPMm2Voe6Ov+RLMtauIyLtomvCyJcCpyv/
	 Ok0aqug1gCXflazGKQ2pnvvpiKmArlMsHnvdXhG2AfnUZQl4pOlhvyRNFOnp59F8ye
	 Kqx4ZDp6ZhYLV58h8JHkO1WqeaVw4cL0cc07WRmq8UlfKJT42bVlSuBjq9IyblF8MS
	 Kr5vgQfMW+SuMc8m4wGjhuQ4QYHMJYyqzD/a5+1VN5oLqB0iQ0XJRsSiSjDy9l36RK
	 YwUnNHOaEgFh35vCYfQWUM1MLDzr//K7pNdEB6oVE5fmmceL3hVgl2uYkAUu+Q36ow
	 0hRI0qSZvwQoCxDwiQlLHyqk+HUUYQ4Ph5sJ0HAJkBdhZE6GxTSmjxhK4d1M4Z8NaD
	 OvGMy/z+nonHv3+M7nqu3xM/i/uAwQ3sherIa1Ss+tHSpn7zuv0p/N4YKJK7s84ngE
	 iK5tbMNdQBD/A/RCo+bdpQxTkAXJrSpu6pIhiNNOHpwVFOM1n3p
Date: Mon, 25 Mar 2024 23:37:12 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: M Hickford <mirth.hickford@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, mjcheetham@outlook.com
Subject: Re: [PATCH 06/13] docs: indicate new credential protocol fields
Message-ID: <ZgIKqJaE79-Erzif@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, mjcheetham@outlook.com
References: <20240324011301.1553072-7-sandals@crustytoothpaste.net>
 <20240325231609.284-1-mirth.hickford@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N3IY23O3hbdaKI4g"
Content-Disposition: inline
In-Reply-To: <20240325231609.284-1-mirth.hickford@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--N3IY23O3hbdaKI4g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-25 at 23:16:09, M Hickford wrote:
> > +`authtype`::
> > +	This indicates that the authentication scheme in question should be u=
sed.
> > +	Common values for HTTP and HTTPS include `basic`, `digest`, and `ntlm=
`,
> > +	although the latter two are insecure and should not be used.  If `cre=
dential`
> > +	is used, this may be set to an arbitrary string suitable for the prot=
ocol in
> > +	question (usually HTTP).
>=20
> How about adding 'bearer' to this list? Popular hosts Bitbucket
> https://bitbucket.org and Gitea/Forgejo (such as https://codeberg.org)
> support Bearer auth with OAuth tokens.

Sure, I can do that.

> > ++
> > +This value should not be sent unless the appropriate capability (see b=
elow) is
> > +provided on input.
> > +
> > +`credential`::
> > +	The pre-encoded credential, suitable for the protocol in question (us=
ually
> > +	HTTP).  If this key is sent, `authtype` is mandatory, and `username` =
and
> > +	`password` are not used.
>=20
> A credential protocol attribute named 'credential' is confusing. How
> about 'authorization' since it determines the HTTP Authorization
> header? This detail is surely worth mentioning too.

I don't want this to be very specific to HTTP, so I don't think that's a
great name.  As I mentioned in the cover letter, I might well extend
this to IMAP and SMTP for our mail handling in the future, and that name
wouldn't work well there.

I named it `credential` because, well, it's the credential that's used
in the protocol.  I feel like saying that the field represents "the
authorization" sounds unnatural.  It's not wrong, per se, but it sounds
confusing.

I'm open to other ideas if you or others have them, but between these
two, I think I'd prefer to stick with `credential`.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--N3IY23O3hbdaKI4g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZgIKqAAKCRB8DEliiIei
gdJEAP9eQ9PvIhhqzdbEIfDIWs0ln+XMLJiTEeBgTMs+zoQsIwD6A/XWXMc6bZev
Cp6HaUPaimbtbAsq04vo1PsXB6MasAo=
=orkE
-----END PGP SIGNATURE-----

--N3IY23O3hbdaKI4g--
