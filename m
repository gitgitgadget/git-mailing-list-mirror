From: Roger Leigh <rleigh@codelibre.net>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 11:27:08 +0000
Message-ID: <20081120112708.GC22787@ravenclaw.codelibre.net>
References: <20081119113752.GA13611@ravenclaw.codelibre.net> <46d6db660811190818r3aa2a392pda9106ac4a579cf0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Cc: git@vger.kernel.org
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 13:41:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L38r3-0004pe-Ec
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 13:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297AbYKTMkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 07:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754105AbYKTMkc
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 07:40:32 -0500
Received: from nagini.codelibre.net ([80.68.93.164]:33630 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036AbYKTMkb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 07:40:31 -0500
Received: by nagini.codelibre.net (Postfix, from userid 1000)
	id D2BB1188A6; Thu, 20 Nov 2008 12:40:21 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <46d6db660811190818r3aa2a392pda9106ac4a579cf0@mail.gmail.com>
X-GPG-Key: 0x25BFB848
X-Debian: testing/unstable
X-OS-Uptime: 11:02:39 up 58 min,  1 user,  load average: 0.15, 0.15, 0.16
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101414>


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2008 at 05:18:16PM +0100, Christian MICHON wrote:
> On Wed, Nov 19, 2008 at 12:37 PM, Roger Leigh <rleigh@codelibre.net> wrot=
e:
> > Would it be possible for git to store the mtime of files in the tree?
> >
> > This would make it possible to do this type of work in git, since it's
> > currently a bit random as to whether it works or not.  This only
> > started when I upgraded to an amd64 architecture from powerpc32,
> > I guess it's maybe using high-resolution timestamps.
> >
>=20
> beside the obvious answer it comes back often as a request, it is
> possible in theory to create a shell script which, for each file
> present in the sandbox in the current branch, would find the mtime of
> the last commit on that file (quite an expensive operation) and apply
> it.

Surely this is only expensive because you're not already storing the
information in the tree; if it was there, it would be (relatively)
cheap?  You could even compare the old and new trees to see if you
needed to touch a file at all.

> You should store mostly content of source files. You should do a make
> in your first cloned repo at least once before committing anything to
> the repo. That's what I did and I saved days...

Except in this case I'm storing the content of *tarballs* (along with
pristine-tar).  I'm committing exactly what's in the tarball with
no changes (this is a requirement).  I can't change the source prior
to commit.


Regards,
Roger

--=20
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux             http://people.debian.org/~rleigh/
 `. `'   Printing on GNU/Linux?       http://gutenprint.sourceforge.net/
   `-    GPG Public Key: 0x25BFB848   Please GPG sign your mail.

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkklSYwACgkQVcFcaSW/uEiNyACcCSvWjGyLfqObCbYWTZ+T0cm6
bE8An2ryWW/vpo2RvZgIm5R+g/bNtWM6
=O/ho
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
