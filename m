Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B0B3246E3;
	Tue, 10 Feb 2026 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770748802; cv=none; b=OJnadweCdVPwV0XztVsJqGvREol4hA8J7UzRTW/fsLN0N4sjJpFTokL+jB73/GW6l82yQvt15gWO62a3SX4kRKrtVn0x0wfHFH0yaIq7WLx7c+QkWa5llmXLC5T4OsU1SXEnnBQoW2EX0QrrMt1juvPcBet7RjZzuWv0AWKAXGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770748802; c=relaxed/simple;
	bh=vTw4x8b7eJFQh4k8uSDRHgeHaYN55Co3pdIEjH0JFNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRp8LWGd/hxlqGA9r0HS+H7yRpy9XLqoMn4HIFpON0faLYd63Z4MJ5wl5b9BkJKVhdKjOcBn4nxixLP0iINjDWEvZFG8mknEZ4J4O0ywCyJ8uej1GVypBmLlO35wH70TgT6PFk1DdGD6f+HkhGtERiE+b4bIrHVx/IY7GQhha1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzwvLUi2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzwvLUi2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EFEC116C6;
	Tue, 10 Feb 2026 18:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770748802;
	bh=vTw4x8b7eJFQh4k8uSDRHgeHaYN55Co3pdIEjH0JFNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dzwvLUi29MBMhlPaMEEXmDXezagsbzp8QdGpPjxddZlDSWzaMCjY9Fc0mL1eYNDgT
	 3inwGIqHCOXdaSqciCKGDOaxRkFw5qT339k+gIFMYrNSY/Nc2WubMunOZK+lPFCG/z
	 OUmk9ipxIyNrMKiEuXdPjU0FsxtBOS+ZdLolEovhr/yeE+WWFDOXfRGJ3ZJ8mjlcwI
	 QfWS3oLxD0M9dUCdvdW1retUFEKGajjpqRAh+FjZ9ybOIDwiyWPfguBr3IghLxrpko
	 7rnl+mF2E2634EcEeJhgCLhI2yljlQ5VAHNt7cWkZUBntoEbuQfG97ZF9pM3tDW1yF
	 qbMM4z415G+SA==
Date: Tue, 10 Feb 2026 19:39:58 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, 
	=?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>, linux-man@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] futex_waitv.2: new page
Message-ID: <aYt5-PaPvKGPjI27@devuan>
References: <jpyv367v4jdxfxebxw6wh7rgqdfeswzp44dzsycfjt5k2pxe4j@tarta.nabijaczleweli.xyz>
 <se6hm5gnd7cyjsby5q6pctkrws5ecp5gpnfjuy3zh2shd2abyj@tarta.nabijaczleweli.xyz>
 <aYpg1XelZBzpw4ZL@devuan>
 <rqshygydxwpfs2mi5cwxl3wvztgctj3nvu3y5bpo5s32owucna@tarta.nabijaczleweli.xyz>
 <aYtAknObJpjszCaj@devuan>
 <55bd6ad3-cd19-4839-a808-eceae802d3c8@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2mwwcg22kklveia5"
Content-Disposition: inline
In-Reply-To: <55bd6ad3-cd19-4839-a808-eceae802d3c8@app.fastmail.com>


--2mwwcg22kklveia5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, 
	=?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>, linux-man@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] futex_waitv.2: new page
Message-ID: <aYt5-PaPvKGPjI27@devuan>
References: <jpyv367v4jdxfxebxw6wh7rgqdfeswzp44dzsycfjt5k2pxe4j@tarta.nabijaczleweli.xyz>
 <se6hm5gnd7cyjsby5q6pctkrws5ecp5gpnfjuy3zh2shd2abyj@tarta.nabijaczleweli.xyz>
 <aYpg1XelZBzpw4ZL@devuan>
 <rqshygydxwpfs2mi5cwxl3wvztgctj3nvu3y5bpo5s32owucna@tarta.nabijaczleweli.xyz>
 <aYtAknObJpjszCaj@devuan>
 <55bd6ad3-cd19-4839-a808-eceae802d3c8@app.fastmail.com>
MIME-Version: 1.0
In-Reply-To: <55bd6ad3-cd19-4839-a808-eceae802d3c8@app.fastmail.com>

Hi Kristoffer, =D0=BD=D0=B0=D0=B1,

On 2026-02-10T16:54:02+0100, Kristoffer Haugsbakk wrote:
> On Tue, Feb 10, 2026, at 15:30, Alejandro Colomar wrote:
> > Hi!
> >
> > On 2026-02-10T15:17:55+0100, =D0=BD=D0=B0=D0=B1 wrote:
> >> Hi!
> >>
> >> On Mon, Feb 09, 2026 at 11:35:53PM +0100, Alejandro Colomar wrote:
> >> > On 2026-02-07T23:00:49+0100, =D0=BD=D0=B0=D0=B1 wrote:
> >> > > Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczle=
weli.xyz>
> >> >
> >> > For some reason, the patch doesn't want to apply.  I don't see anyth=
ing
> >> > obviously wrong, so it may be an issue in my side?
> >> >
> >> > 	Applying: futex_waitv.2: new page
> >> > 	error: affected file 'man2/futex_waitv.2' is beyond a symbolic link
> >> > 	error: man7/futex.7: does not exist in index
> >> > 	Patch failed at 0001 futex_waitv.2: new page
> >> > 	hint: Use 'git am --show-current-patch=3Ddiff' to see the failed pa=
tch
> >> > 	hint: When you have resolved this problem, run "git am --continue".
> >> > 	hint: If you prefer to skip this patch, run "git am --skip" instead.
> >> > 	hint: To restore the original branch and stop patching, run "git am=
 --abort".
