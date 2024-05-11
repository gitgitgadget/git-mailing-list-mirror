Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C1D54F87
	for <git@vger.kernel.org>; Sat, 11 May 2024 11:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715428021; cv=none; b=f8QpFh3ooUoUrov5yC+CkV8m79Se7qW+LZqQx75f7vn37tSdvvIEFwjF6C6lurEN+rAWID4evjn7jFuejNbJ8g/05fxyOzcKn4xIMR/SX+JRs0hij5wtYef5KOGGVs0YIrlfJHC7hukAfMTzzuax8GcGA60+UeVA8kwVQo58t2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715428021; c=relaxed/simple;
	bh=vAX/s1eTnG5XsJZzIlV+kCLMxVfoVT9BmCPopDserIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnLQrkpqLKPcUwEI0otwBY8rjoyxFS0lr0KM/LfQqBK465xJGGMZgXYt7y7W33SYnqVRTLZr9btcUGUToIcJvzj6g6gi2jWm5fusax6yr18EReAJmf20wKqtt2QUMx5IU6ZdYog2pVhL9D3IHmeqbtgsPqo3US4MG7Ni1vDRsmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBVRcu8h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBVRcu8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33087C2BBFC;
	Sat, 11 May 2024 11:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715428021;
	bh=vAX/s1eTnG5XsJZzIlV+kCLMxVfoVT9BmCPopDserIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NBVRcu8hOW/1HSdCVZtTrUZK3OCHEhv29fkZdALpKUQBW1AIf8VMnAesiTWGQ+LKV
	 26tvhOv9OuII2b+B6qL24WrD5289uarc+lHaRRL7QUGhWtnOJSoAF4DgQTcQ4HXuHo
	 ctTZvMZhS0s4bQuB5hRFnOhyeg8JKKkwapmmzT3EgTUv8mHQkru6KQ32oME3ApCBuN
	 hhFBiPeKBU2+KcFNWTNL+eI9EXc+2i8H91S6cCWjTW2J6D8imK+GsyDWplMOidozzM
	 AJYexoUvxTgskKvY3bvTshuu+vUIHsAYGGHA5PxCtT0O1yOKEG3f2itZ1ebv2NaDV+
	 1uPn8RDUzxXUg==
Date: Sat, 11 May 2024 13:46:57 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: git-cherry-pick(1) -- path
Message-ID: <bpjfsabhstkbuvo6ksj3owoxvutgquripmqmqi63ykaquhky2u@r7mfrwucgnye>
References: <e5pklmijfpbsnl2trj4n4czam7n7i37gx7w56med2pfaf6q3yx@wizseio2ickk>
 <xmqqv83mqxg3.fsf@gitster.g>
 <kk244kap6lhuvtfot55u4yb5k5eddwlzl4izlzqhe4pdj52cx7@slghmpvdswkt>
 <9b42e684-32e0-4372-8da6-40f9b708b6ca@gmail.com>
 <xmqqcypt61lo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jl6rfyxtxjadgltn"
Content-Disposition: inline
In-Reply-To: <xmqqcypt61lo.fsf@gitster.g>


--jl6rfyxtxjadgltn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: git-cherry-pick(1) -- path
References: <e5pklmijfpbsnl2trj4n4czam7n7i37gx7w56med2pfaf6q3yx@wizseio2ickk>
 <xmqqv83mqxg3.fsf@gitster.g>
 <kk244kap6lhuvtfot55u4yb5k5eddwlzl4izlzqhe4pdj52cx7@slghmpvdswkt>
 <9b42e684-32e0-4372-8da6-40f9b708b6ca@gmail.com>
 <xmqqcypt61lo.fsf@gitster.g>
MIME-Version: 1.0
In-Reply-To: <xmqqcypt61lo.fsf@gitster.g>

Hi Phillip, Junio,

