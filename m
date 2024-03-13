Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A0C53815
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 21:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710365741; cv=none; b=MnAiaaTQFqlgqNrnyE+c1/H2u99CaWTtLzhG5iyZ797aZa1ek+/0jskB9Hp4cIVMn+PFVoWlomuJ7cx4Ry5yz0GWlbMOYMOCdydVXk7YOnrddN7nd9NlmiWUcZwAlA8YW09CmR0hshg/8At5HXPbtdTAN2beprh+qEOdXiMLMkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710365741; c=relaxed/simple;
	bh=jZhOnDyYSIVd8jvog8p1/Meu/dA1DYJ5VYGPTsPF52o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7wHnni7lxuLWYnTjThra4ZqHZh98REoDpsKWDuOmkBVCaKvPPLZrxP0duXiVzna515mGVEgw/OsBpM/tfzsCerrkpBQ+A7snBPzSiCb23xDvK6AT1VZPGSb0FYcg/pPufxNcu8EUqD07GEtZLbmYL0FwQMKktis7uY4CkOHlOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=AGN5WvFk; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="AGN5WvFk"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 34E195B3D5;
	Wed, 13 Mar 2024 21:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1710365737;
	bh=jZhOnDyYSIVd8jvog8p1/Meu/dA1DYJ5VYGPTsPF52o=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=AGN5WvFkzTcx27GCO23HL8XwQPdr+MdcjZ1rLygh7pAvFJco2K7lQxJOwO4YmSZvX
	 k/KtG+Ze1B6odF362OHGr0fgCMX/+9NaxYjTMYc+YkggVq3dCr4W+vnEjOxIEDQgiy
	 LoSPuC9rxg+r/OnjKgwTtUFA41knuuxryH9eLu478o5hK606zFiwbSWNVYtN/w4jlg
	 +cLkQ6Vp2IO0CZXvSlYjd6LnkUD3RUF04Mkt7e5YY3SBFghfqWrW93BIhodWRuA3/E
	 1I7jRicG4rjMIAD1nDAfcj8k61oR72f6+Vxl/2xrVh0EE/EwEpY6dQ0Ph4eSowxp1U
	 dyDPH8jw7fAON2Cngh6k8YnsWZ/EC18ASEgfMQjr6Y8J7tnBPCVn2mne9q+k0Tt7K/
	 GNvwAYmWI2HYzUJ9tatxbDiL1rt7mxElnZB40/LRoFKxpurEWaKCFeY0wpuX7sySxx
	 vSSeeh3zE37oX2somiNwmaM7nY2r2paqh3hxzV26yiEbWmNMFu+
Date: Wed, 13 Mar 2024 21:35:34 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Nick <billingidentity@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: having issue with git commands. Probably a bug
Message-ID: <ZfIcJo3Jk8XyrWiR@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Nick <billingidentity@gmail.com>, git@vger.kernel.org
References: <CA+cJT-HV=GH84p1nQaoywnJABDWDK9PS-StzW8BTEBezHuvocg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lpUXQzrBrur7nLC0"
Content-Disposition: inline
In-Reply-To: <CA+cJT-HV=GH84p1nQaoywnJABDWDK9PS-StzW8BTEBezHuvocg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--lpUXQzrBrur7nLC0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-12 at 21:36:12, Nick wrote:
> Hi Git Team,
>=20
> I am having the following issue:
> My repository has all these files but my terminal shows that they are
> deleted. My repo is in Amazon Web Services.
>=20
> My terminal show the following:
>=20
> Changes to be committed:
>   (use "git restore --staged <file>..." to unstage)
>         deleted:    Page2 csv file.csv
>         deleted:    Page3 and Page4 csv file.csv
>         deleted:    dummy demo.mp4
>         deleted:    page1 csv file.csv
>         deleted:    page5 csv file.csv
>         deleted:    page6 csv file.csv
>=20
> I have been trying to delete these files from my terminal and from my
> repository but git commands are not working.
>=20
> Git commands:
>=20
> #git commit -m "try to delete csv files and dummy demo"
> error: invalid object 100644 d54132721804e177f865b31a807d9fbebc7ff7
> for 'page1 csv ps.csv'
> error: invalid object 100644 d54132721804e177f865b31a807d9fbebc7ff7
> for 'page1 csv ps.csv'
> error: Error building trees
>=20
> #git log -- page1\ csv\ ps.csv
> commit c302c5202fc374739c0275b2e507a957be45e6
> Date:   Wed Feb 14 22:03:46 2024 +0000
>     Added page1 csv ps.csv
> error: Could not read 32286e5dfdb73b4cfa9eb87abf140dc81e68ab
> fatal: cannot simplify commit aee35d8a1bcde08c2249df029b06d46537751f
> (because of 32286e5dfdb73b4cfa9eb87abf140dc81e68ab)

This looks like your repository has some corruption; it's missing some
objects that it should have.  You can verify this with `git fsck`.

Once you've done that, you'll probably want to find another source for
your corrupt objects.  The howto documentation[0] covers how to recover
=66rom corrupted objects (search for "corrupted").  You could also try
making a copy of the repository to another location, exploding any
corrupted packfiles, deleting the corrupt objects, and then doing a `git
fetch REMOTE OBJECT`, which will work if the remote supports protocol v2
and partial clone and the server has the remote objects.

Are you perhaps storing this repository in a directory with a cloud
syncing service, such as OneDrive, iCloud, or Dropbox?  If so, that's
likely the cause of that corruption, and you should definitely not do
that in the future.  Cloud syncing services can add, remove, and rename
files without you noticing, which causes the corruption.

[0] https://github.com/git/git/tree/master/Documentation/howto
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--lpUXQzrBrur7nLC0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZfIcJgAKCRB8DEliiIei
gclyAQDT6qJCOppMGixNzlNJ0N+I7h++7iIaH291EtIWglFHoAD6A3ZtLbsDgmwx
PMAYjViWJav2BfE1xqR9WApbx3Tt3A8=
=EYAy
-----END PGP SIGNATURE-----

--lpUXQzrBrur7nLC0--
