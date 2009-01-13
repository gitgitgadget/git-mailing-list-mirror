From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: Removing options from build
Date: Tue, 13 Jan 2009 16:06:00 -0600
Message-ID: <200901131606.04634.bss@iguanasuicide.net>
References: <1231883002.14181.27.camel@starfruit>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3259961.UbejDs2KIt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 23:07:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMrPM-0000bu-RO
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 23:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806AbZAMWFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 17:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753462AbZAMWFY
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 17:05:24 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:40116 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbZAMWFX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 17:05:23 -0500
Received: from [206.104.163.94]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LMrNy-0000iL-0Y; Tue, 13 Jan 2009 22:05:22 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <1231883002.14181.27.camel@starfruit>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105548>

--nextPart3259961.UbejDs2KIt
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 2009 January 13 15:43:22 R. Tyler Ballance wrote:
>One of our developers "discovered" the --force option on `git push` and
>used it without taking the appropriate care and hosed one of the project
>branches we have running around in our central repository.

Reflogs should let you recover from this.

>Besides a vigorous flogging, we're looking at other ways to prevent this
>sort of thing from happening again;

receive.denyNonFastForwards
        If set to true, git-receive-pack will deny a ref update which
        is not a fast forward. Use this to prevent such an update via a
        push, even if that push is forced. This configuration variable
        is set when initializing a shared repository.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart3259961.UbejDs2KIt
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkltEEwACgkQdNbfk+86fC2RNgCbBHOVJq1rSS043XUtaxDbevbE
sfsAnRdUUKqaK3YvIk3d0aRdzvVZTJod
=UryB
-----END PGP SIGNATURE-----

--nextPart3259961.UbejDs2KIt--
