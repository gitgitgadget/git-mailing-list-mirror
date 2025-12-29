Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C341F5F6
	for <git@vger.kernel.org>; Mon, 29 Dec 2025 01:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766972076; cv=none; b=qN5M6tW6jGSiv5HaL7a8B9mssnuThAq8Ru96/8PMv+nfLO/TCkWRNAdxrLXQDjg1E7PdZowzamcla6zJM+8JAY+uZpQb9OfpOy8wiiLCP0YU93plsOLBoGlo0o52aLyg7063ms5ChUwooMkKxlp8XrdJhBqnDFyI2/C5Twm37oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766972076; c=relaxed/simple;
	bh=+FB2pZIi1kbVz/yRNoE76OvT/S70t1ikwvBbAQGk/7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQZxMtC0e8HjuU4+mdrhxaUXRyoD8VfB8NECKoZ0zHuotWbo0SPukBNGi8Y7xvbzo9su7fPTAT1xP+Vi25EwWozBD26r3he8cthHw8UH74Ij74gKnhIWwHQMidsqZwRKCIh+VVq5od6WSqcAODV68TZ645B6WTTBdKgtSPGMKwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=rrdHYddQ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="rrdHYddQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1766971581;
	bh=+FB2pZIi1kbVz/yRNoE76OvT/S70t1ikwvBbAQGk/7w=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=rrdHYddQ4XYSLM5+ki55Y3L0fq4m6reoYDobFgr3P1p+wUk5tBp6Tfzxeb2sI9dqq
	 XcSpzUqvHW4OHRekFPeHHCX9bzikKVUffTVEOkUKHpokAHBcM1cK4Vn2vPUxlqGznv
	 pWEbq2e4IFdtbtf+8528KCW/W3wEj0XgSXbeHYlzaWXol9/zPXOFTtWxDC53svz50l
	 JC0CoHRDcXazKTQo+VfDzrhEPNuC2wWijw8TfE8ZGi4cvH76umySARYiRtyk/WT2kx
	 GhZiUigLffBAowyXTnzWvchAFIaQMeXe6zxj567uWruRVV9YaTeKhX2T3MDfuHDFGC
	 a288xGEMH+Jp3gdmhHUXW853FZyGDUPf2RzRB7jrlJIdlQx5LPH9CK+VOw963pbhy1
	 zASyisLfPrP+9cg3tP8eG+s8mVR/NbDgjgFPgROo2x+T3WH1QEt6uiw2aklTUkGB8z
	 y30QfnIrVMAY0SOml+RzaxLC8jcJ6D0QjqW1Gkj6+J7reSlW/bR
Received: from fruit.crustytoothpaste.net (modemcable095.146-80-70.mc.videotron.ca [70.80.146.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 22025200B1;
	Mon, 29 Dec 2025 01:26:21 +0000 (UTC)
Date: Mon, 29 Dec 2025 01:26:19 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Terrence | Wolf1098 <Wolf1098@wolfietech.xyz>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git MSI Download Alternative
Message-ID: <aVHYu-3B0cci4L86@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Terrence | Wolf1098 <Wolf1098@wolfietech.xyz>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <KFiSIrIS7eM0dD67pvLae9ATOgPSyhL6ypLLaB2NTCX4k7AxDIbDGVTn1y35OO6O5wieHLL8NWkAxhgXF4uTd3HxqXN9JQzv2x996pXjsP8=@wolfietech.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R88AVhe0F9Ua4Fn3"
Content-Disposition: inline
In-Reply-To: <KFiSIrIS7eM0dD67pvLae9ATOgPSyhL6ypLLaB2NTCX4k7AxDIbDGVTn1y35OO6O5wieHLL8NWkAxhgXF4uTd3HxqXN9JQzv2x996pXjsP8=@wolfietech.xyz>
User-Agent: Mutt/2.2.13 (2024-03-09)


--R88AVhe0F9Ua4Fn3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-12-28 at 20:40:10, Terrence | Wolf1098 wrote:
> Is it possible to get an MSI(x) install of github so that it can be insta=
lled via provisioning, or gpo rules in ad?

First, the Git project doesn't distribute any binaries, only source
code.  I must admit that I'm not very familiar with Windows, but I
believe an MSI is a Microsoft Installer package that is used on Windows,
but please correct me if I'm incorrect.

If what you want is a _Git_ MSI, then usually Windows packages are built
by the Git for Windows project and you can reach out to them at their
issue tracker at https://github.com/git-for-windows/git/issues.  Please
be sure to search first before asking, since the maintainer is busy.

If you're looking for a _GitHub Desktop_ MSI, then it appears there's
already one at https://github.com/desktop/desktop/releases.  Note that
GitHub is one of many forges that use Git, and while GitHub Desktop may
ship with Git (I don't recall whether it does or not), it is not the
only Git interface or forge that supports Git.  It's helpful not to
confuse the two, especially since we try in the Git project not to
prioritize any particular forge.

If I've guessed incorrectly, please do accept my apologies and feel free
to clarify what you're asking.  Perhaps someone else can chime in with a
helpful thought.  Also, please remember that many people are on vacation
the last few weeks of the year (and part of the beginning of next year),
so it may take time to get the response you're hoping for.  I myself am
out of town on vacation at the moment, for instance.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--R88AVhe0F9Ua4Fn3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaVHYugAKCRB8DEliiIei
gTTdAP9U7wTkGTpygLVCOxhdTSJF1HIJ1TP70kaRKraCr+uqIwEAjGy00E6tLPmb
hEjZ4q12qDFNbVnEvf7NO8s3aIIvsQg=
=kILt
-----END PGP SIGNATURE-----

--R88AVhe0F9Ua4Fn3--
