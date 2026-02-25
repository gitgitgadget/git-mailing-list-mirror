Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A5A2E3B15
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772056465; cv=none; b=Xd2bod4aDwwcTjZMmPcJ3NTE4hk4CTudhjs5DrtusMMxI2xqIVUksL8ydU5UDYfipqp8oss30mbq9ibuHLOkHgzzI2mxNVVVRjntM0U0m2Y8KrzTBZLAaz13c9UlfBgSzAB/U3Z2TY7r9QmQlSu2o3QMIJWtDKaP8ztHB1FiVII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772056465; c=relaxed/simple;
	bh=n/HMo7Dn5JxP1HIX5XDVBWe3Y52cCEJDkczuZfsbHEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPil2Z97glsl/rGnCB2oMjTxhBimLceA+HJ8+GTg8CtL+076QKouho2QDjPffFI76R8zeAauPV15Vzzgdy0J6IKeZI++6PD3cRvuWRi1YO87L+sTXf34YU0Myk00RbiliRImUyERqlBb3aNdawljTgHMf/wV5tHaIG0SkXMv2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdf3tccW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdf3tccW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDB8C116D0;
	Wed, 25 Feb 2026 21:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772056465;
	bh=n/HMo7Dn5JxP1HIX5XDVBWe3Y52cCEJDkczuZfsbHEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qdf3tccWDAocZTXhPuEFjr1E6iHRH97Ej9cFLTdLBpfs5MFPp4jcnUonPImfeQh6W
	 +H3SXK1aLLSOLAPXGvIj0GptH30IapCS5C8iY4uZXbWTnYygGIknpU9sD5d2qJHutk
	 OptOnaV3GsUgkH+0uyMea93tgTvsdc5LYzccBcv4UQcT9nGP/pkOn5hj01Hl8vYK20
	 Bw8zGQN8MuyHu17X+etOoHPhIDWdfQw0wQnlqklCw/UBZj+wvwcgwSR0PalwsQnwHQ
	 XA0WKzFuE7OyCdlmYg0FEfqMhQjblgE4unfzJIVVYH8lhEbapTLzyRaQhDR5XOy3G/
	 5h5gvnsCv9Qbg==
Date: Wed, 25 Feb 2026 22:54:21 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: --no-decorate and %d in git-log(1)
Message-ID: <aZ9vBfhiaR7gO9hs@devuan>
References: <aZ81X6ERyx5fcm6L@devuan>
 <xmqq4in4brt3.fsf@gitster.g>
 <aZ9AuD3dYzCKtI0s@devuan>
 <8f6441ab-5c9a-4b42-ab2e-a670d462569d@xiplink.com>
 <xmqqcy1sa8mx.fsf@gitster.g>
 <cf3d274e-7363-4557-809a-a649b1d304ad@xiplink.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="64gvwz7y5qdq2mo7"
Content-Disposition: inline
In-Reply-To: <cf3d274e-7363-4557-809a-a649b1d304ad@xiplink.com>


--64gvwz7y5qdq2mo7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: --no-decorate and %d in git-log(1)
Message-ID: <aZ9vBfhiaR7gO9hs@devuan>
References: <aZ81X6ERyx5fcm6L@devuan>
 <xmqq4in4brt3.fsf@gitster.g>
 <aZ9AuD3dYzCKtI0s@devuan>
 <8f6441ab-5c9a-4b42-ab2e-a670d462569d@xiplink.com>
 <xmqqcy1sa8mx.fsf@gitster.g>
 <cf3d274e-7363-4557-809a-a649b1d304ad@xiplink.com>
MIME-Version: 1.0
In-Reply-To: <cf3d274e-7363-4557-809a-a649b1d304ad@xiplink.com>

Hi Junio, Marc,

On 2026-02-25T14:46:10-0700, Marc Branchaud wrote:
>=20
> On 2026-02-25 13:08, Junio C Hamano wrote:
> > Marc Branchaud <marcnarc@xiplink.com> writes:
> >=20
> > > BTW, --decorate=3Dauto is documented as "if the output is going to a
> > > terminal, the ref names are shown as if `short` were given, otherwise=
 no
