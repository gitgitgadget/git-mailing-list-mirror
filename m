From: Sebastian Harl <sh@tokkee.org>
Subject: git-stash: RFC: Adopt the default behavior to other commands
Date: Mon, 17 Dec 2007 12:03:22 +0100
Message-ID: <20071217110322.GH14889@albany.tokkee.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HuscSE0D68UGttcd"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 12:03:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4DlD-0005KC-4W
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 12:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934772AbXLQLDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 06:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760632AbXLQLDY
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 06:03:24 -0500
Received: from mail.tokkee.org ([212.114.247.92]:36050 "EHLO albany.tokkee.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934772AbXLQLDX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 06:03:23 -0500
Received: by albany.tokkee.org (Postfix, from userid 1000)
	id 80CE0364001; Mon, 17 Dec 2007 12:03:22 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68539>


--HuscSE0D68UGttcd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

By default, git-stash (when called without any other arguments) creates a n=
ew
stash. This is quite different to the behavior of most other Git commands
(e.g. git-tag, git-branch, etc. do "list" by default). In order to improve
consistency git-stash should imho adopt this as well.

The creation of a new stash should not do any harm. However, I think that
consistency is more important (iirc this has been mentioned in the current
survey a couple of times) and doing "list" is (in general) the best default.

Comments?

Cheers,
Sebastian

--=20
Sebastian "tokkee" Harl +++ GnuPG-ID: 0x8501C7FC +++ http://tokkee.org/

Those who would give up Essential Liberty to purchase a little Temporary
Safety, deserve neither Liberty nor Safety.         -- Benjamin Franklin


--HuscSE0D68UGttcd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHZld6EFEKc4UBx/wRAguBAJ9fKpLDEipmVvFwkLaNnVNfWw+7FwCcDH0h
Di10/IhfcGj1t/gDwju7MZo=
=LcrD
-----END PGP SIGNATURE-----

--HuscSE0D68UGttcd--
