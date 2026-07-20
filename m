Received: from leonardo.netwichtig.de (leonardo.netwichtig.de [213.133.111.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA2B3A5E94
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.111.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541741; cv=none; b=uL30BNo2XnNA41E3PqQPmS4iQRBM+wGOlaU15kdsp/2ZS3QNFJ9Zpcrr7ARYhPERAOYkfpaIGyDH/7IBeaKArQlcPf0KERBOB3kGwVyoJzmtCzAAMMZSZUQQzIIHkg8iuA5sVDaT7M8oXYW8Q4vDQagR/H6qgi6ou1KSh/PUHWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541741; c=relaxed/simple;
	bh=KN0JCA2CfCDvpyMWTy0jOSOPrRe3tfLYt2bpSU+fXQE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Ty5uH28H6PyJlZh6Rlb8kmyH1kqPpdCTl+CJ8Qcrw9cnCvvCbXRElJFe2FnHXDS3XaDSwZweFB7e+azNrbnYCakk3o7RQEK4y9HrvSWGCZ79qp9Xqp375JgVdDGzKsRTgqOBZBMX2EWuAPFgErefVF+Vj6kt9rqvE6XXYkKYGec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=henk.geekmail.org; spf=pass smtp.mailfrom=henk.geekmail.org; dkim=pass (2048-bit key) header.d=geekmail.org header.i=@geekmail.org header.b=cUpLGUt7; arc=none smtp.client-ip=213.133.111.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=henk.geekmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=henk.geekmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geekmail.org header.i=@geekmail.org header.b="cUpLGUt7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=geekmail.org; s=leonardo2023; h=Content-Type:MIME-Version:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jH0cogmUccoTIuRBggvIC8Eh+Pclqn3iXP2mWlG9A8Y=; t=1784541735; x=1785751335; 
	b=cUpLGUt7x6OcGvLqmXOy+t91I+bTipjgpy30qh2p5weqAbRzhfENP1dBIOYF9rHSxiQ1RUHAtai
	GLYzbo/cBBCnhOtHa/OiSbW39IdQpDIRd9CuInuQJqn53Eyat/KerZxFhlxL/TnGPOI8azfFw1Fsg
	OtFwZoONK05n1nBedKtSsMFFusTpjzMndmKfop0OsIEK+7fzLFOH44l0tiXht5NhE2h/HvmReBBhY
	IFpKu840tlobGLDmYH1clZuCyvB0EqAc2Gj84iZxgC4pOX5UrP0z3ClC4phbAbPgKBhdU+Ib7Hyip
	q/ASqhmj82xixfhBhElt+iOmt+PRkqjFUiXQ==;
Received: from [2a02:168:7a8c:21::a2a] (port=54490 helo=frustcomp.hnjs.home.arpa)
	by leonardo.netwichtig.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <ml_git@henk.geekmail.org>)
	id 1wlkOF-00000008js9-2oiO
	for git@vger.kernel.org;
	Mon, 20 Jul 2026 09:34:26 +0000
Date: Mon, 20 Jul 2026 11:34:02 +0200
From: Hendrik Jaeger <ml_git@henk.geekmail.org>
To: git@vger.kernel.org
Subject: git config: unintuitive behaviour with --global and --no-includes
Message-ID: <20260720113402.0dc16abe@frustcomp.hnjs.home.arpa>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/m/9y+o+9B5G0Dw/ayFDyDc0";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-hnjs-rSpam_score: -2.2
X-hnjs-rSpam_score_int: -21
X-hnjs-rSpam_bar: --
X-hnjs-rSpam_report: Action: no action
 Symbol: RCVD_TLS_ALL(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: TO_DN_NONE(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: SIGNED_PGP(-2.00)
 Symbol: MIME_GOOD(-0.20)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: RCPT_COUNT_ONE(0.00)
 Symbol: MISSING_XM_UA(0.00)
 Symbol: MIME_TRACE(0.00)
 Message-ID: 20260720113402.0dc16abe@frustcomp.hnjs.home.arpa
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
  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal information
X-hnjs-domain-score: 0
X-hnjs-ip-score: 0
X-hnjs-inconsistency-score: 0

--Sig_/m/9y+o+9B5G0Dw/ayFDyDc0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi

I ran into a problem working with lbmk (https://codeberg.org/libreboot/lbmk=
).
To see whether git is correctly configured, it runs `git config --global us=
er.name` and that failed for my setup.
The reason is that I have user.name and user.email not directly in the norm=
al git config file but in an included file and when given a scope like --gl=
obal `git config` does not by default check included files.

I tried to create a commented minimal example showing the problem with that:

```
# no config exists
~ % cat .gitconfig
cat: .gitconfig: No such file or directory
~ % cat .gitconfig_personal
cat: .gitconfig_personal: No such file or directory
~ % ls ~/.config/git
ls: cannot access '/home/resu/.config/git': No such file or directory

# config var is not set
~ % git config --show-scope --show-origin user.name

# set user.name
~ % git config --global user.name "Hendrik J=C3=A4ger"

# check if it is set
~ % cat .gitconfig
[user]
        name =3D Hendrik J=C3=A4ger

# check where it is set
~ % git config --show-scope --show-origin user.name
global  file:/home/resu/.gitconfig      Hendrik J=C3=A4ger

# check whether we can still retrieve it when explicitly giving the scope
~ % git config --show-scope --show-origin --global user.name
global  file:/home/resu/.gitconfig      Hendrik J=C3=A4ger

# move setting to non-standard file
~ % cat .gitconfig > .gitconfig_personal

# include that non-standard file
~ % echo '[include]\npath =3D .gitconfig_personal' >| .gitconfig

# check config status
~ % cat .gitconfig
[include]
path =3D .gitconfig_personal
~ % cat .gitconfig_personal
[user]
        name =3D Hendrik J=C3=A4ger

# check whether git still finds that setting
~ % git config --show-scope --show-origin user.name
global  file:/home/resu/.gitconfig_personal     Hendrik J=C3=A4ger

# check whether git still finds that setting in the scope it is in
~ % git config --show-scope --show-origin --global user.name

# set it again in the global scope
~ % git config --global user.name "Henk Hunter"

# check again
~ % git config --show-scope --show-origin user.name
global  file:/home/resu/.gitconfig      Henk Hunter

# check again with specific scope
~ % git config --show-scope --show-origin --global user.name
global  file:/home/resu/.gitconfig      Henk Hunter

# reset git config and check if the setting is really gone
~ % rm .gitconfig
~ % git config --show-scope --show-origin user.name

# set it again in global scope with different value
~ % git config --global user.name "Henk Hunter"

# check whether setting it was successful
~ % git config --show-scope --show-origin user.name
global  file:/home/resu/.gitconfig      Henk Hunter

# check again with specific scope
~ % git config --show-scope --show-origin --global user.name
global  file:/home/resu/.gitconfig      Henk Hunter

# add the include back
~ % echo '[include]\npath =3D .gitconfig_personal' >> .gitconfig

# check config status
~ % cat .gitconfig
[user]
        name =3D Henk Hunter
[include]
path =3D .gitconfig_personal

# check the value and from which scope it comes
~ % git config --show-scope --show-origin user.name
global  file:/home/resu/.gitconfig_personal     Hendrik J=C3=A4ger

# check again with specific scope
~ % git config --show-scope --show-origin --global user.name
global  file:/home/resu/.gitconfig      Henk Hunter

# check again while allowing includes
~ % git config --show-scope --show-origin --includes user.name
global  file:/home/resu/.gitconfig_personal     Hendrik J=C3=A4ger
~ % git config --show-scope --show-origin --global --includes user.name
global  file:/home/resu/.gitconfig_personal     Hendrik J=C3=A4ger
```

The manpage says:
> Respect include.*  directives in config files when looking up values. Def=
aults to off when a specific file is given (e.g., using --file, --global, e=
tc) and on when searching all config files.

IMHO it makes sense the way it is phrased =E2=80=9Cwhen a specific file is =
given=E2=80=9D but then seems to turn into non-sense when --global is given=
 as an example. Giving --global is not =E2=80=9Cgiving a specific file=E2=
=80=9D but =E2=80=9Crestricting to a specific scope=E2=80=9D, which may `in=
clude` other files.
The results seem inconsistent and counterintuitive to me.

Am I misunderstanding anything here?
Is this behaviour intended?
If it is intended, can someone please explain the rationale behind it? I do=
n=E2=80=99t get it, it seems wrong to me.

Regarding the initial issue: I just added --includes to the call in lbmk an=
d it works just fine, so there is no need to address this. I only mentioned=
 it for context to how I got to looking into this behaviour.
If any relevant information is missing in this bugreport, I=E2=80=99ll be h=
appy to add it, please let me know!

Thank you very much

henk

--Sig_/m/9y+o+9B5G0Dw/ayFDyDc0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEv/2bXrNWp9EAWgjaFCJRCMHSVp8FAmpd65MACgkQFCJRCMHS
Vp8gFQ//TJeFmpEuVVIogXhLapgDlkc9WZ3tDMuzeOWtCl0A5H5iLj/n5c1C//mS
Mw3x3J2JiD3ZfVSfhBNvyv+pFxEt6I3KU4D8+IPH+4dgsVaD6+ueqWPhTuDz/Qka
IQL/KBlqPL0JacExovQv127eoJpgvq4FwiTUFzv9RrD3xGC02X/4l29/dn3p9wcg
hq0oHJPOZHF2g0lZ07oQzV3wP0YL4YZPPff94HDvezXts5wIU1S9VzMX6YWQLWiT
uEkeY7ED9F7dGv0gYsGzuTQlJ39GQ4KPo7luvo+rmIrXuv8deDEpO3Ab0CtxebcY
o9Z15JM/l75n5IIRX99HXae+ufVPInM6r4qCu548pfoepv//I/hGkku0CwtF8tkh
RN346IysdE245zWDvqiPLC0gKxbggJdbT3d+jbta6mOcC8HpslW844Gw7h6NJInT
GeQPOLuBVVVIP5mQ+H/iIeLUI8UbrZHN4PRLjlzdNsx5HrG8xKyczktQFcmDT5UV
9DLQS1n1CQnllLdEIHeUfavvKBg1eMQlPk2WCj/wFrFbV/NxEvWzYBWyboUDQtfl
yLcowD2JYgI0ZbUcAU39gSc/rTd35TYtY5e8Sm0tI1Kjpnv8AIaRpeXGZQfjgVJB
KwlNmleao7occZaQbAuxUTYMjdvJAAfxFv4QpHZX2sFZX3GRZOw=
=DzDH
-----END PGP SIGNATURE-----

--Sig_/m/9y+o+9B5G0Dw/ayFDyDc0--
