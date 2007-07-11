From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Build error with qgit4
Date: Wed, 11 Jul 2007 22:33:43 +0200
Message-ID: <20070711203343.GF3069@efreet.light.src>
References: <cc723f590707110919i7def2fbal94b1a437f189040@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7cm2iqirTL37Ot+N"
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 22:33:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8ise-0005CI-Mv
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 22:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755586AbXGKUdr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 16:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755422AbXGKUdr
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 16:33:47 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:54869 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753050AbXGKUdq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 16:33:46 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 2172E57317;
	Wed, 11 Jul 2007 22:33:45 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 42xobt5v1xB7; Wed, 11 Jul 2007 22:33:43 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id C0909572A8;
	Wed, 11 Jul 2007 22:33:43 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1I8isZ-0004Ag-6b; Wed, 11 Jul 2007 22:33:43 +0200
Content-Disposition: inline
In-Reply-To: <cc723f590707110919i7def2fbal94b1a437f189040@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52197>


--7cm2iqirTL37Ot+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 11, 2007 at 21:49:25 +0530, Aneesh Kumar wrote:
> lude/qt4/QtGui -I/usr/include/qt4 -I../src -I../build -I../build -o
> ../build/fileview.o fileview.cpp
> ../build/ui_fileview.h: In member function 'void=20
> Ui_TabFile::setupUi(QWidget*)':
> ../build/ui_fileview.h:63: error: 'class QHBoxLayout' has no member
> named 'setLeftMargin'
> ../build/ui_fileview.h:64: error: 'class QHBoxLayout' has no member
> named 'setTopMargin'
> ../build/ui_fileview.h:65: error: 'class QHBoxLayout' has no member
> named 'setRightMargin'
> ../build/ui_fileview.h:66: error: 'class QHBoxLayout' has no member
> named 'setBottomMargin'
> ../build/ui_fileview.h:71: error: 'class QVBoxLayout' has no member
> named 'setLeftMargin'

That's strange, because the errors are in Qt-generated file when working wi=
th
Qt class. Are you sure it uses uic and moc from the same Qt version as qmake
and the headers?

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--7cm2iqirTL37Ot+N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGlT6nRel1vVwhjGURAmipAKCJfAfvw4+UhZDWSoqkLVuL8mjhFQCgnGQF
5cVtQ9j4QK/jjtdI89du/oI=
=Y/qs
-----END PGP SIGNATURE-----

--7cm2iqirTL37Ot+N--
