Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C136B241139
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770284335; cv=none; b=UV8giLjxbMEvh38FVMih13xBSdEQeqRfpQekDjO8Vv/keTGihtyIyBIgJiyMN9KMc/wHX2cl+CjvD+kEX/DtONUtQT9Pp+Z8rAm+lWbskYrjR6Ns4+dt5WCw7MmFRm0TEjXz5eIOLiCvwCbK+pE+wODgnuYsbBuiYvuHTiTs4Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770284335; c=relaxed/simple;
	bh=y69/BA8tADE9BUdfEquJLWicmtfPScICHIagXAmBS8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hskz9jm9lB+lZOQDdlgWf0ZVVdxMyl6d1YQVevZRaCstv/cdstvS0cNb5OLs2Z9aJrxsLAKyP5eS5J2G8dTXd29wW/N50iATi9A7D+Vac5pyOsYK6c0DM161ASNLw7FUXbzZQQra8Q6wyX0IrXuZrp7iDk/VUKA6zyyGGBRDgiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8HX08y3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8HX08y3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423D3C4CEF7;
	Thu,  5 Feb 2026 09:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770284335;
	bh=y69/BA8tADE9BUdfEquJLWicmtfPScICHIagXAmBS8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a8HX08y3w6jYyqynMSxWGG/FE6QFvteWodXR01uYIA7TPEX4Gx2siYVeYr3cpB5Rd
	 WvEKmC195DdGEdm4sF5MZgA9PX9zrQfzoS8o+2bhS/aUQw93HxG2dxJbzDI9hyLKZE
	 c0ECEwS5dcDj8eN1gbDoJPlVDCaTr3yASKZ1iBd85lXxoL9cq81wZ8EbJMuOIr22JX
	 C01NLkbXbm86Ar45Uc40cjS6ipZX0Byne08v3712nDkSjaqMRoMuEK/ONgZcai+rv+
	 B3xw6M3rNHyivH53kHXLoVHFWscUnilzaruiJELA3GE1R2wLQ/Gnwf//F4qdCAUinq
	 N1JQWOpb9232Q==
Date: Thu, 5 Feb 2026 10:38:53 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	"Neal H. Walfield" <neal@walfield.org>
Subject: Re: [PATCH v1] gpg-interface: Signatures by expired keys are fine
Message-ID: <lroixebbcfnbr6qcaj5oznvl5c5gwusbzzznev5zllhnta2zj4@zkoypgor7g6e>
References: <20260204152306.1767112-2-ukleinek@kernel.org>
 <xmqqjywspgi6.fsf@gitster.g>
 <o2xni4463jlbmv226ngrlvepluqm43vg3fsifubanw6unhei77@wwzsa4ciqexw>
 <xmqqa4xonqs5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ce6ba3ss6w34ufh3"
Content-Disposition: inline
In-Reply-To: <xmqqa4xonqs5.fsf@gitster.g>


--ce6ba3ss6w34ufh3
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] gpg-interface: Signatures by expired keys are fine
MIME-Version: 1.0

Hello Junio,

On Wed, Feb 04, 2026 at 01:27:06PM -0800, Junio C Hamano wrote:
> Uwe Kleine-K=F6nig <ukleinek@kernel.org> writes:
> > On Wed, Feb 04, 2026 at 09:26:09AM -0800, Junio C Hamano wrote:
> >> Makes sense; I'll wrap this overlong line while queuing, though.
> >
> > Just to be sure: That means I don't resent with the typo fixed and an
> > additional line break and you care to apply this patch?
>=20
> Unless there are other things you want to update, no need to resend.
>=20
> FYI, here is what I queued.
>=20
> ---- >8 ----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Date: Wed, 4 Feb 2026 16:23:06 +0100
> Subject: [PATCH] gpg-interface: signatures by expired keys are fine
>=20
> [...]

LGTM, thanks!

Best regards
Uwe

--ce6ba3ss6w34ufh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmEZSoACgkQj4D7WH0S
/k5dCQf/UIyji1+wpwKzSlb60ty3DmWEVoT4FppNe0ydZkHPnB9CSCKHIkl2ZyFj
lVfuDQvij3OQYv2YokOLpuTtsrRuliG4eHG+1227v9M+tNy0fyh0+rsMiJgFH0DG
+JZB3W/kcMqZSlYkA4xojJRVkiLBe2NKScu18xrajfW0nh2tUx+vwctldySovBz/
uG0lLsidyM6FtEFLNJEzY3sGjuxU9J2rxpyaMBJMVE0lCbl316vdr5mEvrMpHde+
Dl/SHb1Ss4JBLKQr9gCBElS3NE85FAayz65eall1hbr1OSLnfH9/6VOTJEUM/bJ4
p4T4G8Vpz4zZcfNF1q5hRGVmyU8eUw==
=fKpM
-----END PGP SIGNATURE-----

--ce6ba3ss6w34ufh3--
