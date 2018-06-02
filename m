Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F09A1F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 04:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbeFBEdl (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 00:33:41 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45616 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeFBEdO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 00:33:14 -0400
Received: by mail-lf0-f68.google.com with SMTP id n3-v6so17614370lfe.12
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 21:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N3jI/SR/VEC46+bMxTWSSy76DTTbwAPzj+/ys2RBFe4=;
        b=ux1eqkhRJnnkkAPYV2M0hHbIU18CLhJDuFOz5N0Mspw3giYVAPLnQLZfVwJAioj5p4
         zkItqK1S9s9FGcsXFQRarrXRgz9ZnYs/i6/4IxHubLW+M9wEqgyAO4V4Il9xulQCc6fR
         +NJZIoEjtVLTBk7eQbKINcE1u4TWNz3vRktGaKanell6HBqXWWW+i0NGPBwGmA+1JrWg
         GElWLH1jocEM1TxFKQ8TA6mfu6hq37JpQOjC+G07unnOGkHgFQ4uYcnxjSAq2GoJe3Fx
         z+5lQX5WNaBOMbh7gKR8sT7uutIqDFwRaFSiS4l7GBJIzJ1XsOpeF+MVHwTpNCykM5Ol
         StHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N3jI/SR/VEC46+bMxTWSSy76DTTbwAPzj+/ys2RBFe4=;
        b=WIAld30W4DJG+DyBPy1WxP9t7MY8I9QWGg1YkDwi+HYGeKPFjbRh+bKVohzFjgTHDQ
         hW+bcWxv0OPue90ZwAyfB9sl1OSWKTztwGST58yAwoBFFXEVoODuo55VB8HrBUWISKki
         fwSclAzJNd866S/H4x9EvTBAlPIKukLCup5KG2YaIN1poudaM9cwOpJXX5Uouwo/J2TZ
         g++PgU6DqEZbRSzFiyDhBHqB8+NyCfIpy68YBQFvdOvQIFWuGwJ6JKPspUboO6xgvlsE
         C5QkG9rYp0MvI+4zUP0iTk8lUj3qKp+NPNsXsRZho2X2Ld3ZzlA3OgSv2a7XslF1ibn6
         Ab1Q==
X-Gm-Message-State: ALKqPwflmEElgiNBS7tyOKBeMCdB5v9Uq/9naZqlwI9enpBCsiNGrjw5
        BSsvoMG8AeeeVP37eBTILAKYgA==
X-Google-Smtp-Source: ADUXVKK5NoXgwyVITU1fujwMZhQ74Hj4gJuM9eNzvku7mbOyN+aVmCHuMu5aQ55hicCVecsOd7pMFw==
X-Received: by 2002:a2e:2bcb:: with SMTP id r72-v6mr10259468ljr.133.1527913991978;
        Fri, 01 Jun 2018 21:33:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o11-v6sm644776lji.0.2018.06.01.21.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 21:33:11 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 20/22] sha1-file.c: mark more strings for translation
Date:   Sat,  2 Jun 2018 06:32:39 +0200
Message-Id: <20180602043241.9941-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.309.g77c7720784
In-Reply-To: <20180602043241.9941-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-file.c | 110 ++++++++++++++++++++++++++--------------------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/sha1-file.c b/sha1-file.c
index 555e780f4b..ab055181ec 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -71,17 +71,17 @@ static void git_hash_sha1_final(unsigned char *hash, git_hash_ctx *ctx)
 
 static void git_hash_unknown_init(git_hash_ctx *ctx)
 {
-	die("trying to init unknown hash");
+	die(_("trying to init unknown hash"));
 }
 
 static void git_hash_unknown_update(git_hash_ctx *ctx, const void *data, size_t len)
 {
-	die("trying to update unknown hash");
+	die(_("trying to update unknown hash"));
 }
 
 static void git_hash_unknown_final(unsigned char *hash, git_hash_ctx *ctx)
 {
-	die("trying to finalize unknown hash");
+	die(_("trying to finalize unknown hash"));
 }
 
 const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
