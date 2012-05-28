From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 49/65] i18n: status: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:14:01 +0700
Message-ID: <1338203657-26486-47-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:25:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy4o-0005QK-1a
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338Ab2E1LZX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:25:23 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36112 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318Ab2E1LZV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:25:21 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4038533dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2vrZh9YvqD0yrSf9e7FRcn19I5TgsrkVITsre+L4b/U=;
        b=vSuxGmnmKPc5fRQdQoo/unZCB+NwxwMT0EP8DvtE/UeIHk9kU59d2RUpEvddWvOyU4
         1wgaN0RavDb5fQNN1jDHKhi9kduzjdRBVIwRv4Lq3E9IjXVRMyrAXgF9gTr2scEIws/Z
         FkdnZUqMtRQ1OzHO44rZptm1Z3bnJrhCAKeKuyUHJ6tr44WDzjcz0GNtuKkkf3mRZ/tz
         0RayBS31n3URrGTqzbjJirpOLPJRjp1PgCbHpsu0CWFV7nZGXRLZOyn/4yVZUiZ9jnmw
         ca7mujtfzRmUldaHV84c5H8UD49FokXjtTboxI4mY6wWnkOfEQXR/6VYgf8uB0fIHCAW
         1NvQ==
Received: by 10.68.138.166 with SMTP id qr6mr26026914pbb.163.1338204321140;
        Mon, 28 May 2012 04:25:21 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id rj4sm19011243pbc.30.2012.05.28.04.25.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:25:20 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:21:14 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198685>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 34d723b..d94719b 100644
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
@@ -1167,24 +1167,24 @@ int cmd_status(int argc, const char **argv, con=
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
 		OPT_COLUMN(0, "column", &s.colopts, "list untracked files in columns=
"),
 		OPT_END(),
--=20
1.7.10.2.549.g9354186
