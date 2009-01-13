From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: how to combine 2 commits?
Date: Mon, 12 Jan 2009 23:27:16 -0600
Message-ID: <200901122327.21102.bss@iguanasuicide.net>
References: <20090113045422.GA6940@b2j>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1600441.vRFc7zvPh2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: bill lam <cbill.lam@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 06:28:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMbpX-0006FW-CI
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 06:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbZAMF1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 00:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbZAMF1Y
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 00:27:24 -0500
Received: from eastrmmtao105.cox.net ([68.230.240.47]:63328 "EHLO
	eastrmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbZAMF1X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 00:27:23 -0500
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090113052722.WIHA4139.eastrmmtao105.cox.net@eastrmimpo02.cox.net>;
          Tue, 13 Jan 2009 00:27:22 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo02.cox.net with bizsmtp
	id 2tTM1b00C2i4SyG02tTM7p; Tue, 13 Jan 2009 00:27:22 -0500
X-Authority-Analysis: v=1.0 c=1 a=Fq1VQ0LPAAAA:8 a=ERLGZdSE-8LwwQZi0V8A:9
 a=k5OFKgBjWQwxL8ujtmzvPdIFGYgA:4 a=MSl-tDqOz04A:10 a=T3brmoaXcPoA:10
 a=LY0hPdMaydYA:10 a=lmvPmao1TeoXXRASv90A:9 a=tWnG1GlSAvWp47nFYie7sJiy_X8A:4
 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LMbo9-0001Kt-7n; Mon, 12 Jan 2009 23:27:21 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <20090113045422.GA6940@b2j>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105457>

--nextPart1600441.vRFc7zvPh2
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 12 January 2009, bill lam <cbill.lam@gmail.com> wrote about 'how=
=20
to combine 2 commits?':
>How to combine these 2 commits so that the changes of linefeed cancel
>out each other and the history only shows the intended changes of the
>few scripts.

Two ways I can think of:
git rebase --interactive (read "git help rebase" first)
git merge --squash (read "git help merge" first)

The rebase is probably semantically closer to how you are thinking about=20
things right now.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1600441.vRFc7zvPh2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklsJjQACgkQ55pqL7G1QFk/YwCeOrT0xpg0FJL8+Mce+gzfoxv1
1moAn16Uv1SUf0W9p3uOzAo3R7FVdRax
=QQKB
-----END PGP SIGNATURE-----

--nextPart1600441.vRFc7zvPh2--
