From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 10 Jun 2007 10:50:44 +0200
Message-ID: <20070610085044.GD4084@efreet.light.src>
References: <20070603114843.GA14336@artemis> <20070609121244.GA2951@artemis> <46a038f90706092359i43a6e834rc096e53a28fbee51@mail.gmail.com> <7v4plgb6t6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 10:50:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxJ8L-00065R-8u
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 10:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbXFJIus (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 04:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbXFJIus
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 04:50:48 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:47321 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940AbXFJIur (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 04:50:47 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 59157572AB;
	Sun, 10 Jun 2007 10:50:45 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HxJ8G-0000BV-7k; Sun, 10 Jun 2007 10:50:44 +0200
Content-Disposition: inline
In-Reply-To: <7v4plgb6t6.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49686>


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 10, 2007 at 00:35:33 -0700, Junio C Hamano wrote:
> "Martin Langhoff" <martin.langhoff@gmail.com> writes:
> > So you can tell your bugtracker
> > - which commit fixed it -- usually auto-linked if you include the
> > bugnumber in the commit message
> > - which commit added the test -- auto linked as above
> > - which commit introduced the bug -- if such thing exists and someone
> > digs it up
>=20
> All of your examples are going from a single bug to commits, but
> from a release person's point of view, you are never interested
> in a single bug, just like a top-level maintainer is never
> interested in a single file.  A release person would want to go
> in the reverse direction: from a commit range to a set of bugs.
> What bugs were fixed and what regressions were introduced during
> this release cycle.  While embedded ticket numbers in commit log
> messages would certainly help, a change made to fix a particular
> bug may fix another as its side effect, and the develeoper who
> did the change may not know about the latter when the commit log
> message is written.

It would be really useful to have a tool, that could link a bug report to
a test case demonstrating it and reporting whenever output of that test case
changes. This would make it much easier for developer to see which bugs he
might have fixed when doing a refactoring.

It should probably report not just unexpected success, but also change to t=
he
error output, because the test case does not have to be 100% correct. That =
is
if you have a test case that prints:
  testFoobar FAIL "foo" !=3D "Bar"
and than starts to say:
  testFoobar FAIL "foo" !=3D "Foo"
the problem is probably fixed, but the test still fails because of minor
error in the expected output string.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGa7tkRel1vVwhjGURAj0ZAKC++d3FvCRYFy8FxI/UqfjEAAmRigCggrCN
7tDe/VHiww3lDYFHR8nLsX0=
=hZZ/
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
