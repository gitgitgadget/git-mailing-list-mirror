Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04312E9EAD
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 02:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762826696; cv=none; b=GDCqw4D2ut4wX+RVHnIBrr7VL1ElXU8T5lcG9iVLlitnpJXcDpgFTumpn8ZiRwN4ZM7/xsuH26YZ57ApWp5qJIG4NgjGy0O9uxWY5VDl3vxl5KpwojpUUbOOqjuJlWKh14XqE1yu7VqWoq1RwPQ3/6EMLxOwOAwNkWbmo5uK0eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762826696; c=relaxed/simple;
	bh=8iCud9KYmQVeoRpRlumTpiWPYwY6L1NMolgsq4u/ss4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jH9M/x8Ayf7E4cqgy7eXJVMHIx88WRUBGSUm2VBmruRdz9N2SjAc23OsLB+CiS9z8UN72V9Q0Y743rOQxEjHe18yArhsWZs5z5EW7OTGRQhaMZi+0xTXfzZfz5+RXhaeqaaw+OLshJEOKEPpJKQpP1LNqZ6gWD+LRMeBtSJE81o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=T8mxc4oH; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="T8mxc4oH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1762826692;
	bh=8iCud9KYmQVeoRpRlumTpiWPYwY6L1NMolgsq4u/ss4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=T8mxc4oH5xEg39fsDGlO/HCsK1rDfHzMKZut//6py0E9SH3hD8vwJFr5ENBbrBk1b
	 +7w4f4rQ99CAZRwt0dCefkK/+6HkDCpJuBAf9QXs+pCpWnjCs2b/5lD3zYhJ8UYCXg
	 g09nRfG7pJMp14Dal+jQAA7C6WTu1h/ANHOI9ou1y70fGFXlS1b0FBP03w91PKEICf
	 c0UJD6FBkbS3RQeTpSPf3xGa57Y7ElaTLIYlhOgBNKAd0EIeeRuNV5OA7hFL+O6Gqf
	 CqitwOfR1fRPexLo8HWYIkYLQq5k5j2wM+ujN0+npiH9sNihsCt+Ova9qzfMVdBmQ8
	 4ItocFrhTK/PZ9XeOPhVBEqXTqw5hMXePobKjxRS21MEx1RpfPRGKT7hOdOe6Qw8fs
	 1SSkoRC0BTKhrHsV4UXVx7ztpORfiI09v4Sm0SgkWYaF3pa2cSQQNLgQGcyYLQuPP3
	 8GeslU4mIccglixbgoRTvsn13RUlBGay3zIsIVRCkxFwpjYoexk
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:2884:27a3:f514:5cad])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A750120069;
	Tue, 11 Nov 2025 02:04:52 +0000 (UTC)
Date: Tue, 11 Nov 2025 02:04:51 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ryan Johnson <ryan.johnson.code@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: gitignore redesign proposal
Message-ID: <aRKZw1h35ZZLkTXh@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ryan Johnson <ryan.johnson.code@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <DS0PR03MB7290A11407D68F7F3623FD9CA3CEA@DS0PR03MB7290.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YEOXALysGSnuFEXz"
Content-Disposition: inline
In-Reply-To: <DS0PR03MB7290A11407D68F7F3623FD9CA3CEA@DS0PR03MB7290.namprd03.prod.outlook.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--YEOXALysGSnuFEXz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-11-11 at 01:02:39, Ryan Johnson wrote:
> I have 4 proposed changes to the gitignore feature:
>=20
> 1. Integrate a hard-coded .gitignore.local option for quietly ignoring us=
er files. Automatically ignore this file, or require users to exclude it in=
 the main .gitignore.

Why is this better than $XDG_CONFIG_HOME/git/ignore, which is global and wo=
rks
for all of the user's repositories, or .git/info/exclude, which is per
repository and not checked in?

The former is the ideal place to put things one wants ignored globally,
such as Vim swap files or Emacs backup files, and the latter is suitable
for individual projects.  The former can even be installed by one's
dotfiles so that one's `git status` output is always tidy with regard to
one's editor files.

> 2. Change .gitignore to just gitignore. This is because gitignore is
> not a system configuration file. Users are expected to interact with
> it. Dot-files are typically not user-facing files. They are expected
> to be hidden on Linux systems, which is inconsistent with the
> expectation of user interaction. They are entirely avoided on Windows
> systems for user-facing configuration files. When a user sees ".file"
> on Windows, they know they should be using a GUI to edit the config,
> not hand-hacking. Additionally, dot-files are ambiguous: they could
> contain key-value pairs or scripts. The point is, don't put essential
> controls in a room labeled "For personnel use only" while expecting
> customers to go touch it to get anything done. gitignore is
> fundamentally different from the .git folder in intent.

