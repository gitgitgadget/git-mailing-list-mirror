From: Martin Waitz <tali@admingilde.org>
Subject: Re: Submodule object store
Date: Tue, 27 Mar 2007 01:55:27 +0200
Message-ID: <20070326235527.GM22773@admingilde.org>
References: <1174825838.12540.5.camel@localhost> <1174930688.5662.20.camel@localhost> <20070326183523.GG22773@admingilde.org> <200703262133.44520.Josef.Weidendorfer@gmx.de> <20070326220302.GH22773@admingilde.org> <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net> <20070326231637.GJ22773@admingilde.org> <7vy7ljtwir.fsf@assigned-by-dhcp.cox.net> <20070326233603.GL22773@admingilde.org> <Pine.LNX.4.63.0703261515330.14387@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QWRRbczYj8mXuejp"
Cc: Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: David Lang <david.lang@digitalinsight.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 01:55:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVz2F-0003po-FC
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 01:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933814AbXCZXzc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 19:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933815AbXCZXzc
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 19:55:32 -0400
Received: from mail.admingilde.org ([213.95.32.147]:40703 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933814AbXCZXzc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 19:55:32 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HVz2A-0003QC-DP; Tue, 27 Mar 2007 01:55:30 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703261515330.14387@qynat.qvtvafvgr.pbz>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43210>


--QWRRbczYj8mXuejp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, Mar 26, 2007 at 03:20:34PM -0800, David Lang wrote:
> >I want to be able to list all objects which are not reachable in the
> >object store, without traversing all submodules at the same time.
> >The only way I can think of to achieve this is to have one separate
> >object store per submodule and then do the traversal per submodule.
>=20
> why do you want to optimize for the relativly rare fsck function rather=
=20
> then the more common read functions (which would benifit from shareing=20
> object that are identical between projects)?

Because I don't know how to make it _possible_ for large repositories
otherwise.  Consider a Linux-distribution which handles each package
as one submodule.

I don't think that it's too much balanced towards fsck.
The separated object store also helps reduce the memory requirement for
large pushs/pulls.
Sharing objects can be achieved by alternates if you want.
If someone comes up with a nice way to handle everything in one big
object store I would happily use that! :-)

--=20
Martin Waitz

--QWRRbczYj8mXuejp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGCF1vj/Eaxd/oD7IRAp+SAJ44GGvj6wzbmj9gmn+nw1ZtQvmKpgCeJx7D
th4Jb1JWPgM3JYJId4AOE9w=
=HXoa
-----END PGP SIGNATURE-----

--QWRRbczYj8mXuejp--
