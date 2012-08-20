From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 45/66] i18n: read-tree: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:34 +0700
Message-ID: <1345465975-16927-46-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:44:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RLA-00005C-Fw
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545Ab2HTMoL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:44:11 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377Ab2HTMoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:44:09 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=V0zm0yh5lfLgRWOt1MT8cp5VaBWoaqcVuNBBHmSZyQA=;
        b=R3RvERwqOhJY0x6oWY8Lj166hUzUnADfNzHl6F5RhFemeuAdCdgMHDvPXjTlJJQ1kX
         pUtqFo6ofkiPOLXkCO32+RzvwrQN9GUzCZjR4NwtlAQf37BoK1lO8nyCGtJMtC1Dbul1
         KuIvgBCRP43k8qMiD2+cImr4Y0bUq770o9nRpFmId1pfSzQJohSGOWeBTQHHhXYXwUP+
         38cyId4lW4HdKCxWLNrxvkPBtX4jj1aaaMmMOoPYPdfrVLWcm8vvX0RLtgkbEOSAlGb2
         gkEq+Kjm1EMGF+TR13mBThhOaKwt4lK2NPAp5aVsd0OjCYsSj6Uf17kgMq4xnRSNuu9E
         We/Q==
Received: by 10.66.78.99 with SMTP id a3mr29411752pax.22.1345466649675;
        Mon, 20 Aug 2012 05:44:09 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id ox5sm11024301pbc.75.2012.08.20.05.44.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:44:09 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:38:05 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203817>

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
1.7.12.rc2.18.g61b472e
