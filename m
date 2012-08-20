From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 65/66] Reduce translations by using same terminologies
Date: Mon, 20 Aug 2012 19:32:54 +0700
Message-ID: <1345465975-16927-66-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:46:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RN8-0001ec-LC
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754389Ab2HTMqQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:46:16 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab2HTMqO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:46:14 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9JmaATomfFfMW+RtpzYei++mkfNZF2A+zxdUvSYBNoY=;
        b=p878eGPqN49nGhzsXPtip1nWdTL2YkfKBfJ2Op2moPnd+ZFMi9VE0I/6S3XqLS/N9W
         azSlieFyDFqL3En7vnnEvlFCrBLwe22p9nTrcd4H3OaIgBwmdqYExNHUn7jTFJD7Knn4
         X9q5cZK/RKJ4nlHDCfy73ehwCT8EowiXMM3c17g1bky5Leau0cUvoWpSxUdAn4Uw32rN
         PlilQZrVxwnrYGoPbojdWcb3dmt5PAr1akvkq+VwekQKUZDQXp5Yp0GxyvxOvBUq4vUL
         DxeRXzKRI2Uv2lWgnLpYfa9eOnVIGkRjkJnA5VnXTBR8bqEgx+09xaLN8n1CYdnXKpo/
         lbIw==
Received: by 10.68.213.5 with SMTP id no5mr34946636pbc.24.1345466774758;
        Mon, 20 Aug 2012 05:46:14 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id pg9sm11052176pbb.26.2012.08.20.05.46.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:46:14 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:40:14 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203837>

Somewhere in help usage, we use both "message" and "msg", "command"
and "cmd", "key id" and "key-id". This patch makes all help text from
parseopt use the first form. Clearer and 3 fewer strings for
translators.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive.c         | 2 +-
 builtin/archive.c | 2 +-
 builtin/notes.c   | 4 ++--
 builtin/tag.c     | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/archive.c b/archive.c
index 2584324..4666404 100644
--- a/archive.c
+++ b/archive.c
@@ -343,7 +343,7 @@ static int parse_archive_args(int argc, const char =
**argv,
 		OPT_GROUP(""),
 		OPT_STRING(0, "remote", &remote, N_("repo"),
 			N_("retrieve the archive from remote repository <repo>")),
-		OPT_STRING(0, "exec", &exec, N_("cmd"),
+		OPT_STRING(0, "exec", &exec, N_("command"),
 			N_("path to the remote git-upload-archive command")),
 		OPT_END()
 	};
diff --git a/builtin/archive.c b/builtin/archive.c
index e7965bf..9a1cfd3 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -92,7 +92,7 @@ int cmd_archive(int argc, const char **argv, const ch=
ar *prefix)
 			N_("write the archive to this file")),
 		OPT_STRING(0, "remote", &remote, N_("repo"),
 			N_("retrieve the archive from remote repository <repo>")),
-		OPT_STRING(0, "exec", &exec, N_("cmd"),
+		OPT_STRING(0, "exec", &exec, N_("command"),
 			N_("path to the remote git-upload-archive command")),
 		OPT_END()
 	};
diff --git a/builtin/notes.c b/builtin/notes.c
index 423c6e8..554c801 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -531,7 +531,7 @@ static int add(int argc, const char **argv, const c=
har *prefix)
 	const unsigned char *note;
 	struct msg_arg msg =3D { 0, 0, STRBUF_INIT };
 	struct option options[] =3D {
-		{ OPTION_CALLBACK, 'm', "message", &msg, N_("msg"),
+		{ OPTION_CALLBACK, 'm', "message", &msg, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
 			parse_msg_arg},
 		{ OPTION_CALLBACK, 'F', "file", &msg, N_("file"),
@@ -688,7 +688,7 @@ static int append_edit(int argc, const char **argv,=
 const char *prefix)
 	const char * const *usage;
 	struct msg_arg msg =3D { 0, 0, STRBUF_INIT };
 	struct option options[] =3D {
-		{ OPTION_CALLBACK, 'm', "message", &msg, N_("msg"),
+		{ OPTION_CALLBACK, 'm', "message", &msg, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
 			parse_msg_arg},
 		{ OPTION_CALLBACK, 'F', "file", &msg, N_("file"),
diff --git a/builtin/tag.c b/builtin/tag.c
index c581e0a..9c3e067 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -460,7 +460,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 		OPT_BOOLEAN('s', "sign", &opt.sign, N_("annotated and GPG-signed tag=
")),
 		OPT_STRING(0, "cleanup", &cleanup_arg, N_("mode"),
 			N_("how to strip spaces and #comments from message")),
-		OPT_STRING('u', "local-user", &keyid, N_("key-id"),
+		OPT_STRING('u', "local-user", &keyid, N_("key id"),
 					N_("use another key to sign the tag")),
 		OPT__FORCE(&force, N_("replace the tag if exists")),
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
--=20
1.7.12.rc2.18.g61b472e
