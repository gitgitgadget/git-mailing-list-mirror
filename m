From: Florian Bruhin <me@the-compiler.org>
Subject: Re: git bisect with temporary commits
Date: Mon, 14 Dec 2015 19:22:55 +0100
Message-ID: <20151214182255.GB13519@tonks>
References: <20151214163726.GY13519@tonks>
 <87si34hphr.fsf@igel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_mehl.schokokeks.org-24491-1450117378-0001-2"
Cc: git@vger.kernel.org, r.seitz@beh.ch
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Dec 14 19:23:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8Xm6-0000NM-BD
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 19:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbbLNSXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 13:23:00 -0500
Received: from mehl.schokokeks.org ([46.4.40.247]:48353 "EHLO
	mehl.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932092AbbLNSW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 13:22:59 -0500
Received: from tonks ([2001:41d0:2:3b68::1])
  (AUTH: PLAIN me@the-compiler.org, TLS: TLSv1/SSLv3,128bits,ECDHE-RSA-AES128-GCM-SHA256)
  by mehl.schokokeks.org with ESMTPSA; Mon, 14 Dec 2015 19:22:57 +0100
  id 000000000000004B.00000000566F0901.00005FAB
Content-Disposition: inline
In-Reply-To: <87si34hphr.fsf@igel.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282376>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_mehl.schokokeks.org-24491-1450117378-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Andreas Schwab <schwab@linux-m68k.org> [2015-12-14 19:08:48 +0100]:
> Florian Bruhin <me@the-compiler.org> writes:
>=20
> > Now when trying to say it's good (and forgetting to remove the
> > temporary commits), I get this:
> >
> >     $ git bisect good
> >     Bisecting: a merge base must be tested
> >     [981e1093dae24b37189bcba2dd848b0c3388080c] still good and does not =
compile
> >
> > Is this intended behaviour? Shouldn't git either do a reset to the
> > commit we're currently bisecting, or warn the user as it was probably
> > unintended to add new commits?
>=20
> You should instead tell git that HEAD^ is good, since that is what git
> asked you to test.

I see - but wouldn't it make more sense for a "git bisect good" (or
bad, respectively) without arguments to assume I mean the commit
bisect checked out for me, not HEAD?

I don't see any scenario where the current behaviour would make sense,
but I might be missing something.

Florian

--=20
http://www.the-compiler.org | me@the-compiler.org (Mail/XMPP)
   GPG: 916E B0C8 FD55 A072 | http://the-compiler.org/pubkey.asc
         I love long mails! | http://email.is-not-s.ms/

--=_mehl.schokokeks.org-24491-1450117378-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWbwj/AAoJEJFusMj9VaByQG4QAJknX6/CBJxSWQMPYHa+fCVO
7LZxwJL7CC+VAcu2MtX4T2v+QT3XIVph44S0sXFPrCmFsE/68NnyaM+dFJamYvkj
Xymywkk1xnRJZPBiajWDOuCOVD/TnzOtytoh4LYh/X18CYMRWedZAJ6OxM8EQdnq
Z5tmFlXfU98zcsg+oIa4csNe6IasOB4vUX65PTNqXFfRxid1RiJa9Y9QqJoL/XTA
ibSGxT0B4M7MiN+XZ1ilNmS/ttQv1+8TwvabBMhzDsjorvoHJw5FZ7xM1RCxtpIe
X/fSt+HMaAZPj719tdABmdHsDqUtpUAarkf3NZzNSQ3/Oq7hLAR7px0DBp0ln3Pj
CRdsi92bjSqsDDhqpYqNNdL8feP8652mSn6klYtsDqtvkVZ0Fx3MJT3nikYa84/g
a0MubRWrekeUkuw4clHuGRZTY/9wSxb0JXOTfD91209UpFAYeR4Y7byigDl5p63F
aUE6AbhEiXFM+gMBIGGBSs1J6aBNPzO0x3mWu/NKXI6MeMFGM9Z7kK4zQB95pfgP
GgWM+YrCyk1o2vH9Tu9DvFiqJibRbuOCbKTmvK0br/ssIPO1ELQ4F7C0hLhoE1/U
+mruP4Yg1ZxQj1Dhg2i/sRKWzjnlg9TSDZgT8UvpHhwHlVNHDDh0PCyfRCLkjMQk
KkORGtHEaHbNy1C9AAvn
=t5fh
-----END PGP SIGNATURE-----

--=_mehl.schokokeks.org-24491-1450117378-0001-2--
