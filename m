Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACCC1E511
	for <git@vger.kernel.org>; Sun,  2 Feb 2025 23:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738537550; cv=none; b=MwDK6ArC4Je1Z8LOlIFyQQ0WzT0hCugB6MeEHlrQGHdDHd1ocQgbLnC4TK4eocrFEAKiY2/pCQmIFZkNcLtIQaHVmOC4Z5HhicXDR0PwBiOYPj3LCeo0hpTbGzC+dnFHnw9q1Qqi1A+sj6+b3SHPJMXB6nqdpiggxFxigfffL+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738537550; c=relaxed/simple;
	bh=yiZo/c4/3Tr8GdepaKTIsF88po2e9Bydd4coAXvpo1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=le5OMK4qNfgC/n+mvb9lwRCak0OrgN60lnc0O9UhNOqWTvFsaOBdeUeksiyQwMoellgf/Ea7UtzqtAn0Owrm4vXk5pssyYNyW0+Bq310SFz3YWAU1KRkWAiklZxEJT8n7jt01t8oLrGiWNljpT1JLhTnSjdnbqBclxq64hQrFi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Zp8E59wp; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Zp8E59wp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1738537540;
	bh=yiZo/c4/3Tr8GdepaKTIsF88po2e9Bydd4coAXvpo1E=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Zp8E59wpZvTh493qFWCky0tjS4aejVaeaUw6MSSE9jEU7NV7mpFyKvu6wxl1cNTZZ
	 SEBvFJdVDlBNBnF5Dn70keszB0uqg5dO2NzHJmL67PeeIX19qc4/3XLfZsgFIx+WQo
	 6QiOxR+NhPw/Aj6ACgQW/1wjxsZSefRsSsSwPzf39qH2VneFXTL+kunVrTpX4lOsMe
	 sDO9thoNJZYfYPBpxU4wfD78eF8Ag+LY14Fuz2gdt+gDxP8o09+NxGEPPZZp/koP+9
	 gyvpRyBy+9JDrWqdG3yeLgtYVwcJH8YVMGkxUGfdmaMx8Lfj5NW5OgHd2w46sglENJ
	 rT9CLviVKFu8myaQ2ScHIG0uGZJwt/o2pYLSJmXOCHbqa6mgLD9nRvCjgnU4pFnqfv
	 Hd++Qo9sIeBodiJDcrZMMSAUEYBcL9SzPDpl7J9QIGyFac3jgtmpTgHqgvJE/iWwm5
	 UXFSQCFXGQ6aYJ6KWj08OYS24bL7V3Luf2OslEQkR33EsCTnXYw
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 25DAA200AF;
	Sun,  2 Feb 2025 23:05:40 +0000 (UTC)
Date: Sun, 2 Feb 2025 23:05:38 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Inivie Yelebe <inivie.yelebe@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: GIT for windows not downloading
Message-ID: <Z5_6QoI0c_fPcVvj@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Inivie Yelebe <inivie.yelebe@gmail.com>, git@vger.kernel.org
References: <CAE33cqX8tenGX=D=y4G0Xn0cBozM=JZhxg_Ai1NrE31v72xN1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0Bi/RRescAKNVjVv"
Content-Disposition: inline
In-Reply-To: <CAE33cqX8tenGX=D=y4G0Xn0cBozM=JZhxg_Ai1NrE31v72xN1g@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--0Bi/RRescAKNVjVv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-02 at 22:38:53, Inivie Yelebe wrote:
> Hello,

Hi,

>  I have for about 2 days tried unsuccessfully to download Git for windows
> from the link
> https://github.com/git-for-windows/git/releases/download/v2.47.1.windows.=
2/Git-2.47.1.2-64-bit.exe
> But it has returned with failure, showing this: *objects.githubuserconten=
t.com
> <http://objects.githubusercontent.com>* took too long to respond.

Git for Windows is a separate project that distributes a patched version
of binaries for Git and other software.  They manage their project
through GitHub (https://github.com/git-for-windows/git), where you can
find their issue tracker, which would be the place to report this.

However, because Git for Windows distributed release assets (such as the
one you're downloading) through GitHub's release asset functionality,
which is typically robust and well-maintained, I suspect this is a
problem with your network or computer.  For instance, while I do not use
Windows, I attempted to download the Windows binary and it completed
nearly instantly.

There's a variety of software and network devices that can prevent this
kind of functionality from working.  If you have a non-default antivirus
or firewall (that is, something other than Windows Defender or Windows
Firewall), those are common sources of breakage, and we advise people to
completely uninstall such software and restart (disabling it is often
not sufficient).  Similarly, if you're using a proxy or TLS MITM device,
such as on a corporate network, those can also be the source of
problems; we advise you to try another network.  Some countries may also
block some sites, or there may simply be some sort of routing or network
problem between your network or ISP and that of GitHub's release assets
server.  We really can't tell you for certain, so you'll have to
investigate further.

If you are going to report this nonetheless, I'm sure Dscho and the other
contributors to that project will appreciate you providing a full list
of any relevant factors, such as I've mentioned above.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--0Bi/RRescAKNVjVv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ5/6QgAKCRB8DEliiIei
gdL/AP4lZg2fw/Is99NC4B3I+fmBBDuMmzTO61sISLS+e2ZVQgD+OlCiA4vz+bKz
Dyby2qUycwWbFOXhoPzQ0djaChH69wc=
=rlRV
-----END PGP SIGNATURE-----

--0Bi/RRescAKNVjVv--
