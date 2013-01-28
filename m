From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 4/4] branch: mark more strings for translation
Date: Mon, 28 Jan 2013 08:18:16 +0700
Message-ID: <1359335896-24406-4-git-send-email-pclouds@gmail.com>
References: <1359118225-14356-1-git-send-email-pclouds@gmail.com>
 <1359335896-24406-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 28 02:19:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzdNu-0008TD-Sa
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 02:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757202Ab3A1BTN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jan 2013 20:19:13 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33581 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757163Ab3A1BTL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 20:19:11 -0500
Received: by mail-pa0-f49.google.com with SMTP id bi1so1200200pad.36
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 17:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=quJtd7faVxlEiXobx0TfHir+C+Rmpxj0CUgNJ26bkZc=;
        b=w/kRvHf9Mj7qU3r9dJXpV7X9nvctecc5Cf8w/XM2YMIMb2ScS+S2dIVarOQW09bvhc
         8GKNh3+kk6MSdz3ITZOqg1kgBVRuac/+67P8a+qKhJtEyvFEQYVCpHiHSssb7pADHq5F
         tRIulinglRXsfrpf8QC+vFAH3FE7tfuWgfRkGrPNHFegUE16JE8Gu011FuQd48vG8DD6
         +6jraG+8W1lCuLnIMdwZsxzP0v14prHRdK4x4pyyT8hiVYt4locss2Vxciz3kWv3uvvy
         Lr6FFaSiCrEHVOJhcurDw2gs6txEGVamrWPkdFxi3R2XwCId57ZThh8I3R/MdYSdP4II
         nejw==
X-Received: by 10.68.220.162 with SMTP id px2mr33841803pbc.109.1359335951342;
        Sun, 27 Jan 2013 17:19:11 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id l8sm5628862pax.9.2013.01.27.17.19.07
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 17:19:10 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 Jan 2013 08:18:45 +0700
X-Mailer: git-send-email 1.8.1.1.459.g5970e58
In-Reply-To: <1359335896-24406-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214777>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Sun, Jan 27, 2013 at 6:55 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
 > For what it's worth, assuming this passes tests,

 It passes the tests. Although I doubt the tests are written to catch
 this.

 builtin/branch.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index ca61c5b..597b578 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -466,7 +466,7 @@ static void add_verbose_info(struct strbuf *out, st=
ruct ref_item *item,
 			     int verbose, int abbrev)
 {
 	struct strbuf subject =3D STRBUF_INIT, stat =3D STRBUF_INIT;
-	const char *sub =3D " **** invalid ref ****";
+	const char *sub =3D _(" **** invalid ref ****");
 	struct commit *commit =3D item->commit;
=20
 	if (commit && !parse_commit(commit)) {
@@ -590,7 +590,7 @@ static int print_ref_list(int kinds, int detached, =
int verbose, int abbrev, stru
 		struct commit *filter;
 		filter =3D lookup_commit_reference_gently(merge_filter_ref, 0);
 		if (!filter)
-			die("object '%s' does not point to a commit",
+			die(_("object '%s' does not point to a commit"),
 			    sha1_to_hex(merge_filter_ref));
=20
 		filter->object.flags |=3D UNINTERESTING;
@@ -854,7 +854,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
=20
 		if (!argc) {
 			if (detached)
-				die("Cannot give description to detached HEAD");
+				die(_("Cannot give description to detached HEAD"));
 			branch_name =3D head;
 		} else if (argc =3D=3D 1)
 			branch_name =3D argv[0];
@@ -866,10 +866,11 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
 			strbuf_release(&branch_ref);
=20
 			if (!argc)
-				return error("No commit on branch '%s' yet.",
+				return error(_("No commit on branch '%s' yet."),
 					     branch_name);
 			else
-				return error("No such branch '%s'.", branch_name);
+				return error(_("No branch named '%s'."),
+					     branch_name);
 		}
 		strbuf_release(&branch_ref);
=20
--=20
1.8.1.1.459.g5970e58
