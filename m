From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/22] builtin/blame.c: mark strings for translation
Date: Sun, 28 Feb 2016 10:57:15 -0800
Message-ID: <xmqq7fhofyt0.fsf@gitster.mtv.corp.google.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
	<1456555333-5853-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 19:57:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aa6Wx-0006wx-PX
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 19:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339AbcB1S5T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Feb 2016 13:57:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56290 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754187AbcB1S5S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Feb 2016 13:57:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3E2B247199;
	Sun, 28 Feb 2016 13:57:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FPo/wzLjwulo
	ZzbAcWd6DWJit/I=; b=dXXL/2zY2i22x9Drwmjes4uvBLiLntD41jPQvvgtki78
	l3HBC3UxfbXEXOiMQk+SC9zYIYF4SQZVbyh6jwPLo6jGap2oxWkO0uNMWtZ/VFQp
	hEKX8oPPXazF+pOmfzI3zFsn1msdDNyXElwBPofukbyPmRBbTzNdnyf8s6PywdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xfvFhT
	PZv7TCI2kjZgGlojZHI0WlgnxE7eJIJPbwrLaH9ifHQK8y3Y8goPuSJwnc/oD4T6
	BRcY7iogyVfJGto1AxCMOx5qFExeV9BcfB/rO4xUPLjPHzCh/uHMLnIMsNj8Ogqj
	z1bfPmrBg0wX0/q6z6JqZ/qFGLbLuLSAf9gpQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 35B1747198;
	Sun, 28 Feb 2016 13:57:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8F04C47197;
	Sun, 28 Feb 2016 13:57:16 -0500 (EST)
In-Reply-To: <1456555333-5853-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 27
 Feb 2016 13:41:53 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 15E766B6-DE4D-11E5-AF2A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287782>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/blame.c | 58 ++++++++++++++++++++++++++++-------------------=
----------
>  1 file changed, 29 insertions(+), 29 deletions(-)

I think most of the strings we see here are not new ones introduced
in this cycle.  I doubt it is a good idea to disturb the codebase,
distract ourselves and adding last-minute workload to translators
with this during the pre-release period.



