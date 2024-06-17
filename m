Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE631FB2
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 00:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718583764; cv=none; b=H7kKkXll/EeammiElyEMsiH0LZpCb9HQCtGVYvygqT2sZdYgejLDWdy9rx4gxbA12B8HMOhd8dhZajvGls8x97OVN4NBY37PMV+XyssDLp7DuRBcH1RV+G8J+4zdGRZHyPWIJxBK/q0rWidSTuCsdOQ3fADGD16xTmD3BrhzMnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718583764; c=relaxed/simple;
	bh=2xk9d+JfBQdquGF+NPHXuAQURrGCpcQl2bw293fUenI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWlzhImbDoAR7fS1dnkvLrjLR1KBBE8TUxlUo0hMt25ooywwTZv9kRHrgJgj9KMUII7URV3RGv1mlQ4X4XhPHBNeA8mXlMqVk1HCmYM2opgVsaE28qOJuJKEotQsjPq6spK4zOCw3XQIG1CxeDi2QLPAubhdzgLcPs85EH/Qnww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=K0ZgBLMD; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="K0ZgBLMD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1718583753;
	bh=2xk9d+JfBQdquGF+NPHXuAQURrGCpcQl2bw293fUenI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=K0ZgBLMDx/f3UmXCIuyekcudoQtBn6PMwdF+U4NTxFjO+2NiPdEjcATTEN98pPaBS
	 DE5v7aZi1gQrRZgc36PhyDHRJHacTNNXvkDkkurXb5yN9BYlBCNqzryrJBzw0RkRVF
	 N3Iw30bBJn7bU9cwek/4dlCCw+VIp6j/x8LYomPHmR5qISr0APmA5X9bBC77z/zKEQ
	 LDeuvS9KkTptc5kaU6nU1EeUpOYQnBI197SAhwZ20+dNSL0ceU6px7yjYZWKzxuoXt
	 88kGMHemXoCY1FIWUATkGU0rbnpruC9sGA1/Q4q9XsyjvgELXt5LqhS1LzML8t3LQx
	 PMh1bf/8+WOjpvkBcMZO8zPIfaVR2CLbyQAON6mstS+xMOKXrGWgkEic8H3Z2Z3ZeK
	 2gofBuW5918RT8bp9nV4o7DBJQbkVh5vvpIKL1mDbB7OheO7FyDusjSkuJQEKbVp0j
	 Vr/LMyiv6rjknd0kThRCgnPPOlhB4R43Gjm9yGvdNoyM0u0vpvL
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D2E092639E;
	Mon, 17 Jun 2024 00:22:33 +0000 (UTC)
Date: Mon, 17 Jun 2024 00:22:32 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeremy Baxter <jeremy@baxters.nz>
Cc: git@vger.kernel.org
Subject: Re: git send-email SMTP password command
Message-ID: <Zm-ByA09z3jhij6u@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeremy Baxter <jeremy@baxters.nz>, git@vger.kernel.org
References: <87ed8w33l8.fsf@baxters.nz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="87kwov4cPCQxDxsQ"
Content-Disposition: inline
In-Reply-To: <87ed8w33l8.fsf@baxters.nz>
User-Agent: Mutt/2.2.12 (2023-09-09)


--87kwov4cPCQxDxsQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-06-16 at 22:49:55, Jeremy Baxter wrote:
> Hi list, I was wondering if it's possible to configure send-email's
> default SMTP client to execute a shell command and capture its output to
> get the SMTP password rather than prompting the user on the terminal.
>=20
> Would anyone know if this is possible without setting
> sendemail.sendmailCmd?

You can use a credential helper, and that can be a shell command.  For
example, you can do this:

  git -c credential.helper=3D \
      -c credential.helper=3D'!f(){ echo username=3D"$USER"; echo password=
=3D"$PASS";};f' send-email ...

This resets the list of credential helpers (with the empty value) to
remove any you may have already set, and then uses that shell script to
read the credentials from the environment.  The documentation on the
protocol is in git-credentials(1) and gitcredentials(7).

You can also use your regular credential helper to store the
credentials, in which case you need not set any -c options at all.

Note that, in general, this only works for SASL authentication that uses
usernames and passwords (e.g., PLAIN, SCRAM-SHA-256, etc.), and not
things like GSSAPI (Kerberos), but you also don't need a credential
helper for GSSAPI.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--87kwov4cPCQxDxsQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZm+BxwAKCRB8DEliiIei
gRA1AQDDJ5oP+/etSR7R/jCGVn3d4477XgIXSGTuyRutyR7bKQD8DwEewSOpZSxV
fhnl6WvcEctJUr5arD6UNbr/yO1/6gw=
=l4QC
-----END PGP SIGNATURE-----

--87kwov4cPCQxDxsQ--
