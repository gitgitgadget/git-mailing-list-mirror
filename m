Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC591FC105
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177740; cv=none; b=YRIeQNa9Y08nYYWLTxvjn7rgjnZWfUDOhOv3bS8dI5KBEK+43ZMFYG9VEbogZSs+3AzKiSLpdwC35ILwxBBzM4zsMqmVJYQX2O7HVfcl7AxlSueUpgeFnNNUXvWA9RbxRTLvCkx+QjaGr9rTbtV7FoqzxJLTh+elY42sv/VJZu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177740; c=relaxed/simple;
	bh=EnL4zn7Dr/oX0MOVy8iyQ9kbO0pjp7u1hUnMt4ZRg0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNQQjdbLNCE3yyEuzRcVTM3dYQ5h5jiRwjLmqNrwULQRPc0wGBXlEEKvwo+VlcIZDqB4AMTp+ssrF2P64mzMIMm0A0ux0xuX0MZbwz2rBI4fvuK7UsXDaQEWLjyQ/09E+PUCGH3MAT4gs52aUsdyimeTwYeSZeiJHZmYNtDItuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=sxR2V9dH; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="sxR2V9dH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1740177735;
	bh=EnL4zn7Dr/oX0MOVy8iyQ9kbO0pjp7u1hUnMt4ZRg0Y=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=sxR2V9dHXp2MyncRMhuUutQQNOATVjNH/TNunur/VAlJNQbehAoFRjcfrVxOHjG3/
	 vIwEdoKRQIFm7Bvuo4JkcrXVYqzEJFB/rH1j+q2HIvf7T2Z1+AJFrQY4peKyVTaN34
	 lv+1Ns/Gt6qz5XG1X1VvPyL+r1Rwsyj3WtIzP5ykHdN+LwreWjw7LV7v9ZH3d4d592
	 X+sDuBOmSmmE68Yt7iUGtxbgFj+RHfp4FSBol7oH9YxdcBfrksL7bzuZfZGbgTWBBu
	 MKE55TtAPfP5rQumShMhkny0hV9FXD+sqBJMXKjYaMtbVOsJxQJY/KN+zPD1sfhYBL
	 vVyooUHbG89/Ni5of8QgKLiLk6tM/lWwkUPg+wydtu9sIXYn21+hcvn20hfDtNjbzF
	 LhkBktmNPVLMdMaRWH7A7qlGKjM6cKiw/npgEOXQRa2U+86iTht8KHIKZ/NmIXQrEY
	 DQOKwY9p7l/XxboncvPylgBvKXXMlps6AZ1Tz30jmiAncFZPvOh
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 90966200B2;
	Fri, 21 Feb 2025 22:42:15 +0000 (UTC)
Date: Fri, 21 Feb 2025 22:42:13 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Emily Shaffer <nasamuffin@google.com>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Jamenson Espindula <jafesp@gmail.com>, git@vger.kernel.org
Subject: Re: Deleting first commits; maintaining last commits
Message-ID: <Z7kBRYcxu3jgOTmZ@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Emily Shaffer <nasamuffin@google.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Jamenson Espindula <jafesp@gmail.com>, git@vger.kernel.org
References: <CAOW_YOkX8K=7i7w9c5oH5Cfia0kCzwC3=ok5E=eUwYgpcOKTRQ@mail.gmail.com>
 <Z7fGQalzCg_Fx-ub@tapette.crustytoothpaste.net>
 <20250221-intrepid-furry-wapiti-eebff0@lemur>
 <CAJoAoZmsLu8DukvMugU6z6C=gKFP=dwDhZAT=_jE6h+dO9V55A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HCT/klUAsxvBWlU2"
Content-Disposition: inline
In-Reply-To: <CAJoAoZmsLu8DukvMugU6z6C=gKFP=dwDhZAT=_jE6h+dO9V55A@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--HCT/klUAsxvBWlU2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-21 at 16:05:59, Emily Shaffer wrote:
> For hosts which support it - which I believe includes GitHub - partial
> clone is generally easier on the server and a little bit less
> bug-prone than shallow clone.

The really expensive thing is fetching into a shallow clone.  A simple
shallow clone itself is not very expensive, and at $DAYJOB we encourage
large-scale users (such as CI systems) to use shallow clones for that
reason, since they're cheaper to serve than full clones, provided that
they never fetch into them.

Now, I agree that the particular use case here is probably going to be
fetching into a shallow clone, and that's okay if it's one particular
user doing that occasionally, which it sounds like it is.  It's
definitely a problem if it's thousands of CI jobs, though.

It may be that a partial clone does perform better overall, but it has
the downside that it effectively requires you to be online during usage,
whereas a shallow clone does not.  Whether that is a problem depends on
your use case: for work, I am effectively always online, so that's not a
problem, but for personal work, I want to be able to work on an
airplane (where there may be no Internet and the Wi-Fi, if any, is very
slow), in a hotel room with bad connectivity, or even on a retreat in
the middle of nowhere without Internet at all.

So that's why I mentioned both: both options have some upsides and some
downsides, and there's no one-size-fits-all solution.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--HCT/klUAsxvBWlU2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ7kBRQAKCRB8DEliiIei
gWnXAQCNWipvP+7aanMCxxe2c02tsPr3pFBxhQgSSN86ZfVRqwEA1JxcrvS4Sj36
PB9+kMJtZ26uTrDGIdvFpJAe6efdYAs=
=2D+E
-----END PGP SIGNATURE-----

--HCT/klUAsxvBWlU2--
