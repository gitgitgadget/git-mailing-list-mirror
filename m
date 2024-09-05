Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A5D165F0E
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725570746; cv=none; b=i8O/uMlGa7s1VPJenVc5APH5bBjIiMeU9yuY8Y+4FVProQla8La6iiFYpVV5QMUbK3Tt3qIsjzJ786HYTRO0bcQhr00fP3ZSt8mgVFL8rQ1SHqH2CapvxCMnvVB9Lhr8zORWfzhLtOgP3+YdtVg8+0t/IZw89kQOWrhUPdz30vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725570746; c=relaxed/simple;
	bh=YyDiI7Ivrl+IPxMlqP00TTg5Ud3CcM84LNpEcvFzntI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0kEtqG9V2SYEtLl+Aq7vcJZxnOmmLfIrpXwk3pcihJxwVQwadeDWSQeMRHGSxfytZ8QLfpv1OWXMclo3RzXzqBzEUedZAzimV/wkPxK9WSH4hOavF5ag+PWTTcWOVi0wlrMtWdBkbLCL6ulA23iyjH2gisgqZW+pBJYjkswNYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=VOBP1Y+m; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="VOBP1Y+m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1725570734;
	bh=YyDiI7Ivrl+IPxMlqP00TTg5Ud3CcM84LNpEcvFzntI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=VOBP1Y+m4PRZoW5N5MP4xsIkWuTv29aAyRQVYJcdr/Esk/PRm1ps7T+ZKmJ52NktW
	 QEsWoN9NoD84Esv4GSN7QHlyX24HTe0dR5j9U1K4a/KoF6OcmuWZmB6sssAUWQAaIo
	 k53qnu+hjmJqu9073LlvyGtxl1TtMTG9YmC9n+0dq6wkXNiGubj+6V/7jki42sZzCP
	 Dfn6m/+MfXid8u2p+4Gg5I25TYzJEz9X/OZeqY0eraiB0Ax14H2BmmTsNZ1wnDwZ+X
	 sLy1V6FKBFM6F0SQs0Aq1hAHmBzADa27iLUNv/oF2a8x8Df12LXl2FLcq5rNuSLfAp
	 YO6j9PNQRJxKGGppYJ6IYWmvUf7ZmUNRJbYxQ/hyAmZAnPm9DpEgFU522OhVx1Moyx
	 Hjhmvu8BNaDyYzaNvcmrji6MHKLzrsX/TCjJugKm/qSWvaHLGDECNFrlrEeczOpOE3
	 AVzIhqlJG6WI+HbR4RDZssp9RWPD1uoBRyioVmJ8aqvrIAStoUD
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A358024455;
	Thu,  5 Sep 2024 21:12:14 +0000 (UTC)
Date: Thu, 5 Sep 2024 21:12:13 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: russell thamm <russell.thamm@hotmail.com>
Cc: git@vger.kernel.org
Subject: Re: git untracks my files
Message-ID: <Ztoere5E8_AV9hvM@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	russell thamm <russell.thamm@hotmail.com>, git@vger.kernel.org
References: <SI6PR01MB6833E05D68861E02407F7641FE9D2@SI6PR01MB6833.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zOQlbaj7uD/kkYxb"
Content-Disposition: inline
In-Reply-To: <SI6PR01MB6833E05D68861E02407F7641FE9D2@SI6PR01MB6833.apcprd01.prod.exchangelabs.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--zOQlbaj7uD/kkYxb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-05 at 04:51:56, russell thamm wrote:
> Under Ubuntu 20.04, when my program modifies one of its log files, git ma=
rks
> it as untracked. Other files that my program modifies are correctly marked
> as modified.
>=20
> This does not happen under Windows 11 and it didn't use to happen under
> Ubuntu.
>=20
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
> Pulled the project, built and ran my program which modified log files.
>=20
> What did you expect to happen? (Expected behavior)
>=20
> I expected the log files to be marked as modified.
>=20
> What happened instead? (Actual behavior)
>=20
> The log files were marked as untracked.
>=20
> What's different between what you expected and what actually happened?
>=20
> I do not expect git to untrack my files.
>=20
> Anything else you want to add:
>=20
> Only happens on Ubuntu 24.04, and not on Windows 11.

I'm not sure that there's enough information for us to go on here.  Are
you sure the file name is exactly the same, including in case and, if
relevant, how it uses Unicode composition in the file system?  Note that
Ubuntu, as with most Unix systems, is case sensitive, and Windows is not
by default.

Can you provide us with an example shell script that can reproduce the
problem, or a repository that we can clone and build relatively easily
that demonstrates the problem?  If we had such a reproduction example,
it would be easy for us to see what the difference in behaviour is
across systems and fix it if it's a bug (or explain what's going on if
it's not).

One final note: typically log files don't belong in a repository, since
they're artifacts from building or running the program, which tend to
cause needless diff noise and merge conflicts.  Thus, usually we'd
recommend that this output not even be stored in a repository at all, so
the files should be untracked and ignored.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--zOQlbaj7uD/kkYxb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZtoerAAKCRB8DEliiIei
gTzIAP4kgttoA6K2ReON5807pvM7TxHVg17LUtT2r1sEE+rVMQEA0d2BKx9FLusd
W47i3vzag3a91Wv3/uGzJtMmgbvrFws=
=zSIe
-----END PGP SIGNATURE-----

--zOQlbaj7uD/kkYxb--
