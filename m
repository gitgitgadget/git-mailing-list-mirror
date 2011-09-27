From: Michal Vyskocil <mvyskocil@suse.cz>
Subject: [PATCH] show git tag output in pager
Date: Tue, 27 Sep 2011 15:42:36 +0200
Message-ID: <20110927134235.GA27478@zelva.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 15:48:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Y19-0001a4-VN
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 15:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818Ab1I0NsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 09:48:11 -0400
Received: from nat.scz.novell.com ([213.151.88.252]:40968 "EHLO zelva.site"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752319Ab1I0NsK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 09:48:10 -0400
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Sep 2011 09:48:10 EDT
Received: by zelva.site (Postfix, from userid 10112)
	id 85666411B2F5; Tue, 27 Sep 2011 15:42:36 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182238>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

---
 builtin/tag.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 667515e..9f70fa8 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -147,6 +147,8 @@ static int list_tags(const char **patterns, int lines,
 			struct commit_list *with_commit)
 {
 	struct tag_filter filter;
+       =20
+        setup_pager();
=20
 	filter.patterns =3D patterns;
 	filter.lines =3D lines;
--=20
1.7.6.3


--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk6B0ssACgkQGwzgx2QvQgRggQCfUwrQRCjC4k9VAeTTBHRzi0eD
7qgAn09ms9jszG8oc5kKCImCe37Ef5nB
=Rms5
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
