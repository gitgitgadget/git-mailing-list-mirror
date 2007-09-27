From: martin f krafft <madduck@madduck.net>
Subject: ignoring non-submodule subrepositories
Date: Thu, 27 Sep 2007 18:07:00 +0100
Message-ID: <20070927170700.GA10250@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 19:08:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IawpX-0003FY-3A
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 19:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683AbXI0RHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 13:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754189AbXI0RHH
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 13:07:07 -0400
Received: from clegg.madduck.net ([82.197.162.59]:53088 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683AbXI0RHF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 13:07:05 -0400
Received: from lapse.madduck.net (absinthe.ifi.unizh.ch [130.60.75.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 2775ABA3E0
	for <git@vger.kernel.org>; Thu, 27 Sep 2007 19:07:01 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id C458E3FD6B; Thu, 27 Sep 2007 18:07:00 +0100 (BST)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4411/Wed Sep 26 23:43:35 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59306>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I have a repository inside another, and for several reasons, I do
not want to use git-submodule in this case. My issue is that
git-status lists the subrepository as untracked.

Of course, I could add it to .gitignore alright, but instead
I wonder whether it would not make sense to ignore subdirectories
themselves containing .git/ directories, not explicitly so as to not
mess with git-submodule, but implicitly.

Thoughts?

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
never underestimate the power of human stupidity.
=20
spamtraps: madduck.bogus@madduck.net

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG++M0IgvIgzMMSnURApYMAJ9rQ3eQhWRpkeJ+tOj6dGtZBPuyJgCg2WEf
rHq4OhI6ur1tSbGu1SOl590=
=qH9V
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
