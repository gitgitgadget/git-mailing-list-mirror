From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/22] sha1_file.c: mark strings for translation
Date: Sat, 27 Feb 2016 13:42:08 +0700
Message-ID: <1456555333-5853-18-git-send-email-pclouds@gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 07:43:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZYbZ-0003mp-Mt
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 07:43:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756092AbcB0Gnu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 01:43:50 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33275 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbcB0Gns (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 01:43:48 -0500
Received: by mail-pf0-f181.google.com with SMTP id 124so564275pfg.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P8y1Ktm4JUdRAnQDx6Ls6IKMYF7xa0iPxjhRgHju59M=;
        b=WhbUZPurawkPGMaQ/p/7K7MctHVrM7bUoniWbVqTO5Qbwx/Dky271m5ujtglx/1XLp
         ANNzNwjl7Dyfi/G/FhgUsPd7eezRoxxbqTq/v63Big+CMLeQrqDcmg9mtfYOSmkqOCXt
         2b9n3iPWG2vArSh4rDNaovzWdn9MdLj95SjtUjsqweShGsSTiO+Gw0eoZTGF7rSBPdNe
         fVKJOYW9F5BFM4qB63bA2pVAIQItru6dxDPQa5rtGOxG2MOfPE7ZWu2WxLM21L+5Iy6i
         SzH0+7rOcsU2n2uYYYEs7QR+nOfvcJXfIYM6735A5RMXlbqZwmyhm0stJEeYDgGOICfp
         AYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8y1Ktm4JUdRAnQDx6Ls6IKMYF7xa0iPxjhRgHju59M=;
        b=bNEVz41NAJQuwR0+tdS6BqBZ9XTusR05wIF1qjlsS4uzwpOXHnHK7b1XG6ZUQx8aMo
         tZm0s+0korAS+fzXrtdiuxsHGhLW+mamaIC7OxOAyvThfOrctp5W2nXdrQ44hv2FO4K2
         PBuS9eTbuRYWG/qulTrxrfxVcG2EfzIVHqqyW/+/ZX72nbxyM8CG2lLLJ111PhoNemqe
         2KbMXjzEXz7Uir4B/KrCluXkx+LWCCrFdeH3E/ojYtFp77YzIZCN4ui1+oMtEcwa2MBw
         p/pxygoXNuXm+WhRg02JNQWdfBdnNrszoV4yK0HP3Ui2dgZ46JOt/DmJXNMfKn2GTiwi
         WJGQ==
X-Gm-Message-State: AD7BkJKpr4JlywOxOVmZunMOWaxSC6afOUc2c91Vj6mX01XQsyr3ghlu+sKNJ78aOxdokQ==
X-Received: by 10.98.19.215 with SMTP id 84mr7661519pft.22.1456555427996;
        Fri, 26 Feb 2016 22:43:47 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id yh5sm23542715pab.13.2016.02.26.22.43.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2016 22:43:46 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:44:20 +0700
X-Mailer: git-send-email 2.8.0.rc0.205.g7ec8cf1
In-Reply-To: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287678>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_file.c | 189 ++++++++++++++++++++++++++++++----------------------=
--------
 1 file changed, 96 insertions(+), 93 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 0251700..f669499 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -194,7 +194,7 @@ const char *sha1_file_name(const unsigned char *sha=
1)
=20
 	/* '/' + sha1(2) + '/' + sha1(38) + '\0' */
 	if (len + 43 > PATH_MAX)
-		die("insanely long object directory %s", objdir);
+		die(_("insanely long object directory %s"), objdir);
 	memcpy(buf, objdir, len);
 	buf[len] =3D '/';
 	buf[len+3] =3D '/';
@@ -284,8 +284,8 @@ static int link_alt_odb_entry(const char *entry, co=
nst char *relative_base,
=20
 	/* Detect cases where alternate disappeared */
 	if (!is_directory(ent->base)) {
-		error("object directory %s does not exist; "
-		      "check .git/objects/info/alternates.",
+		error(_("object directory %s does not exist; "
+			"check .git/objects/info/alternates."),
 		      ent->base);
 		free(ent);
 		return -1;
@@ -328,8 +328,8 @@ static void link_alt_odb_entries(const char *alt, i=
nt len, int sep,
 	struct strbuf objdirbuf =3D STRBUF_INIT;
=20
 	if (depth > 5) {
-		error("%s: ignoring alternate object stores, nesting too deep.",
-				relative_base);
+		error(_("%s: ignoring alternate object stores, nesting too deep."),
+		      relative_base);
 		return;
 	}
=20
@@ -343,8 +343,8 @@ static void link_alt_odb_entries(const char *alt, i=
nt len, int sep,
 		if (entry[0] =3D=3D '\0' || entry[0] =3D=3D '#')
 			continue;
 		if (!is_absolute_path(entry) && depth) {
-			error("%s: ignoring relative alternate object store %s",
-					relative_base, entry);
+			error(_("%s: ignoring relative alternate object store %s"),
+			      relative_base, entry);
 		} else {
 			link_alt_odb_entry(entry, relative_base, depth, objdirbuf.buf);
 		}
@@ -389,7 +389,7 @@ void add_to_alternates_file(const char *reference)
 	hold_lock_file_for_update(lock, alts, LOCK_DIE_ON_ERROR);
 	out =3D fdopen_lock_file(lock, "w");
 	if (!out)
-		die_errno("unable to fdopen alternates lockfile");
+		die_errno(_("unable to fdopen alternates lockfile"));
=20
 	in =3D fopen(alts, "r");
 	if (in) {
@@ -413,12 +413,12 @@ void add_to_alternates_file(const char *reference=
)
 		}
 	}
 	else if (errno !=3D ENOENT)
-		die_errno("unable to read alternates file");
+		die_errno(_("unable to read alternates file"));
=20
 	if (lock) {
 		fprintf_or_die(out, "%s\n", reference);
 		if (commit_lock_file(lock))
-			die_errno("unable to move new alternates file into place");
+			die_errno(_("unable to move new alternates file into place"));
 		if (alt_odb_tail)
 			link_alt_odb_entries(reference, strlen(reference), '\n', NULL, 0);
 	}
@@ -566,7 +566,7 @@ static int check_packed_git_idx(const char *path, s=
truct packed_git *p)
 	idx_size =3D xsize_t(st.st_size);
 	if (idx_size < 4 * 256 + 20 + 20) {
 		close(fd);
-		return error("index file %s is too small", path);
+		return error(_("index file %s is too small"), path);
 	}
 	idx_map =3D xmmap(NULL, idx_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
@@ -576,9 +576,9 @@ static int check_packed_git_idx(const char *path, s=
truct packed_git *p)
 		version =3D ntohl(hdr->idx_version);
 		if (version < 2 || version > 2) {
 			munmap(idx_map, idx_size);
-			return error("index file %s is version %"PRIu32
-				     " and is not supported by this binary"
-				     " (try upgrading GIT to a newer version)",
+			return error(_("index file %s is version %" PRIu32
+				       " and is not supported by this binary"
+				       " (try upgrading GIT to a newer version)"),
 				     path, version);
 		}
 	} else
@@ -592,7 +592,7 @@ static int check_packed_git_idx(const char *path, s=
truct packed_git *p)
 		uint32_t n =3D ntohl(index[i]);
 		if (n < nr) {
 			munmap(idx_map, idx_size);
-			return error("non-monotonic index %s", path);
+			return error(_("non-monotonic index %s"), path);
 		}
 		nr =3D n;
 	}
@@ -607,7 +607,7 @@ static int check_packed_git_idx(const char *path, s=
truct packed_git *p)
 		 */
 		if (idx_size !=3D 4*256 + nr * 24 + 20 + 20) {
 			munmap(idx_map, idx_size);
-			return error("wrong index v1 file size in %s", path);
+			return error(_("wrong index v1 file size in %s"), path);
 		}
 	} else if (version =3D=3D 2) {
 		/*
@@ -629,7 +629,7 @@ static int check_packed_git_idx(const char *path, s=
truct packed_git *p)
 			max_size +=3D (nr - 1)*8;
 		if (idx_size < min_size || idx_size > max_size) {
 			munmap(idx_map, idx_size);
-			return error("wrong index v2 file size in %s", path);
+			return error(_("wrong index v2 file size in %s"), path);
 		}
 		if (idx_size !=3D min_size &&
 		    /*
@@ -639,7 +639,7 @@ static int check_packed_git_idx(const char *path, s=
truct packed_git *p)
 		     */
 		    (sizeof(off_t) <=3D 4)) {
 			munmap(idx_map, idx_size);
-			return error("pack too large for current definition of off_t in %s"=
, path);
+			return error(_("pack too large for current definition of off_t in %=
s"), path);
 		}
 	}
=20
@@ -725,7 +725,7 @@ static void mmap_limit_check(size_t length)
 			limit =3D SIZE_MAX;
 	}
 	if (length > limit)
-		die("attempting to mmap %"PRIuMAX" over limit %"PRIuMAX,
+		die(_("attempting to mmap %"PRIuMAX" over limit %"PRIuMAX),
 		    (uintmax_t)length, (uintmax_t)limit);
 }
=20
@@ -750,7 +750,7 @@ void *xmmap(void *start, size_t length,
 {
 	void *ret =3D xmmap_gently(start, length, prot, flags, fd, offset);
 	if (ret =3D=3D MAP_FAILED)
-		die_errno("mmap failed");
+		die_errno(_("mmap failed"));
 	return ret;
 }
=20
@@ -760,7 +760,7 @@ void close_pack_windows(struct packed_git *p)
 		struct pack_window *w =3D p->windows;
=20
 		if (w->inuse_cnt)
-			die("pack '%s' still has open windows to it",
+			die(_("pack '%s' still has open windows to it"),
 			    p->pack_name);
 		munmap(w->base, w->len);
 		pack_mapped -=3D w->len;
@@ -975,7 +975,7 @@ static int open_packed_git_1(struct packed_git *p)
 	long fd_flag;
=20
 	if (!p->index_data && open_pack_index(p))
-		return error("packfile %s index unavailable", p->pack_name);
+		return error(_("packfile %s index unavailable"), p->pack_name);
=20
 	if (!pack_max_fds) {
 		unsigned int max_fds =3D get_max_fd_limit();
@@ -998,44 +998,44 @@ static int open_packed_git_1(struct packed_git *p=
)
 	/* If we created the struct before we had the pack we lack size. */
 	if (!p->pack_size) {
 		if (!S_ISREG(st.st_mode))
-			return error("packfile %s not a regular file", p->pack_name);
+			return error(_("packfile %s not a regular file"), p->pack_name);
 		p->pack_size =3D st.st_size;
 	} else if (p->pack_size !=3D st.st_size)
-		return error("packfile %s size changed", p->pack_name);
+		return error(_("packfile %s size changed"), p->pack_name);
=20
 	/* We leave these file descriptors open with sliding mmap;
 	 * there is no point keeping them open across exec(), though.
 	 */
 	fd_flag =3D fcntl(p->pack_fd, F_GETFD, 0);
 	if (fd_flag < 0)
-		return error("cannot determine file descriptor flags");
+		return error(_("cannot determine file descriptor flags"));
 	fd_flag |=3D FD_CLOEXEC;
 	if (fcntl(p->pack_fd, F_SETFD, fd_flag) =3D=3D -1)
-		return error("cannot set FD_CLOEXEC");
+		return error(_("cannot set FD_CLOEXEC"));
=20
 	/* Verify we recognize this pack file format. */
 	if (read_in_full(p->pack_fd, &hdr, sizeof(hdr)) !=3D sizeof(hdr))
-		return error("file %s is far too short to be a packfile", p->pack_na=
me);
+		return error(_("file %s is far too short to be a packfile"), p->pack=
_name);
 	if (hdr.hdr_signature !=3D htonl(PACK_SIGNATURE))
-		return error("file %s is not a GIT packfile", p->pack_name);
+		return error(_("file %s is not a GIT packfile"), p->pack_name);
 	if (!pack_version_ok(hdr.hdr_version))
-		return error("packfile %s is version %"PRIu32" and not"
-			" supported (try upgrading GIT to a newer version)",
+		return error(_("packfile %s is version %"PRIu32" and not"
+			       " supported (try upgrading GIT to a newer version)"),
 			p->pack_name, ntohl(hdr.hdr_version));
=20
 	/* Verify the pack matches its index. */
 	if (p->num_objects !=3D ntohl(hdr.hdr_entries))
-		return error("packfile %s claims to have %"PRIu32" objects"
-			     " while index indicates %"PRIu32" objects",
+		return error(_("packfile %s claims to have %"PRIu32" objects"
+			       " while index indicates %"PRIu32" objects"),
 			     p->pack_name, ntohl(hdr.hdr_entries),
 			     p->num_objects);
 	if (lseek(p->pack_fd, p->pack_size - sizeof(sha1), SEEK_SET) =3D=3D -=
1)
-		return error("end of packfile %s is unavailable", p->pack_name);
+		return error(_("end of packfile %s is unavailable"), p->pack_name);
 	if (read_in_full(p->pack_fd, sha1, sizeof(sha1)) !=3D sizeof(sha1))
-		return error("packfile %s signature is unavailable", p->pack_name);
+		return error(_("packfile %s signature is unavailable"), p->pack_name=
);
 	idx_sha1 =3D ((unsigned char *)p->index_data) + p->index_size - 40;
 	if (hashcmp(sha1, idx_sha1))
-		return error("packfile %s does not match index", p->pack_name);
+		return error(_("packfile %s does not match index"), p->pack_name);
 	return 0;
 }
=20
@@ -1073,9 +1073,9 @@ unsigned char *use_pack(struct packed_git *p,
 	 * don't allow an offset too close to the end of the file.
 	 */
 	if (!p->pack_size && p->pack_fd =3D=3D -1 && open_packed_git(p))
-		die("packfile %s cannot be accessed", p->pack_name);
+		die(_("packfile %s cannot be accessed"), p->pack_name);
 	if (offset > (p->pack_size - 20))
-		die("offset beyond end of packfile (truncated pack?)");
+		die(_("offset beyond end of packfile (truncated pack?)"));
=20
 	if (!win || !in_window(win, offset)) {
 		if (win)
@@ -1089,7 +1089,7 @@ unsigned char *use_pack(struct packed_git *p,
 			off_t len;
=20
 			if (p->pack_fd =3D=3D -1 && open_packed_git(p))
-				die("packfile %s cannot be accessed", p->pack_name);
+				die(_("packfile %s cannot be accessed"), p->pack_name);
=20
 			win =3D xcalloc(1, sizeof(*win));
 			win->offset =3D (offset / window_align) * window_align;
@@ -1105,9 +1105,9 @@ unsigned char *use_pack(struct packed_git *p,
 				PROT_READ, MAP_PRIVATE,
 				p->pack_fd, win->offset);
 			if (win->base =3D=3D MAP_FAILED)
-				die("packfile %s cannot be mapped: %s",
-					p->pack_name,
-					strerror(errno));
+				die(_("packfile %s cannot be mapped: %s"),
+				    p->pack_name,
+				    strerror(errno));
 			if (!win->offset && win->len =3D=3D p->pack_size
 				&& !p->do_not_close)
 				close_pack_fd(p);
@@ -1277,7 +1277,7 @@ static void prepare_packed_git_one(char *objdir, =
int local)
 	dir =3D opendir(path.buf);
 	if (!dir) {
 		if (errno !=3D ENOENT)
-			error("unable to open object pack directory: %s: %s",
+			error(_("unable to open object pack directory: %s: %s"),
 			      path.buf, strerror(errno));
 		strbuf_release(&path);
 		return;
@@ -1560,7 +1560,7 @@ void *map_sha1_file(const unsigned char *sha1, un=
signed long *size)
 			*size =3D xsize_t(st.st_size);
 			if (!*size) {
 				/* mmap() is forbidden on empty files */
-				error("object file %s is empty", sha1_file_name(sha1));
+				error(_("object file %s is empty"), sha1_file_name(sha1));
 				return NULL;
 			}
 			map =3D xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
@@ -1583,7 +1583,7 @@ unsigned long unpack_object_header_buffer(const u=
nsigned char *buf,
 	shift =3D 4;
 	while (c & 0x80) {
 		if (len <=3D used || bitsizeof(long) <=3D shift) {
-			error("bad object header");
+			error(_("bad object header"));
 			size =3D used =3D 0;
 			break;
 		}
@@ -1679,9 +1679,9 @@ static void *unpack_sha1_rest(git_zstream *stream=
, void *buffer, unsigned long s
 	}
=20
 	if (status < 0)
-		error("corrupt loose object '%s'", sha1_to_hex(sha1));
+		error(_("corrupt loose object '%s'"), sha1_to_hex(sha1));
 	else if (stream->avail_in)
-		error("garbage at end of loose object '%s'",
+		error(_("garbage at end of loose object '%s'"),
 		      sha1_to_hex(sha1));
 	free(buf);
 	return NULL;
@@ -1721,7 +1721,7 @@ static int parse_sha1_header_extended(const char =
*hdr, struct object_info *oi,
 	if ((flags & LOOKUP_UNKNOWN_OBJECT) && (type < 0))
 		type =3D 0;
 	else if (type < 0)
-		die("invalid object type");
+		die(_("invalid object type"));
 	if (oi->typep)
 		*oi->typep =3D type;
=20
@@ -1797,7 +1797,7 @@ unsigned long get_size_from_delta(struct packed_g=
it *p,
 		 stream.total_out < sizeof(delta_head));
 	git_inflate_end(&stream);
 	if ((st !=3D Z_STREAM_END) && stream.total_out !=3D sizeof(delta_head=
)) {
-		error("delta data unpack-initial failed");
+		error(_("delta data unpack-initial failed"));
 		return 0;
 	}
=20
@@ -1974,7 +1974,7 @@ static enum object_type packed_to_object_type(str=
uct packed_git *p,
 	case OBJ_TAG:
 		break;
 	default:
-		error("unknown object type %i at offset %"PRIuMAX" in %s",
+		error(_("unknown object type %i at offset %"PRIuMAX" in %s"),
 		      type, (uintmax_t)obj_offset, p->pack_name);
 		type =3D OBJ_BAD;
 	}
@@ -2284,7 +2284,7 @@ void *unpack_entry(struct packed_git *p, off_t ob=
j_offset,
 			if (check_pack_crc(p, &w_curs, obj_offset, len, revidx->nr)) {
 				const unsigned char *sha1 =3D
 					nth_packed_object_sha1(p, revidx->nr);
-				error("bad packed object CRC for %s",
+				error(_("bad packed object CRC for %s"),
 				      sha1_to_hex(sha1));
 				mark_bad_packed_object(p, sha1);
 				unuse_pack(&w_curs);
@@ -2298,8 +2298,8 @@ void *unpack_entry(struct packed_git *p, off_t ob=
j_offset,
=20
 		base_offset =3D get_delta_base(p, &w_curs, &curpos, type, obj_offset=
);
 		if (!base_offset) {
-			error("failed to validate delta base reference "
-			      "at offset %"PRIuMAX" from %s",
+			error(_("failed to validate delta base reference "
+				"at offset %"PRIuMAX" from %s"),
 			      (uintmax_t)curpos, p->pack_name);
 			/* bail to phase 2, in hopes of recovery */
 			data =3D NULL;
@@ -2340,7 +2340,7 @@ void *unpack_entry(struct packed_git *p, off_t ob=
j_offset,
 		break;
 	default:
 		data =3D NULL;
-		error("unknown object type %i at offset %"PRIuMAX" in %s",
+		error(_("unknown object type %i at offset %"PRIuMAX" in %s"),
 		      type, (uintmax_t)obj_offset, p->pack_name);
 	}
=20
@@ -2372,8 +2372,8 @@ void *unpack_entry(struct packed_git *p, off_t ob=
j_offset,
 			revidx =3D find_pack_revindex(p, obj_offset);
 			if (revidx) {
 				base_sha1 =3D nth_packed_object_sha1(p, revidx->nr);
-				error("failed to read delta base object %s"
-				      " at offset %"PRIuMAX" from %s",
+				error(_("failed to read delta base object %s"
+					" at offset %"PRIuMAX" from %s"),
 				      sha1_to_hex(base_sha1), (uintmax_t)obj_offset,
 				      p->pack_name);
 				mark_bad_packed_object(p, base_sha1);
@@ -2392,8 +2392,8 @@ void *unpack_entry(struct packed_git *p, off_t ob=
j_offset,
 		delta_data =3D unpack_compressed_entry(p, &w_curs, curpos, delta_siz=
e);
=20
 		if (!delta_data) {
-			error("failed to unpack compressed delta "
-			      "at offset %"PRIuMAX" from %s",
+			error(_("failed to unpack compressed delta "
+				"at offset %"PRIuMAX" from %s"),
 			      (uintmax_t)curpos, p->pack_name);
 			data =3D NULL;
 			continue;
@@ -2412,7 +2412,7 @@ void *unpack_entry(struct packed_git *p, off_t ob=
j_offset,
 		 * the object.
 		 */
 		if (!data)
-			error("failed to apply delta");
+			error(_("failed to apply delta"));
=20
 		free(delta_data);
 	}
@@ -2660,19 +2660,19 @@ static int sha1_loose_object_info(const unsigne=
d char *sha1,
 		*oi->disk_sizep =3D mapsize;
 	if ((flags & LOOKUP_UNKNOWN_OBJECT)) {
 		if (unpack_sha1_header_to_strbuf(&stream, map, mapsize, hdr, sizeof(=
hdr), &hdrbuf) < 0)
-			status =3D error("unable to unpack %s header with --allow-unknown-t=
ype",
+			status =3D error(_("unable to unpack %s header with --allow-unknown=
-type"),
 				       sha1_to_hex(sha1));
 	} else if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)=
) < 0)
-		status =3D error("unable to unpack %s header",
+		status =3D error(_("unable to unpack %s header"),
 			       sha1_to_hex(sha1));
 	if (status < 0)
 		; /* Do nothing */
 	else if (hdrbuf.len) {
 		if ((status =3D parse_sha1_header_extended(hdrbuf.buf, oi, flags)) <=
 0)
-			status =3D error("unable to parse %s header with --allow-unknown-ty=
pe",
+			status =3D error(_("unable to parse %s header with --allow-unknown-=
type"),
 				       sha1_to_hex(sha1));
 	} else if ((status =3D parse_sha1_header_extended(hdr, oi, flags)) < =
0)
-		status =3D error("unable to parse %s header", sha1_to_hex(sha1));
+		status =3D error(_("unable to parse %s header"), sha1_to_hex(sha1));
 	git_inflate_end(&stream);
 	munmap(map, mapsize);
 	if (status && oi->typep)
@@ -2777,7 +2777,7 @@ static void *read_packed_sha1(const unsigned char=
 *sha1,
 		 * This should happen only in the presence of a corrupted
 		 * pack, and is better than failing outright.
 		 */
-		error("failed to read object %s at offset %"PRIuMAX" from %s",
+		error(_("failed to read object %s at offset %"PRIuMAX" from %s"),
 		      sha1_to_hex(sha1), (uintmax_t)e.offset, e.p->pack_name);
 		mark_bad_packed_object(e.p, sha1);
 		data =3D read_object(sha1, type, size);
@@ -2850,22 +2850,22 @@ void *read_sha1_file_extended(const unsigned ch=
ar *sha1,
 		return data;
=20
 	if (errno && errno !=3D ENOENT)
-		die_errno("failed to read object %s", sha1_to_hex(sha1));
+		die_errno(_("failed to read object %s"), sha1_to_hex(sha1));
=20
 	/* die if we replaced an object with one that does not exist */
 	if (repl !=3D sha1)
-		die("replacement %s not found for %s",
+		die(_("replacement %s not found for %s"),
 		    sha1_to_hex(repl), sha1_to_hex(sha1));
=20
 	if (has_loose_object(repl)) {
 		const char *path =3D sha1_file_name(sha1);
=20
-		die("loose object %s (stored in %s) is corrupt",
+		die(_("loose object %s (stored in %s) is corrupt"),
 		    sha1_to_hex(repl), path);
 	}
=20
 	if ((p =3D has_packed_and_bad(repl)) !=3D NULL)
-		die("packed object %s (stored in %s) is corrupt",
+		die(_("packed object %s (stored in %s) is corrupt"),
 		    sha1_to_hex(repl), p->pack_name);
=20
 	return NULL;
@@ -2966,22 +2966,22 @@ int finalize_object_file(const char *tmpfile, c=
onst char *filename)
 	}
 	unlink_or_warn(tmpfile);
 	if (ret) {
-		if (ret !=3D EEXIST) {
-			return error("unable to write sha1 filename %s: %s", filename, stre=
rror(ret));
-		}
+		if (ret !=3D EEXIST)
+			return error(_("unable to write sha1 filename %s: %s"),
+				     filename, strerror(ret));
 		/* FIXME!!! Collision check here ? */
 	}
=20
 out:
 	if (adjust_shared_perm(filename))
-		return error("unable to set permission to '%s'", filename);
+		return error(_("unable to set permission to '%s'"), filename);
 	return 0;
 }
=20
 static int write_buffer(int fd, const void *buf, size_t len)
 {
 	if (write_in_full(fd, buf, len) < 0)
-		return error("file write error (%s)", strerror(errno));
+		return error(_("file write error (%s)"), strerror(errno));
 	return 0;
 }
=20
@@ -3000,7 +3000,7 @@ static void close_sha1_file(int fd)
 	if (fsync_object_files)
 		fsync_or_die(fd, "sha1 file");
 	if (close(fd) !=3D 0)
-		die_errno("error when closing sha1 file");
+		die_errno(_("error when closing sha1 file"));
 }
=20
 /* Size of directory component, including the ending '/' */
@@ -3062,9 +3062,12 @@ static int write_loose_object(const unsigned cha=
r *sha1, char *hdr, int hdrlen,
 	fd =3D create_tmpfile(&tmp_file, filename);
 	if (fd < 0) {
 		if (errno =3D=3D EACCES)
-			return error("insufficient permission for adding an object to repos=
itory database %s", get_object_directory());
+			return error(_("insufficient permission for adding "
+				       "an object to repository database %s"),
+				     get_object_directory());
 		else
-			return error("unable to create temporary file: %s", strerror(errno)=
);
+			return error(_("unable to create temporary file: %s"),
+				     strerror(errno));
 	}
=20
 	/* Set it up */
@@ -3088,19 +3091,19 @@ static int write_loose_object(const unsigned ch=
ar *sha1, char *hdr, int hdrlen,
 		ret =3D git_deflate(&stream, Z_FINISH);
 		git_SHA1_Update(&c, in0, stream.next_in - in0);
 		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
-			die("unable to write sha1 file");
+			die(_("unable to write sha1 file"));
 		stream.next_out =3D compressed;
 		stream.avail_out =3D sizeof(compressed);
 	} while (ret =3D=3D Z_OK);
=20
 	if (ret !=3D Z_STREAM_END)
-		die("unable to deflate new object %s (%d)", sha1_to_hex(sha1), ret);
+		die(_("unable to deflate new object %s (%d)"), sha1_to_hex(sha1), re=
t);
 	ret =3D git_deflate_end_gently(&stream);
 	if (ret !=3D Z_OK)
-		die("deflateEnd on object %s failed (%d)", sha1_to_hex(sha1), ret);
+		die(_("deflateEnd on object %s failed (%d)"), sha1_to_hex(sha1), ret=
);
 	git_SHA1_Final(parano_sha1, &c);
 	if (hashcmp(sha1, parano_sha1) !=3D 0)
-		die("confused by unstable object source data for %s", sha1_to_hex(sh=
a1));
+		die(_("confused by unstable object source data for %s"), sha1_to_hex=
(sha1));
=20
 	close_sha1_file(fd);
=20
@@ -3109,7 +3112,7 @@ static int write_loose_object(const unsigned char=
 *sha1, char *hdr, int hdrlen,
 		utb.actime =3D mtime;
 		utb.modtime =3D mtime;
 		if (utime(tmp_file.buf, &utb) < 0)
-			warning("failed utime() on %s: %s",
+			warning(_("failed utime() on %s: %s"),
 				tmp_file.buf, strerror(errno));
 	}
=20
@@ -3183,7 +3186,7 @@ int force_object_loose(const unsigned char *sha1,=
 time_t mtime)
 		return 0;
 	buf =3D read_packed_sha1(sha1, &type, &len);
 	if (!buf)
-		return error("cannot read sha1_file for %s", sha1_to_hex(sha1));
+		return error(_("cannot read sha1_file for %s"), sha1_to_hex(sha1));
 	hdrlen =3D xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), len)=
 + 1;
 	ret =3D write_loose_object(sha1, hdr, hdrlen, buf, len, mtime);
 	free(buf);
@@ -3241,7 +3244,7 @@ static void check_commit(const void *buf, size_t =
size)
 	struct commit c;
 	memset(&c, 0, sizeof(c));
 	if (parse_commit_buffer(&c, buf, size))
-		die("corrupt commit");
+		die(_("corrupt commit"));
 }
=20
 static void check_tag(const void *buf, size_t size)
@@ -3249,7 +3252,7 @@ static void check_tag(const void *buf, size_t siz=
e)
 	struct tag t;
 	memset(&t, 0, sizeof(t));
 	if (parse_tag_buffer(&t, buf, size))
-		die("corrupt tag");
+		die(_("corrupt tag"));
 }
=20
 static int index_mem(unsigned char *sha1, void *buf, size_t size,
@@ -3343,7 +3346,7 @@ static int index_core(unsigned char *sha1, int fd=
, size_t size,
 		if (size =3D=3D read_in_full(fd, buf, size))
 			ret =3D index_mem(sha1, buf, size, type, path, flags);
 		else
-			ret =3D error("short read %s", strerror(errno));
+			ret =3D error(_("short read %s"), strerror(errno));
 		free(buf);
 	} else {
 		void *buf =3D xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
@@ -3408,29 +3411,29 @@ int index_path(unsigned char *sha1, const char =
*path, struct stat *st, unsigned
 	case S_IFREG:
 		fd =3D open(path, O_RDONLY);
 		if (fd < 0)
-			return error("open(\"%s\"): %s", path,
+			return error(_("open(\"%s\"): %s"), path,
 				     strerror(errno));
 		if (index_fd(sha1, fd, st, OBJ_BLOB, path, flags) < 0)
-			return error("%s: failed to insert into database",
+			return error(_("%s: failed to insert into database"),
 				     path);
 		break;
 	case S_IFLNK:
 		if (strbuf_readlink(&sb, path, st->st_size)) {
 			char *errstr =3D strerror(errno);
-			return error("readlink(\"%s\"): %s", path,
+			return error(_("readlink(\"%s\"): %s"), path,
 			             errstr);
 		}
 		if (!(flags & HASH_WRITE_OBJECT))
 			hash_sha1_file(sb.buf, sb.len, blob_type, sha1);
 		else if (write_sha1_file(sb.buf, sb.len, blob_type, sha1))
-			return error("%s: failed to insert into database",
+			return error(_("%s: failed to insert into database"),
 				     path);
 		strbuf_release(&sb);
 		break;
 	case S_IFDIR:
 		return resolve_gitlink_ref(path, "HEAD", sha1);
 	default:
-		return error("%s: unsupported file type", path);
+		return error(_("%s: unsupported file type"), path);
 	}
 	return 0;
 }
@@ -3454,9 +3457,9 @@ void assert_sha1_type(const unsigned char *sha1, =
enum object_type expect)
 {
 	enum object_type type =3D sha1_object_info(sha1, NULL);
 	if (type < 0)
-		die("%s is not a valid object", sha1_to_hex(sha1));
+		die(_("%s is not a valid object"), sha1_to_hex(sha1));
 	if (type !=3D expect)
-		die("%s is not a valid '%s' object", sha1_to_hex(sha1),
+		die(_("%s is not a valid '%s' object"), sha1_to_hex(sha1),
 		    typename(expect));
 }
=20
@@ -3475,7 +3478,7 @@ static int for_each_file_in_obj_subdir(int subdir=
_nr,
 	if (!dir) {
 		if (errno =3D=3D ENOENT)
 			return 0;
-		return error("unable to open %s: %s", path->buf, strerror(errno));
+		return error(_("unable to open %s: %s"), path->buf, strerror(errno))=
;
 	}
=20
 	while ((de =3D readdir(dir))) {
@@ -3603,7 +3606,7 @@ static int for_each_object_in_pack(struct packed_=
git *p, each_packed_object_fn c
 		const unsigned char *sha1 =3D nth_packed_object_sha1(p, i);
=20
 		if (!sha1)
-			return error("unable to get sha1 of object %u in %s",
+			return error(_("unable to get sha1 of object %u in %s"),
 				     i, p->pack_name);
=20
 		r =3D cb(sha1, p, i, data);
--=20
2.8.0.rc0.205.g7ec8cf1
