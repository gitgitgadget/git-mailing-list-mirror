Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D155A3C01
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 22:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755468720; cv=none; b=DEA6omInsD6qkXuDL0/ghkVIvJNaRL/0k1aoFbT3KiUp+Xv4Wr6e9J4DhQnUAJOfjgfrMtAHkemssYlTHzWFvbLB2ujBHmCUDUZePO8gxKNXRrIwwbvuc7BRsGAWOOBXJaSJSfPMSKjWKiNpsiVTptmjDV0AMgAwCvHjM6A0XTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755468720; c=relaxed/simple;
	bh=wq9gsRTNsnJSwu9vj6DgilYPrSPh+XNoB7nvWvc7kBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b33+lpgbYzmeed/iCUkfDMROulaznByLaFWb5NbS/lYLDVzXNdmLFmrolm2B5I33ooDBFryeTMc60jOg+jiVN6xp439ODs95Jzeu395bU3GX+CWi7jVJe0lVa04YTc/6nZWKLJNhcxqRDoxwWv9ZoYl9ngWfo046aRLureh5VWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=CboZIXo9; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="CboZIXo9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1755468709;
	bh=wq9gsRTNsnJSwu9vj6DgilYPrSPh+XNoB7nvWvc7kBk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=CboZIXo9lXlzYU9qluaoAIt29/JLHtIS714hbY+TLTdJxEt+GjT66uKIqxQmyfRLv
	 zm7JfNS5+oc6eQCe6U+TjGFI199bEc1EoroHoQ8biCT68pzVtsLsAnma+IXquslZZB
	 P3CepJ/hNsKDY1fK857a9LjubDy4mi95iWoKJWUbDJgJetGpnGvzOdKO656BnQsCOO
	 btCG8MqS9zyneYeNbMFfvvDCl+7bbdLdyoKxnYLBZeRRxSBLHvj9K4F8/mFgm863J+
	 Qlsy35Nt9e1Ci/Npcbs5OnlbpPL5Zjgxd5AUeZ6cjWy0RYZyJF6tvacd8HKag21xmP
	 E8N9ofyUZfzmFIb0NGcY0elR9sLhg5978//FHgQ1dZVAkniJwmps0nFqhjmraqgGDh
	 nvvPRChZlUvTIqZNMMnM0JacB+ZH269KdQajbRro5PLMPehNxrYoO7kv/c39PdzqtV
	 4zzZo6Q5E3llo9/jYCUQ1IGfDOrBcqoi2yYQDlG4rBPyNGm5d01
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:4838:5608:ba70:40d3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 92350200B4;
	Sun, 17 Aug 2025 22:11:49 +0000 (UTC)
Date: Sun, 17 Aug 2025 22:11:48 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ron Ziroby Romero <ziroby@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFE] Add JSON output to git log commands
Message-ID: <aKJTpJL3kEyqDA6P@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ron Ziroby Romero <ziroby@gmail.com>, git@vger.kernel.org
References: <CAGW8g7mV6az3ybYf3uzHYQTGLDwc34eebZnha1EQ3Sb6B8E-fQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="570JNeSCqkbzSSbB"
Content-Disposition: inline
In-Reply-To: <CAGW8g7mV6az3ybYf3uzHYQTGLDwc34eebZnha1EQ3Sb6B8E-fQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--570JNeSCqkbzSSbB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-08-17 at 20:17:46, Ron Ziroby Romero wrote:
> I would like to add JSON output to the git log command.
>=20
> ## Motivation
>=20
> Machine parsing of git log output is prevalent, but git only provides
> human-readable output. Having git output JSON directly solves problems
> with the format option or third-party tools. Git has the information
> in a machine-readable format. It should output in a machine-readable
> format. JSON is ubiquitous and easy to generate, and therefore, it
> makes sense to output JSON.

Git provides plenty of machine-readable formats, to be clear.  They're
not typically structured in a standard way like JSON or CBOR, but many
forges and other tools do successfully parse Git output with a variety
of tools.

> The author of one of the third-party tools says that JSON output is
> the natural evolution of the Unix philosophy and should be done
> natively for all tools[4].
>=20
> ## Current behaviour
>=20
> Git log can output human-readable output in several ways. However,
> outputting in JSON requires third-party tools or hacking pretty
> output.
>=20
> ## Proposed enhancement
>=20
> Add a =E2=80=93pretty=3Djson flag to output logs in JSON format.

I'd like to hear how you plan to deal with non-UTF-8 byte strings since
JSON must always be valid Unicode.  Most data in Git is only by
convention UTF-8 and can actually be in other encodings or no encoding
at all: refs, commit messages[0], and author and committer idents.

What would be a good idea is to add a byte string entry to the JSON
writer and use it for these formats.  If the data is not valid UTF-8, or
if it contains a % sign, then you URL-encode it.  Other encodings are
possible as well, but not JSON escapes[1].

Other good options would be to use CBOR instead, since it provides
native byte strings.

Bad options would be to use U+FFFD, since that makes the output useless
when you hit one of these cases (and I can tell you from $DAYJOB that
they're not that uncommon) and to just shovel bytes into the output and
let the reader be sad (which will definitely make the output useless as
well as result in angry bug reports to the list).

As a note, I think you want `--pretty`, not `-pretty` (we use two dashes
for long options).

[0] Yes, they declare an encoding, but it isn't always correct and the
encoding someone used is not always available on every system.  I saw
someone in the Linux kernel history write "latin1", which is not a valid
encoding according to Ruby, which I was using to parse it.
[1] `\u00ff` represents U+00FF, which is equivalent to the byte sequence
0xc3 0xbf, not 0xff.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--570JNeSCqkbzSSbB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaKJTowAKCRB8DEliiIei
gaLFAQDA2KscJ9MB4g1LdUJhq0wZgDyW0J0ptixqtGmxWVlbywEAx1iUr+e08+fN
v00caZXI3QzV6ZzdIlMSKGAai158oQQ=
=3w5k
-----END PGP SIGNATURE-----

--570JNeSCqkbzSSbB--
