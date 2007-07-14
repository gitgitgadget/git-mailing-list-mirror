From: martin f krafft <madduck@madduck.net>
Subject: git-svn: tagging trunk in SVN with git-svn?
Date: Sat, 14 Jul 2007 16:03:59 +0200
Message-ID: <20070714140359.GA5738@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 14 16:04:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9iED-0005k1-Nr
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 16:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757919AbXGNOEF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 10:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757950AbXGNOEE
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 10:04:04 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:40492 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757524AbXGNOED (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 10:04:03 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id CFF0E895D73
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 16:04:00 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 07421-04 for <git@vger.kernel.org>;
	Sat, 14 Jul 2007 16:04:00 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 8EF81895D72
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 16:04:00 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id E54209F121
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 16:03:59 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id BD04C43FC; Sat, 14 Jul 2007 16:03:59 +0200 (CEST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52481>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear list,

I searched the list(s) and even read the code of git-svn, but I am
none the wiser now. From what I understand, git-svn is primarily
used to interact with subversion, rather than doing one-shot imports
(which it can do as well).

I am using it now and it works like a charm (thanks!). However,
I cannot really figure out how to tag the remote trunk from within
git-svn. I tried `git tag tags/1.2.57`, `git tag 1.2.57` and `git
branch tags/1.2.57`, but in none of the three cases does dcommit
think that it needs to push anything upstream.

Is what I am trying to do possible, or do I need to use svn for
that?

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"nothing can cure the soul but the senses,
 just as nothing can cure the senses but the soul."
                                                        -- oscar wilde

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGmNfPIgvIgzMMSnURAhF0AKCEyZOMsYccMYSArdtVjae1RBl73ACeIiVL
fE0YYbES5q5f0frnf0CSEZQ=
=ECXu
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
