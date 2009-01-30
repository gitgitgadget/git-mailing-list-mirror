From: martin f krafft <madduck@madduck.net>
Subject: Re: [topgit] shared topic branch
Date: Fri, 30 Jan 2009 11:15:30 +0100
Message-ID: <20090130101530.GA20372@lapse.rw.madduck.net>
References: <EFB70468-7900-4B22-925D-3FC5F05F951B@gmail.com> <20090126120049.GA9676@lapse.rw.madduck.net> <111E5FDD-FC51-4DD2-9959-676003CD7A61@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
To: Fabien Thomas <thomas.fabien@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 11:17:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSqQv-0007cQ-Hn
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 11:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686AbZA3KPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 05:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753525AbZA3KPp
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 05:15:45 -0500
Received: from clegg.madduck.net ([193.242.105.96]:36186 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969AbZA3KPo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 05:15:44 -0500
Received: from lapse.rw.madduck.net (lapse.rw.madduck.net [IPv6:2001:41e0:ff3a::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id A57A31D40B1;
	Fri, 30 Jan 2009 11:15:32 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 7283D800E; Fri, 30 Jan 2009 11:15:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <111E5FDD-FC51-4DD2-9959-676003CD7A61@gmail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux 5.0 kernel 2.6.27-1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8922/Fri Jan 30 08:21:43 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107787>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Fabien Thomas <thomas.fabien@gmail.com> [2009.01.27.0823 +0100]:
> on the git side:
> the + will overwrite all remote location branche named with that pattern=
=20
> ?

+ simply allows non-fast-forwards. See git-push(1). And that's on
the local side, not the remote. Which is what you want.

> if i'm not up to date and i start a push with the "+" will
> overwrite the central repo with my local branch. (overwrite of my
> central repo master branch and my topics)

please reproduce the problem and paste the complete transcript of
what you are doing: commands and output, as well as the output of
git branch -av before and after.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"now, bring me that horizon."
                                               -- captain jack sparrow
=20
spamtraps: madduck.bogus@madduck.net

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmC0z8ACgkQIgvIgzMMSnX9PACg27K3lnJJCbMi3C7L1rDW/9Nf
6a8AoJ5vD1hdCKn7/kJUVuc3wv6OwMIk
=DTsX
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
