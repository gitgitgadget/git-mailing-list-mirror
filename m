From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Only use ETC_GITCONFIG=$(prefix)/etc/gitconfig ifeq ($(prefix),$(HOME))
Date: Mon, 23 Apr 2007 22:44:24 -0700
Message-ID: <462D9938.8020206@freedesktop.org>
References: <462D673A.1010805@freedesktop.org> <7vhcr6bdmk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEE813C3689215BC81D49BD74"
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 24 07:45:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgDpu-0001wr-P3
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 07:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161641AbXDXFpG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 01:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161637AbXDXFpG
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 01:45:06 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:39160 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161641AbXDXFpE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 01:45:04 -0400
Received: (qmail 30609 invoked from network); 24 Apr 2007 05:45:02 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail7.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <junkio@cox.net>; 24 Apr 2007 05:45:02 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <7vhcr6bdmk.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45413>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEE813C3689215BC81D49BD74
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Is this really necessary?
>=20
> I personally think distro people (or anybody who configures git
> for system-wide deployment for that matter) already has Makefile
> wrapper (a la debian/rules) to take care of this and other
> issues.

So did I.  Then I noticed (while stracing git to diagnose the issue with
git-add searching the whole working copy for .gitignore files) that the
Debian-packaged git looked for /usr/etc/gitconfig.  See
<http://bugs.debian.org/420675>.  Apparently few enough people use
/etc/gitconfig that nobody noticed and reported that it didn't work. :)

Why not make the defaults more resistant to broken configuration?

- Josh Triplett


--------------enigEE813C3689215BC81D49BD74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGLZk4GJuZRtD+evsRAkPuAJwPuoCIWADOTxee6qzr2lMkbOJgNwCgvmIV
WfzwunJ7dZUNJc05n59JWk8=
=QQYl
-----END PGP SIGNATURE-----

--------------enigEE813C3689215BC81D49BD74--
