From: Stefan Sperling <stsp@elego.de>
Subject: [PATCH] Document -u option in git-svnimport man page
Date: Tue, 21 Aug 2007 19:15:09 +0200
Message-ID: <20070821171509.GB1721@jack.stsp.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Cc: subversion@elego.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 19:17:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INXLz-0005d5-84
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 19:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761226AbXHURRO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 13:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761015AbXHURRO
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 13:17:14 -0400
Received: from fallback-mx.in-berlin.de ([192.109.42.17]:60434 "EHLO
	hirscho.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758589AbXHURRN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 13:17:13 -0400
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	by fallback-mx.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id l7LHHCmp012382
	for <git@vger.kernel.org>; Tue, 21 Aug 2007 19:17:12 +0200
X-Envelope-From: stsp@elego.de
Received: from stsp.lan (stsp2.in-vpn.de [217.197.85.95])
	(authenticated bits=128)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id l7LHFoNi009172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 21 Aug 2007 19:15:50 +0200
Received: from jack.stsp.lan (stsp@localhost.stsp.lan [127.0.0.1])
	by stsp.lan (8.14.1/8.14.0) with ESMTP id l7LHFJ1H004913;
	Tue, 21 Aug 2007 19:15:19 +0200 (CEST)
Received: (from stsp@localhost)
	by jack.stsp.lan (8.14.1/8.14.0/Submit) id l7LHF909016098;
	Tue, 21 Aug 2007 19:15:09 +0200 (CEST)
X-Authentication-Warning: jack.stsp.lan: stsp set sender to stsp@elego.de using -f
Mail-Followup-To: git@vger.kernel.org, subversion@elego.de
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56308>


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimport.=
txt
index 2cfc407..c9c8c5d 100644
--- a/Documentation/git-svnimport.txt
+++ b/Documentation/git-svnimport.txt
@@ -65,6 +65,9 @@ When importing incrementally, you might need to edit the =
=2Egit/svn2git file.
 	Prepend 'rX: ' to commit messages, where X is the imported
 	subversion revision.
=20
+-u::
+	Replace underscores in tag names with periods.
+
 -I <ignorefile_name>::
 	Import the svn:ignore directory property to files with this
 	name in each directory. (The Subversion and GIT ignore

--=20
Stefan Sperling <stsp@elego.de>                 Software Developer
elego Software Solutions GmbH                            HRB 77719
Gustav-Meyer-Allee 25, Gebaeude 12        Tel:  +49 30 23 45 86 96=20
13355 Berlin                              Fax:  +49 30 23 45 86 95
http://www.elego.de                 Geschaeftsfuehrer: Olaf Wagner

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (OpenBSD)

iD8DBQFGyx2d5dMCc/WdJfARAnXOAJ0V/uZq9QF+VJ0iFOHX9kb2/gOcWQCfV5V8
okkaLrtzOhYTsJUhlT4Y0Sk=
=CId7
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
