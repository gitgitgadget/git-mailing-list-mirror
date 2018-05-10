Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F1AB1F424
	for <e@80x24.org>; Thu, 10 May 2018 00:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935619AbeEJAMV (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 20:12:21 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33905 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935617AbeEJAMU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 20:12:20 -0400
Received: by mail-pf0-f195.google.com with SMTP id a14-v6so172733pfi.1
        for <git@vger.kernel.org>; Wed, 09 May 2018 17:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LIzb+E5pyq3i0P+Rcbj8fTAhYOWCXsbUpar+qXWWGL0=;
        b=E7TL68hz4V02ltmoGtGoZfrjmfC9D/NupUzQqoav098LOd1S16q9Zm1KUxC2eQ9x7d
         l0o/dLS3sSzr4LGFzQ/0QeXkW+yZUc7dYCQpkRLTY6ouprb0y8g0nKwfwwEpKkywX9R5
         IpSNhHsNoWnc7mKHRZ2FJlsxjcNG0mWCTAu5fiKCqU7v680+NRF8sDI2qTmepkQTWBc+
         LqhR9BrtZMlYbUnvlC4os3clfF7j1hczrOD32Fz12owgjH3VbbeBggezwKoNJoM9k1xt
         9NKy5HhaBQyBPl3kubW0CPy0R9ylSZwaGZBJlpoP8trRLIgT6CHN8tYSonkLuqgQ9r4X
         SQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LIzb+E5pyq3i0P+Rcbj8fTAhYOWCXsbUpar+qXWWGL0=;
        b=jsYdcKcKAhqaLcbjRh3qJW3rZq1Nx2Xcxrfke5UBBOlzISzRVnjS/dH7jzLtmw076Y
         imkcH/ikRGbsyhspZDEZ43OrnU3ZE5aXiSbtcrfSFUVUSG1gKOieywdPUh+WM5G3eQO8
         aywRGhlWlzYsFl/R3YcAJLEKV/7FWqDSjAH/LELndsf/rw3fLLZ1fX77yyEYg7GBwxAc
         L1XAgHP7bqvHgodwm9OXkaCY2iFiBqohnJPGf3jiIRCiHODkdL6YcSsJaQ8hSqjc7G0c
         3R+ZhemrtZii1ePX8Rp3QpWJdhr5fosd7lKXgtvpFJmKo/zBAvsWVY4yctkEYFQoaez/
         BX4g==
X-Gm-Message-State: ALQs6tAqx7KN5Ii4w7JzATp+MAbC92izCqVmyR6hIULTNKeMk4a7HnwU
        Ew405B3xW+U1yk0Mtk/S9dWyHQ==
X-Google-Smtp-Source: AB8JxZqyRMeTOuBPTjrTBNh5So39agOIjXx7omgwm03tm3JejCezcoWB7WktSpiUOSIo8ellu2a/Uw==
X-Received: by 2002:a65:5c88:: with SMTP id a8-v6mr36568214pgt.373.1525911139138;
        Wed, 09 May 2018 17:12:19 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id x71sm70838706pfe.47.2018.05.09.17.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 17:12:18 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] packfile.h: remove all extern keywords
Date:   Wed,  9 May 2018 17:12:11 -0700
Message-Id: <20180510001211.163692-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <20180510001211.163692-1-sbeller@google.com>
References: <20180510001211.163692-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Per our coding guidelines we prefer to only use the extern keyword
when needed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.h | 80 +++++++++++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/packfile.h b/packfile.h
index cdab0557979..eb3b1154501 100644
--- a/packfile.h
+++ b/packfile.h
@@ -10,32 +10,32 @@
  *
  * Example: odb_pack_name(out, sha1, "idx") => ".git/objects/pack/pack-1234..idx"
  */
-extern char *odb_pack_name(struct strbuf *buf, const unsigned char *sha1, const char *ext);
+char *odb_pack_name(struct strbuf *buf, const unsigned char *sha1, const char *ext);
 
 /*
  * Return the name of the (local) packfile with the specified sha1 in
  * its name.  The return value is a pointer to memory that is
  * overwritten each time this function is called.
  */
-extern char *sha1_pack_name(const unsigned char *sha1);
+char *sha1_pack_name(const unsigned char *sha1);
 
 /*
  * Return the name of the (local) pack index file with the specified
  * sha1 in its name.  The return value is a pointer to memory that is
  * overwritten each time this function is called.
  */
-extern char *sha1_pack_index_name(const unsigned char *sha1);
+char *sha1_pack_index_name(const unsigned char *sha1);
 
-extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
+struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
 /* A hook to report invalid files in pack directory */
 #define PACKDIR_FILE_PACK 1
 #define PACKDIR_FILE_IDX 2
 #define PACKDIR_FILE_GARBAGE 4
-extern void (*report_garbage)(unsigned seen_bits, const char *path);
+void (*report_garbage)(unsigned seen_bits, const char *path);
 
