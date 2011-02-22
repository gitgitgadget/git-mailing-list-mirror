From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 25/73] gettextize: git-commit basic messages
Date: Tue, 22 Feb 2011 23:41:44 +0000
Message-ID: <1298418152-27789-26-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:44:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1tm-0007ye-LK
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:44:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755234Ab1BVXoA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:00 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39375 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166Ab1BVXn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:57 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866600bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=w9ODTCAAK0EteC2et5KlL6A+A6SRRz5emrxVX6xpz8w=;
        b=IT9fWC98/5u2WU7oj6R+1wbWKQit1am51IK6aw8SuB+0riS7wqn8SxN0zYFq3g9zTQ
         d4sFg51vqXyC9ZvvDehBFAJjiwXoJ9p9M5xKCfTwSMgA+XMNk1ZRjWmhbnvgVv2YSczU
         0qI44+kWI+Y0rbNnXVUtsQFjb+ElKt597cGhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZGgtc2vn3DA9Xs4sbKI3vT3jECNkR7YSDHJ9C77qjUXou81W5HIeL38YrBwMW2/cgY
         0yfRxoj+lm1o3kCepJBBS1K/CG204K9NVrjM1b8zyQXUR+PFHaEhAsdauizQnANX8PdU
         KcfQrhYzZdFaGE3WXz13YjwM9k6XMEbyZDRKE=
Received: by 10.204.121.193 with SMTP id i1mr3052408bkr.212.1298418236216;
        Tue, 22 Feb 2011 15:43:56 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.55
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:55 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167598>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/commit.c |  118 +++++++++++++++++++++++++++-------------------=
--------
 1 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d7f55e3..c57f603 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -243,7 +243,7 @@ static void add_remove_files(struct string_list *li=
st)
=20
 		if (!lstat(p->string, &st)) {
 			if (add_to_cache(p->string, &st, 0))
-				die("updating files failed");
+				die(_("updating files failed"));
 		} else
 			remove_file_from_cache(p->string);
 	}
@@ -270,7 +270,7 @@ static void create_base_index(void)
 	opts.fn =3D oneway_merge;
 	tree =3D parse_tree_indirect(head_sha1);
 	if (!tree)
-		die("failed to unpack HEAD tree object");
+		die(_("failed to unpack HEAD tree object"));
 	parse_tree(tree);
 	init_tree_desc(&t, tree->buffer, tree->size);
 	if (unpack_trees(1, &t, &opts))
@@ -298,9 +298,9 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix, int
 		refresh_flags |=3D REFRESH_UNMERGED;
 	if (interactive) {
 		if (interactive_add(argc, argv, prefix) !=3D 0)
-			die("interactive add failed");
+			die(_("interactive add failed"));
 		if (read_cache_preload(NULL) < 0)
-			die("index file corrupt");
+			die(_("index file corrupt"));
 		commit_style =3D COMMIT_AS_IS;
 		return get_index_file();
 	}
@@ -309,7 +309,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix, int
 		pathspec =3D get_pathspec(prefix, argv);
=20
 	if (read_cache_preload(pathspec) < 0)
