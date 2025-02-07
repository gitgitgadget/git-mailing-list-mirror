Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2F623C8C7
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 22:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968435; cv=none; b=ZG9QKy+ieiLbUpWhd8JtlahCrHl+LRcmUPqDtVgrYbt9RNiAnkHNz6lNuDHygfWriJTHI/1q8Ba6dRwwo2adLsFwzdnz9rBtgoL7BtQH8uIAODDMHfEuUGvr/247iQPrYTuAt0bASnlsIFUcygjYN6O7g1zJf7TGRakj7EQttBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968435; c=relaxed/simple;
	bh=QzZ24IpxCUSpvGjvJWd+L31bC8eNfLV5Lz7pEcj+LDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SS0+jBE3r5rhSM66i2zZd/MxbUIE4oQKvR5Y6yo9PpYk+dXYNx+nS4hJ4/ONPWubG1lGEd+wOgzxRn033rFpmjnyodJODyC0XnEIskQvN46XkgifeKELQ8YCxZO6xLZbb/tDx7tiJHz6HFWLzeReqe9SA0G3JT6rooUNyODEyFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=urIGKnGx; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="urIGKnGx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1738968425;
	bh=QzZ24IpxCUSpvGjvJWd+L31bC8eNfLV5Lz7pEcj+LDk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=urIGKnGxyjqpIztrx6mq3Jy6S0eO2Dx8bvv5o632s1W+ZyWO4EaN3+qrEDxhhM16I
	 MCc0FQECYaf8QvbtwxkUAgcHqUn1UGi5Z+32EdQ+yXGjnLtp0Ppl3CojTkSan3lQK2
	 lakTy6zV2x47uqZjoT0MsApzuM8zESQaI4MUZQKAOe2tYwp6tEUwWgwTNcCBQ+cxbs
	 DuG0J24N17h60AxbVNkcoqgUFMymrZre8PFsqLGG6A/YVfyThtMIV0mBLzYOWbJH5x
	 Ki1MkTgaeG65KrMiqFIaxRu7MX6BC9SEexoixnbKG/Q69fpggPllCGzfJ8nhkHfYgY
	 8PFlykF5orVFMRbmK45sByJBiCNXxONYc88XPlVNwxmrT4AwEdI7etipprZTOP7A2k
	 5z5kWsbuOYZBJsASwEWXYAtKm8P4csUPNaAXSqJKuth6SFLpOk+G0KryliwdINiUnB
	 kpYo0moen1PZgcDJIwJhg5pUXRo8anKqMqUAROEyWMuQeh9X/3g
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0736220076;
	Fri,  7 Feb 2025 22:47:05 +0000 (UTC)
Date: Fri, 7 Feb 2025 22:47:03 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Devste Devste <devstemail@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Config timezone to prevent chaos when DST/changing timezone
Message-ID: <Z6aNZ3qM1qsD5ZcG@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Devste Devste <devstemail@gmail.com>, git@vger.kernel.org
References: <CANM0SV3DXQeNinmy1Spj7n6G=5s3jMcFrAb0Ayun6ago7F3qWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IPpge7aHGBstQfoJ"
Content-Disposition: inline
In-Reply-To: <CANM0SV3DXQeNinmy1Spj7n6G=5s3jMcFrAb0Ayun6ago7F3qWw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--IPpge7aHGBstQfoJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-07 at 22:02:19, Devste Devste wrote:
> Issue:
> With DST or manual timezone changes (e.g. travelling) you can end up
> with commits that are illogically sorted - newer commits have an
> author/committer date that is older than older commits.

First of all, if the date and time displayed as local, it is very easy
already, without traveling, to end up with one time of a later commit
before the other (ignoring the time zone) simply because different
people are in different time zones.  I'm sure I could give you a large
number of examples in a variety of projects.

Second, Git doesn't guarantee a strict ordering of author or committer
date in timestamps.  It is very possible with a rebase to place commits
with newer author timestamps before ones with older timestamps because
they logically go in that order.  And we don't force users to contact an
NTP server or other reliable time source, so some people just have bad
timestamps altogether.

> I found the discussion about user.hideTimezone
> https://public-inbox.org/git/CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=3DyRnbC=
kMWdrvFHQ@mail.gmail.com/T/#u
> and
> https://git.github.io/rev_news/2023/08/31/edition-102/
>=20
> While there are workarounds, these aren't possible in all cases (e.g.
> "export TZ=3DUTC0" won't work with many IDEs since they run git in a
> separate shell and has side-effects on non-git commands. Using
> pre/post-commit/rewrite/merge hooks won't guarantee it's correct e.g.
> if bypassing them if there checks in there that should be skipped)
>=20
> There should be an easy way to force a specific timezone - or in
> absence of that at least force UTC - to prevent this

The standard way to set the timezone is setting `TZ`.  You can set it in
your `GIT_EDITOR` environment variable, which will be passed to the
shell, like so:

  export GIT_EDITOR=3D"TZ=3DUTC vi"

(or the `core.editor` value, or any other approach).  This will invoke
the editor with the appropriate value so it works correctly.

Part of the problem with setting it in Git is that Git doesn't actually
have a way to set the timezone other than the `TZ` environment variable
because POSIX doesn't offer other approaches for doing so (or, for that
matter, enumerating valid values or verifying a value).  In addition,
Windows uses a different, completely incompatible set of time zone names
=66rom everyone else on the planet, so such a setting would not work
gracefully in a cross-platform way for arbitrary time zones.

For these reasons, reading an arbitrary time zone from the configuration
would require setting `TZ` internally and then calling `tzset`, but that
function is not thread safe, which substantially restricts the places
configuration parsing and handling can be done in our code.  It would
also create a bunch of headaches if we tried to load submodules
repository data in the same process (which is an eventual goal), leading
to hard-to-reproduce problems.

In my case, I always set `TZ=3DUTC` in my `.zshenv` and I specifically
invoke my shell in `~/.Xsession` before starting the session manager.
For instance:

  zsh -c 'mate-session'

This ensures that all programs are started with the `PATH`, `TZ`, and
locale values I want for them, including graphical programs.  If you
don't do that, then graphical programs you start outside of a terminal
also don't honor `PATH` or locale settings (for instance, I always force
`LC_TIME=3Den_DK.UTF_8`, which I want for graphical programs as well).

As for hooks not working, if you have a policy requirement to use UTC,
then check for that in your server `pre-receive` hook or CI system,
where those can be used as an effective control, as the Git FAQ
mentions.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--IPpge7aHGBstQfoJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ6aNZwAKCRB8DEliiIei
gXT+AP0aHWkKN2vFj6o/ZGsp7C+LTT37irY9Jr+Gsc3L6YHFaAEAuFuywMIe0E4d
7y4pEfRKF2BeFJl4pmoFJjrO2OnwJAY=
=gilE
-----END PGP SIGNATURE-----

--IPpge7aHGBstQfoJ--
