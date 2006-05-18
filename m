From: "Fernando J. Pereda" <ferdy@ferdyx.org>
Subject: Re: Shipping man pages?
Date: Thu, 18 May 2006 10:10:37 +0200
Message-ID: <20060518081037.GA8731@ferdyx.org>
References: <20060518074630.GA2994@code-monkey.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 10:10:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fgdaq-0003z6-8Z
	for gcvg-git@gmane.org; Thu, 18 May 2006 10:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWERIKp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 04:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWERIKp
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 04:10:45 -0400
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:55201
	"EHLO smtp.ferdyx.org") by vger.kernel.org with ESMTP
	id S1751190AbWERIKo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 04:10:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id 4C6158D30A;
	Thu, 18 May 2006 10:10:33 +0200 (CEST)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 13168-03; Thu, 18 May 2006 10:10:30 +0200 (CEST)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id DA2858D305;
	Thu, 18 May 2006 10:10:29 +0200 (CEST)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@ferdyx.org; Thu, 18 May 2006 10:10:38 +0200 (CEST)
To: Tilman Sauerbeck <tilman@code-monkey.de>
Mail-Followup-To: "Fernando J. Pereda" <ferdy@ferdyx.org>,
	Tilman Sauerbeck <tilman@code-monkey.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060518074630.GA2994@code-monkey.de>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20272>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2006 at 09:46:32AM +0200, Tilman Sauerbeck wrote:
> Hi,
> atm, the git release tarballs don't contain man pages. They can be
> generated from the asciidoc source files, which makes the build depend
> on python and asciidoc.
>=20
> That's *very* inconvenient; would it be possible to include the man
> pages in the release tarball?
>=20
> Or maybe offer them in a separate tarball?

Hi Tilman,

Actually Junio has 'html' and 'man' branches in his git.git repository
so you just have to use git tar-tree on them.

I do this for the Gentoo packages, you can grab a tarball from any of
our mirrors, the files are called git-{html,man}-VERSION.tar.bz2

- ferdy

--=20
Fernando J. Pereda Garcimart=EDn
Gentoo Developer (Alpha,net-mail,mutt,git)
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEbCv9CkhbDGC9KNQRAiRMAJwK40mgEJ4MqapLitcl6nkyeyk9CwCgjsTM
50qqnSC659exEtR5WRDRdow=
=dAot
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
