Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA37F12C470
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 22:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743633717; cv=none; b=h+g6QV6Mw8T5UfGlirKX1z5spfj9G4f6rZgVw96Wq/BfJcKVr4HtxwG/qFGkZP1jcRvNr1G0blh6j+jp3rAIQ8y4wwmzfzzq/k1EXhd/gvwLvP5sn9wjc3u3tDrDM/58bKowMRgQg7Oz+VfVZ3Q4PoeoQq64TJqaLqIqAVrZgUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743633717; c=relaxed/simple;
	bh=S4WbnnHlbVAbM0jgBw0/ApMVTRRuBJtq/9t3I36Gs6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpIix5c4K1j20U75fkhOswqSNa3IVZAJOQSVSAWvpPUSnBPIlfZUt7cjltsXVUG1NSy2XCt3kz6lax1KM5JIEtyuUz1DAp8LatwXwImK2CcslKo+LBrurI9hV/6timqHiEG8+wv3D1x+6lFJ1LSVGtQ3px5bTi2i0rRlsBuKxt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=HiPdbeaU; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="HiPdbeaU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1743633712;
	bh=S4WbnnHlbVAbM0jgBw0/ApMVTRRuBJtq/9t3I36Gs6M=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=HiPdbeaUY2BML7vRSetUGBN8RW4InNSiKxTPDO98BQxAPRdYNl8CtNG7xIt5K7NsK
	 5MDRIeziFReqpCBtAa9msA82nDDSJiO5+xsEiOazkATi895Rcpg/Bhf+yCbg+8QHu7
	 zDQd+ZR+YAe+DvmsIagvahKFKbOd+3X8Hac8j/pGV06SWundDknJMPzYkqlqp4fyZN
	 NUKm+U7XUyu+X80ZHu+oQxGaCBW/x+sCs2GBen/jB8MQ38r0dvdTpxrHtIMZEHEgIe
	 +45eZPp3JDetjOqiQnN0O7HT8/o/KxbITZVyUFxbo5C3e+l2GA6nFWiVqoVL8QWGX8
	 AsZx1ADKHMGxU+3SJ6MTmY0N4CO7y6rqWx2axWa8bTQe/FMlfSq7d8VSkQ1xHFKrCp
	 fpc9N/OHm4OyF4c/O6wt5zISI2Rx4WgCpkCDSsq7DGSMSuvP5NLwK0ffH0gvXVMA+K
	 rnAmnNz0anm9uUgOGaTNOdRLTWA3APym9SIaYvGiT4eAJM+ilUo
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d5c6:e1bb:f3a5:7a20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 28AE6200BE;
	Wed,  2 Apr 2025 22:41:52 +0000 (UTC)
Date: Wed, 2 Apr 2025 22:41:50 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Andrej Zhilenkov <azhilenkov@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Update symlinks after changing core.symlinks
Message-ID: <Z-29LsgDvcS0qY5a@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Andrej Zhilenkov <azhilenkov@gmail.com>, git@vger.kernel.org
References: <CAArAzAoU9qDj+yLi3pA6wFYdTAk0UvQk4omSWM1RL4D9w5fw_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pjUmnFjTRvi3hcMn"
Content-Disposition: inline
In-Reply-To: <CAArAzAoU9qDj+yLi3pA6wFYdTAk0UvQk4omSWM1RL4D9w5fw_w@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--pjUmnFjTRvi3hcMn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-02 at 07:18:45, Andrej Zhilenkov wrote:
> Hello! Is there a direct way to update symlinks in repo after changing
> core.symlinks?
> E.g. update plain files, if it was false, with symlinks or vice versa.
>=20
> I've tried `checkout` and `reset` but they have no effect in this case
> (see the snippet below). The only two things that are working:
> - checking out a commit before the symlink was introduced and then
> checking out any commit after (need to know that special commit to
> make it work for those specific symlinks, not practical)
> - removing symlinked files and checking them out specifically (need to
> either have a list or somehow search for those files to reset)
>=20
> Is this the way to do it or is there an alternative?

We don't have a way to do this because `core.symlinks` is intended as a
hint from Git to itself about whether the file system and operating
system support symlinks that's determined when the repository is
created.  It's not intended that users modify it, much like
`core.filemode` or `core.ignorecase`.

What is your particular use case that requires changing this value?
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--pjUmnFjTRvi3hcMn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ+29LgAKCRB8DEliiIei
gZzXAQCSOcK6bqeRj+NMDCOUVfqDRHqJlpzNNoLuo/Kz1K3b6wD/UsGjyvoiOl5B
wlJZXxF/doFhLRm6wen7CyyZIBlBYAs=
=PEm/
-----END PGP SIGNATURE-----

--pjUmnFjTRvi3hcMn--
