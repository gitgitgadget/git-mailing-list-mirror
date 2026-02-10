Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B80525B662;
	Tue, 10 Feb 2026 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770733863; cv=none; b=PC96DsIl97DG9VVyxRqhr+bJvlWEkxEJagdNgb+ZOLsHt5k0YQsFUwNW9qtbjuNUvHkRDZjwYuwOrKRZGZ3nolMp1T8eOFf9ABA9qHiPtQWWrdYiRLQiwzkBum/wVjCp1Q1ATNfjWgJfqaq66TPagxG5wkv3/RYfYgymJBo7aA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770733863; c=relaxed/simple;
	bh=/6D7mtlSsxu6MuFgsjjumKvjX6uQ8f2ofDlklCQlVfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8SaZ+uZrXulzIRiomysUP0hUQVuRurOLUTxPYN24oZNsLQlOdGgPKlYUreATMaBrMzN1Zub1b8jGtfUCIMTj/ANLFKlXPK+Lhy7js5lUMCO1vaAi3EZtdcVHlJWwsDYQlKWtTqe0a5Ha1Zq4CqUwamvWLnaLy27SHBmCw8jyWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okTrY1E+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okTrY1E+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D03C116C6;
	Tue, 10 Feb 2026 14:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770733863;
	bh=/6D7mtlSsxu6MuFgsjjumKvjX6uQ8f2ofDlklCQlVfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=okTrY1E+yUyV2iINPeTNPULJHjHE+XQUyeUn3deAvg3Sd/zwSV0X+89rQp9UAtxyi
	 0dWILd7CCuzamAhE6RsrA1pb+Ex/SQZTmA2k7X+b0DIxZZ3PFZmiMTAQDopilZM5FD
	 dx8CdobMLYJ8c/36LXYYqpxv5HoixIQjN2bUjjiCxH7GboQsNF+QSpa8Ifn89iL/Wn
	 KCevEtuK4bvnBYrL/W+IGRwiNQPhsMk9d7pd5OqX0LjvmoCirnk9B83gGoJeZ+AacF
	 GcbAaOBS5xqh2DRfrFw3ry0YS8nv1K1YgtoOlF4dPqME3H372UFHmlOi6BsJ8KjDV+
	 TETVQ/dmlzN0A==
Date: Tue, 10 Feb 2026 15:30:59 +0100
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org, 
	=?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: linux-man@vger.kernel.org
Subject: Re: [PATCH v2] futex_waitv.2: new page
Message-ID: <aYtAknObJpjszCaj@devuan>
References: <jpyv367v4jdxfxebxw6wh7rgqdfeswzp44dzsycfjt5k2pxe4j@tarta.nabijaczleweli.xyz>
 <se6hm5gnd7cyjsby5q6pctkrws5ecp5gpnfjuy3zh2shd2abyj@tarta.nabijaczleweli.xyz>
 <aYpg1XelZBzpw4ZL@devuan>
 <rqshygydxwpfs2mi5cwxl3wvztgctj3nvu3y5bpo5s32owucna@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ozagggnj4k7r53xj"
Content-Disposition: inline
In-Reply-To: <rqshygydxwpfs2mi5cwxl3wvztgctj3nvu3y5bpo5s32owucna@tarta.nabijaczleweli.xyz>


--ozagggnj4k7r53xj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org, 
	=?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: linux-man@vger.kernel.org
Subject: Re: [PATCH v2] futex_waitv.2: new page
Message-ID: <aYtAknObJpjszCaj@devuan>
References: <jpyv367v4jdxfxebxw6wh7rgqdfeswzp44dzsycfjt5k2pxe4j@tarta.nabijaczleweli.xyz>
 <se6hm5gnd7cyjsby5q6pctkrws5ecp5gpnfjuy3zh2shd2abyj@tarta.nabijaczleweli.xyz>
 <aYpg1XelZBzpw4ZL@devuan>
 <rqshygydxwpfs2mi5cwxl3wvztgctj3nvu3y5bpo5s32owucna@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
In-Reply-To: <rqshygydxwpfs2mi5cwxl3wvztgctj3nvu3y5bpo5s32owucna@tarta.nabijaczleweli.xyz>

