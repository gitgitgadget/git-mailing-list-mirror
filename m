From: "W. Trevor King" <wking@tremily.us>
Subject: Git submodule for a local branch?
Date: Mon, 22 Oct 2012 08:37:14 -0400
Message-ID: <20121022123714.GL25563@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/jkxxxtAhYIHVDuh"
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 15:37:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQICa-0008UE-2u
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 15:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320Ab2JVNhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 09:37:43 -0400
Received: from vms173021pub.verizon.net ([206.46.173.21]:24530 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200Ab2JVNhn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 09:37:43 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Oct 2012 09:37:43 EDT
Received: from odin.tremily.us ([unknown] [72.68.93.242])
 by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MCA000HJOE2Q920@vms173021.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 22 Oct 2012 07:37:20 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 371A467D3B8; Mon,
 22 Oct 2012 08:37:14 -0400 (EDT)
Content-disposition: inline
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208184>


--/jkxxxtAhYIHVDuh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have a bunch of branches in my repo (a, b, c, =E2=80=A6), and I'd like to
check them out into subdirectories of another branch (index).  My
initial inclination was to use something like

  $ git checkout index
  $ git branch
    a
    b
    c
  * index
  $ git submodule add -b a --reference ./ ./ dir-for-a/
  $ git submodule add -b b --reference ./ ./ dir-for-b/
  $ git submodule add -b c --reference ./ ./ dir-for-c/

but cloning a remote repository (vs. checking out a local branch)
seems to be baked into the submodule implementation.  Should I be
thinking about generalizing git-submodule.sh, or am I looking under
the wrong rock?  My ideal syntax would be something like

  $ git submodule add -b c --local dir-for-c/

The motivation is that I have website that contains a bunch of
sub-sites, and the sub-sites share content.  I have per-sub-site
branches (a, b, c) and want a master branch (index) that aggregates
them.  Perhaps this is too much to wedge into a single repository?

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--/jkxxxtAhYIHVDuh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQhT33AAoJEEUbTsx0l5OMb5MP/1xSdFahLjuY1GHqJ8qCmj1A
Ovhohhq564YIfGHiEIXEn66uX7PAHnjNfpR6q8uRJKj+opIVNcHuL8EjKwZ5zeig
JJ5z6EsUvknQDYsJTI2aPZmXJ831VDAdyjUd9Ku3CftEuUeJLWyF77PWo+9CKdL4
vB6eon93kE4AB/qyOj474bKSN02wI+VgWHrTtaIkCndDH3wC0McoH6Oua6qOUEv2
uY/ef7p+mDZKBC9Mv2x4op3DrXr9UcxjIBcZoE8u8rG5Kyt8rQqXnZzl9VYPOzC5
jMPt/LcgPLdu6fk0oOO1sqZsgoVEuNnTELI9YWNmXVBRK6zY6GtJZcyfvt63iuam
9x9fgIYkNWTadRXOLBdK7nJZFtsdPjNhXRochPMruuJPnj/CCBu708A7iwSi2yQH
owwm4eu79fr0Ct7re2va2FQwojqI8KxYk2/GQsJvTiZWW5DnwwHtBsyNx6NnlRdp
qeOckB7tQNLmJukFdAOGcj+5XTjlA9cYpXc0q81Q8IaI5IWwM6wS4tfuuTmR93U8
oheq7ctGy1URCCAgVAG2qCSjLwktlACLhBUqc0mmZwPAKgpJE2PCtZIdqEMHzaLj
XRMT+ADPplUtGlSBJP6+y52pfgd1f1N31upsdtRM8uTfzblSjRz16UwQXcGY2B/4
w0nRR/cs3JykmfLU0gvK
=7dK2
-----END PGP SIGNATURE-----

--/jkxxxtAhYIHVDuh--
