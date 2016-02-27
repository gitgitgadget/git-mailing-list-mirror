From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/22] submodule.c: mark strings for translation
Date: Sat, 27 Feb 2016 13:42:09 +0700
Message-ID: <1456555333-5853-19-git-send-email-pclouds@gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 07:43:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZYbe-0003pk-Ps
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 07:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756101AbcB0Gnz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 01:43:55 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36048 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbcB0Gny (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 01:43:54 -0500
Received: by mail-pf0-f173.google.com with SMTP id e127so64374668pfe.3
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FO+EQgOdzG/4lyP/ps89I/Gk2+/jbA+gx6IQM/GzxGk=;
        b=zg8pXDW0KayD2McilQV93/J1Fi5GYM7hsdtvDzKmj+QDfpVVrVlbyC9vt2+uDuuxGX
         ikuu5HzwH5NISykLKKSmZv9BvvMiFuWw2WTxz2uARGHmNtnlzO5bN9gtYGh2K8yT/kkS
         lnJpyAF60ZbYkLGYIun7vftgzFQ/TyAe1C3i8V8nL1ClAZhU0lwrzP9Lyu35s3fGMpMW
         Qdk0X/CVv5+WdTT4fk96KFdSTKzBtgXh+2EWyp+ZgB+KMOne7LhuIlmarkGu8IZqsanS
         oJxA42+YFlLuFAmrpf3d52r5Auvuhy3if08Jo80kCi4JHgEZ7YzkPirt7ROrm+2/jGdV
         eXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FO+EQgOdzG/4lyP/ps89I/Gk2+/jbA+gx6IQM/GzxGk=;
        b=Z3vVxQv197+nzDnUhzwes1B4+Aj7cVx0AnFHFrHdSILN1gx/Dwp45/r4CrAeJCCzlO
         M8IwJXASg/lhSp7qGjYz31NFaZY572DMbDkEcFFGSSUh9Gg07Ff0cIexpZTaOyNVz6cX
         N5oyhqWiRCgmNPtaBxx3WZbWKkPUCcqf1h4YOCtI7kDl8B2UvaBYV0VEhcnfxtCESpD7
         Nd08JBSWEpNprO1v4AFbmFAgMgrhbz12IcVayFIA+d9v4ZkDWeG2ylcrP4FE+ilu0cxQ
         J9qMCuDbs9+YGAR2JZNAAr5DwWbU2csLpdwyh126bhGQVuv2KDMFWnELzbP/H0Djys3R
         jxVQ==
X-Gm-Message-State: AD7BkJJEesX7hyB9Ou/mEtTCBPl2rXOh8Kk60Wc5CtJM5mDmVCNpRf7N+1aRj+lAS9qdKg==
X-Received: by 10.98.16.85 with SMTP id y82mr7618652pfi.90.1456555433606;
        Fri, 26 Feb 2016 22:43:53 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id v71sm991031pfa.63.2016.02.26.22.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2016 22:43:52 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:44:27 +0700
X-Mailer: git-send-email 2.8.0.rc0.205.g7ec8cf1
In-Reply-To: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287679>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 submodule.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/submodule.c b/submodule.c
index 24fb81a..4dd6ab3 100644
--- a/submodule.c
+++ b/submodule.c
@@ -187,7 +187,7 @@ void gitmodules_config(void)
 		strbuf_addstr(&gitmodules_path, work_tree);
 		strbuf_addstr(&gitmodules_path, "/.gitmodules");
 		if (read_cache() < 0)
-			die("index file corrupt");
+			die(_("index file corrupt"));
 		pos =3D cache_name_pos(".gitmodules", 11);
 		if (pos < 0) { /* .gitmodules not found or isn't merged */
 			pos =3D -1 - pos;
@@ -224,7 +224,7 @@ void handle_ignore_submodules_arg(struct diff_optio=
ns *diffopt,
 	else if (!strcmp(arg, "dirty"))
 		DIFF_OPT_SET(diffopt, IGNORE_DIRTY_SUBMODULES);
 	else if (strcmp(arg, "none"))
-		die("bad --ignore-submodules argument: %s", arg);
+		die(_("bad --ignore-submodules argument: %s"), arg);
 }
=20
 static int prepare_submodule_summary(struct rev_info *rev, const char =
*path,
@@ -372,7 +372,7 @@ static int submodule_needs_pushing(const char *path=
, const unsigned char sha1[20
 		cp.out =3D -1;
 		cp.dir =3D path;
 		if (start_command(&cp))
-			die("Could not run 'git rev-list %s --not --remotes -n 1' command i=
n submodule %s",
+			die(_("Could not run 'git rev-list %s --not --remotes -n 1' command=
 in submodule %s"),
 				sha1_to_hex(sha1), path);
 		if (strbuf_read(&buf, cp.out, 41))
 			needs_pushing =3D 1;
@@ -431,7 +431,7 @@ int find_unpushed_submodules(unsigned char new_sha1=
[20],
 	argv[3] =3D remotes_arg.buf;
 	setup_revisions(argc, argv, &rev, NULL);
 	if (prepare_revision_walk(&rev))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
=20
 	while ((commit =3D get_revision(&rev)) !=3D NULL)
 		find_unpushed_submodule_commits(commit, needs_pushing);
@@ -583,7 +583,7 @@ static void calculate_changed_submodule_paths(void)
 				   add_sha1_to_argv, &argv);
 	setup_revisions(argv.argc, argv.argv, &rev, NULL);
 	if (prepare_revision_walk(&rev))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
=20
 	/*
 	 * Collect all submodules (whether checked out or not) for which new
@@ -685,7 +685,7 @@ static int get_next_submodule(struct child_process =
*cp,
 			cp->env =3D local_repo_env;
 			cp->git_cmd =3D 1;
 			if (!spf->quiet)
-				strbuf_addf(err, "Fetching submodule %s%s\n",
+				strbuf_addf(err, _("Fetching submodule %s%s\n"),
 					    spf->prefix, ce->name);
 			argv_array_init(&cp->args);
 			argv_array_pushv(&cp->args, spf->args.argv);
@@ -743,7 +743,7 @@ int fetch_populated_submodules(const struct argv_ar=
ray *options,
 		goto out;
=20
 	if (read_cache() < 0)
-		die("index file corrupt");
+		die(_("index file corrupt"));
=20
 	argv_array_push(&spf.args, "fetch");
 	for (i =3D 0; i < options->argc; i++)
@@ -801,7 +801,7 @@ unsigned is_submodule_modified(const char *path, in=
t ignore_untracked)
 	cp.out =3D -1;
 	cp.dir =3D path;
 	if (start_command(&cp))
-		die("Could not run 'git status --porcelain' in submodule %s", path);
+		die(_("Could not run 'git status --porcelain' in submodule %s"), pat=
h);
=20
 	len =3D strbuf_read(&buf, cp.out, 1024);
 	line =3D buf.buf;
@@ -826,7 +826,7 @@ unsigned is_submodule_modified(const char *path, in=
t ignore_untracked)
 	close(cp.out);
=20
 	if (finish_command(&cp))
-		die("'git status --porcelain' failed in submodule %s", path);
+		die(_("'git status --porcelain' failed in submodule %s"), path);
=20
 	strbuf_release(&buf);
 	return dirty_submodule;
@@ -895,7 +895,7 @@ int ok_to_remove_submodule(const char *path)
 	cp.out =3D -1;
 	cp.dir =3D path;
 	if (start_command(&cp))
-		die("Could not run 'git status --porcelain -uall --ignore-submodules=
=3Dnone' in submodule %s", path);
+		die(_("Could not run 'git status --porcelain -uall --ignore-submodul=
es=3Dnone' in submodule %s"), path);
=20
 	len =3D strbuf_read(&buf, cp.out, 1024);
 	if (len > 2)
@@ -903,7 +903,7 @@ int ok_to_remove_submodule(const char *path)
 	close(cp.out);
=20
 	if (finish_command(&cp))
-		die("'git status --porcelain -uall --ignore-submodules=3Dnone' faile=
d in submodule %s", path);
+		die(_("'git status --porcelain -uall --ignore-submodules=3Dnone' fai=
led in submodule %s"), path);
=20
 	strbuf_release(&buf);
 	return ok_to_remove;
@@ -935,7 +935,7 @@ static int find_first_merges(struct object_array *r=
esult, const char *path,
=20
 	/* save all revisions from the above list that contain b */
 	if (prepare_revision_walk(&revs))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
 	while ((commit =3D get_revision(&revs)) !=3D NULL) {
 		struct object *o =3D &(commit->object);
 		if (in_merge_bases(b, commit))
@@ -978,7 +978,7 @@ static void print_commit(struct commit *commit)
 }
=20
 #define MERGE_WARNING(path, msg) \
-	warning("Failed to merge submodule %s (%s)", path, msg);
+	warning(_("Failed to merge submodule %s (%s)"), path, msg);
=20
 int merge_submodule(unsigned char result[20], const char *path,
 		    const unsigned char base[20], const unsigned char a[20],
--=20
2.8.0.rc0.205.g7ec8cf1
