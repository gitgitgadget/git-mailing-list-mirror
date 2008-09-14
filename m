From: martin f krafft <madduck@madduck.net>
Subject: TopGit: how to deal with upstream inclusion
Date: Sun, 14 Sep 2008 21:30:43 +0100
Organization: The Debian project
Message-ID: <20080914203043.GA4872@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
To: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 22:32:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeyGM-0003gu-Bw
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 22:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbYINUa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2008 16:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753918AbYINUa6
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 16:30:58 -0400
Received: from clegg.madduck.net ([193.242.105.96]:38752 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbYINUa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 16:30:57 -0400
Received: from lapse.rw.madduck.net (lapse.rw.madduck.net [IPv6:2001:41e0:ff3a::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id DB0651D40C9;
	Sun, 14 Sep 2008 22:30:45 +0200 (CEST)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id BF6AB80C0; Sun, 14 Sep 2008 21:30:43 +0100 (IST)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel
	2.6.24-etchnhalf.1+scoflowctrl.1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94/8238/Sun Sep 14 19:22:28 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95858>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Petr, hi Gits,

So the Debian topgit package used to have a branch fixes/destdir to
make the Makefile distro-friendly. TopGit 0.3 has integrated this,
thus obsoleting the fixes/destdir branch.

I thought the way to handle this would be to simply delete the
TopGit branch, but of course that breaks everything, e.g.:

lapse:..t/topgit|debian/locations|% tg update
tg: fatal: some dependencies are missing: fixes/destdir

I now we had a recent discussion about how to remove branches, and
that there's basically no way to do this. In the discussion,
upstream inclusion was listed as one of the instances when this
wouldn't be needed, but that refers to upstream pulling/am'ing my
commits, not implementing the same functionality differently.

How do I retire the fixes/destdir branch? Do I manually remove the
dependency from depending branches?

Thanks,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"one should never allow one's mind
 and one's foot to wander at the same time."
                                -- edward perkins (yes, the librarian)
=20
spamtraps: madduck.bogus@madduck.net

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjNdHMACgkQIgvIgzMMSnWoZACg7XPjZGIfEDSWg6OVgrkB/fMk
V4wAn1tLo9bjO4wweyQb5r8MQdg1ulSD
=o87I
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
