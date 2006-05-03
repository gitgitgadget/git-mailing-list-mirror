From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] Transitively read alternatives
Date: Wed, 3 May 2006 09:51:33 +0200
Message-ID: <20060503075133.GO20847@admingilde.org>
References: <20060501203631.GH20847@admingilde.org> <7v1wvdsbuj.fsf@assigned-by-dhcp.cox.net> <20060501225335.GI20847@admingilde.org> <20060502073847.GK20847@admingilde.org> <7v8xpjhguu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ijf6z65S790CMqo8"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 09:51:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbC94-0005B6-Ib
	for gcvg-git@gmane.org; Wed, 03 May 2006 09:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbWECHvf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 03:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbWECHvf
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 03:51:35 -0400
Received: from admingilde.org ([213.95.32.146]:46992 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S965047AbWECHvf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 03:51:35 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1FbC8z-0005PY-LY; Wed, 03 May 2006 09:51:33 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xpjhguu.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19456>


--ijf6z65S790CMqo8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, May 02, 2006 at 09:28:25PM -0700, Junio C Hamano wrote:
> > +	if (*entry !=3D '/' && relative_base) {
> > +		/* Relative alt-odb */
> > +		if (base_len < 0)
> > +			base_len =3D strlen(relative_base) + 1;
>=20
> Wouldn't base_len be always -1 here?

hmm, I just moved that part around.

> Maybe it is easier not to do the recursive thing unless the alternate
> is absolute path, and also as a purely safety measure, limit the
> maximum recursion depth to something low like 5, similar to recursive
> symlink resolution.

Agreed.
Lets see if I have some free time in the evening ;-)

--=20
Martin Waitz

--ijf6z65S790CMqo8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEWGEFj/Eaxd/oD7IRAss6AJwMpTW+XGZMhnT+jVXz56A7hiqhYgCfYYYS
VpvUQwLJqdF9pLqRqEC8TuQ=
=coft
-----END PGP SIGNATURE-----

--ijf6z65S790CMqo8--
