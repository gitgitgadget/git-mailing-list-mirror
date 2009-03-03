From: martin f krafft <madduck@debian.org>
Subject: Re: topgit patches
Date: Tue, 3 Mar 2009 08:54:23 +0100
Organization: The Debian project
Message-ID: <20090303075423.GA29920@piper.oerlikon.madduck.net>
References: <20090225195856.GA12372@pengutronix.de> <20090225212309.GM12275@machine.or.cz> <20090225231550.GA19741@pengutronix.de> <20090226060652.GA16251@lapse.rw.madduck.net> <20090302162641.GB15229@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Tue Mar 03 08:56:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LePU6-000884-FU
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 08:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbZCCHyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 02:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbZCCHyq
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 02:54:46 -0500
Received: from clegg.madduck.net ([193.242.105.96]:57636 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbZCCHyp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 02:54:45 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 9FF291D409B;
	Tue,  3 Mar 2009 08:54:25 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTPS id 8C73C9F166;
	Tue,  3 Mar 2009 08:54:23 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 1A6BD450A; Tue,  3 Mar 2009 08:54:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090302162641.GB15229@pengutronix.de>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.26-1-amd64 x86_64
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/9062/Tue Mar  3 05:42:20 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112016>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [2009.03.02=
=2E1726 +0100]:
> > it. But if someone else has the time, maybe we can prepare a 0.6
> > without a new option parser?
> I assume you planned to use git rev-parse --parseopt?

Yes.

> Since topgit-0.5 we have some fixes, a new export method and improved
> bash completion.  Just repackaging the current state into a new Debian
> package closes 4 bugs in the Debian BTS.
>=20
> Before 0.6 I still need to write some documentation for the new export
> method, but after that I consider releasing the then current state as
> 0.6 is a good idea.
>=20
> martin, Petr, others: any comments?  Should I just tag if I feel ready?

Sounds good to me, even without parseopt. Thanks Uwe for stepping in
to help us!

> martin: I can try to prepare the Debian package, AFAIK I cannot
> upload it, so here I need your help.  (And maybe you should check
> the package, because up to now I only created Debian packages for
> my private use.)

Possibly the easiest way to do this is http://mentors.debian.net, so
if that's okay with you, send me the URL to the uploaded .dsc file
and I will look at it and get back to you. If you don't want to
bother creating the source package, just let me know which commit ID
to build (don't tag debian/* until after the upload).

--=20
 .''`.   martin f. krafft <madduck@d.o>      Related projects:
: :'  :  proud Debian developer               http://debiansystem.info
`. `'`   http://people.debian.org/~madduck    http://vcs-pkg.org
  `-  Debian - when you have better things to do than fixing systems
=20
"if you are going to run a rinky-dink distro made by a couple of
 volunteers, why not run a rinky-dink distro made by a lot of
 volunteers?"
                                                    -- jaldhar h. vyas

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkms4igACgkQIgvIgzMMSnUzQACfewAFugpv1FdefRrPJxLywGtV
TtAAn2Ii5bu1yZVCQ/MaW7PnP/AiEFUT
=g1P6
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
