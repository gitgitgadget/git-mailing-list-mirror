Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343CB1946E
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 22:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="m2YIpWuZ"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51CAED
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 15:46:21 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id E1AB15B0BB;
	Tue, 31 Oct 2023 22:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1698792380;
	bh=1s9pU6Svf+e1jaKB4xHYmbRRuFGSjH4zaotSBXui79E=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=m2YIpWuZKoT155aLl/4P9kRFmW6ENen1KYuTzK09sguefnntVZ/o9tPwCAIAehIwc
	 RZBKEu9N2Pvv8SCbWMFKyB6ZxQFEixfEXnzbQkwsQoacjHm2wt3IzHym7LXxEXBz3U
	 c7L+GEtcjfsOyV2c2PxJhFBvnXfyHo9teJNsid42w/eHOIRAA/YQm7aSrhuAomliQc
	 J47rmkTe9nWJWd88tNGya8Ty7lFbi3dIixblkS1zw3QWdq70oEGvs5z/0RfHDYAva7
	 hU6b4vwctph6+bxE4LpzpxrnB2zVPQlJj1RP0O0+hZ31HuZIfGpCGEFoJDHWErEBpd
	 gOToaRaJNvq85wyD/Gx2kSPVQn/scNvlHW0T7UJ0tT+07OjWW/NcXvGCjdtATXfgs5
	 Oc+cVjh3Shc5WQzPTWBrnLnTzMIYbKVswcisg3cf2QXVFMGOirKkwVJ5fiUiLV802+
	 njjS2SAeiJ7pC0rQ8bIfL/1DklvTgH7NYQ/eRSIs79CUCupK5me
Date: Tue, 31 Oct 2023 22:46:19 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Injamul Hasan <injamulhasan2020@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: facing issue in git in a perticuler directory
Message-ID: <ZUGDuyEao7wWCu0i@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Injamul Hasan <injamulhasan2020@gmail.com>, git@vger.kernel.org
References: <CAG4aqRxyY+xeWVc+StqsE3AVp6O2ghFhtW9iHBUFfq+hCiTWEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9sLESXiv4C2WWqKQ"
Content-Disposition: inline
In-Reply-To: <CAG4aqRxyY+xeWVc+StqsE3AVp6O2ghFhtW9iHBUFfq+hCiTWEQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--9sLESXiv4C2WWqKQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-10-31 at 20:21:08, Injamul Hasan wrote:
> hello i'm facing this error in my e drive but when i try anything in other
> drive it works properly .do you have any solution?

What kind of disk is your E drive?  Is it built-in or external, is it
local or remote, is it NTFS, FAT, FATX, or something else, and is it
synced in any way with a cloud syncing service (e.g., DropBox,
OneDrive)?

If you are syncing it with a cloud syncing service, you should stop
doing that, since it can cause problems like this and it very frequently
causes corruption.  The recommendation is to use a regular file system
with normal OS semantics.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--9sLESXiv4C2WWqKQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZUGDuwAKCRB8DEliiIei
gbBuAQDauFSDJ5nX8y9gSoj0Hf1WFRoC5h9J+hzxqdWzzaIyugEAj+D1BppvwqP1
WcTvvUhHUeIUEDvqMNPrPBEQdbVRngs=
=CrEb
-----END PGP SIGNATURE-----

--9sLESXiv4C2WWqKQ--
