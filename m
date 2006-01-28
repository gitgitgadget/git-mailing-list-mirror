From: Keith Packard <keithp@keithp.com>
Subject: Re: LCA06 Cogito/GIT workshop - (Re: git-whatchanged: exit out
	early on errors)
Date: Sun, 29 Jan 2006 00:00:30 +1300
Message-ID: <1138446030.9919.112.camel@evo.keithp.com>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ij75MFA1npTIPZUQ7KfM"
Cc: keithp@keithp.com, Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 28 12:01:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2npF-0002TO-FD
	for gcvg-git@gmane.org; Sat, 28 Jan 2006 12:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWA1LAr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jan 2006 06:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWA1LAr
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jan 2006 06:00:47 -0500
Received: from home.keithp.com ([63.227.221.253]:60427 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S932313AbWA1LAr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jan 2006 06:00:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id E263C130021;
	Sat, 28 Jan 2006 03:00:37 -0800 (PST)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 27896-04; Sat, 28 Jan 2006 03:00:37 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1033)
	id 854F7130020; Sat, 28 Jan 2006 03:00:37 -0800 (PST)
Received: from evo.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 04C3014001;
	Sat, 28 Jan 2006 03:00:36 -0800 (PST)
Received: from keithp by evo.keithp.com with local (Exim 4.60)
	(envelope-from <keithp@keithp.com>)
	id 1F2nol-0005bC-Ei; Sun, 29 Jan 2006 00:00:31 +1300
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15196>


--=-ij75MFA1npTIPZUQ7KfM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-01-28 at 18:33 +1300, Martin Langhoff wrote:

> I've got a few small improvements to cvsimport in my laptop that I'll
> push out for Junio to merge as soon as I get back to the office. I've
> run "99% successful" imports of cairo and of x.org (modular and
> monolithic) with all their branches and tags. It isn't literally the
> 20 years of commits Jim talked initially about -- cvs holds just the
> last ~5 years.

Yeah, X CVS is a scattered mess at present. I think it would be better
to just leave that mess alone and grab a reasonably recent chunk of it
to put into a GIT repository. Save a bunch of space too. We also haven't
quite finished all of the recovery needed to span the whole twenty years
yet.

Carl and I hacked at the tool a bit to pull apart our ChangeLog-based
commit messages; extracting email addresses and separating the commit
messages from the (now useless) list of affected files. =20

We're getting clean cairo imports now, there are a few weirdnesses
around branches that we've seen -- one commit appears on both the branch
and trunk for some reason.

Once we're happy with the import, I'm pretty sure we'll just switch
cairo over to git and dump the CVS bits. X.org is a harder case, for
that I suspect we'll migrate individual modules over one at a time,
perhaps starting with the core X server pieces so that I can get my work
done, have it published in the main repository and not have it also
break everyone else's X server.

I'm not sure we'll need ongoing synchronization with existing X.org CVS
for long; there aren't any other developers doing any significant
changes to this part of the system, so we can abandon the losers with no
remorse.
 =20
--=20
keith.packard@intel.com

--=-ij75MFA1npTIPZUQ7KfM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD207OQp8BWwlsTdMRAmsqAJ4yLut41nymvm+6ZB+vhQMI/ItgEACfaS6M
40xZpuZZAqVkyGwnn1jfraM=
=ibPA
-----END PGP SIGNATURE-----

--=-ij75MFA1npTIPZUQ7KfM--
