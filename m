From: Keith Packard <keithp@keithp.com>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Thu, 23 Mar 2006 22:12:58 -0800
Message-ID: <1143180778.6850.55.camel@neko.keithp.com>
References: <20060322133337.GU20746@lug-owl.de>
	 <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org>
	 <Pine.LNX.4.64.0603221607580.26286@g5.osdl.org>
	 <Pine.LNX.4.64.0603221717120.26286@g5.osdl.org>
	 <20060323200306.GG31387@lug-owl.de>  <20060324003944.GA28652@pe.Belkin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-50VyWrdbehkogJK4j0KN"
Cc: keithp@keithp.com, Jan-Benedict Glaw <jbglaw@lug-owl.de>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 07:15:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMfaA-0008ER-Ao
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 07:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423181AbWCXGO3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 01:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423163AbWCXGN4
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 01:13:56 -0500
Received: from home.keithp.com ([63.227.221.253]:24594 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1423181AbWCXGNa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 01:13:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 922FC130020;
	Thu, 23 Mar 2006 22:13:23 -0800 (PST)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 15087-01-4; Thu, 23 Mar 2006 22:13:23 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1033)
	id 47DFB13001F; Thu, 23 Mar 2006 22:13:23 -0800 (PST)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id ECA3B14001;
	Thu, 23 Mar 2006 22:13:22 -0800 (PST)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 212D76AC1BF; Thu, 23 Mar 2006 22:13:00 -0800 (PST)
To: Chris Shoemaker <c.shoemaker@cox.net>
In-Reply-To: <20060324003944.GA28652@pe.Belkin>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17899>


--=-50VyWrdbehkogJK4j0KN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-03-23 at 19:39 -0500, Chris Shoemaker wrote:
> On Thu, Mar 23, 2006 at 09:03:06PM +0100, Jan-Benedict Glaw wrote:
> > On Wed, 2006-03-22 17:28:23 -0800, Linus Torvalds <torvalds@osdl.org> w=
rote:
> > > On Wed, 22 Mar 2006, Linus Torvalds wrote:
> > > > This one-liner to cvsps.c seems to make sure we have an ancestor br=
anch=20
> > > > for that "gdb-4.18-branch" branch, at least according to the cvsps =
output.=20
> > >=20
> > > The "git cvsimport" is still running, but at least it seems to be hap=
pily=20
> > > running further past the point it broke earlier.
> >=20
> > I've started it once again, too, with the one-liner added to Debian
> > unstable's version of cvsps:
> >=20
> > It seems there's a patch like
> > http://www.gelato.unsw.edu.au/archives/git/0602/16278.html is missing?
> > ...or we need a better cvsps.  Shall I add it and try again / try to
> > continue, or give up on it for now?  Though it would be nice to have
> > these two large and important source trees under GIT control :-)

I'm busy writing a new import tool to get X into git; I've got it
generating complete revision trees in memory, and dumping them in
graphviz form. I'd sure be interested to see how well this works with
other ancient and broken CVS trees. Once I've got it dealing with
current X.org CVS correctly (or, at least, reasonably), I'll finish it
up and get it to actually generate the repository.

git://git.freedesktop.org/~keithp/parsecvs

Usage is completely lame at present -- a list of ,v file names either on
the command line or via stdin (one name per line). The .dot file is
output on stdout, with some diagnostics on stderr.

Pipe this through 'dot -Tsvg' and you'll get a .svg file which can be
viewed with inkscape. They're generally immense...

--=20
keith.packard@intel.com

--=-50VyWrdbehkogJK4j0KN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEI43qQp8BWwlsTdMRAmN5AJ4xkHesW4lQyNceOB9nZa8vQkJLZQCePNgi
Wfmg3iQ7QOSTRprLvaA2RNU=
=0zx/
-----END PGP SIGNATURE-----

--=-50VyWrdbehkogJK4j0KN--
