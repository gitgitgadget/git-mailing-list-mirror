From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 40/66] i18n: pack-objects: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:29 +0700
Message-ID: <1345465975-16927-41-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:43:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RKX-00086r-OP
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430Ab2HTMng convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:43:36 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377Ab2HTMne (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:43:34 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Y9QJaWIGt4QZFypTmNSIPXSzNjkJRKO335ridmDMLsw=;
        b=sAiycgQsJnWY8qp5gvzmQaAFm57xnADVHliEQCV1SyF/1bxusSSIHYvjbQvJIpImu5
         VC9+gOe5DAZaj6K6+i971yzYBi6lSLD+2lTmqyUEbL8giS04/lgEhsl32QBMPM9xIoO3
         vmpJm6Je4SxXTSb5lhPbhghbs47ee3233Wtlup0KcPdDURVLABGtLgu1s5ghS1ni5w+O
         kxwOI+T3k+QXr8fvWlVqvIC3RiwppzmumTDgtCLE7a79ee0l0dVz4GpGu7Pmvkk/GJdR
         Xa1GQUq4Q9AcpEdub3aaRpfoSTQ3HHaGE3IehCfLtjnIIfzkoeNv2VQ3bUY2g0URCQrH
         D3JA==
Received: by 10.66.84.163 with SMTP id a3mr26074962paz.61.1345466614538;
        Mon, 20 Aug 2012 05:43:34 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id wd6sm11050003pbc.15.2012.08.20.05.43.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:43:33 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:37:34 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203812>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 64 +++++++++++++++++++++++++-----------------=
--------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 782e7d0..5e14064 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -20,8 +20,8 @@
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
@@ -2445,67 +2445,67 @@ int cmd_pack_objects(int argc, const char **arg=
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
1.7.12.rc2.18.g61b472e
