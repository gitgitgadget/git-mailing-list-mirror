From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] builtin-commit: avoid using reduce_heads()
Date: Mon, 29 Sep 2008 20:18:56 +0200
Message-ID: <20080929181856.GX23137@genesis.frugalware.org>
References: <20080925235029.GA15837@neumann> <m37i8y3mqt.fsf@localhost.localdomain> <20080926193122.GW23137@genesis.frugalware.org> <200809270151.51785.jnareb@gmail.com> <20080929150722.GU23137@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jFijuCULRDbBA23d"
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes.Schindelin@gmx.de
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 20:20:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkNMF-00062m-Hi
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 20:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756578AbYI2SS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 14:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756571AbYI2SS7
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 14:18:59 -0400
Received: from virgo.iok.hu ([193.202.89.103]:37937 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754279AbYI2SS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 14:18:58 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A5F3258142;
	Mon, 29 Sep 2008 20:18:56 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8F2324465E;
	Mon, 29 Sep 2008 20:18:56 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 7F5B411901A1; Mon, 29 Sep 2008 20:18:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080929150722.GU23137@genesis.frugalware.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97040>


--jFijuCULRDbBA23d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2008 at 05:07:22PM +0200, Miklos Vajna <vmiklos@frugalware.=
org> wrote:
> > Currently parents of merge commits are 'reduce(HEAD + MERGE_HEAD)'
> > in symbolic equation; I propose they would be simply 'MERGE_HEAD'.
> > then we set this branch to new commit
>=20
> Yes. Currently - after a merge conflict - you are able to check what
> heads caused were merged, which caused the conflict, but with this
> approach you would not be able to. I think this would be a step back...

Uh, I should read my mail before sending it next time.

I just wanted to say that in case, for example, I merge A^ and A, but I
get a conflict after octopus tried to merge A^ then it can be a useful
info to see that A^ was a head. Putting reduce(HEAD + MERGE_HEAD) to
MERGE_HEAD would hide this info, which would make the situation worse,
IMHO.

--jFijuCULRDbBA23d
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjhHBAACgkQe81tAgORUJZIRwCgjQ+cygo+5P2LrQuhu8iRaYcV
yjIAnAn2dKJgCBIMwq3NabV2FpI7+oRM
=XXVV
-----END PGP SIGNATURE-----

--jFijuCULRDbBA23d--
