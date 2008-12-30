From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-)
Date: Tue, 30 Dec 2008 15:49:22 -0600
Message-ID: <200812301549.26538.bss@iguanasuicide.net>
References: <gj68a0$u56$3@ger.gmane.org> <gjdmm6$9oj$4@ger.gmane.org> <gje3ok$gnc$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7252068.fuui5M9M3s";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Zorba" <cr@altmore.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 30 22:50:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHmTq-0003eA-5E
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 22:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbYL3VtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 16:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752497AbYL3VtE
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 16:49:04 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:52202 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbYL3VtD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 16:49:03 -0500
Received: from [206.104.161.8]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LHmST-0005Cw-4i; Tue, 30 Dec 2008 21:49:01 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <gje3ok$gnc$4@ger.gmane.org>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104212>

--nextPart7252068.fuui5M9M3s
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 2008 December 30 15:27:33 you wrote:
> conorr@KINKLADZE /w/GITPLATFORM/swproj
> $ git status
> # On branch master
> nothing to commit (working directory clean)
>
> conorr@KINKLADZE /w/GITPLATFORM/swproj
> $ git checkout versionA .
>
> conorr@KINKLADZE /w/GITPLATFORM/swproj
> $ ls
> ABC.txt  AC.txt
>
> conorr@KINKLADZE /w/GITPLATFORM/swproj
> $ rm *.*
>
> conorr@KINKLADZE /w/GITPLATFORM/swproj
> $ git checkout versionB .
>
> conorr@KINKLADZE /w/GITPLATFORM/swproj
> $ ls
> ABC.txt  AC.txt  BC.txt

Not a bug.  git checkout <commit> <paths> does not delete files by design. =
=20
Try using "git checkout versionB" instead (no paths specified), and it will=
=20
properly remove AC.txt from your working tree as well as warning you=20
that "You're Doing It Wrong" (tm).
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart7252068.fuui5M9M3s
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklal2YACgkQdNbfk+86fC0H9wCbBOJgvelTtP8R1YUz47CZIB8w
zygAn3AU3FQXx5orkzy/sLffApBuH3Py
=Bmfq
-----END PGP SIGNATURE-----

--nextPart7252068.fuui5M9M3s--
