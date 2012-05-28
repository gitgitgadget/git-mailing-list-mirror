From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 46/65] i18n: read-tree: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:58 +0700
Message-ID: <1338203657-26486-44-git-send-email-pclouds@gmail.com>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
 <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 28 13:25:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy4M-0004zN-5e
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553Ab2E1LY5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:24:57 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36112 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451Ab2E1LY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:24:56 -0400
Received: by dady13 with SMTP id y13so4038533dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ZRr1A0cCriP2WdcCXh3bHi/9Sqi0XHYxjnc6N+ioq48=;
        b=Y2gJA/aK64L7Fc1ME+C2Flup4aZKQ9uIpnIQedqWrC5X53t5oRBV9Zze4spXnoqPBP
         sRfPSRHKdYeQ91XJxpqPpVsBnPo4wNJ+l27jt9wwGCQWJQjnCsr8iXmfQ7Lng0zzJDMC
         IoXLX0Zg7V2dD0xrLRQLkuxFxvOCTWpeOFLawjc5mGPUqpfSDko8A8LimFyuQmD+82Qn
         Y1LxU4m0mcsq84DXdQycu8F0dWjobhQDXMS1FmCAKXFBrNrn8M4JLYRKITDHZdYFH2pu
         EaKaykUjyJ5evJeY19GQkQzYk4Jhlpw7HTxvMAq8EI2skwL4bD4SFVIdgdApRq1qzauw
         4hjQ==
Received: by 10.68.200.9 with SMTP id jo9mr26124107pbc.122.1338204292870;
        Mon, 28 May 2012 04:24:52 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id gj8sm15484914pbc.39.2012.05.28.04.24.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:24:51 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:20:47 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198682>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/read-tree.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index df6c4c8..042ac1b 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -33,7 +33,7 @@ static int list_tree(unsigned char *sha1)
 }
=20
 static const char * const read_tree_usage[] =3D {
-	"git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<prefix>] [-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-spar=
se-checkout] [--index-output=3D<file>] (--empty | <tree-ish1> [<tree-is=
h2> [<tree-ish3>]])",
+	N_("git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefi=
x=3D<prefix>] [-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-=
sparse-checkout] [--index-output=3D<file>] (--empty | <tree-ish1> [<tre=
e-ish2> [<tree-ish3>]])"),
 	NULL
 };
=20
@@ -104,37 +104,37 @@ int cmd_read_tree(int argc, const char **argv, co=
nst char *unused_prefix)
 	struct unpack_trees_options opts;
 	int prefix_set =3D 0;
 	const struct option read_tree_options[] =3D {
-		{ OPTION_CALLBACK, 0, "index-output", NULL, "file",
-		  "write resulting index to <file>",
+		{ OPTION_CALLBACK, 0, "index-output", NULL, N_("file"),
+		  N_("write resulting index to <file>"),
 		  PARSE_OPT_NONEG, index_output_cb },
 		OPT_SET_INT(0, "empty", &read_empty,
-			    "only empty the index", 1),
-		OPT__VERBOSE(&opts.verbose_update, "be verbose"),
-		OPT_GROUP("Merging"),
+			    N_("only empty the index"), 1),
+		OPT__VERBOSE(&opts.verbose_update, N_("be verbose")),
+		OPT_GROUP(N_("Merging")),
 		OPT_SET_INT('m', NULL, &opts.merge,
-			    "perform a merge in addition to a read", 1),
+			    N_("perform a merge in addition to a read"), 1),
 		OPT_SET_INT(0, "trivial", &opts.trivial_merges_only,
-			    "3-way merge if no file level merging required", 1),
+			    N_("3-way merge if no file level merging required"), 1),
 		OPT_SET_INT(0, "aggressive", &opts.aggressive,
-			    "3-way merge in presence of adds and removes", 1),
+			    N_("3-way merge in presence of adds and removes"), 1),
 		OPT_SET_INT(0, "reset", &opts.reset,
-			    "same as -m, but discard unmerged entries", 1),
-		{ OPTION_STRING, 0, "prefix", &opts.prefix, "<subdirectory>/",
-		  "read the tree into the index under <subdirectory>/",
+			    N_("same as -m, but discard unmerged entries"), 1),
+		{ OPTION_STRING, 0, "prefix", &opts.prefix, N_("<subdirectory>/"),
+		  N_("read the tree into the index under <subdirectory>/"),
 		  PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP },
 		OPT_SET_INT('u', NULL, &opts.update,
-			    "update working tree with merge result", 1),
+			    N_("update working tree with merge result"), 1),
 		{ OPTION_CALLBACK, 0, "exclude-per-directory", &opts,
-		  "gitignore",
-		  "allow explicitly ignored files to be overwritten",
+		  N_("gitignore"),
+		  N_("allow explicitly ignored files to be overwritten"),
 		  PARSE_OPT_NONEG, exclude_per_directory_cb },
 		OPT_SET_INT('i', NULL, &opts.index_only,
-			    "don't check the working tree after merging", 1),
-		OPT__DRY_RUN(&opts.dry_run, "don't update the index or the work tree=
"),
+			    N_("don't check the working tree after merging"), 1),
+		OPT__DRY_RUN(&opts.dry_run, N_("don't update the index or the work t=
ree")),
 		OPT_SET_INT(0, "no-sparse-checkout", &opts.skip_sparse_checkout,
-			    "skip applying sparse checkout filter", 1),
+			    N_("skip applying sparse checkout filter"), 1),
 		OPT_SET_INT(0, "debug-unpack", &opts.debug_unpack,
-			    "debug unpack-trees", 1),
+			    N_("debug unpack-trees"), 1),
 		OPT_END()
 	};
=20
--=20
1.7.10.2.549.g9354186
