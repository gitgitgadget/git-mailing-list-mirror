From: martin f krafft <madduck@madduck.net>
Subject: worktree: incorrect handling of directory argument
Date: Sat, 10 May 2008 00:12:52 +0100
Message-ID: <20080509231252.GA14822@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 10 01:13:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jubmc-0006Cq-Az
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 01:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756299AbYEIXM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 19:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756268AbYEIXM4
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 19:12:56 -0400
Received: from clegg.madduck.net ([82.197.162.59]:57682 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086AbYEIXMz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 19:12:55 -0400
Received: from lapse.madduck.net (chiu.ifi.unizh.ch [130.60.75.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 9FCA2A83C2
	for <git@vger.kernel.org>; Sat, 10 May 2008 01:12:51 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 021E74FD40; Sat, 10 May 2008 00:12:52 +0100 (IST)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.24-1+scoflowctrl.1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.92.1/7081/Fri May  9 17:52:50 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81634>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

If I set core.worktree to ../.. instead of ../../, then a file foo
will be unpacked by checkout-index to be the literal ../..foo, not
=2E./../foo. I suppose core.worktree should always be treated as
a directory.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"everyone has a little secret he keeps,
 i like the fires when the city sleeps."
                                                  -- mc 900 ft jesus
=20
spamtraps: madduck.bogus@madduck.net

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIJNpyIgvIgzMMSnURAuH6AJ96+9m5PVtEUTW7Ir1QccnFiOJagwCgiQKR
DXIYbg1uj7dT5s8d2jD+69w=
=/t85
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
