From: Martin Waitz <tali@admingilde.org>
Subject: git reset --hard not removing some files
Date: Thu, 1 Jun 2006 18:00:52 +0200
Message-ID: <20060601160052.GK14325@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="it/zdz3K1bH9Y8/E"
X-From: git-owner@vger.kernel.org Thu Jun 01 18:00:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlpbV-00049P-MF
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 18:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWFAQAy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 12:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbWFAQAy
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 12:00:54 -0400
Received: from admingilde.org ([213.95.32.146]:14486 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1030213AbWFAQAx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jun 2006 12:00:53 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1FlpbQ-0005O5-DJ
	for git@vger.kernel.org; Thu, 01 Jun 2006 18:00:52 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21117>


--it/zdz3K1bH9Y8/E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

I have the following problem:


nbg1l001:~/src/git > git branch
* master
  next
  origin
nbg1l001:~/src/git > git checkout -b test
nbg1l001:~/src/git > git status
# On branch refs/heads/test
nothing to commit
zsh: exit 1     git status
nbg1l001:~/src/git > git reset --hard v1.3.3
nbg1l001:~/src/git > git status
# On branch refs/heads/test
#
# Untracked files:
#   (use "git add" to add to commit)
#
#       git-quiltimport
#       git-upload-tar
nothing to commit
zsh: exit 1     git status
nbg1l001:~/src/git > git reset --hard master
nbg1l001:~/src/git > git status
# On branch refs/heads/test
nothing to commit
zsh: exit 1     git status

nbg1l001:~/src/git > git --version
git version 1.3.3.g0825d


However, the complete test suite and especially t7101-reset.sh succeed.
Any ideas?

--=20
Martin Waitz

--it/zdz3K1bH9Y8/E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEfw80j/Eaxd/oD7IRAq5SAJ984LMj60uvzxYIJuceUbpR7/YMSwCfZmxh
xuAe4hrWhuUbVrYBK3gbd+0=
=K63u
-----END PGP SIGNATURE-----

--it/zdz3K1bH9Y8/E--
