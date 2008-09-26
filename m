From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] builtin-commit: avoid using reduce_heads()
Date: Fri, 26 Sep 2008 08:24:04 +0200
Message-ID: <20080926062404.GR23137@genesis.frugalware.org>
References: <20080925235029.GA15837@neumann> <1222389359-22191-1-git-send-email-vmiklos@frugalware.org> <20080926010312.GE6816@neumann>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yr6OvWOSyJed8q4v"
Cc: git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Sep 26 08:25:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj6lT-0000c4-7B
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 08:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342AbYIZGYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 02:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753291AbYIZGYI
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 02:24:08 -0400
Received: from virgo.iok.hu ([193.202.89.103]:32776 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886AbYIZGYH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 02:24:07 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 5AA791B25B5;
	Fri, 26 Sep 2008 08:24:04 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id DFEE64465E;
	Fri, 26 Sep 2008 08:24:05 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 2118811901A1; Fri, 26 Sep 2008 08:24:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080926010312.GE6816@neumann>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96829>


--yr6OvWOSyJed8q4v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2008 at 03:03:12AM +0200, SZEDER G=E1bor <szeder@ira.uka.de=
> wrote:
> Szia Mikl=F3s,

:)

> unfortunately it introduces a new one:  t7502-commit.sh
> fails at me with the following:
>=20
>=20
> *   ok 17: a SIGTERM should break locks
>=20
> * expecting success:=20
>=20
>         git rev-parse second master >expect &&
>         test_must_fail git merge second master &&
>         git checkout master g &&
>         EDITOR=3D: git commit -a &&
>         git cat-file commit HEAD | sed -n -e "s/^parent //p" -e
> "/^$/q" >actual &&
>         test_cmp expect actual

Uh-oh. I forgot to make test before git send-email. I'll have a look at
it later today.

--yr6OvWOSyJed8q4v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjcgAQACgkQe81tAgORUJYq0ACfUUGK0Fw6nK5tX62L9AbFqefE
ETgAn1L5Owu8GH2l9yg9cMYfh9BXPF/q
=gTbj
-----END PGP SIGNATURE-----

--yr6OvWOSyJed8q4v--
