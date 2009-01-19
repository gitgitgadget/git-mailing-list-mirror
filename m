From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH,v2] git-checkout(1): mention fate of extraneous files
Date: Mon, 19 Jan 2009 17:16:54 -0600
Message-ID: <200901191716.59373.bss@iguanasuicide.net>
References: <877i4teq78.fsf@jidanni.org> <87priivrt3.fsf_-_@jidanni.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3039672.IWXgNcAGmA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, markus.heidelberg@web.de
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Tue Jan 20 00:17:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP3ND-0007nL-Cc
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 00:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbZASXQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 18:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752996AbZASXQN
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 18:16:13 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:52773 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbZASXQN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 18:16:13 -0500
Received: from [206.104.167.41]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LP3Ll-0000cq-PY; Mon, 19 Jan 2009 23:16:09 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <87priivrt3.fsf_-_@jidanni.org>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106401>

--nextPart3039672.IWXgNcAGmA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>-specified, <new_branch>.  Using -b will cause <new_branch> to
>+specified, <new_branch>. (No files are deleted, use linkgit:git-clean[1]
>+for a pristine checkout.) Using -b will cause <new_branch> to

The parenthetical remark is not true, here:
$ git status
# On branch anagrams
nothing to commit (working directory clean)
$ ls
anagram  fsdupfind
$ git checkout master
Switched to branch "master"
$ ls
fsdupfind

I think you mean "No untracked content is removed,...".
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart3039672.IWXgNcAGmA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl1CesACgkQdNbfk+86fC2C4ACfcIlaln7Yb254UWz2cfnj1oOp
uzAAn3J7p02OjD+1o8AmWc+06UIGN9o5
=LKxP
-----END PGP SIGNATURE-----

--nextPart3039672.IWXgNcAGmA--
