From: martin f krafft <madduck@madduck.net>
Subject: git-svn clone duplicates content
Date: Thu, 13 Mar 2008 10:52:15 +0100
Message-ID: <20080313095215.GA22241@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 13 11:20:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZkXs-000509-1l
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 11:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbYCMKTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 06:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbYCMKTl
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 06:19:41 -0400
Received: from clegg.madduck.net ([82.197.162.59]:44845 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699AbYCMKTk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 06:19:40 -0400
X-Greylist: delayed 1638 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Mar 2008 06:19:40 EDT
Received: from wall.oerlikon.madduck.net (84-75-158-163.dclient.hispeed.ch [84.75.158.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id AC187A8305
	for <git@vger.kernel.org>; Thu, 13 Mar 2008 10:52:16 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 467F09F18E
	for <git@vger.kernel.org>; Thu, 13 Mar 2008 10:52:15 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 09E17442E; Thu, 13 Mar 2008 10:52:15 +0100 (CET)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.24-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.91.2/6220/Wed Mar 12 23:33:03 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77058>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi list,

if I

  git-svn clone --stdlayout svn://svn.debian.org/svn/python-modules/package=
s/python-docutils

then I get

  drwx------ 3 madduck madduck 4096 2008-03-13 10:11 debian/
  drwx------ 3 madduck madduck 4096 2008-03-13 10:11 trunk/
  drwx------ 3 madduck madduck 4096 2008-03-13 10:11 trunk/debian/

and the diff between the two debian directories is equivalent to the
last commit to the trunk. If I create a new branch off the remote
'trunk' branch, then the trunk/ directory will be gone, as it
should.

I am a bit wary to dcommit off anything else than master though for
I've already killed SVN repos with git-svn in the past. I'd rather
not to that to Debian's python-modules repo, or else would have to
spend the rest of my life hidden on some island.

It seems that master is branched off a tag in this case.
Does anyone have an idea what's going on?
Is this something weird in the svn or with git-svn?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
what do you mean, it's not packaged in debian?
=20
spamtraps: madduck.bogus@madduck.net

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH2PlOIgvIgzMMSnURAseLAJ9EDLDz1+1TFYaOXicwSRCRkctfXgCgj9aq
D2M3etVd+2zCroLoBOwwxeg=
=OSnw
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
