From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 20/73] gettextize: git-checkout basic messages
Date: Tue, 22 Feb 2011 23:41:39 +0000
Message-ID: <1298418152-27789-21-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:47:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1wq-0001H8-NV
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755111Ab1BVXnz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:43:55 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39209 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584Ab1BVXnw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:52 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866615bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=OJHRCuMTGDKbsjqVMOhCId+FDYiE4bPfTTuuBDDYfJ0=;
        b=nTILGaLSlO/GFj2b3GmjgFiB/kAMd5v+Vgj5OwXcZEWewqM+06hvGnaWxUUeZKbmQ3
         Ol3f1/cBfzv2/VoTf4gSg3Dfr2JQrDlkYh0xwu5pYewN6Ffvpqhskwf5lDm+VQROeYfJ
         PSY8wM5Y+DMxVAAdvMxBPzUbJrcrkB+oLQukw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uuywoa3q42gHaJa0aSWzexjW0Fn6wA0pSaqtqcVp5s/pv4A/XUmp4rS8EoRuke0HcP
         B+O+u9pb+PVbkn+DehLfmJQ8gzCBhzUV7O1DFN9XBT7Ej5dB1JBhjvgo4q54A1WGBruz
         WxyTb45UO3QAlYSOzhIstB/RYh9xoleWLn3aY=
Received: by 10.204.32.216 with SMTP id e24mr3031816bkd.204.1298418231022;
        Tue, 22 Feb 2011 15:43:51 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.50
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:50 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167645>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/checkout.c |   68 ++++++++++++++++++++++++++------------------=
--------
 1 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index cd7f56e..b5060ab 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -116,7 +116,7 @@ static int check_all_stages(struct cache_entry *ce,=
 int pos)
 	    ce_stage(active_cache[pos+1]) !=3D 2 ||
 	    strcmp(active_cache[pos+2]->name, ce->name) ||
 	    ce_stage(active_cache[pos+2]) !=3D 3)
-		return error("path '%s' does not have all three versions",
+		return error(_("path '%s' does not have all three versions"),
 			     ce->name);
 	return 0;
 }
@@ -150,7 +150,7 @@ static int checkout_merged(int pos, struct checkout=
 *state)
 	    ce_stage(active_cache[pos+1]) !=3D 2 ||
 	    strcmp(active_cache[pos+2]->name, path) ||
 	    ce_stage(active_cache[pos+2]) !=3D 3)
-		return error("path '%s' does not have all 3 versions", path);
+		return error(_("path '%s' does not have all 3 versions"), path);
=20
 	read_mmblob(&ancestor, active_cache[pos]->sha1);
 	read_mmblob(&ours, active_cache[pos+1]->sha1);
@@ -167,7 +167,7 @@ static int checkout_merged(int pos, struct checkout=
 *state)
 	free(theirs.ptr);
 	if (status < 0 || !result_buf.ptr) {
 		free(result_buf.ptr);
-		return error("path '%s': cannot merge", path);
+		return error(_("path '%s': cannot merge"), path);
 	}
=20
 	/*
@@ -184,12 +184,12 @@ static int checkout_merged(int pos, struct checko=
ut *state)
 	 */
 	if (write_sha1_file(result_buf.ptr, result_buf.size,
 			    blob_type, sha1))
-		die("Unable to add merge result for '%s'", path);
+		die(_("Unable to add merge result for '%s'"), path);
 	ce =3D make_cache_entry(create_ce_mode(active_cache[pos+1]->ce_mode),
 			      sha1,
 			      path, 2, 0);
 	if (!ce)
-		die("make_cache_entry failed for path '%s'", path);
+		die(_("make_cache_entry failed for path '%s'"), path);
 	status =3D checkout_entry(ce, state, NULL);
 	return status;
 }
