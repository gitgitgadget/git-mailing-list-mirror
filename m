From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] gitweb: start to generate PATH_INFO URLs
Date: Sat, 30 Sep 2006 20:14:09 +0200
Message-ID: <20060930181408.GD2871@admingilde.org>
References: <20060929221641.GC2871@admingilde.org> <7v8xk2jofc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 30 20:14:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTjLr-0002eY-Dh
	for gcvg-git@gmane.org; Sat, 30 Sep 2006 20:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWI3SOL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 14:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWI3SOL
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 14:14:11 -0400
Received: from agent.admingilde.org ([213.95.21.5]:48269 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1751388AbWI3SOK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Sep 2006 14:14:10 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GTjLl-0004Q4-1W; Sat, 30 Sep 2006 20:14:09 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xk2jofc.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28146>


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Sep 29, 2006 at 03:30:47PM -0700, Junio C Hamano wrote:
> Martin Waitz <tali@admingilde.org> writes:
>=20
> > Instead of providing the project as a ?p=3D parameter it is simply appe=
nded
> > to the base URI.
> > All other parameters are appended to that, except for ?a=3Dsummary which
> > is the default and can be omitted.
>=20
> Supporting PATH_INFO in the sense that we do sensible things
> when we get called with one is one thing, but generating such a
> URL that uses PATH_INFO is a different thing.  I suspect not
> everybody's webserver is configured to call us with PATH_INFO,
> so this should be conditional.

right, and in fact it was more intended as a RFC, to see what
people think about such a thing.  Obviously I wanted to have
it for my repository, so I implemented it unconditional first.

Should we use the gitweb feature mechanism to enable/disable
PATH_INFO URL generation?

--=20
Martin Waitz

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFHrPwj/Eaxd/oD7IRAhCAAJ4+TgF8G3ei6+IRoXfuIJDPB/QadwCfW7qk
csK6nwDYXdbJlJsx0XKFeMo=
=W3xe
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
