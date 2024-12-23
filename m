Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898FF188587
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 20:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734986983; cv=none; b=RCWf196bGn9WmABQHerR3Uhyel0ElXpdN7oYrffUIYMON/F8+dSt9AhiM8Hv0nUkKMOIETAFVIRyldv+ZvHqeT1w03vn3a3NmMj++OH1dgQ3e+1AXuIK8zS3u+HbTaDCnHvkBxgifT3hChavJq1HNDLN6fOxWAzFwAe3hkxuUJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734986983; c=relaxed/simple;
	bh=3xJMBootiiSR+eF1GxOs8xqpTWEANqNm20/qCAZNPKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYGCMOtfgm7jctuIzt/+QSSPxa47fv/LZ2QEshMDTe54f4WvTtgv3WAXQrGev7yDgRtEtvUvN6TVAE5Y1zV4GTrb4HIMgrfenPjjqirDSFwqcnQcSx6yIj6nSsl2Xs2384jsu7Z/pbs8msxX2RMc59VicTKfaJ2LKpMMsnKbEJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIcq2+aB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIcq2+aB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C023C4CED3;
	Mon, 23 Dec 2024 20:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734986983;
	bh=3xJMBootiiSR+eF1GxOs8xqpTWEANqNm20/qCAZNPKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vIcq2+aBtDsOOdu7TkHZtk6QLghYyHH/Llplkl6IcUmz72lMtTgR+wN0n/E+Q9VdC
	 BzOy5tuYIRBYZQr+BGdyPGc3Cn9sLo+js+BCBG+/53S8Ts2a7nNJpm5u/1O6evD35g
	 obNwh0x1T7ukBkBYKE+MalXXcmFXjdOPMXm1izfERCDHPvgisgQ9IWDk41q9x2Btxs
	 DZ1hLLgL6RINTxngCzmp3cGKZyUhqTHwyYZGcWBpswtRyhzpZxguQyn7vmZJrBIZn7
	 qwVz6U95XjQ4AoxWl07598uUEG20kkyL57w4553aXQLEpeTpKK+Ur0Y7+tVUsJ/Lhw
	 e1TELyJhMnr0w==
Date: Mon, 23 Dec 2024 21:49:40 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: git-log --format missing trailing newline character
Message-ID: <5aib7c6x5m6e4muutjuoqp3f4lvpeh3hz5qkwpayi2usm7b6yi@af2oucx5j4w5>
References: <cw7vyas4yw2q4lqiskbvil7mpkx5l5qilj25vnqzkrp5nuezrx@d6tsavm3ajzw>
 <d813a3dd-68c2-4cbe-92a0-cfd1ece77e9b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m77sxzhttqvntvpf"
Content-Disposition: inline
In-Reply-To: <d813a3dd-68c2-4cbe-92a0-cfd1ece77e9b@app.fastmail.com>


--m77sxzhttqvntvpf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: git-log --format missing trailing newline character
References: <cw7vyas4yw2q4lqiskbvil7mpkx5l5qilj25vnqzkrp5nuezrx@d6tsavm3ajzw>
 <d813a3dd-68c2-4cbe-92a0-cfd1ece77e9b@app.fastmail.com>
MIME-Version: 1.0
In-Reply-To: <d813a3dd-68c2-4cbe-92a0-cfd1ece77e9b@app.fastmail.com>

Hi Kristoffer,

On Mon, Dec 23, 2024 at 09:36:48PM GMT, Kristoffer Haugsbakk wrote:
> On Mon, Dec 23, 2024, at 21:28, Alejandro Colomar wrote:
> > Hi!
> >
> > I'm having trouble scripting around git-log(1), due to a missing newline
> > character at the end of the file.
> >
> > 	$ git -v
> > 	git version 2.45.2
> > 	$ git log --format=3Dformat:'%H' HEAD^^^..HEAD | wc -l
> > 	2
> > 	$ git log --format=3Dformat:'%H' HEAD^^^..HEAD
> > 	2ff431ab1b46a25088fe40baf1faf35ea9fac722
> > 	e75e6c4504022ae52d877926e63c908d9572088a
> > 	178442837d39560a789a8044a8eb90fde3ad7cd7
> >
> > Would you mind fixing this bug?  POSIX requires that text files end in a
> > newline character, precisely for being able to use UNIX tools to process
> > output from arbitrary commands.
>=20
> Is the format here simplified relative to your use case?  Or do you just
> want to process commits as one-hash-per-line?

I want to process commits as one-hash-per-line, yes.

The entire pipeline I have is this:

	git rev-list "$old..HEAD" \
	| sed 's,.*,https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-p=
ages.git/commit/?h=3Dcontrib\&id=3D&,';

which I run in <hooks/post-update> in my server for printing URIs to all
of the newly pushed commits.  I use that for easily pasting them to the
confirmation email I write to contributors when I apply and push one of
their patches.

>  I would use
> git-rev-list(1) instead in that case.

Hmmm, thanks!  I knew there had to be some git-rev-something for this,
but couldn't find it!  :)

I had workarounded it by doing

	git log --oneline --abbrev=3D40 | cut -f1 -d' '

However, git-rev-list(1) is better, of course, so I'll use it.

Anyway, it feels awkward that git-log(1) skips the last newline whith
--format=3Dformat.  Should that be fixed?


Have a lovely night!
Alex

>=20
> --=20
> Kristoffer Haugsbakk
>=20

--=20
<https://www.alejandro-colomar.es/>

--m77sxzhttqvntvpf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmdpzOQACgkQnowa+77/
2zIiRxAAqfboO/ijWUz2s9rgamvDpRJyyIhZXI5sFkp+bGqlUccnGAiIQIxAehv1
nFVjdLtfoyXfuQ7zJ0IkFFCJxzb4p+pJRUfQrAzUy9ZFBPNWy7AHnB5YROq2dw1N
JlyrchwdjLTB2o52nYy9KZgYW29CsbuvZbTaqPY5pb6HIKp6OfBDzJvG+/uMZxuB
tgUYt1hTbG5Ur8Xkp+zXE2lWAQbs2TvEajUsNmSxGdtNuBEwCZNgWYG5UkCAQ69e
WaSV6iUvTdIkNuoHjh+TOvPgIVgcNH+WA0lr4ToG9DvDM2CDsNGpU15RS6yhi3Cz
hNxGh7/pJ9LArg+JJ4gn6WxFAgb8LqaRElV97kfP66sfhMaBPM7VUWox53Id12No
4G0P2pMbCU5pT4jY48h/H+1qjkn7+H4Bx4LZOGKv+xFoc4A7iOgkE2DOP8HIU8V6
DyD/xBAqgoG8GB3WUbCeXyLfY3puRFsXJ/pMQMo6d9JaCkneWnUZLirh0bv1qDFC
7uaEwjqfyteZAjFIs96uxsDwV7B6H0RzjZYwa/gFiMMkGnfAXqKggCrf9JNLsI9N
0HqUVAI9pgavaCKG4mPcqIdAltywvbikERaYueMGaz42RaKx8QKqmiXWkKTDwF72
3aSAlSQ8t+qoO8pOyYYSIEmr2Pa5FiYsEDnYw1h7y9iSaVTlC24=
=Nn9R
-----END PGP SIGNATURE-----

--m77sxzhttqvntvpf--
