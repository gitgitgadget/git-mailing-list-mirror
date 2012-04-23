From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/10] i18n: index-pack: mark strings for translation
Date: Mon, 23 Apr 2012 19:30:29 +0700
Message-ID: <1335184230-8870-10-git-send-email-pclouds@gmail.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 14:35:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMIUN-00061a-MQ
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 14:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384Ab2DWMfT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Apr 2012 08:35:19 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55597 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab2DWMfR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 08:35:17 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so3837007pbc.19
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 05:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=47o4o1hNX0ZjLTJNZ8el/VOLhM/qr+kMYV2homFrSLk=;
        b=ZYQJQn9QR6LtmJ4ECwUXsKaPzNuL9siCya5SLugHBGzx3WVvqgPdBXX+knb46YYOUc
         N8nVRT24FRpeN4/KoUctsIViTNI9YIX+nuANgSLxD47oZ6nlXsJUFcyz72+lAZOKhf57
         dKytjVoEqUUMONsOQHZ/7uGbTPH5KuJXQEsAg24i5Y1Oz3zZcSg0VaXamqcJTGDpkoT3
         L+1Qnpbg7Gsj8cEc1Zfvx/KprP+QI34Ff5oS99+IHrdopIVAW2na+IAWq4l0TOLNOz8c
         08QZuHAGk5YPYdqDGLszEDBbhN395LH5M+3SFFUXT1BKc879sGsWxX05irdVRqGGFnH9
         WStQ==
Received: by 10.68.232.8 with SMTP id tk8mr1169598pbc.25.1335184517627;
        Mon, 23 Apr 2012 05:35:17 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.59.47])
        by mx.google.com with ESMTPS id g4sm14273805pbt.58.2012.04.23.05.35.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Apr 2012 05:35:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 23 Apr 2012 19:31:59 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196123>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c |  125 +++++++++++++++++++++++++++---------------=
--------
 1 files changed, 68 insertions(+), 57 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index dd1c5c9..83555e5 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -81,7 +81,7 @@ static int mark_link(struct object *obj, int type, vo=
id *data)
 		return -1;
=20
 	if (type !=3D OBJ_ANY && obj->type !=3D type)
-		die("object type mismatch at %s", sha1_to_hex(obj->sha1));
+		die(_("object type mismatch at %s"), sha1_to_hex(obj->sha1));
=20
 	obj->flags |=3D FLAG_LINK;
 	return 0;
@@ -101,7 +101,7 @@ static void check_object(struct object *obj)
 		unsigned long size;
 		int type =3D sha1_object_info(obj->sha1, &size);
 		if (type !=3D obj->type || type <=3D 0)
-			die("object of unexpected type");
+			die(_("object of unexpected type"));
 		obj->flags |=3D FLAG_CHECKED;
 		return;
 	}
@@ -138,15 +138,18 @@ static void *fill(int min)
 	if (min <=3D input_len)
 		return input_buffer + input_offset;
 	if (min > sizeof(input_buffer))
-		die("cannot fill %d bytes", min);
+		die(Q_("cannot fill %d byte",
+		       "cannot fill %d bytes",
+		       min),
+		    min);
 	flush();
 	do {
 		ssize_t ret =3D xread(input_fd, input_buffer + input_len,
 				sizeof(input_buffer) - input_len);
 		if (ret <=3D 0) {
 			if (!ret)
-				die("early EOF");
-			die_errno("read error on input");
+				die(_("early EOF"));
+			die_errno(_("read error on input"));
 		}
 		input_len +=3D ret;
 		if (from_stdin)
@@ -158,14 +161,14 @@ static void *fill(int min)
 static void use(int bytes)
 {
 	if (bytes > input_len)
-		die("used more bytes than were available");
+		die(_("used more bytes than were available"));
 	input_crc32 =3D crc32(input_crc32, input_buffer + input_offset, bytes=
);
 	input_len -=3D bytes;
 	input_offset +=3D bytes;
=20
 	/* make sure off_t is sufficiently large not to wrap */
 	if (signed_add_overflows(consumed_bytes, bytes))
-		die("pack too large for current definition of off_t");
+		die(_("pack too large for current definition of off_t"));
 	consumed_bytes +=3D bytes;
 }
=20
@@ -181,12 +184,12 @@ static const char *open_pack_file(const char *pac=
k_name)
 		} else
 			output_fd =3D open(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
 		if (output_fd < 0)
-			die_errno("unable to create '%s'", pack_name);
+			die_errno(_("unable to create '%s'"), pack_name);
 		pack_fd =3D output_fd;
 	} else {
 		input_fd =3D open(pack_name, O_RDONLY);
 		if (input_fd < 0)
-			die_errno("cannot open packfile '%s'", pack_name);
+			die_errno(_("cannot open packfile '%s'"), pack_name);
 		output_fd =3D -1;
 		pack_fd =3D input_fd;
 	}
