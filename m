Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792531217;
	b=poyq4+6+A74YzFoyZGj+YFt8UH9Y2Ut+MCiZ0HqmmLRtyv+T4vqmfGxeyVfsdXeaz4bF
	 lbi6oEPMcsWK7yODEsiB3/ynAVve0Fy/GzgRPXuPnXOAiwBeg9czyZU9zAKzrHdi0klPH
	 +xgMtjcUc9JHkzmgvd4lCOJxopj2Qorlye61x0BjrroQ8kxJnR5fTJZrGaLgbeJFIwvrF
	 hR64OlDfyCzjaIIVwhgj0BPSday+eZUbcpGyvmvSLWXcpwfgHZCvVLgpLxsgg7+Z96Mrm
	 7Is7ChqKUlqK7TdDX2P4BvxDs3JpVWFP9+EeMjbOaKfh27QnysaRAhXSmnhJCV8eNEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792531217;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=Ju8pmB3VAs1H5Q7BXIAJwkkE6TM2eI9WKXffITyuqKU=;
	b=MliDc/dQQ5TF30rdUIQ+SU/x1YBYFMO2tImDyAM4meEXGytAHNQFWY6fCwIxJiwsT9kg
	 AcVwNHye2uKz98P/f4Bb58bHr+WGIdoAppIXCZvX+KlPoAWoqz3v+zt8MmXI//fZMED27
	 m/mOgq/kR6cQ1smfXAweNGG0koj68mwyylRJ+1wtPuwfbbPwaKebQB0JML3/r+0C61Hcd
	 wNFQGRzNleffO/NILm3tuPjgFjF9R9U5FZANzTzA/GaeDEusasAYQrQpM3d7074fmYQbe
	 I4VwNzIjocb2sF+t9DRo3/uCZ13nptmzNdHEqtv+yyV7AeGnONn5/stJnVFHU8ZUiMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=KUhoSKyM;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1299606A323
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 21:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1299606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=KUhoSKyM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1792531215;
	bh=wgvrtRNoYpbDQ14ZjTE9Of6EsJggdcDyytkCX96fmmk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=KUhoSKyMX4ixTr7U46mRwj1aybPPE0aNtiHQxnf/DbWUrc3wRQ3lABXg0OBHqgt7p
	 TVdHDZsR9OL869soAxvl2HIlQ90i76avHirrSrYVw5IzTdvDKVY6Lse53om/8hbFUO
	 WHK09XQXCVkVgMRHsKgsUw7em1MWohMQamdoVWWFnb5XVYdBrOgPkOSiGDAaBLU2Be
	 swgsE6D+041NuJBswy/5Kn32qggGORUoZlQDJJDb0+IMEQlbSWNFnnNNjYgrQMqs9x
	 vHWkXrCOWMDpHnH399EYOTsnu05h5hGfiFmAGfu7grCauRKJs1iO/ofnttqgE1N4D+
	 VYl5EgdSbBNbAKBJExte8wLHjbiXmixePRzPWSg5YbJkZKqx0vdzQMnL5tnxcofyI9
	 /RUG9VGZ/pmPX4IO8znSX8yiCZ8SwOjdmIVU9WzdgrIVrTEpwWBmNXAgVBayV+IqHX
	 JxlbFnVOlCkgr6Nmy/dJVWOk2WPoD6X6Lh/aaSKocQDJNRRW9q+
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9d74:90e2:669b:59fd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9A8952006B;
	Tue, 20 Oct 2026 21:20:15 +0000 (UTC)
Date: Tue, 20 Oct 2026 21:20:14 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jason Newton via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jason Newton <nevion@gmail.com>
Subject: Re: [PATCH v2 1/2] worktree: add --reflink for copy-on-write
 worktree creation
Message-ID: <atfbDXhTUmPtv5pE@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jason Newton via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Jason Newton <nevion@gmail.com>
References: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
 <pull.2317.v2.git.git.1792512249.gitgitgadget@gmail.com>
 <83841020f43f9f8989371117075ebf089888d619.1792512249.git.gitgitgadget@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Fn0gfu8UUmmz4hMy"
Content-Disposition: inline
In-Reply-To: <83841020f43f9f8989371117075ebf089888d619.1792512249.git.gitgitgadget@gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--Fn0gfu8UUmmz4hMy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-20 at 16:04:08, Jason Newton via GitGitGadget wrote:
> Creating many worktrees from the same base -- for example to run a
> fleet of automated agents in parallel -- is expensive today: every
> "git worktree add" materializes the entire working tree by writing
> each tracked file out from the object store. The objects are shared
> via the common directory, but the working tree is not: N worktrees
> mean N full checkouts on disk and N times the file I/O.
>=20
> Add a "--reflink" option that, on a copy-on-write filesystem, populates
> the new worktree by reflinking the current worktree's files and index
> instead. The subsequent "git reset --hard" then only rewrites the
> paths that actually differ between the current worktree and
> <commit-ish>; everything else (including untracked files such as build
> outputs) keeps sharing storage with the source until modified.
>=20
> A new reflink_file() helper in copy.c clones every regular file. There
> is no size cutoff.
>=20
> On Linux it uses the FICLONE ioctl. That is the primitive btrfs, XFS
> and bcachefs implement, and the one overlayfs forwards when the lower
> filesystem can clone. This path has been tested on btrfs.
>=20
> On macOS it uses clonefile(), the APFS primitive. That path is
> implemented and has not been run here.
>=20
> On Windows it uses ReFS block cloning,
> FSCTL_DUPLICATE_EXTENTS_TO_FILE, as Git LFS does. The destination is
> sized to the source, extents are cloned in chunks of at most 1GiB, and
> the tail is rounded up to a cluster (64K, then 4K) and cloned; Windows
> ignores the range past EOF. The tail is not byte-copied, and small
> files are not skipped. That path is implemented and has not been run
> on ReFS. A volume that rejects the control code, including NTFS, fails
> the probe.

That functionality is defective; see
https://github.com/git-lfs/git-lfs/issues/6312.  We should not implement
this on Windows because there's no reasonable way to avoid corruption.
It's quite shocking that that bug exists, but it does.  Unless we can
guarantee a fixed version of Windows (which does not exist yet), we
should skip reflinking there.

I'd also like to see us limit this to platforms where it _has_ been
manually tested or is guaranteed to be automatically tested in CI.  That
means we should make sure this runs in CI on APFS for macOS (see below).

> +# Reflinks are only available on copy-on-write filesystems (btrfs, XFS,
> +# bcachefs, APFS, ...). Where they are unavailable, --reflink transparen=
tly
> +# falls back to a regular checkout, which the test above already covers.
> +test_lazy_prereq REFLINK '
> +	echo probe >reflink-src &&
> +	cp --reflink=3Dalways reflink-src reflink-dst 2>/dev/null
> +'

Does this work properly on macOS?  That is, does the macOS `cp` binary
contain support for `--reflink=3Dalways`?  If not, we won't be testing
this case properly on macOS.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Fn0gfu8UUmmz4hMy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrX2w0JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ8cQa/Bvv5ugbkGKAruOMyz04tYtkB0ft+tAKVoSE1yZ
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAFnZAQDZJOGcsCD7FjX1sC8yspbBPcLL
SBCMig0TJg1U95T23wD+M3M9IbZbdpFJWkuvlhgYJ17ZXffh55m/UzgNFldfWw0=
=Kl9P
-----END PGP SIGNATURE-----

--Fn0gfu8UUmmz4hMy--
