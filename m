From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 48/66] i18n: status: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:37 +0700
Message-ID: <1345465975-16927-49-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:44:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RLP-0000Ic-PW
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755629Ab2HTMoa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:44:30 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54012 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755610Ab2HTMo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:44:28 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so2156474dad.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=unZ62MmopuHLeSpB/fhIatnPMaTJsQCUPmDeNzbZWqU=;
        b=IXx5zPu7ztGpB1Yp/R1Mrq5qMAw0fVhbgiecYdjBsm2ob0ah9XpKiUqQkq47pspx10
         lGOh6fRuf4oosDPgzUn0BZqCht0BlZpba9akI+bR3lnWUbVnkBDLmY86ctDZ91tv4wlL
         AgDi8yd0rdeuWrNy9B/osl7dQ0idAkQyOB2dlrvB6YZvIQAkCTYjiRcmXi1wObmwbBKd
         jm6/YGG/e+04csnqAQ3QrYKRxpczaL7xdgnj/D3MBdmArxWbUyO/aLkmm3+0SWyWKWHj
         tD6/nfnRdEsxk+kEchYk+TJ5pwBa2nSgmtgGEbCblK8bc1E6YiPbyOaUSSNvVrVMRSsi
         1wTg==
Received: by 10.66.84.229 with SMTP id c5mr29542422paz.12.1345466668316;
        Mon, 20 Aug 2012 05:44:28 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id uu6sm7027027pbc.70.2012.08.20.05.44.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:44:27 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:38:28 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203820>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 33b78fe..feb43f4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -35,7 +35,7 @@ static const char * const builtin_commit_usage[] =3D =
{
 };
=20
 static const char * const builtin_status_usage[] =3D {
-	"git status [options] [--] <filepattern>...",
+	N_("git status [options] [--] <filepattern>..."),
 	NULL
 };
=20
@@ -1169,24 +1169,24 @@ int cmd_status(int argc, const char **argv, con=
st char *prefix)
 	int fd;
 	unsigned char sha1[20];
 	static struct option builtin_status_options[] =3D {
-		OPT__VERBOSE(&verbose, "be verbose"),
+		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT_SET_INT('s', "short", &status_format,
-			    "show status concisely", STATUS_FORMAT_SHORT),
+			    N_("show status concisely"), STATUS_FORMAT_SHORT),
 		OPT_BOOLEAN('b', "branch", &s.show_branch,
-			    "show branch information"),
+			    N_("show branch information")),
 		OPT_SET_INT(0, "porcelain", &status_format,
-			    "machine-readable output",
+			    N_("machine-readable output"),
 			    STATUS_FORMAT_PORCELAIN),
 		OPT_BOOLEAN('z', "null", &s.null_termination,
-			    "terminate entries with NUL"),
+			    N_("terminate entries with NUL")),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg,
-		  "mode",
-		  "show untracked files, optional modes: all, normal, no. (Default: =
all)",
+		  N_("mode"),
+		  N_("show untracked files, optional modes: all, normal, no. (Defaul=
t: all)"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 		OPT_BOOLEAN(0, "ignored", &show_ignored_in_status,
-			    "show ignored files"),
-		{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, "whe=
n",
-		  "ignore changes to submodules, optional when: all, dirty, untracke=
d. (Default: all)",
+			    N_("show ignored files")),
+		{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, N_("=
when"),
+		  N_("ignore changes to submodules, optional when: all, dirty, untra=
cked. (Default: all)"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 		OPT_COLUMN(0, "column", &s.colopts, N_("list untracked files in colu=
mns")),
 		OPT_END(),
--=20
1.7.12.rc2.18.g61b472e
