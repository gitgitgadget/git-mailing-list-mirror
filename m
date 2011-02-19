From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 08/72] gettextize: git-add basic messages
Date: Sat, 19 Feb 2011 19:23:51 +0000
Message-ID: <1298143495-3681-9-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:26:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsRL-00021o-QQ
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755858Ab1BSTZ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:25:57 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42014 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484Ab1BSTZz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:25:55 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1969964ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=fK54wYdfHkXrhuyfa3IYKWM991tQ0rl/jsNcdsKLv4o=;
        b=PSTGUpN56+QHh6uL9VwhnU2YmZi8YFkqiDxe6v13eXgs5Ow4/pkIVKr4VKeLhZ/CAk
         K+yvKex7M0TEeBWIn9fQNw3RcnR7S+6ebd1wXac8McpGFkhydcx0Avm72/sDtwHoHM+N
         iMW4M0skMhH1q8Zi7L2wiPnGaFylESJZEBsBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=CdAi2ST99Wyj80N1jxzk9Ma72S09vS/wA91j7TRisovL8tJMhQhkw3Sj8SIB2/4yPH
         hGGLDFuaB5OLX7+9YVAGFcuEX6z/Ebbk/wYV/LUS7xxRKBhm6Aj/sgW2pJnT7hJaxEmT
         U7nVvww1uzay3k5JmCMP/GwUf7ZdSPBtyPf5Y=
Received: by 10.213.12.200 with SMTP id y8mr2535057eby.52.1298143555214;
        Sat, 19 Feb 2011 11:25:55 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.25.54
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:25:54 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167315>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/add.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 42c906e..a9a78f4 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -38,7 +38,7 @@ static void update_callback(struct diff_queue_struct =
*q,
 		const char *path =3D p->one->path;
 		switch (p->status) {
 		default:
-			die("unexpected diff status %c", p->status);
+			die(_("unexpected diff status %c"), p->status);
 		case DIFF_STATUS_UNMERGED:
 			/*
 			 * ADD_CACHE_IGNORE_REMOVAL is unset if "git
@@ -64,7 +64,7 @@ static void update_callback(struct diff_queue_struct =
*q,
 		case DIFF_STATUS_TYPE_CHANGED:
 			if (add_file_to_index(&the_index, path, data->flags)) {
 				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
-					die("updating files failed");
+					die(_("updating files failed"));
 				data->add_errors++;
 			}
 			break;
@@ -172,7 +172,7 @@ static void treat_gitlinks(const char **pathspec)
 					/* strip trailing slash */
 					pathspec[j] =3D xstrndup(ce->name, len);
 				else
-					die ("Path '%s' is in submodule '%.*s'",
+					die (_("Path '%s' is in submodule '%.*s'"),
 						pathspec[j], len, ce->name);
 			}
 		}
@@ -191,7 +191,7 @@ static void refresh(int verbose, const char **paths=
pec)
 		      pathspec, seen, "Unstaged changes after refreshing the index:"=
);
 	for (i =3D 0; i < specs; i++) {
 		if (!seen[i])
-			die("pathspec '%s' did not match any files", pathspec[i]);
+			die(_("pathspec '%s' did not match any files"), pathspec[i]);
 	}
         free(seen);
 }
@@ -205,7 +205,7 @@ static const char **validate_pathspec(int argc, con=
st char **argv, const char *p
 		for (p =3D pathspec; *p; p++) {
 			if (has_symlink_leading_path(*p, strlen(*p))) {
 				int len =3D prefix ? strlen(prefix) : 0;
-				die("'%s' is beyond a symbolic link", *p + len);
+				die(_("'%s' is beyond a symbolic link"), *p + len);
 			}
 		}
 	}
@@ -272,7 +272,7 @@ static int edit_patch(int argc, const char **argv, =
const char *prefix)
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
=20
 	if (read_cache() < 0)
-		die ("Could not read the index");
+		die (_("Could not read the index"));
=20
 	init_revisions(&rev, prefix);
 	rev.diffopt.context =3D 7;
@@ -281,24 +281,24 @@ static int edit_patch(int argc, const char **argv=
, const char *prefix)
 	rev.diffopt.output_format =3D DIFF_FORMAT_PATCH;
 	out =3D open(file, O_CREAT | O_WRONLY, 0644);
 	if (out < 0)
-		die ("Could not open '%s' for writing.", file);
+		die (_("Could not open '%s' for writing."), file);
 	rev.diffopt.file =3D xfdopen(out, "w");
 	rev.diffopt.close_file =3D 1;
 	if (run_diff_files(&rev, 0))
-		die ("Could not write patch");
+		die (_("Could not write patch"));
=20
 	launch_editor(file, NULL, NULL);
=20
 	if (stat(file, &st))
-		die_errno("Could not stat '%s'", file);
+		die_errno(_("Could not stat '%s'"), file);
 	if (!st.st_size)
-		die("Empty patch. Aborted.");
+		die(_("Empty patch. Aborted."));
=20
 	memset(&child, 0, sizeof(child));
 	child.git_cmd =3D 1;
 	child.argv =3D apply_argv;
 	if (run_command(&child))
-		die ("Could not apply '%s'", file);
+		die (_("Could not apply '%s'"), file);
=20
 	unlink(file);
 	return 0;
@@ -354,7 +354,7 @@ static int add_files(struct dir_struct *dir, int fl=
ags)
 	for (i =3D 0; i < dir->nr; i++)
 		if (add_file_to_cache(dir->entries[i]->name, flags)) {
 			if (!ignore_add_errors)
-				die("adding files failed");
+				die(_("adding files failed"));
 			exit_status =3D 1;
 		}
 	return exit_status;
@@ -386,9 +386,9 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 	argv++;
=20
 	if (addremove && take_worktree_changes)
-		die("-A and -u are mutually incompatible");
+		die(_("-A and -u are mutually incompatible"));
 	if (!show_only && ignore_missing)
-		die("Option --ignore-missing can only be used together with --dry-ru=
n");
+		die(_("Option --ignore-missing can only be used together with --dry-=
run"));
 	if ((addremove || take_worktree_changes) && !argc) {
 		static const char *here[2] =3D { ".", NULL };
 		argc =3D 1;
@@ -408,14 +408,14 @@ int cmd_add(int argc, const char **argv, const ch=
ar *prefix)
 		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
=20
 	if (require_pathspec && argc =3D=3D 0) {
-		fprintf(stderr, "Nothing specified, nothing added.\n");
-		fprintf(stderr, "Maybe you wanted to say 'git add .'?\n");
+		fprintf(stderr, _("Nothing specified, nothing added.\n"));
+		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
 		return 0;
 	}
 	pathspec =3D validate_pathspec(argc, argv, prefix);
=20
 	if (read_cache() < 0)
-		die("index file corrupt");
+		die(_("index file corrupt"));
 	treat_gitlinks(pathspec);
=20
 	if (add_new_files) {
@@ -467,7 +467,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 	if (active_cache_changed) {
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    commit_locked_index(&lock_file))
-			die("Unable to write new index file");
+			die(_("Unable to write new index file"));
 	}
=20
 	return exit_status;
--=20
1.7.2.3
