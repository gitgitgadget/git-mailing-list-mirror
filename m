From: Jan Hudec <bulb@ucw.cz>
Subject: [BUG?] Detaching head at checked out point does not work.
Date: Sat, 12 May 2007 19:21:05 +0200
Message-ID: <20070512172105.GB32764@efreet.light.src>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 12 19:21:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmvHo-0003Em-L3
	for gcvg-git@gmane.org; Sat, 12 May 2007 19:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756153AbXELRVY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 13:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757006AbXELRVX
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 13:21:23 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:4686 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756153AbXELRVX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 13:21:23 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP with TLS id 5203017.196590;
	Sat, 12 May 2007 19:21:05 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HmvHF-0002DJ-BO
	for git@vger.kernel.org; Sat, 12 May 2007 19:21:05 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47067>


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I can correctly detach head by saying:

  git checkout master^0

(or git checkout master^{} or git checkout refs/heads/master), but NONE of
these work, if I currently have master checked out. Shouldn't it detach
anyway?

Regards,

Jan

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGRfeBRel1vVwhjGURAr8bAKCogwq5KguzNQyKIMBR5GBE/4pYNgCgxT16
bV8/H4NH/JSVtu2Jbv0kgc0=
=6iYD
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