@@ -200,7 +203,7 @@ static void parse_pack_header(void)
=20
 	/* Header consistency check */
 	if (hdr->hdr_signature !=3D htonl(PACK_SIGNATURE))
-		die("pack signature mismatch");
+		die(_("pack signature mismatch"));
 	if (!pack_version_ok(hdr->hdr_version))
 		die("pack version %"PRIu32" unsupported",
 			ntohl(hdr->hdr_version));
@@ -220,7 +223,7 @@ static NORETURN void bad_object(unsigned long offse=
t, const char *format, ...)
 	va_start(params, format);
 	vsnprintf(buf, sizeof(buf), format, params);
 	va_end(params);
-	die("pack has bad object at offset %lu: %s", offset, buf);
+	die(_("pack has bad object at offset %lu: %s"), offset, buf);
 }
=20
 static struct base_data *alloc_base_data(void)
@@ -294,7 +297,7 @@ static void *unpack_entry_data(unsigned long offset=
, unsigned long size)
 		use(input_len - stream.avail_in);
 	} while (status =3D=3D Z_OK);
 	if (stream.total_out !=3D size || status !=3D Z_STREAM_END)
-		bad_object(offset, "inflate returned %d", status);
+		bad_object(offset, _("inflate returned %d"), status);
 	git_inflate_end(&stream);
 	return buf;
 }
