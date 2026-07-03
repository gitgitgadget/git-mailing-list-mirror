Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862523CE0A7
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080607; cv=none; b=r5l2vcy8ZJN78/+FkhaO75Nz4K04r/1jZf3FeVJ+CzNVf2iOkhmweIxWZ1TR0BZD3gOpq0/xI8xTNC27pTt9DwPNfgugJh8bDB8UH4hCcJnFD+Qu6etVgEevMih56vmTSuCxFcnO+W8cxY/AIidZyaqV5h70xXCKBdnUJpQVnzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080607; c=relaxed/simple;
	bh=LWlBaeIwC271x/N36SphcYY68GSW50V1I5JLqddQD+k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dp3bbI5oetp+8v5yHYcECqHfYlHodWTVoljhTWLRqST1ZnJD1GkdhE1GBcZME5BaU4ol7vb+MKJVB4Qzv1Yc5lPPi78YOsBETgupYQwJ9KBU7uZhESPkP9zynUwtPfDk/e+r3mDYeCKBJUDOua2ZLr8nYjBHcX7xhj5IZNPTzdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=beyermatthias.de; spf=pass smtp.mailfrom=beyermatthias.de; dkim=pass (4096-bit key) header.d=beyermatthias.de header.i=@beyermatthias.de header.b=ciNO+Z/w; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=beyermatthias.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beyermatthias.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=beyermatthias.de header.i=@beyermatthias.de header.b="ciNO+Z/w"
Received: from cressida.uberspace.de (cressida.uberspace.de [185.26.156.202])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id 2B55A18015A
	for <git@vger.kernel.org>; Fri, 03 Jul 2026 14:02:38 +0200 (CEST)
Received: (qmail 13095 invoked by uid 989); 3 Jul 2026 12:02:38 -0000
Authentication-Results: cressida.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
	by cressida.uberspace.de (Haraka/3.1.1) with ESMTPSA; Fri, 03 Jul 2026 14:02:35 +0200
Date: Fri, 3 Jul 2026 14:02:33 +0200
From: Matthias Beyer <mail@beyermatthias.de>
To: git@vger.kernel.org
Cc: neikos@neikos.email
Subject: Programmatically edit the git rebase sequence?
Message-ID: <akei64goQf3nFhX4@hikari>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fb7eythi5ogkv6k4"
Content-Disposition: inline
X-Rspamd-Bar: -
X-Rspamd-Report: BAYES_HAM(-1.278719) MID_RHS_NOT_FQDN(0.5) SIGNED_PGP(-2) SUBJECT_ENDS_QUESTION(1) MIME_GOOD(-0.2)
X-Rspamd-Score: -1.978719
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=beyermatthias.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=LWlBaeIwC271x/N36SphcYY68GSW50V1I5JLqddQD+k=;
	b=ciNO+Z/wvO2iueqJKLM16ogfHcuL/1gUYvrvBkyy0dIlTtmqurUlMQLO3O1BREdaDazkuCimrQ
	dBXhy3j5IFm23DnuhfWP40ehNWPZ8SEJSpkj0v+fhHSa8Gdcod9CrsVwksqq/GhL4tGUXxF/D6cy
	95xUDstGYavRH844qJbzf8Fi3/w4cF7hLXAKNMdiBDP76heiIvW6J/pviK4b8gFLjKWq+DY7B8Xf
	ECGHjf5qBnjaeNu9Pp/3li3HO70W1gsXMeBiodn3TByEcNpWi0ltoEsxZA3w3lE9BBcba3JdG1bz
	1GXRgKjolpD0Da0c1TmZJOfJ1toMYELb3t5IIxDtV0DYQrL0lt+NxeXFsJtv6ITu9vUGwgMLYyaE
	6+YTDGM/iITma8FSxMTIyrqJjz0TVzWWmuBO7FIg9rgGUPLSxgOipZepNLl/46osKZa31c8B/kNf
	J4MBgaKjVwGPGQfcbDEZnTXwdfx8GqnjU0vtiuKOoynwgUrSax3poiVeLPrytB/3fsZhiLGb+Vdr
	Qi50jB42T+sa/X8+dkjx6mha/iF2jdHZoc+M+kb4vJdlCxWnDFytTZysBC561E/NzmNTnOfBDQrf
	xkFOWP1eRRloJfFk8/mDBsdHBqzlShpN1lT5DiMr8oZ+rNxOVE+LTWqS5oIwdYavBUiVJTnj6x+e
	M=


--fb7eythi5ogkv6k4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Programmatically edit the git rebase sequence?
MIME-Version: 1.0

Hi git people,

in a recent conversation at work, the question of how to
programmatically edit the git-rebase sequence came up.

Example use case:

I have a branch that touches a number of files, adds some files and
removes some files.
When rebasing, I want to split all commits that touched a certain subset
of files, for the clearity of the history.

I look at the output of

    git log master..mybranch --oneline --diff-filter=M -- "./subdir/*.rs"

to find all commits in that subdir that only touched the files. All of
these commits are to be "edit"ed.

Now I fire up `git rebase -i master` and manually(!) match the list from
above `git-log` call and find the respective commits to edit them.

Is there a way I am not aware of to do that manual step programatically?
Something like

    git rebase -i master --edit-commits="$(git log master..mybranch --diff-filter=M --format="%H" -- "./subdir/*.rs")"

would be convenient here, although I would understand if that is too
much clutter for the already very heavy git CLI interface :-)

Maybe I am just not aware of the obvious solution - I would be happy to
learn that there is already one!

Best,
Matthias

--fb7eythi5ogkv6k4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEUJGUus1GMTrRclzcEKWX9Kitz80FAmpHpNkACgkQEKWX9Kit
z83yXBAAuYXiagezK8LI3h51/cQzpxRpHK6GmdbbglwOWyfOWqCMQVc16s8QGXfi
S+UCrQGITJ20t3gBDYhbKCvcTCwUNDM7X3iaHxz8AcTBWx9em3vYd+g+GmxB2I8x
6YWi+/IrPdfrmqULctdbbh/s8oSctiErlrmHJzjOLtJh2KPMMCaRAsEUf3xE4RGU
3fre39Z7EvODs+OdM0JMJtoSa4T2GzwOX2vQlncRWBKCTAspRLELCUfSnlP7RbOX
fB07oSf3DqozN+rQDRMXiebhFepIRiwgKkFUkNbZdodGgntT8O7dFPRC43ORqjXh
MpRHxE3FnbCROc3RM86RcJvqebm+X08icj/rSX1jI7VJtS4MAN+Np1Q2GFk5ZCbp
wApQjCiHFZvucqidJ3meKxCRU6RfGgdLIBGyqaRpIz8CexX7uPrQhp8S99uaMvwD
xgM0k+NPfuNeQB8Xoe0Asbeesvs/Zs8SC1q9pmidMoz9/qaV0ukrA08qcEZj3J4A
dRIAXl2bROGXVJ8v2xN9FRQnmesaa8frov1at+nf6LAgkTvayAzhEVt+EvD3s6X7
aakx91BVVKFZKzX9yOKjIMI9kOHlSLickTUwJPyGZNO4nULzlD3y9GTjiZ6rbXw9
IbyeuCwi8IX3cB4AD3HK90GHu97zY6anV/bDPrfvi0mmRCzHXvo=
=O6Z5
-----END PGP SIGNATURE-----

--fb7eythi5ogkv6k4--
