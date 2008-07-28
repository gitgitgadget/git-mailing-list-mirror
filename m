From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a
	custom merge strategy
Date: Mon, 28 Jul 2008 20:14:24 +0200
Message-ID: <20080728181424.GM32057@genesis.frugalware.org>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Q9WauJOYVMCoee2"
Cc: Git Mailinglist <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Mon Jul 28 20:15:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNXG6-00057d-FR
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 20:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758099AbYG1SOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 14:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757754AbYG1SO3
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 14:14:29 -0400
Received: from virgo.iok.hu ([193.202.89.103]:57697 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757599AbYG1SOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 14:14:25 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 8A24A1B250C;
	Mon, 28 Jul 2008 20:14:24 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 043904465E;
	Mon, 28 Jul 2008 19:30:10 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 512B01190A0A; Mon, 28 Jul 2008 20:14:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90481>


--1Q9WauJOYVMCoee2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2008 at 04:54:17PM +0200, Sverre Rabbelier <alturin@gmail.c=
om> wrote:
> So, in short: what does the list think about adding
> "git-merge-theirs", that does (although possibly less 'hackish'):
>=20
> cat > git-merge-theirs << EOF
> #!/bin/sh
> eval git read-tree --reset -u \\\$\$#
> EOF

Isn't this the stupid one?

It's perfect for my testing needs, but this is not something that people
should ever use on a real repo.

--1Q9WauJOYVMCoee2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiODIAACgkQe81tAgORUJZM5QCcC7tgtSOlZ57YxhdPtln2Xw3V
URoAnjndyQDVX7VpKWc+3y/bg9CJ+9Og
=8fyN
-----END PGP SIGNATURE-----

--1Q9WauJOYVMCoee2--
