Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31AD3B1AB
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750108569; cv=none; b=PLPto3iWlcy5SjtjvmuZ17sE/bYDBSBl1nVLd4Yo9R5hWtgz+8Rk+WigO2nNpGmZ3n31tPgTzNUcA5iNF323Qncno5Ag+voOaTnKTVriJDAhMViK5YVTjrHQkaSqh2YHOdc6wFzOrrMkmV2lTnTqeZ4wfHZ2Ks7NdBzIeE6tlrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750108569; c=relaxed/simple;
	bh=HZE9QGxhmdEzmW2Sqs7Q0Tbgfs2KyAGlelvdE03km8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLoFiyrWke7+lTaTCWwN5HRQMdA7JCoWUQC7CEE+MFkNX61g/i3jML8iqfZEbaU3dhL6qA7nY7+yXCV+U1IKfRqMY3cvCltbGmD8CvP9LZtWcWVDcxW9RVHNGlmQcLu0FjkPRV9NwSW+Vcam0BdAw0+BKKv2QdXzFMU4x/2kdlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=JhH1a0nM; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JhH1a0nM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750108563;
	bh=HZE9QGxhmdEzmW2Sqs7Q0Tbgfs2KyAGlelvdE03km8U=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=JhH1a0nMN3GD3BWLaGa0KYyp5fsTPDN9OV84EZd4qjNoku2uNHQ3jmbQs2u4ZVaq4
	 tLYtMC84znYKB9MKgccJ7eJvLdJhn0fu3DQaAzq6ydGqIgKSvMIyQSXSHKJLVBMM94
	 Y8NLuDXqi2YzjeCSpcqYOBQPnUiahSjqSpU2W1GM1LUTPnmKRuQkvnXWWJgCZfFynn
	 HBcqHRciPsJHX2RwkrnLJVzo0ekpGGpjGvxn9YUuPTINBTbrnP5zKTpE2Kej02MZhK
	 bPCLzGfTp6buVIVw5JazQiCWeoWv4hb/Uk4H23IafJLOVssuZfVToLiQZxEichQ2ob
	 dHFhKDCl+jXOS7Ezb+J4X3npuY1dpd6RG7xMzDsrFn+NIsvz7ea+ot80SrSf+qsGkT
	 aKknligCNZqxflyvbytEdhk0I/EHPujVmdxUJF0/ulQldqsWRzaQwfaAiQI3NQuNT3
	 xKk3HpqO4d8yaJnQ3M9qv9VFknLloTLTKHEnGbsrTAw9RJ53KBN
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5a29:1c28:6529:d0a8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A9B7D20120;
	Mon, 16 Jun 2025 21:16:03 +0000 (UTC)
Date: Mon, 16 Jun 2025 21:16:01 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Juri <juraj.sojak@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Git gui webclient info
Message-ID: <aFCJkV-iEvDAcpSM@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Juri <juraj.sojak@gmail.com>, git@vger.kernel.org
References: <CAKn8H7qa_b==1LqPkJ-dmH0UNNp4Z4xbewN+LgcL6-bBPM1boQ@mail.gmail.com>
 <aE9ag8TY7i4Qi1Pr@fruit.crustytoothpaste.net>
 <CAKn8H7rLmdNUrukS8P-c4UMKuk==rGQtHXFCm++Zn9o+T941=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tD3pUrgn6nEGhhNk"
Content-Disposition: inline
In-Reply-To: <CAKn8H7rLmdNUrukS8P-c4UMKuk==rGQtHXFCm++Zn9o+T941=w@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--tD3pUrgn6nEGhhNk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-16 at 11:42:46, Juri wrote:
> Hi,
>=20
> Yeah, I would like to know about a version of Git GUI that runs in the
> browser and is able to modify a repository stored on the server where
> the web version is hosted.
> I found Gitlab and Gogs on the internet, but I'm not sure if it's what I =
need.

Okay, thanks for clarifying.  Git GUI is a graphical tool, so it's not
designed to provide a web interface for modifying a repository.

GitLab and Gogs (and similar tools like Forgejo) are forges that you can
host on your own system, much like GitHub is a forge (and all of those
provide similar features for the most part).  If what you're looking for
is a forge that stores repositories for you in the bare format (that is,
without a working tree you can modify) and that you can fetch and clone
=66rom and push to after modifying locally, then those are what you're
looking for.

If you're looking to have a repository with files checked out that you
can modify on the server, then those aren't the right tools.  If the
server is a Linux server and you're running X11 on your local machine,
you can install Git GUI on the server and use X11 forwarding over SSH to
have it display on your local machine.  However, most people don't want
to install graphical tools on their server and X11 forwarding can be
slow if the server is a long distance away.

If you want a read-only webclient that's just for browsing repositories,
then gitweb or cgit can be decent options, although they, too, usually
work with bare repositories.  They are more lightweight than forges but
are usually used for displaying repositories that are being hosted (for
instance, cgit is used at https://git.kernel.org/).

If you want something that hosts repositories that you can use for
cloning, pushing, and pulling to bare repositories but is more
lightweight than a forge, then gitolite is an option that many people
use.  It can be used in conjunction with something like cgit for web
browsing.

I'm not aware of a good choice for working with repositories that have
working trees in a read-write mode.  Usually we recommend that people
just work with the command line in that case, especially since that's
commonly necessary in working with servers anyway.  Perhaps someone else
can offer some suggestions that might meet your needs, though.

I'll just note also that there are also other tools that can be used in
each of these categories, but these are just some that I'm aware of and
appear to be reasonably common.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--tD3pUrgn6nEGhhNk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHQEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaFCJkAAKCRB8DEliiIei
gTogAPjIhKsztHmE0iXFEGFi/pEErF667e5l3FHTV3zUZ56FAQDp4r4RSzvn6sZT
V4noCYQ6rFoYwafi3W2jtTw6ZQEbCg==
=eEAC
-----END PGP SIGNATURE-----

--tD3pUrgn6nEGhhNk--