@@ -211,7 +211,7 @@ static int checkout_paths(struct tree *source_tree,=
 const char **pathspec,
=20
 	newfd =3D hold_locked_index(lock_file, 1);
 	if (read_cache_preload(pathspec) < 0)
-		return error("corrupt index file");
+		return error(_("corrupt index file"));
=20
 	if (source_tree)
 		read_tree_some(source_tree, pathspec);
@@ -239,14 +239,14 @@ static int checkout_paths(struct tree *source_tre=
e, const char **pathspec,
 			if (!ce_stage(ce))
 				continue;
 			if (opts->force) {
-				warning("path '%s' is unmerged", ce->name);
+				warning(_("path '%s' is unmerged"), ce->name);
 			} else if (stage) {
 				errs |=3D check_stage(stage, ce, pos);
 			} else if (opts->merge) {
 				errs |=3D check_all_stages(ce, pos);
 			} else {
 				errs =3D 1;
-				error("path '%s' is unmerged", ce->name);
+				error(_("path '%s' is unmerged"), ce->name);
 			}
 			pos =3D skip_same_name(ce, pos) - 1;
 		}
@@ -275,7 +275,7 @@ static int checkout_paths(struct tree *source_tree,=
 const char **pathspec,
=20
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    commit_locked_index(lock_file))
-		die("unable to write new index file");
+		die(_("unable to write new index file"));
=20
 	resolve_ref("HEAD", rev, 0, &flag);
 	head =3D lookup_commit_reference_gently(rev, 1);
@@ -292,7 +292,7 @@ static void show_local_changes(struct object *head,=
 struct diff_options *opts)
 	rev.diffopt.flags =3D opts->flags;
 	rev.diffopt.output_format |=3D DIFF_FORMAT_NAME_STATUS;
 	if (diff_setup_done(&rev.diffopt) < 0)
-		die("diff_setup_done failed");
+		die(_("diff_setup_done failed"));
 	add_pending_object(&rev, head, NULL);
 	run_diff_index(&rev, 0);
 }
