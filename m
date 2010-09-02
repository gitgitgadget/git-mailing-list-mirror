From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 08/25] gettextize: git-log basic messages
Date: Thu,  2 Sep 2010 19:40:29 +0000
Message-ID: <1283456446-22577-9-git-send-email-avarab@gmail.com>
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
	id 1OrFfZ-00061i-61
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756612Ab0IBTlo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:41:44 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61967 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756520Ab0IBTll (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:41:41 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so1282023wwj.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=S9b6sLSHba+9IEkUaT/RyY3syEwc+j1T/ZyOBMFUDaY=;
        b=EMy5lH3v7LBKEpdXUDet9Zr4Yi+1LF+X2OMLp0Y68hprnsmkKGu1afwTugU9W8j6jD
         q0HJq46+QedHBhekVjWyIp0b/xRSnk2ZA7ahd1RD2owzU/qZ3NI2xz6MciIiAD4DUh0f
         MY19OC6R0eiRPhBSk6ogEqaq8orX/fTIFcJn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Z24tBmSPZP2mZKo8uTaN+uxdnT6q6uCcT3YIXRkjd55lO0BjUC6u7pLwk2nDQZwQj3
         YKgrZ6Ll6YxnuWOHXzixGcInXQWFwq8+YnxNEJZagdApyRWHmtmPLVcwbQmNd8AS4JJD
         DZASXQf8V2iEzwYn+K7omFeyga9pI70vcKKoA=
Received: by 10.227.155.143 with SMTP id s15mr333384wbw.154.1283456501064;
        Thu, 02 Sep 2010 12:41:41 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.41.40
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:41:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155168>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/log.c |   74 ++++++++++++++++++++++++++++---------------------=
-------
 1 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index ed8598e..460353b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -141,9 +141,9 @@ static void cmd_log_init(int argc, const char **arg=
v, const char *prefix,
 			free((void *)fullpath);
 			if (range->nr =3D=3D 0) {
 				if (range->next) {
-					die("Path %s need a -L <range> option\n"
+					die(_("Path %s need a -L <range> option\n"
 					"If you want follow the history of the whole file "
-					"use 'git log -L 1,$ <path>'", range->spec->path);
+					"use 'git log -L 1,$ <path>'"), range->spec->path);
 				} else {
 					parse_options_next(&ctx, 1);
 					continue;
@@ -167,7 +167,7 @@ parse_done:
=20
 	/* die if '-L <range>' with no pathspec follow */
 	if (range->nr > 0 && range->spec =3D=3D NULL)
-		die("Each -L should follow a path");
+		die(_("Each -L should follow a path"));
 	/* clear up the last range */
 	if (range->nr =3D=3D 0) {
 		struct diff_line_range *r =3D range->next;
@@ -201,7 +201,7 @@ parse_done:
 			const char *v =3D skip_prefix(arg, "--decorate=3D");
 			decoration_style =3D parse_decoration_style(arg, v);
 			if (decoration_style < 0)
-				die("invalid --decorate option: %s", arg);
+				die(_("invalid --decorate option: %s"), arg);
 			decoration_given =3D 1;
 		} else if (!strcmp(arg, "--no-decorate")) {
 			decoration_style =3D 0;
@@ -210,7 +210,7 @@ parse_done:
 		} else if (!strcmp(arg, "-h")) {
 			usage(builtin_log_usage);
 		} else
-			die("unrecognized argument: %s", arg);
+			die(_("unrecognized argument: %s"), arg);
 	}
=20
 	/*
@@ -259,7 +259,7 @@ static void show_early_header(struct rev_info *rev,=
 const char *stage, int nr)
 		if (rev->commit_format !=3D CMIT_FMT_ONELINE)
 			putchar(rev->diffopt.line_termination);
 	}
-	printf("Final output: %d %s\n", nr, stage);
+	printf(_("Final output: %d %s\n"), nr, stage);
 }
=20
 static struct itimerval early_output_timer;
@@ -358,7 +358,7 @@ static int cmd_log_walk(struct rev_info *rev)
 		setup_early_output(rev);
=20
 	if (prepare_revision_walk(rev))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
=20
 	if (rev->early_output)
 		finish_early_output(rev);
@@ -450,7 +450,7 @@ static int show_object(const unsigned char *sha1, i=
nt show_tag_object,
 	int offset =3D 0;
=20
 	if (!buf)
-		return error("Could not read object %s", sha1_to_hex(sha1));
+		return error(_("Could not read object %s"), sha1_to_hex(sha1));
=20
 	if (show_tag_object)
 		while (offset < size && buf[offset] !=3D '\n') {
@@ -537,7 +537,7 @@ int cmd_show(int argc, const char **argv, const cha=
r *prefix)
 				break;
 			o =3D parse_object(t->tagged->sha1);
 			if (!o)
-				ret =3D error("Could not read object %s",
+				ret =3D error(_("Could not read object %s"),
 					    sha1_to_hex(t->tagged->sha1));
 			objects[i].item =3D o;
 			i--;
@@ -561,7 +561,7 @@ int cmd_show(int argc, const char **argv, const cha=
r *prefix)
 			ret =3D cmd_log_walk(&rev);
 			break;
 		default:
-			ret =3D error("Unknown type: %d", o->type);
+			ret =3D error(_("Unknown type: %d"), o->type);
 		}
 	}
 	free(objects);
@@ -664,7 +664,7 @@ static int git_format_config(const char *var, const=
 char *value, void *cb)
 {
 	if (!strcmp(var, "format.headers")) {
 		if (!value)
-			die("format.headers without value");
+			die(_("format.headers without value"));
 		add_header(value);
 		return 0;
 	}
@@ -736,7 +736,7 @@ static int reopen_stdout(struct commit *commit, str=
uct rev_info *rev)
 		strbuf_addstr(&filename, output_directory);
 		if (filename.len >=3D
 		    PATH_MAX - FORMAT_PATCH_NAME_MAX - suffix_len)
-			return error("name of output directory is too long");
+			return error(_("name of output directory is too long"));
 		if (filename.buf[filename.len - 1] !=3D '/')
 			strbuf_addch(&filename, '/');
 	}
@@ -747,7 +747,7 @@ static int reopen_stdout(struct commit *commit, str=
uct rev_info *rev)
 		fprintf(realstdout, "%s\n", filename.buf + outdir_offset);
=20
 	if (freopen(filename.buf, "w", stdout) =3D=3D NULL)
-		return error("Cannot open patch file %s", filename.buf);
+		return error(_("Cannot open patch file %s"), filename.buf);
=20
 	strbuf_release(&filename);
 	return 0;
@@ -761,7 +761,7 @@ static void get_patch_ids(struct rev_info *rev, str=
uct patch_ids *ids, const cha
 	unsigned flags1, flags2;
=20
 	if (rev->pending.nr !=3D 2)
-		die("Need exactly one range.");
+		die(_("Need exactly one range."));
=20
 	o1 =3D rev->pending.objects[0].item;
 	flags1 =3D o1->flags;
@@ -769,7 +769,7 @@ static void get_patch_ids(struct rev_info *rev, str=
uct patch_ids *ids, const cha
 	flags2 =3D o2->flags;
=20
 	if ((flags1 & UNINTERESTING) =3D=3D (flags2 & UNINTERESTING))
-		die("Not a range.");
+		die(_("Not a range."));
=20
 	init_patch_ids(ids);
=20
@@ -780,7 +780,7 @@ static void get_patch_ids(struct rev_info *rev, str=
uct patch_ids *ids, const cha
 	add_pending_object(&check_rev, o1, "o1");
 	add_pending_object(&check_rev, o2, "o2");
 	if (prepare_revision_walk(&check_rev))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
=20
 	while ((commit =3D get_revision(&check_rev)) !=3D NULL) {
 		/* ignore merges */
@@ -806,7 +806,7 @@ static void gen_message_id(struct rev_info *info, c=
har *base)
 	const char *email_end =3D strrchr(committer, '>');
 	struct strbuf buf =3D STRBUF_INIT;
 	if (!email_start || !email_end || email_start > email_end - 1)
-		die("Could not extract email from committer identity.");
+		die(_("Could not extract email from committer identity."));
 	strbuf_addf(&buf, "%s.%lu.git.%.*s", base,
 		    (unsigned long) time(NULL),
 		    (int)(email_end - email_start - 1), email_start + 1);
@@ -838,7 +838,7 @@ static void make_cover_letter(struct rev_info *rev,=
 int use_stdout,
 	struct commit *commit =3D NULL;
=20
 	if (rev->commit_format !=3D CMIT_FMT_EMAIL)
-		die("Cover letter needs email format");
+		die(_("Cover letter needs email format"));
=20
 	committer =3D git_committer_info(0);
=20
@@ -931,7 +931,7 @@ static const char *clean_message_id(const char *msg=
_id)
 		m++;
 	}
 	if (!z)
-		die("insane in-reply-to: %s", msg_id);
+		die(_("insane in-reply-to: %s"), msg_id);
 	if (++z =3D=3D m)
 		return a;
 	return xmemdupz(a, z - a);
@@ -1004,7 +1004,7 @@ static int output_directory_callback(const struct=
 option *opt, const char *arg,
 {
 	const char **dir =3D (const char **)opt->value;
 	if (*dir)
-		die("Two output directories?");
+		die(_("Two output directories?"));
 	*dir =3D arg;
 	return 0;
 }
@@ -1192,7 +1192,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
 		committer =3D git_committer_info(IDENT_ERROR_ON_NO_NAME);
 		endpos =3D strchr(committer, '>');
 		if (!endpos)
-			die("bogus committer info %s", committer);
+			die(_("bogus committer info %s"), committer);
 		add_signoff =3D xmemdupz(committer, endpos - committer + 1);
 	}
=20
@@ -1237,20 +1237,20 @@ int cmd_format_patch(int argc, const char **arg=
v, const char *prefix)
 		numbered =3D 0;
=20
 	if (numbered && keep_subject)
-		die ("-n and -k are mutually exclusive.");
+		die (_("-n and -k are mutually exclusive."));
 	if (keep_subject && subject_prefix)
-		die ("--subject-prefix and -k are mutually exclusive.");
+		die (_("--subject-prefix and -k are mutually exclusive."));
=20
 	argc =3D setup_revisions(argc, argv, &rev, &s_r_opt);
 	if (argc > 1)
-		die ("unrecognized argument: %s", argv[1]);
+		die (_("unrecognized argument: %s"), argv[1]);
=20
 	if (rev.diffopt.output_format & DIFF_FORMAT_NAME)
-		die("--name-only does not make sense");
+		die(_("--name-only does not make sense"));
 	if (rev.diffopt.output_format & DIFF_FORMAT_NAME_STATUS)
-		die("--name-status does not make sense");
+		die(_("--name-status does not make sense"));
 	if (rev.diffopt.output_format & DIFF_FORMAT_CHECKDIFF)
-		die("--check does not make sense");
+		die(_("--check does not make sense"));
=20
 	if (!use_patch_format &&
 		(!rev.diffopt.output_format ||
@@ -1271,9 +1271,9 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
=20
 	if (output_directory) {
 		if (use_stdout)
-			die("standard output, or directory, which one?");
+			die(_("standard output, or directory, which one?"));
 		if (mkdir(output_directory, 0777) < 0 && errno !=3D EEXIST)
-			die_errno("Could not create directory '%s'",
+			die_errno(_("Could not create directory '%s'"),
 				  output_directory);
 	}
=20
@@ -1327,7 +1327,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
 		realstdout =3D xfdopen(xdup(1), "w");
=20
 	if (prepare_revision_walk(&rev))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
 	rev.boundary =3D 1;
 	while ((commit =3D get_revision(&rev)) !=3D NULL) {
 		if (commit->object.flags & BOUNDARY) {
@@ -1408,7 +1408,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
=20
 		if (!use_stdout && reopen_stdout(numbered_files ? NULL : commit,
 						 &rev))
-			die("Failed to create output files");
+			die(_("Failed to create output files"));
 		shown =3D log_tree_commit(&rev, commit);
 		free(commit->buffer);
 		commit->buffer =3D NULL;
@@ -1495,9 +1495,9 @@ int cmd_cherry(int argc, const char **argv, const=
 char *prefix)
 		if (!current_branch || !current_branch->merge
 					|| !current_branch->merge[0]
 					|| !current_branch->merge[0]->dst) {
-			fprintf(stderr, "Could not find a tracked"
+			fprintf(stderr, _("Could not find a tracked"
 					" remote branch, please"
-					" specify <upstream> manually.\n");
+					" specify <upstream> manually.\n"));
 			usage_with_options(cherry_usage, options);
 		}
=20
@@ -1511,9 +1511,9 @@ int cmd_cherry(int argc, const char **argv, const=
 char *prefix)
 	DIFF_OPT_SET(&revs.diffopt, RECURSIVE);
=20
 	if (add_pending_commit(head, &revs, 0))
-		die("Unknown commit %s", head);
+		die(_("Unknown commit %s"), head);
 	if (add_pending_commit(upstream, &revs, UNINTERESTING))
-		die("Unknown commit %s", upstream);
+		die(_("Unknown commit %s"), upstream);
=20
 	/* Don't say anything if head and upstream are the same. */
 	if (revs.pending.nr =3D=3D 2) {
@@ -1525,11 +1525,11 @@ int cmd_cherry(int argc, const char **argv, con=
st char *prefix)
 	get_patch_ids(&revs, &ids, prefix);
=20
 	if (limit && add_pending_commit(limit, &revs, UNINTERESTING))
-		die("Unknown commit %s", limit);
+		die(_("Unknown commit %s"), limit);
=20
 	/* reverse the list of commits */
 	if (prepare_revision_walk(&revs))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
 	while ((commit =3D get_revision(&revs)) !=3D NULL) {
 		/* ignore merges */
 		if (commit->parents && commit->parents->next)
--=20
1.7.2.2.614.g1dc9
