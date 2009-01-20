From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: What's cooking in git.git (Jan 2009, #04; Mon, 19)
Date: Mon, 19 Jan 2009 23:17:13 -0600
Message-ID: <200901192317.23079.bss@iguanasuicide.net>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2731445.OpykBLznDi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 06:18:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP90q-0007nB-D4
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 06:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbZATFR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 00:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbZATFR3
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 00:17:29 -0500
Received: from eastrmmtao103.cox.net ([68.230.240.9]:54735 "EHLO
	eastrmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbZATFR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 00:17:28 -0500
Received: from eastrmimpo01.cox.net ([68.1.16.119])
          by eastrmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090120051727.JUPH18445.eastrmmtao103.cox.net@eastrmimpo01.cox.net>;
          Tue, 20 Jan 2009 00:17:27 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo01.cox.net with bizsmtp
	id 5hHR1b0072i4SyG02hHS7E; Tue, 20 Jan 2009 00:17:27 -0500
X-Authority-Analysis: v=1.0 c=1 a=i9Njo8JdTk0A:10 a=UjP9HbbQeAAA:10
 a=Fq1VQ0LPAAAA:8 a=Nkgay6Y5G33-qWcplx0A:9 a=rOFf6Ir6bcclFjAt_ZNK1SugpdIA:4
 a=qIVjreYYsbEA:10 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10
 a=0SKBznAgIUJTKiXxgyAA:9 a=8nd6BTlL8XUIGPTOI4BJCeMcS2wA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LP8zL-000CVg-J5; Mon, 19 Jan 2009 23:17:23 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <7vbpu3r745.fsf@gitster.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106439>

--nextPart2731445.OpykBLznDi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 19 January 2009, Junio C Hamano <gitster@pobox.com> wrote=20
about 'What's cooking in git.git (Jan 2009, #04; Mon, 19)':
>Here are the topics that have been cooking.  Commits prefixed with '-'
> are only in 'pu' while commits prefixed with '+' are in 'next'.  The
> ones marked with '.' do not appear in any of the branches, but I am
> still holding onto them.

Is there anywhere you are publishing these refs?  Of course, I see the=20
commits in 'pu', but sometimes I would like to merge something you have=20
in 'next'/'pu' into a branch based on 'master' or one of my local=20
branches, and I have to go hunting for the commit SHA.

It's not a big deal: qgit, gitk, and 'git log'+grep all solve the issue=20
quickly enough, and I don't want to add to your workload.  I was just=20
hoping they were already published and I could simply add a remote to my=20
config to get them.

Currently, I'm just using:
* remote origin
  URL: git://git.kernel.org/pub/scm/git/git.git
  Remote branch merged with 'git pull' while on branch master
    master
  Tracked remote branches
    html maint man master next pu todo
and I get this:
$ git pull origin jk/color-parse
fatal: Couldn't find remote ref jk/color-parse
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart2731445.OpykBLznDi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkl1XloACgkQ55pqL7G1QFmhgQCfYt5SyoM+NmfI78MzKKT23ozA
b9IAnRYUcqKR3Hb3RnTFHH+P9QhKOq8e
=d6DM
-----END PGP SIGNATURE-----

--nextPart2731445.OpykBLznDi--
