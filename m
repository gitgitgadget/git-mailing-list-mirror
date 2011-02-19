From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 35/72] gettextize: git-grep basic messages
Date: Sat, 19 Feb 2011 19:24:18 +0000
Message-ID: <1298143495-3681-36-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:28:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsTn-0003Eb-OF
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105Ab1BST2G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:28:06 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56673 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756045Ab1BST15 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:57 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1970368ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=NiGlZJXy5YzEXXPkLjZojqjSkPlOabqX2i5lgLawGfQ=;
        b=OgWsmDCqw8YEWFgGFzKU4Nbg7y9+xasnnS9z8lSe23mhoLAj992alCB0vLZJ9rrO1B
         5Aozim2RKJB8ZW1bKFXxGTf1G6tHPXoHepY61W3Brz6EeTCOU012HeoXoXJQZYS74xvH
         iJMOmGzOjde+Kfsk90oF3Z4ff9AJVIFBYpvvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=v6PmlcgxNKkWsVp97ePPfCmbcFC0kqiYr8UB2FthpjtIOOVHU9JEKk0iWCn95VA+Om
         GmXxumtEkyIYDV3BHcnOcEpLfBByj/pNX5ncV6tFvp33wrS/ks1b24IbBlLgeFPMPhmB
         brqbGrA9yyr+Jc9kj03asBWjBRg4D6wpNmvWI=
Received: by 10.213.0.212 with SMTP id 20mr2541291ebc.64.1298143674938;
        Sat, 19 Feb 2011 11:27:54 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.54
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:54 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167344>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/grep.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index fdf7131..d35b76c 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -245,7 +245,7 @@ static void start_threads(struct grep_opt *opt)
 		err =3D pthread_create(&threads[i], NULL, run, o);
=20
 		if (err)
-			die("grep: failed to create thread: %s",
+			die(_("grep: failed to create thread: %s"),
 			    strerror(err));
 	}
 }
@@ -450,7 +450,7 @@ static void *load_sha1(const unsigned char *sha1, u=
nsigned long *size,
 	void *data =3D lock_and_read_sha1_file(sha1, &type, size);
=20
 	if (!data)
-		error("'%s': unable to read %s", name, sha1_to_hex(sha1));
+		error(_("'%s': unable to read %s"), name, sha1_to_hex(sha1));
=20
 	return data;
 }
@@ -501,7 +501,7 @@ static void *load_file(const char *filename, size_t=
 *sz)
 	if (lstat(filename, &st) < 0) {
 	err_ret:
 		if (errno !=3D ENOENT)
-			error("'%s': %s", filename, strerror(errno));
+			error(_("'%s': %s"), filename, strerror(errno));
 		return 0;
 	}
 	if (!S_ISREG(st.st_mode))
@@ -512,7 +512,7 @@ static void *load_file(const char *filename, size_t=
 *sz)
 		goto err_ret;
 	data =3D xmalloc(*sz + 1);
 	if (st.st_size !=3D read_in_full(i, data, *sz)) {
-		error("'%s': short read %s", filename, strerror(errno));
+		error(_("'%s': short read %s"), filename, strerror(errno));
 		close(i);
 		free(data);
 		return 0;
@@ -574,7 +574,7 @@ static void run_pager(struct grep_opt *opt, const c=
har *prefix)
 	argv[path_list->nr] =3D NULL;
=20
 	if (prefix && chdir(prefix))
-		die("Failed to chdir: %s", prefix);
+		die(_("Failed to chdir: %s"), prefix);
 	status =3D run_command_v_opt(argv, RUN_USING_SHELL);
 	if (status)
 		exit(status);
@@ -664,7 +664,7 @@ static int grep_tree(struct grep_opt *opt, const ch=
ar **paths,
=20
 			data =3D lock_and_read_sha1_file(entry.sha1, &type, &size);
 			if (!data)
-				die("unable to read tree (%s)",
+				die(_("unable to read tree (%s)"),
 				    sha1_to_hex(entry.sha1));
 			init_tree_desc(&sub, data, size);
 			hit |=3D grep_tree(opt, paths, &sub, tree_name, down);
@@ -690,13 +690,13 @@ static int grep_object(struct grep_opt *opt, cons=
t char **paths,
 		data =3D read_object_with_reference(obj->sha1, tree_type,
 						  &size, NULL);
 		if (!data)
-			die("unable to read tree (%s)", sha1_to_hex(obj->sha1));
+			die(_("unable to read tree (%s)"), sha1_to_hex(obj->sha1));
 		init_tree_desc(&tree, data, size);
 		hit =3D grep_tree(opt, paths, &tree, name, "");
 		free(data);
 		return hit;
 	}
-	die("unable to grep from object of type %s", typename(obj->type));
+	die(_("unable to grep from object of type %s"), typename(obj->type));
 }
=20
 static int grep_objects(struct grep_opt *opt, const char **paths,
@@ -748,7 +748,7 @@ static int context_callback(const struct option *op=
t, const char *arg,
 	}
 	value =3D strtol(arg, (char **)&endp, 10);
 	if (*endp) {
-		return error("switch `%c' expects a numerical value",
+		return error(_("switch `%c' expects a numerical value"),
 			     opt->short_name);
 	}
 	grep_opt->pre_context =3D grep_opt->post_context =3D value;
@@ -764,7 +764,7 @@ static int file_callback(const struct option *opt, =
const char *arg, int unset)
=20
 	patterns =3D fopen(arg, "r");
 	if (!patterns)
-		die_errno("cannot open '%s'", arg);
+		die_errno(_("cannot open '%s'"), arg);
 	while (strbuf_getline(&sb, patterns, '\n') =3D=3D 0) {
 		char *s;
 		size_t len;
@@ -1005,11 +1005,11 @@ int cmd_grep(int argc, const char **argv, const=
 char *prefix)
 	}
=20
 	if (!opt.pattern_list)
-		die("no pattern given.");
+		die(_("no pattern given."));
 	if (!opt.fixed && opt.ignore_case)
 		opt.regflags |=3D REG_ICASE;
 	if ((opt.regflags !=3D REG_NEWLINE) && opt.fixed)
-		die("cannot mix --fixed-strings and regexp");
+		die(_("cannot mix --fixed-strings and regexp"));
=20
 #ifndef NO_PTHREADS
 	if (online_cpus() =3D=3D 1 || !grep_threads_ok(&opt))
@@ -1034,7 +1034,7 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
 		if (!get_sha1(arg, sha1)) {
 			struct object *object =3D parse_object(sha1);
 			if (!object)
-				die("bad object %s", arg);
+				die(_("bad object %s"), arg);
 			add_object_array(object, arg, &list);
 			continue;
 		}
@@ -1086,9 +1086,9 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
=20
 	if (!use_index) {
 		if (cached)
-			die("--cached cannot be used with --no-index.");
+			die(_("--cached cannot be used with --no-index."));
 		if (list.nr)
-			die("--no-index cannot be used with revs.");
+			die(_("--no-index cannot be used with revs."));
 		hit =3D grep_directory(&opt, paths);
 	} else if (!list.nr) {
 		if (!cached)
@@ -1097,7 +1097,7 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
 		hit =3D grep_cache(&opt, paths, cached);
 	} else {
 		if (cached)
-			die("both --cached and trees are given.");
+			die(_("both --cached and trees are given."));
 		hit =3D grep_objects(&opt, paths, &list);
 	}
=20
--=20
1.7.2.3
