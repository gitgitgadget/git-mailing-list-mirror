From: martin f krafft <madduck@debian.org>
Subject: Re: topgit patches
Date: Fri, 27 Feb 2009 13:37:31 +0100
Organization: The Debian project
Message-ID: <20090227123731.GA22696@piper.oerlikon.madduck.net>
References: <20090225195856.GA12372@pengutronix.de> <20090225212309.GM12275@machine.or.cz> <20090225231550.GA19741@pengutronix.de> <20090226060652.GA16251@lapse.rw.madduck.net> <20090226141548.GA32439@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Fri Feb 27 13:39:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld1zn-0002Mj-MK
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 13:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607AbZB0Mhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 07:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbZB0Mhs
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 07:37:48 -0500
Received: from clegg.madduck.net ([193.242.105.96]:37046 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbZB0Mhr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 07:37:47 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 675C41D409B;
	Fri, 27 Feb 2009 13:37:33 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTPS id 560B69F13D;
	Fri, 27 Feb 2009 13:37:32 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id E12E94509; Fri, 27 Feb 2009 13:37:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090226141548.GA32439@pengutronix.de>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux 5.0 kernel 2.6.26-1-amd64 x86_64
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/9054/Fri Feb 27 10:02:52 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111666>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [2009.02.26=
=2E1515 +0100]:
> If you need help, I'm also interested to co-maintain the debian
> package. Just an offer ...  (I don't know the exact way to become
> a maintainer, if I need to meet a Debian developer, that's no
> problem, I know one.)

The Debian package is pretty trivial to maintain on top of upstream
(thanks to topgit), and I am using it a bit as a test-case for
workflow experiments. However, if you are interested in packaging,
by all means, join me. In that case I'd suggest that you make the
0.6-1 Debian package after 0.6 is out, and I give you some hints up
front and then simply stand by to help out.

>  1 move all or most topgit-topic-branches to a private namespace, say
>    refs/top-heads because the patch branches pollute the output of git
>    branch.

But aren't the topic branches essentially also plain Git branches?

>  2 export method that works like the existing linearize but creates
>    branches for topgit branches living in refs/heads and merges these
>    properly without linearisation.
>    (obviously depends on 1)

I am not sure I understand what you are trying to do.

>  3 address topgit bugs on bugs.debian.org

Awesome. I will try to be available for any support you might need.
I just can't come up with a sufficiently long stretch of time to see
through the next release right now.

Cheers,

--=20
 .''`.   martin f. krafft <madduck@d.o>      Related projects:
: :'  :  proud Debian developer               http://debiansystem.info
`. `'`   http://people.debian.org/~madduck    http://vcs-pkg.org
  `-  Debian - when you have better things to do than fixing systems
=20
ubuntu is an ancient african word meaning "i can't install debian."
                                                          -- unknown

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmn3osACgkQIgvIgzMMSnV3oACeMLIaN0qA86Drwjh5oQ05FjAA
vm0AoIYywGpnay5PtZs40omhB0xz+OjU
=UmBa
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