-		die("index file corrupt");
+		die(_("index file corrupt"));
=20
 	/*
 	 * Non partial, non as-is commit.
@@ -329,7 +329,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix, int
 		refresh_cache_or_die(refresh_flags);
 		if (write_cache(fd, active_cache, active_nr) ||
 		    close_lock_file(&index_lock))
-			die("unable to write new_index file");
+			die(_("unable to write new_index file"));
 		commit_style =3D COMMIT_NORMAL;
 		return index_lock.filename;
 	}
@@ -349,7 +349,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix, int
 		if (active_cache_changed) {
 			if (write_cache(fd, active_cache, active_nr) ||
 			    commit_locked_index(&index_lock))
-				die("unable to write new_index file");
+				die(_("unable to write new_index file"));
 		} else {
 			rollback_lock_file(&index_lock);
 		}
@@ -379,7 +379,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix, int
 	commit_style =3D COMMIT_PARTIAL;
=20
 	if (in_merge)
-		die("cannot do a partial commit during a merge.");
+		die(_("cannot do a partial commit during a merge."));
=20
 	memset(&partial, 0, sizeof(partial));
 	partial.strdup_strings =3D 1;
@@ -388,14 +388,14 @@ static char *prepare_index(int argc, const char *=
*argv, const char *prefix, int
=20
 	discard_cache();
 	if (read_cache() < 0)
-		die("cannot read the index");
+		die(_("cannot read the index"));
=20
 	fd =3D hold_locked_index(&index_lock, 1);
 	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
 	if (write_cache(fd, active_cache, active_nr) ||
 	    close_lock_file(&index_lock))
-		die("unable to write new_index file");
+		die(_("unable to write new_index file"));
=20
 	fd =3D hold_lock_file_for_update(&false_lock,
 				       git_path("next-index-%"PRIuMAX,
@@ -408,7 +408,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix, int
=20
 	if (write_cache(fd, active_cache, active_nr) ||
 	    close_lock_file(&false_lock))
-		die("unable to write temporary index file");
+		die(_("unable to write temporary index file"));
=20
 	discard_cache();
 	read_cache_from(false_lock.filename);
@@ -455,7 +455,7 @@ static int is_a_merge(const unsigned char *sha1)
 {
 	struct commit *commit =3D lookup_commit(sha1);
 	if (!commit || parse_commit(commit))
-		die("could not parse HEAD commit");
+		die(_("could not parse HEAD commit"));
 	return !!(commit->parents && commit->parents->next);
 }
=20
@@ -474,13 +474,13 @@ static void determine_author_info(struct strbuf *=
author_ident)
=20
 		a =3D strstr(use_message_buffer, "\nauthor ");
 		if (!a)
-			die("invalid commit: %s", use_message);
+			die(_("invalid commit: %s"), use_message);
=20
 		lb =3D strchrnul(a + strlen("\nauthor "), '<');
 		rb =3D strchrnul(lb, '>');
 		eol =3D strchrnul(rb, '\n');
 		if (!*lb || !*rb || !*eol)
-			die("invalid commit: %s", use_message);
+			die(_("invalid commit: %s"), use_message);
=20
 		if (lb =3D=3D a + strlen("\nauthor "))
 			/* \nauthor <foo@example.com> */
@@ -498,7 +498,7 @@ static void determine_author_info(struct strbuf *au=
thor_ident)
 		const char *rb =3D strchr(force_author, '>');
=20
 		if (!lb || !rb)
-			die("malformed --author parameter");
+			die(_("malformed --author parameter"));
 		name =3D xstrndup(force_author, lb - force_author);
 		email =3D xstrndup(lb + 2, rb - (lb + 2));
 	}
@@ -554,7 +554,7 @@ static char *cut_ident_timestamp_part(char *string)
 {
 	char *ket =3D strrchr(string, '>');
 	if (!ket || ket[1] !=3D ' ')
-		die("Malformed ident string: '%s'", string);
+		die(_("Malformed ident string: '%s'"), string);
 	*++ket =3D '\0';
 	return ket;
 }
@@ -588,7 +588,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 			struct commit *c;
 			c =3D lookup_commit_reference_by_name(squash_message);
 			if (!c)
-				die("could not lookup commit %s", squash_message);
+				die(_("could not lookup commit %s"), squash_message);
 			ctx.output_encoding =3D get_commit_output_encoding();
 			format_commit_message(c, "squash! %s\n\n", &sb,
 					      &ctx);
