Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DD31327E8
	for <git@vger.kernel.org>; Tue, 14 May 2024 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716317; cv=none; b=g5nT+UPM8NwovRObC3rooIOrtOIfkBKolcG5uQxE7zO4IBrOpEiq5i73WNtDPINeD9AfESFXAJfIsIRpnKIr+Z07t1xRcMgXkYXVL10GiOPNXFyOimxNWqic7CehaO4cfZLlS22FSdDxsLvT3EtL4E6+tHx43e1oDXt/d/sz99w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716317; c=relaxed/simple;
	bh=t2IegaG7AJkq/Xv1yuaaWreIKdc2GSTfK2STzA8qhqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzFEsAX09P8OoyTGX79uaMqMueCq+ncWRbcbrNJ1aPNWjMUoiFTMok8vjOyam7q8u7O3u4hsmBxC831mznEHzq6YVlfZhJg+L3BHZEviRpzBtQnHpMZgBkbhaUONgLDh/xoOy2PgaO7lQx34bCFwOAlVqx3fv7MCFiF9HMF42t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=1OHgHWUI; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="1OHgHWUI"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B829D5DA89;
	Tue, 14 May 2024 19:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1715716313;
	bh=t2IegaG7AJkq/Xv1yuaaWreIKdc2GSTfK2STzA8qhqg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=1OHgHWUIwIQsOE3Thp/gS+nJPZfIuYcDGRDRDR+Hm8r0vJ4jxhsWmG/BB/eCGUmUl
	 uHVE0eGh00Q8SVb7eZW1jj3jo6meBULlGv1aIT/21qomohzepAQzBLjT2NuYxC6Bvm
	 ZS3DzMChcQ1I3oR3pxSxkFiSdT4KL7hEhucn1EedGav7z+32CWrZMy5Qk05x2LjOLL
	 6chuTqHJVAFMGBpI/KFxlOpcgsKiPZ3MkBtr/cU6L8hfSmgbochs77y7/LsH4+flMA
	 wAMNBOTk58cjL0C1j0AeMBEIMrdDeCjM8r5/zkZ3dadBBi4yRmN3T3Kz53ctIK4X82
	 gK++Qzi4wXhZOqUSevqyiFjdlFufYmjeraeWul1lJvcee6EZ8Oa3fdJ6JLfu0Xjsfc
	 cuUKU1LCDKpH7YXz0mOJfJU5fKxnjtaOMpIHV+1WFP0VTMNoNfnkeHg6j6oKUYnBfN
	 +WP6LWIvQh/RU36ELXk9jYCzwZ5wavU/3S4fyRk4L8FzwzfpLVX
Date: Tue, 14 May 2024 19:51:52 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Dimitri Sabadie <hadronized@strongly-typed-thoughts.net>
Cc: git@vger.kernel.org
Subject: Re: Author signature
Message-ID: <ZkPA2Pmz2EB6SOzL@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Dimitri Sabadie <hadronized@strongly-typed-thoughts.net>,
	git@vger.kernel.org
References: <D19KZ1CBA7JF.27PYPL5X68543@strongly-typed-thoughts.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vKh64H/zEUEHMHdP"
Content-Disposition: inline
In-Reply-To: <D19KZ1CBA7JF.27PYPL5X68543@strongly-typed-thoughts.net>
User-Agent: Mutt/2.2.12 (2023-09-09)


--vKh64H/zEUEHMHdP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-14 at 18:31:55, Dimitri Sabadie wrote:
> With the email workflow, from what I understand, `git am` has no way to
> keep the signature of the author =E2=80=94 and I have not found anything =
going
> that direction with `git send-email` and `git format-patch`, and I think
> that the reason why is because the commit is modified to introduce the
> committer (committer being me here; the author being the contributor who
> sent the patch), whence the commit SHA changes. The author signature is
> simply dropped, and `git log --show-signature` only shows my GPG
> signature; not the author=E2=80=99s anymore!

`git send-email` does not send a signature, correct.  I've proposed an
approach to add such a signature in the past as part of a more general
series, but it hasn't been implemented.

> So=E2=80=A6 I was wondering: since we can only sign commits, is there any
> way / work in progress to attach the author signature to a commit? To
> me, it would make sense to have something hierarchical: the comitter
> simply signs above what the author signed, and the author doesn=E2=80=99t=
 sign
> the whole commit (I guess?), since we want to be able to change the
> commit hash.

This is a great question.  I have seen previous requests for author and
committer signatures, or in general, multiple signatures (such as with
co-authors).  Git has only one signature field (well, two if you could
the one for the SHA-1 encoding and the SHA-256 encoding), but OpenPGP
does allow multiple signatures to be embedded in one ASCII-armored blob.

So it is in theory possible to take the author signature and _add_ a
committer signature and have both be valid, although this will change
the object ID of the commit.  However, Git doesn't support that right
now, although there's no reason it couldn't be added for OpenPGP.  I
don't know whether it's possible for X.509 to have multiple signatures,
and I don't get the impression that OpenSSH supports it (but haven't
checked).

I was doing some test work on this within the past week, and I have a
vague desire to implement such a thing, but no definitive plans at the
moment.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--vKh64H/zEUEHMHdP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZkPA1wAKCRB8DEliiIei
gcP1AP40U3ydgiNqCWFOeM93HaW5LqkF+aQtFBU4n9HzQ4z7VwEA47o7CngKZWWm
RjwLp1xdETFTNLLYfSlZyWmXLHofBgY=
=z3gG
-----END PGP SIGNATURE-----

--vKh64H/zEUEHMHdP--