@@ -339,7 +342,7 @@ static void *unpack_raw_entry(struct object_entry *=
obj, union delta_base *delta_
 		while (c & 128) {
 			base_offset +=3D 1;
 			if (!base_offset || MSB(base_offset, 7))
-				bad_object(obj->idx.offset, "offset value overflow for delta base =
object");
+				bad_object(obj->idx.offset, _("offset value overflow for delta bas=
e object"));
 			p =3D fill(1);
 			c =3D *p;
 			use(1);
@@ -347,7 +350,7 @@ static void *unpack_raw_entry(struct object_entry *=
obj, union delta_base *delta_
 		}
 		delta_base->offset =3D obj->idx.offset - base_offset;
 		if (delta_base->offset <=3D 0 || delta_base->offset >=3D obj->idx.of=
fset)
-			bad_object(obj->idx.offset, "delta base offset is out of bound");
+			bad_object(obj->idx.offset, _("delta base offset is out of bound"))=
;
 		break;
 	case OBJ_COMMIT:
 	case OBJ_TREE:
@@ -355,7 +358,7 @@ static void *unpack_raw_entry(struct object_entry *=
obj, union delta_base *delta_
 	case OBJ_TAG:
 		break;
 	default:
-		bad_object(obj->idx.offset, "unknown object type %d", obj->type);
+		bad_object(obj->idx.offset, _("unknown object type %d"), obj->type);
 	}
 	obj->hdr_size =3D consumed_bytes - obj->idx.offset;
=20
@@ -384,9 +387,12 @@ static void *get_data_from_pack(struct object_entr=
y *obj)
 		ssize_t n =3D (len < 64*1024) ? len : 64*1024;
 		n =3D pread(pack_fd, inbuf, n, from);
 		if (n < 0)
-			die_errno("cannot pread pack file");
+			die_errno(_("cannot pread pack file"));
 		if (!n)
-			die("premature end of pack file, %lu bytes missing", len);
+			die(Q_("premature end of pack file, %lu byte missing",
+			       "premature end of pack file, %lu bytes missing",
+			       len),
+			    len);
 		from +=3D n;
 		len -=3D n;
 		stream.next_in =3D inbuf;
@@ -396,7 +402,7 @@ static void *get_data_from_pack(struct object_entry=
 *obj)
=20
 	/* This has been inflated OK when first encountered, so... */
 	if (status !=3D Z_STREAM_END || stream.total_out !=3D obj->size)
-		die("serious inflate inconsistency");
+		die(_("serious inflate inconsistency"));
=20
 	git_inflate_end(&stream);
 	free(inbuf);
@@ -467,10 +473,10 @@ static void sha1_object(const void *data, unsigne=
d long size,
 		unsigned long has_size;
 		has_data =3D read_sha1_file(sha1, &has_type, &has_size);
 		if (!has_data)
-			die("cannot read existing object %s", sha1_to_hex(sha1));
+			die(_("cannot read existing object %s"), sha1_to_hex(sha1));
 		if (size !=3D has_size || type !=3D has_type ||
 		    memcmp(data, has_data, size) !=3D 0)
-			die("SHA1 COLLISION FOUND WITH %s !", sha1_to_hex(sha1));
+			die(_("SHA1 COLLISION FOUND WITH %s !"), sha1_to_hex(sha1));
 		free(has_data);
 	}
 	if (strict) {
@@ -479,7 +485,7 @@ static void sha1_object(const void *data, unsigned =
long size,
 			if (blob)
 				blob->object.flags |=3D FLAG_CHECKED;
 			else
-				die("invalid blob object %s", sha1_to_hex(sha1));
+				die(_("invalid blob object %s"), sha1_to_hex(sha1));
 		} else {
 			struct object *obj;
 			int eaten;
@@ -491,11 +497,11 @@ static void sha1_object(const void *data, unsigne=
d long size,
 			 */
 			obj =3D parse_object_buffer(sha1, type, size, buf, &eaten);
 			if (!obj)
-				die("invalid %s", typename(type));
+				die(_("invalid %s"), typename(type));
 			if (fsck_object(obj, 1, fsck_error_function))
-				die("Error in object");
+				die(_("Error in object"));
 			if (fsck_walk(obj, mark_link, NULL))
-				die("Not all child objects of %s are reachable", sha1_to_hex(obj->=
sha1));
+				die(_("Not all child objects of %s are reachable"), sha1_to_hex(ob=
j->sha1));
=20
 			if (obj->type =3D=3D OBJ_TREE) {
 				struct tree *item =3D (struct tree *) obj;
@@ -567,7 +573,7 @@ static void *get_base_data(struct base_data *c)
 				&c->size);
 			free(raw);
 			if (!c->data)
-				bad_object(obj->idx.offset, "failed to apply delta");
+				bad_object(obj->idx.offset, _("failed to apply delta"));
 			base_cache_used +=3D c->size;
 			prune_base_data(c);
 		}
@@ -593,7 +599,7 @@ static void resolve_delta(struct object_entry *delt=
a_obj,
 				   delta_data, delta_obj->size, &result->size);
 	free(delta_data);
 	if (!result->data)
-		bad_object(delta_obj->idx.offset, "failed to apply delta");
+		bad_object(delta_obj->idx.offset, _("failed to apply delta"));
 	sha1_object(result->data, result->size, delta_obj->real_type,
 		    delta_obj->idx.sha1);
 	nr_resolved_deltas++;
@@ -697,7 +703,7 @@ static void parse_pack_objects(unsigned char *sha1)
 	 */
 	if (verbose)
 		progress =3D start_progress(
-				from_stdin ? "Receiving objects" : "Indexing objects",
+				from_stdin ? _("Receiving objects") : _("Indexing objects"),
 				nr_objects);
 	for (i =3D 0; i < nr_objects; i++) {
 		struct object_entry *obj =3D &objects[i];
@@ -719,15 +725,15 @@ static void parse_pack_objects(unsigned char *sha=
1)
 	flush();
 	git_SHA1_Final(sha1, &input_ctx);
 	if (hashcmp(fill(20), sha1))
-		die("pack is corrupted (SHA1 mismatch)");
+		die(_("pack is corrupted (SHA1 mismatch)"));
 	use(20);
=20
 	/* If input_fd is a file, we should have reached its end now. */
 	if (fstat(input_fd, &st))
-		die_errno("cannot fstat packfile");
+		die_errno(_("cannot fstat packfile"));
 	if (S_ISREG(st.st_mode) &&
 			lseek(input_fd, 0, SEEK_CUR) - input_len !=3D st.st_size)
-		die("pack has junk at the end");
+		die(_("pack has junk at the end"));
=20
 	if (!nr_deltas)
 		return;
@@ -745,7 +751,7 @@ static void parse_pack_objects(unsigned char *sha1)
 	 *   for some more deltas.
 	 */
 	if (verbose)
-		progress =3D start_progress("Resolving deltas", nr_deltas);
+		progress =3D start_progress(_("Resolving deltas"), nr_deltas);
 	for (i =3D 0; i < nr_objects; i++) {
 		struct object_entry *obj =3D &objects[i];
 		struct base_data *base_obj =3D alloc_base_data();
@@ -778,7 +784,7 @@ static int write_compressed(struct sha1file *f, voi=
d *in, unsigned int size)
 	} while (status =3D=3D Z_OK);
=20
 	if (status !=3D Z_STREAM_END)
-		die("unable to deflate appended object (%d)", status);
+		die(_("unable to deflate appended object (%d)"), status);
 	size =3D stream.total_out;
 	git_deflate_end(&stream);
 	return size;
@@ -857,7 +863,7 @@ static void fix_unresolved_deltas(struct sha1file *=
f, int nr_unresolved)
=20
 		if (check_sha1_signature(d->base.sha1, base_obj->data,
 				base_obj->size, typename(type)))
-			die("local object %s is corrupt", sha1_to_hex(d->base.sha1));
+			die(_("local object %s is corrupt"), sha1_to_hex(d->base.sha1));
 		base_obj->obj =3D append_obj_to_pack(f, d->base.sha1,
 					base_obj->data, base_obj->size, type);
 		find_unresolved_deltas(base_obj);
@@ -881,7 +887,7 @@ static void final(const char *final_pack_name, cons=
t char *curr_pack_name,
 		fsync_or_die(output_fd, curr_pack_name);
 		err =3D close(output_fd);
 		if (err)
-			die_errno("error while closing pack file");
+			die_errno(_("error while closing pack file"));
 	}
=20
 	if (keep_msg) {
@@ -894,7 +900,7 @@ static void final(const char *final_pack_name, cons=
t char *curr_pack_name,
=20
 		if (keep_fd < 0) {
 			if (errno !=3D EEXIST)
-				die_errno("cannot write keep file '%s'",
+				die_errno(_("cannot write keep file '%s'"),
 					  keep_name);
 		} else {
 			if (keep_msg_len > 0) {
@@ -902,7 +908,7 @@ static void final(const char *final_pack_name, cons=
t char *curr_pack_name,
 				write_or_die(keep_fd, "\n", 1);
 			}
 			if (close(keep_fd) !=3D 0)
-				die_errno("cannot close written keep file '%s'",
+				die_errno(_("cannot close written keep file '%s'"),
 				    keep_name);
 			report =3D "keep";
 		}
@@ -915,7 +921,7 @@ static void final(const char *final_pack_name, cons=
t char *curr_pack_name,
 			final_pack_name =3D name;
 		}
 		if (move_temp_to_file(curr_pack_name, final_pack_name))
-			die("cannot store pack file");
+			die(_("cannot store pack file"));
 	} else if (from_stdin)
 		chmod(final_pack_name, 0444);
=20
@@ -926,7 +932,7 @@ static void final(const char *final_pack_name, cons=
t char *curr_pack_name,
 			final_index_name =3D name;
 		}
 		if (move_temp_to_file(curr_index_name, final_index_name))
-			die("cannot store index file");
+			die(_("cannot store index file"));
 	} else
 		chmod(final_index_name, 0444);
=20
@@ -1015,9 +1021,9 @@ static void read_idx_option(struct pack_idx_optio=
n *opts, const char *pack_name)
 	struct packed_git *p =3D add_packed_git(pack_name, strlen(pack_name),=
 1);
=20
 	if (!p)
-		die("Cannot open existing pack file '%s'", pack_name);
+		die(_("Cannot open existing pack file '%s'"), pack_name);
 	if (open_pack_index(p))
-		die("Cannot open existing pack idx file for '%s'", pack_name);
+		die(_("Cannot open existing pack idx file for '%s'"), pack_name);
=20
 	/* Read the attributes from the existing idx file */
 	opts->version =3D p->index_version;
@@ -1064,15 +1070,18 @@ static void show_pack_info(int stat_only)
 	}
=20
 	if (baseobjects)
-		printf("non delta: %d object%s\n",
-		       baseobjects, baseobjects > 1 ? "s" : "");
+		printf_ln(Q_("non delta: %d object",
+			     "non delta: %d objects",
+			     baseobjects),
+			  baseobjects);
 	for (i =3D 0; i < deepest_delta; i++) {
 		if (!chain_histogram[i])
 			continue;
-		printf("chain length =3D %d: %lu object%s\n",
-		       i + 1,
-		       chain_histogram[i],
-		       chain_histogram[i] > 1 ? "s" : "");
+		printf_ln(Q_("chain length =3D %d: %lu object",
+			     "chain length =3D %d: %lu objects",
+			     chain_histogram[i]),
+			  i + 1,
+			  chain_histogram[i]);
 	}
 }
=20
@@ -1095,7 +1104,7 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 	reset_pack_idx_option(&opts);
 	git_config(git_index_pack_config, &opts);
 	if (prefix && chdir(prefix))
-		die("Cannot come back to cwd");
+		die(_("Cannot come back to cwd"));
=20
 	for (i =3D 1; i < argc; i++) {
 		const char *arg =3D argv[i];
@@ -1128,10 +1137,10 @@ int cmd_index_pack(int argc, const char **argv,=
 const char *prefix)
 				hdr->hdr_signature =3D htonl(PACK_SIGNATURE);
 				hdr->hdr_version =3D htonl(strtoul(arg + 14, &c, 10));
 				if (*c !=3D ',')
-					die("bad %s", arg);
+					die(_("bad %s"), arg);
 				hdr->hdr_entries =3D htonl(strtoul(c + 1, &c, 10));
 				if (*c)
-					die("bad %s", arg);
+					die(_("bad %s"), arg);
 				input_len =3D sizeof(*hdr);
 			} else if (!strcmp(arg, "-v")) {
 				verbose =3D 1;
@@ -1143,11 +1152,11 @@ int cmd_index_pack(int argc, const char **argv,=
 const char *prefix)
 				char *c;
 				opts.version =3D strtoul(arg + 16, &c, 10);
 				if (opts.version > 2)
-					die("bad %s", arg);
+					die(_("bad %s"), arg);
 				if (*c =3D=3D ',')
 					opts.off32_limit =3D strtoul(c+1, &c, 0);
 				if (*c || opts.off32_limit & 0x80000000)
-					die("bad %s", arg);
+					die(_("bad %s"), arg);
 			} else
 				usage(index_pack_usage);
 			continue;
@@ -1161,11 +1170,11 @@ int cmd_index_pack(int argc, const char **argv,=
 const char *prefix)
 	if (!pack_name && !from_stdin)
 		usage(index_pack_usage);
 	if (fix_thin_pack && !from_stdin)
-		die("--fix-thin cannot be used without --stdin");
+		die(_("--fix-thin cannot be used without --stdin"));
 	if (!index_name && pack_name) {
 		int len =3D strlen(pack_name);
 		if (!has_extension(pack_name, ".pack"))
-			die("packfile name '%s' does not end with '.pack'",
+			die(_("packfile name '%s' does not end with '.pack'"),
 			    pack_name);
 		index_name_buf =3D xmalloc(len);
 		memcpy(index_name_buf, pack_name, len - 5);
@@ -1175,7 +1184,7 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 	if (keep_msg && !keep_name && pack_name) {
 		int len =3D strlen(pack_name);
 		if (!has_extension(pack_name, ".pack"))
-			die("packfile name '%s' does not end with '.pack'",
+			die(_("packfile name '%s' does not end with '.pack'"),
 			    pack_name);
 		keep_name_buf =3D xmalloc(len);
 		memcpy(keep_name_buf, pack_name, len - 5);
@@ -1184,7 +1193,7 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 	}
 	if (verify) {
 		if (!index_name)
-			die("--verify with no packfile name given");
+			die(_("--verify with no packfile name given"));
 		read_idx_option(&opts, index_name);
 		opts.flags |=3D WRITE_IDX_VERIFY | WRITE_IDX_STRICT;
 	}
@@ -1208,7 +1217,7 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 			int nr_unresolved =3D nr_deltas - nr_resolved_deltas;
 			int nr_objects_initial =3D nr_objects;
 			if (nr_unresolved <=3D 0)
-				die("confusion beyond insanity");
+				die(_("confusion beyond insanity"));
 			objects =3D xrealloc(objects,
 					   (nr_objects + nr_unresolved + 1)
 					   * sizeof(*objects));
@@ -1227,7 +1236,9 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 				    "(disk corruption?)", curr_pack);
 		}
 		if (nr_deltas !=3D nr_resolved_deltas)
-			die("pack has %d unresolved deltas",
+			die(Q_("pack has %d unresolved delta",
+			       "pack has %d unresolved deltas",
+			       nr_deltas - nr_resolved_deltas),
 			    nr_deltas - nr_resolved_deltas);
 	}
 	free(deltas);
--=20
1.7.8.36.g69ee2
