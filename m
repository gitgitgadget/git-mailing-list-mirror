From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 1/7] parse-options: Make callbacks take flags instead of boolean `unset`
Date: Mon, 17 Dec 2007 19:54:16 +0100
Message-ID: <20071217185416.GD22554@artemis.madism.org>
References: <1197915797-30679-1-git-send-email-madcoder@debian.org> <1197915797-30679-2-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="/unnNtmY43mpUSKx";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 17 19:55:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4L6v-0004QP-Vc
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 19:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbXLQSyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 13:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752670AbXLQSyT
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 13:54:19 -0500
Received: from pan.madism.org ([88.191.52.104]:42692 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbXLQSyS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 13:54:18 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 584043085B;
	Mon, 17 Dec 2007 19:54:17 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 7CE6937DE78; Mon, 17 Dec 2007 19:54:16 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>, gitster@pobox.com,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1197915797-30679-2-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68598>


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

And of course here is the MadBug #1, to be squashed:
---
 builtin-rev-parse.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 20d1789..3e8ee62 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -210,10 +210,10 @@ static int try_difference(const char *arg)
 	return 0;
 }
=20
-static int parseopt_dump(const struct option *o, const char *arg, int unse=
t)
+static int parseopt_dump(const struct option *o, const char *arg, int flag=
s)
 {
 	struct strbuf *parsed =3D o->value;
-	if (unset)
+	if (flags & PARSE_OPT_UNSET)
 		strbuf_addf(parsed, " --no-%s", o->long_name);
 	else if (o->short_name)
 		strbuf_addf(parsed, " -%c", o->short_name);
--=20
1.5.4.rc0.1151.g102b0


--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHZsXYvGr7W6HudhwRAk5xAKCCpmBTUJx9hunC5tZtLQmWdSEgbQCdGguQ
BBZyWTBv1xHmyQKQ2L6HR5U=
=8TKt
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--
