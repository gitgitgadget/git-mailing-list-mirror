Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F5D30E852
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750367847; cv=none; b=Ua4uCiR6NmYnaRZ4nPxnGOgMB2le9Vzig/Y0xBJf7sSfHnUtzgimlI22cFAUUDaxJmkLRCGdE+D9kv/ikxgpbYtQ5eIPTduFbL7qSZaGGJzYeODQQ6Gn8QCz1da6xB8EgNNIvvO51PCniRfVGrlCdLFc8t1D3osbFE1ti7oa7T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750367847; c=relaxed/simple;
	bh=8EoKV6iFtQuCBeieV0q8Ob1ee0vk/hJPMdt46lyaq/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7Fc/hxgoUb8quRRsLYe1/ZldRn4EGZVpDUu5ANKQ/Qh3C4GIz7qDLQVMkBmse/MCcfvOBiCsGeZrH914GJwj27tYefLLG7NDICIT9G98UuRpQD8XzKqejz3smfeKdozrDe8FrxTJKGmQTPZBeaRhJr18diQaa3SDl4GxdM20Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=IHdm1HSq; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="IHdm1HSq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750367843;
	bh=8EoKV6iFtQuCBeieV0q8Ob1ee0vk/hJPMdt46lyaq/M=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=IHdm1HSq00KZdQEzvkODU31oVHZI6uQtdPk4txUOgdER+gJwoDutEXDnFbsev37cZ
	 JHQ7ao/uUvK0/sNGbHRDWjDh4IRpNp49KJAxSup1Q7JMtGY+Ig5kDofu86+3eQZF8n
	 6SBCSJSYh4mqJXsf2Noph7dz0hckBRn2WB8IMJyqyJZ/rJPiZD/a1asW6MetgyxstD
	 VxAe+tCpT/OWKHVbebBFXsygL5vaM3pgSNZMfAmMfyKrrs7zA4P5pixoFzOtqxGNZ+
	 C3Hu0w6+8n5V7XFn7cEG8DEk+UsAL2X/4WnpbvXsaS6bGjrJOyurzURSmX+8WvXEbJ
	 k4LQeEE5Zjj2KSmRmSrYXdQ6hL6CoLmSTfmdlYuuvW+LbWqEWp3twMKSBV52qtQnkT
	 vcbJ47FuuVVpDzIPMdV5oIhWRKEBxJ3uOC833Ee1NJm88ht49yHpCZk/GIh2jeZ0B9
	 bmVlpnBIFGTWB4X4UbsbvrQlncPTM3QVG+Lww/Nl8GiAqp9KFz6
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f445:674a:9eb4:f272])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1D8C720069;
	Thu, 19 Jun 2025 21:17:23 +0000 (UTC)
Date: Thu, 19 Jun 2025 21:17:21 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: .clang-format: how useful, how often used, and how well
 maintained?
Message-ID: <aFR-Yf0PMj30ex2O@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
References: <xmqqmsa3adpw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5PPvPzgFJrQ/S0pt"
Content-Disposition: inline
In-Reply-To: <xmqqmsa3adpw.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--5PPvPzgFJrQ/S0pt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-19 at 16:38:35, Junio C Hamano wrote:
> Cc-list chosen from "git shortlog --since=3D12.months --no-merges .clang-=
format".
>=20
> I am wondering how often our developers use "make style" aka
>=20
>     git clang-format --style file --diff --extensions c,h
>=20
> and also wondering if the suggested style fixes are really
> "improvements".  For example, taking randomly the latest patch I
> just injested into my tree, i.e.
>=20
>     $ git am a-single-patch-file.txt
>     $ git reset --soft HEAD^
>     $ make style

I don't at the moment.  In my view, the main utility of tidy tools is
that the project has picked a style, whatever everyone may think of
it[0], and we apply the tool consistently on every change and enforce
it. Then, the application of the tidy tool becomes a rote keystroke in
one's editor and one does not need to think about it.  This is how
things work in most Rust and Go projects, for instance, since they have
well-defined tidy tools.

That is not how things work here, however.

> I got the output attached at the end of the message.  The result is
> a mixed bag (I commented on the "patch" as if it were a patch
> submission).
>=20
> I have this suspicion that nobody complained these sub-par
> suggestions the tool makes based on what we have in .clang-format
> because not many folks run "make style", and "make style" is not
> very easy to use after you record your changes into a commit.  IOW,
> there is nothing packaged to help "I have four commits on top of the
> upstream, I want to run style checks before running format-patch",
> i.e.
>=20
>     git clang-format --diff HEAD~4

I agree most people probably do not use it, probably for the reasons I
don't.  I don't know if clang-format produces stable output: that is,
using a newer version of clang-format with the same config does not
result in diff changes.  If it does, then we can simply pick a set of
style configs and a minimum version and tell people to apply it.

We can then check it in CI and if CI fails, we can output a
base64-encoded diff (since it's going to have lots of whitespace, base64
encoding will be practically useful) that the author can apply.  Then
people using esoteric systems without clang-format can simply apply the
diff from CI.

If clang-format does not produce stable output, we're going to have a
bunch of practical problems.  I use Debian unstable at home and I know
Peff does as well, but I also use Ubuntu 24.04 at work.  Some
contributors use Fedora or Cygwin, and we're all going to have a giant
problem picking a consistent version of clang-format to use such that
people don't have to compile their own or use external packages. Perhaps
we can create a small script that does the tidying in a Linux
Docker/Podman container in that case.

> Even the output from the tool is of mixed quality, there are good
> pieces that can be used to improve your patches.  So we may prefer
> to see the tool used more often, but not in a way to suggest its
> output is always better than what the human developer has written.

I really would prefer us to pick a set of standards that is good enough
and just apply them.  I agree clang-format may not produce ideal output,
but I really do not want to think about formatting and style and whether
my lines exceed 80 characters.  Fixing those style issues is annoying
and I can say that it often delays me getting to re-rolls.

> For that, there are a few things we'd probably need to do:
>=20
>  - Improve our tooling so that the develper can check a range of
>    commits they made before running format-patch, and other
>    situations.

I agree better tooling would be valuable.

>  - Improve .clang-format rules to reduce false positives.

I think we should iterate on the rules a bit to get them to good enough
and then commit to the style.

[0] Go's tool, gofmt, even acknowledges that the style it uses is
nobody's favourite, but having it is better than bikeshedding arguments
over style.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--5PPvPzgFJrQ/S0pt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaFR+YQAKCRB8DEliiIei
gR8LAP4tr4r7BEDxQvgAbivHKHmVXtEOvGxNW2Pmb5+bo4UvWgD8CLP7I0ksWulm
XvjDhvAosjcQ0EAJhwPkLZOLVzsRiAM=
=X+g7
-----END PGP SIGNATURE-----

--5PPvPzgFJrQ/S0pt--
