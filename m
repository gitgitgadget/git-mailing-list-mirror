Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB531224D7
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 01:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739757543; cv=none; b=qYDPw7UjuxzKsE9+JEsQLLrubNEt6UsKkTAhAvI6bUbRa1d/tOBHFTbvm3uFliVINdxN7Jaiu04YKMv9zOpYokD6QFGUzzBLgOC5C5PjaqcKzaaEAk+52OMeyRBC7Cu6dVTnMQmHrXH/F0lhK0vnJFWSy4EUC2LGdGrYREzGY/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739757543; c=relaxed/simple;
	bh=ki68WLjvu1TLJaJSd4NGuD9Va+ErxUsSmg+rJERQOkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLaEW8P3xRU5UawQAdG/Vq8bb191zdfeQPl+n4IuOS8oLDFsBV6WrTKl+2ytDlbOG4NY3f5HKFy5/AVM8xzjJtivlXtWSx1bPSZDABdR5MSMfgKb70MHQokowc8+aDZzxtfbVoMPPSKxgWU/Y0qUnJY0nKvtprkExzXikQJ8zPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=h2jb4CKB; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="h2jb4CKB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1739757532;
	bh=ki68WLjvu1TLJaJSd4NGuD9Va+ErxUsSmg+rJERQOkA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=h2jb4CKBJJjgacaDiOw/0BnuqwBVLyCC9OrSqUNdoGGHWn93tAtyrxRWMkUvW7MUv
	 UYLc5+XRuw/PF2hJi5nGshsDGkiCnUOXWFeiSsrOs0/1zzcVEU8Ru/LR3qMSaTaPp7
	 Ikjc+UjFZjnWrlyB58ZtSuG8HMcbIJgIwmSr3KHdo3koy70UB4g8v6Ot9rrKhUmusb
	 rz6egnVoWL80U2DlAibmIGCYiA2bcQGvvC5RLhk2ZWSZ04icOot196iO+vHUfHzI1A
	 oGhEQUZu3iLNa4yQnZJN40niruYS8eu4FQRjCDLKAqjlVqkFWkpm1z4V6gO0DfmTMS
	 I8YqWDJt6XzToOnWLOtuozOvPrYJPU53Pw+iAqFho/+c9Y8masj+bO3ILmscMxVMtT
	 HFICKtjFCv5dUiTXtzWCC08QV9eVSYU+pgnO5X3XoeRxwV2BPjlUcjYA4In0KC8VL8
	 x+3KbLrPhPzN08sQVWczR2ayBKeTbpucu4IMaKz59LDgDztEux8
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6A52120078;
	Mon, 17 Feb 2025 01:58:52 +0000 (UTC)
Date: Mon, 17 Feb 2025 01:58:51 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jared Van Bortel <cebtenzzre@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Crash on empty pickaxe argument
Message-ID: <Z7KX2y-dXaZuPrW4@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jared Van Bortel <cebtenzzre@gmail.com>, git@vger.kernel.org
References: <b59b75a1ad77f59cc8d81e2dd5cc9607e53b50af.camel@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cvLiv1M13aML9ro8"
Content-Disposition: inline
In-Reply-To: <b59b75a1ad77f59cc8d81e2dd5cc9607e53b50af.camel@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--cvLiv1M13aML9ro8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-17 at 01:24:14, Jared Van Bortel wrote:
> Hi all,

Hi,

> I fat-fingered my enter key today and noticed this crash:
>=20
> $ git --version
> git version 2.48.1
> $ mkdir foo && cd foo
> $ git init
> <snip>
> $ git commit --allow-empty -m "foo"
> [master (root-commit) ed4e080] foo
> $ git log -S ""
> BUG: diffcore-pickaxe.c:241: should have needle under -G or -S
> [1]    65421 IOT instruction (core dumped)  git log -S ""
> $ git log -G ""
> BUG: diffcore-pickaxe.c:241: should have needle under -G or -S
> [1]    65457 IOT instruction (core dumped)  git log -G ""
>=20
>=20
> Well, it says BUG right there. It probably shouldn't crash. Relevant
> backtrace for -S:

Thanks for the report.  I agree this is a bug and we shouldn't crash.  I
think the right thing to do here is reject empty arguments since those
aren't actually very useful, so I'm in the process of writing a patch to
do that now, which I'll send out either later this evening or tomorrow,
depending on when CI finishes running.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--cvLiv1M13aML9ro8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ7KX2wAKCRB8DEliiIei
gWDAAQDUoTU+MItzb3AIjuAD6qbrlfOLnro1/9mfQnePIs3mhAD/Q4emDusi3tmN
2cOQKYbpBTFp+7AXIASPkfJDz6FJeA4=
=eM1y
-----END PGP SIGNATURE-----

--cvLiv1M13aML9ro8--
