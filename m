From: Luciano Rocha <luciano@eurotux.com>
Subject: clone --bare 2.6.24.y with --reference linus.git too big?
Date: Wed, 13 Feb 2008 18:25:45 +0000
Message-ID: <20080213182545.GA14886@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 19:26:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPMJh-0003Cv-Ee
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 19:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757916AbYBMSZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 13:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752094AbYBMSZw
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 13:25:52 -0500
Received: from os.eurotux.com ([216.75.63.6]:51460 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883AbYBMSZv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 13:25:51 -0500
Received: (qmail 32475 invoked from network); 13 Feb 2008 18:25:49 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 13 Feb 2008 18:25:49 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73808>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello,

I did today a bare clone of the 2.6.24.y tree of the Linux kernel.

I instructed git to use a local mirror of Linus's tree, but the clone
ended up downloading over 40MB of data:

$ git clone --bare --reference /.src/kernel/linus.git/ \
    git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.24.y.git=
 \
    2.6.24.y.git
Initialized empty Git repository in /media/stuff/src/kernel/2.6.24.y.git/
remote: Counting objects: 15483, done.
remote: Compressing objects: 100% (14747/14747), done.
remote: Total 15483 (delta 1795), reused 5236 (delta 632)
Receiving objects: 100% (15483/15483), 46.30 MiB | 317 KiB/s, done.
Resolving deltas: 100% (1795/1795), done.

I expected a much smaller download, as the difference between the heads
of both trees are only a few patches (2.6.24 -> 2.6.24.2).

My git is at version 1.5.4.1.99.g3b933.

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHszYpinSul6a7oB8RAge7AJ47C2io3JO+XlWEICT1MtJ61ykFtwCfftAi
8uRFSMM728DoSkWp2aE/j+g=
=s3Ii
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
