Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3EC380FC1
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788549751; cv=none; b=VTc/QTEN/V0BaiBRipdULWX8VI/owv3fo5S/PSEOkWFYm3kMy4e7IIYmIp6mjQkLvp+BdYjFlTYIFLH4SYgifjWa5B8yKq5HOhNOpAZCdr3BIuw7CwWbYZn7YhDtSuTJT6LxKGweJKaSP1bmih3idVXZ8+oc0Q+jho0fKX8JWjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788549751; c=relaxed/simple;
	bh=9aDdp/RFqFVnWiFIdvyKm6y1/b9YSLz7pFq9+x2EpUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TE4E3pTvJGngPLTu05vMLxKSEwF66BOrYRfIABpRYvaYPepz9V2OzB6wMHjLhX9+GDa3ymwsaucwXBAwWOv2+CNUVA0iPdYnOMyPl1W08plMtzx8R+IWqfQjTeSFXruU3iY9+W2hdPHb9r4G4LDqiRbwGPpCrjcnEZmTsN4FNuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=zGtzEoED; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zGtzEoED"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1788549739;
	bh=9aDdp/RFqFVnWiFIdvyKm6y1/b9YSLz7pFq9+x2EpUE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=zGtzEoEDzTjolXhYmthZsiCQYL3bFzhbj6NhUGrLEUWjCp5QTcjHIO0ToGOV/FXgk
	 Nyo53P0P6tsRQGU0rt99FQCTcsYJw0FaXunhsehXMGu2UsH/VCRiRyBa/DRsP/JZZl
	 kCAEsQzxKvVZ/cnXBQVHeJhxy9hBHUIEGfptCagpez+H69WDuKWCv2Zhzr9qtmZuXV
	 eI8QVTFO9U+ZwvqjrnJKSHKnriavEp6h05wKwtslbmxxlWwBVer4yIP4J3IgM8ZNmv
	 qoQI3/cCeLJnzudZHtuA69xDqKcF0S81+4dCzv49hEgi4Z2jsh+FtUOOzhJEHFAxpy
	 vGdY3W3+PmqTzHQjvfDRiLmPVzdYablpTQOj0Q/1Kfe3idBomFVTd3vFzG8/LqXb8Q
	 eIAgrv1eMS3CcV0beoJz64RgvIdC8mRKuZO6MTXoee9b2w419IRQC2tUXK6+2tPxkl
	 dgC3X1bFz/4vKfgmGjw7GVsCtzdM5lHkhX3YBYMrPSYJy303ZXR
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:42f7:d8ee:b006:e499])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CD55F20033;
	Fri,  4 Sep 2026 19:22:19 +0000 (UTC)
Date: Fri, 4 Sep 2026 19:22:18 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ramkumar Ramachandra <r@artagnon.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: User report on git 2.55.0
Message-ID: <apsaaQrngwYIVeVM@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ramkumar Ramachandra <r@artagnon.com>,
	Git List <git@vger.kernel.org>
References: <7fb200e9-ff28-4b22-9d9e-dbdec83c2835@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mt9+y6u9d1BGVCRu"
Content-Disposition: inline
In-Reply-To: <7fb200e9-ff28-4b22-9d9e-dbdec83c2835@app.fastmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--mt9+y6u9d1BGVCRu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-09-04 at 18:05:43, Ramkumar Ramachandra wrote:
> Hi,
>=20
> I recently bumped to the latest version of git on macOS via homebrew, and=
 here's what I've noticed:
>=20
> 1. git-replay now updates the ref, simplifying my git-reply-checkout scri=
pt. Someone on this list recommended it to me in response to an issue I had=
 a long time ago, and I think I can safely say that git-replay is an invalu=
able tool. Thanks!
> 2. git-pull often fails with a dangling remote ref error, and fails to up=
date the current branch (main, in my case): the workaround is to reset-hard=
 to origin/main. I'm not sure if this is a GitHub issue, or a bug in core g=
it: I've never encountered this behavior on older versions of git, with the=
 exception of submodules.
> 3. git-diff sometimes exits with 0 code without printing a diff, even tho=
ugh the worktree is dirty: the workaround is to run it again. I've never en=
countered this behavior on older versions of git, and I think it might be a=
 subtle race in core git.
> 4. `git checkout -` sometimes fails with an invalid ref error after a pul=
l, where the previous branch is a local branch. I don't know if this is due=
 to a background git-gc with some behavior change, but I never encountered =
this behavior on older versions without an operation that would cause this.
>=20
> Before digging further to find the root cause, I'd like to know if there =
is some explanation I'm missing, or if these are known issues?

I haven't heard of any of these things and I usually follow bug reports
to the list fairly closely.  I also use Homebrew's Git on my work Mac
using macOS 26 and haven't run into any of these things, either.  I feel
like my colleagues would have mentioned this, too, and I haven't heard
about any such thing anywhere, including in our Git users channel.

Do you maybe have some sort of security software running on your Mac?
That seems like a thing that could cause items 2=E2=80=934.  Also, are you
having any sort of other disk, hardware, or other problems where files
sometimes go missing or don't have the expected content?

Are you using files or reftable as the ref backend for your repositories
(or a combination of both)?  If you're using the files backend, does
switch to reftable (`git refs migrate --ref-format=3Dreftable`) fix the
problem or change the behaviour?
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--mt9+y6u9d1BGVCRu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmqbGmkJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZwPDmZr4j3FUB5x8dExVv8/NpPPxu3I0MjMqGQUKO6fg
FiEECCzmip28ZfuD0cORfAxJYoiHooEAABovAQDPUb5ybDJKOqNqMOcliSfFd7pu
GK0gs44TSYmwzeHTYQEAwzNHznsd3lYKTgbesloZ8KDeIe00HraiTjX55xNsdg8=
=YjdD
-----END PGP SIGNATURE-----

--mt9+y6u9d1BGVCRu--