-extern void reprepare_packed_git(struct repository *r);
-extern void install_packed_git(struct repository *r, struct packed_git *pack);
+void reprepare_packed_git(struct repository *r);
+void install_packed_git(struct repository *r, struct packed_git *pack);
 
 struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
@@ -46,31 +46,31 @@ struct list_head *get_packed_git_mru(struct repository *r);
  */
 unsigned long approximate_object_count(void);
 
-extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
+struct packed_git *find_sha1_pack(const unsigned char *sha1,
 					 struct packed_git *packs);
 
-extern void pack_report(void);
+void pack_report(void);
 
 /*
  * mmap the index file for the specified packfile (if it is not
  * already mmapped).  Return 0 on success.
  */
-extern int open_pack_index(struct packed_git *);
+int open_pack_index(struct packed_git *);
 
 /*
  * munmap the index file for the specified packfile (if it is
  * currently mmapped).
  */
-extern void close_pack_index(struct packed_git *);
+void close_pack_index(struct packed_git *);
 
-extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
-extern void close_pack_windows(struct packed_git *);
-extern void close_pack(struct packed_git *);
-extern void close_all_packs(struct raw_object_store *o);
-extern void close_and_free_packs(struct raw_object_store *o);
-extern void unuse_pack(struct pack_window **);
-extern void clear_delta_base_cache(void);
-extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
+unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
+void close_pack_windows(struct packed_git *);
+void close_pack(struct packed_git *);
+void close_all_packs(struct raw_object_store *o);
+void close_and_free_packs(struct raw_object_store *o);
+void unuse_pack(struct pack_window **);
+void clear_delta_base_cache(void);
+struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
 
 /*
  * Make sure that a pointer access into an mmap'd index file is within bounds,
@@ -80,7 +80,7 @@ extern struct packed_git *add_packed_git(const char *path, size_t path_len, int
  * (like the 64-bit extended offset table), as we compare the size to the
  * fixed-length parts when we open the file.
  */
-extern void check_pack_index_ptr(const struct packed_git *p, const void *ptr);
+void check_pack_index_ptr(const struct packed_git *p, const void *ptr);
 
 /*
  * Perform binary search on a pack-index for a given oid. Packfile is expected to
@@ -96,51 +96,51 @@ int bsearch_pack(const struct object_id *oid, const struct packed_git *p, uint32
  * at the SHA-1 within the mmapped index.  Return NULL if there is an
  * error.
  */
-extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t n);
+const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t n);
 /*
  * Like nth_packed_object_sha1, but write the data into the object specified by
  * the the first argument.  Returns the first argument on success, and NULL on
  * error.
  */
-extern const struct object_id *nth_packed_object_oid(struct object_id *, struct packed_git *, uint32_t n);
+const struct object_id *nth_packed_object_oid(struct object_id *, struct packed_git *, uint32_t n);
 
 /*
  * Return the offset of the nth object within the specified packfile.
  * The index must already be opened.
  */
-extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
+off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
 
 /*
  * If the object named sha1 is present in the specified packfile,
  * return its offset within the packfile; otherwise, return 0.
  */
-extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
+off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
 
-extern int is_pack_valid(struct packed_git *);
-extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
-extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
-extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
-extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
+int is_pack_valid(struct packed_git *);
+void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
+unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
+unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
+int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
 
-extern void release_pack_memory(size_t);
+void release_pack_memory(size_t);
 
 /* global flag to enable extra checks when accessing packed objects */
-extern int do_check_packed_object_crc;
+int do_check_packed_object_crc;
 
-extern int packed_object_info(struct packed_git *pack, off_t offset, struct object_info *);
+int packed_object_info(struct packed_git *pack, off_t offset, struct object_info *);
 
-extern void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
-extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
+void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
+const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
 
 /*
  * Iff a pack file in the given repository contains the object named by sha1,
  * return true and store its location to e.
  */
-extern int find_pack_entry(struct repository *r, const unsigned char *sha1, struct pack_entry *e);
+int find_pack_entry(struct repository *r, const unsigned char *sha1, struct pack_entry *e);
 
-extern int has_sha1_pack(const unsigned char *sha1);
+int has_sha1_pack(const unsigned char *sha1);
 
-extern int has_pack_index(const unsigned char *sha1);
+int has_pack_index(const unsigned char *sha1);
 
 /*
  * Only iterate over packs obtained from the promisor remote.
@@ -156,13 +156,13 @@ typedef int each_packed_object_fn(const struct object_id *oid,
 				  struct packed_git *pack,
 				  uint32_t pos,
 				  void *data);
-extern int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn, void *data);
-extern int for_each_packed_object(each_packed_object_fn, void *, unsigned flags);
+int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn, void *data);
+int for_each_packed_object(each_packed_object_fn, void *, unsigned flags);
 
 /*
  * Return 1 if an object in a promisor packfile is or refers to the given
  * object, 0 otherwise.
  */
-extern int is_promisor_object(const struct object_id *oid);
+int is_promisor_object(const struct object_id *oid);
 
 #endif
-- 
2.17.0.255.g8bfb7c0704

