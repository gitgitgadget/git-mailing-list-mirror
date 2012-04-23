From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/10] i18n: bundle: mark strings for translation
Date: Mon, 23 Apr 2012 19:30:30 +0700
Message-ID: <1335184230-8870-11-git-send-email-pclouds@gmail.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 14:35:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMIUO-00061a-Gu
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 14:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389Ab2DWMf2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Apr 2012 08:35:28 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55597 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab2DWMf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 08:35:26 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so3837007pbc.19
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 05:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=81OdpnSdPW5jD1JY+LbPbie6pW+/qQ7hOWXGm3cXdc8=;
        b=JxqCYY6Cb6ntZZ95abjhQttVvYkUMrK6yxS8hTmXUudDEvqBAVDJeRd5svM8IjBj/V
         ++YZ7R+XJXK8RRo2BMctFZfFC4Wm9fGaTBJgKIPawhyk1GemIDiuo+8UNEnvV64r1EAG
         QFnOB/6UJ4MyaF9R8DaAZCedN4+XiTauMwDYP30IF8XZ6rueW59YGATdLwqs4hXraTDu
         x319pq01T3lXPkGbNrVg57lVfEissrs8eY65wsiJ7ySjY94AArJGTyy9OdYYp9uAQRA6
         TG2TpZrs3Gv7cmo8JhPeBU2hFzPBEDCRDB946wWLKFDbAJehh6Em9erl9k6EtR5/3v1K
         0o6Q==
Received: by 10.68.201.169 with SMTP id kb9mr18296882pbc.146.1335184526330;
        Mon, 23 Apr 2012 05:35:26 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.59.47])
        by mx.google.com with ESMTPS id o2sm14272787pbq.61.2012.04.23.05.35.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Apr 2012 05:35:25 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 23 Apr 2012 19:32:09 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196124>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 bundle.c |   38 +++++++++++++++++++++-----------------
 1 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/bundle.c b/bundle.c
index d9cfd90..6d21c77 100644
--- a/bundle.c
+++ b/bundle.c
@@ -33,7 +33,7 @@ static int parse_bundle_header(int fd, struct bundle_=
header *header,
 	if (strbuf_getwholeline_fd(&buf, fd, '\n') ||
 	    strcmp(buf.buf, bundle_signature)) {
 		if (report_path)
-			error("'%s' does not look like a v2 bundle file",
+			error(_("'%s' does not look like a v2 bundle file"),
 			      report_path);
 		status =3D -1;
 		goto abort;
@@ -60,7 +60,7 @@ static int parse_bundle_header(int fd, struct bundle_=
header *header,
 		    (40 <=3D buf.len && !isspace(buf.buf[40])) ||
 		    (!is_prereq && buf.len <=3D 40)) {
 			if (report_path)
-				error("unrecognized header: %s%s (%d)",
+				error(_("unrecognized header: %s%s (%d)"),
 				      (is_prereq ? "-" : ""), buf.buf, (int)buf.len);
 			status =3D -1;
 			break;
@@ -86,7 +86,7 @@ int read_bundle_header(const char *path, struct bundl=
e_header *header)
 	int fd =3D open(path, O_RDONLY);
=20
 	if (fd < 0)
-		return error("could not open '%s'", path);
+		return error(_("could not open '%s'"), path);
 	return parse_bundle_header(fd, header, path);
 }
=20
@@ -137,7 +137,7 @@ int verify_bundle(struct bundle_header *header, int=
 verbose)
 	struct object_array refs;
 	struct commit *commit;
 	int i, ret =3D 0, req_nr;
-	const char *message =3D "Repository lacks these prerequisite commits:=
";
+	const char *message =3D _("Repository lacks these prerequisite commit=
s:");
=20
 	init_revisions(&revs, NULL);
 	for (i =3D 0; i < p->nr; i++) {
@@ -161,7 +161,7 @@ int verify_bundle(struct bundle_header *header, int=
 verbose)
 	revs.leak_pending =3D 1;
=20
 	if (prepare_revision_walk(&revs))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
=20
 	i =3D req_nr;
 	while (i && (commit =3D get_revision(&revs)))
@@ -183,12 +183,16 @@ int verify_bundle(struct bundle_header *header, i=
nt verbose)
 		struct ref_list *r;
=20
 		r =3D &header->references;
-		printf("The bundle contains %d ref%s\n",
-		       r->nr, (1 < r->nr) ? "s" : "");
+		printf_ln(Q_("The bundle contains %d ref",
+			     "The bundle contains %d refs",
+			     r->nr),
+			  r->nr);
 		list_refs(r, 0, NULL);
 		r =3D &header->prerequisites;
-		printf("The bundle requires these %d ref%s\n",
-		       r->nr, (1 < r->nr) ? "s" : "");
+		printf_ln(Q_("The bundle requires this ref",
+			     "The bundle requires these %d refs",
+			     r->nr),
+			  r->nr);
 		list_refs(r, 0, NULL);
 	}
 	return ret;
@@ -283,13 +287,13 @@ int create_bundle(struct bundle_header *header, c=
onst char *path,
 	strbuf_release(&buf);
 	fclose(rls_fout);
 	if (finish_command(&rls))
-		return error("rev-list died");
+		return error(_("rev-list died"));
=20
 	/* write references */
 	argc =3D setup_revisions(argc, argv, &revs, NULL);
=20
 	if (argc > 1)
-		return error("unrecognized argument: %s'", argv[1]);
+		return error(_("unrecognized argument: %s'"), argv[1]);
=20
 	object_array_remove_duplicates(&revs.pending);
=20
@@ -324,7 +328,7 @@ int create_bundle(struct bundle_header *header, con=
st char *path,
 		 * constraints.
 		 */
 		if (!(e->item->flags & SHOWN) && e->item->type =3D=3D OBJ_COMMIT) {
-			warning("ref '%s' is excluded by the rev-list options",
+			warning(_("ref '%s' is excluded by the rev-list options"),
 				e->name);
 			free(ref);
 			continue;
@@ -369,7 +373,7 @@ int create_bundle(struct bundle_header *header, con=
st char *path,
 		free(ref);
 	}
 	if (!ref_count)
-		die ("Refusing to create empty bundle.");
+		die(_("Refusing to create empty bundle."));
=20
 	/* end header */
 	write_or_die(bundle_fd, "\n", 1);
@@ -387,7 +391,7 @@ int create_bundle(struct bundle_header *header, con=
st char *path,
 	rls.out =3D bundle_fd;
 	rls.git_cmd =3D 1;
 	if (start_command(&rls))
-		return error("Could not spawn pack-objects");
+		return error(_("Could not spawn pack-objects"));
=20
 	/*
 	 * start_command closed bundle_fd if it was > 1
@@ -405,10 +409,10 @@ int create_bundle(struct bundle_header *header, c=
onst char *path,
 	}
 	close(rls.in);
 	if (finish_command(&rls))
-		return error ("pack-objects died");
+		return error(_("pack-objects died"));
 	if (!bundle_to_stdout) {
 		if (commit_lock_file(&lock))
-			die_errno("cannot create '%s'", path);
+			die_errno(_("cannot create '%s'"), path);
 	}
 	return 0;
 }
@@ -430,6 +434,6 @@ int unbundle(struct bundle_header *header, int bund=
le_fd, int flags)
 	ip.no_stdout =3D 1;
 	ip.git_cmd =3D 1;
 	if (run_command(&ip))
-		return error("index-pack died");
+		return error(_("index-pack died"));
 	return 0;
 }
--=20
1.7.8.36.g69ee2
