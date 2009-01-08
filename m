From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH (topgit)] tg-patch: add support for generating patches
	against worktree and index
Date: Fri, 9 Jan 2009 08:53:56 +1300
Message-ID: <20090108195356.GA14644@lapse.rw.madduck.net>
References: <1231438975-13624-1-git-send-email-kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 21:06:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL0yi-00019c-CT
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 20:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755437AbZAHTyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 14:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753858AbZAHTyQ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 14:54:16 -0500
Received: from clegg.madduck.net ([193.242.105.96]:53138 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbZAHTyP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 14:54:15 -0500
Received: from lapse.rw.madduck.net (unknown [IPv6:2404:130:0:a000:214:a4ff:fe04:eadc])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 5A2531D40A9;
	Thu,  8 Jan 2009 20:54:02 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id D971B80C9; Fri,  9 Jan 2009 08:53:56 +1300 (NZDT)
Content-Disposition: inline
In-Reply-To: <1231438975-13624-1-git-send-email-kirr@landau.phys.spbu.ru>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux 5.0 kernel 2.6.27-1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8845/Thu Jan  8 17:52:13 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104956>


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Kirill Smelkov <kirr@landau.phys.spbu.ru> [2009.01.09.0722 +130=
0]:
> This implements `tg patch -i` and `tg patch -w` to see current
> patch as generated against not-yet-committed index and worktree.

I think at this early stage, it would make sense to use long options
and not reserve short options yet. Unless Petr disagrees, I'd kindly
ask you to use long options instead. Once TopGit has been around for
a while, we can provide short options for the most important long
options.

This is possibly too conservative, but I've been bitten by lack of
new letters before because I've used them all up for options that
later turned out not to be needed.

I have not yet had the time to actually look at the patch.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"when zarathustra was alone... he said to his heart: 'could it be
 possible! this old saint in the forest hath not yet heard of it, that
 god is dead!'"
                                                 - friedrich nietzsche
=20
spamtraps: madduck.bogus@madduck.net

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklmWdQACgkQIgvIgzMMSnUdkACgr9/II42kotRJua85GOs/HZT/
t9sAoMZWBMMfPpqD6Zs8uNhYIIE+bZUs
=7Bi3
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
