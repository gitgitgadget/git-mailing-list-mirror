From: David =?utf-8?q?=E2=80=98Bombe=E2=80=99_Roden?= 
	<bombe@pterodactylus.net>
Subject: Re: [BUG] Git looks for repository in wrong directory
Date: Thu, 3 Jul 2008 03:05:15 +0200
Message-ID: <200807030305.17767.bombe@pterodactylus.net>
References: <200807030216.28921.bombe@pterodactylus.net> <7vtzf76c60.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1280002.VB2i74BkSF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 03 03:06:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEDHA-0004IX-OL
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 03:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbYGCBFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 21:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbYGCBFV
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 21:05:21 -0400
Received: from wing.pterodactylus.net ([89.207.253.13]:34496 "HELO
	pterodactylus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751901AbYGCBFU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 21:05:20 -0400
Received: (qmail 13839 invoked from network); 3 Jul 2008 01:05:18 -0000
Received: from unknown (HELO ?192.168.178.19?) (10.98.86.10)
  by 10.98.86.1 with SMTP; 3 Jul 2008 01:05:18 -0000
User-Agent: KMail/1.9.9
In-Reply-To: <7vtzf76c60.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87215>

--nextPart1280002.VB2i74BkSF
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 03 July 2008 02:31:35 Junio C Hamano wrote:

> This is age old usability feature that lets you say "ls-remote r1" even
> when you do *not* have "r1.git"

Is it just me or does that sentence not make any sense at all? ;)

I mean, _of cource_ I want the contents of "r1" if I say "give me the conte=
nts=20
of r1". I could understand if Git looked in "r1.git" if there was no "r1" b=
ut=20
the way it is currently done is plain wrong. IMHO, of course.


> If you have both, you already have found the way to disambiguate ;-)

Yes, _now_ I know. In my opinion it=E2=80=99s very unintuitive and should b=
e changed.=20
And if=E2=80=94for some strange reason=E2=80=94this is to be kept as a comp=
atibility feature=20
it should at least be documented somewhere in large red blinking letters th=
at=20
under certain circumstances Git doesn=E2=80=99t care about the path you giv=
e it but=20
simply chooses to look somewhere else. :)


	David

--nextPart1280002.VB2i74BkSF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhsJc0ACgkQsh8Hgp5TwkOTRwCglHikaeUn50CC1Cgad+43SyxR
DmwAoLSQBc5r77Vsjtrwl1d2FdwUYr8/
=9hLf
-----END PGP SIGNATURE-----

--nextPart1280002.VB2i74BkSF--
