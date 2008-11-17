From: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
Subject: Grafting mis-aligned trees.
Date: Mon, 17 Nov 2008 16:45:12 -0600
Message-ID: <200811171645.12869.bss03@volumehost.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5482417.mLE8qSvHhX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 18 00:24:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2DSD-000694-2v
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 00:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbYKQXXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 18:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbYKQXXH
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 18:23:07 -0500
Received: from eastrmmtai107.cox.net ([68.230.240.14]:36250 "EHLO
	eastrmmtai107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbYKQXXG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 18:23:06 -0500
X-Greylist: delayed 2250 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Nov 2008 18:23:06 EST
Received: from eastrmimpo01.cox.net ([68.1.16.119])
          by eastrmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20081117224534.LHVN20724.eastrmmtao107.cox.net@eastrmimpo01.cox.net>
          for <git@vger.kernel.org>; Mon, 17 Nov 2008 17:45:34 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo01.cox.net with bizsmtp
	id gNlZ1a0052i4SyG02NlZdV; Mon, 17 Nov 2008 17:45:33 -0500
X-Authority-Analysis: v=1.0 c=1 a=nEQGfrJnAAAA:8 a=NmERGd_JpBVGFTSkQ5kA:9
 a=WAJP-zaRVLYFhjwEetUA:7 a=AbS6fFyS1Sf9bbTUdtXVdeEQfPIA:4 a=B7iFY6Z7H_gA:10
 a=gi0PWCVxevcA:10 a=q6Lt0MKa98zCPV7-rRUA:9 a=VLsiqBGsZQd0i-A-5xX1HC0FcmIA:4
 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss03@volumehost.net>)
	id 1L2CqL-0006Ep-Ut
	for git@vger.kernel.org; Mon, 17 Nov 2008 16:45:17 -0600
User-Agent: KMail/1.9.9
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101254>

--nextPart5482417.mLE8qSvHhX
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I haven't gotten a response from my subscription email, so please CC me on =
any replies.

So, I've been managaing the source I had from a client project in git and=20
have a non-linear history.  Currently, two tips (production and testing)=20
but there are many feature branches that were git-merge'd in, not rebased.

Now, I've gotten the full tree.  Turns out all the source code I was=20
working on was in a subdirectory "project/web".  I'd like to "graft" the=20
*changes* I made onto the full tree.

I figured this might be a job for git-filter-branch.  Certainly, that did=20
the job of moving all my changes into the subdirectory.  But, now I want to=
=20
do something that's a combination or git-rebase and git-filter-branch.  I=20
want to replay the *patches/deltas* (like rebase) on top of the full tree I=
=20
have, but *maintain the non-liear history* (like filter-branch).

Can anyone think of a recipe for me?

Trees look something like this right now.

<some history> -> FT

TI -> <non-linear history> -> A -> <non-linear history> -> C
   \                            \                           \
    -> PI ------------------------> B ------------------------> D

I'd like to have it look something like:

<some history> -> FT -> <non-linear history> -> A' -> <non-linear history> =
=2D> C'
                    \                            \                         =
  \
                     -> PI' ----------------------> B' --------------------=
=2D--> D'

A', B', C', and D' are different commits, but the diff (and history) betwee=
n=20
=46T and A' is the same as the diff (and history) between TI and A.

Again, please CC me on any replies.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss03@volumehost.net                      ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.org/                      \_/    =20

--nextPart5482417.mLE8qSvHhX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkh8/gACgkQ55pqL7G1QFloVgCggnAjX/SEBx/dp9ZPGFIWBn9r
idkAoIliYCbxXTg8IB4J7ZvIKCe6i/lE
=jsAQ
-----END PGP SIGNATURE-----

--nextPart5482417.mLE8qSvHhX--
