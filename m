Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386ED801
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 22:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752100989; cv=none; b=l0xDJh2fz1jyKSf03CAciY1wqpSd+uVHmrdEqgOAgVMhlUio/mHLsStlioPF1jda2+Mb5vSlo6BCAYSW2c5CB1sVy4jYA07G77gn1Hd+1QqX0noiW4nad2F98+0VtNCQpuK5cZmgIh650eqD12K9h+NqL1xmVsgvBgtq+ZY3Mcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752100989; c=relaxed/simple;
	bh=EFCfPaYoRYLr2TRqZm6Woxy3Aneh30Ci8ParaNnaGEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTPDVl6KTMOs1zWZ1OPwsDGw2wN27HinEIMSoRbIrX0iMPNZZ5AGuRt/mw4aNpH3S/vh4+MsCaxWSnlr/upH/p3aluqmUjBV1c0oEv7HxvkVDaXR70b/1KX9PNe02PI0vAGaHPGlx+QN+efscezj8W3aVbipi26yt38JXstoyfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=PaA09Lot; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="PaA09Lot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1752100979;
	bh=EFCfPaYoRYLr2TRqZm6Woxy3Aneh30Ci8ParaNnaGEY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=PaA09LotnNERX9GcPpdnBOdplLJe557GDeGbMNXodqLS/8m4k4+uCNc2hLIUqqCNS
	 2m4pEGeO/7rWN5lMGGvstBAO6lOsdegJmQl5H7bwn15I/5d4FquulEFIAndFJBoHhe
	 QGnk2OsDxhtXmJvrttcQnjIxu9HCp9jyijYbClL6aKny+o9hYVSLaBq7ps/aBlxKEN
	 0rZodCNPXdwj3UNMeYAX6ctey+tesqrXy7+2PWBXRP3//Ko3T+EJU8AMVHcw6mgDOw
	 bmB4m7EQflK2WSI2bgVEsrSI6YkLtpu0psih6n1/1iiRSESDbEsyEC6GY68fXnVCbc
	 lOA5j1H5Pyf9S7bKosb/EzM+2ZLSitekgCWS2Oo41RWYS019h+i82erzKOeQwZTMzT
	 BvSYHV1qEAxhRoO3kK4ePGx67fGNsr6LVEPwMMGKnY9dUkAOnnap/OGYBCRq8la2/R
	 YiDSt8BG2SlMUV86PK+zbWtlT2C2rsdlAZMLsTXY1eDPYNVCAo4
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:828b:3227:a916:b7f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E7B5920075;
	Wed,  9 Jul 2025 22:42:59 +0000 (UTC)
Date: Wed, 9 Jul 2025 22:42:58 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	redoste <redoste@redoste.xyz>
Subject: Re: [PATCH] SubmittingPatches: allow non-real name contributions
Message-ID: <aG7wcoy3gTzSd_4w@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	redoste <redoste@redoste.xyz>
References: <20250706163009.335780-1-sandals@crustytoothpaste.net>
 <20250707204224.GB3115893@coredump.intra.peff.net>
 <CAN0heSou=BgC8ec9ZE+V-pYKt+XQiNfOBHj-5CZY8s5XCatZTg@mail.gmail.com>
 <20250708225134.GB1180568@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D7vz128WWDWEVLOC"
Content-Disposition: inline
In-Reply-To: <20250708225134.GB1180568@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--D7vz128WWDWEVLOC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-08 at 22:51:34, Jeff King wrote:
> Yeah, I agree (and didn't know that before; thanks for mentioning). I
> think mostly I was just hoping that some of this reasoning and these
> pointers would make it into the commit message.
>=20
> The content of the patch looked OK to me, though I do still like the
> CNCF wording a bit better.

In case it isn't clear, I'll be sending a v2, probably this weekend with
more of this information and some updated wording.

I don't love the CNCF wording because I feel it's too ambiguously
worded.  What is the "community"?  The open-source community?  My
neighbourhood?  My friend group?  Can a real name be a username or
handle that's distinct and unambiguous?  What about communities where
people share the same name?  (Debian has, or at least had, two
contributors who both have the exact same full legal name and can
therefore only be distinguished by handle.)

I also think redefining "real name" in that way is misleading and leads
to confusion that might put people off, especially those that are not
native English speakers.  I know it's common for lawyers to redefine
language to mean something very precise but different from the language
that ordinary humans use[0], but that's ultimately dishonest and tends
to deceive and we shouldn't do it.  Most people take the phrase "real
name" to mean something equivalent to "legal name", so we should use
language to describe the requirement that doesn't confuse or mislead
people when it's used without further context (such as in a social media
post).

By contrast, we suggest that `user.name` "conventionally refer to some
form of a personal name".  That doesn't work here because I did intend
for us to allow handles or usernames, but Wikipedia describes it as "the
set of names by which an individual person or animal is known" and, due
to the use of the passive voice (an intentional choice, I'm sure) is
specifically ambiguous and allows lots of allowance for personal
circumstances.

I'll take some inspiration from the CNCF post and rephrase to make it
more approachable in v2.

[0] For instance, one time where I was told that my laptop's removable
battery was an "accessory" and was therefore not covered under warranty,
despite the fact that it was required for the machine to boot.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--D7vz128WWDWEVLOC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaG7wcgAKCRB8DEliiIei
gapkAQCQuQS0ITlh6KcOaI388pBxCsfuiYxSMRZo7mwMcasfSgD9ErehfkqplZZH
w52CohF+yIHlA1YG2PukTOuggXDsNgA=
=obgA
-----END PGP SIGNATURE-----

--D7vz128WWDWEVLOC--
