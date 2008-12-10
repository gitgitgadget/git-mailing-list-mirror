From: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
Subject: Re: fatal output from git-show really wants a terminal
Date: Wed, 10 Dec 2008 10:10:14 -0600
Message-ID: <200812101010.14868.bss03@volumehost.net>
References: <ghop5d$qud$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart614474878.afLusXfKXG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Tim Olsen <tim@brooklynpenguin.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 10 17:12:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LARf3-0005wm-LL
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 17:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753543AbYLJQKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 11:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbYLJQKX
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 11:10:23 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:54303 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbYLJQKW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 11:10:22 -0500
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20081210161022.JXEI2948.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>;
          Wed, 10 Dec 2008 11:10:22 -0500
Received: from [10.0.0.123] ([72.204.50.125])
	by fed1rmimpo03.cox.net with bizsmtp
	id pUA91a00D2i4SyG04UAMlc; Wed, 10 Dec 2008 11:10:22 -0500
X-Authority-Analysis: v=1.0 c=1 a=4x8eZqvhE5cA:10 a=cCwArZ2WySYA:10
 a=nEQGfrJnAAAA:8 a=iN18yP-ElZEsN2CUkc4A:9 a=4OVYHAgB7ssekxPcUEnGVaWI4MYA:4
 a=B7iFY6Z7H_gA:10 a=LY0hPdMaydYA:10 a=7vY25r5LKNZFbyYTDf8A:9
 a=rVdmItnawO-iSBJMOSoTI38fvawA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
User-Agent: KMail/1.9.9
In-Reply-To: <ghop5d$qud$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102696>

--nextPart614474878.afLusXfKXG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 2008 December 10 10:01:49 you wrote:
>It appears that when outputting a fatal error, git-show will choose
>stdout over stderr if stdout is a terminal and stderr is not.  How do I
>redirect the error but still allow stdout to be displayed?

Gah, I think that's really bad behavior. Anyway, something like:
git show 12345 2>/dev/null | cat
should work.  Neither stdout nor stderr will be a terminal, but stdout will=
 be=20
displayed to your terminal.
=2D-=20
Boyd Stephen Smith Jr. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ,=3D ,-_-. =
=3D.=20
bss03@volumehost.net =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((_/)o o(\_=
))
ICQ: 514984 YM/AIM: DaTwinkDaddy =A0 =A0 =A0 =A0 =A0 `-'(. .)`-'=20
http://iguanasuicide.org/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\_/ =
=A0 =A0=20

--nextPart614474878.afLusXfKXG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkk/6eYACgkQdNbfk+86fC1v0gCcDxWXFtigmHt1edVDqgxduHg2
e0oAn0NTqABxiCrPzXno/1hXLTGj2wej
=xDAJ
-----END PGP SIGNATURE-----

--nextPart614474878.afLusXfKXG--
