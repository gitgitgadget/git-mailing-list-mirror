Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F1D1D31BE
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732055409; cv=none; b=azMcQmCx3HpVVIRPrd6Pq9e/iJdDfgTZ/S+KppM80Kqt6bCxDqrUlJAgPD8tGh0oV83JJXMnJv8HT10MeV97XYk2ZoHq/BQYSec8voDQH1RALHnXct2t222hU36pQWveYEsPZWMDhyze04p4XJLthtswGlo9n34rHGXLzTe1a2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732055409; c=relaxed/simple;
	bh=/AoNA3eX8e5S0tTh+RcyCzR8V9BSGV3yPusDPzSsay0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajQED34aE+OboSNbCvyIZXeVr1DBhgNNwWFEcyqJdKgBLozKyG89FGO2BeScu0BMJLTdpYj4gbjSYbWBjPjLME0yghXC14xtFKHiVViFwyfFaQgfQSFOn6cDSsG6stdqzPMIDA2SZzzT2x5QH/zkW6K8xVTzIyUgqOUxekda59g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=YS+W+Jds; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YS+W+Jds"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1732055405;
	bh=/AoNA3eX8e5S0tTh+RcyCzR8V9BSGV3yPusDPzSsay0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=YS+W+JdsMEZ2gVd8UIQTvY0a8cQ6osWORu/M3xwDOBwxAh6rrJqWxRwGPBQqt309L
	 gyn5OOJ+9Tb+TpAMpi83EBxr5k4fBLjzVYdzURo8wkZ2ncDv2TYVVFUNW/KiV/VSBd
	 SyuEyvNVb0lTnsFL1gzSVZ6wZCMERYxW6pYlZXFMPLoXmeFYNykRytpU0/iHYl4XJN
	 oLFvoI7ROLeHatgQC+c9RpVTAesuaOTKBfQe4bdxbs9A3k93MfchB3yNtYmjoX2MO5
	 2iPBaXppA86AgxwDgu3TVPW+/0Ym5Pc7g2ouvh8TjwMer3yRES8DHzCeLYUv4QYE32
	 dwaKK10bcX0mASyQ+pJ3NxGAO+OKS9d0cOncLoM3PVlj8JXP6ESWP9JugczjUE4trO
	 wNuUTFsU+AXNcXh6lCBAq7UDogCw8y/pIZqoLq4ebUR1QYT15wgwWpLJJpnZj4l77h
	 8OsDPFLgwWGpoU0pN0rZ3JXY5RnkyLZmErTcnV/KW421eU48loZ
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:d026:90f3:853d:a63c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 170F0200C4;
	Tue, 19 Nov 2024 22:30:05 +0000 (UTC)
Date: Tue, 19 Nov 2024 22:30:03 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Haritha D <Harithamma.D@ibm.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Inquiry on Onboarding a z/OS Machine to Git Community CI/CD
 Pipeline
Message-ID: <Zz0Ra7PfJNhOcn7X@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Haritha D <Harithamma.D@ibm.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <898B3E90-1703-419D-A5FA-8BE9557744E5@ibm.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q8EULT9g74iWvCAl"
Content-Disposition: inline
In-Reply-To: <898B3E90-1703-419D-A5FA-8BE9557744E5@ibm.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Q8EULT9g74iWvCAl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-19 at 11:34:36, Haritha D wrote:
> Hi Team,
>=20
> As we are working on enabling Git on the z/OS platform, and we believe in=
tegrating a z/OS machine into the Git community's CI/CD pipeline could be v=
aluable for testing and validation.
>=20
> Could you please provide guidance on how to proceed with onboarding a z/O=
S system as part of the community's CI/CD pipeline? We would appreciate any=
 information on the technical requirements and necessary steps for this int=
egration.

My recommendation is to set up a GitHub App that will be able to work
with the GitHub checks API and webhooks to kick off a job and report
back on the status of your CI system.  Once that's set up, someone with
access to the git organization can add it to run CI jobs.

It might seem like a good idea to use a self-hosted GitHub Actions
runner on your platform, but (a) I don't think the runner runs on z/OS
and (b) GitHub recommends against using self-hosted runners on public
repositories for security reasons[0].  For that reason, I don't think
we're going to enable that as an option, since it would be a
vulnerability on our end (plus it would probably end poorly for you as
well, which we'd want to avoid).

One other alternatives is that if you can get things running in a
virtual machine well enough, that could be set up to run in emulation in
GitHub Actions.  I've done this on my own personal repositories to set
up Debian on arm64 as well as FreeBSD and NetBSD on amd64.

Other folks may have other suggestions, so I'd definitely suggest seeing
what they have to say.

In any event, before we set up CI, we'd probably want the tests to be
passing. Is that the case now, or is more work required for that to
happen?

[0] https://docs.github.com/en/actions/hosting-your-own-runners/managing-se=
lf-hosted-runners/about-self-hosted-runners#self-hosted-runner-security
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--Q8EULT9g74iWvCAl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZz0RawAKCRB8DEliiIei
gaSCAP9Sf/F5PjMsB9RBBY1IDpIxxAw63Il+QWoCsfK/oamptgD+IiKS+SO6OGNN
V9s94xFSN2nULDPiAIZ/TmiYZzSnbA0=
=xKbP
-----END PGP SIGNATURE-----

--Q8EULT9g74iWvCAl--
