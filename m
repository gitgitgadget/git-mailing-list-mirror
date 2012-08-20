From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 64/66] i18n: write-tree: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:53 +0700
Message-ID: <1345465975-16927-65-git-send-email-pclouds@gmail.com>
References: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 14:46:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RN2-0001ZN-AA
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266Ab2HTMqK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:46:10 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080Ab2HTMqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:46:09 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VjezddxgUlBjE+tJAEUya23xJHGxqSDZaXl2bKOfSAA=;
        b=0ayA6dmL6671OXEDeM1SeJV6jSt6h6Ii4kz7J6fF0DO5W8DhfDDKqZ9LXxu768bEYd
         HqifIjwDPw1uYc7FHIBCmHhdC45PW0rOso0IYfReQzY3Fov12CIH6FxPkIxrWIv4N6zx
         o4pEOFv4WGZqAzzTNS8tFeeGdw9izBSudzp+0b/lghLOaqFZzJsbc8UlGbIeof/QB1F7
         3vmFEopSM2nWhtJEVdSjwbDAzupC0aAEyiLKbJNj9iJHCzLtS1fB2bk884LVnhe5RYT3
         EqAL70bKTzndFK9/0UJe+VjsSmZluFIi3EYo2FJxi31BQE8AR2B1HmjxAjjTk0IJRFDZ
         hD7A==
Received: by 10.66.88.39 with SMTP id bd7mr29460865pab.50.1345466768761;
        Mon, 20 Aug 2012 05:46:08 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id sz3sm11052635pbc.21.2012.08.20.05.46.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:46:08 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:40:08 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203836>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/write-tree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index b223af4..084c0df 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -10,7 +10,7 @@
 #include "parse-options.h"
=20
 static const char * const write_tree_usage[] =3D {
-	"git write-tree [--missing-ok] [--prefix=3D<prefix>/]",
+	N_("git write-tree [--missing-ok] [--prefix=3D<prefix>/]"),
 	NULL
 };
=20
@@ -21,13 +21,13 @@ int cmd_write_tree(int argc, const char **argv, con=
st char *unused_prefix)
 	unsigned char sha1[20];
 	const char *me =3D "git-write-tree";
 	struct option write_tree_options[] =3D {
-		OPT_BIT(0, "missing-ok", &flags, "allow missing objects",
+		OPT_BIT(0, "missing-ok", &flags, N_("allow missing objects"),
 			WRITE_TREE_MISSING_OK),
-		{ OPTION_STRING, 0, "prefix", &prefix, "<prefix>/",
-		  "write tree object for a subdirectory <prefix>" ,
+		{ OPTION_STRING, 0, "prefix", &prefix, N_("<prefix>/"),
+		  N_("write tree object for a subdirectory <prefix>") ,
 		  PARSE_OPT_LITERAL_ARGHELP },
 		{ OPTION_BIT, 0, "ignore-cache-tree", &flags, NULL,
-		  "only useful for debugging",
+		  N_("only useful for debugging"),
 		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, NULL,
 		  WRITE_TREE_IGNORE_CACHE_TREE },
 		OPT_END()
--=20
1.7.12.rc2.18.g61b472e
