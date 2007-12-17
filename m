From: Sebastian Harl <sh@tokkee.org>
Subject: git-clone: Unobvious error messages when update-server-info has not been run
Date: Mon, 17 Dec 2007 11:55:41 +0100
Message-ID: <20071217105541.GG14889@albany.tokkee.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lQSB8Tqijvu1+4Ba"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 11:56:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Ddy-00037h-77
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 11:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761288AbXLQKzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 05:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757839AbXLQKzp
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 05:55:45 -0500
Received: from mail.tokkee.org ([212.114.247.92]:36048 "EHLO albany.tokkee.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756103AbXLQKzo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 05:55:44 -0500
Received: by albany.tokkee.org (Postfix, from userid 1000)
	id F05FE364001; Mon, 17 Dec 2007 11:55:41 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68536>


--lQSB8Tqijvu1+4Ba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I was just trying to clone a repository using http but missed to run
git-update-server-info on the server side. git-clone aborted with the
following error messages:

  % git clone http://some/repo.git
  Initialized empty Git repository in /path/repo/.git/
  cat: /path/repo/.git/refs/remotes/origin/master: No such file or directory
  cd: 482: can't cd to /path/repo/.git/refs/remotes/origin
  fatal: : not a valid SHA1
  fatal: Not a valid object name HEAD

It's kind of hard to guess where the error comes from in this case (I blamed
Git at first). Is there some way to improve the error message in a case like
this?

TIA,
Sebastian

--=20
Sebastian "tokkee" Harl +++ GnuPG-ID: 0x8501C7FC +++ http://tokkee.org/

Those who would give up Essential Liberty to purchase a little Temporary
Safety, deserve neither Liberty nor Safety.         -- Benjamin Franklin


--lQSB8Tqijvu1+4Ba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHZlWtEFEKc4UBx/wRAkUxAJ9HzeAgb+2HOyXF4yokyVaUwThavgCfZ8Em
WEMdLawHnbN6inLxvIYqLy8=
=oHt/
-----END PGP SIGNATURE-----

--lQSB8Tqijvu1+4Ba--
