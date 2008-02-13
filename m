From: Graham Cox <graham@grahamcox.co.uk>
Subject: git-archive for files changed in revision range
Date: Wed, 13 Feb 2008 13:03:04 +0000
Message-ID: <20080213130304.GA19957@grahamcox.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 14:29:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPHgD-0006xI-2e
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 14:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbYBMN3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 08:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752970AbYBMN3F
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 08:29:05 -0500
Received: from li23-39.members.linode.com ([67.18.208.39]:57025 "EHLO
	grahamcox.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752956AbYBMN3E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 08:29:04 -0500
X-Greylist: delayed 1559 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Feb 2008 08:29:04 EST
Received: from graham by grahamcox.co.uk with local (Exim 4.63)
	(envelope-from <graham@grahamcox.co.uk>)
	id 1JPHGS-0005IN-Nn
	for git@vger.kernel.org; Wed, 13 Feb 2008 13:03:04 +0000
Content-Disposition: inline
X-GPG-Key: mailto:graham-gpgkey@grahamcox.co.uk
X-GPG-Fingerprint: 9FE5 30E8 98A0 B876 56C9  7EE2 8201 6CFE C738 4EC7
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73789>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hiya,

We have a small project that is being managed in a Git repository (MSysGit =
to=20
be exact) - mostly for backups and so on. The project is a mod for the=20
computer game Civilization 4. (Actually a mod of a mod, but still...)  As=
=20
such, to release the mod to other people to actually use the only thing tha=
t=20
needs to be released is all of the files that have actually been changed. (=
The=20
actual git repository contains ~700MB of files, the vast majority of which=
=20
haven't changed since the initial import and so don't need to be downloaded=
 by=20
people).

I've managed to make it produce an archive that contains only the files tha=
t=20
have changed by using a combination of git-archive and git-whatchanged, alo=
ng=20
with grep and sed, but it's kinda unwieldly. Is there a better way of doing=
=20
this?

The command line I used was something like (This is mostly from memory):
git-archive --format=3Dzip . `git-whatchanged <start>..HEAD --pretty=3Donel=
ine=20
  | grep '^:' | sed 's/^.*\t//'` > release.zip

To produce a zip containing all of the modified and added files for the=20
revision range <start>..HEAD.

--=20
Graham Cox


--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHsuqIggFs/sc4TscRAnsqAJ9mvufBLsxDzULd0Iz0wtcmlKTcRwCgv8/n
0iXBFIbnZW/Mz4oIcB+2wV8=
=NXjR
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
