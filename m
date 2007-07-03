From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Document -<n> for git-format-patch
Date: Wed, 4 Jul 2007 01:38:29 +0200
Message-ID: <20070703233829.GK32766@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fKov5AqTsvseSZ0Z"
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 04 01:39:09 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5rxd-0000sm-3Z
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 01:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756078AbXGCXil (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 19:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757125AbXGCXik
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 19:38:40 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:54691 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752387AbXGCXik (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 19:38:40 -0400
X-Greylist: delayed 5226 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Jul 2007 19:38:39 EDT
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1I5rx6-0002pz-6f
	from <vmiklos@frugalware.org>; Wed, 04 Jul 2007 01:38:39 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 0B5681868117; Wed,  4 Jul 2007 01:38:29 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-1.0 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51551>


--fKov5AqTsvseSZ0Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The -<n> option was not mentioned in git-format-patch's manpage till
now. Fix this.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

At least as far as I see. Correct me if I'm wrong :)

 Documentation/git-format-patch.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-=
patch.txt
index e563810..6cbcf93 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -53,6 +53,9 @@ OPTIONS
 -------
 include::diff-options.txt[]
=20
+-<n>::
+	Limits the number of patches to prepare.
+
 -o|--output-directory <dir>::
 	Use <dir> to store the resulting files, instead of the
 	current working directory.
--=20
1.5.2.2


--fKov5AqTsvseSZ0Z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGit31e81tAgORUJYRAik1AJ43JaMF2nTG7rVUL5Tk2L7eSA0AyACfV28i
XGzi5XcF4Ggf7nM5yKmZUkQ=
=yO0h
-----END PGP SIGNATURE-----

--fKov5AqTsvseSZ0Z--
