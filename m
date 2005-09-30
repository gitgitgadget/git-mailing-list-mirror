From: Elfyn McBratney <beu@gentoo.org>
Subject: [COGITO] cg-status in an empty repo spits out git-diff-index usage info
Date: Fri, 30 Sep 2005 19:18:09 +0100
Message-ID: <20050930181809.GB13582@emcb.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Cc: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Sep 30 20:21:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELPSr-00061y-MM
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 20:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbVI3SSV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 14:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbVI3SSU
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 14:18:20 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:35334 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S932576AbVI3SSK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 14:18:10 -0400
Received: from beu1.demon.co.uk ([83.105.51.149] helo=emcb.local)
	by anchor-post-35.mail.demon.net with esmtp (Exim 4.42)
	id 1ELPMx-000FVD-H4; Fri, 30 Sep 2005 18:12:27 +0000
Received: by emcb.local (Postfix, from userid 1001)
	id 3EE3E148040; Fri, 30 Sep 2005 19:18:09 +0100 (BST)
To: git mailing list <git@vger.kernel.org>
Mail-Followup-To: Elfyn McBratney <beu@gentoo.org>,
	git mailing list <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
Organisation: Gentoo Foundation, Inc.
User-Agent: mutt-ng/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9570>


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Re-sending ..]

Hello Petr, git list,

A `cg-status` in an empty repo (i.e., straight after a `cg-init -I`)
spits out git-diff-index usage information, a la:

	[($) 09:03:42] beu@zippy ~/git/test
	> cg-status
	Heads:
	    >master
	   =20
	    usage: git-diff-index [-m] [--cached] [<common diff options>] <tree-is=
h> [<path>...]
	    common diff options:
	    [...]

which I'm guessing isn't expected behaviour ;)  `git status` does the
same, FWIW.  I'm having a look around to try and figure out why, and
will try to work up a patch to fix it, but in case I don't find the bug
(or feature ;), consider this a heads-up. :)

(And I've just used gitk for the first time, too, and I must say it's
one invaluable piece of software !  Kudos to it's creators :)

This is with latest cogito.git (b06f2a707963c8712f7a6bbd4b89bae758bcf92a,
though the 'bug' is also present in 0.15.1) with git 0.99.7d.

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

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDPYFhjUHll2nfF60RAiivAJwNJepg6gnq/dN0DlQYLRfstY0D0ACgjQh8
wzSOan4qJTL1Hm2lkznoI6g=
=tg7J
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
