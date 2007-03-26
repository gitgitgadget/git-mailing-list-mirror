From: Martin Waitz <tali@admingilde.org>
Subject: Re: Submodule object store
Date: Tue, 27 Mar 2007 01:36:03 +0200
Message-ID: <20070326233603.GL22773@admingilde.org>
References: <1174825838.12540.5.camel@localhost> <1174930688.5662.20.camel@localhost> <20070326183523.GG22773@admingilde.org> <200703262133.44520.Josef.Weidendorfer@gmx.de> <20070326220302.GH22773@admingilde.org> <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net> <20070326231637.GJ22773@admingilde.org> <7vy7ljtwir.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVcIhgQsEzAXu06J"
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 01:36:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVyjh-0002NW-J3
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 01:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933796AbXCZXgH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 19:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933788AbXCZXgH
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 19:36:07 -0400
Received: from mail.admingilde.org ([213.95.32.147]:40874 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933804AbXCZXgF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 19:36:05 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HVyjM-0003Gm-0e; Tue, 27 Mar 2007 01:36:04 +0200
Content-Disposition: inline
In-Reply-To: <7vy7ljtwir.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43207>


--EVcIhgQsEzAXu06J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2007 at 04:28:28PM -0700, Junio C Hamano wrote:
> Martin Waitz <tali@admingilde.org> writes:
>=20
> > To make purge and fsck work we have the hard requirement that it
> > must be possible to list all objects which belong to one submodule.
>=20
> I understand you would want to separate the ref namespace, but I
> still do not see why you would want to have a separate object
> store, laid out in a funny way.  Unless you are thinking about
> using rsync to transfer object store, that is.

I want to be able to list all objects which are not reachable in the
object store, without traversing all submodules at the same time.
The only way I can think of to achieve this is to have one separate
object store per submodule and then do the traversal per submodule.

--=20
Martin Waitz

--EVcIhgQsEzAXu06J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGCFjjj/Eaxd/oD7IRAjG7AJ0cGMQy1jBqM3koc5r7XklJfKdicACfax5j
n15zp53LdHTJJpfxs5R906Y=
=v7zY
-----END PGP SIGNATURE-----

--EVcIhgQsEzAXu06J--
