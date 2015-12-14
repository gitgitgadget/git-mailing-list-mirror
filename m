From: Florian Bruhin <me@the-compiler.org>
Subject: Re: git bisect with temporary commits
Date: Mon, 14 Dec 2015 20:38:02 +0100
Message-ID: <20151214193802.GD13519@tonks>
References: <20151214163726.GY13519@tonks>
 <87si34hphr.fsf@igel.home>
 <20151214182255.GB13519@tonks>
 <xmqqa8pckfa5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_mehl.schokokeks.org-13414-1450121885-0001-2"
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org,
	r.seitz@beh.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 20:38:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8Ywu-0004OH-P9
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 20:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbbLNTiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 14:38:09 -0500
Received: from mehl.schokokeks.org ([46.4.40.247]:44291 "EHLO
	mehl.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231AbbLNTiH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 14:38:07 -0500
Received: from tonks ([2001:41d0:2:3b68::1])
  (AUTH: PLAIN me@the-compiler.org, TLS: TLSv1/SSLv3,128bits,ECDHE-RSA-AES128-GCM-SHA256)
  by mehl.schokokeks.org with ESMTPSA; Mon, 14 Dec 2015 20:38:05 +0100
  id 0000000000000056.00000000566F1A9D.00003466
Content-Disposition: inline
In-Reply-To: <xmqqa8pckfa5.fsf@gitster.mtv.corp.google.com>
Accept-Language: de, en
X-URL: http://www.the-compiler.org/
X-Operating-System: Arch Linux
X-Editor: vim 7.4
X-PGP-Key: http://www.the-compiler.org/pubkey.asc
OpenPGP: id=FD55A072; url=http://www.the-compiler.org/pubkey.asc;
 preference=signencrypt
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282395>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_mehl.schokokeks.org-13414-1450121885-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Junio C Hamano <gitster@pobox.com> [2015-12-14 11:21:06 -0800]:
> Florian Bruhin <me@the-compiler.org> writes:
>=20
> > * Andreas Schwab <schwab@linux-m68k.org> [2015-12-14 19:08:48 +0100]:
> >> Florian Bruhin <me@the-compiler.org> writes:
> >>=20
> >> > Now when trying to say it's good (and forgetting to remove the
> >> > temporary commits), I get this:
> >> >
> >> >     $ git bisect good
> >> >     Bisecting: a merge base must be tested
> >> >     [981e1093dae24b37189bcba2dd848b0c3388080c] still good and does n=
ot compile
> >> >
> >> > Is this intended behaviour? Shouldn't git either do a reset to the
> >> > commit we're currently bisecting, or warn the user as it was probably
> >> > unintended to add new commits?
> >>=20
> >> You should instead tell git that HEAD^ is good, since that is what git
> >> asked you to test.
> >
> > I see - but wouldn't it make more sense for a "git bisect good" (or
> > bad, respectively) without arguments to assume I mean the commit
> > bisect checked out for me, not HEAD?
> >
> > I don't see any scenario where the current behaviour would make sense,
> > but I might be missing something.
>=20
> When the commit "bisect" checked out is untestable, the user can
> freely go to another commit, e.g. "git reset --hard HEAD^" to go
> back one step, and then test it instead.  "git bisect good" has
> to mark the then-current HEAD, not the commit that was checked out,
> for this to work.

That makes sense - thanks for the explanation!

Florian

--=20
http://www.the-compiler.org | me@the-compiler.org (Mail/XMPP)
   GPG: 916E B0C8 FD55 A072 | http://the-compiler.org/pubkey.asc
         I love long mails! | http://email.is-not-s.ms/

--=_mehl.schokokeks.org-13414-1450121885-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWbxqaAAoJEJFusMj9VaBy6RgP/0X9hia5MgGI8k59/QDKSccP
KLH6ZXXhla4m4bs/Lj1L8oxP/4u39FZHBHTubhvDNi2KX4qwsOiNSWqrvMg/2sYY
TjAqwU6N78lsFXzcYiDsiqJTdBny/aIiujjZs1XStV2ZpzqL52xmueZoECBbPMOJ
QA1pmMka5G964r5/k0NfZq7k5F5FmnaWAbvGevYG46ptUob8qm4PWRVDuqnUiq5b
pL746kzcTjyTekU1dJCIq+nAUfMhfZNy8VgQbOx/2jEqCi2bS+9mItbscrYn7/7l
I1P53ttiEuBcZzl9z2DqDKl31U0VjoqKwZVmTCblnz2wClyANgi8ahi3/ysu7c9i
sHkiv4DCTeSf919QDaZ6sZqBs5VOSO7/B25rQ9aCQWvo3d5qZIT7HBRt4+1d9T1T
UEmf7dwvULTMWmEkkNeZ5a/fxEQOnGCZshwQI/w5P0XzkHRqXHzNZGz3RgjrgiLF
vkkNHfcgaWaqBoeLYgdD5meV5jbnIWezuoPIeRIML3Eqrn1JqBt5P1E0nEtrjnht
CvFir96q0FUASjCtVqBnHTI7h/tEzI+lR4Vy4+dwG1l2lLCXRWuidC73GcnW/ypY
3sk9QFX1b73cZBh3dZtVpg+2do7hZ0fhzsq4Z4+s95rICcQkUdznCn7+IyOvadW1
kB+sDYNV+6cBuny6Vo3J
=Gy/f
-----END PGP SIGNATURE-----

--=_mehl.schokokeks.org-13414-1450121885-0001-2--
