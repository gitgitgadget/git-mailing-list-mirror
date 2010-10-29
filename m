From: Sascha Peilicke <sasch.pe@gmx.de>
Subject: Unable to remove git branch
Date: Fri, 29 Oct 2010 09:43:12 +0200
Message-ID: <201010290943.13177.sasch.pe@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7303624.Fo8fJmbk0z";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 29 09:43:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBjcV-0001XY-KR
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 09:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754978Ab0J2HnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 03:43:19 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:59153 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753553Ab0J2HnR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 03:43:17 -0400
Received: (qmail invoked by alias); 29 Oct 2010 07:43:15 -0000
Received: from charybdis-ext.suse.de (EHLO bort.localnet) [195.135.221.2]
  by mail.gmx.net (mp053) with SMTP; 29 Oct 2010 09:43:15 +0200
X-Authenticated: #30943063
X-Provags-ID: V01U2FsdGVkX1/W3IN2TiDWPO5qHpXolyGaA1bReiX/CF5TNC3ym9
	YUj5SeRmtvdBOv
User-Agent: KMail/1.13.5 (Linux/2.6.34.7-0.5-desktop; KDE/4.5.2; x86_64; ; )
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160313>

--nextPart7303624.Fo8fJmbk0z
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi guys,

I accidentally did an 'git co -b --track origin/foo' ending up with a local=
=20
branch '--track'. Sadly, git is unable to remove or rename that branch beca=
use=20
it always interprets it as a parameter.=20

As a consequence, 'git br -d "--track"' does nothing and 'git br -m "--trac=
k"=20
foo' even renames the current branch, say, master,  to 'foo'. Any hints on =
how=20
to get rid of that pesky branch?

BTW please CC me as I'm not subscribed to this list.
=2D-=20
Mit freundlichen Gr=FC=DFen,
Sascha Peilicke
http://saschpe.wordpress.com

--nextPart7303624.Fo8fJmbk0z
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEABECAAYFAkzKexEACgkQDq/ykSrZt1XxWgCeOpfcpNjG/a8WzNDqcRxKSrgL
YmAAoK3j0QVLD7H7mMfTgBi/F3SU0Po7
=L2iC
-----END PGP SIGNATURE-----

--nextPart7303624.Fo8fJmbk0z--
