Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309E31CD23
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 21:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720475215; cv=none; b=U2zjLydVA98qfOM2xvya5hE6h4kstYXkfew3NO5rBXRGCKyhcpWKzgM1htl4oN2BgKiAEEhmA1Yac0Zehjqhbsi7MJCXHppLTHlbEWLYHVbRNhnJ8z0Pw76dEVrbCCGpS5LLmEiMNmKs9t7VEjwkAZiElI8WfmXxgZlXg5zCmz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720475215; c=relaxed/simple;
	bh=KXOLhSdPagXv8yke9IU2qTBqmoA811jFoJVSZuazKps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGb3kBSEZu6dNbfn/+f/QOhGTOH9A8cAWbQWWFSB7NRiHi36K4JcLuYyiPKRWfgrfdgdFkUWoYG7rd+qihuoyUCABlQePwardsAVH8ZxE5porUHarNKOsQmm4ufKhPPH3tkenBkG3zbtrc+JkQJUdwexgSmUMCdspp+idATsGN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=vLZVVA+c; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vLZVVA+c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720475204;
	bh=KXOLhSdPagXv8yke9IU2qTBqmoA811jFoJVSZuazKps=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=vLZVVA+cHqRMK47pDGNnD6Jf6n8IA6s+SXR8NkxiVEDXYz/HK1N0gcHjSUKPVKQWP
	 2zVm1eHQJUprS3MDX5kXb5Okcv1KdKKpvrhvH17WuCal2Udffr8Na8HPmSkN41qZnb
	 h9Yi9KAiJ00Y6ordNhFiLzA5RPsnwiiILxQb+xTXD0E25DnoWAqT3TvP0I9xpReVZx
	 J+Xc90eD6tW8Jc58LyPvra7e5DjUrbBxPHZxcNJwVvA7LkcsnKWZ3QiygRncl0OFTb
	 vNfUrPudhzy/wnvy1Zy9Z9iWl0Ae5mFCpNlcd00DCTfqiAcn/jSIYSq0chPuxGty8i
	 Wc2h+gd+LfsdwaQ+a+7vk7Ysk68rDmrMzhX6J5IGJ6TmpLRhXTzIlEYHlO+yu+c8rK
	 cWoOJrnfWBQRDj2Ac9fDXPgIDsfrIRB/UdKCOALy47+m92q292IELPfyGXHc/VrCSZ
	 J3qz5RTHOtkGMjQmsRy8xAUPPFr6+Z848a/ovf1rlD2VMwESyWP
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D406D20991;
	Mon,  8 Jul 2024 21:46:44 +0000 (UTC)
Date: Mon, 8 Jul 2024 21:46:42 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: github@online.ms
Cc: git@vger.kernel.org
Subject: Re: Aw: Re: linux git init/clone on Netapp NTFS security style
 volumes
Message-ID: <ZoxeQgi3RWIHUPya@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	github@online.ms, git@vger.kernel.org
References: <trinity-ea5945a3-0663-4e48-b995-913003b5e932-1720294530422@msvc-mesg-web002>
 <ZoryWtGqsD9iIafI@tapette.crustytoothpaste.net>
 <trinity-3d633a4a-10c6-444e-9e5c-79330941ddb6-1720457458565@3c-app-webde-bap34>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J5ntUqZvTJMpnONy"
Content-Disposition: inline
In-Reply-To: <trinity-3d633a4a-10c6-444e-9e5c-79330941ddb6-1720457458565@3c-app-webde-bap34>
User-Agent: Mutt/2.2.12 (2023-09-09)


--J5ntUqZvTJMpnONy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-08 at 16:50:58, github@online.ms wrote:
> The feature is very specific to Netapp. The (Netapp) volume is mounted us=
ing NFSv4, but chmod operations are not allowed as permissions have to be m=
anaged using Windows.
> Currently, OS is ubuntu 22.04. I'm confident that the distribution does n=
ot make a difference.

Okay, then I think the answer is that your NFS server is considered to
be broken, and there are a variety of NFS breakages that violate POSIX
that we don't work around, including the very common one where
open(file, O_RDWR, 0444) doesn't work.

I will tell you that this configuration will break a lot of other tools,
not just Git.  Git LFS and its testsuite will be broken; the Perl,
Python, and Ruby testsuites will also be broken; and there's various
other software I know of that simply will not work on such a file system
(and a simple search turns up yet more). chmod is a really fundamental
piece of Unix functionality, and even if you patch this in Git, you're
going to see a bunch of breakage and most upstreams and distros won't
care.

> Following section of the code should be skipped for given case.
> https://github.com/git/git/blob/master/config.c#L3434-L3438
>=20
> 		if (chmod(get_lock_file_path(&lock), st.st_mode & 07777) < 0) {
> 			error_errno(_("chmod on %s failed"), get_lock_file_path(&lock));
> 			ret =3D CONFIG_NO_WRITE;
> 			goto out_free;
> 		}
>=20
> I'm looking for some advice how to best skip or catch this section.

We have core.filemode, but according to the documentation, that only
takes into consideration the executable bit.  So I suppose you could add
a third option, "none" (or "broken"), that is the equivalent of false
but also means that chmod is broken altogether and shouldn't be used.
The documentation would need to be updated as well.

Someone else might prefer a different option for this altogether, but
you may not get that feedback until you send a patch.

> In addition, I came across this Netapp setting which might just ignore th=
e chmod operations without Client side failure. I haven't tested it yet.
> https://kb.netapp.com/on-prem/ontap/da/NAS/NAS-KBs/Can_I_set_UNIX_style_p=
ermissions_from_an_NFS_mount_on_an_NTFS_qtree

That might be also be a viable approach.  I don't see an option to
disable this functionality in the Linux NFS client, which is where I
would have looked.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--J5ntUqZvTJMpnONy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZoxeQgAKCRB8DEliiIei
gVWPAQCih7bYuHWUfR7ZFbeXhWBsA9AY3fr3tcul2XWbDW4i5QD/X9HoemVJGuD0
fERWw6K8Z1PGuAH2cBqL3WGjo8cd5Ag=
=QaBr
-----END PGP SIGNATURE-----

--J5ntUqZvTJMpnONy--
