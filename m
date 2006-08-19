From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] gitweb: use common parameter parsing and generation for "o", too.
Date: Sat, 19 Aug 2006 20:33:03 +0200
Message-ID: <20060819183303.GC30022@admingilde.org>
References: <11557673213372-git-send-email-tali@admingilde.org> <ec1d6q$823$2@sea.gmane.org> <20060817191300.GA11477@admingilde.org> <200608172134.38751.jnareb@gmail.com> <20060818202013.GB30022@admingilde.org> <ec6qnp$aal$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 19 20:33:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEVdA-0008Vs-Mj
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 20:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbWHSSdF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 14:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbWHSSdF
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 14:33:05 -0400
Received: from agent.admingilde.org ([213.95.21.5]:1170 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1751765AbWHSSdE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Aug 2006 14:33:04 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GEVd1-0002er-ME; Sat, 19 Aug 2006 20:33:03 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ec6qnp$aal$1@sea.gmane.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25731>


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sat, Aug 19, 2006 at 12:55:57PM +0200, Jakub Narebski wrote:
> > Perhaps introduce a new function which is used to access the parameters?
> > This new function could check the URL or CGI->param or whatever and then
> > return the requested value.
>=20
> CGI->param. There is no reason to duplicate CGI module.

yes there is.
using CGI->param it is not possible to use nice URLs ala
http://git.site.org/projectpath.git

I would really appreciate to be able to use nice URLs in gitweb that
correspond to the repository URL.

--=20
Martin Waitz

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE51lfj/Eaxd/oD7IRAoZbAJ47BrHsKPjavv6JrAtv+z4mD7v7iQCcDZxG
aoTJn7FErb1Kw7QgoZMv02U=
=Xuhv
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
