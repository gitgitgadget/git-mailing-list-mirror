Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793993800;
	b=Js0Uc5ojWPhWde6Xb/QAatCfKnEavO0YiWZCVxUe5atRlLRSWuiCpLLBiT8iOrzqqlVR
	 4siQuNXDPQWvNlEczmJ/y0CIGvEKXn8hUp4QQxD7p8iN11Rjn/l9K0SECIvz+iY9k+gls
	 UJzyY2ZpHGHRF7B+52DyasGXjNEXyOAN8Cnag/Ja3ZZvuCIRG5ao8nUUNGFdiCnbPDeTR
	 dBbAryuZgmhgQ6RGjSZrg7WBjNo1hDI53TYKJedAmK555FpijHG9Pkll7bhZQnPfoBDDH
	 jEBsgjim9Jxo17WBKhRSc6Z69LRjxt12jE6YDW3GXnyLKAKIELNwMZGCF31kavpBHvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993800;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=g4vgkadlBzwY4REghO8cfzqssIfOOmOwnfp055pgPik=;
	b=hOU5su32V21ZfM4ol6IzRxU3REyJEsFAaAtMk+EtuCFcUa2lbHrXCOZka6GXtZxxw+bu
	 fuqrV3uI/aE6YwvvcZGy36WIDNW2zgyqTvvV4CPxHY0wQPXQ6knh++Td4Fhq7RMxtE6fi
	 W2dE8fJiXLOjJuWb2AdC6pvlCHtzWhV7szmKAHavHP2aSJahcQ1z2gSwuX481cvk9Tm+s
	 28CEAMdQnEapwPwBeBhXFuExA/dnDZRYOwXfC73Ayi9m/UAUMg3Qdtvfw+m2VuN9LwpvJ
	 m0pjnW5Ft3huCQaqTL9usRUaAFmJfHrGPTh0nWYkyrRM29/m/jDL9DAxVp83xlrV85w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dvnZJag1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF526606A32C
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dvnZJag1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189961F008BC;
	Fri,  6 Nov 2026 19:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793993799;
	bh=g4vgkadlBzwY4REghO8cfzqssIfOOmOwnfp055pgPik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dvnZJag1trF2pwXgc/ES4Hw6e7WQcF6z2LTOgqPDFfZVfaSFkK88pV3mvXwNW5xqI
	 Pj1T7kUfVwHT3xjjAHj18nd7rhro+VfzteuHAVrSrfAWH1hItmAPBd1KXOkKbK584r
	 sDsEz6pqIudIGMJNfka20Bb55LtTmxtam6STqlnf94uGi4JsPlIipVEguhCLID4ll1
	 138Rh73Dbqn3+8LZmjZ1dtrraSMsr2gbtljgZRqh5MXtPvnhTfuPJdNPEKHwWdZARY
	 KneIFcbN2KKx07SpSSFbh0HhMPMSezXkWF86UNtKgK0vRqw42rn6TkOBqruwM0QRV2
	 StwGm8R2n/SSw==
Date: Fri, 6 Nov 2026 20:36:31 +0100
From: Alejandro Colomar <alx+git@kernel.org>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: git-ls-files(1) avoiding symlinks
Message-ID: <au4rmQRjRtIv1Oru@debian>
References: <au3lu4jYwZ5hBZSy@devuan>
 <AE63992D-7BEA-413D-A372-78708CFA8F6F@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wiyvbp77ygcid7vz"
Content-Disposition: inline
In-Reply-To: <AE63992D-7BEA-413D-A372-78708CFA8F6F@gmail.com>


--wiyvbp77ygcid7vz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+git@kernel.org>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: git-ls-files(1) avoiding symlinks
Message-ID: <au4rmQRjRtIv1Oru@debian>
References: <au3lu4jYwZ5hBZSy@devuan>
 <AE63992D-7BEA-413D-A372-78708CFA8F6F@gmail.com>
MIME-Version: 1.0
In-Reply-To: <AE63992D-7BEA-413D-A372-78708CFA8F6F@gmail.com>

Hi Ben,

> Date: 2026-11-06 12:34:20-0500
> From: Ben Knoble <ben.knoble@gmail.com>
>
[...]
> > Hmmm, that could work.  Thanks!
> >=20
> >    $ git ls-files --format=3D'%(objectmode) %(path)' \
> >    | grep -v ^120000 \
> >    | sed 's/^.* //' \
> >    | grep '\.[ch]$' \
> >    | xargs grepc creat;
> >=20
> > With -z it becomes a bit tedious:
> >=20
> >    $ git ls-files -z --format=3D'%(objectmode) %(path)' \
> >    | grep -zv ^120000 \
> >    | sed -z 's/^.* //' \
> >    | grep -z '\.[ch]$' \
> >    | xargs -0 grepc creat;
>=20
> The filtering for C files can also be done by Git, I believe:
>=20
>     git ls-files =E2=80=A6 '*.[ch]'

I prefer regexes over globs; they're more powerful, and they're hot in
brain memory.  :)

> > But, indeed, I don't care about files with spaces often, because I don't
> > create them in my stuff.
> >=20
> > I expect git-ls-files(1) could make this much simpler, though:
> >=20
> >    $ git ls-files --type f \
> >    | grep '\.[ch]$' \
> >    | xargs grepc creat;
>=20
> I believe the expression is =E2=80=9Cpatches [scratching your own itch ar=
e] welcome=E2=80=9D ;)=20

Nice!  If the idea is welcome, I can certainly work on a patch.  :)


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es>

--wiyvbp77ygcid7vz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmruLD8ACgkQ64mZXMKQ
wqmv4w//WOK6c9yElT/g4r7756NLSXotHAqfEafLb1jML5x0muIIgek+p1rDkbKs
X/TygZDIFYIolX6JHQb6ALrgfF1l6805QjFP+TOrRgVvod0YUb+hva+EUR8ntahC
XdElmjObRoc7XCMHX3b1sBgAfc+vo5Tqbi+/Ho12vtiaUZjkMYZYxG7zo0NK1l4A
D4vFYlXUDzjKBm4OWyJ65q0sLC5V4o+5YsVIKOGcD+FFUmHJT2gfEMyP0Opl6qt7
DBEgf45pXV/eSBkpJhLyxS+/aSQm9fTw5PO/6GNl1r/9ZdtfsnEW6Zvr1d8/DVfr
9T1pZNDS3hbY6wgVCFd7KuqdI3i2i7I1MBCQvFLMWJhqtjGg6Ren8Oqs+Z04Qe6N
QsXc0Tu+YAa8qC/Sr2ahtQAiUsqsgTeHE8VDu0k8MCBf/M2X6pUtHWp9szKeTKE4
fV3DbsysMF24jBCVbYGUNFtb1puSin7anifZbyuYamwEH3O//FeLDN3mhdbeT7AK
aUEOo5kgRU4e1/qFSw2JF34Urg3n2IsbREF5TVo86Un/k+aMcuT02KIxz6MpKBHR
4kGf5a8dWJgtGlC5agWLeotesJ4NrY+KZR57xISftmBYCsnjhmmVEG4nbYtPUpnJ
5aWsfGMU47A+YRJtn96ix197WMqUy09v9M7LwdoiCfIrOhs/g7k=
=4ZDg
-----END PGP SIGNATURE-----

--wiyvbp77ygcid7vz--
