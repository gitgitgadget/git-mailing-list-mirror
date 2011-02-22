From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 38/73] gettextize: git-log basic messages
Date: Tue, 22 Feb 2011 23:41:57 +0000
Message-ID: <1298418152-27789-39-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:44:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1uI-0008HI-H4
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755456Ab1BVXoN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:13 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39375 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166Ab1BVXoK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:10 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866600bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=q6EVibSfiLZo2CBJv4XLwvHwBhVYHtsG0HaDQ9WKcv4=;
        b=wWJs6NJLngkGq+rKDmXrrsDBtlydajwp/FYMVoC9VG3p/LP8M4QRe2nPuudaYlW74h
         lXHqLCWljtOT4J93hth7q8G4NRwxIA9IexzFpE1bkZXXVO553hDNEcQacf5pW0xNSmMv
         a9qdc15NvdZ8Bt9ISGWOGLWBjaJdldji+AZrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=UGSFiDU+brqQldPaldxapXzb+wbi59X4LZTUJLqYeH4iWBnjBXOfIcl1qpERVIk1JA
         Dhe0mL3GrinEkP/+1DbmIVVyhKooU+x2OOx+PR4grLMlRffdVi9/YAAMLwnVZhRoTIg8
         wkNSHhFieXfW2+9mU+qyncn1vFihjpCyF7O+M=
Received: by 10.204.63.8 with SMTP id z8mr2983174bkh.17.1298418248928;
        Tue, 22 Feb 2011 15:44:08 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.08
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:08 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167605>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/log.c |   62 ++++++++++++++++++++++++++++---------------------=
-------
 1 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index d8c6c28..b36a01e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -101,7 +101,7 @@ static void cmd_log_init(int argc, const char **arg=
v, const char *prefix,
 			const char *v =3D skip_prefix(arg, "--decorate=3D");
 			decoration_style =3D parse_decoration_style(arg, v);
 			if (decoration_style < 0)
-				die("invalid --decorate option: %s", arg);
+				die(_("invalid --decorate option: %s"), arg);
 			decoration_given =3D 1;
 		} else if (!strcmp(arg, "--no-decorate")) {
 			decoration_style =3D 0;
@@ -110,7 +110,7 @@ static void cmd_log_init(int argc, const char **arg=
v, const char *prefix,
 		} else if (!strcmp(arg, "-h")) {
 			usage(builtin_log_usage);
 		} else
-			die("unrecognized argument: %s", arg);
+			die(_("unrecognized argument: %s"), arg);
 	}
=20
 	/*
@@ -153,7 +153,7 @@ static void show_early_header(struct rev_info *rev,=
 const char *stage, int nr)
 		if (rev->commit_format !=3D CMIT_FMT_ONELINE)
 			putchar(rev->diffopt.line_termination);
 	}
-	printf("Final output: %d %s\n", nr, stage);
+	printf(_("Final output: %d %s\n"), nr, stage);
 }
=20
 static struct itimerval early_output_timer;
@@ -252,7 +252,7 @@ static int cmd_log_walk(struct rev_info *rev)
 		setup_early_output(rev);
=20
 	if (prepare_revision_walk(rev))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
=20
 	if (rev->early_output)
 		finish_early_output(rev);
@@ -343,7 +343,7 @@ static int show_object(const unsigned char *sha1, i=
nt show_tag_object,
 	int offset =3D 0;
=20
 	if (!buf)
-		return error("Could not read object %s", sha1_to_hex(sha1));
+		return error(_("Could not read object %s"), sha1_to_hex(sha1));
=20
 	if (show_tag_object)
 		while (offset < size && buf[offset] !=3D '\n') {
@@ -430,7 +430,7 @@ int cmd_show(int argc, const char **argv, const cha=
r *prefix)
 				break;
 			o =3D parse_object(t->tagged->sha1);
 			if (!o)
-				ret =3D error("Could not read object %s",
+				ret =3D error(_("Could not read object %s"),
 					    sha1_to_hex(t->tagged->sha1));
 			objects[i].item =3D o;
 			i--;
@@ -454,7 +454,7 @@ int cmd_show(int argc, const char **argv, const cha=
r *prefix)
 			ret =3D cmd_log_walk(&rev);
 			break;
 		default:
-			ret =3D error("Unknown type: %d", o->type);
+			ret =3D error(_("Unknown type: %d"), o->type);
 		}
 	}
 	free(objects);
@@ -554,7 +554,7 @@ static int git_format_config(const char *var, const=
 char *value, void *cb)
 {
 	if (!strcmp(var, "format.headers")) {
 		if (!value)
-			die("format.headers without value");
+			die(_("format.headers without value"));
 		add_header(value);
 		return 0;
 	}
@@ -626,7 +626,7 @@ static int reopen_stdout(struct commit *commit, str=
uct rev_info *rev)
 		strbuf_addstr(&filename, output_directory);
 		if (filename.len >=3D
 		    PATH_MAX - FORMAT_PATCH_NAME_MAX - suffix_len)
-			return error("name of output directory is too long");
+			return error(_("name of output directory is too long"));
 		if (filename.buf[filename.len - 1] !=3D '/')
 			strbuf_addch(&filename, '/');
 	}
@@ -637,7 +637,7 @@ static int reopen_stdout(struct commit *commit, str=
uct rev_info *rev)
 		fprintf(realstdout, "%s\n", filename.buf + outdir_offset);
=20
 	if (freopen(filename.buf, "w", stdout) =3D=3D NULL)
-		return error("Cannot open patch file %s", filename.buf);
+		return error(_("Cannot open patch file %s"), filename.buf);
=20
 	strbuf_release(&filename);
 	return 0;
@@ -651,7 +651,7 @@ static void get_patch_ids(struct rev_info *rev, str=
uct patch_ids *ids, const cha
 	unsigned flags1, flags2;
=20
 	if (rev->pending.nr !=3D 2)
-		die("Need exactly one range.");
+		die(_("Need exactly one range."));
=20
 	o1 =3D rev->pending.objects[0].item;
 	flags1 =3D o1->flags;
@@ -659,7 +659,7 @@ static void get_patch_ids(struct rev_info *rev, str=
uct patch_ids *ids, const cha
 	flags2 =3D o2->flags;
=20
 	if ((flags1 & UNINTERESTING) =3D=3D (flags2 & UNINTERESTING))
-		die("Not a range.");
+		die(_("Not a range."));
=20
 	init_patch_ids(ids);
=20
@@ -670,7 +670,7 @@ static void get_patch_ids(struct rev_info *rev, str=
uct patch_ids *ids, const cha
 	add_pending_object(&check_rev, o1, "o1");
 	add_pending_object(&check_rev, o2, "o2");
 	if (prepare_revision_walk(&check_rev))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
=20
 	while ((commit =3D get_revision(&check_rev)) !=3D NULL) {
 		/* ignore merges */
