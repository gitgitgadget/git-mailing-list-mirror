Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD040DFDF
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 21:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777411239; cv=none; b=r6iFAg1GjlMvMpCkqoevE3yapKr3FIUKusfQakKMGdID4sGvZiFhyrr9TcpHMdlRf78mWin0eLgkwrT1YJ2vCH+ZjrLvVI7L9RgEB6LZ/FO8WXwoM6mNwdOkA1Rm5RtHgp9z4HnPqZW66gEcOLACr3fYqqtsUvPtU3f1AEGsl0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777411239; c=relaxed/simple;
	bh=c0k22xVzOzQ4jrJvWbkJHJ16jsZJnYcC+DmUwe7Anl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sh3dxZXL7rg3AQgHNFODfKnkw2YTPSg+3r3n6UwKvL88jZFwSOSfj5fhjmyha57+5LxYUD9SpIIRoYtuEX21B73kOECQ21AdpI+EjGskxvOZy3i6063/igOdqJAm+PHHvJPFIIDM3QBdUeQtlPzMiTPwc8MonE25z9qhOBCJNAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=WiLlk6wD; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="WiLlk6wD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1777411236;
	bh=c0k22xVzOzQ4jrJvWbkJHJ16jsZJnYcC+DmUwe7Anl0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=WiLlk6wDBTQfZLA5L+SP59pTvvnrTjK8XA3QN7TlhFRL5QgMK2Z8ltpF3MovLcimv
	 CwcWOmQiIFDlUkdwT3+7g+YqhUZnxGEt4TrCdhORgOboTXI9kdYwCpV2i7570PCk3Q
	 BnaE6P+KpnT15371Oc/ZDk+NLpk9vA16a4G0DivYBsEZ/Z7DkCrvWkVlipP9e5Oy4d
	 V7oRELk9EYp+Q7ZLvNuRn4vOvoZa+vRwbUDp2iBhWZLIM1U4FPkEWxC4/IZxeqQzuc
	 1EUjp8153d3HMyvYlgMGIqpeaO/J24Ua2Riw8hbWZB6atbp5tno+EBIJ4csJZvXZJx
	 Rnd3uqDqiKSLinM2f8WhKro+OL5WJiLxgpNlnL8LRM8A+dv8lzPJ+lJ1IjBfstF9Vb
	 uCsqJIujlbVrLHFeaV+THRn8WZ6qD0oTXFNHbgMxQ0p9wxAIDoGOsY40Xi/mKE1VFM
	 cHjJZ6msmM6d1InZJdsC0QUqL2jYflsRiNPNEukDvt9e2tJutUh
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:bac1:b2bc:a4e9:dd0e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5712E2006D;
	Tue, 28 Apr 2026 21:20:36 +0000 (UTC)
Date: Tue, 28 Apr 2026 21:20:35 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Theodore Tso <tytso@mit.edu>
Cc: Simon Richter <Simon.Richter@hogyros.de>, git <git@vger.kernel.org>,
	Ian Jackson <ijackson@chiark.greenend.org.uk>
Subject: Re: Git generated tarballs and Debian
Message-ID: <afEko8bJnN3IOxcl@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Theodore Tso <tytso@mit.edu>,
	Simon Richter <Simon.Richter@hogyros.de>, git <git@vger.kernel.org>,
	Ian Jackson <ijackson@chiark.greenend.org.uk>
References: <9030b26d-02ed-4452-b212-a69a4ff21e2d@hogyros.de>
 <afCLFJX86yEPKKfk@fruit.crustytoothpaste.net>
 <20260428115017.GA71700@macsyma-wired.lan>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uUq+XzCvS16I7wR+"
Content-Disposition: inline
In-Reply-To: <20260428115017.GA71700@macsyma-wired.lan>
User-Agent: Mutt/2.2.13 (2024-03-09)


--uUq+XzCvS16I7wR+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-04-28 at 11:50:17, Theodore Tso wrote:
> On Tue, Apr 28, 2026 at 10:25:24AM +0000, brian m. carlson wrote:
> >=20
> > I'll just note that we don't make any guarantees that `git archive`
> > produces identical output across versions.  Incorrectly making that
> > assumption broke kernel.org when we changed the format in the past.
> >=20
> > Also, if you use `export-subst`, then it's possible to emit short object
> > IDs, which can differ in length depending on how many objects are in the
> > repository.  It's also possible to use zlib or pigz instead of gzip to
> > produce tarballs, in which case the compressed data will also differ.
>=20
> This is what I've been using to try get reproducible tarballs for
> e2fprogs:
>=20
> git archive --prefix=3De2fsprogs-${ver}/ ${commit} | gzip -9n > $fn
>=20
> ,,, where $commit is a signed git tag.
>=20
> I know that in the past, using --format=3Dtgz has broken based on
> different compression parameters used by git (and whether it used an
> external or internal compressor).  I also know that if $commit is a
> tree-id, this can result in the timestamps being not reproduible.  I
> also don't use export-subst.
>=20
> There is also the difference in the prefix used by github and gitlab,
> but that's arguably not git's fault.
>=20
> What other gotchas are there?  How is this likely to be inconsistent
> in the future?  How much work is there to provide that guarantee in
> the future?

We could in theory provide reproducible tar output, but again, nobody
has committed to doing that yet.  If we did that, we would add a special
option that produces, say, reproducible format v1, and if we needed to
make a change, then we would provide reproducible format v2, and so on.
That would also necessarily disable `export-subst`, since that
introduces non-reproducibility.

Of course, if you're using filters, then those can also be a source of
issues.  Git LFS doesn't have that problem because it identifies objects
by SHA-256 hash, but there are many people who _do_ have unreproducible
filters (for instance, inserting the current date and time), so we might
need to disable those as well.

My approach would be to document a format and then implement it and
thoroughly test it.  I was hoping, in fact, to define a format that
other tarball-generating implementations could _also_ implement, since
reproducible tarballs are also an issue for other tools like Cargo.  I
have some code somewhere in some branch to do part of that, but it ran
into complexities due to handling `--add-file` and `--add-virtual-file`,
which are always appended, when we'd actually want them inserted in
sorted order.  This will almost certainly be easier to write in Rust
because of better data structures and easier unit testing, so I may pick
it up at some point.

We cannot guarantee providing reproducible tar.gz output because we
don't control the compressor.  If gzip tomorrow decides to release a
version that produces a different bitstream for some output, we're not
going to ship our own gzip.  Same goes for zlib, especially since
different distros use different libraries to implement that interface.

Our zip files also have the undesirable attribute that they contain both
a local and a UTC timestamp, so the timezone is a problem.  This bit us
at $DAYJOB when we started generating archives inside a container, since
the local timezone changed to UTC[0] and thus the archives were no
longer bit-for-bit identical.  Of course, zip files also have
compression, which adds additional potential for reproducibility
problems.

[0] Yes, I know all servers should be using UTC and I agree, but that
decision got made well before my time.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--uUq+XzCvS16I7wR+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmnxJKIJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ1pSzGAyOGDZbvOJMKwKRj7gsynKv8dPQKnRjSj3GvAQ
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAIr4AQCNMzBwhJ5FxbOulLHV1PrNNAfF
PPxzWG4JyyYTi0EdzgEAiQcPU2oXZHkxfB3Oh0iUBhP/jbTMjoWo1BB0Yyc0vgk=
=G1qj
-----END PGP SIGNATURE-----

--uUq+XzCvS16I7wR+--
