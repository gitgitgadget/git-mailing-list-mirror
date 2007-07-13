From: martin f krafft <madduck@madduck.net>
Subject: Re: Lump commit HOWTO?
Date: Fri, 13 Jul 2007 08:09:09 +0200
Message-ID: <20070713060909.GA18442@lapse.madduck.net>
References: <625fc13d0707121821l70e2d6aaw555c79b5d700585f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 13 08:09:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9EL0-00005V-Jw
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 08:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbXGMGJH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 02:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbXGMGJG
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 02:09:06 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:38582 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbXGMGJF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 02:09:05 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id ADD45895D6F
	for <git@vger.kernel.org>; Fri, 13 Jul 2007 08:09:03 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 16675-03 for <git@vger.kernel.org>;
	Fri, 13 Jul 2007 08:09:03 +0200 (CEST)
Received: from lapse.madduck.net (p549C364A.dip0.t-ipconnect.de [84.156.54.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 57656895D6D
	for <git@vger.kernel.org>; Fri, 13 Jul 2007 08:09:03 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 078F34FD40; Fri, 13 Jul 2007 08:09:09 +0200 (CEST)
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <625fc13d0707121821l70e2d6aaw555c79b5d700585f@mail.gmail.com>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-686 i686
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52364>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Josh Boyer <jwboyer@gmail.com> [2007.07.13.0321 +0200]:
> 8) take all local commits (A - D) and create a single commit without
> any of the upstream changes in it

This is entirely untested and since I am a newbie, it might well not
work, but shouldn't the following do what you want?

git log origin..master --> gives you the local commits not in origin
git checkout -b merger
git merge --squash <sha> <sha> <sha> ...
git commit ...

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
officer, arrest that man! he's whistling a copyrighted song.

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGlxcFIgvIgzMMSnURAv1oAKDmk3qAKjsZr1cyFcUb7Ks6cw0NawCfWpWG
h1MN6Dl78OwQY31yEiKaHug=
=TVOf
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
