From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/22] builtin/blame.c: mark strings for translation
Date: Sat, 27 Feb 2016 13:41:53 +0700
Message-ID: <1456555333-5853-3-git-send-email-pclouds@gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 07:42:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZYZq-0002kX-Aj
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 07:42:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645AbcB0GmA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 01:42:00 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33732 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbcB0Gl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 01:41:59 -0500
Received: by mail-pa0-f50.google.com with SMTP id fl4so62527466pad.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ZnRbNmRWzei2Ap1ZGMLzp7DStz1eqphB/eMZC1zk3E=;
        b=W/kS3Vv2d4VgGSh0yEpcSLCdJFdXKfJn/wW7iyYGKm3SMEKfXEAvzrw1uSU9KvuOMN
         Cc8VvkcU9CknaaLwAoxSkJoeCY4BYv5GtiTK2nYLAZnD4e1LEHRLgciYRcGyGvABP4ph
         o2jA8gyT6IkKxlWXla10ChcHzqXrQ0ezhwiza9xVbjxyg1Gsh9YsQHrYKFyab0ZmdyfW
         eImPLzWrVw9FphDxpZaMSxblP/B4ZhYC1kqRjeNYomS05+i0KWsxz6FMogp2n4wCq6+r
         EYOxCAxbSv2zumz39Z5wYF/ce0qNWOgGC7hZwCxk1s3EdZY2allCGN1G8Wc/yYdnVZlk
         kC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ZnRbNmRWzei2Ap1ZGMLzp7DStz1eqphB/eMZC1zk3E=;
        b=IqwGS8NKJvdyIlMqkApVSDE1atyrZwjWuwfsnwt5kkJLXpsbuCp1yYkUFucJfB318h
         czq4VEn3F/3x9py6BPgRQL5PwFTvNz0Fc4dO6yEceDaNX0MUgIjmsCVqXgQRBE5vVCAs
         ux0JEs4+gSs1PZw+6hpCp7FoPOVhX1sOKWvx/3JnGsqjND5grx01zWUOoBotdbJXVDeR
         PstgG9XcIXcNgSG1ac8JsXHrhNwYpTLi2Jeh4LhyNWfU+JNJ67b+Mqk7Dv946p7SezUc
         zuEwpfWhbCCby0Ha4umTvac6KIkmrM8r7QvE933ucOB+7C0JF5xnc68qfl2nEjI9rT6E
         OqXQ==
X-Gm-Message-State: AD7BkJJ0Hi/vlfNR/rqb5K8z7wCgOpJvbR0iOA0gPnL6kpvSzACn0LlSXpbHp0IB8o3O+A==
X-Received: by 10.67.1.209 with SMTP id bi17mr7602821pad.150.1456555318876;
        Fri, 26 Feb 2016 22:41:58 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id ko9sm23512591pab.37.2016.02.26.22.41.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2016 22:41:57 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:42:31 +0700
