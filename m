From: Timo Sirainen <tss@iki.fi>
Subject: Re: [PATCH 1/3] Added generic string handling code.
Date: Wed, 23 May 2007 16:56:50 +0300
Message-ID: <1179928610.32181.1707.camel@hurina>
References: <1179627869.32181.1284.camel@hurina>
	 <20070522134007.GK4489@pasky.or.cz> <1179917386.32181.1643.camel@hurina>
	 <20070523132429.GM4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dE1uIYM+Rcc/Vi0VVFx3"
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed May 23 15:57:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqrLE-0003yc-Ut
	for gcvg-git@gmane.org; Wed, 23 May 2007 15:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764249AbXEWN4y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 09:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764327AbXEWN4x
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 09:56:53 -0400
Received: from dovecot.org ([82.118.211.50]:39389 "EHLO dovecot.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1764249AbXEWN4w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 09:56:52 -0400
Received: from [192.168.10.2] (82-203-162-146.dsl.gohome.fi [82.203.162.146])
	by dovecot.org (Postfix) with ESMTP id 46D8DFA8A32;
	Wed, 23 May 2007 16:56:51 +0300 (EEST)
In-Reply-To: <20070523132429.GM4489@pasky.or.cz>
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48155>


--=-dE1uIYM+Rcc/Vi0VVFx3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-23 at 15:24 +0200, Petr Baudis wrote:
> > > > +void _str_append(struct string *str, const char *cstr)
> > >=20
> > > _ is reserved namespace.
> >=20
> > I remember __ is, but was _ too? A lot of programs are using that. :)
>=20
> C99 7.1.3 says that
>=20
>    -- All identifiers that begin with an underscore are always reserved
> for use as identifiers with file scope in both the ordinary and tag name
> spaces.
>=20
> Hmm, this _is_ file scope, right?

Right. I'll start changing my practices. Although grepping
under /usr/include shows that there are a lot of other software that
doesn't respect it either (X11, MySQL, OpenSSL at least).


--=-dE1uIYM+Rcc/Vi0VVFx3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGVEgiyUhSUUBViskRApWdAJ40KCApDqfjxeK/YowpFXZNb+XrgACdE1uR
IC1AppmA6FvOOPbmbSl10nE=
=ybHH
-----END PGP SIGNATURE-----

--=-dE1uIYM+Rcc/Vi0VVFx3--
