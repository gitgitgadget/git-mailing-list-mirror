From: Martin Waitz <tali@admingilde.org>
Subject: Re: gitweb testing with non-apache web server
Date: Thu, 3 Aug 2006 22:14:34 +0200
Message-ID: <20060803201434.GB5476@admingilde.org>
References: <20060803075403.GA5238@buici.com> <easbev$act$1@sea.gmane.org> <20060803153403.GA30729@buici.com> <eat5qp$3sr$1@sea.gmane.org> <7vfygdr888.fsf@assigned-by-dhcp.cox.net> <eatfog$8er$1@sea.gmane.org> <7virl9ppy7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 03 22:15:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8jal-0001D6-Ul
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 22:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbWHCUOh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 16:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbWHCUOg
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 16:14:36 -0400
Received: from admingilde.org ([213.95.32.146]:37510 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S932555AbWHCUOg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 16:14:36 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1G8jaU-00035g-Mn; Thu, 03 Aug 2006 22:14:34 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virl9ppy7.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24752>


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Thu, Aug 03, 2006 at 12:41:20PM -0700, Junio C Hamano wrote:
> 	http://www.kernel.org/git/?p=3Dgitk/gitk.git;a=3Dsummary
>=20
> (that's two insertions of 'k').
>=20
> Now with PATH_INFO, how exactly is this easier?

well, editing is not easier, but you can do other nice things.

On git.admingilde.org I have set up apache to serve the contents
of my git repositories for all the well-known git repository
URLs (*.git/objects/*, *.git/refs/*, ...) and to call gitweb for
all other URLs.
That way I get the exact same URLs for both gitweb and http:// clone
(and even for git://, just change the protocol name).

I really think that it is very handy that you can give out a
repository URL and any user can just click on it and get the
summary page of this project.

I'm sure that it is possible to transfer the PATH_INFO into a p=3D
parameter through URL rewrite rules, but it is much easier
to set up if gitweb can directly grok appended paths.

I even changed the old gitweb to hand out links which used PATH_INFO
rather than the p=3D parameter so that the URLs looked nicer.
If there is interest in such a feature then I can do these changes
again.

--=20
Martin Waitz

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE0lkqj/Eaxd/oD7IRAjTgAJ9LBA9BuKrz6djBduOrokeXY35vpgCfTjn4
NyRNKdeU3v/Ln12CMSSUBgQ=
=pB8A
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
