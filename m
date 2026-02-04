Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DB91C862F;
	Wed,  4 Feb 2026 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770212041; cv=none; b=uLv3BB6KGbMkfD3512ikpRaJtljEtZftzsHUw9DSANQnrS379f93JCRyTg3z0pys7R9shya+zm4PA+JoveMBhHIfEFY/oR5KHRle7sppcmSEP8NUe5BBcbYJ8hqtMVTeLJ7U66j7RPABTjyPHcZzj8No1UGS11kf4bjYvArd8II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770212041; c=relaxed/simple;
	bh=xwpW+NxkA3r+ZyPa5hXyZXd3opTw6d2rS5Te40zczpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkHhXI5uWUHdmtjPsWrenWUtJDWYdrr/h2sYIN6sjr1/BK3EEoez+Gj1xsRIbOHpyRBFeXe/hRUt+sf07m+ZYz0hJh9BnXPMkxeGQ7K3Q++KyAshUmsVdgDbEQXpeSJy58RN/TYiE5rruSjDvabwT71X9+ux9HD0FxgnOVIV9pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRrFbJeY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRrFbJeY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5897C4CEF7;
	Wed,  4 Feb 2026 13:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770212041;
	bh=xwpW+NxkA3r+ZyPa5hXyZXd3opTw6d2rS5Te40zczpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NRrFbJeYo1Eu7PxHwYTEPDboxcYBFpqOj//ESFEPRKAT+JZXwYPFl3RpPqWYf/QEI
	 ASx1p2Ib8mavdu/k7BnZh7ezib6V0wHKsQKnkiUW1ZicmZ6kOhsI/q5f5Vnt7jHigL
	 m9EhaiZ9R7jA8EgWqJ8gtd9b/b7S6RdsJOVzdwbF+Z4h3HnCIQgc6Uqy0/rGSfIUgt
	 ziK3eMnUGpjvJtqjgB/YssgM+9cTfWwhpTrTJfaSqvDWuG2yK9gmlrgqR7k1sH7R8u
	 gmkwLkZEG38KOWrl+fpW+gSCKwTlQKcV9Xoz/NDJ/TbHvxCekSbWg26magBijtKMoo
	 Mj9DMuvnYxCdw==
Date: Wed, 4 Feb 2026 14:33:57 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Collin Funk <collin.funk1@gmail.com>
Cc: linux-man@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alyssa Ross <hi@alyssa.is>, Greg KH <greg@kroah.com>, git@vger.kernel.org
Subject: Re: [PATCH] CONTRIBUTING.d/: Document format of 'Fixes:' trailer
 fields
Message-ID: <aYNITpLKCEYFOOsw@devuan>
References: <3a656e90329f26d743d0904f56ae847951c852c7.1770150003.git.alx@kernel.org>
 <87zf5p8jgv.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u5ambhypebfc6e5b"
Content-Disposition: inline
In-Reply-To: <87zf5p8jgv.fsf@gmail.com>


--u5ambhypebfc6e5b
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Collin Funk <collin.funk1@gmail.com>
Cc: linux-man@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alyssa Ross <hi@alyssa.is>, Greg KH <greg@kroah.com>, git@vger.kernel.org
Subject: Re: [PATCH] CONTRIBUTING.d/: Document format of 'Fixes:' trailer
 fields
Message-ID: <aYNITpLKCEYFOOsw@devuan>
References: <3a656e90329f26d743d0904f56ae847951c852c7.1770150003.git.alx@kernel.org>
 <87zf5p8jgv.fsf@gmail.com>
MIME-Version: 1.0
In-Reply-To: <87zf5p8jgv.fsf@gmail.com>

[CC +=3D git@]

Hi Collin,

