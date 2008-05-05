From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: git checkout -b -f v1.5.5.1
Date: Mon, 5 May 2008 17:58:30 +0200
Message-ID: <20080505155830.GC18443@leksak.fem-net>
References: <dcf6addc0805050848v91589c6i6c2fca168b7644d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Cc: git@vger.kernel.org
To: Jun Ma <sync.jma@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 05 18:00:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt37C-0008Pt-TY
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 18:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568AbYEEP7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 11:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754155AbYEEP7q
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 11:59:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:58271 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754064AbYEEP7q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 11:59:46 -0400
Received: (qmail invoked by alias); 05 May 2008 15:59:44 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp032) with SMTP; 05 May 2008 17:59:44 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+4Ckszj5e4dlGJRqtx1zdDIT+1xcy1ERXm6v1ISN
	BxvvgEd1LQ1SV/
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1Jt35C-0005vr-8u; Mon, 05 May 2008 17:58:30 +0200
Mail-Followup-To: Jun Ma <sync.jma@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <dcf6addc0805050848v91589c6i6c2fca168b7644d5@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81290>


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

>      I just mistaken 'git checkout -b 1.5.5.1 v1.5.5.1' to 'git
> checkout -b -f v1.5.5.1', and I don't how to delete it ,

Try
  git branch -D -- -f

>   537  git-branch -D -f
>   538  git-branch -D \-f
>   539  git-branch -D "\-f"
>=20
>      all the above operations were failed. :(

In all cases, git-branch gets -f as parameter, because your shell "expands"
them to -f.

> PS: Would it be better if we do checking on branch name to avoid this cas=
e?

What do you want to check for?
No leading dashes?

--=20
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIHy6mbt3SB/zFBA8RAoNJAKCPs31bwloq2Ityqr/nIs0Gi127JgCeMqiv
4bT7hA0jNY3bQzh/KwXunwA=
=qDY9
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
