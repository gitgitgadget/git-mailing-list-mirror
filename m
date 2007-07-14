From: martin f krafft <madduck@madduck.net>
Subject: Re: failing to send patches to the list
Date: Sat, 14 Jul 2007 08:59:28 +0200
Message-ID: <20070714065928.GB27136@lapse.madduck.net>
References: <20070713093050.GA18001@lapse.madduck.net> <f79742$j44$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 12:17:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9egv-0003OX-PF
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 12:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015AbXGNKRb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 06:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754598AbXGNKRb
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 06:17:31 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:56168 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866AbXGNKRa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 06:17:30 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id ACE19895D73
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 12:17:28 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 27725-05 for <git@vger.kernel.org>;
	Sat, 14 Jul 2007 12:17:28 +0200 (CEST)
Received: from lapse.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 74E37895D72
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 12:17:28 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 23C8A4FD42; Sat, 14 Jul 2007 08:59:27 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <f79742$j44$2@sea.gmane.org>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-686 i686
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52461>


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Jakub Narebski <jnareb@gmail.com> [2007.07.14.0258 +0200]:
> Shouldn't this be rather in configure.in? Main Makefile has only
> defaults for different systems, but does not do tests.

You are right, except git HEAD already comes with a Makefile (rather
than a Makefile.in), so I just ran it while testing out patches.
I introduced the test because I thought the computer could find out
about libssl for me, rather than myself having to forget to specify
NO_OPENSSL every time.

I agree that this should be (also) in configure.ac; the question is
more whether we *could* also add it to the Makefile to make
=66rom-source compilations easier.

On the other hand, I wonder: if the mozilla/sha.h implementation is
in the tree anyway, why even bother with libssl? The SHA
implementation is unlikely to be changed anytime soon, so the extra
library dependency seems overkill just for the SHA hash
functionality.

Just my 2=A2

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"to get back my youth i would do anything in the world, except take
 exercise, get up early, or be respectable."
                                                        -- oscar wilde

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGmHRQIgvIgzMMSnURAvq0AJ9rDBPtVRgho4QyxenMacOv7dgRowCgwuRG
E29OL6SCW2ZWGnywJEO6E4g=
=wmy3
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
