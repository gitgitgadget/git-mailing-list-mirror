Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFE434BA2F
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 00:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758242359; cv=none; b=Q3EUVZWikU+FnPmCMY7nFiICZxVGgm9V/Mc1xQw329rFNdypuGAwJtw2bsXGQkyT5WwqIfkCB102JFNavIM2qUbHDoesKFlLA8zuCnG1Udhr1yf5qwTd3BnGv1tCS0xveRUdOMKHuZhdmtcrX72Qvwe1pN6cl1g1bP96f7n7RNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758242359; c=relaxed/simple;
	bh=ZtD9zl4DENeCcp0z/VMxQ0Rd+BXzfSA9wkKb1amMBj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Owfz0Xe2bBOi/znrTr8rtC3aTs177f5LIpyv/481oaGjmnG8hYRdl4zomd4bNyrJrn1oXzB/SnNuqWPjCQPq5yBqHDwvjRG3qX/NMgM36jqTfGU5XQmsjAvgR53VSqMgwrLEkoQejw7rx4JFOx9TEdGi6Xivwydb07+oESE6I0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=pcJ2rvPu; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="pcJ2rvPu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758242353;
	bh=ZtD9zl4DENeCcp0z/VMxQ0Rd+BXzfSA9wkKb1amMBj8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=pcJ2rvPumNBsDWT6JKMB/TwzBVdvwO7LWu4OBkyceYcZ1G0Bjtu6qfUFtmNXARADP
	 870JXXUD0v8vAdK15FqdT2ziC8+zzRIH/s9gufEswbxjBd4lhcT50I/hWgdR+Q6Z7N
	 LaJO02rh5KYiTlb153sDeOmt4Il32xvsXexQcodOE5wDPqx+YlaIP5Qcc5qNNBvw8H
	 xKlPzZRw1tOCGK3FTXYuot788LbmmznGCZISshVgI7saLiv2ZPRQCzil5Lera9ltFF
	 VT4d/0maGAS6411Rj9spl7OqjL8ITcLFLDsqodxLqvpIJTMyNpdSm4ZEvSo1tbqssJ
	 SDBR1WTLEayaDJmkNFQ0Mik8wlpUdmz6gJptYrogxfLcX7hpmMPdnBLuwT+lI7fyph
	 RrV2xemeND0XCCk3t+Nhz90qMIskD3SifUNSsg23RDsqn9gJpK2cUvsY7FB52SbwJx
	 NVRVAWuX2syCRAeofm2rr/d9FIhwst9gHb1MCRroTc0tQsGX8GZ
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ada0:faf8:3cb8:a81f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A45BF20105;
	Fri, 19 Sep 2025 00:39:13 +0000 (UTC)
Date: Fri, 19 Sep 2025 00:39:12 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 0/2] doc: git-push: clarify section
Message-ID: <aMymMLkJg7PkmxL7@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Julia Evans <julia@jvns.ca>
References: <pull.1973.git.1758144815.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MC7LUd1CJch5QtNU"
Content-Disposition: inline
In-Reply-To: <pull.1973.git.1758144815.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--MC7LUd1CJch5QtNU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-17 at 21:33:33, Julia Evans via GitGitGadget wrote:
> This is a continuation of the changes to git push, from
> https://lore.kernel.org/git/pull.1964.git.1756240823.gitgitgadget@gmail.c=
om/
> . These changes to the refspec section got kind of big so I'm moving them
> into a separate topic.
>=20
> Since the last review, the main change is to move the rules for pushing o=
ut
> of the section and into their own section ("PUSH RULES") so that it can be
> easily referenced from other places in the man page.
>=20
> I don't love the nested list in PUSH RULES but the sentence starting with
> "If the source is a tag or commit object..." is really a tough one to rea=
d,
> it's not going to be relevant to the vast majority of people, and I think
> keeping it contained inside a bullet point will make it much easier to sk=
ip
> over to get to later information which is more likely to be relevant to
> folks.
>=20
> Other changes:
>=20
>  * removed "+:<dst> is optional.", from Junio's review
>  * kept "+ is optional and does the same thing as --force", since now the
>    push rules are in their own section.
>  * fixed the fully expanded refspec form (main:refs/heads/main =3D>
>    refs/heads/main:refs/heads/main)
>  * switched from a numbered list to an unordered list, from Junio's revie=
w.
>    I think the numbered list looks a lot nicer in the terminal output, but
>    it's true that there isn't any order. I briefly attempted to understand
>    how AsciiDoc's nroff (?) generation works to see if it's possible to m=
ake
>    unordered lists indent with fewer spaces (2 instead of 4) but I was le=
ft
>    feeling that nroff/troff/etc are not for mere mortals like me to
>    understand.

I have used groff for many years to write letters and address envelopes
(as well as write a few manual pages and design some awards) and I still
don't understand much of it, so I understand how you feel.

In this case we have two possible implementations, AsciiDoc and
Asciidoctor, but both use the man macros.  I think if there were some
way to control the value generated as the argument to the `.RS` macro,
then that would be what you want, but I have no idea how to adjust that
in either one.  Personally, I would just leave it as it is, since I
believe 4 is the traditional value used with the man macros, even if
typographically or aesthetically it might be suboptimal.

Having said all that, I think this documentation is much improved and
easier to understand, so thank you for that.  I don't have specific
comments on the patches (although I see that Junio has suggested some
clarifying comments), but I do deeply appreciate your efforts to improve
the documentation (and, outside of the list, to clarify difficult
technical topics in general).
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--MC7LUd1CJch5QtNU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaMymMAAKCRB8DEliiIei
gcsiAP9r3Nnbbu8OnaUW3zwq+OqQMKwNxcKxXaYRuDPJCBd5fQEA1kuAeFQQk9ZB
fCyEtN+UXbO7owfYCeiz1CHViEmZQwA=
=zvTr
-----END PGP SIGNATURE-----

--MC7LUd1CJch5QtNU--
