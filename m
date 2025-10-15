Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AEA30BBA2
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567311; cv=none; b=sPeyUtYAkiRGSNFC/MkIJjO3Yav6Dou/0pBowQfmiWMS2s/BPoDqYfv3uAo7kedjXS8ppHEKEB53+EpjCPO72efEFEfofQsAas0BrWZwzzJ8HOtKjY6gsvVbWAxwRi4NIps6iS0TijYMh2jZFIH5+T6wYwbGFvaWroGNJpI7HR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567311; c=relaxed/simple;
	bh=12c/XXhWXQFe7E//aXhhjSnKJ+ltGtXe22jtwEMypmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etUy2NIQy1VBoFKG6GeC4mcMPPAa7sak5DkEJ6IVsv1eAeE4pjxzREsLRr62RwRDfsNAtU1SEUr7eQeEbIvrPKcbqY1wmIJSPHjFPF9xbov3fpy0Ko+IQQp8LokM+9MdcsKFHwu0q6Q3fwOyT+LdmY0PyxX7xpZnlx858QHrinU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=yWmT+dTp; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yWmT+dTp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1760567302;
	bh=12c/XXhWXQFe7E//aXhhjSnKJ+ltGtXe22jtwEMypmY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=yWmT+dTpNs/EHV3kCgUq04XZaQyPPB04gGYuLcgELyjRAs6mjtuMesBK5eAzutkVK
	 KpgSxB/WIVy9RxYaadisoIMHA42CSsgUEBGGFaZQ2wzNMarj3HnuNIdJCok/mCz2c0
	 RaXSh6uMNpvzspcaCkhSk98o+EP0IlXE2pGDxSW5SaNKSB5TSALzlnjNVRvoNhdGyn
	 hKC00yl0k6zp4RaZT5MwEeKB0wmOlmNc6Hvmqke/av3XoB8vnM0EleKF66IT1Sh2t8
	 86kDtm5AbL4W2usS98YoRMJAjZGGMqZjXF/udXNv9gjApJHs/9khE1ne2Wr/RrXKmr
	 yDUrzDSr+ma0PIcRZAnPmdTBMSX60Zh+T/0MeYU6u4IuoFD51/UGUMKQTEsmz1EeWP
	 1wK/G1dEDjjZznsksYJn0YL6sWwZ9I5ckEq6h835lAipqaZdogWf1sjmgo7pLaPFoS
	 kbZoP153WVPLHxkyhq+s2LzvDJRNP53owbbNV3rbxIDZdW18Njj
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:a1c4:25fc:92db:3a96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 48F3F20126;
	Wed, 15 Oct 2025 22:28:22 +0000 (UTC)
Date: Wed, 15 Oct 2025 22:28:20 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Martin von Zweigbergk via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>,
	Martin von Zweigbergk <martinvonz@google.com>
Subject: Re: [PATCH] BreakingChanges: say that `git diff X..Y` syntax will be
 removed in 3.0
Message-ID: <aPAgBPLH4QYa0ceP@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Martin von Zweigbergk via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>,
	Martin von Zweigbergk <martinvonz@google.com>
References: <pull.1989.git.1760566054455.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0CjymRIAdgMTyNKK"
Content-Disposition: inline
In-Reply-To: <pull.1989.git.1760566054455.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--0CjymRIAdgMTyNKK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-15 at 22:07:34, Martin von Zweigbergk via GitGitGadget wrote:
> From: Martin von Zweigbergk <martinvonz@google.com>
>=20
> The `git diff X..Y` syntax is quite misleading because it looks like
> it shows the diff of the commits in the X..Y range but it actually
> shows the diff from X to Y. IMO, if that syntax is supported, it
> should show a diff from the merge base of X and Y to Y. I hope Git 3.0
> is a good time to remove support for the current syntax and
> semantics. Then we can perhaps add the syntax back later with less
> surprising semantics.
>=20
> Signed-off-by: Martin von Zweigbergk <martinvonz@google.com>
> ---
>     BreakingChanges: say that git diff X..Y syntax will be removed in 3.0
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1989%2F=
martinvonz%2Fmz%2Fwtmnpolouvvz-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1989/marti=
nvonz/mz/wtmnpolouvvz-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1989
>=20
>  Documentation/BreakingChanges.adoc | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingC=
hanges.adoc
> index 90b53abcea..93fb968840 100644
> --- a/Documentation/BreakingChanges.adoc
> +++ b/Documentation/BreakingChanges.adoc
> @@ -114,6 +114,10 @@ applications and forges.
>  +
>  There is no plan to deprecate the "sha1" object format at this point in =
time.
>  +
> +Support for "git diff X..Y" syntax will be removed. Use "git diff X Y" i=
nstead.
> +This will open up the syntax for a more consistent interpretation of
> +"git diff $(git merge-base X Y) Y".

I feel like this is going to break a whole lot of existing scripts and
probably more than a few forges as well.  It seems especially bad that
we would add it back in the future with a completely different meaning,
since we'll have some people that use 10-year LTS distros that go from,
say, Git 2.51 to Git 3.xx, where the latter reintroduces the syntax with
different semantics.

We've never really changed the meaning of things like revisions or
revision-adjacent code in the past and I think those kinds of things
we're pretty much stuck with forever.  With that in mind, I don't think
this is a good idea.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--0CjymRIAdgMTyNKK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaPAgBAAKCRB8DEliiIei
gbUiAQDkEeGcgAwW70AwPQJ3xlXJY84yeASTR/ZpqWm2BgGtQQEAngX+u76BPmJY
lcpuG80L5Zqlu9RVQP+D3YkIpEwBFQQ=
=ugZR
-----END PGP SIGNATURE-----

--0CjymRIAdgMTyNKK--
