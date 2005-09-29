From: Elfyn McBratney <beu@gentoo.org>
Subject: Re: [PATCH] Cogito README: add a block describing team workflow with git+ssh
Date: Thu, 29 Sep 2005 22:25:11 +0100
Message-ID: <20050929212511.GA28106@zippy.emcb.local>
References: <11279754774179-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Sep 29 23:27:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL5u2-0001T9-NK
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 23:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbVI2VZP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 17:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbVI2VZO
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 17:25:14 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:44557 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751335AbVI2VZN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 17:25:13 -0400
Received: from beu1.demon.co.uk ([83.105.51.149] helo=zippy)
	by anchor-post-35.mail.demon.net with smtp (Exim 4.42)
	id 1EL5oQ-0001zY-I7; Thu, 29 Sep 2005 21:19:30 +0000
Received: by zippy (sSMTP sendmail emulation); Thu, 29 Sep 2005 22:25:11 +0100
To: git@vger.kernel.org
Mail-Followup-To: Elfyn McBratney <beu@gentoo.org>, git@vger.kernel.org,
	Martin Langhoff <martin@catalyst.net.nz>
Content-Disposition: inline
In-Reply-To: <11279754774179-git-send-email-martin@catalyst.net.nz>
User-Agent: mutt-ng/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9512>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 29, 2005 at 06:31:17 +1200, Martin Langhoff wrote:
> The README doesn't talk about teams with "peer" access to a shared repo.
> It took me a while to figure our the /right/ way to do it. Document for
> future generations and general happiness.
>=20
> Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>
> [...]
>=20
> +        $ chgroup gitcommit /var/git

s/chgroup/chgrp/

> +        $ chmod  2775 /var/git
> +        $ mkdir -p /var/git/projectname.git
> +        $ GIT_DIR=3D/var/git/projectname.git git-init-db

Hmm .. if you're you're going to be using cogito anyway, might it be an
idea to instead do:

	$ GIT_DIR=3D/var/git/projectname.git/.git cg-init [-I]

?

> +Note: All the developers with "commit" access must belong to the gitcomm=
it
> +group and have a 002 umask on the remote server.
> +
> +Going back to your Cogito working copy, run=20
> +
> +        $ git-push  remoteserver:/var/git/projectname.git master branchn=
ame

Ditto here, tho' that'll require that remotes have been set-up, of
course. ;)

Anyhow, nice howto - thanks. :)

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

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDPFu3jUHll2nfF60RAvWMAKCk3QwpHolb2otUPOhjvNuZhyuTpACfcMOB
LHzoQSsTEA6d6tLG4bB35sk=
=zFz+
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
