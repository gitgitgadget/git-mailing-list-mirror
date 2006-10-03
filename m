From: Martin Waitz <tali@admingilde.org>
Subject: git-fetch --update-head-ok ?
Date: Tue, 3 Oct 2006 14:34:52 +0200
Message-ID: <20061003123452.GK2871@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6lXr1rPCNTf1w0X8"
X-From: git-owner@vger.kernel.org Tue Oct 03 14:35:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUjUa-0007aw-CY
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 14:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWJCMex (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 08:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWJCMex
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 08:34:53 -0400
Received: from agent.admingilde.org ([213.95.21.5]:16061 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1750802AbWJCMex (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 08:34:53 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GUjU4-000085-5C
	for git@vger.kernel.org; Tue, 03 Oct 2006 14:34:52 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28269>


--6lXr1rPCNTf1w0X8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

I have no idea why there is a --update-head-ok, but the code looks
like it has a typo:

diff --git a/git-fetch.sh b/git-fetch.sh
index 09a5d6c..5843639 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -433,7 +433,7 @@ esac
 # If the original head was empty (i.e. no "master" yet), or
 # if we were told not to worry, we do not have to check.
 case ",$update_head_ok,$orig_head," in
-*,, | t,* )
+*,, | ,t,* )
        ;;
 *)
        curr_head=3D$(git-rev-parse --verify HEAD 2>/dev/null)

--=20
Martin Waitz

--6lXr1rPCNTf1w0X8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFIljsj/Eaxd/oD7IRAmkMAJ9RRteiNZufhZfowemm7HEwvo8UpgCfd0Ln
dcSHf2yHMUTTnyOCqQDUFIM=
=3vDG
-----END PGP SIGNATURE-----

--6lXr1rPCNTf1w0X8--
