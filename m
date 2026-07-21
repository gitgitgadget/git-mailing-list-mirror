Received: from leonardo.netwichtig.de (leonardo.netwichtig.de [213.133.111.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB3B331A77
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.111.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634828; cv=none; b=BtgBogSaiFfLZ79NO77+gT4pnVyKWadMIk0jgNVPjU7e4H69H0PxHDScnzeJgCpcagTdLjuAG2OhnZgA2ejUu8r9pphzQxFv5kcdG+X4AEH/kXs8q9a3a1Bf2oC1tS8Fs6BrpEGE4WSWNoBniWNl63OZaMuapEpPkJmz/URFLYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634828; c=relaxed/simple;
	bh=nknnEfGPn23PcYYUd8yJ0EC5eddfE/bqe+B/gZTwHZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NqVBD6DTZEvpEaHpAynDDuDbPHJNEjBe9/+cAOyusFJGU0V6lf7/ndjBEmREGqcJQZOnOhR8saxj0QRM9HYaWg1OuZZ8RIXZH2qpawieG4QYbX562OT0L9E1b6vIjOFgOBMYDzJCP+7x6PNbwz7RlkGJB13bYr2lE5SwS6peAIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=henk.geekmail.org; spf=pass smtp.mailfrom=henk.geekmail.org; dkim=pass (2048-bit key) header.d=geekmail.org header.i=@geekmail.org header.b=rNrLtuAE; arc=none smtp.client-ip=213.133.111.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=henk.geekmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=henk.geekmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geekmail.org header.i=@geekmail.org header.b="rNrLtuAE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=geekmail.org; s=leonardo2023; h=Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CN47JIyVBYkESqhTMYmiVR9wREvfzRWVhYIVCdHeKng=; t=1784634822; x=1785844422; 
	b=rNrLtuAESkiTzFvrwJBN3dPnsdX00Y3vuVvSJivdjWUrrdRtL2jVbpFqgci4si81OtHx4zDWLKL
	Y/nCNYXy+5PatZaZVBZN7WFvONyCqbSYplzevZGwwwb6CZL8jwyw1Sr7+WxXRrhZbbS2ZXpOWffdu
	VxRYA3p+rZ1X1FtNdwQz2ZlThjiHpgP4JJ2E0VBMo0yPzrSXaoPxJs1D0LLDz0Jrij7u8obf83aXa
	gDPnVhUZ2xerVvNgiZXzYFGD+tu2jpjDoLCVMBH/hYJMPT+HUX2alrRwPznJ7BxkjIg1++W2vr32/
	yM3CzZ8ealcOnrA1t4r9GLdhm0+4XJe4C0Zw==;
Received: from [2a02:168:7a8c:21::a2a] (port=47474 helo=frustcomp.hnjs.home.arpa)
	by leonardo.netwichtig.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <ml_git@henk.geekmail.org>)
	id 1wm92Q-00000009odM-2V5Z;
	Tue, 21 Jul 2026 11:53:33 +0000
Date: Tue, 21 Jul 2026 13:53:17 +0200
From: Hendrik Jaeger <ml_git@henk.geekmail.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: git config: unintuitive behaviour with --global and
 --no-includes
Message-ID: <20260721135317.4802ef2d@frustcomp.hnjs.home.arpa>
In-Reply-To: <20260720125145.GA5100@coredump.intra.peff.net>
References: <20260720113402.0dc16abe@frustcomp.hnjs.home.arpa>
	<20260720125145.GA5100@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9iw.akXH4FtSXP1J8b+XHpy";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-hnjs-rSpam_score: -2.2
X-hnjs-rSpam_score_int: -21
X-hnjs-rSpam_bar: --
X-hnjs-rSpam_report: Action: no action
 Symbol: RCVD_TLS_ALL(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: SIGNED_PGP(-2.00)
 Symbol: MIME_GOOD(-0.20)
 Symbol: RCPT_COUNT_TWO(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: TO_DN_SOME(0.00)
 Symbol: MISSING_XM_UA(0.00)
 Symbol: MIME_TRACE(0.00)
 Message-ID: 20260721135317.4802ef2d@frustcomp.hnjs.home.arpa
X-hnjs-Spam_score: -2.9
X-hnjs-Spam_score_int: -28
X-hnjs-Spam_bar: --
X-hnjs-Spam_report: Spam detection software, running on the system "leonardo.netwichtig.de",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 postmaster@netwichtig.de for details.
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
X-hnjs-domain-score: 0
X-hnjs-ip-score: 0
X-hnjs-inconsistency-score: 0

--Sig_/9iw.akXH4FtSXP1J8b+XHpy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jeff

Thanks for your email!

> As for the rationale, it is a mix of backwards compatibility and least-su=
rprise.

To be honest, this reminds me of the XKCD comic with the title "workflow": =
https://xkcd.com/1172/
The behaviour may be =E2=80=9Cleast-surprise=E2=80=9D for the initiated. Fo=
r everyone new to this, I=E2=80=99d expect it to be as =E2=80=9Cmost-surpri=
sing=E2=80=9D as it was for me.

Best regards

henk


On Mon, 20 Jul 2026 08:51:45 -0400
Jeff King <peff@peff.net> wrote:

> On Mon, Jul 20, 2026 at 11:34:02AM +0200, Hendrik Jaeger wrote:
>=20
> > The manpage says: =20
> > > Respect include.*  directives in config files when looking up
> > > values. Defaults to off when a specific file is given (e.g., using
> > > --file, --global, etc) and on when searching all config files. =20
> >=20
> > IMHO it makes sense the way it is phrased =E2=80=9Cwhen a specific file=
 is
> > given=E2=80=9D but then seems to turn into non-sense when --global is g=
iven as
> > an example. Giving --global is not =E2=80=9Cgiving a specific file=E2=
=80=9D but
> > =E2=80=9Crestricting to a specific scope=E2=80=9D, which may `include` =
other files.
> > The results seem inconsistent and counterintuitive to me.
> >=20
> > Am I misunderstanding anything here?
> > Is this behaviour intended?
> > If it is intended, can someone please explain the rationale behind it? =
I don=E2=80=99t get it, it seems wrong to me. =20
>=20
> The behavior you're seeing is intended. Regarding "a specific scope", I
> don't think that's an unreasonable way to think about it. But it's not
> how Git thinks about it, and in particular back when --include was added
> and this behavior was set, "--global" was literally a synonym for
> "--file=3D$HOME/.gitconfig".
>=20
> As for the rationale, it is a mix of backwards compatibility and
> least-surprise. The include functionality was tacked on to the existing
> config parser, and we did not want to surprise anybody who asked for a
> specific file by showing them results for another file. This is
> especially important for reading untrusted input like .gitmodules, but
> also for writing.
>=20
> > Regarding the initial issue: I just added --includes to the call in
> > lbmk and it works just fine, so there is no need to address this. I
> > only mentioned it for context to how I got to looking into this
> > behaviour. =20
>=20
> IMHO lbmk is wrong to be using "--global" in the first place. Looking at
> the source, it is trying to check whether the user has set up their
> identity. But it is not lbmk's business whether you did it in the
> --global config file, or elsewhere! So it should probably just use a
> straight "git config user.name", which will do the same resolution that
> Git will do internally.
>=20
> The "--global" was added in their 4a280c62 (.gitcheck: re-write
> entirely. force global config., 2023-08-27), but I don't see any
> rationale given.
>=20
> Depending on what they are trying to check, it might be even better
> still for it to use "git var GIT_AUTHOR_IDENT". That will give the
> actual ident Git will derive, including things like checking $EMAIL in
> the environment and so on.
>=20
> So if the intent is "will Git come up with some ident", then that is the
> most accurate way to check it. But if the intent is "did the user
> specifically configure Git (because we are worried that values derived
> from GECOS and $EMAIL might not be accurate)", then checking user.*
> specifically is closer to that.
>=20
> Though note there is one other hitch, which is that the user can set
> author.* and committer.* as specific variables, since 39ab4d0951
> (config: allow giving separate author and committer idents, 2019-02-04).
> I suspect not many people do that, but that would also be something that
> a config-specific check would have to handle (but "git var" would do
> automatically).
>=20
> So I think you might consider sending a bug report to lbmk. Feel free to
> point at this thread, and I'm happy to discuss further with them.
>=20
> -Peff

--Sig_/9iw.akXH4FtSXP1J8b+XHpy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEv/2bXrNWp9EAWgjaFCJRCMHSVp8FAmpfXbcACgkQFCJRCMHS
Vp/3ww//V1q24kS47wfcPwpzkdrj2BCrTjX43CvcDHn7dGXYOb4AqDeyuIQ460bS
BiHsabpF4UMHO0I3yT+25F9z7U964o177JcbH7531VZnNEMIdx+TyvpHr23Efpj1
G5xdkfKXkRnnallEMI1gmevp/WxfpwFyGk+doucVGNE/tm+q7w9/Ns9YGScChN2J
pkAsRsiLrVj30i3kdPDcxPosnadAG3riFGn9Mmam0uJphnhMHbpV0usnlfUL6Cnq
DtDy9uxXrw6/BBWTUvYZmEV7cA3n0XvgF2K/TtC6ujml8ARetkMf+2SpTGTzxA+T
wweoNhwc5DHDC32dtXX23F/7secl+iw2DfyIKGyacxSNEtJd3r2w+lz064WISyps
1EoR3rbmRxv6a8MB9J7xKmM3/bbWLDj2v0qRZRhk64pPEBPe/KbpRdJqd3ykLaYx
dt6RoYuBs3jlTo2FqyrrXdEDZEMGinPf6UitRr6Kz/hy3prdkN7P91GBL/UYe4Y9
GF4TrhwRl4FEo12ki88ug50O7gmODVIibOsPVhAYUuB7IIuzTiL9ZHwPeLA4K/bL
Y2/Htaq3wr8hnj3TslKE1REGDg73+W8Jz68Xy7H1oYVtY5MJ4gkqrd1mWoiszR9C
uO8LAWVlyw6Bb2b0uEwn9zDGk7ivNe7s/uqxEKB3he4RReXgzYo=
=C+1A
-----END PGP SIGNATURE-----

--Sig_/9iw.akXH4FtSXP1J8b+XHpy--
