Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467354C97
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752186985; cv=none; b=qo9r2HSnIxStdtfqBQuCwMDAC8EZuRc+C69jhmxBmtGRiPYBRPseFU+i446JbuDqQdtmhzsAD8QYava3GVtj3eRd+niQGxZwsn9slsj3ePfjwFdRULASaFMz4BurVxeMxNYAXTLWWYl1BRinf/VthE3v9H3MNm3vsTKKBX/RS/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752186985; c=relaxed/simple;
	bh=KuC99j+ZLcUYfoycPo/hdDikMkZ9/uo6LDgEeCNQNRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/RTxOWBzf59ePgQ/ZarhlfZUnMNBMb8mF6hvrt1bc7uF2cpmlkRQyEVtPKm/Lz1GVBYefsr1qUC8JIvwnaV25pFq6EslU+hhYuyDUNU4xRTsa90MS6NcfahiGCrJW8mRSqjCjM9H1ZqGNU7HOwRE0ObgmafxenLIiipEH61x1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=J9CHS9SY; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="J9CHS9SY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1752186982;
	bh=KuC99j+ZLcUYfoycPo/hdDikMkZ9/uo6LDgEeCNQNRc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=J9CHS9SYKirjSLVQBkjjOasg2KAwdH7Y+w55bb6699TRzNJgHt8QR6mTfdV/kf2+M
	 VooRDuQWKmHqqaYQ+IjVSAqW7dlF/fRXXu46SGQadE2yh+n/HFyt3H7oVBEfwujwS8
	 M2Nhtl6OenrAlUybE5xy3kvCuISMCQQRTsoRv73hn9a8Uf0fu937RyZt5eyTfaGmJL
	 Gtu9090Ix07bqFysIrtG6xeDB3KmVt7bd0Px/9b2PKIz9vrkNrLBgf5ogDsaMWh52R
	 94qCG/e4Ax2EN4PymPBJgf5a8WRvFpBN7c9V4jAFgmWMGE4AWzo/lNAyqisIfAZ5Qf
	 hM6kFm7H0xac3KWREaVjyK/dlg1ibBJLlJhf9lt7Ueuih5TkIu0nCJBYiUmbRmukjN
	 kLs3tRvyERyC5NugyPs3iTeFLmf0qc50QDp25a3rBb5bwk7+/1Ugwu4HdLUEsP3DNl
	 TFT4kVDmPIrVuoZBYfx7EF0ZByRevprCtsbOEFgiUA3srz4nGoF
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:828b:3227:a916:b7f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2F80A20077;
	Thu, 10 Jul 2025 22:36:22 +0000 (UTC)
Date: Thu, 10 Jul 2025 22:36:20 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFD] helping distributors by changing the release schedule?
Message-ID: <aHBAZLC4xTcy9-UR@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqldov4rpt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v2HP/lac4eunYVYJ"
Content-Disposition: inline
In-Reply-To: <xmqqldov4rpt.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--v2HP/lac4eunYVYJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-10 at 22:16:14, Junio C Hamano wrote:
> If we "release" reasonably often enough to make the distinction
> between the tags so smooth and meaningless, would it help in weaning
> the distros off of their mentality that pick one "major" version and
> stick to that version unless the user upgrades the Operating System
> version as a whole?  After all, we do not make changes that are
> backward-incompatible at the end-user level, and the "we stick to a
> given single major released version to give stability to our users"
> mantra that leads distros to ship and support an ancient version is
> hurting them (and their users) more than helping.

I don't think this is going to help.  We do, from time to time, make
incompatible changes (e.g., changes to defaults), as well as
user-visible changes which are not expected in a stable release (e.g.,
advice.defaultBranchName)[0].  There are also just bugs that crop up
=66rom time to time: I remember that one time I broke things when cloning
two files that only differed in case if it was a case-insensitive file
system.  Users will not appreciate that kind of addition to their stable
OS[1].

Most non-rolling-release distributions will not want new non-security
updates, no matter how we package them.  Distros already are not
delighted by the fact that Chromium and non-ESR Firefox release new
versions every six weeks, often with new toolchain requirements, and
_every_ major release is a security update and therefore must be shipped
no matter what.

If you want to do this to help users and provide them more frequent
releases, great.  If you want to do this to help distros, I fear that
you're not going to get many adopters.

If it makes you feel any better, this is a common issue for upstreams
and it certainly was a problem when I was one of the maintainers of Git
LFS, since people would use versions from the distro that had a bug we'd
fixed years before.  I'm not sure there's a great solution out there.

[0] I very much wanted the underlying feature and was looking forward to
it (and still think it's great, to be clear), but the thing that got me
to set init.defaultBranch nearly immediately was the giant advice
message that I didn't want to see every time I initialized a repository.
This is the kind of change which users would be annoyed to see on a
stable upgrade.
[1] Many companies, mine included, use unattended-upgrades to
automatically apply security updates on a periodic basis.  Any sort of
substantial change to the package risks breaking users doing this in a
very noticeable production incident kind of way.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--v2HP/lac4eunYVYJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaHBAZAAKCRB8DEliiIei
gUP5AP9w7YR8qA3Ga0tJcimCfhWfrTVEwMqZFT6AqcCVj2WoJgD/eSb5uvf7rjxt
llcc1SQducUqoW7dAd/BDDxljTmuNAw=
=fl7R
-----END PGP SIGNATURE-----

--v2HP/lac4eunYVYJ--
