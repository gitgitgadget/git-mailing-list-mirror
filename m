From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Retrieving last tag of a working tree
Date: Sun, 21 Dec 2008 16:28:56 +0100
Message-ID: <200812211628.59120.trast@student.ethz.ch>
References: <21071491.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5085823.sxvG7prKkX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "the_jack" <josip@yopmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 16:30:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEQGR-0001ZD-QX
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 16:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644AbYLUP2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 10:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753953AbYLUP2v
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 10:28:51 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:33615 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752620AbYLUP2u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 10:28:50 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 21 Dec 2008 16:28:48 +0100
Received: from [192.168.0.3] ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 21 Dec 2008 16:28:48 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <21071491.post@talk.nabble.com>
X-OriginalArrivalTime: 21 Dec 2008 15:28:48.0344 (UTC) FILETIME=[D1CA7580:01C96380]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103703>

--nextPart5085823.sxvG7prKkX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

the_jack wrote:
> Precompiler assigns this string to a variable. At this moment, version.h =
is
> filled by python script that calls "git-describe --tag HEAD" and parses t=
he
> output. This works, but it's not quite reliable. There has to be a better
> way for getting the last tag of current working tree. If I checkout an
> earlier tagged version (0.70), I would need to automatically get 0.70 ins=
ide
> version.h

'git describe' is indeed the tool for this.  You have not said in what
way it fails, so here's an educated guess:

Up until 7e425c4 (describe: Make --tags and --all match lightweight
tags more often, 2008-10-13) which will only be in 1.6.1, using --tags
does not match a lightweight tag if there is also an annotated tag
available.

=2DThomas

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch





--nextPart5085823.sxvG7prKkX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklOYLsACgkQqUud07tmzP3GzQCggACWpb4WJ3Tg9QMUdel0twDW
pjwAn2C3wZUliUHV/j1aPT8x+Jjv8/ep
=ii7m
-----END PGP SIGNATURE-----

--nextPart5085823.sxvG7prKkX--
