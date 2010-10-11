From: Sven Eckelmann <sven.eckelmann@gmx.de>
Subject: Re: [PATCH] contrib/ciabot: git-describe commit instead of HEAD
Date: Mon, 11 Oct 2010 12:43:24 +0200
Message-ID: <201010111243.25375.sven.eckelmann@gmx.de>
References: <1286179362-23597-1-git-send-email-sven.eckelmann@gmx.de> <7vd3rp97f7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2704615.csqLo0a2q1";
  protocol="application/pgp-signature";
  micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Cc: esr@thyrsus.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 12:43:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5Fqc-0001eP-Bv
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 12:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672Ab0JKKnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 06:43:08 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:45981 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753504Ab0JKKnF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 06:43:05 -0400
Received: (qmail invoked by alias); 11 Oct 2010 10:43:03 -0000
Received: from unknown (EHLO sven-desktop.lazhur.ath.cx) [89.246.215.5]
  by mail.gmx.net (mp063) with SMTP; 11 Oct 2010 12:43:03 +0200
X-Authenticated: #15668376
X-Provags-ID: V01U2FsdGVkX19fxksRwiRfItKtDrz3w9tUYojTNovySeeBrlzEav
	ZXcTrZ6T0qg0pw
User-Agent: KMail/1.13.5 (Linux/2.6.32-5-amd64; KDE/4.4.5; x86_64; ; )
In-Reply-To: <7vd3rp97f7.fsf@alter.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158756>

--nextPart2704615.csqLo0a2q1
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Sven Eckelmann <sven.eckelmann@gmx.de> writes:
> > For each commit a shorter version of the name will be generated. This is
> > either the truncated hash or the output of git-describe. The
> > call to git-describe was only made with an empty shell variable instead
> > of an actual commit hash. Thus it only described the current HEAD and
> > not each commit we want to submit to cia.vc.
> >=20
> > Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
> > ---
> > I send this patch already two and four weeks ago and got no reaction.
> > This is a resent in case it was forgotton.
>=20
> Although the computation of "rev" indeed looks wrong, I do not see it used
> anywhere, so it might be a better patch to remove it ... wait, the code
> does something funny to slurp everything into xml via ...
>=20
> 	context =3D locals()
>         context.update(globals())
>         out =3D xml % context
>=20
> Yuck.
>=20
> Even though it has been my policy not to complain too loudly on stuff in
> contrib/ part of the tree, I have to say that this is a bit too _cute_ for
> my taste.
>=20
> Anyway, Ok, so it _is_ used.  And it needs to be fixed.

Yes, it is a little bit confusing when reading through it, but still it is=
=20
used. :)
=20
> I was hoping that Eric who took over the maintainership of contrib/ciabot/
> directory in April would give his blessing sooner, without me having to
> look at the script.
>=20
> Ack?

Hm, just be sure, because I saw no other replies since this message: You=20
expected reaction after that "Ack?" from Eric Raymond and not from me, or?

Anyway, thanks for answering :)

Kind regards,
	Sven

--nextPart2704615.csqLo0a2q1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMsupMAAoJEF2HCgfBJntGIr0QANm9hV/N+3bNJFmhtd8fvLV+
tHkqqV4zu2aIvnrUUFasYr6bKk6Jm9J8vhdcYRptllGabg0ACQnKkkD2IwTNKOMX
zqW6LFynTSthtUJ9kesgYB9gMUzbxwNO6aUnK1BWng7CmdqEKo4AYwnGw3axuALM
O+LEHeBCSaM9rRE2y9TqkBYU5DfB+0mJSXK6Q8ISPFXwxQazf/4+Jpd5Y8Ud0TdW
vL47QQPP140i8Dff6wAaTdV26rg4NUv09LcJo01fdzVD9w5Oqi+43pxmweUS3aJZ
cXftYHUN3EB2z+NaBLcT4zRKYihU3h5IQ3dvTmgPK44pveN9Vzalpn3uP2CbAmwZ
+/f3CBUdqF8162SGVG44ViOgq/ftIy5i6u87Ace3u9KIGs/1GWJ/k2T10KM8MVOL
rzuXMrnb4N4e6U4GRwqC/Taz8O9Ri8x0tKwSgg/c7bfxEm4pulAt+HTBZd5oSfjx
1rAqO5F8F3i8M/D0pTbiiwYDGAvJoR9BkxDr3GP7jqGQ5VXRNTzLIzxbTaprTRAZ
1SzxUY1GcCmCa/MXo6A4+iVCjRDPT7McG5vh1NDptAEo0WlmVExs0frckvoa/yJB
KFwPKt+x3pZI2tL4BE2ckS+9Ph7aXEmalk+GJqnpPx7FrFHgpL+Cj/DLQ5xDrFey
eB2xojEBTnyflLTkQbgv
=R33h
-----END PGP SIGNATURE-----

--nextPart2704615.csqLo0a2q1--
