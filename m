From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 41/65] i18n: pack-objects: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:53 +0700
Message-ID: <1338203657-26486-39-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:24:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy3Y-0003mS-An
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754241Ab2E1LYG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:24:06 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58121 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab2E1LYF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:24:05 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4036469dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7OCMHYcvVx/bkthrsNGdNAVbprdOjtrt5bJynAhK91k=;
        b=UD6Ky0m8UA3AIEBHAQYbE1vtLtnqw00ZZeJh23jSppmt6eXnXmkjncwcC5kHTBMRVE
         n/eDnSZmy76bKJRwJNgeIJx83S2/vrK2fEcWXxyFpRVEyStFK3GSbcCE1xiq9uPMhbS3
         ipI5zIjOXZxLEEu/EMmVYXHiviScvqsQG/eyGAuh4Q4aPYNmOUfs9+oBa6iWhjc/d6aZ
         jE5Il5E1iXnjUcif2T1ZEF+LjkMBFOTyjBhGraUQBnFhb20X1L6Xsci5Jg5+BimbCH2Q
         gPT28CB7SVqRXeFNHx0pHF1fl9Wu6a+ze5E7u0iFYJrV/p/8XSYgTXVmZ5T4zKdqAtAz
         Rq0g==
Received: by 10.68.225.9 with SMTP id rg9mr26163784pbc.137.1338204245059;
        Mon, 28 May 2012 04:24:05 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id rk4sm18994921pbc.48.2012.05.28.04.24.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:24:04 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:19:58 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198677>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 64 +++++++++++++++++++++++++-----------------=
--------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1861093..a26ac22 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -19,8 +19,8 @@
 #include "thread-utils.h"
=20
 static const char *pack_usage[] =3D {
-	"git pack-objects --stdout [options...] [< ref-list | < object-list]"=
,
-	"git pack-objects [options...] base-name [< ref-list | < object-list]=
",
+	N_("git pack-objects --stdout [options...] [< ref-list | < object-lis=
t]"),
+	N_("git pack-objects [options...] base-name [< ref-list | < object-li=
st]"),
 	NULL
 };
=20
@@ -2362,67 +2362,67 @@ int cmd_pack_objects(int argc, const char **arg=
v, const char *prefix)
 	int rev_list_unpacked =3D 0, rev_list_all =3D 0, rev_list_reflog =3D =
0;
 	struct option pack_objects_options[] =3D {
 		OPT_SET_INT('q', "quiet", &progress,
-			    "do not show progress meter", 0),
+			    N_("do not show progress meter"), 0),
 		OPT_SET_INT(0, "progress", &progress,
-			    "show progress meter", 1),
+			    N_("show progress meter"), 1),
 		OPT_SET_INT(0, "all-progress", &progress,
-			    "show progress meter during object writing phase", 2),
+			    N_("show progress meter during object writing phase"), 2),
 		OPT_BOOL(0, "all-progress-implied",
 			 &all_progress_implied,
-			 "similar to --all-progress when progress meter is shown"),
-		{ OPTION_CALLBACK, 0, "index-version", NULL, "version[,offset]",
-		  "write the pack index file in the specified idx format version",
+			 N_("similar to --all-progress when progress meter is shown")),
+		{ OPTION_CALLBACK, 0, "index-version", NULL, N_("version[,offset]"),
+		  N_("write the pack index file in the specified idx format version"=
),
 		  0, option_parse_index_version },
 		OPT_ULONG(0, "max-pack-size", &pack_size_limit,
-			  "maximum size of each output pack file"),
+			  N_("maximum size of each output pack file")),
 		OPT_BOOL(0, "local", &local,
-			 "ignore borrowed objects from alternate object store"),
+			 N_("ignore borrowed objects from alternate object store")),
 		OPT_BOOL(0, "incremental", &incremental,
-			 "ignore packed objects"),
+			 N_("ignore packed objects")),
 		OPT_INTEGER(0, "window", &window,
-			    "limit pack window by objects"),
+			    N_("limit pack window by objects")),
 		OPT_ULONG(0, "window-memory", &window_memory_limit,
-			  "limit pack window by memory in addition to object limit"),
+			  N_("limit pack window by memory in addition to object limit")),
 		OPT_INTEGER(0, "depth", &depth,
-			    "maximum length of delta chain allowed in the resulting pack"),
+			    N_("maximum length of delta chain allowed in the resulting pack=
")),
 		OPT_BOOL(0, "reuse-delta", &reuse_delta,
-			 "reuse existing deltas"),
+			 N_("reuse existing deltas")),
 		OPT_BOOL(0, "reuse-object", &reuse_object,
-			 "reuse existing objects"),
+			 N_("reuse existing objects")),
 		OPT_BOOL(0, "delta-base-offset", &allow_ofs_delta,
-			 "use OFS_DELTA objects"),
+			 N_("use OFS_DELTA objects")),
 		OPT_INTEGER(0, "threads", &delta_search_threads,
-			    "use threads when searching for best delta matches"),
+			    N_("use threads when searching for best delta matches")),
 		OPT_BOOL(0, "non-empty", &non_empty,
-			 "do not create an empty pack output"),
+			 N_("do not create an empty pack output")),
 		OPT_BOOL(0, "revs", &use_internal_rev_list,
-			 "read revision arguments from standard input"),
+			 N_("read revision arguments from standard input")),
 		{ OPTION_SET_INT, 0, "unpacked", &rev_list_unpacked, NULL,
-		  "limit the objects to those that are not yet packed",
+		  N_("limit the objects to those that are not yet packed"),
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
 		{ OPTION_SET_INT, 0, "all", &rev_list_all, NULL,
-		  "include objects reachable from any reference",
+		  N_("include objects reachable from any reference"),
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
 		{ OPTION_SET_INT, 0, "reflog", &rev_list_reflog, NULL,
-		  "include objects referred by reflog entries",
+		  N_("include objects referred by reflog entries"),
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
 		OPT_BOOL(0, "stdout", &pack_to_stdout,
-			 "output pack to stdout"),
+			 N_("output pack to stdout")),
 		OPT_BOOL(0, "include-tag", &include_tag,
-			 "include tag objects that refer to objects to be packed"),
+			 N_("include tag objects that refer to objects to be packed")),
 		OPT_BOOL(0, "keep-unreachable", &keep_unreachable,
-			 "keep unreachable objects"),
-		{ OPTION_CALLBACK, 0, "unpack-unreachable", NULL, "time",
-		  "unpack unreachable objects newer than <time>",
+			 N_("keep unreachable objects")),
+		{ OPTION_CALLBACK, 0, "unpack-unreachable", NULL, N_("time"),
+		  N_("unpack unreachable objects newer than <time>"),
 		  PARSE_OPT_OPTARG, option_parse_unpack_unreachable },
 		OPT_BOOL(0, "thin", &thin,
-			 "create thin packs"),
+			 N_("create thin packs")),
 		OPT_BOOL(0, "honor-pack-keep", &ignore_packed_keep,
-			 "ignore packs that have companion .keep file"),
+			 N_("ignore packs that have companion .keep file")),
 		OPT_INTEGER(0, "compression", &pack_compression_level,
-			    "pack compression level"),
+			    N_("pack compression level")),
 		OPT_SET_INT(0, "keep-true-parents", &grafts_replace_parents,
-			    "do not hide commits by grafts", 0),
+			    N_("do not hide commits by grafts"), 0),
 		OPT_END(),
 	};
=20
--=20
1.7.10.2.549.g9354186