@@ -378,8 +378,8 @@ static int alt_odb_usable(struct raw_object_store *o,
 
 	/* Detect cases where alternate disappeared */
 	if (!is_directory(path->buf)) {
-		error("object directory %s does not exist; "
-		      "check .git/objects/info/alternates.",
+		error(_("object directory %s does not exist; "
+			"check .git/objects/info/alternates."),
 		      path->buf);
 		return 0;
 	}
@@ -429,7 +429,7 @@ static int link_alt_odb_entry(struct repository *r, const char *entry,
 	strbuf_addstr(&pathbuf, entry);
 
 	if (strbuf_normalize_path(&pathbuf) < 0 && relative_base) {
-		error("unable to normalize alternate object path: %s",
+		error(_("unable to normalize alternate object path: %s"),
 		      pathbuf.buf);
 		strbuf_release(&pathbuf);
 		return -1;
@@ -500,14 +500,14 @@ static void link_alt_odb_entries(struct repository *r, const char *alt,
 		return;
 
 	if (depth > 5) {
-		error("%s: ignoring alternate object stores, nesting too deep.",
+		error(_("%s: ignoring alternate object stores, nesting too deep"),
 				relative_base);
 		return;
 	}
 
 	strbuf_add_absolute_path(&objdirbuf, r->objects->objectdir);
 	if (strbuf_normalize_path(&objdirbuf) < 0)
-		die("unable to normalize object directory: %s",
+		die(_("unable to normalize object directory: %s"),
 		    objdirbuf.buf);
 
 	while (*alt) {
@@ -562,7 +562,7 @@ void add_to_alternates_file(const char *reference)
 	hold_lock_file_for_update(&lock, alts, LOCK_DIE_ON_ERROR);
 	out = fdopen_lock_file(&lock, "w");
 	if (!out)
-		die_errno("unable to fdopen alternates lockfile");
+		die_errno(_("unable to fdopen alternates lockfile"));
 
 	in = fopen(alts, "r");
 	if (in) {
@@ -580,14 +580,14 @@ void add_to_alternates_file(const char *reference)
 		fclose(in);
 	}
 	else if (errno != ENOENT)
-		die_errno("unable to read alternates file");
+		die_errno(_("unable to read alternates file"));
 
 	if (found) {
 		rollback_lock_file(&lock);
 	} else {
 		fprintf_or_die(out, "%s\n", reference);
 		if (commit_lock_file(&lock))
-			die_errno("unable to move new alternates file into place");
+			die_errno(_("unable to move new alternates file into place"));
 		if (the_repository->objects->alt_odb_tail)
 			link_alt_odb_entries(the_repository, reference,
 					     '\n', NULL, 0);
@@ -778,7 +778,7 @@ static void mmap_limit_check(size_t length)
 			limit = SIZE_MAX;
 	}
 	if (length > limit)
-		die("attempting to mmap %"PRIuMAX" over limit %"PRIuMAX,
+		die(_("attempting to mmap %"PRIuMAX" over limit %"PRIuMAX),
 		    (uintmax_t)length, (uintmax_t)limit);
 }
 
@@ -803,7 +803,7 @@ void *xmmap(void *start, size_t length,
 {
 	void *ret = xmmap_gently(start, length, prot, flags, fd, offset);
 	if (ret == MAP_FAILED)
-		die_errno("mmap failed");
+		die_errno(_("mmap failed"));
 	return ret;
 }
 
@@ -970,7 +970,7 @@ static void *map_sha1_file_1(struct repository *r, const char *path,
 			*size = xsize_t(st.st_size);
 			if (!*size) {
 				/* mmap() is forbidden on empty files */
-				error("object file %s is empty", path);
+				error(_("object file %s is empty"), path);
 				return NULL;
 			}
 			map = xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
@@ -1090,9 +1090,9 @@ static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long s
 	}
 
 	if (status < 0)
-		error("corrupt loose object '%s'", sha1_to_hex(sha1));
+		error(_("corrupt loose object '%s'"), sha1_to_hex(sha1));
 	else if (stream->avail_in)
-		error("garbage at end of loose object '%s'",
+		error(_("garbage at end of loose object '%s'"),
 		      sha1_to_hex(sha1));
 	free(buf);
 	return NULL;
@@ -1134,7 +1134,7 @@ static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
 	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE) && (type < 0))
 		type = 0;
 	else if (type < 0)
-		die("invalid object type");
+		die(_("invalid object type"));
 	if (oi->typep)
 		*oi->typep = type;
 
@@ -1216,19 +1216,19 @@ static int sha1_loose_object_info(struct repository *r,
 		*oi->disk_sizep = mapsize;
 	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE)) {
 		if (unpack_sha1_header_to_strbuf(&stream, map, mapsize, hdr, sizeof(hdr), &hdrbuf) < 0)
-			status = error("unable to unpack %s header with --allow-unknown-type",
+			status = error(_("unable to unpack %s header with --allow-unknown-type"),
 				       sha1_to_hex(sha1));
 	} else if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
-		status = error("unable to unpack %s header",
+		status = error(_("unable to unpack %s header"),
 			       sha1_to_hex(sha1));
 	if (status < 0)
 		; /* Do nothing */
 	else if (hdrbuf.len) {
 		if ((status = parse_sha1_header_extended(hdrbuf.buf, oi, flags)) < 0)
-			status = error("unable to parse %s header with --allow-unknown-type",
+			status = error(_("unable to parse %s header with --allow-unknown-type"),
 				       sha1_to_hex(sha1));
 	} else if ((status = parse_sha1_header_extended(hdr, oi, flags)) < 0)
-		status = error("unable to parse %s header", sha1_to_hex(sha1));
+		status = error(_("unable to parse %s header"), sha1_to_hex(sha1));
 
 	if (status >= 0 && oi->contentp) {
 		*oi->contentp = unpack_sha1_rest(&stream, hdr,
@@ -1419,19 +1419,19 @@ void *read_object_file_extended(const struct object_id *oid,
 		return data;
 
 	if (errno && errno != ENOENT)
-		die_errno("failed to read object %s", oid_to_hex(oid));
+		die_errno(_("failed to read object %s"), oid_to_hex(oid));
 
 	/* die if we replaced an object with one that does not exist */
 	if (repl != oid)
-		die("replacement %s not found for %s",
+		die(_("replacement %s not found for %s"),
 		    oid_to_hex(repl), oid_to_hex(oid));
 
 	if (!stat_sha1_file(the_repository, repl->hash, &st, &path))
-		die("loose object %s (stored in %s) is corrupt",
+		die(_("loose object %s (stored in %s) is corrupt"),
 		    oid_to_hex(repl), path);
 
 	if ((p = has_packed_and_bad(repl->hash)) != NULL)
-		die("packed object %s (stored in %s) is corrupt",
+		die(_("packed object %s (stored in %s) is corrupt"),
 		    oid_to_hex(repl), p->pack_name);
 
 	return NULL;
@@ -1533,21 +1533,21 @@ int finalize_object_file(const char *tmpfile, const char *filename)
 	unlink_or_warn(tmpfile);
 	if (ret) {
 		if (ret != EEXIST) {
-			return error_errno("unable to write sha1 filename %s", filename);
+			return error_errno(_("unable to write sha1 filename %s"), filename);
 		}
 		/* FIXME!!! Collision check here ? */
 	}
 
 out:
 	if (adjust_shared_perm(filename))
-		return error("unable to set permission to '%s'", filename);
+		return error(_("unable to set permission to '%s'"), filename);
 	return 0;
 }
 
 static int write_buffer(int fd, const void *buf, size_t len)
 {
 	if (write_in_full(fd, buf, len) < 0)
-		return error_errno("file write error");
+		return error_errno(_("file write error"));
 	return 0;
 }
 
@@ -1566,7 +1566,7 @@ static void close_sha1_file(int fd)
 	if (fsync_object_files)
 		fsync_or_die(fd, "sha1 file");
 	if (close(fd) != 0)
-		die_errno("error when closing sha1 file");
+		die_errno(_("error when closing sha1 file"));
 }
 
 /* Size of directory component, including the ending '/' */
@@ -1632,9 +1632,9 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	fd = create_tmpfile(&tmp_file, filename.buf);
 	if (fd < 0) {
 		if (errno == EACCES)
-			return error("insufficient permission for adding an object to repository database %s", get_object_directory());
+			return error(_("insufficient permission for adding an object to repository database %s"), get_object_directory());
 		else
-			return error_errno("unable to create temporary file");
+			return error_errno(_("unable to create temporary file"));
 	}
 
 	/* Set it up */
@@ -1658,21 +1658,21 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		ret = git_deflate(&stream, Z_FINISH);
 		the_hash_algo->update_fn(&c, in0, stream.next_in - in0);
 		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
-			die("unable to write sha1 file");
+			die(_("unable to write sha1 file"));
 		stream.next_out = compressed;
 		stream.avail_out = sizeof(compressed);
 	} while (ret == Z_OK);
 
 	if (ret != Z_STREAM_END)
-		die("unable to deflate new object %s (%d)", oid_to_hex(oid),
+		die(_("unable to deflate new object %s (%d)"), oid_to_hex(oid),
 		    ret);
 	ret = git_deflate_end_gently(&stream);
 	if (ret != Z_OK)
-		die("deflateEnd on object %s failed (%d)", oid_to_hex(oid),
+		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
 		    ret);
 	the_hash_algo->final_fn(parano_oid.hash, &c);
 	if (oidcmp(oid, &parano_oid) != 0)
-		die("confused by unstable object source data for %s",
+		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
 
 	close_sha1_file(fd);
@@ -1682,7 +1682,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		utb.actime = mtime;
 		utb.modtime = mtime;
 		if (utime(tmp_file.buf, &utb) < 0)
-			warning_errno("failed utime() on %s", tmp_file.buf);
+			warning_errno(_("failed utime() on %s"), tmp_file.buf);
 	}
 
 	return finalize_object_file(tmp_file.buf, filename.buf);
@@ -1757,7 +1757,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 		return 0;
 	buf = read_object(oid->hash, &type, &len);
 	if (!buf)
-		return error("cannot read sha1_file for %s", oid_to_hex(oid));
+		return error(_("cannot read sha1_file for %s"), oid_to_hex(oid));
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", type_name(type), len) + 1;
 	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime);
 	free(buf);
@@ -1802,7 +1802,7 @@ static void check_commit(const void *buf, size_t size)
 	struct commit c;
 	memset(&c, 0, sizeof(c));
 	if (parse_commit_buffer(&c, buf, size))
-		die("corrupt commit");
+		die(_("corrupt commit"));
 }
 
 static void check_tag(const void *buf, size_t size)
@@ -1810,7 +1810,7 @@ static void check_tag(const void *buf, size_t size)
 	struct tag t;
 	memset(&t, 0, sizeof(t));
 	if (parse_tag_buffer(&t, buf, size))
-		die("corrupt tag");
+		die(_("corrupt tag"));
 }
 
 static int index_mem(struct object_id *oid, void *buf, size_t size,
@@ -1903,10 +1903,10 @@ static int index_core(struct object_id *oid, int fd, size_t size,
 		char *buf = xmalloc(size);
 		ssize_t read_result = read_in_full(fd, buf, size);
 		if (read_result < 0)
-			ret = error_errno("read error while indexing %s",
+			ret = error_errno(_("read error while indexing %s"),
 					  path ? path : "<unknown>");
 		else if (read_result != size)
-			ret = error("short read while indexing %s",
+			ret = error(_("short read while indexing %s"),
 				    path ? path : "<unknown>");
 		else
 			ret = index_mem(oid, buf, size, type, path, flags);
@@ -1977,7 +1977,7 @@ int index_path(struct object_id *oid, const char *path, struct stat *st, unsigne
 		if (fd < 0)
 			return error_errno("open(\"%s\")", path);
 		if (index_fd(oid, fd, st, OBJ_BLOB, path, flags) < 0)
-			return error("%s: failed to insert into database",
+			return error(_("%s: failed to insert into database"),
 				     path);
 		break;
 	case S_IFLNK:
@@ -1986,13 +1986,13 @@ int index_path(struct object_id *oid, const char *path, struct stat *st, unsigne
 		if (!(flags & HASH_WRITE_OBJECT))
 			hash_object_file(sb.buf, sb.len, blob_type, oid);
 		else if (write_object_file(sb.buf, sb.len, blob_type, oid))
-			rc = error("%s: failed to insert into database", path);
+			rc = error(_("%s: failed to insert into database"), path);
 		strbuf_release(&sb);
 		break;
 	case S_IFDIR:
 		return resolve_gitlink_ref(path, "HEAD", oid);
 	default:
-		return error("%s: unsupported file type", path);
+		return error(_("%s: unsupported file type"), path);
 	}
 	return rc;
 }
@@ -2016,9 +2016,9 @@ void assert_oid_type(const struct object_id *oid, enum object_type expect)
 {
 	enum object_type type = oid_object_info(the_repository, oid, NULL);
 	if (type < 0)
-		die("%s is not a valid object", oid_to_hex(oid));
+		die(_("%s is not a valid object"), oid_to_hex(oid));
 	if (type != expect)
-		die("%s is not a valid '%s' object", oid_to_hex(oid),
+		die(_("%s is not a valid '%s' object"), oid_to_hex(oid),
 		    type_name(expect));
 }
 
@@ -2045,7 +2045,7 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 	dir = opendir(path->buf);
 	if (!dir) {
 		if (errno != ENOENT)
-			r = error_errno("unable to open %s", path->buf);
+			r = error_errno(_("unable to open %s"), path->buf);
 		strbuf_setlen(path, origlen);
 		return r;
 	}
@@ -2202,18 +2202,18 @@ static int check_stream_sha1(git_zstream *stream,
 	git_inflate_end(stream);
 
 	if (status != Z_STREAM_END) {
-		error("corrupt loose object '%s'", sha1_to_hex(expected_sha1));
+		error(_("corrupt loose object '%s'"), sha1_to_hex(expected_sha1));
 		return -1;
 	}
 	if (stream->avail_in) {
-		error("garbage at end of loose object '%s'",
+		error(_("garbage at end of loose object '%s'"),
 		      sha1_to_hex(expected_sha1));
 		return -1;
 	}
 
 	the_hash_algo->final_fn(real_sha1, &c);
 	if (hashcmp(expected_sha1, real_sha1)) {
-		error("sha1 mismatch for %s (expected %s)", path,
+		error(_("sha1 mismatch for %s (expected %s)"), path,
 		      sha1_to_hex(expected_sha1));
 		return -1;
 	}
@@ -2237,18 +2237,18 @@ int read_loose_object(const char *path,
 
 	map = map_sha1_file_1(the_repository, path, NULL, &mapsize);
 	if (!map) {
-		error_errno("unable to mmap %s", path);
+		error_errno(_("unable to mmap %s"), path);
 		goto out;
 	}
 
 	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0) {
-		error("unable to unpack header of %s", path);
+		error(_("unable to unpack header of %s"), path);
 		goto out;
 	}
 
 	*type = parse_sha1_header(hdr, size);
 	if (*type < 0) {
-		error("unable to parse header of %s", path);
+		error(_("unable to parse header of %s"), path);
 		git_inflate_end(&stream);
 		goto out;
 	}
@@ -2259,13 +2259,13 @@ int read_loose_object(const char *path,
 	} else {
 		*contents = unpack_sha1_rest(&stream, hdr, *size, expected_oid->hash);
 		if (!*contents) {
-			error("unable to unpack contents of %s", path);
+			error(_("unable to unpack contents of %s"), path);
 			git_inflate_end(&stream);
 			goto out;
 		}
 		if (check_object_signature(expected_oid, *contents,
 					 *size, type_name(*type))) {
-			error("sha1 mismatch for %s (expected %s)", path,
+			error(_("sha1 mismatch for %s (expected %s)"), path,
 			      oid_to_hex(expected_oid));
 			free(*contents);
 			goto out;
-- 
2.18.0.rc0.309.g77c7720784