Typically, we hide files and directories used by version control systems
because there are several of them (.git, .gitignore, .gitmodules, and
=2Egitattributes).

This also helps other tools easily not process VCS-specific files by
providing an option to skip processing hidden files.

CVS and friends did not use hidden files and it was ugly and unwieldy.
(In general, we should avoid replicating CVS's mistakes.)

> 4. Every gitignore file should be initialized with a link to the gitignor=
e templates on GitHub.

We try not to prioritize any particular forge in this project and many
contributors work on a variety of different forges.  Even though I am
employed by a major forge[0], I end up using several because various
projects I would like to participate in are on other forges (even some
projects that we use at work).

There's no reason that the GitHub templates are intrinsically better
than any other options and if an objectively better option comes along,
we would end up providing suboptimal information.

I'll also note that the GitHub templates tend to be very expansive and
cover a large variety of files.  The Python file, for instance, covers
Django, Jupyter Notebook, IPython, Redis, SageMath, and a variety of
other things that most Python projects will never use.  Having a very
long file with a lot of unused entries worsens performance and makes
maintenance of the file much more complicated than necessary, especially
when a project needs custom values as well.

> Why YAML?
>=20
> Being able to include other files in a main ignore file is necessary coll=
aborative environments. Teams need two things:
>=20
> 1. To be able to include templates that are provided by authoritative
> sources (such as next.js, zig, unity, etc). Veteran coders know to
> pull templates from this repository:
> https://github.com/github/gitignore --- a repository that is not
> self-evident in any respect for a beginner software developer.
> Beginners have to just *magically* happen upon the repository or
> search for gitignore templates in a search engine. This intuition is
> not a guarantee, so every gitignore file should be initialized by git
> with a link to that repository to maintain good practice.

I have over 13 years of professional software development experience and
even more non-professional, so I think I would qualify as a veteran
coder.  I don't use those files, either at home or at work.

Instead, when creating a project, I add those files and directories that
are build or intermediate products to .gitignore as one of my first
commits and add additional entries along the way.  That way, I know that
my values are correct for my project.

Note that I almost always have additional custom files that are not
listed in the templates, so I need to edit the file anyway.  I assume
that's true for most everyone, but I could be wrong.

> 2. To be able to organize their gitignores hierarchically. At present,
> people just randomly stick items in the file, so it's a visual mess
> that results in duplicates being added. Removing a duplicate doesn't
> guarantee the removal of the other in very large gitignore files,
> which can cause problems.
>=20
> I previously requested an include feature in the existing gitignore
> parser, but I saw that people are afraid to implement it by modifying
> the normal gitignore syntax to accommodate. To deal with this, I
> recommend implementing a YAML alternative to the traditional gitignore
> file. YAML already has a usable syntax, parser, etc. This extension
> would exist concurrently to the current gitignore implementation so
> that it can be adopted gradually.

I agree that YAML is a very popular option.  However, different parsers
implement different versions, so they work differently.  It also has
some downsides (`no` is interpreted as false, not "no", which is a
frequent source of problems for Norway- and Norwegian-related
information).  Some parsers[1] also don't support parsing byte data encoded
as base64 (the `!!binary` tag), which we would need because Git does not
require filenames to be UTF-8.

Other options, such as JSON or TOML, also don't support non-UTF-8 data
(and JSON doesn't support comments[2]), so those are also out.

[0] My participation in this list, unless stated otherwise, is in my
personal capacity only and I neither speak for my employer nor do they
speak for me.
[1] In my brief few minutes of testing a handful of implementations, I
found Perl's YAML::Tiny, which also does not accept `!!str`.
[2] Before you say, "But there's this variant of JSON that _does_
support comments," that is not standardized and most JSON parsers don't
accept it, so it is strictly worse than using YAML or TOML in terms of
compatibility.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--YEOXALysGSnuFEXz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaRKZwgAKCRB8DEliiIei
gVUwAP0XfAEeYFXJiaacppWoRET315VGp/a6vELFa2BlRUsgUQD/Y8La3aL1RuuX
2O1CWzYAzRkdd5ATpMb+1f0D1+oCTA0=
=GFJe
-----END PGP SIGNATURE-----

--YEOXALysGSnuFEXz--
