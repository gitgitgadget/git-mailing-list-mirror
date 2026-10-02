Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91AD3EC827
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925602; cv=none; b=O6zakHsmt9BHlBsLcJyNgvc7wZiX/Tp7rH2yaj7iQ5I5gn6j8Pu39JuuQAuKaW6ospn4BJhm65ckkY2zzQvOt4216AVCM1q2BgGzTfRL+TYM+FZhjaFGhv43l0vzJjxYW55mYw+oimiAjrnLS3ApW4/jgWaEGlYuotFn0gqVIHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925602; c=relaxed/simple;
	bh=Uh8jZ/v1YbWKlYRhNphHcIIhFHD/MR1DA28rMgVnVEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKsuHz9uLvs7b0UWn8keklhstvF2K8ZOOzIstRee8E5toHYqdWkeuLwtkoouX+0NMFs4isXjnPr6Ih/IBGbsU9uwvsHH1rVlUOkiXOcfDOgJbNoQ0GZDhIbs0nvZJd3e/mG3WOvsLIIS9XfydhBasVQF3pkLEe3ETZD0N0WDS1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cl0sjFaG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cl0sjFaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BF51F000FF;
	Fri,  2 Oct 2026 07:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790925600;
	bh=P7PYjSpO6eNvhBB0Gkge5hs2V8F2bQV63Gba/ewqoLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Cl0sjFaG8EUBfIUL8uMcewVQ8RdOJ74tPN39+IpgDNC056UMIfEIvg5ihfGKkhej4
	 qObGFkpHC2GnotvjtSspu0Athz5hBMSOwz9fb6F7sbvvnISSwCJrqI5kvVKJNwGkU7
	 5xPTzwncYZNNUhQFrSzrT7katJJElyxcUaPUBbIeQ+t8FenF5AfKKsvUcBqAoo6KJb
	 epEGoMepvPR2l/Ygf/U5PkkU74M0eyVut/AIMrPGn0YFzTFLVxUikjXpwovsoTadSJ
	 RwYlpfMGBTfEDw4/tFb3pvAwA53WZJfp9dwjbenp5Ihn41QaeWixIkyq/5SZ7M8E2d
	 5NkWbucEHwoKQ==
Date: Fri, 2 Oct 2026 09:19:56 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: git-rebase-walk
Message-ID: <ar9ZRrVyr1-Fk2LZ@debian>
References: <ar5KL4_IKXYbx3Sb@debian>
 <ar5eereSq91xldo-@pks.im>
 <ar5-7ZtM6C23H-8m@debian>
 <ar9TTB5nmPPAdABE@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7bd4a74ratk2mh2n"
Content-Disposition: inline
In-Reply-To: <ar9TTB5nmPPAdABE@pks.im>


--7bd4a74ratk2mh2n
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: git-rebase-walk
Message-ID: <ar9ZRrVyr1-Fk2LZ@debian>
References: <ar5KL4_IKXYbx3Sb@debian>
 <ar5eereSq91xldo-@pks.im>
 <ar5-7ZtM6C23H-8m@debian>
 <ar9TTB5nmPPAdABE@pks.im>
MIME-Version: 1.0
In-Reply-To: <ar9TTB5nmPPAdABE@pks.im>

Hi Patrick,

> Date: 2026-10-02 08:46:36+0200
> From: Patrick Steinhardt <ps@pks.im>
>
[...]
> > My script I use it in shadow-utils and in the Linux man-pages project,
> > and is in use today.  I was wondering if there was interest in
> > integrating it to git(1).=20
>=20
> I guess the answer is "maybe". The fact that multiple folks have solved
> similar issues over the course of many years is an indicator that the
> funcitonality may be more generally useful.

Nice.  :)

> But it probably shouldn't be
> a separate script, so if we wanted to integrate it I'd think the best
> way forward would be to integrate it into git-rebase(1) directly.

For a git-rebase(1) option, I guess it would have to be named something
like --first-conflict.  --first conflict because it doesn't really
rebase on the target commit, but rather on the first commit of that
branch which causes conflict.

> That's of course more involved though, so I understand in case you're
> not interested in doing that.

I'd still be interested, but it may take me time, and I'll probably need
help.

> > If not, I will likely provide it in the man-pages repository as a help
> > tool (which might end up packed by distros as part of manpages-utils).
> > Is that okay to you?  (I ask mainly because it's using the git-
> > namespace for commands, so you should at lease be aware of it.)
>=20
> I mean overall this is our primary way of extension, by picking up
> utilities that have the "git-" prefix. So arguably you don't have to ask
> us for permission to do that.

I think I'll do this to provide the command in the meantime as an easy
extension, with the goal of deprecating it eventually once it lands in
git-rebase(1).

> Whether it makes sense to distribute such a tool as part of
> manpages-utils is a different question, and one where I myself am of a
> split mind. But that feels more like a question for distributors rather
> than for us in the Git project.

We already have other tools that are generally useful, such as grepc(1),
which finds C source code with a grep(1)-like interface.  It's
essentially similar to things like ctags, but it has a traditional
command-line interface, and doesn't use any index or cache (yet it's
very fast).

So, it wouldn't hurt having this one.


Have a lovely day!
Alex

>=20
> Thanks!
>=20
> Patrick

--=20
<https://www.alejandro-colomar.es>

--7bd4a74ratk2mh2n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmq/WxQACgkQ64mZXMKQ
wqlllQ/+LBsomCXEFAIKabczRDZNL+5JLaXTYR63XAZ3rBVTmemSotTR+kdel3I8
YLij1m8YnTkYiiJQR8/uvkmgM2OZxCeqgZ7h4ePm8sDhsq37F49cYRrk3BQA7hyI
xwtakvNv+7WDON0z9CzWMzuW5B6JEFsQvq8yeVJAhN1025Uzi0+PNpvX+7qrjhKi
l+73AOTIBWsLmgh4anYn/NJsJmYjsBVpWRmCQAwT/1gXqfBFdQx44haOBYc+Ceje
fiqUHYvb1r06DvalAeH+NnMcX8X3p+OY47VB85tvy/uzJ4vqCadjcJfPJpA599b5
SHBkViSj45voGot6vo6DVOG6HanjZxzwcnwz95TnnTpueIjiHJ2sp8KLc7pcvqoE
hoI55ipdwdjj6Ny+/OiUNGEGz1RgIwYSu0ZrMfU9sKEv85DNMgrP4yilC06wgJkw
MrBGlPjPP0rutqttWAgQ4vgWxkPqYsyjF5MiPrcWlJJijulJL0YEBFhlsuYBQsAr
DpII/PQIQyUzfwjgmX3X1mf9Auz+pheD5wa6rRoUJJbykSIxswJsSdW6P0FzGded
W4cTk9CD9M+dlgFjzPXH1mmF4m+3ZrzLWiVtUAJ5HYljC0h7LEkzeBuyhutkNcKH
uJhVKBEr14X1D5aLNUkybBNcfBX67Hcm8LR+7L+v7JizOCCVr/s=
=IknU
-----END PGP SIGNATURE-----

--7bd4a74ratk2mh2n--