On 2026-02-03T16:01:52-0800, Collin Funk wrote:
> Alejandro Colomar <alx@kernel.org> writes:
>=20
> > Signed-off-by: Alejandro Colomar <alx@kernel.org>
> > ---
> >
> > Hi!
> >
> > I hadn't yet documented how to produce the Fixes: trailer fields in the
> > Linux man-pages project.  We require the commit-date to disambiguate
> > possible hash (and subject) collisions.  This documents how to produce
> > them easily.
> >
> > I hope this will be useful to other projects.  I've been using this
> > format for some time, and it has some nice properties: it shows at first
> > glance the date of a commit (which itself gives an idea of how many
> > stable versions would need to be fixed).  It can also be parsed by a
> > machine, by having a consistent and simple (unambiguous) format.
> >
> >
> > Have a lovely night!
> > Alex
> >
> >  CONTRIBUTING.d/git                 | 16 ++++++++++++++++
> >  CONTRIBUTING.d/patches/description | 11 +++++++++++
> >  2 files changed, 27 insertions(+)
> >
> > diff --git a/CONTRIBUTING.d/git b/CONTRIBUTING.d/git
> > index 4b7a95472..3f944a23c 100644
> > --- a/CONTRIBUTING.d/git
> > +++ b/CONTRIBUTING.d/git
> > @@ -43,6 +43,22 @@ Description
> >  		$ git config --global \
> >  			sendemail.sendmailcmd 'mutt -H - && true';
> > =20
> > +    Commit references
> > +	'Fixes:' trailer fields should have the following format.
> > +
> > +		Fixes: 12-char-hash ([author-date,] commit-date; "subject")
> > +
> > +	where the author date is optional, and only included if it's
> > +	somehow important.  The commit date is often more important, as
> > +	it's sorted, and thus can be used to find (with a binary search)
> > +	a commit whose hash and subject may have collisions.  To produce
> > +	such fields, the following git aliases are useful.
> > +
> > +		$ git config --global alias.ref \
> > +			"show --no-patch --abbrev=3D12 --date=3Dshort --format=3Dtformat:'%=
C(auto)%h%C(reset) %C(dim white)(%cd%x3B \"%C(reset)%C(auto)%s%C(reset)%C(d=
im white)\")%C(reset)'"
> > +		$ git config --global alias.ref2 \
> > +			"show --no-patch --abbrev=3D12 --date=3Dshort --format=3Dtformat:'%=
C(auto)%h%C(reset) %C(dim white)(%ad, %cd%x3B \"%C(reset)%C(auto)%s%C(reset=
)%C(dim white)\")%C(reset)'"
> > +
>=20
> I would recommend taking a look at the one mentioned in git's
> SubmittingPatches. It looks fairly similar to yours:
>=20
>     $ git ref HEAD
>     d9fb823121b1 (2026-02-02; "maintainer-makefile: propagate MAKEINFO to=
 gendocs")
>     $ git show -s --pretty=3Dreference HEAD
>     d9fb82312 (maintainer-makefile: propagate MAKEINFO to gendocs, 2026-0=
2-02)

I've seen that format before (while investigating all the --pretty=3D
options).  I didn't know that was used in git(1)'s SubmittingPatches,
though.

I considered it, and concluded that it was suboptimal for several
reasons:

-  It is unclear whether ', 2026-02-02' is part of the commit message.
   Since it's common practice to quote the subject in other projects
   --such as the kernel--, a format that quotes the subject is
   preferrable.

-  The date is a short and fixed-width field.  Readability is better if
   such fields go early, as they would be aligned.  Compare:

	8df2abb81a90 (man/man3/stpncpy.3: wfix, 2026-01-06)
	a17ed1cefd7f (man/man3type/intN_t.3type: STANDARDS: These conform to C23, =
2026-01-06)

	8df2abb81a90 (2026-01-06; "man/man3/stpncpy.3: wfix")
	a17ed1cefd7f (2026-01-06; "man/man3type/intN_t.3type: STANDARDS: These con=
form to C23")

-  I use a semicolon, which is a stronger separator than a comma, as
   that allows me to use a comma for adding another sub-field to the
   date field.  In some cases, the author date is useful:

	$ git ref2 8df2abb81a90
	8df2abb81a90 (2026-01-06, 2026-01-06; "man/man3/stpncpy.3: wfix")

   This also allows further future extension, for example for including
   the author and/or committer names, as other fields.

I wondered a few months ago whether I should let git know about this
to improve --pretty=3Dreference.  I guess this is the time.  I've thus
added them to CC.


Have a lovely day!
Alex

> Collin

--=20
<https://www.alejandro-colomar.es>

--u5ambhypebfc6e5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmmDSr8ACgkQ64mZXMKQ
wqmlUQ/9FkDRyOMehzwpNzi6BI49zmE+YpFll6oY/7q9SzWeE1Nwema4YMGC2qKX
EN7YFaRGIUhO3uapY9Co2Jw3Xx7nQUlD7CgqF+4zYg3agfhuayUCJSYR+a+hSGxr
tIjw1gmtFkMK/SEtINyS7IpVZyi0xr3pG/hnjO3BQ1wkzpjl9nGDjvdpUpVN1MWG
wLQA2tB+a8xpGzeDfccNfCuZq8htGLoUvyai/flm7YusaMJijGzXQfaC/ZVeWZpq
7H0tH1/2wu1FkTQcCNV3O/9rkt08SnSfWO+gLTCUr9WsON2h3v7WrOGsryECBQih
opL0vK/ZJNgokEMeEXvaAl8s53519GSUBGywkCRfUt2YOL/RWKIxIjWpVKv8Z4QR
5jVua+OiWOnexMD3yk/HmCP6d0Ub9W6pyu8xhBwS2B5I9kS0iUr0XfND7I4hbgXb
MWq9JPovCnYoTP6RlUomcYflXT3pK1MI0rxXC6tL6YsAE1MMznll+FOmJMOU7ia4
tFwt8qb2b5tAWwLFw/kYfbiNQo2Wl69fxmVdbiGdYz5jAxvzaijNSKPB6MakL75f
GAh35Caip1fX0gNAuMN53nwAnwlk2dj5r6hoMk929hnhBw22FfwySLUL3mpI6Cbd
tOsBQaeu8OsnhCX3Os9duCd6AXEvIgcd9XuuVyaKJzQWCU8Bsj0=
=7Zc1
-----END PGP SIGNATURE-----

--u5ambhypebfc6e5b--