@@ -600,19 +600,19 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix,
 		hook_arg1 =3D "message";
 	} else if (logfile && !strcmp(logfile, "-")) {
 		if (isatty(0))
-			fprintf(stderr, "(reading log message from standard input)\n");
+			fprintf(stderr, _("(reading log message from standard input)\n"));
 		if (strbuf_read(&sb, 0, 0) < 0)
-			die_errno("could not read log from standard input");
+			die_errno(_("could not read log from standard input"));
 		hook_arg1 =3D "message";
 	} else if (logfile) {
 		if (strbuf_read_file(&sb, logfile, 0) < 0)
-			die_errno("could not read log file '%s'",
+			die_errno(_("could not read log file '%s'"),
 				  logfile);
 		hook_arg1 =3D "message";
 	} else if (use_message) {
 		buffer =3D strstr(use_message_buffer, "\n\n");
 		if (!buffer || buffer[2] =3D=3D '\0')
-			die("commit has empty message");
+			die(_("commit has empty message"));
 		strbuf_add(&sb, buffer + 2, strlen(buffer + 2));
 		hook_arg1 =3D "commit";
 		hook_arg2 =3D use_message;
@@ -621,22 +621,22 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix,
 		struct commit *commit;
 		commit =3D lookup_commit_reference_by_name(fixup_message);
 		if (!commit)
-			die("could not lookup commit %s", fixup_message);
+			die(_("could not lookup commit %s"), fixup_message);
 		ctx.output_encoding =3D get_commit_output_encoding();
 		format_commit_message(commit, "fixup! %s\n\n",
 				      &sb, &ctx);
 		hook_arg1 =3D "message";
 	} else if (!stat(git_path("MERGE_MSG"), &statbuf)) {
 		if (strbuf_read_file(&sb, git_path("MERGE_MSG"), 0) < 0)
-			die_errno("could not read MERGE_MSG");
+			die_errno(_("could not read MERGE_MSG"));
 		hook_arg1 =3D "merge";
 	} else if (!stat(git_path("SQUASH_MSG"), &statbuf)) {
 		if (strbuf_read_file(&sb, git_path("SQUASH_MSG"), 0) < 0)
-			die_errno("could not read SQUASH_MSG");
+			die_errno(_("could not read SQUASH_MSG"));
 		hook_arg1 =3D "squash";
 	} else if (template_file && !stat(template_file, &statbuf)) {
 		if (strbuf_read_file(&sb, template_file, 0) < 0)
-			die_errno("could not read '%s'", template_file);
+			die_errno(_("could not read '%s'"), template_file);
 		hook_arg1 =3D "template";
 	}
=20
@@ -659,7 +659,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
=20
 	fp =3D fopen(git_path(commit_editmsg), "w");
 	if (fp =3D=3D NULL)
-		die_errno("could not open '%s'", git_path(commit_editmsg));
+		die_errno(_("could not open '%s'"), git_path(commit_editmsg));
=20
 	if (cleanup_mode !=3D CLEANUP_NONE)
 		stripspace(&sb, 0);
@@ -683,7 +683,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 	}
=20
 	if (fwrite(sb.buf, 1, sb.len, fp) < sb.len)
-		die_errno("could not write commit template");
+		die_errno(_("could not write commit template"));
=20
 	strbuf_release(&sb);
=20
@@ -752,7 +752,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 		const char *parent =3D "HEAD";
=20
 		if (!active_nr && read_cache() < 0)
-			die("Cannot read index");
+			die(_("Cannot read index"));
=20
 		if (amend)
 			parent =3D "HEAD^1";
@@ -785,7 +785,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 		active_cache_tree =3D cache_tree();
 	if (cache_tree_update(active_cache_tree,
 			      active_cache, active_nr, 0, 0) < 0) {
-		error("Error building trees");
+		error(_("Error building trees"));
 		return 0;
 	}
=20
@@ -800,7 +800,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 		snprintf(index, sizeof(index), "GIT_INDEX_FILE=3D%s", index_file);
 		if (launch_editor(git_path(commit_editmsg), NULL, env)) {
 			fprintf(stderr,
-			"Please supply the message using either -m or -F option.\n");
+			_("Please supply the message using either -m or -F option.\n"));
 			exit(1);
 		}
 	}
@@ -880,7 +880,7 @@ static const char *find_author_by_nickname(const ch=
ar *name)
 		format_commit_message(commit, "%an <%ae>", &buf, &ctx);
 		return strbuf_detach(&buf, NULL);
 	}
-	die("No existing author found with '%s'", name);
+	die(_("No existing author found with '%s'"), name);
 }
=20
=20
@@ -895,7 +895,7 @@ static void handle_untracked_files_arg(struct wt_st=
atus *s)
 	else if (!strcmp(untracked_files_arg, "all"))
 		s->show_untracked_files =3D SHOW_ALL_UNTRACKED_FILES;
 	else
-		die("Invalid untracked files mode '%s'", untracked_files_arg);
+		die(_("Invalid untracked files mode '%s'"), untracked_files_arg);
 }
