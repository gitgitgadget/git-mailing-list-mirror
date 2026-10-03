Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3D5345736
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791061631; cv=none; b=MPqn3xUJDPPbDs+lm3p/OphPSvvwM1r78LDf2MT+WGnifC+6inSGA1UI2f8CbxFMveUDVXe3NC0Z44+6bSrfoBlN+OnCrCuaIYeEzPpny9ehwb+tLEyAOb4h2R5ZbQoVD0LIMz5lvm0BbEnfB+bi0XKyhzVb7DLSWwGwWBbTKQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791061631; c=relaxed/simple;
	bh=wrBxUE6kB/CDO++Jqhyhh3fjs4QLIx7yFIIeF7OxOWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6vRpXOYPZlJbyf5OZrENPeWbGS9mOyJufb4dMA50bcIy7cKL5A8fn5LnGUFL48dFg9HQ5zXwXxVg/FH2cqXNmtHu0paDyEpqewDVaHE5HM46rIhVtt5dt4xBMk0lILY7u9Qk8JB1LX+G4PSUOvTy8rArp+Ppb67oAjriYNTM3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEm7TAOo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEm7TAOo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB10B1F0089B;
	Sat,  3 Oct 2026 21:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791061630;
	bh=92zCp2nYLmq1rFPRhOuwJE7rMCBzQlmLfNxp/dxEgNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IEm7TAOoifxLwJGchOdnpgLdizhJGtEFrLKLEaIRFoPiPjxvMk9S/z5Qb0x7Y5TAO
	 9GfL0tR4OFoYDNqL0r/ECZI3WybcspBjH0mPOHD/JEicBcC87oPje0geh2SFldKrjq
	 wEOdaBUEOaKMCgP0U17Mpu/BiSZr4sUEynte7t8LR6zpywV3Y8viYjDnsQ42+zfhNH
	 C/984pWab3XkFx/QJHj95QhbQpab8KfTg9FwUk4iSNJ3wA7THbqx4UQckFtVxSunkK
	 1z3GETxlJ82keb4+u9J+NriOnhw2ls2Dd0e6T5HWrS5RUdAMNedcEphH5I53Ok0MG8
	 v14TJ/kJufhrg==
Date: Sat, 3 Oct 2026 23:07:04 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Nico Williams <nico@cryptonector.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Ben Boeckel <mathstuf@gmail.com>, Viktor Dukhovni <viktor@openssl.org>
Subject: Re: [RFC] git-brebase
Message-ID: <asFtLJDJliQBPe1c@debian>
References: <asFRVdMTpshsazgM@debian>
 <asFoDZKscLKqaIf+@ubby>
 <asFqLv3hMEE7yEOC@ubby>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h2fu7crrqzd43zqh"
Content-Disposition: inline
In-Reply-To: <asFqLv3hMEE7yEOC@ubby>


--h2fu7crrqzd43zqh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Nico Williams <nico@cryptonector.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Ben Boeckel <mathstuf@gmail.com>, Viktor Dukhovni <viktor@openssl.org>
Subject: Re: [RFC] git-brebase
Message-ID: <asFtLJDJliQBPe1c@debian>
References: <asFRVdMTpshsazgM@debian>
 <asFoDZKscLKqaIf+@ubby>
 <asFqLv3hMEE7yEOC@ubby>
MIME-Version: 1.0
In-Reply-To: <asFqLv3hMEE7yEOC@ubby>

Hi Nico,

> Date: 2026-10-03 15:48:46-0500
> From: Nico Williams <nico@cryptonector.com>
>
> On Sat, Oct 03, 2026 at 03:39:41PM -0500, Nico Williams wrote:
> > that it deserves a name.  But also, `git-rebase(1)` should always have
> > been this useful, so that argues for this to be either... a new option
> > like `--onto-first-conflict`, or even a new default behavior.
>=20
> I.e., maybe if I run `git rebase $upstream/$branch` and there's
> conflicts then it should do this bisection to drop me at the first
> upstream commit to introduce conflicts, stop, inform me of this, inform
> me that after I finish resolving conflicts I need to run `git rebase
> --continue` until that's done, that I should then `git rebase
> $upstream/$branch` again.
>=20
> Additionally when `git rebase --continue` finishes successfully, if
> we're not at `$upstream/$branch` then `--continue` should run `git
> rebase $upstream/$branch` directly.  This means recording the target
> committish along with other git rebase state during the rebase.  This
> would feel very natural to me.

What would --abort do?  Go back to the begining of this iteration, or to
the very first initial state of the branch?

The useful thing would be to just go back to the begining of this
iteration --that is essential for rebasing entire trees of branches, as
explained in the previous message--.

Since --abort doesn't go all the way back, I think --continue shouldn't
continue all the way forward, for consistency.

If that's desired behavior, it should go in this tool, and not as part
of git-rebase(1).  git-rebase(1) is a much simpler and much more
fundamental tool, which is used to build this more complex tool.
That's one reason I'm rather opposed to having this as part of
git-rebase(1); it would confuse about the responsibility of
git-rebase(1).  IMO, git-rebase(1) is a plumbing command, and
git-brebase would be a porcelain thingy.

> If we take this approach then we'd need an option not to enable this
> behavior but to disable it, something like `--direct`.

That hints it might be just be a different command.

> The more I think about it, the more I want this approach to be the
> default for `git rebase`.  But maybe there's a good reason not to?
> Maybe first ship the option, then later make it the default?
>=20
> Nico
> --=20


Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es>

--h2fu7crrqzd43zqh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrBbngACgkQ64mZXMKQ
wqk+Yw//XYFSZ221E9uA5KDs2B5KaAOGEUxm1qRE/phcs9ZWppepiOKUK6pbiGBI
fRWAVQFyTxdcsM+Hhqh6iR/OMe08kc+I5g9nNq5ByC1qGX9q5nR2XOWVJWNbCn1+
2EoAnt3xnKyPdwUslonpU1NWsIMSihRnbFxJevhhm8iU/0FjFB+4f0KYwRQqfFPT
UR1UApx8BkuX8DBwqTmQ3lq5bR8EbDi1oNBGfIrLVBrYzmEwOIjzrJB1g38SAW+U
WjzS82QQ/RwSbDXBpBPE7gfXj7+/LUuBO0Zj5+DSRmt/q/kYbrX2WZNdi27GwMLh
K1sJjr4cj7glC7j1fINU/mxD8RmdZaVzVwqMZ5yQcs+AkWKt2tbrHS0nc8AddhWS
yv8Ccr1gQsEjyVWdAXLYw7JQIKQmFNLuERLuaurzGD1AFd1ET41S+IAhCvu0uDh8
v4FljFHCQD0aHJT4dWNgLvd995X6+b3HwFY65LGWYRIRd6Dv013bpStWWOuwqymc
lw1gTtainfR28eAiDAjdXrBScngN9QfIUIT12rbvhnGGskRWGFxE39GidFGK2j8E
e+8wxJsV+NYxd6jXRDZPA8c/1GJnjmIy2JN5Mqt+fRmiaXM7cuotcv3K3+gQisyi
pGA72ejaGiU9uYYkNj0VfcKl/Lr4TAW0+3nWuEdpZNmTYTnXisQ=
=JsrR
-----END PGP SIGNATURE-----

--h2fu7crrqzd43zqh--
