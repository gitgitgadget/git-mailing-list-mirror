From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: Git - Pushing to a production website
Date: Fri, 9 Jan 2009 22:38:06 -0600
Message-ID: <200901092238.06968.bss@iguanasuicide.net>
References: <20090109222344.3539138a@family.dyweni.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4308154.PZ4ePxcVmR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: 4jxDQ6FQee2H@dyweni.com
X-From: git-owner@vger.kernel.org Sat Jan 10 05:39:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLVcm-0005aw-Ce
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 05:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbZAJEha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 23:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbZAJEha
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 23:37:30 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:53558 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbZAJEha (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 23:37:30 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.124])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LLVbE-0003CS-Ti; Sat, 10 Jan 2009 04:37:29 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <20090109222344.3539138a@family.dyweni.com>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105073>

--nextPart4308154.PZ4ePxcVmR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 2009 January 09 22:23:44 4jxDQ6FQee2H@dyweni.com wrote:
>Our company's website is stored in a GIT Repository.

Interesting.  I like the thought.

>The repository is coded for our test server.  When we push updates to
>the production server, have manually run a script to patch several
>files to make the code work on the production server (i.e. port
>numbers, etc).
>
>I'd like to write a script to email me whenever someone changes files
>on the production server without checking those changes back into git
>(i.e. running 'git status | grep "nothing to commit" ...').
>
>However, this approach get confused by the files patched to work
>correctly.
>
>Is there any way to 'save' those patched files so they don't get
>reported by 'git status', yet not mung up the git history every time
>we push out an update?

You could simply commit after running the perl script.  You could even comm=
it=20
to a branch so that it's (a little) less likely those changes get integrate=
d=20
into master.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart4308154.PZ4ePxcVmR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkloJi4ACgkQdNbfk+86fC1BfQCeK3cxTKQ0GbfkHnzg7C4rtvtI
/ycAnjmJymTeeCyqwtYJwE5th7NbGS2z
=uaCR
-----END PGP SIGNATURE-----

--nextPart4308154.PZ4ePxcVmR--
