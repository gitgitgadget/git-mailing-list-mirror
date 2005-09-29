From: Elfyn McBratney <beu@gentoo.org>
Subject: Re: [PATCH] Cogito README: add a block describing team workflow with git+ssh
Date: Thu, 29 Sep 2005 23:19:26 +0100
Message-ID: <20050929221926.GB13542@zippy.emcb.local>
References: <11279754774179-git-send-email-martin@catalyst.net.nz> <20050929212511.GA28106@zippy.emcb.local> <46a038f905092914524d3cd8c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 00:21:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL6kW-00073K-TV
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 00:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbVI2WTa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 18:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbVI2WTa
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 18:19:30 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:21766 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S932142AbVI2WT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 18:19:29 -0400
Received: from beu1.demon.co.uk ([83.105.51.149] helo=zippy)
	by anchor-post-35.mail.demon.net with smtp (Exim 4.42)
	id 1EL6ev-0009LC-Gc; Thu, 29 Sep 2005 22:13:45 +0000
Received: by zippy (sSMTP sendmail emulation); Thu, 29 Sep 2005 23:19:26 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
Mail-Followup-To: Elfyn McBratney <beu@gentoo.org>,
	Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46a038f905092914524d3cd8c1@mail.gmail.com>
User-Agent: mutt-ng/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9521>


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 30, 2005 at 09:52:11AM +1200, Martin Langhoff wrote:
 > On 9/30/05, Elfyn McBratney <beu@gentoo.org> wrote:
 > > > +        $ chgroup gitcommit /var/git
 > >
 > > s/chgroup/chgrp/
 >=20
 > Ooops! Thanks for catching that

Np :)

 > > > +        $ chmod  2775 /var/git
 > > > +        $ mkdir -p /var/git/projectname.git
 > > > +        $ GIT_DIR=3D/var/git/projectname.git git-init-db
 > >
 > > Hmm .. if you're you're going to be using cogito anyway, might it be an
 > > idea to instead do:
 > >
 > >         $ GIT_DIR=3D/var/git/projectname.git/.git cg-init [-I]
 >=20
 > You only really need git on the repo server, and I think that's a plus.

*nods*

 > > > +        $ git-push  remoteserver:/var/git/projectname.git master br=
anchname
 > >
 > > Ditto here, tho' that'll require that remotes have been set-up, of
 > > course. ;)
 >=20
 > Yes, the cogito way of doing this seems messy. Is there a simple way
 > to set up the remote branch and push to it?

Not that I know of, tho' I'm still quite new to cogito, mind. ;)

Best,
Elfyn

--=20
Elfyn McBratney
Gentoo Developer/Perl Team Lead
beu/irc.freenode.net                            http://dev.gentoo.org/~beu/
+------------O.o--------------------- http://dev.gentoo.org/~beu/pubkey.asc

PGP Key ID: 0x69DF17AD
PGP Key Fingerprint:
  DBD3 B756 ED58 B1B4 47B9  B3BD 8D41 E597 69DF 17AD

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDPGhtjUHll2nfF60RAhkpAJ0S4Dr6uyhuQTRqtNrLlIPo8ssr2ACeJp/B
+YI/IdeRdq8+SaKTyG58f34=
=WkRY
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
