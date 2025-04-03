Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357D018CBFB
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 22:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743719162; cv=none; b=MlDIeMBUw1ndCbTvdtv5PvUIVzpkVlR3TebV6MYqwPrvqlmLjJf7M+KF37GKGDPMmjI53x7w6/czn3xNcFMWPkAOweRUVyRADBf7JRbwgS9RVrk68f2XXVkKzmowY5BOWhgADdEvso2N7YUdbBsasoGM26AisdXESAa65R1R600=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743719162; c=relaxed/simple;
	bh=4HX05w7ti8lEmlh/8ZahjM72frtUR4JJVlyBlAbAtoo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0A1WJE2ZMcUrZrQ0PxOtOSR7Ck2zCvX3WWqRKxZw00FLgtucU60SV0/er1jhe3x2kJaJhtTnkwlJf7lRi4GCklXGgHu88ucnvXe7LLD78pkAMwvmfMtFlyaRBy1yWGV7hnM8vLRRNzxjK7xeZWtctfiSyRMpepxgWeeDgNjZyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=xCuPfrLv; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xCuPfrLv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1743719158;
	bh=4HX05w7ti8lEmlh/8ZahjM72frtUR4JJVlyBlAbAtoo=;
	h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
	 In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
	 Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=xCuPfrLvvjpxzOYs7xdrtzm1xq0TGVQZLTCP1EuiTN21VWK3BuGbOaVObpSfOzTau
	 MDJOyDBdwl5ahjlp6onld3FJd/QYFfLKlLQCi/PbQKSIV7nKIQV2uPxSKWX/Rg4/sE
	 61Jh8gAvYbx5Z9yw0wWbtav7nC7Bm5VknUub4Z8obNUmNlcOax/KQoWVvgv0+91i7C
	 WuyzIpqrbceQzaiWG/PzsP9uBiGaDNq1RuJ4PI++8hrtf4GKuy0lcy6IyTOeVfdP3u
	 oS27fz+46d8xUuxA/5XYyKy8og9+8t6sUf3cZk8GxZ7XRX7C+4776dm6544CaUlE1u
	 6VMhxxNRh4eOqyikwgv60dHWJMdpscCAHUPRPQdsXjIjkB7BqR+v9ZFmU22g6DUeyB
	 8D/yyMtygddmBSCKTaQPEc1aBtwA0v1hY7meAs2YbPZheYTGiKFKCGpvJzk1xSonpH
	 TyeUOLS27OJ99+7MwcQLElV81YoXGzArdtN8P2nPYNgvOMHHMlg
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id AB25A200BE;
	Thu,  3 Apr 2025 22:25:58 +0000 (UTC)
Date: Thu, 3 Apr 2025 22:25:57 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Andrej Zhilenkov <azhilenkov@gmail.com>, git@vger.kernel.org
Subject: Re: Update symlinks after changing core.symlinks
Message-ID: <Z-8K9ZIt4j_UMNZm@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Andrej Zhilenkov <azhilenkov@gmail.com>, git@vger.kernel.org
References: <CAArAzAoU9qDj+yLi3pA6wFYdTAk0UvQk4omSWM1RL4D9w5fw_w@mail.gmail.com>
 <Z-29LsgDvcS0qY5a@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ik8o6/sdbD7rKtC/"
Content-Disposition: inline
In-Reply-To: <Z-29LsgDvcS0qY5a@tapette.crustytoothpaste.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Ik8o6/sdbD7rKtC/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-02 at 22:41:50, brian m. carlson wrote:
> On 2025-04-02 at 07:18:45, Andrej Zhilenkov wrote:
> > Hello! Is there a direct way to update symlinks in repo after changing
> > core.symlinks?
> > E.g. update plain files, if it was false, with symlinks or vice versa.
> >=20
> > I've tried `checkout` and `reset` but they have no effect in this case
> > (see the snippet below). The only two things that are working:
> > - checking out a commit before the symlink was introduced and then
> > checking out any commit after (need to know that special commit to
> > make it work for those specific symlinks, not practical)
> > - removing symlinked files and checking them out specifically (need to
> > either have a list or somehow search for those files to reset)
> >=20
> > Is this the way to do it or is there an alternative?
>=20
> We don't have a way to do this because `core.symlinks` is intended as a
> hint from Git to itself about whether the file system and operating
> system support symlinks that's determined when the repository is
> created.  It's not intended that users modify it, much like
> `core.filemode` or `core.ignorecase`.
>=20
> What is your particular use case that requires changing this value?

I'll also just mention that this seems to be a particular variant of a
use case I've seen elsewhere, which is to force Git to re-check out
every object (or at least re-evaluate which objects need to be checked
out).

Notably, in Git LFS, it's possible to have the small pointer files in
the tree or the large objects.  Going from the former to the latter can
be done with `git lfs checkout`, but there isn't a good way to go back
=66rom the latter to the former.  `git checkout` and `git read-tree` don't
seem to work properly.  I think blowing the index away is possible, but
that's obviously less good for lots of reasons.  A simple re-evaluation
of the smudge filter on each filtered object during a commit would work,
though.

So if there's a good use case for the symlink change, such a feature
might be more generally useful.  I don't plan to implement such a
feature, but I would welcome such a change.  I am still curious about
the reason for changing `core.symlinks`, though.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Ik8o6/sdbD7rKtC/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ+8K9QAKCRB8DEliiIei
gSULAQCgHFeQzHxnpKR2wSm2/rJvSWfekPpPNLQK2iJjTG8vSgEAjZzqOtkONINM
KF9wMUJPMdK0ii0r1S122rmsd+7FYQ4=
=oliW
-----END PGP SIGNATURE-----

--Ik8o6/sdbD7rKtC/--
