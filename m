Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613AB7DA7F
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743720284; cv=none; b=MaFxxeaJwkiE4nkXPplI8QYIahDRxc73EywHWSEZjWUr27uVWSLOqPBK5LtuxT0IHQxtmhKNdtHxbt2QqK3m9sDgh+DMiRsYq0/Ko8xuatYDcvdet725SR1NBCXaPVEzg6amCRwXGcKD6SH2Lchyw74L297CMuHKUH/dDYV76ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743720284; c=relaxed/simple;
	bh=cbuPwr5+xwEL8BxunZMZVItSw4HRHBHf+fmUZx4vIto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocf0aSZv4vm3dS/5pYPCwPln6/hd5UkXDew3PwMwiTHMqVeLVED6JAbqbo8qX1uxvxGSXe2RiFQ7MgrqoUxpZM5l4e7DtFfMP3ci6N1ArxCE3+K+YapN54AMFiHlsHg9Kz7Zqh06kQJO6nckvOWMlvc9k5189lx2TY1iyjLIF3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=hY7BK9gv; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hY7BK9gv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1743720280;
	bh=cbuPwr5+xwEL8BxunZMZVItSw4HRHBHf+fmUZx4vIto=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=hY7BK9gvvU3IafnF8IAV95XTnlcq2cXa4lTKZa24ay6G+oZXunvwtoCKc5J37fw2z
	 4mW2EX3UO0gwHMtWD/HIICkEWhioDKe438Z15N7lssHOiuvljeyXiuz/bmgIRe+DSX
	 6VIYCzdetD2UxgjgB9M9kD8ZDzjTH8FuoH35Pv/uvu48Dixf1LcXSoNrlmsor3ep5t
	 VASbOmNXnqDvlp5t/flKPBzCu/SfaFlD/Y9ywfR9wL05lyUL9wv8PtXqgVNqD431cM
	 SxGjPVGmbZ+sQhm7tMxIPrddgYoO02Zxq/OmNwqqrR8XHMdfyXmuZW589bu7SjewZD
	 ywCrva8hm462wgAli6Qs/N7I0IaPRV4QsLi8gTXm9k8zFA58r1Py1t7WqDjXp4BI91
	 /1cmfLEV9G6QBH1TYQRgA5vc3AWgwKm1xMizYrUzC0yduv3PEWMn7dluYDEYaTlkGc
	 RnYGncGMFzCIVZjAxaGE7wipn27i3AjZYZy8JJvTCH3ouXeo8XQ
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D8D3D200BE;
	Thu,  3 Apr 2025 22:44:40 +0000 (UTC)
Date: Thu, 3 Apr 2025 22:44:39 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Sylvain Fardeau <sylvain.fardeau@free.fr>
Cc: git@vger.kernel.org
Subject: Re: --filter=blob:none in GIT config
Message-ID: <Z-8PV0q5T1KiMpn2@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Sylvain Fardeau <sylvain.fardeau@free.fr>, git@vger.kernel.org
References: <76775176-b7ee-4361-82a8-70b7d7701ee2@free.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B8kWRkUB42o/KsAa"
Content-Disposition: inline
In-Reply-To: <76775176-b7ee-4361-82a8-70b7d7701ee2@free.fr>
User-Agent: Mutt/2.2.13 (2024-03-09)


--B8kWRkUB42o/KsAa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-03 at 20:55:10, Sylvain Fardeau wrote:
> Dear GIT team,
>=20
> I was wondering if GIT roadmap plans to allow setting clone option
> "--filter=3Dblob:none" as default in GIT configuration?
>=20
> Didn't find a way in GITconfig, see :
>=20
> https://stackoverflow.com/questions/76770003/is-there-a-way-to-configure-=
git-to-clone-with-filter-blobnone-by-default
>=20
>=20
> Would be very useful for developments using binary files :
>=20
> https://stackoverflow.com/questions/79550931/cleanup-binary-files-in-git-=
repository-before-a-given-date

I don't believe we have such an option and I haven't seen one proposed,
although I don't follow every series on the list.  I can see how there
might be some utility for this and I noticed the use of an alias in one
of the links you provided, which is currently the way to implement this.

Usually we reserve judgment on a feature until someone has sent patches,
since we want to evaluate the implementation of an idea and its impact
on the code as well as the idea itself.

I can think about some possible concerns that might come up that a
series would need to address, though.  For instance, because partial
clones effectively require an always-on connection to a server, a user
might accidentally make a partial clone when they didn't intend to and
then find that the server is down or they're offline (or someplace with
really slow Internet, like an airplane) and have a problem.  It would
also be harder for scripts that assume a standard clone to work around
this, especially if they were written for older versions of Git.  Some
of these concerns would also apply to enabling shallow clones as well,
which we also don't presently support as a config option.

So to sum up, I don't think there's anyone who's planned this, but I
won't say that it's out of the question that it might happen in the
future, though, provided Junio is in agreement.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--B8kWRkUB42o/KsAa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ+8PVwAKCRB8DEliiIei
gQ5eAQD80Ua6NabyjNOIpbZOWxiCnYu7QZBoqYLM1yIoX0aW0wEA5K+zj81JVP+r
wjNWEIz81j6ynZI6ibJpwQlLxEfHpwY=
=hdqj
-----END PGP SIGNATURE-----

--B8kWRkUB42o/KsAa--
