From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] Update bash completions to prevent unbound variable errors.
Date: Mon, 12 Jan 2009 15:38:39 -0600
Message-ID: <200901121538.43400.bss@iguanasuicide.net>
References: <496BA0E4.2040607@tedpavlic.com> <200901121527.21818.bss@iguanasuicide.net> <20090112213149.GL10179@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2654180.yxSYgxRIGv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Adeodato =?utf-8?q?Sim=C3=B3?= <dato@net.com.org.es>,
	Ted Pavlic <ted@tedpavlic.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 22:40:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMUVd-0003WP-Ty
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 22:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531AbZALViT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 16:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752655AbZALViT
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 16:38:19 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:51116 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbZALViS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 16:38:18 -0500
Received: from [63.167.79.33]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LMUTx-0003xn-M8; Mon, 12 Jan 2009 21:38:01 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <20090112213149.GL10179@spearce.org>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105390>

--nextPart2654180.yxSYgxRIGv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 2009 January 12 15:31:49 Shawn O. Pearce wrote:
>"Boyd Stephen Smith Jr." <bss@iguanasuicide.net> wrote:
>> Well, if the user want to run in "set -u" mode preventing it is bogus,
>> IMO. We could use subshells and unset at the top of _git and _gitk
>> functions, that would be only a +6/-4 patch.  It would also not be
>> something future contributors have to think (much) about.
>
>Running in subshells is a bad idea.

Yeah, not only for all the reasons you mention, but because it would requir=
e=20
refactoring to use -C instead of -F (so we a longer and uglier patch); our=
=20
changes to COMPREPLY in the subshell wouldn't be seen by bash.

Having tripped over my lack of experience twice in two messages in this=20
thread, I'm going to bow out of the rest of it.  My ascetic opinion still=20
stands, but I'll take working code, warts and all, over broken code.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart2654180.yxSYgxRIGv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklruGMACgkQdNbfk+86fC1D1wCdHtTGsu14vufjdlKgNl2+DXq0
yGcAn2joRHxDKkcQZANFOf9ErYvXd5LR
=Wq8D
-----END PGP SIGNATURE-----

--nextPart2654180.yxSYgxRIGv--
