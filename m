From: Martin Waitz <tali@admingilde.org>
Subject: Re: Submodule object store
Date: Tue, 27 Mar 2007 17:46:14 +0200
Message-ID: <20070327154614.GP22773@admingilde.org>
References: <1174825838.12540.5.camel@localhost> <1174930688.5662.20.camel@localhost> <20070326183523.GG22773@admingilde.org> <200703262133.44520.Josef.Weidendorfer@gmx.de> <20070326220302.GH22773@admingilde.org> <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net> <20070326231637.GJ22773@admingilde.org> <7vy7ljtwir.fsf@assigned-by-dhcp.cox.net> <20070326233603.GL22773@admingilde.org> <20070327112549.GA12178@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/UvyDgxjlFfP/4zZ"
Cc: Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue Mar 27 17:46:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWDsM-0004U6-RQ
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 17:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbXC0PqR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 11:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbXC0PqR
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 11:46:17 -0400
Received: from mail.admingilde.org ([213.95.32.147]:58388 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932189AbXC0PqP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 11:46:15 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HWDsE-0002SJ-Ff; Tue, 27 Mar 2007 17:46:14 +0200
Content-Disposition: inline
In-Reply-To: <20070327112549.GA12178@informatik.uni-freiburg.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43275>


--/UvyDgxjlFfP/4zZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Mar 27, 2007 at 01:25:49PM +0200, Uwe Kleine-K=F6nig wrote:
> Martin Waitz wrote:
> > I want to be able to list all objects which are not reachable in the
> > object store, without traversing all submodules at the same time.
> > The only way I can think of to achieve this is to have one separate
> > object store per submodule and then do the traversal per submodule.
> I might have understood something wrongly, but to list objects that are
> not reachable you need to traverse all trees anyhow, don't you. =20
>=20
> Then how big is the difference between a directory and an submodule?
> I'd expect it's not so big if the submodules included in different
> revisions of the supermodule share most of their history.  Of course you
> need to exploit that.  Thinking again that might be the problem?

there is no big difference, only that the submodule may be huge by
itself.

And yes, every object has to be traversed anyhow, but not neccessarily by
the same process and at the same time.

--=20
Martin Waitz

--/UvyDgxjlFfP/4zZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGCTxGj/Eaxd/oD7IRAm0bAJ9L4FFAyK83/kvg6k0zVxwaXeEinACcDOPG
b4BSa1zu3GXIWwwPEHJyYgo=
=/+lu
-----END PGP SIGNATURE-----

--/UvyDgxjlFfP/4zZ--
