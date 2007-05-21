From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Using git to store /etc, redux
Date: Mon, 21 May 2007 20:32:39 +0200
Message-ID: <20070521183239.GB5082@efreet.light.src>
References: <20070519174815.GA5124@hardeman.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Cc: git@vger.kernel.org
To: David =?utf-8?B?SMOkcmRlbWFu?= <david@hardeman.nu>
X-From: git-owner@vger.kernel.org Mon May 21 20:33:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqCgq-0007Ug-Vi
	for gcvg-git@gmane.org; Mon, 21 May 2007 20:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756510AbXEUSc5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 14:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756521AbXEUSc5
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 14:32:57 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:1830 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756510AbXEUSc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 14:32:56 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP  id 5203017.480812;
	Mon, 21 May 2007 20:32:40 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HqCgR-0001VV-A6; Mon, 21 May 2007 20:32:39 +0200
Content-Disposition: inline
In-Reply-To: <20070519174815.GA5124@hardeman.nu>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48039>


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 19, 2007 at 19:48:15 +0200, David H=C3=A4rdeman wrote:
> I recently had the idea to store and track /etc using git. When googling=
=20
> the topic I came across the "Using git to store /etc" thread from the=20
> end of last year which provided some interesting details on what would=20
> be necessary.
>=20
> It seems the file metadata (owner, group, mode, xattrs, etc) was the big=
=20
> stumbling point, so I wrote up a tool over the last few days which=20
> allows the metadata to be stored in a separate file which can be stored=
=20
> along with the rest of the data in the repo (or separately).
>=20
> This is also useful for tripwire type checks and for other types of=20
> storage which drops some of the metadata (tar comes to mind)...
>=20
> The tool (metastore) is available from:=20
> git://git.hardeman.nu/metastore.git
>=20
> Not completely cleaned up yet (it lacks a real README and some Makefile=
=20
> targets) but I hope it might be useful to others (it sure is to me).
>=20
> Please CC me on any replies.

Have you looked at IsiSetup (http://www.isisetup.ch/, linked from
http://git.or.cz/gitwiki/InterfacesFrontendsAndTools) yet? It's a front-end
to git specifically targeted for versioning configuration. From a quick
glance at it's web I don't see whether it already stores the metadata you
describe, but in either case it could be interesting for you.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGUeXHRel1vVwhjGURAp6zAJ9/jrXIsUlAkqgXT0+w+YOCXc1O2QCfV2dT
LwzpqV/bZ4aEHvYwYKLyvrI=
=v8qU
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
