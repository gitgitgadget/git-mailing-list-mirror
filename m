From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: git svn rebase totally confused; just need some sorta reset
Date: Mon, 29 Dec 2008 16:04:56 -0600
Message-ID: <200812291605.00112.bss@iguanasuicide.net>
References: <cd7145c4-a4bb-4ef6-95db-7c4058b6774c@m16g2000vbp.googlegroups.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2134257.HxuyXqMjVp";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: davetron5000 <davetron5000@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 23:06:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHQFK-0008AD-0A
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 23:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342AbYL2WEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 17:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753272AbYL2WEh
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 17:04:37 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:42743 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025AbYL2WEh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 17:04:37 -0500
Received: from [206.104.162.243]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LHQE0-0004GG-CU; Mon, 29 Dec 2008 22:04:36 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <cd7145c4-a4bb-4ef6-95db-7c4058b6774c@m16g2000vbp.googlegroups.com>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104131>

--nextPart2134257.HxuyXqMjVp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 2008 December 29 15:39:45 davetron5000 wrote:
> Is there a way I can basically say:  commit XXX is the same as the
> current HEAD of SVN, so treat things as if that's the case.

No, commits are immutable and their "name" is based on their contents. =20
However, if you've fetched the current HEAD of SVN, you've already got a=20
commit that corresponds (roughly) to the HEAD of SVN.

> i.e.=20
> treat things the same as if I had just done a clean git svn clone.

On my git-svn created repository, I have a special ref "git-svn" that appea=
rs=20
to refer to the "HEAD of SVN" commit.  ("git branch -a" shows it.)  If that=
's=20
also the case with you:

git branch -m master master.save
git checkout -b master git-svn
# Make sure you are seeing what you want.
git branch -D master.save

should get you to where you want.

Heck, "git reset git-svn" might work.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart2134257.HxuyXqMjVp
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklZSYwACgkQdNbfk+86fC1+bgCgg2A/UULXHVSYIG6cQczhcXRv
6dcAnjZDqxBeQQZRXkubbES0+l0nfM3d
=CS5d
-----END PGP SIGNATURE-----

--nextPart2134257.HxuyXqMjVp--