> >> > 	hint: Disable this message with "git config set advice.mergeConflic=
t false"
> >> > 	Press any key to continue...
> >>
> >> Hm, I did recently set
> >>   $ git config diff.noprefix
> >>   true
> >> I didn't expect this to affect format-patch diffs
> >> (since it doesn't affect diffs shown by git add -p),
> >> or, if it did, I expected the designated consumer of format-patch
> >> diffs (am) to understand this. perhaps not;
> >> maybe -p0 to git am?
> >>
> >> A quick search yields
> >>   https://lore.kernel.org/git/xmqqy1o5op1i.fsf@gitster.g/t/#eaa0323ec4=
eed441b37caf96e1b136529b298dbac
> >> where you're in the thread and the maintainer says "queued" for a patch
> >> that would ignore noprefix for format-patch for this reason precisely.
> >> But clearly not, since my patches were with noprefix=3Dtrue and came o=
ut -p0.
> >
> > Oh, that bites again!
> >
> > Junio, do you still have this queued?
> > <https://lore.kernel.org/git/xmqqy1o5op1i.fsf@gitster.g/t/#m6f42ff4f0cb=
2d6dd1d68f12a533d04c822b68a80>
>=20
> See 15108de2 (Merge branch 'jk/format-patch-ignore-noprefix',
> 2023-03-21).

Ahhh, it seems that the OP is using a too-old version of git.  I saw at
the bottom of the patch 2.39.5.  But the fix was part of 2.41.0.

	$ git describe --contains ab89575387c02ea024163256826ad1c6dd2e4247
	v2.41.0-rc0~141^2

This seems reasonable.  =D0=BD=D0=B0=D0=B1, would you mind not using that f=
lag unless
you use a recent-enough git(1) (I suspect you're on an old Debian)?  :)

	alx@devuan:~/src/linux/git/main$ git show v2.41.0 | grep ^Date
	Date:   2023-06-01 15:28:43 +0900
	Date:   2023-06-01 15:28:26 +0900
	alx@devuan:~/src/linux/git/main$ git show v2.39.5 | grep ^Date
	Date:   2024-05-30 17:22:58 -0700
	Date:   2024-05-30 16:52:52 -0700
	alx@devuan:~/src/linux/git/main$ git show v2.39.0 | grep ^Date
	Date:   2022-12-12 09:59:23 +0900
	Date:   2022-12-12 09:59:08 +0900


Have a lovely night!
Alex

> An aside but `format.noprefix` is not a boolean like `diff.noprefix`.
> It will be enabled with any value.
>=20
> Is it standard to indicate this with the existing =E2=80=9CIf set,=E2=80=
=9D, perhaps? Or
> should it say =E2=80=9Cenabled with any value=E2=80=9D?
>=20
> (+Cc Peff)
>=20
>     format.noprefix::
>             If set, do not show any source or destination prefix in patch=
es.
>             This is equivalent to the `diff.noprefix` option used by `git
>             diff` (but which is not respected by `format-patch`). Note th=
at
>             by setting this, the receiver of any patches you generate will
>             have to apply them using the `-p0` option.

--=20
<https://www.alejandro-colomar.es>

--2mwwcg22kklveia5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmmLe3gACgkQ64mZXMKQ
wqlzMxAAuGYuSgSKrUL4qHH0C5vPOefQYDdDnvoSps2KLLLlRwgXNKf0eqkK6nD8
qvO128TcYu7ink3h/OPfokvgU9/4rjmATvS17LWZaqgWzqDdYQJEqS0QdpHk8DJ1
gwgkO0eHaxh3871AylRIRHXaUD5c0UGWfSFDZ4R/GVIeqVKhJpJHp3zE0l0RvGo2
WRzbzkyEQkZ0hGOYTTG2GWcN5DHLy7HeXr1eMQpVIY+SRzvYPxfXRaQ6/2Yr1QAz
UHeWnlIkJ/gHvNtApHvRiWo/zxG68BY5oQoNwGojWO5BW92gaZMburu+S8Ll0wCd
cONM1sXw0BrcVQ+mNYLCvW3V1EkMWqrLGcwdOHQldLZliJ619QIR8cWVUiMGtRZ3
z4eAQff3DrktHPGLrQzk59raiNirjhlIoF+aDN155SnlXtVhfuqn6F2xmkIlPGIJ
/nbrxx0H9OC3lXl/YcwBtfMKzXfHBUkxLbwS0E+F0JyOSPlwKZgWM8i5oMXYR98p
uPvyaFl23b2/bBxtZqJNERHlXFzaKZtp092HJ2SWpv0kd2riAW1F0Q1ua6BxRDqW
8ynmeBO/y4zhNBeaEBd7Zl+4kSqjWY/0PaddgJr5JZKrgz3qIu1pk9VwlG0Cox+w
3lQzd/9Tw+aYKgGNQUYtmqQNLiuVGqJmFGRL2Gi+Y4gYp5qkqLI=
=EXTs
-----END PGP SIGNATURE-----

--2mwwcg22kklveia5--
