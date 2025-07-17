Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FEB1547CC
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752792308; cv=none; b=qEeT9Sj3A4qtFCXhi76FmB++SPKSifpKRtqt2OXT50XFLe1LPkddDuv+ILzkCcLKUMr8ti/5gTCdmQR4xenUC4coR1dLKsCX9n0eIPIb6wlVb3bKcJ7YqY5zNgxM3CYjr5kcFvQWCPMBBG+Xn1HCAyVcyTE0YhC4/op0WlyPwCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752792308; c=relaxed/simple;
	bh=X1WLJ5lEKDMISKuk0eoEaOv3fwgrzdhPaLXnjp1mE64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXWbJva0tjvqHrqhBwoQMsUmDDTrOFd1E51MQOZam4odl9HG1FEsVJmxUhYeqG/Nf65KvjmA9G2YBUKr/PtCNK9ALJbyNtJhNsu2tlXL9AhRMxwwOvaH3bbImSnaRAJHbp3f2++ugAqR0IDIyWhjIm04i/sRb22UMR38+28OoXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=lqUH+nt2; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lqUH+nt2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1752792304;
	bh=X1WLJ5lEKDMISKuk0eoEaOv3fwgrzdhPaLXnjp1mE64=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=lqUH+nt2WOn1AghZartCEETdHBD5kunkxA3D/kdAnUGsvnd0HM6IrmVq8e+iCdGBs
	 lixKxiLoALm/X6tLJ33Mdfl5VgY9WjESsaSbQ0X2JIQx7Dmf+O8TOcgX4t7AINKJk/
	 OLeqJ+qJxpZu0CkuzRsrb88khr9AJrmzUVVnq83DnFuwYa20KuG554+H8i1WhxS1zR
	 wFxkAIzLsTN+o6PofIziVbM+wEAhNcujalNmkB+xPf4uXfPznE41XWJQP0cOJ5k+HE
	 cGEbjzifGBvC97UsDBfRkRrFZHSZHQENU3okdq6C9x4Uj+VckycTRltSpLZP2tWUtH
	 WunE6a7JzYaeLte4e1aDYk54t1BabZvH0iPgY91xsaYSaZh3p0rMdU/RhzujLkcaQ7
	 H+InNOid0IANE6BwXr+TNwMjzELOzsTLhocobrm1cPqnUYy7Z3hw1E0O0XJ2X6OVbj
	 VJ4rEKU0jZmwDUjJVIfQptbWuqsmWqVmRZ2gV0p1bS2rzwGvadE
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:c351:2fb1:6e4f:b4fb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6D7D62007E;
	Thu, 17 Jul 2025 22:45:04 +0000 (UTC)
Date: Thu, 17 Jul 2025 22:45:03 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "Harrison, Latasha" <HarrisonL@hcfl.gov>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Security Questionnaires =?utf-8?Q?for_?=
 =?utf-8?Q?Software_Installation_?= =?utf-8?B?4oCT?= Hillsborough County
 Public Libraries
Message-ID: <aHl87-stEOn_AxIy@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Harrison, Latasha" <HarrisonL@hcfl.gov>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <DM8PR09MB65497709DE3054423B2FFDFFD556A@DM8PR09MB6549.namprd09.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OGdEatw8qQAdV0p4"
Content-Disposition: inline
In-Reply-To: <DM8PR09MB65497709DE3054423B2FFDFFD556A@DM8PR09MB6549.namprd09.prod.outlook.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--OGdEatw8qQAdV0p4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-16 at 16:57:59, Harrison, Latasha wrote:
> Hello,

Hi,

> I hope this message finds you well. My name is Latasha Harrison, and I=E2=
=80=99m a Project Manager with Hillsborough County Public Libraries.
> We are planning to install your software on select staff computers, and a=
s part of our standard procedure, our IT department requires completion of =
two brief documents: a Cybersecurity Questionnaire and software questions. =
I can attach both forms for your review. If there's a specific team member =
who handles these requests, please let me know, or feel free to forward thi=
s directly to them. We appreciate your help in supporting our security comp=
liance process and look forward to moving ahead with the installation. Let =
me know if you have any questions.=C2=A0

I'm certainly glad to hear that you'd like to use Git, especially for a
public library[0].  However, we are an open source project and many of
our contributors are volunteers. The Git project is legally part of the
Software Freedom Conservancy, a nonprofit that provides a legal
framework for our project, but no paid staff to respond to inquiries on
behalf of the project.

It's generally considered impolite to ask contributors to open source
projects to fill out paperwork, since this paperwork is different for
every company, it doesn't really benefit us or the project in any way to
do so, and it would take so much time that we wouldn't have any time to
do anything else like write code or maintain the project.  Instead, we
ask that you take on that responsibility since it's your organization
that has this policy.  As I mentioned above, there are no team members
or other people that the project pays to work on it or answer inquiries,
although some companies do employ paid staff to contribute to Git (but
not to address paperwork matters).

Note that the Git project doesn't ship anything but source code.  If
you're installing a compiled version, that probably comes from somewhere
else.  On Windows, that's usually the Git for Windows project; on macOS,
it's Apple or something like Homebrew; and on Linux, it's usually the
Linux distro itself.  If you have a contract with Apple or a Linux
distro (such as Ubuntu), they might be willing to fill out that
paperwork, but in general, the other distributors, like most other open
source projects, will not want to do so.  I am very certain that the Git
for Windows maintainer in particular will not appreciate such a request,
since they are very busy and have lots of pieces to maintain as part of
Git for Windows[0].  However, if your version of Git is distributed by
your OS vendor, you may not need this paperwork at all since it comes
directly from them, depending on your policies.

Hopefully your IT department will understand that we can't fill out
these documents, since it applies to almost all open source software
(which is something that IT staff should be familiar with in this day
and age).  I will note that we've had other government organizations
that have asked for similar things and we've given them a similar
response, so hopefully that's helpful.  I'll note that Git is in use in
a variety of governmental agencies across the world[1], all without the
need for us to fill out any questionnaires.

Best of luck in your rollout of Git.

[0] I'm a huge fan of libraries and started programming at six years old
based on books from the local library.
[1] Including, among others:

18F, a (former) U.S. government agency (https://github.com/18F/18f.gsa.gov)
The Government of Canada (https://github.com/canada-ca)
Various agencies of the European Union (such as https://github.com/eea
and https://github.com/eurostat)
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--OGdEatw8qQAdV0p4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHQEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaHl87gAKCRB8DEliiIei
gfxaAQDNSBil0O8QyPFsfhTNCd6HAZ2Y30JD5RB+ga23nAE9bwD43AVHxGoc5mXa
1Y33Vp50jFPKCqjjNqiEG96ZR4NeBA==
=PPww
-----END PGP SIGNATURE-----

--OGdEatw8qQAdV0p4--
