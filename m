From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: gitweb index performance (Re: [PATCH] gitweb: support the
	rel=vcs-* microformat)
Date: Fri, 9 Jan 2009 01:16:47 +0100
Message-ID: <20090109001647.GI21154@genesis.frugalware.org>
References: <20090107042518.GB24735@gnu.kitenet.net> <gk2794$djn$1@ger.gmane.org> <20090107155023.GA16540@gnu.kitenet.net> <cb7bb73a0901071003m77482a99wf6f3988beb5b5e78@mail.gmail.com> <20090107184515.GB31795@gnu.kitenet.net> <20090107190238.GA3909@gnu.kitenet.net> <20090107232427.GA18958@gnu.kitenet.net> <gk4bk5$9dq$1@ger.gmane.org> <20090108195446.GB18025@gnu.kitenet.net> <496691EC.1070805@eaglescrag.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JTJq4mKM0qXghaEa"
Cc: Joey Hess <joey@kitenet.net>
To: "J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 09 01:18:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL55N-0006RU-4a
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 01:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763649AbZAIAQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 19:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759735AbZAIAQv
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 19:16:51 -0500
Received: from virgo.iok.hu ([212.40.97.103]:35485 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755622AbZAIAQu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 19:16:50 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id BCC1058099;
	Fri,  9 Jan 2009 01:16:49 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id D2C0A4465E;
	Fri,  9 Jan 2009 01:16:47 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id F0F8711B8630; Fri,  9 Jan 2009 01:16:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <496691EC.1070805@eaglescrag.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JTJq4mKM0qXghaEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 08, 2009 at 03:53:16PM -0800, "J.H." <warthog19@eaglescrag.net>=
 wrote:
> Look at either Lea's or my caching engines, it will help dramatically on=
=20
> something of that size.

repo.or.cz uses a single patch for caching the project list only:

http://repo.or.cz/w/git/repo.git?a=3Dcommit;h=3D152fb0b22d36c6981ac3c4403b6=
9ad91b27a1bc6

you are probably better off with such a small patch instead of using a
gitweb fork.

--JTJq4mKM0qXghaEa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklml28ACgkQe81tAgORUJbdZwCdEi+nE+zj6k5ZV3pIjr5h78wV
0oIAn2c1h1h/mzizHtPB5YeqkKpjYruE
=pZiN
-----END PGP SIGNATURE-----

--JTJq4mKM0qXghaEa--
