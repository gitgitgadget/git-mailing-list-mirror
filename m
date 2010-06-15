From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Changled submodule cannot be "git added"
Date: Tue, 15 Jun 2010 09:25:14 +0200
Message-ID: <20100615072514.GA3260@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 15 09:26:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOQXM-0000NS-Ic
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 09:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930Ab0FOH0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 03:26:13 -0400
Received: from mx3.schottelius.org ([77.109.138.221]:34871 "EHLO
	mx3.schottelius.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123Ab0FOH0M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 03:26:12 -0400
Received: from kr.localdomain (mx3.schottelius.org [77.109.138.221])
	by mx3.schottelius.org (Postfix) with ESMTP id 6B889197A041
	for <git@vger.kernel.org>; Tue, 15 Jun 2010 09:26:10 +0200 (CEST)
Received: by kr.localdomain (Postfix, from userid 1000)
	id B65EF943CA; Tue, 15 Jun 2010 09:25:14 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149163>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

And another interesting behaviour of git with submodules:

---------------------------------------------------------------------------=
-----
% git status
# On branch master
# Your branch is ahead of 'origin/master' by 8 commits.
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working director=
y)
#   (commit or discard the untracked or modified content in submodules)
#
#       modified:   modules/tftpd_hpa (modified content)
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       modules/ethz_systems_private/
no changes added to commit (use "git add" and/or "git commit -a")
% git add modules/tftpd_hpa
# On branch master
# Your branch is ahead of 'origin/master' by 8 commits.
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working director=
y)
#   (commit or discard the untracked or modified content in submodules)
#
#       modified:   modules/tftpd_hpa (modified content)
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       modules/ethz_systems_private/
no changes added to commit (use "git add" and/or "git commit -a")
---------------------------------------------------------------------------=
-----

- Why can modules/tftpd_hpa not be added?
- Why does git checkout not remove modules/ethz_systems_private/,
  when switching from the master to the private branch?
  (the module is only registered in the private branch)

Nico

--=20
New PGP key: 7ED9 F7D3 6B10 81D7 0EC5  5C09 D7DC C8E4 3187 7DF0
Please resign, if you signed 9885188C or 8D0E27A4.

Currently moving *.schottelius.org to http://www.nico.schottelius.org/ ...

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwXKtoACgkQ19zI5DGHffB65QCfW1iafk6VfwGjg5DSYYQO/2D5
py8An28tgq5NTTWRj7mWooI07ZZLNXVR
=FAtL
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
