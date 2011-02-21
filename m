From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/15] clone: mark basic messages for translation
Date: Mon, 21 Feb 2011 04:18:27 -0600
Message-ID: <20110221101827.GH32137@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <20110221040012.GB26968@elie>
 <20110221101229.GA32137@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 11:18:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrSqk-0002Jt-ES
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 11:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755061Ab1BUKSf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 05:18:35 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61870 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754980Ab1BUKSe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 05:18:34 -0500
Received: by mail-iw0-f174.google.com with SMTP id 8so1729136iwn.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 02:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=EDDQDcVa3GLPoqO/4RYMNVhoc2PRE+Mg1QmTFA69G3o=;
        b=Wz4JYYFT3W206KCP9t79I8/TEoPAM6oU9RTxlkltOsQe8N/VZQkphRKQlmOZ7Rdhn4
         jGvJgI9Mpn33zM+UnWVh00058WwRHeq+eg26ttbbncxebGHECIIWVxhFWp76s8OPgRhh
         Yc8r91VGnaqgD2jd09CHkaAcgb0q4G9x7MMZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=DsYRrU4I4asLh6xbZe6zS9hYiKMWwGhxwF6y8tsyJBeSqUt7XgtuTKh2Htu7O7gO+W
         VBeV6TAIj3hlG4GzAXbmxmigttgxfAgl5nbEq4fC7RqGaV5Le6ObRVDQ+VILp7rSjIjE
         FtHMIaWDRbQllzKu9g0csfsTgAFMu6274OSQ0=
Received: by 10.42.227.65 with SMTP id iz1mr1696420icb.463.1298283513675;
        Mon, 21 Feb 2011 02:18:33 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id gy41sm5074681ibb.23.2011.02.21.02.18.31
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 02:18:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110221101229.GA32137@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167461>

=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Date: Wed, 1 Sep 2010 15:44:13 +0000

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/clone.c |   54 +++++++++++++++++++++++++++--------------------=
-------
 1 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 60d9a64..f46d09b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -208,7 +208,7 @@ static void setup_reference(const char *repo)
 	if (is_directory(mkpath("%s/.git/objects", ref_git)))
 		ref_git =3D mkpath("%s/.git", ref_git);
 	else if (!is_directory(mkpath("%s/objects", ref_git)))
-		die("reference repository '%s' is not a local directory.",
+		die(_("reference repository '%s' is not a local directory."),
 		    option_reference);
=20
 	ref_git_copy =3D xstrdup(ref_git);
@@ -235,15 +235,15 @@ static void copy_or_link_directory(struct strbuf =
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
@@ -257,7 +257,7 @@ static void copy_or_link_directory(struct strbuf *s=
rc, struct strbuf *dest)
 		strbuf_setlen(dest, dest_len);
 		strbuf_addstr(dest, de->d_name);
 		if (stat(src->buf, &buf)) {
-			warning ("failed to stat %s\n", src->buf);
+			warning (_("failed to stat %s\n"), src->buf);
 			continue;
 		}
 		if (S_ISDIR(buf.st_mode)) {
@@ -267,16 +267,16 @@ static void copy_or_link_directory(struct strbuf =
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
@@ -305,7 +305,7 @@ static const struct ref *clone_local(const char *sr=
c_repo,
 	ret =3D transport_get_remote_refs(transport);
 	transport_disconnect(transport);
 	if (0 <=3D option_verbosity)
-		printf("done.\n");
+		printf(_("done.\n"));
 	return ret;
 }
=20
@@ -387,11 +387,11 @@ int cmd_clone(int argc, const char **argv, const =
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
@@ -399,7 +399,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
=20
 	if (option_bare) {
 		if (option_origin)
-			die("--bare and --origin %s options are incompatible.",
+			die(_("--bare and --origin %s options are incompatible."),
 			    option_origin);
 		option_no_checkout =3D 1;
 	}
@@ -418,7 +418,7 @@ int cmd_clone(int argc, const char **argv, const ch=
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
@@ -428,8 +428,8 @@ int cmd_clone(int argc, const char **argv, const ch=
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
@@ -438,7 +438,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	else {
 		work_tree =3D getenv("GIT_WORK_TREE");
 		if (work_tree && !stat(work_tree, &buf))
-			die("working tree '%s' already exists.", work_tree);
+			die(_("working tree '%s' already exists."), work_tree);
 	}
=20
 	if (option_bare || work_tree)
@@ -451,10 +451,10 @@ int cmd_clone(int argc, const char **argv, const =
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
@@ -465,7 +465,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 	setenv(CONFIG_ENVIRONMENT, mkpath("%s/config", git_dir), 1);
=20
 	if (safe_create_leading_directories_const(git_dir) < 0)
-		die("could not create leading directories of '%s'", git_dir);
+		die(_("could not create leading directories of '%s'"), git_dir);
 	set_git_dir(make_absolute_path(git_dir));
=20
 	if (0 <=3D option_verbosity)
@@ -527,7 +527,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		transport =3D transport_get(remote, remote->url[0]);
=20
 		if (!transport->get_refs_list || !transport->fetch)
-			die("Don't know how to clone %s", transport->url);
+			die(_("Don't know how to clone %s"), transport->url);
=20
 		transport_set_option(transport, TRANS_OPT_KEEP, "yes");
=20
@@ -566,8 +566,8 @@ int cmd_clone(int argc, const char **argv, const ch=
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
@@ -576,7 +576,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 			our_head_points_at =3D remote_head_points_at;
 	}
 	else {
-		warning("You appear to have cloned an empty repository.");
+		warning(_("You appear to have cloned an empty repository."));
 		our_head_points_at =3D NULL;
 		remote_head_points_at =3D NULL;
 		remote_head =3D NULL;
@@ -618,8 +618,8 @@ int cmd_clone(int argc, const char **argv, const ch=
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
@@ -655,7 +655,7 @@ int cmd_clone(int argc, const char **argv, const ch=
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
1.7.4.1
