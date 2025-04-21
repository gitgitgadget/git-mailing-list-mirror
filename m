Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B981EF393
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745268803; cv=none; b=UFvEmUhnDFg/SxUXekUqQnur7hrUCwg3eg621/utNzrTtaCBkjBilISBtTVhARkwXSC9NSc6j1YQt4iasF2eUJ2XO83I/SSFJDTgNaZRXtGqn7EXq7yRIZexUCzdyNdfwg8Icg77pkFVf4QMuJWYnjf4mIRImGKatKcAX2dvJOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745268803; c=relaxed/simple;
	bh=iS76UqMAMDTrZiDuq+9qvJM4A85mV03GfB8sODDlu9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WU7hvMEiNA5WD8+e7ien9WCH21Zn6AGdquINBrN0Lp9a/j0e5ZqEMQ0SOdOymDwA4PwAeeKxVzu0TGkkDziIXHxmRL4pgxC/bTNkHKQ6/FxeYRHdfWIoq5C+pWpqyYVaPRmbo2s9wUiIOqdq6rk+gchB23wuhe1ghFUD6YRigUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=c8O7uSxf; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="c8O7uSxf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202405; t=1745268796;
	bh=iS76UqMAMDTrZiDuq+9qvJM4A85mV03GfB8sODDlu9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c8O7uSxfY8GT2NHUf4FjaMt96agLFnLwpepHfCOsJYgfeohIJBVKgWUTQJWR6gi1I
	 fWH27q8EF3ECuipemHbykRp5veC6zJJhW5EAP0zr4bs9sW0jvWXBElTOMWVs++EZyt
	 Z/JJnnfD1dCX1Es66Qhm0KNltRCzZZMiiC2V+yTvpqj4Tj3LAD/QXjZROtTO1sfNZ6
	 mvVDqJAO2TMZAe0Ggn8CiEAmzAolgrXYtwm1Z073x8uQxXHSEOzHqU625MIBw+lTU+
	 YPKN0oFDwkPwzpgv8tYnpkdKz08csJpVwxs+rAMiUSH6BCPrc1LH4U7vM9y1Wjv5kg
	 Xpk8km5thcHZw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 1493CF490;
	Mon, 21 Apr 2025 22:53:16 +0200 (CEST)
Date: Mon, 21 Apr 2025 22:53:15 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, 
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>, Elijah Newren <newren@gmail.com>, Glen Choo <glencbz@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] Make remaining usage strings and string tables const
Message-ID: <zvqoyyyfgyjd3chrxaitn7rqbpmosoxd2qfz6hkumkkjzdwxnl@tarta.nabijaczleweli.xyz>
References: <daj53eijkqzsjy5cvuxchea4qm3pbiu673ehetihfffyvwzhgs@tarta.nabijaczleweli.xyz>
 <xmqqv7qx5kb7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="byywn7cepsvyr57b"
Content-Disposition: inline
In-Reply-To: <xmqqv7qx5kb7.fsf@gitster.g>
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--byywn7cepsvyr57b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 01:30:36PM -0700, Junio C Hamano wrote:
> Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz> writes:
> > -static const char *blame_opt_usage[] =3D {
> > +static const char *const blame_opt_usage[] =3D {
> >  	blame_usage,
> >  	"",
> >  	N_("<rev-opts> are documented in git-rev-list(1)"),
> >  	NULL
> >  };
> much looser to allow swapping the pointers in the array is *not* a
> problem per-se, but as long as the compiler would not barf after
> this patch, we know these callers that use these arrays are not
> doing such mutations to these arrays themselves, so it is good.
This built for me on Debian and the resulting binary worked so there's
no obvious sneaky const-incorrectness; it only resulted in one error,
where one of these variables was assigned to a
  const char *      *opt_usage;
instead of a
  const char *const *opt_usage;
this has been obviously fixed and is part of this submission.

I came across this as I was debugging some other issue
(that ended up as me holding it wrong),
static const char *s in library functions appeared quite pervasive,
but those aren't really possible to identify and close semi-automatically
(and it's unclear to me if a tighter analysis scope allows the compiler
 to actually put the static in .rodata or eliminate it outright).

Best,

--byywn7cepsvyr57b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmgGsDkACgkQvP0LAY0m
WPGQuRAAlvxgLMfzSG+ltIBZj+aGp/KF2qq4dzk0NtqAkSrdKM/Fr2yeFbIbzMkC
AZMUUDvqZ2Yd0xeSrGVPl9eDP3u42XOJsFd880JhPTOqv47B4ZHYtjDDbPPAVDUz
ylotHEsjXdn+qwQkNO8K+W4qLdiqoVfcyNQvx/Rw5VeGjZ7WFuUpPiqjhpXEs0ib
ekQDXZua8DzEqllwSOpNflZ9a5RgZ2gbRhTMiX6sTqaQOqz0FX5bV4BJTZ+ChRu5
zBHtbsehzyi+jg0ETIIAo/jjwBDZOVeuPkNYntxAyBAgt7kE9o+lXiaDZ0gwfdzQ
x7ki+d+b3ixRnR6fPNmJGz0SR6eGGGFyJEdGI7y+bRMKXOCc3aUuVCVEaAa/wxDB
K17vndLbJmGpOaWuba87aRDm6KgaS4qd54ECD0llfoLbGeGWluX+Pw9HrP2csWSO
X6MOhFkQyqZ/u1+zDEQ/GpsoorvPRmCgBSuLNMVeVLg5RRXJ2aqpS6wfrHcq9rSs
a9qfELVXlRDEuJqeO3508Rxu0AhuA5k/JIvE2+HQzSsV27a9dkzXBFswcfAXF+t6
aksV4uAcOmWhsorUuEoR0tWCB1iK02VPnY8Zcm+foO1pd2LFynIqFfyE3fo1N8Qi
rBTOFIYkKBBzded0Cm0hief6ilDRk7vVyNfwHkpMo9dkxAFFsD8=
=6g1c
-----END PGP SIGNATURE-----

--byywn7cepsvyr57b--