> > > ref names are shown."  But in my experiments %d still shows refs even
> > > when the output is piped to a file.  Seems like another symptom of the
> > > same bug?
> >=20
> > Isn't that documentation merely referring to "git log" without
> > "--format=3D... %d ..." and not about the case where you explicitly
> > ask for "%d"?  That is, the description is there to explain the
> > differences between
> >=20
> > 	git log --oneline --decorate=3Dauto -1
> > 	git log --oneline --decorate=3Dauto -1 | cat
> >=20
> > isn't it?
>=20
> I'm sure that's how the code works, but I don't see any indication in the
> documentation that this is for when --format isn't used or when the format
> doesn't contain %d.  The descriptions of --decorate and --format mostly j=
ust
> ignore each other.
>=20
> We do have this at the end of the --format section:
>=20
> 	The %d and %D placeholders will use the "short"
> 	decoration format if --decorate was not already
> 	provided on the command line.
>=20
> Given this documented connection between %d/%D and --decorate, it seems
> reasonable for a reader to assume that --decorate=3Dauto would do the same
> thing regardless of whether or not a --format=3D...%d... was present.
>=20
> > I think --decorate=3Dauto is the default so the above
> > without --decorate=3Dauto would behave similarly.
> >=20
> > > (Do people who use `--format` (with or without %d) *also* use
> > > `--decorate`?  It seems like the two are naturally exclusive, even if
> > > the code allows them both.)
> >=20
> > That is an interesting question, but I am not sure if it affects how
> > we decide to resolve this discussion.
>=20
> Yeah, it's more philosophical, though if we did know the answer was "the =
two
> are almost never used together" we'd be more comfortable changing how
> --decorate=3Dno and --format=3D%d interact.
>=20
> I note that currently --decorate has no effect at all if the --format
> doesn't contain %d or %D.  To me this bolsters the argument for making
> --decorate=3Dno suppress %d/%D.
>=20
>=20
> To expand on my earlier point: --decorate=3Dno currently has the same eff=
ect
> on %d/%D as --decorate=3Dshort, so it seems to me that we can change what
> --decorate=3Dno does because if anyone needs to preserve the existing beh=
avior
> for their favorite --format they can just use --decorate=3Dshort.  (I'd be
> surprised if anyone is using --decorate=3Dno to ensure that they get the =
short
> ref names).

I agree with this.  If anyone has a script, I expect it won't use both
--decorate=3Dno and %d together, because it makes no sense (at least with
the current behavior).  And if there's some case where they do it for
some reason, they're able to change =3Dno to =3Dshort to keep the old
behavior.


Cheers,
Alex

>=20
> 		M.
>=20

--=20
<https://www.alejandro-colomar.es>

--64gvwz7y5qdq2mo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmmfb40ACgkQ64mZXMKQ
wqmn0w//dmgP3jBRaxyYDwIEoVizqSu86S1gHyAxpEht2cmHyrQ630ZMupvgUt5z
r40qy9rNy7sD9iCA/E0VFRFolUrTShQsZepsJ5rz8Xt2Z+FxjWjKSjP9R1Yniwu8
4YnPpokxe6y4ubgqK9eU3AKCaoawig9s+oTytUbXvZiEuwesV2K0eJzz8N/OtEyu
07r/yQ9I8JEDcfq6oQvbian1wsm0m3KgR3VBXmFPhVGjlyTu5vpdoO3F+sQNrZi4
lWNLAF3thdlkaxSqULI5rYrGIiEbIz5dBnZWlU42lcLNSQlOxR81yquAiRKpu9uO
SFDs9ZtRAlV9sGjNEDxeu5tB9+fgCigNJg6SpXhW/56rNIc3QQVptwraFKbIdCU9
/KxZksWq0/MUUv6xsvhZCyAffH+inbKy3wtOr7sWlAeoHQcLfQJXjP2UEkyBCn/7
2QJtjrOagpiGPUcsvlRoEeKCx0gKwahKWT8l7bCUw+EKAoic00HALpb0YtQjZMNm
EhbkzZJ7QeeR0NEh+CduMaMpxTifXHEnkkDXoshVFJ20RsPCRJwut6vsaWMlGDDF
BSEM1sbhNjXOUztOWkYRAHg9bYAUpyxmmGrpaMr/0OIoVfaAK3sEk4Qt6fE4yGBs
WdTDYxDzLlEtmZtukaB8Ja7mv6wTIInPMPN/JSi2xd3oQnD95aU=
=q5Ba
-----END PGP SIGNATURE-----

--64gvwz7y5qdq2mo7--
