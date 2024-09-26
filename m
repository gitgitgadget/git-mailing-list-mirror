Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013F028371
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 21:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727384653; cv=none; b=MUNtYIuUPCulTO+lyhMahaznqWjRHtVAaokJgpSNS81SYhGN7BwUCUaVH+8hEuYsTj2jsWw0SHXa+SqMhBa/kD1ByFlf0LkP+1KY1sV3kEaTxKXpe92QMsBCQHXave3WUG5QgWNh2daSTSJCPjL8bNDRIXee+aOQvm+irNi/qGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727384653; c=relaxed/simple;
	bh=rQxGgO6Yzzo6RMVTGsBnmcgSAVdy4srbu35sUMpMqfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baqtfp8oDUwyCSflY/VjQli7z5w9nsk1cizqUB1edS48eGiQYFOZEB/pB6pJDbdYhqJvXk1/5YztTxXgikAN0HCBX4Sn4CL7VgAEtfwwxoKRqwAUlpoyUB9MjG72YhIh9xVslsT27N67jriIGaNcKB923ebZtxE/cVGFYu4OVDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=sYYc1fqk; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="sYYc1fqk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1727384649;
	bh=rQxGgO6Yzzo6RMVTGsBnmcgSAVdy4srbu35sUMpMqfs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=sYYc1fqkFWXYDwnlmPXIQG4zsawzJbzTWbiZhncTBkeW2Q9JL7oV0l6UN/wP5s43j
	 xDqq3aQ6f+8OqtGhv529O2xQ4hUGssT7D1/BsbUFBGw+EadSm2lIdgDCHySbQjS0PW
	 bl+r4tXaSXnQmaT6MyaldsKHILBxNPFcmnsmTqB767lYhidaLCbNkQaXtcZXWbaQIV
	 cTvZVggH33g4pdJlbGg/1U92OeaRUKYXy6RGYosX90PpNWPh1eqOwIQJ7uOg/retyG
	 aWM/qXx7AL/Ze6lAWe39XtWmLPez63u33bxKCWZ168MFC1UwM+FGuzvP+CMSzMOgmp
	 8TKqRrah1Udb6q/25hoLS1saF702X2ONDE9vTCR/ojLVnZrvW0Bf9qieABsNgjS5EI
	 kUaxtrmm3H2e8358qGej1tRxtWUnJPppu0xEA8JMDG2yjZbRfIS6uBG0HtSe6q6Lz1
	 9J+Qcxt25lHaTdsoy/0JOSHNpPvGkq39cb8FouUtFAje4KeDLRk
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 921B420073;
	Thu, 26 Sep 2024 21:04:09 +0000 (UTC)
Date: Thu, 26 Sep 2024 21:04:08 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Sean Allred <allred.sean@gmail.com>
Cc: Ron Ziroby Romero <ziroby@gmail.com>, git@vger.kernel.org
Subject: Re: Pretty output in JSON format
Message-ID: <ZvXMSKaUWWA-MG9J@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Sean Allred <allred.sean@gmail.com>,
	Ron Ziroby Romero <ziroby@gmail.com>, git@vger.kernel.org
References: <CAGW8g7=21pPAgCixjpayEvmw_ns-hcB4e59NP476TKtCRXHPXQ@mail.gmail.com>
 <ZvM39VNFptcfwMGk@tapette.crustytoothpaste.net>
 <m0r097mv19.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0OUEqjPJz4TWHLnK"
Content-Disposition: inline
In-Reply-To: <m0r097mv19.fsf@epic96565.epic.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--0OUEqjPJz4TWHLnK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-25 at 18:45:54, Sean Allred wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > On 2024-09-24 at 21:52:35, Ron Ziroby Romero wrote:
> >> What do y'all think?
> >
> > I think this is ultimately a bad idea.  JSON requires that the output be
> > UTF-8, but Git processes a large amount of data, including file names,
> > ref names, commit messages, author and committer identities, diff
> > output, and other file contents, that are not restricted to UTF-8.
>=20
> This strikes me with a little bit of 'perfect as the enemy of good'
> here. I'm sure there are ways to signal an encoding failure. I would,
> however, caution against trying to provide diff output in JSON. That
> just seems... odd. Maybe base64 it first? (I don't know -- I just
> struggle to see the use-case here.)

I understand JSON output would be useful, but it's also not useful to
randomly fail to do git for-each-ref (for example) because someone has a
non-UTF-8 ref, or to fail to do a git log because of encoding problems
(which absolutely is a problem in the Linux kernel tree).  "It works
most of the time, but seemingly randomly fails" is not a good user
experience, and I'm opposed to adding serialization formats that do
that.  (For that reason, just-send-bytes that produces invalid JSON on
occasion is also unacceptable.)

If we always base64-encoded or percent-encoded the things that aren't
guaranteed to be UTF-8, then we could well create JSON.  However, that
makes working with the data structure in most scripting languages a pain
since there's no automatic decoding of this data.  In strongly typed
languages like Rust, it's possible to do this decoding with no problem,
but I expect that's not most users who'd want this feature.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--0OUEqjPJz4TWHLnK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZvXMRwAKCRB8DEliiIei
gSewAQDf/0B8CcTtfyVWzGNwJagIuFlW0pCxacpq2AXhDbazjAEAt9PNql80LGBN
GeWOJ9taT+lWvVpeXkX9J9VBomDhPwU=
=54G1
-----END PGP SIGNATURE-----

--0OUEqjPJz4TWHLnK--
