From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Showing stash state in bash prompt
Date: Thu, 14 May 2009 20:24:21 +0200
Message-ID: <200905142025.02592.trast@student.ethz.ch>
References: <20090513094448.GC2106@bug.science-computing.de> <20090513112535.GD2106@bug.science-computing.de> <7v4ovo4xyt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2549806.vBHlKtoWU3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Daniel Trstenjak <Daniel.Trstenjak@science-computing.de>
X-From: git-owner@vger.kernel.org Thu May 14 20:26:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4fd6-0007Yd-Ed
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 20:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbZENSZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 14:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbZENSZz
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 14:25:55 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:33950 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177AbZENSZy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 14:25:54 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 14 May 2009 20:25:50 +0200
Received: from thomas.localnet ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 14 May 2009 20:25:53 +0200
User-Agent: KMail/1.11.3 (Linux/2.6.27.21-0.1-default; KDE/4.2.3; x86_64; ; )
In-Reply-To: <7v4ovo4xyt.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 14 May 2009 18:25:53.0704 (UTC) FILETIME=[6A7BBA80:01C9D4C1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119210>

--nextPart2549806.vBHlKtoWU3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
> Daniel Trstenjak <Daniel.Trstenjak@science-computing.de> writes:
>=20
> > Showing stash state in bash prompt.
[...]
> 	Subject: [PATCH] completion: show presense of stashed changes
>=20
> 	Users often forget that there are stashed changes that want to be
> 	unstashed.  Add a '$' in the prompt string to remind them.

I'd hate to see this go in without any sort of configurability, since
I would have to patch it out again for my own builds.

The way git-stash is currently documented teaches a stash/apply
workflow, in which pop is not used at all.  For example, in
git-stash.txt itself, the description of 'apply' has all the meat
while 'pop' just refers to 'apply'.  In user-manual.txt, there is an
example that teaches stash/apply.

This may historically be because 'git stash pop' was added later on:

  bd56ff5 (git-stash: add new 'pop' subcommand, 2008-02-22)
  f2c66ed (Add git-stash script, 2007-06-30)

But IMHO it would not be a good idea to teach people stash/pop anyway:
'stash drop' is irreversible, because the stash is itself implemented
through the reflog and thus not guarded by one.

And unfortunately, for people who use stash/apply instead of stash/pop
(including me :-), the proposed indicator merely shows if they have
ever used stash in the current repository.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart2549806.vBHlKtoWU3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkoMYf4ACgkQqUud07tmzP180gCfdLj7JIPi1ll3IgXzz8cL59Kf
bl0AoIWfVs8qNQK/NWCojxk+6Vv0QpE6
=2GWo
-----END PGP SIGNATURE-----

--nextPart2549806.vBHlKtoWU3--
