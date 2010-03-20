From: "R. Tyler Ballance" <tyler@monkeypox.org>
Subject: [PATCH] Correct references to /usr/bin/python which may ont exist
 on certain systems
Date: Sat, 20 Mar 2010 16:02:37 -0700
Message-ID: <20100320230230.GA29738@kiwi.sharlinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 00:09:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt7nR-0002cL-Ss
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 00:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665Ab0CTXJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 19:09:29 -0400
Received: from mail.geekisp.com ([216.168.135.169]:1929 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752515Ab0CTXJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 19:09:28 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Mar 2010 19:09:28 EDT
Received: (qmail 794 invoked by uid 1003); 20 Mar 2010 23:02:45 -0000
Received: from localhost (HELO kiwi.sharlinx.com) (tyler@monkeypox.org@127.0.0.1)
  by mail.geekisp.com with SMTP; 20 Mar 2010 23:02:44 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142765>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

FreeBSD for example does not ship with a /usr/bin/python such that Python
installed from ports will be located by default in /usr/local/bin
---
 Makefile                           |    2 +-
 contrib/fast-import/import-zips.py |    2 +-
 contrib/hg-to-git/hg-to-git.py     |    2 +-
 contrib/p4import/git-p4import.py   |    2 +-
 git_remote_helpers/Makefile        |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 3a6c6ea..2b248b4 100644
--- a/Makefile
+++ b/Makefile
@@ -444,7 +444,7 @@ ifndef PERL_PATH
 	PERL_PATH =3D /usr/bin/perl
 endif
 ifndef PYTHON_PATH
-	PYTHON_PATH =3D /usr/bin/python
+	PYTHON_PATH =3D /usr/bin/env python
 endif
=20
 export PERL_PATH
diff --git a/contrib/fast-import/import-zips.py b/contrib/fast-import/impor=
t-zips.py
index 7051a83..82f5ed3 100755
--- a/contrib/fast-import/import-zips.py
+++ b/contrib/fast-import/import-zips.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python
=20
 ## zip archive frontend for git-fast-import
 ##
diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index 854cd94..046cb2b 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -1,4 +1,4 @@
-#! /usr/bin/python
+#!/usr/bin/env python
=20
 """ hg-to-git.py - A Mercurial to GIT converter
=20
diff --git a/contrib/p4import/git-p4import.py b/contrib/p4import/git-p4impo=
rt.py
index 0f3d97b..b6e534b 100644
--- a/contrib/p4import/git-p4import.py
+++ b/contrib/p4import/git-p4import.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python
 #
 # This tool is copyright (c) 2006, Sean Estabrooks.
 # It is released under the Gnu Public License, version 2.
diff --git a/git_remote_helpers/Makefile b/git_remote_helpers/Makefile
index c62dfd0..af3cc28 100644
--- a/git_remote_helpers/Makefile
+++ b/git_remote_helpers/Makefile
@@ -7,7 +7,7 @@ pysetupfile:=3Dsetup.py
 DESTDIR_SQ =3D $(subst ','\'',$(DESTDIR))
=20
 ifndef PYTHON_PATH
-	PYTHON_PATH =3D /usr/bin/python
+	PYTHON_PATH =3D /usr/bin/env python
 endif
 ifndef prefix
 	prefix =3D $(HOME)
--=20
1.6.4.3

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkulVAYACgkQFCbH3D9R4W9/uwCeKwdpoZF7SFi/XAXSyPQaKAf7
yOsAoLOt4e+AxbreS49vWw0Swj/Zs/wo
=pjRa
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