@@ -696,7 +696,7 @@ static void gen_message_id(struct rev_info *info, c=
har *base)
 	const char *email_end =3D strrchr(committer, '>');
 	struct strbuf buf =3D STRBUF_INIT;
 	if (!email_start || !email_end || email_start > email_end - 1)
-		die("Could not extract email from committer identity.");
+		die(_("Could not extract email from committer identity."));
 	strbuf_addf(&buf, "%s.%lu.git.%.*s", base,
 		    (unsigned long) time(NULL),
 		    (int)(email_end - email_start - 1), email_start + 1);
@@ -728,7 +728,7 @@ static void make_cover_letter(struct rev_info *rev,=
 int use_stdout,
 	struct commit *commit =3D NULL;
=20
 	if (rev->commit_format !=3D CMIT_FMT_EMAIL)
-		die("Cover letter needs email format");
+		die(_("Cover letter needs email format"));
=20
 	committer =3D git_committer_info(0);
=20
@@ -821,7 +821,7 @@ static const char *clean_message_id(const char *msg=
_id)
 		m++;
 	}
 	if (!z)
-		die("insane in-reply-to: %s", msg_id);
+		die(_("insane in-reply-to: %s"), msg_id);
 	if (++z =3D=3D m)
 		return a;
 	return xmemdupz(a, z - a);
@@ -894,7 +894,7 @@ static int output_directory_callback(const struct o=
ption *opt, const char *arg,
 {
 	const char **dir =3D (const char **)opt->value;
 	if (*dir)
-		die("Two output directories?");
+		die(_("Two output directories?"));
 	*dir =3D arg;
 	return 0;
 }
@@ -1082,7 +1082,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
 		committer =3D git_committer_info(IDENT_ERROR_ON_NO_NAME);
 		endpos =3D strchr(committer, '>');
 		if (!endpos)
-			die("bogus committer info %s", committer);
+			die(_("bogus committer info %s"), committer);
 		add_signoff =3D xmemdupz(committer, endpos - committer + 1);
 	}
=20
@@ -1127,13 +1127,13 @@ int cmd_format_patch(int argc, const char **arg=
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
 		die("--name-only does not make sense");
@@ -1163,9 +1163,9 @@ int cmd_format_patch(int argc, const char **argv,=
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
@@ -1219,7 +1219,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
 		realstdout =3D xfdopen(xdup(1), "w");
=20
 	if (prepare_revision_walk(&rev))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
 	rev.boundary =3D 1;
 	while ((commit =3D get_revision(&rev)) !=3D NULL) {
 		if (commit->object.flags & BOUNDARY) {
@@ -1300,7 +1300,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
=20
 		if (!use_stdout && reopen_stdout(numbered_files ? NULL : commit,
 						 &rev))
-			die("Failed to create output files");
+			die(_("Failed to create output files"));
 		shown =3D log_tree_commit(&rev, commit);
 		free(commit->buffer);
 		commit->buffer =3D NULL;
@@ -1387,9 +1387,9 @@ int cmd_cherry(int argc, const char **argv, const=
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
@@ -1403,9 +1403,9 @@ int cmd_cherry(int argc, const char **argv, const=
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
@@ -1417,11 +1417,11 @@ int cmd_cherry(int argc, const char **argv, con=
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
1.7.2.3
