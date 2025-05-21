Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CA0190472
	for <git@vger.kernel.org>; Wed, 21 May 2025 23:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747868457; cv=none; b=LgriKRIPgDIi2Z2/Lqyi7aSBmwuyZW3U7E/al4R3lnopN1amCSBpJV5B2GuXMALDnAgEkcBL8Doe+O0Txl7GrK0Jp1EUM5NtCD7q1oV+xwHd1fbgtVn2yRi6emOsS0WRDctkcxVuvBb7Exr9U6En8nhhc9IkSg1SBYiWjA4J2GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747868457; c=relaxed/simple;
	bh=fezRLlJsm0CQ4xOfcnkqdB4zh+KVpz0RxcCnCHAnl6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6ifjoUmpT+zh2/HaZH+Lc5BFaL5fAvdxRYogQMekW5o+Modmx1wGeVyMhkK5pp7Pq9S2uA9j9k9n2Hgjr1Bil4G2eJ+/S3D1XGPzjGybc+qGTc3AgtSI4BCsaIOaf4QpGHojt/f+WdY6KpvMyFb4NTuMnW2DLqwLixV8TyzM9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Uc59UNX/; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Uc59UNX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1747868453;
	bh=fezRLlJsm0CQ4xOfcnkqdB4zh+KVpz0RxcCnCHAnl6w=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Uc59UNX/iDO6l6wcRKKwGn+efArnVpFAg7akJwAH4dposcxdyfcMKQNc1aizhySx3
	 B8HofpL2iBiVY7WN8q+b8KA+2LPCzFJiGd1OPKBO+ZhKIisa1q8suJHqcRpF9n5g7t
	 PKhczjCc0ywa46ZI2LNMALOZiHkmG7YF3GdbkwabW02kuQjry86n5vSC3q9HFUtYuv
	 GbedzL/yrgf4VdxZTrPAQrRfjTa9LX53q65NCEYGH/VX+5hZbTvo0q49MU6hR8uSMO
	 U5o3G+jEqve62GitRW5QEB8fPjtlcfyvYJosEikrQl/2nmEhqytDbA5ZH6RIAlF0rx
	 qLPkAv5uvYG7SD2bJZ9G+IZljgLyqOObDJ6PmD+I+IWBLBf6WBS6058OV+CGdQlYk5
	 0Pv96wXIC3n4fj/zBijFZeoorH8xBgAIHYk2LwfEdUHXO7ZI9DSXJzKDlPLvu+daHM
	 139AiC8wFRYeNCYi/7PZgwlDJsqW7BBYFG7MtMpbJeU1wAy46u/
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 176742010F;
	Wed, 21 May 2025 23:00:53 +0000 (UTC)
Date: Wed, 21 May 2025 23:00:51 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Aditya Garg <gargaditya08@live.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] help: inform about 'git update-git-for-windows' on
 Windows
Message-ID: <aC5bI_Y9-ZQPXJ4t@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aditya Garg <gargaditya08@live.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
References: <PN3PR01MB9597FDF30B7CE529985DE546B89FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597AFD63B750703E90AD18BB89EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <aC5MOl66YuIK1eyU@tapette.crustytoothpaste.net>
 <xmqq5xht8uxm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Kbn7A01xZCch4MdL"
Content-Disposition: inline
In-Reply-To: <xmqq5xht8uxm.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Kbn7A01xZCch4MdL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-21 at 22:23:33, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > I don't think this belongs in our codebase.  It should instead be
> > carried as a patch in Git for Windows.  The reason is that there are a
> > variety of possible projects that compile for Windows=E2=80=94Git for W=
indows,
> > Cygwin, MINGW, etc.=E2=80=94and only one of them ships this binary.  It=
 is even
> > possible for users to compile their own Windows binaries, which I know
> > is at least done by Microsoft as well as some Git contributors on
> > Windows.
> >
> > This change might be misleading or incorrect as it might tell users to
> > invoke a binary which is not present or to update software in a way
> > which is not via the normal package mechanism.  For instance, telling a
> > MINGW or Cygwin user to run that command would not result in anything
> > useful or desired happening.
>=20
> Do you mean that this is OK if the #ifdef were more specific to
> Git-for-Windows?  Just being curious.

I don't think that would be a good idea, either.  There's no such #ifdef
to my knowledge and we have lots of ways for people to update software.
We don't tell people to run commands to update to a newer version of
their Debian package because that's a responsibility of the packager or
distributor, and so the same policy applies here.  If Debian wants that
message to be included, then they can apply a patch and receive any bug
reports or other feedback related to that message; same goes for Git for
Windows.

I also happen to know that in some corporate environments proxy problems
cause the updater to break (which is not in any way a surprise) and
there are also cases where antivirus false positives flag the updater or
other tools.  We do not in any way want to receive reports about those
problems or the updater and if we avoid recommending it, then we aren't
responsible for it.  Otherwise, we'll inevitably get a request to allow
people to configure that message because it doesn't work in their very
special corporate environment and they don't want to confuse their
users.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Kbn7A01xZCch4MdL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmguWyMJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ/BY1nUvS6RjatphpeulcmDvLf511TedwNNCl9PYbQsp
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAOa3AP91rFq7VodHEKwzHinA/FWL5GoE
7auYqhTeGMXtFwdM2wD/f7B9gHv3sJqaRNNQGfpJJj+bpZKISWh8NSAeASqz7wI=
=3TTG
-----END PGP SIGNATURE-----

--Kbn7A01xZCch4MdL--
