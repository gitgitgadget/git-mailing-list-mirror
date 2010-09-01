From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 02/13] gettextize: git-clone basic messages
Date: Wed,  1 Sep 2010 20:43:54 +0000
Message-ID: <1283373845-2022-3-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 01 22:45:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OquBQ-000790-E8
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 22:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711Ab0IAUod convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 16:44:33 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54032 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626Ab0IAUoc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 16:44:32 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so478054wwj.1
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 13:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=G4E3iwxsi4WvvxFtkpTlTYbY3305H7dyxvdEzCUsYT8=;
        b=Ez2EBZwWS2qTRr9YlR7QWSFF+834Yx3OBrqK4NhdDohc3prr1O/ueLqTigDbN4UVl1
         +ToebGyAx6BF94hJ7r5z0md4cvzzzjemFUHIA6Ah1bEO0jBK4WCESTW1NGLWZ8jMguWW
         pkF5j7Vv4tKJHWvYKZYdHF1V4Xt3XwSVSqobw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=F5MkTvP0A0QtYLAwf8p355CJcAmjpu93OcmudYY/lvUZGD6Oeeg9ULAXk3mBXUP3cg
         Vso4CpaARwSY/qUVNuHFRbAP5jk2QA0dL0l7tEfUyVethtsZS4ndpNHXLXHLd5oHtdDB
         c8T6IW350ibNGe9A1bNj1LbkKoEkYDzxfkaCQ=
Received: by 10.227.147.204 with SMTP id m12mr8686757wbv.131.1283373871132;
        Wed, 01 Sep 2010 13:44:31 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm6461150weq.16.2010.09.01.13.44.30
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 13:44:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.579.g2183d
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155083>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/clone.c |   54 +++++++++++++++++++++++++++--------------------=
-------
 1 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 994d527..0b595ba 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -205,7 +205,7 @@ static void setup_reference(const char *repo)
 	if (is_directory(mkpath("%s/.git/objects", ref_git)))
 		ref_git =3D mkpath("%s/.git", ref_git);
 	else if (!is_directory(mkpath("%s/objects", ref_git)))
-		die("reference repository '%s' is not a local directory.",
+		die(_("reference repository '%s' is not a local directory."),
 		    option_reference);
=20
 	ref_git_copy =3D xstrdup(ref_git);
@@ -232,15 +232,15 @@ static void copy_or_link_directory(struct strbuf =
*src, struct strbuf *dest)
=20
 	dir =3D opendir(src->buf);
 	if (!dir)
-		die_errno("failed to open '%s'", src->buf);
+		die_errno(_("failed to open '%s'"), src->buf);
=20
 	if (mkdir(dest->buf, 0777)) {
 		if (errno !=3D EEXIST)
-			die_errno("failed to create directory '%s'", dest->buf);
+			die_errno(_("failed to create directory '%s'"), dest->buf);
 		else if (stat(dest->buf, &buf))
-			die_errno("failed to stat '%s'", dest->buf);
+			die_errno(_("failed to stat '%s'"), dest->buf);
 		else if (!S_ISDIR(buf.st_mode))
-			die("%s exists and is not a directory", dest->buf);
+			die(_("%s exists and is not a directory"), dest->buf);
 	}
=20
 	strbuf_addch(src, '/');
@@ -254,7 +254,7 @@ static void copy_or_link_directory(struct strbuf *s=
rc, struct strbuf *dest)
 		strbuf_setlen(dest, dest_len);
 		strbuf_addstr(dest, de->d_name);
 		if (stat(src->buf, &buf)) {
-			warning ("failed to stat %s\n", src->buf);
+			warning (_("failed to stat %s\n"), src->buf);
 			continue;
 		}
 		if (S_ISDIR(buf.st_mode)) {
@@ -264,16 +264,16 @@ static void copy_or_link_directory(struct strbuf =
*src, struct strbuf *dest)
 		}
=20
 		if (unlink(dest->buf) && errno !=3D ENOENT)
-			die_errno("failed to unlink '%s'", dest->buf);
+			die_errno(_("failed to unlink '%s'"), dest->buf);
 		if (!option_no_hardlinks) {
 			if (!link(src->buf, dest->buf))
 				continue;
 			if (option_local)
-				die_errno("failed to create link '%s'", dest->buf);
+				die_errno(_("failed to create link '%s'"), dest->buf);
 			option_no_hardlinks =3D 1;
 		}
 		if (copy_file_with_time(dest->buf, src->buf, 0666))
-			die_errno("failed to copy file to '%s'", dest->buf);
+			die_errno(_("failed to copy file to '%s'"), dest->buf);
 	}
 	closedir(dir);
 }
@@ -302,7 +302,7 @@ static const struct ref *clone_local(const char *sr=
c_repo,
 	ret =3D transport_get_remote_refs(transport);
 	transport_disconnect(transport);
 	if (0 <=3D option_verbosity)
-		printf("done.\n");
+		printf(_("done.\n"));
 	return ret;
 }