On Fri, May 10, 2024 at 10:03:31AM GMT, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>=20
> >>>      $ git format-patch --stdout -1 $ThatCommit -- $ThisPath |
> >>>        git am -3
> >> Hmmm, I hadn't thought of that; very interesting!
> >> Although I have some concerns with git-am(1); basically that it's
> >> almost
> >> clueless when there's a conflict.
> >
> > "git am -3" should be fine here as you're guaranteed to have the
> > necessary blobs available to create conflicts - this is what "git
> > rebase --apply" does.
>=20
> Good thing to point out.  "am -3" is just as good for this purpose
> and "almost clueless" is a derogatory comment that requires an
> apology ;-)

Huh, I am quite surprised by `git am -3`.  I've tried it just now, and
it's amazing.  I certainly must apologize.  :-)

I tried it yesterday, but the patches were from a different repo, and
not available locally, so it really didn't do anything.  But now I tried
it within the same repo, and it's really nice!

> > As far as the implementation goes I haven't thought too deeply but I
> > suspect we'd want to create a couple of trees based on the commit we
> > want to cherry-pick and its parent filtered by the pathspec and use
> > those in the tree-way merge with HEAD.
>=20
> If we were to use the ort machinery, it may not be too bad to use
> the pathspec only at the final writeout phase.  That is, perform a
> full cherry-pick in the in-core index, reset all the entries in the
> in-core index back to HEAD that are outside the given pathspec, and
> then write out the result to the working tree.  That way, an old
> change that was made to paths at the original location can be cherry
> picked to a much newer tree after these paths have been moved to a
> different location.  Doing the same with the recursive machinery
> would be missier but perhaps the more recent merge-tree that uses
> the ort machinery to work purely in-core might be a good way to go.

I didn't understand the last part well, but I guess I may do when I
start researching into it.  :)

Apart from <builtin/revert.c>, do you recommend I look into any
particular files?

Thanks!

And have a lovely weekend!
Alex


--=20
<https://www.alejandro-colomar.es/>
A client is hiring kernel driver, mm, and/or crypto developers;
contact me if interested.

--jl6rfyxtxjadgltn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmY/WqsACgkQnowa+77/
2zJaXBAAixljx9Y7m1mSJaGR+MGJRcB0xOqwOCoNQpE9U/rVO2N42+AsHt9bJa+0
Z9lAqHgwuY9acu4MmyJbe/QLBQ+9bKT3yCKs31RS6i1S6gsoXpFi8tKHjsiA+5HG
SrDfHcnLkYGKhiTUCse49N14w8Ir9+H5LiFl58B4AjFJDL2baTp+H4FmYPcoG1tT
uQSDwp28zoB06/gM87vhwfQN3ICopqqgneHRq1thqcAFHgIhdFohlpL26YBy9Hw9
Q+7jK4ywAN6ElcFUPWAp8hoCDKOpMZWXrbhl9c6IZvQiNsUk3J9KwcOCGWQFTtK4
eyRlK1JW5FVLMV8ZIqycCkUMXlam3kBP7DP2xZZrKxUkQ7+Ek+ySJBmXBC/QZp80
HcwsxJWFF0sKlH5db6mQoglZdsmkzHQTjWQs+qL89slZUHwQeGvYYSkB2PN1QXJH
OzHk2FCZLFgY5bH8J5YChOOGQFAXfOm2rtd0VHytB9DovSahkXsiKtgGfBQI9LFg
H1SA6zTgdyvxKwTB/ZiW5gTBoAylYAkAZAsSkES83hnG8XpWLeMFrHc3buoM+4nq
lfNNhe5j5YVryC3VpRnRco2xe2D6zRgEHn0dCpnN8WnlsOMndEUewAIj8bbdt3iL
1PwXOwZTn12Qo99N7wsYprV2ovefJnMINqa0oFwk2REhr5VHwgs=
=4B/5
-----END PGP SIGNATURE-----

--jl6rfyxtxjadgltn--
