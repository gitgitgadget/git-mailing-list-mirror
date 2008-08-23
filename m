From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Makefile: improve customization for supporting HP-UX
Date: Sat, 23 Aug 2008 22:26:01 +0200
Message-ID: <20080823202601.GF23800@genesis.frugalware.org>
References: <1219520484-7712-1-git-send-email-vmiklos@frugalware.org> <20080823200928.GA7185@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yIMHf/Pa6CzSkARF"
Cc: git@vger.kernel.org
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 22:27:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWzhW-00079e-QD
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 22:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbYHWU0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 16:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbYHWU0F
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 16:26:05 -0400
Received: from virgo.iok.hu ([193.202.89.103]:49804 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464AbYHWU0E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 16:26:04 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 369CF1B2537;
	Sat, 23 Aug 2008 22:26:02 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 911C74465E;
	Sat, 23 Aug 2008 21:27:45 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id E5542119003C; Sat, 23 Aug 2008 22:26:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080823200928.GA7185@schiele.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93487>


--yIMHf/Pa6CzSkARF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2008 at 10:09:28PM +0200, Robert Schiele <rschiele@gmail.co=
m> wrote:
> The systems I build on are:
>=20
> 1x HP-UX B.11.11 U 9000/785

This is the same version I'm using at the moment.

The NEEDS_LIBICONV is simple, the linker fails to find iconv symbols:

/usr/ccs/bin/ld: Unsatisfied symbols:
   libiconv (first referenced in libgit.a(utf8.o)) (code)
   libiconv_open (first referenced in libgit.a(utf8.o)) (code)
   libiconv_close (first referenced in libgit.a(utf8.o)) (code)
collect2: ld returned 1 exit status
gmake: *** [git] Error 1

The SNPRINTF_RETURNS_BOGUS is not something you can notice compile-time,
but once you try to commit, you get:

$ git commit
fatal: your vsnprintf is broken

--yIMHf/Pa6CzSkARF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiwclkACgkQe81tAgORUJbb+wCfSQL6asfM+7KCqI7iP56itfyM
xoUAn04Lqf7+6epYTv6xwuHjivd7eVK9
=fQ5y
-----END PGP SIGNATURE-----

--yIMHf/Pa6CzSkARF--
