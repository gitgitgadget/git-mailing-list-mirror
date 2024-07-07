Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E9722EE5
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720364329; cv=none; b=NAJWSTQ1unztz+jRJPrzdaV2htJ5Of3KzkyISSzqEfIdZU8Rtiahn2wo6yn87pxoNrcxFOQVShHugBtdr7N0ANGzUN7DFRWb6zwF20oFY+PxkqYwxs+CGvGD0uZqk6vKAYRmsLUHO91EpnT6lrH8KHyDwICP9/QY3RFqSwI6/bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720364329; c=relaxed/simple;
	bh=feTx+N7Bn1DExL2Wm5lDlpsTWCxG12bKK4xITgddaZc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOEqyordgUEVQv6+LIGGrp6b3AKh4LRd7GaDuUQrUqtiNfGjvuvhXMYhk19P9VXNsQ9WiJkRGfrSWjuU4hXrEzVkNJXcb65t40cEsd4Emh0essSFJCtcTFrQmSFIJ3jpnMBgJe7e8JZfWuJJ2SYqd2GGY1ECxA4bx1OnhVESZqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=1CbSzWA8; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="1CbSzWA8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720364320;
	bh=feTx+N7Bn1DExL2Wm5lDlpsTWCxG12bKK4xITgddaZc=;
	h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
	 In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
	 Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=1CbSzWA8EO/pcM+2Tgghsfqx0Prws0BO2rhfxhQ8K/tvLImB9YBLsRowxRNsk9ggu
	 K80bEzp8dZlW66/JLxTIaSRnULk9x9KwumlKztQC2G/5Tib55BzRPcVZOXgc6m98mz
	 5/+PObXw2RKdKYSL2MERzwOwBnHpVWNFsPmJ2SV0Fk++pDOoz0PswUm5LUMi2UgpCX
	 39NF8g13Ak8wM+TWnAasZ1CsSe0IVrHdfxUOkbg/8fg+05kROXMM+mjwOo0u4HhrWt
	 Km+YytoPoeoqXkaoj4jT4c5x7UNgciVT+nOv+IDhXDB0cQwnXz7i4XVZblBHJylFPg
	 Nkscgl9VME+yzP1TH/EYUx5b3/6EX9S04UiIaVo0g1ZYzBUOue26c3Vnv53Lm/aJrT
	 pmdCloJ1DMMvaVL4+F4R6T8c7PCNbXZE1vn921xNMshLcee0fCEk2jLa7eta2W4E6B
	 n5Wfz4yjq2nX8zLw/UpY1htb3DpEBy9hy1XheKPx5nFQbqCd/Zf
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7EEFE2099A
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 14:58:40 +0000 (UTC)
Date: Sun, 7 Jul 2024 14:58:38 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: git@vger.kernel.org
Subject: Re: Re: Remove your ZSH completion in favor of the completion script
 distributed and maintained by ZSH
Message-ID: <ZoqtHrKcdliM4Uf9@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
References: <mrn75pj663u6ikkwfnoq6c342l7w5plfeju4ji7norsmlzx4jn@3se3fmuqes4p>
 <87cynpnv8m.fsf@igel.home>
 <e4ylt2rihvm2uc22irsxbeid57ijblioekit3o4xpufflrqwal@5t67kr2a5ahq>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="93khK1Pa7ciTH6+S"
Content-Disposition: inline
In-Reply-To: <e4ylt2rihvm2uc22irsxbeid57ijblioekit3o4xpufflrqwal@5t67kr2a5ahq>
User-Agent: Mutt/2.2.12 (2023-09-09)


--93khK1Pa7ciTH6+S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-07 at 14:47:06, Doron Behar wrote:
> They don't perform any version checks as far as I can see in their
> implementation.

This is true as far as I can tell.  In many cases, the built-in
completion can take advantage of --help output to find the proper
commands, and usually it can intuit expected arguments and such.

> Almost all commands that the ZSH team maintains completions for, don't
> perform version checks and the maintainers of the commands themselves
> don't bother taking responsibility for that and usually users don't
> complain. If a ZSH user notices a new command or new option missing from
> such a completion function, they can submit a patch to the ZSH project,
> and setup a workaround until there is a new ZSH release with their patch
> included.

The only downside of this is that zsh releases very infrequently, so it
may take a year to get these changes into distros.  I submitted a change
to zsh after some Git version changed one of the rebase files, which
broke rebase detection, and it took some time to get that out the door.

> Besides the option of living with this potential version mismatch
> imperfection, you could also ask the ZSH team to remove their
> implementation and start maintain their implementation here. However,
> they might object because not all distributions will accommodate to this
> change in both projects...

No, please don't do that.  I use the built-in zsh functionality for
completion and things like version control usage and it works very
nicely.  One of the advantages to using zsh is that it has completion
built in and doesn't require external dependencies for most of it.

The only time I've seen problems in the zsh built-in completion was when
I was dealing with a large repository where getting the list of files in
a repository to complete a filename (e.g., HEAD:<tab>foo) took too long,
and I've just made it use local files instead, which is acceptable.

> I personally think that Git is a stable enough project that the commands
> and options don't deviate enough between the different versions of it,
> So it'd be easier for you and for the distributions if you'd let go of
> your implementation.

I don't think it's super necessary to get rid of either one.  The Git
functionality is primarily based around bash, which does need this
functionality.  zsh doesn't, but it can be used there if you want things
to work exactly as it does in bash and want to have the latest version.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--93khK1Pa7ciTH6+S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZoqtHgAKCRB8DEliiIei
gbpPAPwNEOuMRHCorhLhwSL3awdPL3uch0eM5eZF9vbFAPgQ/gEAsNOXFRv0kFbO
QUv/SNsUYQjH7FkEfHfqdNNrBIaXQwU=
=PjV7
-----END PGP SIGNATURE-----

--93khK1Pa7ciTH6+S--
