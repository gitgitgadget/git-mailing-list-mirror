From: Yaroslav Halchenko <debian@onerussian.com>
Subject: problem with cherry-picking a commit which comes before
 introducing a new submodule
Date: Fri, 7 Jan 2011 12:24:32 -0500
Message-ID: <20110107172432.GA6040@onerussian.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 07 18:24:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbG3Z-00080L-8Z
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 18:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992Ab1AGRYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 12:24:35 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:36980 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754981Ab1AGRYe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 12:24:34 -0500
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1PbG3E-000317-M0
	for git@vger.kernel.org; Fri, 07 Jan 2011 12:24:32 -0500
Received: from yoh by washoe.onerussian.com with local (Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1PbG3E-000314-EC
	for git@vger.kernel.org; Fri, 07 Jan 2011 12:24:32 -0500
Content-Disposition: inline
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164723>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi GIT Gurus,

per quick IRC troubleshooting it seems to be some kind of an issue in
git cherry-pick logic which tries to deal with existing .gitmodules
structure?

In our repository we had some submodules, then there was a branch off
(call new branch todonotloose) with a single commit.  In the master we
had some other commits and moved one of the subdirectories into a
submodule.

Later on we decided to cherry pick todonotloose into master but
cherry-pick fails despite the fact that 'git show todonotloose | patch
-p1' applies just fine, ie there were no changes touching any of the
submodules.

See http://pastebin.com/hpqbiB03 for output.

IMHO everything is legit and failure should have not occurred, or am I
missing something?

--=20
Yaroslav O. Halchenko
Postdoctoral Fellow,   Department of Psychological and Brain Sciences
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik       =20

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk0nTFAACgkQjRFFY3XAJMismQCgzcLjhjz1Nsey70ipr/qf7kWB
1gwAn28RaUFoWLBfHz/K0n3UNCbjbLGT
=oOhi
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
