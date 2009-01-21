From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: what are plumbing and porcelain
Date: Tue, 20 Jan 2009 23:50:10 -0600
Message-ID: <200901202350.15011.bss@iguanasuicide.net>
References: <20090121052741.GC6970@b2j>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1793682.bI79vLnqc6";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 06:51:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPW05-0001to-PT
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 06:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbZAUFuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 00:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbZAUFuS
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 00:50:18 -0500
Received: from eastrmmtao104.cox.net ([68.230.240.46]:36589 "EHLO
	eastrmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbZAUFuR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 00:50:17 -0500
Received: from eastrmimpo01.cox.net ([68.1.16.119])
          by eastrmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090121055016.BXQU3752.eastrmmtao104.cox.net@eastrmimpo01.cox.net>;
          Wed, 21 Jan 2009 00:50:16 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo01.cox.net with bizsmtp
	id 65qF1b00D2i4SyG025qGvp; Wed, 21 Jan 2009 00:50:16 -0500
X-Authority-Analysis: v=1.0 c=1 a=Fq1VQ0LPAAAA:8 a=FyOGl_SDYmV4vN6j36EA:9
 a=n433RZGqMaRmGntTYjw68aRjXtUA:4 a=MSl-tDqOz04A:10 a=T3brmoaXcPoA:10
 a=LY0hPdMaydYA:10 a=TIF4ISnt0FzQ79_Xg6MA:9 a=VLsAlUIrTIwvk216ZegujJKo3aIA:4
 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LPVyh-000Lj5-4I; Tue, 20 Jan 2009 23:50:15 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <20090121052741.GC6970@b2j>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106569>

--nextPart1793682.bI79vLnqc6
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 20 January 2009, bill lam <cbill.lam@gmail.com> wrote=20
about 'what are plumbing and porcelain':
>Sorry for this idiot question, but I really don't know what they are
>and why it is necessary to distinguish between them.

"plumbing" are the commands that do low-level operations.  Generally,=20
end-users won't have to use them much, if at all, but they=20
are "fundamental" operations, upon which git is built.  It's a term also=20
used in other project some, with a similar meaning.

"porcelain" is a cute name for the end-user operations.  They "cover" the=20
plumbing to make it look and act "pretty".  While some may be less useful=20
to some users, they all are high-level operations that depend on the=20
plumbing.

It's important to distinguish between them because we don't want the=20
plumbing to get needlessly complex.  They should be single-purpose=20
commands and their options should be utilitarian in nature.  Also,=20
porcelain is meant to be used interactively, not in scripts, so the output=
=20
or behavior might change a bit--but that is still kept to a minimum.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1793682.bI79vLnqc6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkl2t5IACgkQ55pqL7G1QFl80QCcCM+CUQuVtSYdpc9HKiVtB9j4
gAMAniPWvrRtvmjvKRd1wU3Rtg+RKKEB
=HR32
-----END PGP SIGNATURE-----

--nextPart1793682.bI79vLnqc6--