@@ -366,7 +366,7 @@ static int merge_working_tree(struct checkout_opts =
*opts,
 	int newfd =3D hold_locked_index(lock_file, 1);
=20
 	if (read_cache_preload(NULL) < 0)
-		return error("corrupt index file");
+		return error(_("corrupt index file"));
=20
 	resolve_undo_clear();
 	if (opts->force) {
@@ -388,7 +388,7 @@ static int merge_working_tree(struct checkout_opts =
*opts,
 		refresh_cache(REFRESH_QUIET);
=20
 		if (unmerged_cache()) {
-			error("you need to resolve your current index first");
+			error(_("you need to resolve your current index first"));
 			return 1;
 		}
=20
@@ -470,7 +470,7 @@ static int merge_working_tree(struct checkout_opts =
*opts,
=20
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    commit_locked_index(lock_file))
-		die("unable to write new index file");
+		die(_("unable to write new index file"));
=20
 	if (!opts->force && !opts->quiet)
 		show_local_changes(&new->commit->object, &opts->diff_options);
@@ -519,7 +519,7 @@ static void update_refs_for_switch(struct checkout_=
opts *opts,
 				temp =3D log_all_ref_updates;
 				log_all_ref_updates =3D 1;
 				if (log_ref_setup(ref_name, log_file, sizeof(log_file))) {
-					fprintf(stderr, "Can not do reflog for '%s'\n",
+					fprintf(stderr, _("Can not do reflog for '%s'\n"),
 					    opts->new_orphan_branch);
 					log_all_ref_updates =3D temp;
 					return;
@@ -545,14 +545,14 @@ static void update_refs_for_switch(struct checkou=
t_opts *opts,
 		create_symref("HEAD", new->path, msg.buf);
 		if (!opts->quiet) {
 			if (old->path && !strcmp(new->path, old->path))
-				fprintf(stderr, "Already on '%s'\n",
+				fprintf(stderr, _("Already on '%s'\n"),
 					new->name);
 			else if (opts->new_branch)
 				fprintf(stderr, "Switched to%s branch '%s'\n",
 					opts->branch_exists ? " and reset" : " a new",
 					new->name);
 			else
-				fprintf(stderr, "Switched to branch '%s'\n",
+				fprintf(stderr, _("Switched to branch '%s'\n"),
 					new->name);
 		}
 		if (old->path && old->name) {
@@ -597,7 +597,7 @@ static int switch_branches(struct checkout_opts *op=
ts, struct branch_info *new)
 		new->name =3D "HEAD";
 		new->commit =3D old.commit;
 		if (!new->commit)
-			die("You are on a branch yet to be born");
+			die(_("You are on a branch yet to be born"));
 		parse_commit(new->commit);
 	}
=20
@@ -724,7 +724,7 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
=20
 	/* we can assume from now on new_branch =3D !new_branch_force */
 	if (opts.new_branch && opts.new_branch_force)
-		die("-B cannot be used with -b");
+		die(_("-B cannot be used with -b"));
=20
 	/* copy -B over to -b, so that we can just check the latter */
 	if (opts.new_branch_force)
@@ -732,28 +732,28 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
=20
 	if (patch_mode && (opts.track > 0 || opts.new_branch
 			   || opts.new_branch_log || opts.merge || opts.force))
-		die ("--patch is incompatible with all other options");
+		die (_("--patch is incompatible with all other options"));
=20
 	/* --track without -b should DWIM */
 	if (0 < opts.track && !opts.new_branch) {
 		const char *argv0 =3D argv[0];
 		if (!argc || !strcmp(argv0, "--"))
-			die ("--track needs a branch name");
+			die (_("--track needs a branch name"));
 		if (!prefixcmp(argv0, "refs/"))
 			argv0 +=3D 5;
 		if (!prefixcmp(argv0, "remotes/"))
 			argv0 +=3D 8;
 		argv0 =3D strchr(argv0, '/');
 		if (!argv0 || !argv0[1])
-			die ("Missing branch name; try -b");
+			die (_("Missing branch name; try -b"));
 		opts.new_branch =3D argv0 + 1;
 	}
=20
 	if (opts.new_orphan_branch) {
 		if (opts.new_branch)
-			die("--orphan and -b|-B are mutually exclusive");
+			die(_("--orphan and -b|-B are mutually exclusive"));
 		if (opts.track > 0)
-			die("--orphan cannot be used with -t");
+			die(_("--orphan cannot be used with -t"));
 		opts.new_branch =3D opts.new_orphan_branch;
 	}
=20
@@ -763,7 +763,7 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
 	}
=20
 	if (opts.force && opts.merge)
-		die("git checkout: -f and -m are incompatible");
+		die(_("git checkout: -f and -m are incompatible"));
=20
 	/*
 	 * case 1: git checkout <ref> -- [<paths>]
@@ -809,7 +809,7 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
=20
 		if (get_sha1_mb(arg, rev)) {
 			if (has_dash_dash)          /* case (1) */
-				die("invalid reference: %s", arg);
+				die(_("invalid reference: %s"), arg);
 			if (!patch_mode &&
 			    dwim_new_local_branch &&
 			    opts.track =3D=3D BRANCH_TRACK_UNSPECIFIED &&
@@ -846,7 +846,7 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
 			source_tree =3D parse_tree_indirect(rev);
=20
 		if (!source_tree)                   /* case (1): want a tree */
-			die("reference is not a tree: %s", arg);
+			die(_("reference is not a tree: %s"), arg);
 		if (!has_dash_dash) {/* case (3 -> 1) */
 			/*
 			 * Do not complain the most common case
@@ -872,7 +872,7 @@ no_reference:
 		const char **pathspec =3D get_pathspec(prefix, argv);
=20
 		if (!pathspec)
-			die("invalid path specification");
+			die(_("invalid path specification"));
=20
 		if (patch_mode)
 			return interactive_checkout(new.name, pathspec, &opts);
@@ -880,14 +880,14 @@ no_reference:
 		/* Checkout paths */
 		if (opts.new_branch) {
 			if (argc =3D=3D 1) {
-				die("git checkout: updating paths is incompatible with switching b=
ranches.\nDid you intend to checkout '%s' which can not be resolved as =
commit?", argv[0]);
+				die(_("git checkout: updating paths is incompatible with switching=
 branches.\nDid you intend to checkout '%s' which can not be resolved a=
s commit?"), argv[0]);
 			} else {
-				die("git checkout: updating paths is incompatible with switching b=
ranches.");
+				die(_("git checkout: updating paths is incompatible with switching=
 branches."));
 			}
 		}
=20
 		if (1 < !!opts.writeout_stage + !!opts.force + !!opts.merge)
-			die("git checkout: --ours/--theirs, --force and --merge are incompa=
tible when\nchecking out of the index.");
+			die(_("git checkout: --ours/--theirs, --force and --merge are incom=
patible when\nchecking out of the index."));
=20
 		return checkout_paths(source_tree, pathspec, &opts);
 	}
@@ -898,22 +898,22 @@ no_reference:
 	if (opts.new_branch) {
 		struct strbuf buf =3D STRBUF_INIT;
 		if (strbuf_check_branch_ref(&buf, opts.new_branch))
-			die("git checkout: we do not like '%s' as a branch name.",
+			die(_("git checkout: we do not like '%s' as a branch name."),
 			    opts.new_branch);
 		if (!get_sha1(buf.buf, rev)) {
 			opts.branch_exists =3D 1;
 			if (!opts.new_branch_force)
-				die("git checkout: branch %s already exists",
+				die(_("git checkout: branch %s already exists"),
 				    opts.new_branch);
 		}
 		strbuf_release(&buf);
 	}
=20
 	if (new.name && !new.commit) {
-		die("Cannot switch branch to a non-commit.");
+		die(_("Cannot switch branch to a non-commit."));
 	}
 	if (opts.writeout_stage)
-		die("--ours/--theirs is incompatible with switching branches.");
+		die(_("--ours/--theirs is incompatible with switching branches."));
=20
 	return switch_branches(&opts, &new);
 }
--=20
1.7.2.3