=20
 static int parse_and_validate_options(int argc, const char *argv[],
@@ -912,7 +912,7 @@ static int parse_and_validate_options(int argc, con=
st char *argv[],
 		force_author =3D find_author_by_nickname(force_author);
=20
 	if (force_author && renew_authorship)
-		die("Using both --reset-author and --author does not make sense");
+		die(_("Using both --reset-author and --author does not make sense"))=
;
=20
 	if (logfile || message.len || use_message || fixup_message)
 		use_editor =3D 0;
@@ -926,7 +926,7 @@ static int parse_and_validate_options(int argc, con=
st char *argv[],
=20
 	/* Sanity check options */
 	if (amend && initial_commit)
-		die("You have nothing to amend.");
+		die(_("You have nothing to amend."));
 	if (amend && in_merge)
 		die("You are in the middle of a merge -- cannot amend.");
 	if (fixup_message && squash_message)
@@ -940,22 +940,22 @@ static int parse_and_validate_options(int argc, c=
onst char *argv[],
 	if (logfile)
 		f++;
 	if (f > 1)
-		die("Only one of -c/-C/-F/--fixup can be used.");
+		die(_("Only one of -c/-C/-F/--fixup can be used."));
 	if (message.len && f > 0)
-		die("Option -m cannot be combined with -c/-C/-F/--fixup.");
+		die((_("Option -m cannot be combined with -c/-C/-F/--fixup.")));
 	if (edit_message)
 		use_message =3D edit_message;
 	if (amend && !use_message && !fixup_message)
 		use_message =3D "HEAD";
 	if (!use_message && renew_authorship)
-		die("--reset-author can be used only with -C, -c or --amend.");
+		die(_("--reset-author can be used only with -C, -c or --amend."));
 	if (use_message) {
 		const char *out_enc;
 		struct commit *commit;
=20
 		commit =3D lookup_commit_reference_by_name(use_message);
 		if (!commit)
-			die("could not lookup commit %s", use_message);
+			die(_("could not lookup commit %s"), use_message);
 		out_enc =3D get_commit_output_encoding();
 		use_message_buffer =3D logmsg_reencode(commit, out_enc);
=20
@@ -970,13 +970,13 @@ static int parse_and_validate_options(int argc, c=
onst char *argv[],
 	}
=20
 	if (!!also + !!only + !!all + !!interactive > 1)
-		die("Only one of --include/--only/--all/--interactive can be used.")=
;
+		die(_("Only one of --include/--only/--all/--interactive can be used.=
"));
 	if (argc =3D=3D 0 && (also || (only && !amend)))
-		die("No paths with --include/--only does not make sense.");
+		die(_("No paths with --include/--only does not make sense."));
 	if (argc =3D=3D 0 && only && amend)
-		only_include_assumed =3D "Clever... amending the last one with dirty=
 index.";
+		only_include_assumed =3D _("Clever... amending the last one with dir=
ty index.");
 	if (argc > 0 && !also && !only)
-		only_include_assumed =3D "Explicit paths specified without -i nor -o=
; assuming --only paths...";
+		only_include_assumed =3D _("Explicit paths specified without -i nor =
-o; assuming --only paths...");
 	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
 		cleanup_mode =3D use_editor ? CLEANUP_ALL : CLEANUP_SPACE;
 	else if (!strcmp(cleanup_arg, "verbatim"))
@@ -986,14 +986,14 @@ static int parse_and_validate_options(int argc, c=
onst char *argv[],
 	else if (!strcmp(cleanup_arg, "strip"))
 		cleanup_mode =3D CLEANUP_ALL;
 	else
-		die("Invalid cleanup mode %s", cleanup_arg);
+		die(_("Invalid cleanup mode %s"), cleanup_arg);
=20
 	handle_untracked_files_arg(s);
=20
 	if (all && argc > 0)
-		die("Paths with -a does not make sense.");
+		die(_("Paths with -a does not make sense."));
 	else if (interactive && argc > 0)
-		die("Paths with --interactive does not make sense.");
+		die(_("Paths with --interactive does not make sense."));
=20
 	if (null_termination && status_format =3D=3D STATUS_FORMAT_LONG)
 		status_format =3D STATUS_FORMAT_PORCELAIN;
@@ -1074,7 +1074,7 @@ static int git_status_config(const char *k, const=
 char *v, void *cb)
 		else if (!strcmp(v, "all"))
 			s->show_untracked_files =3D SHOW_ALL_UNTRACKED_FILES;
 		else
-			return error("Invalid untracked files mode '%s'", v);
+			return error(_("Invalid untracked files mode '%s'"), v);
 		return 0;
 	}
 	return git_diff_ui_config(k, v, NULL);
@@ -1180,9 +1180,9 @@ static void print_summary(const char *prefix, con=
st unsigned char *sha1)
=20
 	commit =3D lookup_commit(sha1);
 	if (!commit)
-		die("couldn't look up newly created commit");
+		die(_("couldn't look up newly created commit"));
 	if (!commit || parse_commit(commit))
-		die("could not parse newly created commit");
+		die(_("could not parse newly created commit"));
=20
 	strbuf_addstr(&format, "format:%h] %s");
=20
@@ -1336,7 +1336,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 			reflog_msg =3D "commit (amend)";
 		commit =3D lookup_commit(head_sha1);
 		if (!commit || parse_commit(commit))
-			die("could not parse HEAD commit");
+			die(_("could not parse HEAD commit"));
=20
 		for (c =3D commit->parents; c; c =3D c->next)
 			pptr =3D &commit_list_insert(c->item, pptr)->next;
@@ -1349,19 +1349,19 @@ int cmd_commit(int argc, const char **argv, con=
st char *prefix)
 		pptr =3D &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
 		fp =3D fopen(git_path("MERGE_HEAD"), "r");
 		if (fp =3D=3D NULL)
-			die_errno("could not open '%s' for reading",
+			die_errno(_("could not open '%s' for reading"),
 				  git_path("MERGE_HEAD"));
 		while (strbuf_getline(&m, fp, '\n') !=3D EOF) {
 			unsigned char sha1[20];
 			if (get_sha1_hex(m.buf, sha1) < 0)
-				die("Corrupt MERGE_HEAD file (%s)", m.buf);
+				die(_("Corrupt MERGE_HEAD file (%s)"), m.buf);
 			pptr =3D &commit_list_insert(lookup_commit(sha1), pptr)->next;
 		}
 		fclose(fp);
 		strbuf_release(&m);
 		if (!stat(git_path("MERGE_MODE"), &statbuf)) {
 			if (strbuf_read_file(&sb, git_path("MERGE_MODE"), 0) < 0)
-				die_errno("could not read MERGE_MODE");
+				die_errno(_("could not read MERGE_MODE"));
 			if (!strcmp(sb.buf, "no-ff"))
 				allow_fast_forward =3D 0;
 		}
@@ -1378,7 +1378,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 	if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
 		int saved_errno =3D errno;
 		rollback_index_files();
-		die("could not read commit message: %s", strerror(saved_errno));
+		die(_("could not read commit message: %s"), strerror(saved_errno));
 	}
=20
 	/* Truncate the message just before the diff, if any. */
@@ -1392,14 +1392,14 @@ int cmd_commit(int argc, const char **argv, con=
st char *prefix)
 		stripspace(&sb, cleanup_mode =3D=3D CLEANUP_ALL);
 	if (message_is_empty(&sb) && !allow_empty_message) {
 		rollback_index_files();
-		fprintf(stderr, "Aborting commit due to empty commit message.\n");
+		fprintf(stderr, _("Aborting commit due to empty commit message.\n"))=
;
 		exit(1);
 	}
=20
 	if (commit_tree(sb.buf, active_cache_tree->sha1, parents, commit_sha1=
,
 			author_ident.buf)) {
 		rollback_index_files();
-		die("failed to write commit object");
+		die(_("failed to write commit object"));
 	}
 	strbuf_release(&author_ident);
=20
@@ -1417,11 +1417,11 @@ int cmd_commit(int argc, const char **argv, con=
st char *prefix)
=20
 	if (!ref_lock) {
 		rollback_index_files();
-		die("cannot lock HEAD ref");
+		die(_("cannot lock HEAD ref"));
 	}
 	if (write_ref_sha1(ref_lock, commit_sha1, sb.buf) < 0) {
 		rollback_index_files();
-		die("cannot update HEAD ref");
+		die(_("cannot update HEAD ref"));
 	}
=20
 	unlink(git_path("MERGE_HEAD"));
@@ -1430,9 +1430,9 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 	unlink(git_path("SQUASH_MSG"));
=20
 	if (commit_index_files())
-		die ("Repository has been updated, but unable to write\n"
+		die (_("Repository has been updated, but unable to write\n"
 		     "new_index file. Check that disk is not full or quota is\n"
-		     "not exceeded, and then \"git reset HEAD\" to recover.");
+		     "not exceeded, and then \"git reset HEAD\" to recover."));
=20
 	rerere(0);
 	run_hook(get_index_file(), "post-commit", NULL);
--=20
1.7.2.3
