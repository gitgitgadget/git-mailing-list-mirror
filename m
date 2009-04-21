From: martin f krafft <madduck@madduck.net>
Subject: switching a git-svn clone to a different URL (was: reviving a
	git-svn clone)
Date: Tue, 21 Apr 2009 19:06:33 +0200
Message-ID: <20090421170633.GB16665@piper.oerlikon.madduck.net>
References: <20090420104316.GA11433@lapse.rw.madduck.net> <1240296712.3424.8.camel@maia.lan> <86d4c5e00904210209v3f1b8fd3t6a991fe44455941@mail.gmail.com> <20090421115815.GC7967@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 21 19:10:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwJSF-00061a-RL
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 19:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbZDURGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 13:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841AbZDURGo
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 13:06:44 -0400
Received: from clegg.madduck.net ([193.242.105.96]:34629 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbZDURGn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 13:06:43 -0400
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "piper.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 2DCAE1D409B
	for <git@vger.kernel.org>; Tue, 21 Apr 2009 19:06:36 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 2541544A0; Tue, 21 Apr 2009 19:06:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090421115815.GC7967@piper.oerlikon.madduck.net>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.29-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/9268/Tue Apr 21 17:10:12 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117137>


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach martin f krafft <madduck@madduck.net> [2009.04.21.1358 +0200]:
> Now I can turn to changing the URL, since upstream wants to drop
> svn.suspend2.net in favour of svn.tuxonice.net. This does not seem
> to be as straight-forward as it should be. I hate SVN!

Turns out using the --rewrite-root option to 'git svn init' and
swapping the URLs later, as described on the wiki [0], is exactly
what I needed.

0. http://git.or.cz/gitwiki/GitSvnSwitch

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"alas, i am dying beyond my means."
                                                        -- oscar wilde
=20
spamtraps: madduck.bogus@madduck.net

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknt/RMACgkQIgvIgzMMSnXSrwCcCVNYzW+9mp8uVILf6Q+yPPB3
jkwAoLZE3tl+JDbKT0wVzbagBWfr8HU+
=UPly
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
