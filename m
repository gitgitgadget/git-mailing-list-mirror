From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-) [Scanned]
Date: Tue, 30 Dec 2008 17:31:36 -0600
Message-ID: <200812301731.40572.bss@iguanasuicide.net>
References: <BB5F02FD3789B54E8964D38D6775E718242D31@ALTMORE-SVR.altmore.local>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1305541.QnjyTEcRBu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Conor Rafferty" <conor.rafferty@altmore.co.uk>
X-From: git-owner@vger.kernel.org Wed Dec 31 01:13:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHohv-0003op-TA
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 01:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbYLaALu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 19:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbYLaALt
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 19:11:49 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:35351 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbYLaALs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 19:11:48 -0500
Received: from [206.104.161.8]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LHogd-0005Lt-5b; Wed, 31 Dec 2008 00:11:47 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <BB5F02FD3789B54E8964D38D6775E718242D31@ALTMORE-SVR.altmore.local>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104230>

--nextPart1305541.QnjyTEcRBu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 2008 December 30 16:36:19 Conor Rafferty wrote:
> I don't understand, sorry. I thought I'd already removed all files from
> the local tree, in the $ rm *.* move just above the checkout

Yeah, I guess I missed that, and I am seeing some "odd" behavior from git=20
checkout <treeish> <path>, but I'm not an expert on exactly what that is=20
supposed to do, particularly when applied to a directory.

The description is:
"When <paths> are given, this command does not switch branches. It
updates the named paths in the working tree from the index file, or from a=
=20
named commit.  [...]  <tree-ish> argument can be used to specify a
specific tree-ish to update the index for
the given paths before updating the working tree."

I'm guess what is happening here is that the index is getting updated in a =
way=20
that includes both the files from the HEAD tree and from the named tree. =20
Then the modified index is written out, outputting all of them, effectively=
=20
doing some sort of "theirs" merge.  It's not quite what I would expect but =
I=20
don't normally use git checkout <treeish> <path> when path indicates a=20
directory.

You should do a "git status" when you get ls output that is "unexpected". =
=20
Here, it confirms that the index has been updated (git thinks I've staged=20
some changes).

Personally, I expected "git checkout <treeish> <paths>" to bypass the index=
=20
entirely, the way "git commit <paths>" does, but this way also makes sense =
=2D-=20
at least when applied to a single file.  (And probably saves a good number =
of=20
git add commands...).

In short, while I can't say for sure, I'm pretty sure you don't want the "g=
it=20
commit <treeish> <path>" form and want the "git commit <treeish>" form=20
instead.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1305541.QnjyTEcRBu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklar1wACgkQdNbfk+86fC2mdACfbqX7hKyJiPkBJfaEDHG7oxdd
I3IAmweDZ1qZMCifu+zyfTpKfy0kB3rT
=Q9lQ
-----END PGP SIGNATURE-----

--nextPart1305541.QnjyTEcRBu--