=20
@@ -384,11 +384,11 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
 			     builtin_clone_usage, 0);
=20
 	if (argc > 2)
-		usage_msg_opt("Too many arguments.",
+		usage_msg_opt(_("Too many arguments."),
 			builtin_clone_usage, builtin_clone_options);
=20
 	if (argc =3D=3D 0)
-		usage_msg_opt("You must specify a repository to clone.",
+		usage_msg_opt(_("You must specify a repository to clone."),
 			builtin_clone_usage, builtin_clone_options);
=20
 	if (option_mirror)
@@ -396,7 +396,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
=20
 	if (option_bare) {
 		if (option_origin)
-			die("--bare and --origin %s options are incompatible.",
+			die(_("--bare and --origin %s options are incompatible."),
 			    option_origin);
 		option_no_checkout =3D 1;
 	}
@@ -415,7 +415,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		repo =3D repo_name;
 	is_local =3D path && !is_bundle;
 	if (is_local && option_depth)
-		warning("--depth is ignored in local clones; use file:// instead.");
+		warning(_("--depth is ignored in local clones; use file:// instead."=
));
=20
 	if (argc =3D=3D 2)
 		dir =3D xstrdup(argv[1]);
@@ -425,8 +425,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
=20
 	dest_exists =3D !stat(dir, &buf);
 	if (dest_exists && !is_empty_dir(dir))
-		die("destination path '%s' already exists and is not "
-			"an empty directory.", dir);
+		die(_("destination path '%s' already exists and is not "
+			"an empty directory."), dir);
=20
 	strbuf_addf(&reflog_msg, "clone: from %s", repo);
=20
@@ -435,7 +435,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	else {
 		work_tree =3D getenv("GIT_WORK_TREE");
 		if (work_tree && !stat(work_tree, &buf))
-			die("working tree '%s' already exists.", work_tree);
+			die(_("working tree '%s' already exists."), work_tree);
 	}
=20
 	if (option_bare || work_tree)
@@ -448,10 +448,10 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
 	if (!option_bare) {
 		junk_work_tree =3D work_tree;
 		if (safe_create_leading_directories_const(work_tree) < 0)
-			die_errno("could not create leading directories of '%s'",
+			die_errno(_("could not create leading directories of '%s'"),
 				  work_tree);
 		if (!dest_exists && mkdir(work_tree, 0755))
-			die_errno("could not create work tree dir '%s'.",
+			die_errno(_("could not create work tree dir '%s'."),
 				  work_tree);
 		set_git_work_tree(work_tree);
 	}
@@ -462,7 +462,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	setenv(CONFIG_ENVIRONMENT, mkpath("%s/config", git_dir), 1);
=20
 	if (safe_create_leading_directories_const(git_dir) < 0)
-		die("could not create leading directories of '%s'", git_dir);
+		die(_("could not create leading directories of '%s'"), git_dir);
 	set_git_dir(make_absolute_path(git_dir));
=20
 	if (0 <=3D option_verbosity)
@@ -524,7 +524,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		transport =3D transport_get(remote, remote->url[0]);
=20
 		if (!transport->get_refs_list || !transport->fetch)
-			die("Don't know how to clone %s", transport->url);
+			die(_("Don't know how to clone %s"), transport->url);
=20
 		transport_set_option(transport, TRANS_OPT_KEEP, "yes");
=20
@@ -563,8 +563,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 			strbuf_release(&head);
=20
 			if (!our_head_points_at) {
-				warning("Remote branch %s not found in "
-					"upstream %s, using HEAD instead",
+				warning(_("Remote branch %s not found in "
+					"upstream %s, using HEAD instead"),
 					option_branch, option_origin);
 				our_head_points_at =3D remote_head_points_at;
 			}
@@ -573,7 +573,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 			our_head_points_at =3D remote_head_points_at;
 	}
 	else {
-		warning("You appear to have cloned an empty repository.");
+		warning(_("You appear to have cloned an empty repository."));
 		our_head_points_at =3D NULL;
 		remote_head_points_at =3D NULL;
 		remote_head =3D NULL;
@@ -615,8 +615,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	} else {
 		/* Nothing to checkout out */
 		if (!option_no_checkout)
-			warning("remote HEAD refers to nonexistent ref, "
-				"unable to checkout.\n");
+			warning(_("remote HEAD refers to nonexistent ref, "
+				"unable to checkout.\n"));
 		option_no_checkout =3D 1;
 	}
=20
@@ -652,7 +652,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
=20
 		if (write_cache(fd, active_cache, active_nr) ||
 		    commit_locked_index(lock_file))
-			die("unable to write new index file");
+			die(_("unable to write new index file"));
=20
 		err |=3D run_hook(NULL, "post-checkout", sha1_to_hex(null_sha1),
 				sha1_to_hex(our_head_points_at->old_sha1), "1",
--=20
1.7.2.2.579.g2183d