Hi!

On 2026-02-10T15:17:55+0100, =D0=BD=D0=B0=D0=B1 wrote:
> Hi!
>=20
> On Mon, Feb 09, 2026 at 11:35:53PM +0100, Alejandro Colomar wrote:
> > On 2026-02-07T23:00:49+0100, =D0=BD=D0=B0=D0=B1 wrote:
> > > Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczlewel=
i.xyz>
> >=20
> > For some reason, the patch doesn't want to apply.  I don't see anything
> > obviously wrong, so it may be an issue in my side?
> >=20
> > 	Applying: futex_waitv.2: new page
> > 	error: affected file 'man2/futex_waitv.2' is beyond a symbolic link
> > 	error: man7/futex.7: does not exist in index
> > 	Patch failed at 0001 futex_waitv.2: new page
> > 	hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> > 	hint: When you have resolved this problem, run "git am --continue".
> > 	hint: If you prefer to skip this patch, run "git am --skip" instead.
> > 	hint: To restore the original branch and stop patching, run "git am --=
abort".
> > 	hint: Disable this message with "git config set advice.mergeConflict f=
alse"
> > 	Press any key to continue...
>=20
> Hm, I did recently set
>   $ git config diff.noprefix
>   true
> I didn't expect this to affect format-patch diffs
> (since it doesn't affect diffs shown by git add -p),
> or, if it did, I expected the designated consumer of format-patch
> diffs (am) to understand this. perhaps not;
> maybe -p0 to git am?
>=20
> A quick search yields
>   https://lore.kernel.org/git/xmqqy1o5op1i.fsf@gitster.g/t/#eaa0323ec4eed=
441b37caf96e1b136529b298dbac
> where you're in the thread and the maintainer says "queued" for a patch
> that would ignore noprefix for format-patch for this reason precisely.
> But clearly not, since my patches were with noprefix=3Dtrue and came out =
-p0.

Oh, that bites again!

Junio, do you still have this queued?
<https://lore.kernel.org/git/xmqqy1o5op1i.fsf@gitster.g/t/#m6f42ff4f0cb2d6d=
d1d68f12a533d04c822b68a80>


Have a lovely day!
Alex

>=20
> Best,



--=20
<https://www.alejandro-colomar.es>

--ozagggnj4k7r53xj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmmLQR0ACgkQ64mZXMKQ
wqlDpw/9E2TyUu3WnmEPciM7JuGN5a1yAO34c5ttqJQv9xdXYRwkd3TgFZcjU4ca
uvV2n7CJgY+RDWH6YJEyP4tiAJgJT/ogBFV0IDBvw8tmEyeNkQqOe9+euLtFBMZG
+GGuHtX6y3cYXuQtCfOR6vrbgUDxqLtm7aj+X70sCkn16IJa6Oc7jRNreHoeihoK
m4CbYcRoITygTLqYj5C/4NzN26HGD+A4fm6zrfO9+PwdkIZPl8BBfbmyLP2A4lw0
O/2LLtTVi99DgXhwo/Jugx7uxMYTJb0dCUJdsuvPh3Do9SJz+5rQOdANZAao4kyg
ruY0iPZ+QrEUYfkMUobPkwpEbefMwCxZ0lrKzbf3pBzXYwFGQ7XvzCBKWpHWgJyt
rtDutnGSG/T9joaQy0yp+OsKqZsn6EodyUr6DaQuoZiAYdmxg6qPiMxcd/1u79qi
W1rRrusyQmMW2V4Sknxm9Whq5DxwmcoeOmJtchbcEDHidQ3dVA1JaivuV+n4J+pi
PM+zidcoPExMp0/qPOpX4cBGbIIIkFvY8UNp9K/1+NvbpbR5K2yHS5LwbTeY57Fe
c0Es3qtgf1TKbRHX29Vu71XeZMuh/8DbpQ45AkDcUlQcop7bZiVCdiVZz61LBcxw
n5pKJV5cYnGh/tNo2XEo/FcC6Zch7FWJ3/u4mf/x6okgGhUh2vs=
=5yH5
-----END PGP SIGNATURE-----

--ozagggnj4k7r53xj--
