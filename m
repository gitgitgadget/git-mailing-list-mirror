Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0965113473D
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265304; cv=none; b=H+2a4+v9bRLApP4u55Wiff/YJlBZkQGBbMYbmuVaOggUT4xxb3Rm/6RFNqBwbwa/3XxR7QhcF9Bz4ysOnfjijfPb6I4hDoZIc1BllQGUEP50+izWG1Ly59dcUCmpTDzVvVDB8euJmi+0GClKvO6IVPyyLKbq1FIQZDIQpIN6FIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265304; c=relaxed/simple;
	bh=ZZyBo3HhjiSCL57mT26FR2/wRDckRDGYQhH5gKfXKSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RU7NfbzdXZKc0tbFeMU4QVNKA26fvxplnZRKmG3V4ctUsHUk5Wgj4WBoo34mz2uO6Ya88TJDsXdsH4p7XH0oZY9eHY9dewhm4zby/eiCbEmKpwHpIeRxnE/rKpOpN8DdLGL4905KwocG0KDvYrM4WDoxOWZlg3z+8rpkM53Lajw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=bMKtX+fl; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="bMKtX+fl"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id C864D5D4B9;
	Thu,  4 Apr 2024 21:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1712265299;
	bh=ZZyBo3HhjiSCL57mT26FR2/wRDckRDGYQhH5gKfXKSM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=bMKtX+flM0sdYCxt8uwjNIVZ4hXCR1DiBlEM8Lviy95Uc9m/hXX06JfmjbwYP5uqK
	 5OdVGcmpaOjiSF0ImOUEchLNXa3Ab7iD6t1lu5UF+fCGi8Q+TNjTOcwOi93g2/eFz+
	 u23pNMW52cwE49bgCox5jIQzzEQV0kt33eGJ8+dXqbB8fBiFOapArZf0MDpgiASL+e
	 XYqpXOhPjfNgunAIQC1p2+tSiKIsRK72xs59UbfUU1fbY4Iv/TC67u9cNwc6KgkPLD
	 K5dnpIIiNdtSRIWHLYArOvbMLrqqbddDGhmUcbBJMOTtuEA+/4slP6fHDDYJr8w8Yy
	 9RfZh79c8uAmOFwfFqlLG7/jmqK0BV5VuEHvljUw7sohOAZ0zUjvP6eTyxtr8Vhjfs
	 5yl614JixSav6FX8UdyhEd/E9U5n4guK4tV8wxmUPRsHj5ddfEsPwUv0YpT7GA+FV7
	 7/xPSlQUPLY1bwKPMzxMN+OctM8gu0SKGemA0XiGYXsfYgHbUHX
Date: Thu, 4 Apr 2024 21:14:57 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Simon Phai <simonphaikm@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Git Server
Message-ID: <Zg8YUYSH2cSb7k6J@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Simon Phai <simonphaikm@gmail.com>, git@vger.kernel.org
References: <CACArJ22jCTArv=U-XW61P8x6sa0rrXYupQvh_txdSk6vAG7p6Q@mail.gmail.com>
 <20240404100854.5vfozqo7iiyyshoc@carbon>
 <CACArJ23dNONx-Fk5VwZZ+A64aEYW0nhn+X6q50W5hKLN=VbEng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6lWXWuO7mFLdYSW5"
Content-Disposition: inline
In-Reply-To: <CACArJ23dNONx-Fk5VwZZ+A64aEYW0nhn+X6q50W5hKLN=VbEng@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--6lWXWuO7mFLdYSW5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-04-04 at 10:26:31, Simon Phai wrote:
> actually I'm quite new to this but I would like to setup my own git
> server so that my fellows can develop our own repository, I find
> online there isn't much guide on using windows server to do it.

It's probably true that there's little documentation on hosting a Git
server on Windows because most people doing so on their own do it on
Linux or another Unix system.  It certainly is possible, but because
it's a rather uncommon configuration, you'll typically be left to
figuring it out for yourself.

If you're using a Unix system, there are options like Gitolite and
Forgejo, depending on what you're looking for, but I'm unsure if any of
those support Windows.  Running such a tool may be easier than doing it
yourself, but you may find that the documentation in `git http-backend
--help` may help you set up Git with an HTTP server (such as Apache) if
you're interested in doing that.

[Also, it's polite on this list to reply inline instead of on top with
everything quoted underneath.]
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--6lWXWuO7mFLdYSW5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZg8YUQAKCRB8DEliiIei
gZdkAQDFxwpg4LtMxJ7NwtVGDZG0u7ffZKzbEIM0l0XqEI4B/QD/W7OGUXfNJ2OH
HaYmDqalMYBrS0PQ35p9W9Os0Z7vHA4=
=lwzA
-----END PGP SIGNATURE-----

--6lWXWuO7mFLdYSW5--
