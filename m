From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: [PATCH] [PATCH] git-tag(1): add hint about commit messages
Date: Mon, 30 Mar 2009 13:58:21 +0200
Message-ID: <20090330115821.GA7314@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 14:00:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoG9l-0008Hk-VK
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 13:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbZC3L60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 07:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbZC3L60
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 07:58:26 -0400
Received: from mx3.schottelius.org ([77.109.138.221]:49362 "EHLO
	mx3.schottelius.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbZC3L6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 07:58:25 -0400
Received: from ikn.ethz.ch (ikn.inf.ethz.ch [129.132.130.3])
	by mx3.schottelius.org (Postfix) with ESMTPSA id E052D197A067
	for <git@vger.kernel.org>; Mon, 30 Mar 2009 13:58:20 +0200 (CEST)
Received: by ikn.ethz.ch (Postfix, from userid 1000)
	id 2BD6D710A; Mon, 30 Mar 2009 13:58:22 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115140>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If a tag is not annotated, git tag displays the commit message
instead. Add this hint to the manpage to unhide this secret.

Signed-off-by: Nico Schottelius <nico@ikn.schottelius.org>
---
 Documentation/git-tag.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 533d18b..fa73321 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -63,6 +63,7 @@ OPTIONS
 	are printed when using -l.
 	The default is not to print any annotation lines.
 	If no number is given to `-n`, only the first line is printed.
+	If the tag is not annotated, the commit message is displayed instead.
=20
 -l <pattern>::
 	List tags with names that match the given pattern (or all if no pattern i=
s given).
--=20
1.6.2


--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknQs90ACgkQuL75KpiFGIxUZQCffsK0FsItq1hMnPmSheNqwzRQ
V34AnRaJRxgOKjSvhkex8AHU4DH98Ggf
=ZYg1
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
