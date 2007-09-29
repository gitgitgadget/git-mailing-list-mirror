From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] handle Docbook XSL 1.72 (incompletely)
Date: Sat, 29 Sep 2007 14:48:01 +0200
Message-ID: <20070929124801.GI18156@genesis.frugalware.org>
References: <bb5b640b0709201426u6ab77d07n6039499eb8baf381@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="64j1qyTOoGvYcHb1"
Cc: git@vger.kernel.org
To: Alexey Mahotkin <squadette@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 14:48:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibbjz-0006Nh-PF
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 14:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756013AbXI2MsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 08:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755952AbXI2MsG
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 08:48:06 -0400
Received: from virgo.iok.hu ([193.202.89.103]:36286 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755946AbXI2MsF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 08:48:05 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id BDFCC1B24FA;
	Sat, 29 Sep 2007 14:48:01 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 955C16FCF9;
	Sat, 29 Sep 2007 14:48:01 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 6159F13A4019; Sat, 29 Sep 2007 14:48:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bb5b640b0709201426u6ab77d07n6039499eb8baf381@mail.gmail.com>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59463>


--64j1qyTOoGvYcHb1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21, 2007 at 01:26:21AM +0400, Alexey Mahotkin <squadette@gmail.=
com> wrote:
> Fedora Core 7 has docbook-style-xsl-1.72.0-2.fc7
>=20
> git-diff manpage (and couple of more, using callouts) is broken here:
>=20
> EXAMPLES
>        Various ways to check your working tree
>=20
>                $ git diff            \fB(1)\fR
>                $ git diff --cached   \fB(2)\fR
>                $ git diff HEAD       \fB(3)\fR
>=20
>            .sp \fB1. \fRChanges in the working tree not yet staged for
> the next commit.

this is a bug in docbook-xsl. see
http://article.gmane.org/gmane.comp.version-control.git/54785

by the way, are gitlinks okay at you?

example: in the DESCRIPTION section:

"You can stage these changes by using git1[1]."

while the man branch has:

"You can stage these changes by using git-add(1)."

this is asciidoc 8.2.3 and docbook-xsl 1.73.2

thanks,
- VMiklos

--64j1qyTOoGvYcHb1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG/kmBe81tAgORUJYRAjT9AJ4gPOooVn1foT6txTIlf5fTQe9UfwCgn4y3
8Gfo0cy7bYVLdB7oB6DTd60=
=F+B8
-----END PGP SIGNATURE-----

--64j1qyTOoGvYcHb1--
