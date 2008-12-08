From: "D. Stuart Freeman" <stuart.freeman@et.gatech.edu>
Subject: git-svn not working when parent of cloned dir requires auth
Date: Mon, 8 Dec 2008 15:54:18 -0500
Message-ID: <20081208205418.GA16418@cetel-004-xx6.admin.gatech.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 22:19:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9nVT-0008Ke-J9
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 22:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbYLHVRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 16:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbYLHVRo
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 16:17:44 -0500
Received: from deliverator1.ecc.gatech.edu ([130.207.185.171]:49326 "EHLO
	deliverator1.ecc.gatech.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752089AbYLHVRn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2008 16:17:43 -0500
X-Greylist: delayed 1402 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Dec 2008 16:17:43 EST
Received: from deliverator3.ecc.gatech.edu (deliverator3.ecc.gatech.edu [130.207.185.173])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by deliverator1.ecc.gatech.edu (Postfix) with ESMTP id B445B2DCE60
	for <git@vger.kernel.org>; Mon,  8 Dec 2008 15:55:21 -0500 (EST)
Received: from deliverator3.ecc.gatech.edu (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 4BF1739C19D
	for <git@vger.kernel.org>; Mon,  8 Dec 2008 15:54:18 -0500 (EST)
Received: from mailprx5.gatech.edu (mailprx5.prism.gatech.edu [130.207.171.19])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.mail.gatech.edu", Issuer "Equifax" (verified OK))
	by deliverator3.ecc.gatech.edu (Postfix) with ESMTP id 1409F39C187
	for <git@vger.kernel.org>; Mon,  8 Dec 2008 15:54:18 -0500 (EST)
Received: from mothra.cetl.gatech.edu (cetel-004-xx6.admin.gatech.edu [130.207.46.56])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	(sasl: method=PLAIN, username=dfreeman31@mailprx5.gatech.edu, sender=stuart@cetel-004-xx6.admin.gatech.edu)
	by mailprx5.gatech.edu (Postfix) with ESMTP id C4E8F1F7F
	for <git@vger.kernel.org>; Mon,  8 Dec 2008 15:54:17 -0500 (EST)
	(envelope-from stuart@cetel-004-xx6.admin.gatech.edu)
Received: from stuart by mothra.cetl.gatech.edu with local (Exim 4.69)
	(envelope-from <stuart@cetel-004-xx6.admin.gatech.edu>)
	id 1L9n7S-0004M9-Qp
	for git@vger.kernel.org; Mon, 08 Dec 2008 15:54:18 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102582>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm trying to
'git svn clone https://mware.ucdavis.edu/svn/ucd-sakai/gradebook-gwt -s'
that repo is setup to allow anonymous reading of that directory tree, but
git-svn prompts me for a password.  I think git-svn is traversing up the
directory tree and encountering a directory that needs authn, can I prevent
it from doing that?

--=20
D. Stuart Freeman
Georgia Institute of Technology

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkk9iXoACgkQ74jXllI0CXTk8ACgvWi9Hg2GYzkmW9egdU+o7O+0
HYoAn2110zVALYK+UefnYv5+E14AQHeZ
=85hw
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
