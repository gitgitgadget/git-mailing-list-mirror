From: Martin Waitz <tali@admingilde.org>
Subject: Re: Submodule object store
Date: Tue, 27 Mar 2007 17:53:06 +0200
Message-ID: <20070327155306.GQ22773@admingilde.org>
References: <1174930688.5662.20.camel@localhost> <20070326183523.GG22773@admingilde.org> <200703262133.44520.Josef.Weidendorfer@gmx.de> <20070326220302.GH22773@admingilde.org> <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net> <20070326231637.GJ22773@admingilde.org> <7vy7ljtwir.fsf@assigned-by-dhcp.cox.net> <20070326233603.GL22773@admingilde.org> <20070327112549.GA12178@informatik.uni-freiburg.de> <20070327115029.GC12178@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+gHRqQ1BTyNna/y8"
Cc: Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue Mar 27 17:53:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWDyy-0007bC-QQ
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 17:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbXC0PxJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 11:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbXC0PxJ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 11:53:09 -0400
Received: from mail.admingilde.org ([213.95.32.147]:55130 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932424AbXC0PxI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 11:53:08 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HWDys-0002WZ-HS; Tue, 27 Mar 2007 17:53:06 +0200
Content-Disposition: inline
In-Reply-To: <20070327115029.GC12178@informatik.uni-freiburg.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43276>


--+gHRqQ1BTyNna/y8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Mar 27, 2007 at 01:50:29PM +0200, Uwe Kleine-K=F6nig wrote:
> If you separate the odbs e.g by the pathname of the subproject, what
> happens if I choose to move the linux kernel in my embedded Linux
> project from /linux to /kernel/linux?

Then a new separate object database would have to be created.
This is the part I really don't like about separate object databases,
but perhaps some persistent alternates information could help here.

For any other way to separate the odb (project id, whatever), we
can't get a list of references into it by a path-limited traversal
in the parent. Thus separate odbs which are not bound to a special
location have some serious downsides.

> Or maybe worse:  If I currently track the Kernel in a tree (because of
> git lacking submodule support) and switch to submodule.  Then
> linux/Makefile has to exist in both the supermodule's and the
> submodule's odb.

Sorry, I don't understand you here.

--=20
Martin Waitz

--+gHRqQ1BTyNna/y8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGCT3ij/Eaxd/oD7IRAmSnAJ90zinJ8movLDN6iu0o5RHWzTHSpgCeMI6X
ZfzwVheUEb+EBnrGm2kcMjo=
=muXt
-----END PGP SIGNATURE-----

--+gHRqQ1BTyNna/y8--
