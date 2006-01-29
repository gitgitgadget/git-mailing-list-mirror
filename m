From: Keith Packard <keithp@keithp.com>
Subject: Re: [Census] So who uses git?
Date: Sun, 29 Jan 2006 23:09:45 +1300
Message-ID: <1138529385.9919.185.camel@evo.keithp.com>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	 <1138446030.9919.112.camel@evo.keithp.com>
	 <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-y/Re3WEt3MDhn47Nuqgm"
Cc: cworth@cworth.org, keithp@keithp.com,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 29 11:12:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F39Xs-0005sH-CK
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 11:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWA2KMZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 05:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWA2KMZ
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 05:12:25 -0500
Received: from home.keithp.com ([63.227.221.253]:28677 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1750783AbWA2KMZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 05:12:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 6338F130022;
	Sun, 29 Jan 2006 02:12:16 -0800 (PST)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 05781-08; Sun, 29 Jan 2006 02:12:16 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1033)
	id EE2A2130021; Sun, 29 Jan 2006 02:12:15 -0800 (PST)
Received: from evo.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 786B914001;
	Sun, 29 Jan 2006 02:12:15 -0800 (PST)
Received: from keithp by evo.keithp.com with local (Exim 4.60)
	(envelope-from <keithp@keithp.com>)
	id 1F39VC-0001a0-20; Sun, 29 Jan 2006 23:09:46 +1300
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15210>


--=-y/Re3WEt3MDhn47Nuqgm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-01-28 at 13:08 -0800, Junio C Hamano wrote:
> Keith Packard <keithp@keithp.com> writes:
>=20
> > Once we're happy with the import, I'm pretty sure we'll just switch
> > cairo over to git and dump the CVS bits. X.org is a harder case, for
> > that I suspect we'll migrate individual modules over one at a time,
> > perhaps starting with the core X server pieces so that I can get my wor=
k
> > done, have it published in the main repository and not have it also
> > break everyone else's X server.
>=20
> Wow.......  You are switching Cairo and X.org from CVS to git?

We're not switching 'X.org', we're switching the X server core. X.org is
now broken into many separate projects, and each one will get to choose
SCM on their own. I expect to migrate the ones I maintain and use to
git, but migration of the dead code is unlikely to ever happen (and
there's lots of dead code)=20

> It could be that anything is better than CVS these days, but I
> have to admit that my jaw dropped after reading this, primarily
> because I've have never touched anything as big as X.
>=20
> Awestruck, dumbstruck,... Xstruck.  Yeah, I know I should have
> more faith in git.  Earlier I heard Wine folks are running git
> in parallel with CVS as their dual primary SCM now, and of
> course git is the primary SCM for the Linux kernel project.
>=20
> For things like the source code management, it takes a new
> software to be at least 10 times as good as the one that has
> been used, because switching _is_ a pain no matter how well tool
> helps the transition.  You have to transition not just the
> repository, but people who interact with it.

Fortunately, there are very few people involved with any specific piece
of the X.org distribution; there's really only one or two people
actively developing the X.org core server, so that part of the migration
will be easy. Our users will be stuck, but there aren't many of them
either, and git makes just sucking the current bits pretty easy.=20
=20
> When the Linux kernel switched, it was not that hard to be
> infinitely better than the previous one.  Because the previous
> one was no longer available to the kernel community; git did not
> have to be 10 times better on technical merits alone when the
> transition happened.

git really does look 10x better than CVS at this point; mostly social
issues are now blocking X development as weaker developers are refused
access to source code management to protect the project from damage. git
eliminates that barrier, and should let many new developers experiment
and share their results without affecting my work

> Can I hear experiences from other big projects that tried to use
> git [*1*]?  I suspect there are many that have tried, and I
> would not be surprised at all if git did not work out well for
> them.  For projects that already run on a (free) SCM, I would be
> very surprised if the developers find the current git 10 times
> better than the SCM they have been using (probably with an
> exception of CVS), unless they have very specific need, such as
> parallel development of distributed nature like the Linux
> kernel.

Everyone *wants* parallel distributed development, CVS prevents it.
And, remember that this is *not* a huge project, the core X server is
only 2M lines of source code. We separate out all of the drivers,
libraries and applications. Doing the migration in pieces allows us to
incrementally affect developers, and repair issues without suspending
all development.

I don't know of other huge projects moving to git; it's not all that
interesting as we know the tool is stable and will scale to support our
project already. Also, hg and bzr are not ready for production use in my
opinion; hg as it appears likely a flag day will be required before 1.0,
and bzr because they didn't focus on repository format, and have
suggested that they will switch to a hash-addressed scheme at some point
in the future...
 =20
--=20
keith.packard@intel.com

--=-y/Re3WEt3MDhn47Nuqgm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD3JRpQp8BWwlsTdMRAhTYAJ0TYVp4H7F5G/Up/SWOPOyXb0kI0wCcCGae
eyaWoER79Wyj6nHBPuyKOmY=
=LMfA
-----END PGP SIGNATURE-----

--=-y/Re3WEt3MDhn47Nuqgm--
