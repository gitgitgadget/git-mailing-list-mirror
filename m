From: martin f krafft <madduck@madduck.net>
Subject: Re: how to combine two clones in a collection
Date: Tue, 10 Jul 2007 09:40:13 +0200
Message-ID: <20070710074013.GA457@piper.oerlikon.madduck.net>
References: <20070709222250.GA8007@piper.oerlikon.madduck.net> <alpine.LFD.0.999.0707091923300.3412@woody.linux-foundation.org> <20070710062104.GA22603@piper.oerlikon.madduck.net> <7v3azwsp6a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 09:40:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8AKf-00079Y-MB
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 09:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbXGJHkS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 03:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbXGJHkS
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 03:40:18 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:48290 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbXGJHkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 03:40:16 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 6D121895D74
	for <git@vger.kernel.org>; Tue, 10 Jul 2007 09:40:14 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 06048-05 for <git@vger.kernel.org>;
	Tue, 10 Jul 2007 09:40:14 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 1934C895D71
	for <git@vger.kernel.org>; Tue, 10 Jul 2007 09:40:13 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 7E7439F121
	for <git@vger.kernel.org>; Tue, 10 Jul 2007 09:40:13 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 51B9643FC; Tue, 10 Jul 2007 09:40:13 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v3azwsp6a.fsf@assigned-by-dhcp.cox.net>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52051>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Junio C Hamano <gitster@pobox.com> [2007.07.10.0917 +0200]:
> For the former kind, It is unavoidable for people to get your
> (slightly modified) upstream source from you --- there is
> nowhere else that stores what you changed.

This is pretty similar to a method developed by Manoj Srivastava adn
described here: http://arch.debian.org/arch/private/srivasta/ and
it's very promising, albeit a little complex for newcomers, in my
experience. As linked previously, I presented a similar workflow
with git[0] at DebConf7[1].

0. http://albatross.madduck.net/pipermail/vcs-pkg/2007-June/000001.html
1. https://penta.debconf.org/~joerg/events/53.en.html

I actually knew the answers to my questions, I guess, but I was way
too confused to get the picture straight. Thanks to both of you for
your time in helping me understand.

I shall spend some time experimenting and will then blog about my
experience of converting the various types of Debian source packages
to the suggested style of maintenance. I shall post the URL to this
thread too.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"for art to exist, for any sort of aesthetic activity or perception to
 exist, a certain physiological precondition is indispensable:
 intoxication."
                                                -- friedrich nietzsche

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGkzfdIgvIgzMMSnURAolQAJ9ifQQwrpqXi3x2YyUHqyaoOtKyGwCgipAa
7sMLcXZd4+nITf5VS/tvlIM=
=h88N
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