X-Mailer: git-send-email 2.8.0.rc0.205.g7ec8cf1
In-Reply-To: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287663>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/blame.c | 58 ++++++++++++++++++++++++++++---------------------=
--------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index e982fb8..988a38a 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -196,7 +196,7 @@ static void fill_origin_blob(struct diff_options *o=
pt,
 		file->size =3D file_size;
=20
 		if (!file->ptr)
-			die("Cannot read blob %s for path %s",
+			die(_("Cannot read blob %s for path %s"),
 			    sha1_to_hex(o->blob_sha1),
 			    o->path);
 		o->file =3D *file;
@@ -981,7 +981,7 @@ static void pass_blame_to_parent(struct scoreboard =
*sb,
 	num_get_patch++;
=20
 	if (diff_hunks(&file_p, &file_o, 0, blame_chunk_cb, &d))
-		die("unable to generate diff (%s -> %s)",
+		die(_("unable to generate diff (%s -> %s)"),
 		    oid_to_hex(&parent->commit->object.oid),
 		    oid_to_hex(&target->commit->object.oid));
 	/* The rest are the same as the parent */
@@ -1130,7 +1130,7 @@ static void find_copy_in_blob(struct scoreboard *=
sb,
 	 */
 	memset(split, 0, sizeof(struct blame_entry [3]));
 	if (diff_hunks(file_p, &file_o, 1, handle_split_cb, &d))
-		die("unable to generate diff (%s)",
+		die(_("unable to generate diff (%s)"),
 		    oid_to_hex(&parent->commit->object.oid));
 	/* remainder, if any, all match the preimage */
 	handle_split(sb, ent, d.tlno, d.plno, ent->num_lines, parent, split);
@@ -2240,7 +2240,7 @@ static void verify_working_tree_path(struct commi=
t *work_tree, const char *path)
 		    sha1_object_info(blob_sha1, NULL) =3D=3D OBJ_BLOB)
 			return;
 	}
-	die("no such path '%s' in HEAD", path);
+	die(_("no such path '%s' in HEAD"), path);
 }
=20
 static struct commit_list **append_parent(struct commit_list **tail, c=
onst unsigned char *sha1)
@@ -2249,7 +2249,7 @@ static struct commit_list **append_parent(struct =
commit_list **tail, const unsig
=20
 	parent =3D lookup_commit_reference(sha1);
 	if (!parent)
-		die("no such commit %s", sha1_to_hex(sha1));
+		die(_("no such commit %s"), sha1_to_hex(sha1));
 	return &commit_list_insert(parent, tail)->next;
 }
=20
@@ -2262,13 +2262,13 @@ static void append_merge_parents(struct commit_=
list **tail)
 	if (merge_head < 0) {
 		if (errno =3D=3D ENOENT)
 			return;
-		die("cannot open '%s' for reading", git_path_merge_head());
+		die(_("cannot open '%s' for reading"), git_path_merge_head());
 	}
=20
 	while (!strbuf_getwholeline_fd(&line, merge_head, '\n')) {
 		unsigned char sha1[20];
 		if (line.len < 40 || get_sha1_hex(line.buf, sha1))
-			die("unknown line in '%s': %s", git_path_merge_head(), line.buf);
+			die(_("unknown line in '%s': %s"), git_path_merge_head(), line.buf)=
;
 		tail =3D append_parent(tail, sha1);
 	}
 	close(merge_head);
@@ -2314,7 +2314,7 @@ static struct commit *fake_working_tree_commit(st=
ruct diff_options *opt,
 	parent_tail =3D &commit->parents;
=20
 	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_sha1, NULL)=
)
-		die("no such ref: HEAD");
+		die(_("no such ref: HEAD"));
=20
 	parent_tail =3D append_parent(parent_tail, head_sha1);
 	append_merge_parents(parent_tail);
@@ -2344,12 +2344,12 @@ static struct commit *fake_working_tree_commit(=
struct diff_options *opt,
=20
 		if (contents_from) {
 			if (stat(contents_from, &st) < 0)
-				die_errno("Cannot stat '%s'", contents_from);
+				die_errno(_("Cannot stat '%s'"), contents_from);
 			read_from =3D contents_from;
 		}
 		else {
 			if (lstat(path, &st) < 0)
-				die_errno("Cannot lstat '%s'", path);
+				die_errno(_("Cannot lstat '%s'"), path);
 			read_from =3D path;
 		}
 		mode =3D canon_mode(st.st_mode);
@@ -2360,21 +2360,21 @@ static struct commit *fake_working_tree_commit(=
struct diff_options *opt,
 			    textconv_object(read_from, mode, null_sha1, 0, &buf_ptr, &buf_l=
en))
 				strbuf_attach(&buf, buf_ptr, buf_len, buf_len + 1);
 			else if (strbuf_read_file(&buf, read_from, st.st_size) !=3D st.st_s=
ize)
-				die_errno("cannot open or read '%s'", read_from);
+				die_errno(_("cannot open or read '%s'"), read_from);
 			break;
 		case S_IFLNK:
 			if (strbuf_readlink(&buf, read_from, st.st_size) < 0)
-				die_errno("cannot readlink '%s'", read_from);
+				die_errno(_("cannot readlink '%s'"), read_from);
 			break;
 		default:
-			die("unsupported file type %s", read_from);
+			die(_("unsupported file type %s"), read_from);
 		}
 	}
 	else {
 		/* Reading from stdin */
 		mode =3D 0;
 		if (strbuf_read(&buf, 0, 0) < 0)
-			die_errno("failed to read from stdin");
+			die_errno(_("failed to read from stdin"));
 	}
 	convert_to_git(path, buf.buf, buf.len, &buf, 0);
 	origin->file.ptr =3D buf.buf;
@@ -2427,9 +2427,9 @@ static struct commit *find_single_final(struct re=
v_info *revs,
 		while (obj->type =3D=3D OBJ_TAG)
 			obj =3D deref_tag(obj, NULL, 0);
 		if (obj->type !=3D OBJ_COMMIT)
-			die("Non commit %s?", revs->pending.objects[i].name);
+			die(_("Non commit %s?"), revs->pending.objects[i].name);
 		if (found)
-			die("More than one commit to dig from %s and %s?",
+			die(_("More than one commit to dig from %s and %s?"),
 			    revs->pending.objects[i].name, name);
 		found =3D (struct commit *)obj;
 		name =3D revs->pending.objects[i].name;
@@ -2463,16 +2463,16 @@ static char *prepare_initial(struct scoreboard =
*sb)
 		while (obj->type =3D=3D OBJ_TAG)
 			obj =3D deref_tag(obj, NULL, 0);
 		if (obj->type !=3D OBJ_COMMIT)
-			die("Non commit %s?", revs->pending.objects[i].name);
+			die(_("Non commit %s?"), revs->pending.objects[i].name);
 		if (sb->final)
-			die("More than one commit to dig down to %s and %s?",
+			die(_("More than one commit to dig down to %s and %s?"),
 			    revs->pending.objects[i].name,
 			    final_commit_name);
 		sb->final =3D (struct commit *) obj;
 		final_commit_name =3D revs->pending.objects[i].name;
 	}
 	if (!final_commit_name)
-		die("No commit to dig down to?");
+		die(_("No commit to dig down to?"));
 	return xstrdup(final_commit_name);
 }
=20
@@ -2594,7 +2594,7 @@ parse_done:
=20
 	if (incremental || (output_option & OUTPUT_PORCELAIN)) {
 		if (show_progress > 0)
-			die("--progress can't be used with --incremental or porcelain forma=
ts");
+			die(_("--progress can't be used with --incremental or porcelain for=
mats"));
 		show_progress =3D 0;
 	} else if (show_progress < 0)
 		show_progress =3D isatty(2);
@@ -2604,7 +2604,7 @@ parse_done:
 		abbrev++;
=20
 	if (revs_file && read_ancestry(revs_file))
-		die_errno("reading graft file '%s' failed", revs_file);
+		die_errno(_("reading graft file '%s' failed"), revs_file);
=20
 	if (cmd_is_annotate) {
 		output_option |=3D OUTPUT_ANNOTATE_COMPAT;
@@ -2704,7 +2704,7 @@ parse_done:
=20
 		setup_work_tree();
 		if (!file_exists(path))
-			die_errno("cannot stat path '%s'", path);
+			die_errno(_("cannot stat path '%s'"), path);
 	}
=20
 	revs.disable_stdin =3D 1;
@@ -2717,7 +2717,7 @@ parse_done:
 		sb.commits.compare =3D compare_commits_by_commit_date;
 	}
 	else if (contents_from)
-		die("--contents and --reverse do not blend well.");
+		die(_("--contents and --reverse do not blend well."));
 	else {
 		final_commit_name =3D prepare_initial(&sb);
 		sb.commits.compare =3D compare_commits_by_reverse_commit_date;
@@ -2737,12 +2737,12 @@ parse_done:
 		add_pending_object(&revs, &(sb.final->object), ":");
 	}
 	else if (contents_from)
-		die("Cannot use --contents with final commit object name");
+		die(_("Cannot use --contents with final commit object name"));
=20
 	if (reverse && revs.first_parent_only) {
 		final_commit =3D find_single_final(sb.revs, NULL);
 		if (!final_commit)
-			die("--reverse and --first-parent together require specified latest=
 commit");
+			die(_("--reverse and --first-parent together require specified late=
st commit"));
 	}
=20
 	/*
@@ -2769,7 +2769,7 @@ parse_done:
 		}
=20
 		if (oidcmp(&c->object.oid, &sb.final->object.oid))
-			die("--reverse --first-parent together require range along first-pa=
rent chain");
+			die(_("--reverse --first-parent together require range along first-=
parent chain"));
 	}
=20
 	if (is_null_oid(&sb.final->object.oid)) {
@@ -2780,7 +2780,7 @@ parse_done:
 	else {
 		o =3D get_origin(&sb, sb.final, path);
 		if (fill_blob_sha1_and_mode(o))
-			die("no such path %s in %s", path, final_commit_name);
+			die(_("no such path %s in %s"), path, final_commit_name);
=20
 		if (DIFF_OPT_TST(&sb.revs->diffopt, ALLOW_TEXTCONV) &&
 		    textconv_object(path, o->mode, o->blob_sha1, 1, (char **) &sb.fi=
nal_buf,
@@ -2791,7 +2791,7 @@ parse_done:
 						      &sb.final_buf_size);
=20
 		if (!sb.final_buf)
-			die("Cannot read blob %s for path %s",
+			die(_("Cannot read blob %s for path %s"),
 			    sha1_to_hex(o->blob_sha1),
 			    path);
 	}
@@ -2810,7 +2810,7 @@ parse_done:
 				    &bottom, &top, sb.path))
 			usage(blame_usage);
 		if (lno < top || ((lno || bottom) && lno < bottom))
-			die("file %s has only %lu lines", path, lno);
+			die(_("file %s has only %lu lines"), path, lno);
 		if (bottom < 1)
 			bottom =3D 1;
 		if (top < 1)
--=20
2.8.0.rc0.205.g7ec8cf1
