From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 07/25] gettextize: git-grep basic messages
Date: Thu,  2 Sep 2010 19:40:28 +0000
Message-ID: <1283456446-22577-8-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 21:41:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFfY-00061i-3L
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756583Ab0IBTll convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:41:41 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:41644 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756520Ab0IBTlj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:41:39 -0400
Received: by mail-ww0-f42.google.com with SMTP id 18so59843wwi.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=/50EimBzq4aqBiW/J6aA2I0KH9PJFdypPJsGsqFlR1s=;
        b=WdTmEl27/ZbotnxJ+zEWOb+rEpZotq+tTd5ljfujcGH53UbonMcnJHJJi0Yg1RSZkP
         sbmFEh8Zpcxc+oHH1jHxPaRfC7t6ihLsJPBbiY3cSg3jLnhVQQ1pzwkm0PQkYk9GiSCg
         ObNh4QAD5CDseqVT/ERkLQIUgVpZ60nZ2jiWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Ch1RV2qgmFz/ahCiwbXjcZ1mtQAOUWPB2RJuX0j69sA7kDNiiLE13XhUHPg4o1uyY+
         tQvYJezkD1fdabS493DJ2SUGtQ1GP+GHDNLElAZeAl16KPSipxh9FABM1LWCITK8tJuH
         s+Q4PnptnGYihyjAscRxRNLtsXZKzsJgEj0+w=
Received: by 10.227.156.67 with SMTP id v3mr10177063wbw.147.1283456498469;
        Thu, 02 Sep 2010 12:41:38 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.41.37
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:41:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155169>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/grep.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index da32f3d..af5d227 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -249,7 +249,7 @@ static void start_threads(struct grep_opt *opt)
 		err =3D pthread_create(&threads[i], NULL, run, o);
=20
 		if (err)
-			die("grep: failed to create thread: %s",
+			die(_("grep: failed to create thread: %s"),
 			    strerror(err));
 	}
 }
@@ -454,7 +454,7 @@ static void *load_sha1(const unsigned char *sha1, u=
nsigned long *size,
 	void *data =3D lock_and_read_sha1_file(sha1, &type, size);
=20
 	if (!data)
-		error("'%s': unable to read %s", name, sha1_to_hex(sha1));
+		error(_("'%s': unable to read %s"), name, sha1_to_hex(sha1));
=20
 	return data;
 }
@@ -505,7 +505,7 @@ static void *load_file(const char *filename, size_t=
 *sz)
 	if (lstat(filename, &st) < 0) {
 	err_ret:
 		if (errno !=3D ENOENT)
-			error("'%s': %s", filename, strerror(errno));
+			error(_("'%s': %s"), filename, strerror(errno));
 		return 0;
 	}
 	if (!S_ISREG(st.st_mode))
@@ -516,7 +516,7 @@ static void *load_file(const char *filename, size_t=
 *sz)
 		goto err_ret;
 	data =3D xmalloc(*sz + 1);
 	if (st.st_size !=3D read_in_full(i, data, *sz)) {
-		error("'%s': short read %s", filename, strerror(errno));
+		error(_("'%s': short read %s"), filename, strerror(errno));
 		close(i);
 		free(data);
 		return 0;
@@ -578,7 +578,7 @@ static void run_pager(struct grep_opt *opt, const c=
har *prefix)
 	argv[path_list->nr] =3D NULL;
=20
 	if (prefix && chdir(prefix))
-		die("Failed to chdir: %s", prefix);
+		die(_("Failed to chdir: %s"), prefix);
 	status =3D run_command_v_opt(argv, RUN_USING_SHELL);
 	if (status)
 		exit(status);
@@ -668,7 +668,7 @@ static int grep_tree(struct grep_opt *opt, const ch=
ar **paths,
=20
 			data =3D lock_and_read_sha1_file(entry.sha1, &type, &size);
 			if (!data)
-				die("unable to read tree (%s)",
+				die(_("unable to read tree (%s)"),
 				    sha1_to_hex(entry.sha1));
 			init_tree_desc(&sub, data, size);
 			hit |=3D grep_tree(opt, paths, &sub, tree_name, down);
@@ -694,13 +694,13 @@ static int grep_object(struct grep_opt *opt, cons=
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
@@ -752,7 +752,7 @@ static int context_callback(const struct option *op=
t, const char *arg,
 	}
 	value =3D strtol(arg, (char **)&endp, 10);
 	if (*endp) {
-		return error("switch `%c' expects a numerical value",
+		return error(_("switch `%c' expects a numerical value"),
 			     opt->short_name);
 	}
 	grep_opt->pre_context =3D grep_opt->post_context =3D value;
@@ -768,7 +768,7 @@ static int file_callback(const struct option *opt, =
const char *arg, int unset)
=20
 	patterns =3D fopen(arg, "r");
 	if (!patterns)
-		die_errno("cannot open '%s'", arg);
+		die_errno(_("cannot open '%s'"), arg);
 	while (strbuf_getline(&sb, patterns, '\n') =3D=3D 0) {
 		char *s;
 		size_t len;
@@ -1009,11 +1009,11 @@ int cmd_grep(int argc, const char **argv, const=
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
@@ -1038,7 +1038,7 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
 		if (!get_sha1(arg, sha1)) {
 			struct object *object =3D parse_object(sha1);
 			if (!object)
-				die("bad object %s", arg);
+				die(_("bad object %s"), arg);
 			add_object_array(object, arg, &list);
 			continue;
 		}
@@ -1065,7 +1065,7 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
 	}
=20
 	if (show_in_pager && (cached || list.nr))
-		die("--open-files-in-pager only works on the worktree");
+		die(_("--open-files-in-pager only works on the worktree"));
=20
 	if (show_in_pager && opt.pattern_list && !opt.pattern_list->next) {
 		const char *pager =3D path_list.items[0].string;
@@ -1090,9 +1090,9 @@ int cmd_grep(int argc, const char **argv, const c=
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
@@ -1101,7 +1101,7 @@ int cmd_grep(int argc, const char **argv, const c=
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
1.7.2.2.614.g1dc9
