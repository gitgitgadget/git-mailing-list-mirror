Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C9B230BE9
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790974867; cv=none; b=VRPBLv9uCf/4TXdEiKFZcDz2X6mIDtsd2EEWrApi8NyCg+1L35hmGSuf2wGkwAtymGQ5/A7vnohm+Zvfo5s8hkBJEQaYIsDR0aGSMY9yLvuiO7ro9RRB4O/PfuO0y/t8JZcleH1qRr64cYTWxbfwHf+xQ6+/2Fp1obVT05O6kUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790974867; c=relaxed/simple;
	bh=/SmIvhEhIX/uqtfJ68C1UVmryxZfIZf32e+C8PzgJ48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3FFxePfFEoWQC4uVqA+yvb9MrxhGWoQWd5Ln4VK5tr0aNa5MXQUzf+KRE2mH/4r0NVcNG+5qDOBqiSOdLHngrMCQIrd+RXE0z3YZaDRewYSjZczO8mZ4KUt68mNFp0uTrX29bZIv3iETvmgWtpeH4Vkb0Pt6MctP5YEiY9px1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=cXSO6o3Q; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="cXSO6o3Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1790974863;
	bh=/SmIvhEhIX/uqtfJ68C1UVmryxZfIZf32e+C8PzgJ48=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=cXSO6o3QNRCaGSyL6XeWZyHHTGHXqVDUDAoCOgUPCJuQiwiG/Ki+uTlCNHVkiSS6D
	 PEr8U7ni/02CC2Ix24hHaWKbL1pfiIjeVASipFaoLJBvkPbZCkfivuQs4luXfYfe2J
	 POP0IGYymh1iTapuKqIz375WJBCPkxFaCvCQE9EVJccH1uEjbjyGMYwwYTekwK+BGA
	 XmfdU5GNehR0QI7S69nBFPAZteUBVDpdaN19RPsl7G4ZIKOLHHVdNDtU2kxomerC4Y
	 +VRkZD81+dBtx/Zjq6w3uymlvtCr3JCakm/UsIsen8hRW6yzrXjCQmTR00iV0wYN0u
	 zqkpRQGNNMwzcnC+ZJTqJmd9WASGtUHa3A7PW4uixjfp/tnd2P3Wn87qw1DzjL2z2M
	 4wKqixypQsRKYn9P1nwn3G7T+dSFlveEBfoKMFV+ZEqPav+RiJfoR1NaF35znR5IFg
	 RY1oMDXUdAnSYcDV1w5ITa3ojbpAY+seaBknAo/vdhc2T0ABvOt
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:7c1:8d15:f288:f856])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E080C20075;
	Fri,  2 Oct 2026 21:01:03 +0000 (UTC)
Date: Fri, 2 Oct 2026 21:01:02 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christophe Lohr <christophe.lohr@cegetel.net>, git@vger.kernel.org
Subject: Re: Confusion with git config list --show-origin
Message-ID: <asAbjl-3IIbGKGkA@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Christophe Lohr <christophe.lohr@cegetel.net>, git@vger.kernel.org
References: <b93a24c5-7411-4bf0-ad1a-aa5999f107f9@cegetel.net>
 <ar3_jVZPdgKSZJF2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D127k+LGqtNg1azx"
Content-Disposition: inline
In-Reply-To: <ar3_jVZPdgKSZJF2@pks.im>
User-Agent: Mutt/2.4.1 (2026-07-04)

--D127k+LGqtNg1azx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-01 at 06:37:01, Patrick Steinhardt wrote:
> On Tue, Sep 29, 2026 at 02:36:20PM +0200, Christophe Lohr wrote:
> > Hello,
> > =C2=A0 The 'git config list --show-origin' command is very useful for
> > understanding where the settings come from.
> > This command lists the files involved, specifying the full path for each
> > one,
> > except for '.git/config'
> >=20
> > This gives the impression that there is a '.git/' directory in the curr=
ent
> > working directory, even though it isn't located here but higher up in t=
he
> > directory tree.
> > So, may I suggest, that this command display the full path to the
> > .git/config file used by the current git command?
>=20
> I agree that this is quite confusing. I'm a bit torn on whether the
> consequence of that is that the resulting path should be an absolute
> one. But at the very least, in the case where we're not in the root of
> the Git repository there is a good case to be made that we should adapt
> the relative path to be relative to the current working directory and
> not to the top-level directory of the repository.
>=20
> One thing I wonder about though is whether that would break any users
> out there. I think it's unlikely that any scripts out there parse the
> output. But if they do, they may have long since learned that the
> repository-local file is always specified relative to the top-level
> directory of the repository. And if we were to change that now, then
> those scripts may break.
>=20
> As I said, I think the risk of breakage is comparatively low. But I'd be
> curious to learn what others think about this.

I think it would be fine to specify it as an absolute path, provided
it's canonicalized (symlink-free).  We already do that for other paths
in the output, so callers already have to deal with that case.

There is certainly the possibility of breakage, but I agree it's likely
low.  It's also not hard to do something like `git rev-parse
--path-format=3Dabsolute --git-path config` to find out which file is the
local file among multiple.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--D127k+LGqtNg1azx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrAG44JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ+Qb6HyvTzOY3zUVNRK3FYHftDsI2rDXbp40ojP6XQB4
FiEECCzmip28ZfuD0cORfAxJYoiHooEAALs7AQCosRsKEpfZwhqqdkBxvs8o8Y9l
zlY9dq5CpF3q4enkZQD/TUkdKCRqRWvneSjDYgXVEXtZ1freil/QzJhpzddQWg0=
=2nvP
-----END PGP SIGNATURE-----

--D127k+LGqtNg1azx--
