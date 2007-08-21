From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] Clarify role of init command in git-submodules
	documentation
Date: Tue, 21 Aug 2007 23:03:49 +0200
Message-ID: <20070821210349.GA16702@piper.oerlikon.madduck.net>
References: <20070817103652.GK1070MdfPADPa@greensroom.kotnet.org> <11875937841178-git-send-email-madduck@madduck.net> <7vd4xhsybm.fsf@gitster.siamese.dyndns.org> <20070817103652.GK1070MdfPADPa@greensroom.kotnet.org> <11875937841178-git-send-email-madduck@madduck.net> <20070820075459.GY1070MdfPADPa@greensroom.kotnet.org> <20070821180218.GA14739@piper.oerlikon.madduck.net> <20070821202516.GL1070MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
To: Sven Verdoolaege <skimo@kotnet.org>, git@vger.kernel.org,
	hjemli@gmail.com, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 23:04:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INate-00049J-Ii
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 23:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbXHUVEA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 17:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753890AbXHUVEA
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 17:04:00 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:60337 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966AbXHUVD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 17:03:59 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id DCCC5895D98;
	Tue, 21 Aug 2007 23:03:56 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 09682-06; Tue, 21 Aug 2007 23:03:56 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 963AF895D90;
	Tue, 21 Aug 2007 23:03:50 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id DC5789F16A;
	Tue, 21 Aug 2007 23:03:49 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id A74BF43F4; Tue, 21 Aug 2007 23:03:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070821202516.GL1070MdfPADPa@greensroom.kotnet.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56329>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Sven Verdoolaege <skimo@kotnet.org> [2007.08.21.2225 +0200]:
> >   FILES
>=20
> I'm not sure this is the most appropriate name for this section.

I was pondering this as well. BASIC CONCEPT might be better.

> >   Users who clone the project's repository need to initialize each
> >   submodule before they can work with it. By initializing
>=20
> I suppose this is implicit in the git submodule man page,

It wasn't to me; that's why I am doing all this.

Anyway, when it comes to documentation, I don't think redundancy
needs to be avoided as much as otherwise, don't you agree?

> but this is only true if you actually want to use git submodule to
> work with the submodules.

Is it? I tried this and after cloning a repo with submodules, it
created the submodule directories alright, but it did not actually
check them out/populate them, so they were empty.

> >   a submodule, the submodule's url is copied from the
> >   .gitmodules
>=20
> As I mentioned before, this is not strictly true. (see init::)

You're missing something like "... unless the submodule is already
registered, in which case it won't be overwritten", right?

> >   By pulling the submodule urls out of $GIT_DIR/config,
> >   git-submodule allows contributors to use different urls (e.g.
> >   via
>=20
> I'm not a native speaker, but to me that sounds like you are _not_
> using the urls in $GIT_DIR/config.  That is, I read that as: they
> are pulled out of $GIT_DIR/config (and then placed somewhere
> else).

Well, the sentence says what I wanted to say, but you're absolutely
right in that it could be improved. Something like

  Since git-submodule uses the urls in $GIT_DIR/config, which is
  a local configuration file, contributers are free to use urls
  different from the default (e.g. via ssh for those with accounts).

> Other than that, it's definitely an improvement.

Thanks,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"i like young girls. their stories are shorter."
                                                        -- tom mcguane
=20
spamtraps: madduck.bogus@madduck.net

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGy1M1IgvIgzMMSnURAlqCAKDMX4XRZmT2O88VYdBIXqS142TkdQCfWoet
1EwNXTOg8gvD2o8vJ97Y/gQ=
=MGxp
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
