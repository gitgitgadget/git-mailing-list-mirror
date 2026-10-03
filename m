Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B496B443E5E
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062987; cv=none; b=W/nYM5kV1bfOzk9Jr9nwSqNtNAnklau7gaKIyky2c17uYIuUGNFJplLiNo7wTe0t3ZfXZEbJKZ/TfU9d902uH1IK4hAu2yNgsnZ7Lvmd2T3ZoVNrQ+HQliBpjbOwilXdfLiEY5ySvEvlVcCcpFwQt7ZMPdyG7KrdfcU0C3ddsIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062987; c=relaxed/simple;
	bh=GFfRluGbK2/cD7kkiqaYJZ0BlNWJqqbUqJwdvm7549k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4HyCuY304gSvGeGwyjVtTvIzj9i5gx/yeSYmZRvSzEiKlsYujmak5eDQmytc7I/B7d+8MTK0LxNpNu7vYTv7Xjg/jMEGruuUNQ/f39yMPyoROCbBn4NlOBrOZnMU0OUHsdL/00Ya7EKaWs1LA9KXoUZwqa654+CZ81L09QxU8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaFlg8wV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaFlg8wV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D351F00A04;
	Sat,  3 Oct 2026 21:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791062986;
	bh=yeRlslWFxV00a68WrJ8VnsyQc4H/wYIpQ4aLXqLtv2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OaFlg8wVhUKf94rMpGIx1EJLAOuEN1PUAAUZl+fHcFdrz9oW1vCqRFdyfkG8ed0ZH
	 a8n1jI4hTiO4rofzEJoCltMlIGMZ6MzR/EVq1VlYkc0y+51DDUUiMm6oJVJG8WILRB
	 bmHlrGd5teR1uarnVOMqT7buyHlzp6foNWCjPqfESbhtnRHSp+PzGCAzRu/pNywmg7
	 AzNAF6PSyuno+3RS3DOZaJsDBypRwpBMwK9Y/Rvflxl+U9yDCeHDcieGLq+XKf1afh
	 0pw4kPx1ygfaMuiiV9uJTcbuylXKGmFUQquUYexX4uXWW6HS03oj7a9JYR+cfGGrof
	 PrbXMt2WcvpJQ==
Date: Sat, 3 Oct 2026 23:29:40 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Nico Williams <nico@cryptonector.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Ben Boeckel <mathstuf@gmail.com>, Viktor Dukhovni <viktor@openssl.org>
Subject: Re: [RFC] git-brebase
Message-ID: <asFy2kOZe7WDy38I@debian>
References: <asFRVdMTpshsazgM@debian>
 <asFoDZKscLKqaIf+@ubby>
 <asFqLv3hMEE7yEOC@ubby>
 <asFtLJDJliQBPe1c@debian>
 <asFw4gsn253MQtxp@ubby>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yoy5ki4qev2cpkzn"
Content-Disposition: inline
In-Reply-To: <asFw4gsn253MQtxp@ubby>


--yoy5ki4qev2cpkzn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Nico Williams <nico@cryptonector.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Ben Boeckel <mathstuf@gmail.com>, Viktor Dukhovni <viktor@openssl.org>
Subject: Re: [RFC] git-brebase
Message-ID: <asFy2kOZe7WDy38I@debian>
References: <asFRVdMTpshsazgM@debian>
 <asFoDZKscLKqaIf+@ubby>
 <asFqLv3hMEE7yEOC@ubby>
 <asFtLJDJliQBPe1c@debian>
 <asFw4gsn253MQtxp@ubby>
MIME-Version: 1.0
In-Reply-To: <asFw4gsn253MQtxp@ubby>

Hi Nico,

> Date: 2026-10-03 16:17:22-0500
> From: Nico Williams <nico@cryptonector.com>
>
> On Sat, Oct 03, 2026 at 11:07:04PM +0200, Alejandro Colomar wrote:
> > Since --abort doesn't go all the way back, I think --continue shouldn't
> > continue all the way forward, for consistency.
>=20
> Fair.
>=20
> > If that's desired behavior, it should go in this tool, and not as part
> > of git-rebase(1).  git-rebase(1) is a much simpler and much more
> > fundamental tool, which is used to build this more complex tool.
> > That's one reason I'm rather opposed to having this as part of
> > git-rebase(1); it would confuse about the responsibility of
> > git-rebase(1).  IMO, git-rebase(1) is a plumbing command, and
> > git-brebase would be a porcelain thingy.
> >=20
> > > If we take this approach then we'd need an option not to enable this
> > > behavior but to disable it, something like `--direct`.
> >=20
> > That hints it might be just be a different command.
>=20
> If this was 2007, and you were writing the first version of `rebase`,
> and you had already worked out that you wanted this feature, what would
> you do then?  Would you make it the default?  I _think_ I would.
>=20
> Basically, this makes rebasing much nicer, so why not make it the
> default?

I'm currently defaulting to brebase for every rebase I want to do.

However, I still use the regular git-rebase(1) for more precise
operations.  To be specific, I use it for changing history (without
moving the base), and I also use it for resolving conflicts as part of
a git-brebase operation.  They seem to me to be different tools, even
though they're clearly related.

I think we use git-rebase(1) for what we should be using git-brebase
only because we didn't have the latter.  That might be the reason we
confuse them and think they're the same tool.  They're used for very
different operations.


Cheers,
Alex

>=20
> Nico
> --=20

--=20
<https://www.alejandro-colomar.es>

--yoy5ki4qev2cpkzn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrBc8QACgkQ64mZXMKQ
wqnx1xAAlaDUI7ZcoCWpeMgAiU9C2KXhu8PATHsl1RO6rE6vNV5iKx5lfonmZaW5
syqKniLST8Dw4WOkabKHMg/txW+AQQKPW+iu7tGpt9lYVvbQ7igY/h6sardP0xXn
YTO+NVgJ04zt4qeFufshl1tctqnGs2evYCybq5kvBpmLtPi1BWPAdbEfCRbnUMe0
4u5C3S+LAzxTfyW8+Gt42+d0CpbovaiK2Vf9ovO5hEZZNZdods9MFHeL4lECIdHF
x2qgUukKgOrcRea318Xii3F051oGzoCuBhN2EXGMBKgR4eh/vEOyjKi/Jyw4ZFFL
8AHE6rHvzX3k8fQZpbEiMXclOJbo8eJmcEoAGxbvYyzIg+2S7KaPbDxAiywfqU6S
+8gD+ClV4YcrLhFrX+5ljiAxb1c2wKeJStahW6goP/alaNkxSOsGKOI9z97SGb1C
jgOFf4YDOdxTsZnJvZs1ufzPEm15H8QEoNhKYc0P/74lkY0E3CUFVGwWUy9+8XX/
+Ri3T0WwmYpUcHvBUjDj6NtukoBVTX4YMp/5kDm86UyzA/UGbiQjl+AwdESWczSx
sRf4lxCdmK8KsXFhbAqh3zVYQRMUN29qX2gtUCXPs3jFK3GqVjItZzJeZTc/4/YY
3mH1lowvVOnItbjSV8/2KEDAEL99hCSZTc1KiWF00pnWwX9zHa4=
=4vbF
-----END PGP SIGNATURE-----

--yoy5ki4qev2cpkzn--
