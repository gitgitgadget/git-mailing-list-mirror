Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5FB4A1D
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 00:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724978883; cv=none; b=dgbRalvDZhp9aAo5usKHxEIDihV1skcxSv72F9qI4ZLIlgVUGBg1wrc9UMxrDqGdPdVtKlbwXpGFvF93jDWhMj0q41PSmoHKxpWI9jNJRMJCrlNTEM/gk9EHGSXRsuSLqUN4Xanu+zkRRu/kPIbENwXypBk7VtLL5A2REpecP4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724978883; c=relaxed/simple;
	bh=gI6E3J/xl6AtIwvJ9IOD8j6V1M7UmB5VXxwA+3mGA9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBbVto/f28h9ISa6oaygwBV9PtvUijQ2j5OJkjIO1M/fQDZ9zgmdL+Y8qhWwbawCraWR05W5kOdqFHajeyGayGJiiDCVfZHwiaIMEbz0bp3KHb3d9brYiYNSP9IzhxmuIfNNGLmJ6CSpa/Ns5VLqe6UgstK22ra7loxgt3ywTD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ma6tUQoD; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ma6tUQoD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1724978879;
	bh=gI6E3J/xl6AtIwvJ9IOD8j6V1M7UmB5VXxwA+3mGA9Y=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ma6tUQoDvTNE08s1GtC8opJkBoMZTfO8imj04+5fdj2CwvWCgouoZP44Pdncve5Uf
	 LQx1gdXSf8Edd+HiT7RcUWAMB5V2DQRS9n+2TxOj4ck6ot//jSu5QaYupdOoRSBt9/
	 FauPs7JFG1cQ1UaUppXfF66YdYuVaxGUIQdGNfgOY/Mv7b92ncL4jp0CUBs1wdutlq
	 dQgkX5iFBHE74QP1UAWh3YDFhjpngnevzlIwB6KotyDss9DI17CGfw8/BkTbL9R9U3
	 b1cicm5hg3WTtPRzSbYdsNUPnzSXecorRwAjogcfsejMz4k8Zn1APueQtPaNZy72w8
	 9j6MJzQcyI5OEKUGC4g6vT58nAD8kwFbkLoujefAS8DCqxBjzMBaiAnjTSSgqDJB3c
	 cK+a89ObchJG1o4S09uqFaMAGXPvOvxLVXcEAihFd0zNFLrOH280StmhQcklXkI7kl
	 82tgEGyfFQIJrEh1H5r05DX+DNMWb4BdaY/s5zFKXTKWK1OrGm3
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6D33A24429;
	Fri, 30 Aug 2024 00:47:59 +0000 (UTC)
Date: Fri, 30 Aug 2024 00:47:57 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Roman Sandu <r.sandu@gaijin.team>
Cc: git@vger.kernel.org
Subject: Re: Committing crimes with NTFS-3G
Message-ID: <ZtEWvQOwLPgjIFks@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Roman Sandu <r.sandu@gaijin.team>, git@vger.kernel.org
References: <7d1dad03-703c-47ae-a039-c15aa765fd0b@gaijin.team>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XA5UUN57ftKSFAJs"
Content-Disposition: inline
In-Reply-To: <7d1dad03-703c-47ae-a039-c15aa765fd0b@gaijin.team>
User-Agent: Mutt/2.2.13 (2024-03-09)


--XA5UUN57ftKSFAJs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-29 at 20:43:40, Roman Sandu wrote:
> Good day!
>=20
> I have a decently sized (80K files) monorepo on an NTFS drive that I have
> been working with for a while under Windows via git-for-windows. Recently=
, I
> had to (temporarily) switch to Ubuntu (24.04) via dual-boot for irrelevant
> reasons, and I decided that simply mounting my NTFS drive and using the
> monorepo from Ubuntu is a great idea, actually, as NTFS-3G allow for
> seamless interop with NTFS via UserMapping. And so that is exactly what I
> did and It Just Works!

In general, I would not recommend this.  NTFS doesn't support Unix
permissions, so I'd expect a lot of things to be broken.  A lot of
people like using NTFS to share data across Windows and Linux, but UDF
is a much better choice and I'm not surprised that NTFS isn't working
the way you'd expect.

Also, when you share a repository across systems, you should expect the
index to be fully refreshed each time you change the OS, reading every
file in the repository[0].

> So, what do I do about this? It honestly looks like a git bug to me, maybe
> it silently fails to update the index with new timestamps because it was
> initially created on Windows? But I have no clue how to narrow this issue
> down further, so any ideas or suggestions would be appreciated!

Can you pick some file in your repository and run `stat` on it, before
and after running `git status`, and include the output?

For example:

  stat http.c | tee /tmp/before
  git status
  stat http.c | tee /tmp/after
  sha256sum /tmp/before /tmp/after

My guess is that NTFS-3G is not emulating something properly and it's
differing at some point.

[0] https://git-scm.com/docs/gitfaq#sync-working-tree
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--XA5UUN57ftKSFAJs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZtEWvQAKCRB8DEliiIei
gR6sAP0Tlq46ZvpcVkJ2XMpozloWCQBbJWecjuc3PdgQDFXkmwD+KPP+W/U0OaGO
sn6AEkfQ4JIrccGNiGNVvDxHtCsioAA=
=r/18
-----END PGP SIGNATURE-----

--XA5UUN57ftKSFAJs--
