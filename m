From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-) [Scanned]
Date: Tue, 30 Dec 2008 21:40:58 -0600
Message-ID: <200812302141.02248.bss@iguanasuicide.net>
References: <BB5F02FD3789B54E8964D38D6775E718242D36@ALTMORE-SVR.altmore.local>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart14681783.luBj9bTgXa";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org
To: "Conor Rafferty" <conor.rafferty@altmore.co.uk>
X-From: git-owner@vger.kernel.org Wed Dec 31 04:42:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHry9-0000h7-AD
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 04:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503AbYLaDkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 22:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754299AbYLaDkr
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 22:40:47 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:55981 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbYLaDkq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 22:40:46 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.124])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LHrwo-0005YH-9a; Wed, 31 Dec 2008 03:40:43 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <BB5F02FD3789B54E8964D38D6775E718242D36@ALTMORE-SVR.altmore.local>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104247>

--nextPart14681783.luBj9bTgXa
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 2008 December 30 20:30:46 Conor Rafferty wrote:
> MERCURIAL:
>
> Update
> hg update [-C] [-d DATE] [[-r] REV]

Which is the role of "git checkout <branch>"

"git checkout <branch> <paths>" is similar to "hg revert -r <branch> <paths=
>",=20
but the later seems to handle your use case properly.  I don't know much=20
about the workings of hg revert -- it might use the history to determine=20
what's correct, or completely bypass the existing "index" when determining=
=20
what to drop.  In any case, it seems to work better for what you are trying=
=20
to do.  Why not just use it?

I could do with more hg/bzr/darcs experience myself, but git seems to behav=
e=20
the way I like it so it's what I use.  When deciding on the right tool for=
=20
the job, it does help to have many.  "To the man with only a hammer, all=20
problems look like nails."

That said, I'm pretty sure that if you hasn't specified '.' and just used "=
git=20
checkout <branch>" you wouldn't have seen those "artifacts".
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart14681783.luBj9bTgXa
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkla6c4ACgkQdNbfk+86fC29kwCaAzbCtK2ma/oxZ+W+Qzzh30ou
Qj8AnjFtvcAHbcxd54kj+0weQkauKRRF
=97/Q
-----END PGP SIGNATURE-----

--nextPart14681783.luBj9bTgXa--