>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index e982fb8..988a38a 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -196,7 +196,7 @@ static void fill_origin_blob(struct diff_options =
*opt,
>  		file->size =3D file_size;
> =20
>  		if (!file->ptr)
> -			die("Cannot read blob %s for path %s",
> +			die(_("Cannot read blob %s for path %s"),
>  			    sha1_to_hex(o->blob_sha1),
>  			    o->path);
>  		o->file =3D *file;
> @@ -981,7 +981,7 @@ static void pass_blame_to_parent(struct scoreboar=
d *sb,
>  	num_get_patch++;
> =20
>  	if (diff_hunks(&file_p, &file_o, 0, blame_chunk_cb, &d))
> -		die("unable to generate diff (%s -> %s)",
> +		die(_("unable to generate diff (%s -> %s)"),
>  		    oid_to_hex(&parent->commit->object.oid),
>  		    oid_to_hex(&target->commit->object.oid));
>  	/* The rest are the same as the parent */
> @@ -1130,7 +1130,7 @@ static void find_copy_in_blob(struct scoreboard=
 *sb,
>  	 */
>  	memset(split, 0, sizeof(struct blame_entry [3]));
>  	if (diff_hunks(file_p, &file_o, 1, handle_split_cb, &d))
> -		die("unable to generate diff (%s)",
> +		die(_("unable to generate diff (%s)"),
>  		    oid_to_hex(&parent->commit->object.oid));
>  	/* remainder, if any, all match the preimage */
>  	handle_split(sb, ent, d.tlno, d.plno, ent->num_lines, parent, split=
);
> @@ -2240,7 +2240,7 @@ static void verify_working_tree_path(struct com=
mit *work_tree, const char *path)
>  		    sha1_object_info(blob_sha1, NULL) =3D=3D OBJ_BLOB)
>  			return;
>  	}
> -	die("no such path '%s' in HEAD", path);
> +	die(_("no such path '%s' in HEAD"), path);
>  }
> =20
>  static struct commit_list **append_parent(struct commit_list **tail,=
 const unsigned char *sha1)
> @@ -2249,7 +2249,7 @@ static struct commit_list **append_parent(struc=
t commit_list **tail, const unsig
> =20
>  	parent =3D lookup_commit_reference(sha1);
>  	if (!parent)
> -		die("no such commit %s", sha1_to_hex(sha1));
> +		die(_("no such commit %s"), sha1_to_hex(sha1));
>  	return &commit_list_insert(parent, tail)->next;
>  }
> =20
> @@ -2262,13 +2262,13 @@ static void append_merge_parents(struct commi=
t_list **tail)
>  	if (merge_head < 0) {
>  		if (errno =3D=3D ENOENT)
>  			return;
> -		die("cannot open '%s' for reading", git_path_merge_head());
> +		die(_("cannot open '%s' for reading"), git_path_merge_head());
>  	}
> =20
>  	while (!strbuf_getwholeline_fd(&line, merge_head, '\n')) {
>  		unsigned char sha1[20];
>  		if (line.len < 40 || get_sha1_hex(line.buf, sha1))
> -			die("unknown line in '%s': %s", git_path_merge_head(), line.buf);
> +			die(_("unknown line in '%s': %s"), git_path_merge_head(), line.bu=
f);
>  		tail =3D append_parent(tail, sha1);
>  	}
>  	close(merge_head);
> @@ -2314,7 +2314,7 @@ static struct commit *fake_working_tree_commit(=
struct diff_options *opt,
>  	parent_tail =3D &commit->parents;
> =20
>  	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_sha1, NUL=
L))
> -		die("no such ref: HEAD");
> +		die(_("no such ref: HEAD"));
> =20
>  	parent_tail =3D append_parent(parent_tail, head_sha1);
>  	append_merge_parents(parent_tail);
> @@ -2344,12 +2344,12 @@ static struct commit *fake_working_tree_commi=
t(struct diff_options *opt,
> =20
>  		if (contents_from) {
>  			if (stat(contents_from, &st) < 0)
> -				die_errno("Cannot stat '%s'", contents_from);
> +				die_errno(_("Cannot stat '%s'"), contents_from);
>  			read_from =3D contents_from;
>  		}
>  		else {
>  			if (lstat(path, &st) < 0)
> -				die_errno("Cannot lstat '%s'", path);
> +				die_errno(_("Cannot lstat '%s'"), path);
>  			read_from =3D path;
>  		}
>  		mode =3D canon_mode(st.st_mode);
> @@ -2360,21 +2360,21 @@ static struct commit *fake_working_tree_commi=
t(struct diff_options *opt,
>  			    textconv_object(read_from, mode, null_sha1, 0, &buf_ptr, &buf=
_len))
>  				strbuf_attach(&buf, buf_ptr, buf_len, buf_len + 1);
>  			else if (strbuf_read_file(&buf, read_from, st.st_size) !=3D st.st=
_size)
> -				die_errno("cannot open or read '%s'", read_from);
> +				die_errno(_("cannot open or read '%s'"), read_from);
>  			break;
>  		case S_IFLNK:
>  			if (strbuf_readlink(&buf, read_from, st.st_size) < 0)
> -				die_errno("cannot readlink '%s'", read_from);
> +				die_errno(_("cannot readlink '%s'"), read_from);
>  			break;
>  		default:
> -			die("unsupported file type %s", read_from);
> +			die(_("unsupported file type %s"), read_from);
>  		}
>  	}
>  	else {
>  		/* Reading from stdin */
>  		mode =3D 0;
>  		if (strbuf_read(&buf, 0, 0) < 0)
> -			die_errno("failed to read from stdin");
> +			die_errno(_("failed to read from stdin"));
>  	}
>  	convert_to_git(path, buf.buf, buf.len, &buf, 0);
>  	origin->file.ptr =3D buf.buf;
> @@ -2427,9 +2427,9 @@ static struct commit *find_single_final(struct =
rev_info *revs,
>  		while (obj->type =3D=3D OBJ_TAG)
>  			obj =3D deref_tag(obj, NULL, 0);
>  		if (obj->type !=3D OBJ_COMMIT)
> -			die("Non commit %s?", revs->pending.objects[i].name);
> +			die(_("Non commit %s?"), revs->pending.objects[i].name);
>  		if (found)
> -			die("More than one commit to dig from %s and %s?",
> +			die(_("More than one commit to dig from %s and %s?"),
>  			    revs->pending.objects[i].name, name);
>  		found =3D (struct commit *)obj;
>  		name =3D revs->pending.objects[i].name;
> @@ -2463,16 +2463,16 @@ static char *prepare_initial(struct scoreboar=
d *sb)
>  		while (obj->type =3D=3D OBJ_TAG)
>  			obj =3D deref_tag(obj, NULL, 0);
>  		if (obj->type !=3D OBJ_COMMIT)
> -			die("Non commit %s?", revs->pending.objects[i].name);
> +			die(_("Non commit %s?"), revs->pending.objects[i].name);
>  		if (sb->final)
> -			die("More than one commit to dig down to %s and %s?",
> +			die(_("More than one commit to dig down to %s and %s?"),
>  			    revs->pending.objects[i].name,
>  			    final_commit_name);
>  		sb->final =3D (struct commit *) obj;
>  		final_commit_name =3D revs->pending.objects[i].name;
>  	}
>  	if (!final_commit_name)
> -		die("No commit to dig down to?");
> +		die(_("No commit to dig down to?"));
>  	return xstrdup(final_commit_name);
>  }
> =20
> @@ -2594,7 +2594,7 @@ parse_done:
> =20
>  	if (incremental || (output_option & OUTPUT_PORCELAIN)) {
>  		if (show_progress > 0)
> -			die("--progress can't be used with --incremental or porcelain for=
mats");
> +			die(_("--progress can't be used with --incremental or porcelain f=
ormats"));
>  		show_progress =3D 0;
>  	} else if (show_progress < 0)
>  		show_progress =3D isatty(2);
> @@ -2604,7 +2604,7 @@ parse_done:
>  		abbrev++;
> =20
>  	if (revs_file && read_ancestry(revs_file))
> -		die_errno("reading graft file '%s' failed", revs_file);
> +		die_errno(_("reading graft file '%s' failed"), revs_file);
> =20
>  	if (cmd_is_annotate) {
>  		output_option |=3D OUTPUT_ANNOTATE_COMPAT;
> @@ -2704,7 +2704,7 @@ parse_done:
> =20
>  		setup_work_tree();
>  		if (!file_exists(path))
> -			die_errno("cannot stat path '%s'", path);
> +			die_errno(_("cannot stat path '%s'"), path);
>  	}
> =20
>  	revs.disable_stdin =3D 1;
> @@ -2717,7 +2717,7 @@ parse_done:
>  		sb.commits.compare =3D compare_commits_by_commit_date;
>  	}
>  	else if (contents_from)
> -		die("--contents and --reverse do not blend well.");
> +		die(_("--contents and --reverse do not blend well."));
>  	else {
>  		final_commit_name =3D prepare_initial(&sb);
>  		sb.commits.compare =3D compare_commits_by_reverse_commit_date;
> @@ -2737,12 +2737,12 @@ parse_done:
>  		add_pending_object(&revs, &(sb.final->object), ":");
>  	}
>  	else if (contents_from)
> -		die("Cannot use --contents with final commit object name");
> +		die(_("Cannot use --contents with final commit object name"));
> =20
>  	if (reverse && revs.first_parent_only) {
>  		final_commit =3D find_single_final(sb.revs, NULL);
>  		if (!final_commit)
> -			die("--reverse and --first-parent together require specified late=
st commit");
> +			die(_("--reverse and --first-parent together require specified la=
test commit"));
>  	}
> =20
>  	/*
> @@ -2769,7 +2769,7 @@ parse_done:
>  		}
> =20
>  		if (oidcmp(&c->object.oid, &sb.final->object.oid))
> -			die("--reverse --first-parent together require range along first-=
parent chain");
> +			die(_("--reverse --first-parent together require range along firs=
t-parent chain"));
>  	}
> =20
>  	if (is_null_oid(&sb.final->object.oid)) {
> @@ -2780,7 +2780,7 @@ parse_done:
>  	else {
>  		o =3D get_origin(&sb, sb.final, path);
>  		if (fill_blob_sha1_and_mode(o))
> -			die("no such path %s in %s", path, final_commit_name);
> +			die(_("no such path %s in %s"), path, final_commit_name);
> =20
>  		if (DIFF_OPT_TST(&sb.revs->diffopt, ALLOW_TEXTCONV) &&
>  		    textconv_object(path, o->mode, o->blob_sha1, 1, (char **) &sb.=
final_buf,
> @@ -2791,7 +2791,7 @@ parse_done:
>  						      &sb.final_buf_size);
> =20
>  		if (!sb.final_buf)
> -			die("Cannot read blob %s for path %s",
> +			die(_("Cannot read blob %s for path %s"),
>  			    sha1_to_hex(o->blob_sha1),
>  			    path);
>  	}
> @@ -2810,7 +2810,7 @@ parse_done:
>  				    &bottom, &top, sb.path))
>  			usage(blame_usage);
>  		if (lno < top || ((lno || bottom) && lno < bottom))
> -			die("file %s has only %lu lines", path, lno);
> +			die(_("file %s has only %lu lines"), path, lno);
>  		if (bottom < 1)
>  			bottom =3D 1;
>  		if (top < 1)
