From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] gitweb: use correct mime type even if filename has multiple dots.
Date: Tue, 19 Sep 2006 11:23:24 +0200
Message-ID: <20060919092324.GD31940@admingilde.org>
References: <20060916210933.GX17042@admingilde.org> <eehr7e$5i0$1@sea.gmane.org> <20060917075157.GY17042@admingilde.org> <7vejua7um3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 19 11:23:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPbpH-0004n0-LY
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 11:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbWISJX0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 05:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751717AbWISJX0
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 05:23:26 -0400
Received: from agent.admingilde.org ([213.95.21.5]:12732 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1751707AbWISJXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 05:23:25 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GPbp6-0001Qo-Cc; Tue, 19 Sep 2006 11:23:24 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vejua7um3.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27269>


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, Sep 17, 2006 at 01:41:40AM -0700, Junio C Hamano wrote:
>  - read in mime.types, sort the entries with length of the
>    suffixes (longer first);
>=20
>  - try matching the suffixes from longer to shorter and pick the
>    first match.
>=20
> Without that, you would not be able to cope with a /etc/mime.types
> that looks like this, no?
>=20
>         application/a	a
>         application/b	b.a
>=20
> Perhaps something like the attached.

works perfectly, thanks.

--=20
Martin Waitz

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFD7cMj/Eaxd/oD7IRAo4pAJ9NFsJxE8Si3sbf6pMe4l7GaSzf0gCeLTmn
sqARYtjf3KKlmGblzg4YDlA=
=R8CM
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--
