From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [RFC] Automagic patch merge ack emails
Date: Mon, 22 Dec 2008 14:59:26 -0600
Message-ID: <200812221459.30728.bss@iguanasuicide.net>
References: <2d460de70812220607j7f218ee3r7722bc8147a3dab4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6548430.mlyR6juZgo";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Richard Hartmann" <richih.mailinglist@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 22 22:01:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LErtG-0005Oq-E5
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 22:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755628AbYLVU7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 15:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755590AbYLVU7Q
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 15:59:16 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:53363 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201AbYLVU7P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 15:59:15 -0500
Received: from [206.104.162.243]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LErru-0002zK-3R; Mon, 22 Dec 2008 20:59:14 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <2d460de70812220607j7f218ee3r7722bc8147a3dab4@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103769>

--nextPart6548430.mlyR6juZgo
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 2008 December 22 08:07:07 Richard Hartmann wrote:
> I poked around the docs, but I could not find any option to have git
> send email to people who signed off a patch when it's merged.

There's not one, since something that that should probably be done in a hoo=
k. =20
Maybe the update hook?

> I only realized the two patches I sent were merged because they were
> listed in the RC changelog summary and would have followed up my patch
> email in a about a week, asking about its status.
>
> Does anyone else think this is useful?

I think it would be nice to get a notification whenever Junio pushes commit=
s=20
to 'master' or 'maint' in git.git if I've signed off on one of the commits.=
 =20
I don't think everyone would though so the hook would need to be maintained=
=20
indefinitely (updating the email blacklist, etc.).

It would probably be a nice hook to have as an example, I guess.

> Does anyone else think it should=20
> make it into main so it can be enabled via config, not via a hook that
> needs to be imported into each and every repo?

Definitely not.  It's not that difficult to add a hook to the repositories=
=20
that need it, and I think the majority of repositories will be private and=
=20
not need it.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart6548430.mlyR6juZgo
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklP/7IACgkQdNbfk+86fC23SwCcC4OsyuG+S/dYG/QQ4CypBeIq
DasAnivJiO/VAT76k6OmdR0RddKEcTUN
=giwa
-----END PGP SIGNATURE-----

--nextPart6548430.mlyR6juZgo--
