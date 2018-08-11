Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D5F21F404
	for <e@80x24.org>; Sat, 11 Aug 2018 04:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeHKHFL (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 03:05:11 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:54298 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727156AbeHKHFL (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 11 Aug 2018 03:05:11 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7B4SZhd027398;
        Fri, 10 Aug 2018 21:32:20 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kr347cmx5-1;
        Fri, 10 Aug 2018 21:32:20 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 8C37F2237917;
        Fri, 10 Aug 2018 21:32:20 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 7ADD92CDE5F;
        Fri, 10 Aug 2018 21:32:20 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/9] Add missing includes and forward declares
Date:   Fri, 10 Aug 2018 21:32:10 -0700
Message-Id: <20180811043218.31456-2-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.549.gd4454f3f9b
In-Reply-To: <20180811043218.31456-1-newren@gmail.com>
References: <20180811043218.31456-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-11_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808110048
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 alloc.h               |  2 ++
 apply.h               |  3 +++
 archive.h             |  4 ++++
 argv-array.h          |  2 ++
 attr.h                |  1 +
 branch.h              |  2 ++
 bulk-checkin.h        |  2 ++
 color.h               |  2 ++
 column.h              |  1 +
 commit-graph.h        |  1 +
 config.h              |  6 ++++++
 connected.h           |  1 +
 convert.h             |  3 +++
 credential.h          |  1 +
 csum-file.h           |  2 ++
 delta.h               |  2 ++
 diffcore.h            |  4 ++++
 dir-iterator.h        |  2 ++
 exec-cmd.h            |  2 ++
 fsck.h                |  1 +
 fsmonitor.h           |  7 +++++++
 gpg-interface.h       |  4 ++++
 grep.h                |  1 +
 hashmap.h             |  2 ++
 khash.h               |  4 ++++
 kwset.h               |  2 ++
 list-objects-filter.h |  4 ++++
 list-objects.h        |  4 ++++
 ll-merge.h            |  2 ++
 mailinfo.h            |  2 ++
 mailmap.h             |  4 ++++
 mem-pool.h            |  2 ++
 merge-recursive.h     |  4 +++-
 notes-cache.h         |  1 +
 notes-merge.h         |  4 ++++
 notes-utils.h         |  4 ++++
 notes.h               |  3 +++
 object-store.h        |  1 +
 object.h              |  2 ++
 oidmap.h              |  1 +
 pack-bitmap.h         |  3 +++
 pack-revindex.h       |  2 ++
 parse-options.h       |  2 ++
 patch-ids.h           |  6 ++++++
 path.h                |  3 +++
 pathspec.h            |  5 +++++
 pretty.h              |  4 ++++
 progress.h            |  2 ++
 quote.h               |  2 ++
 reachable.h           |  4 ++++
 reflog-walk.h         |  1 +
 refs.h                |  4 ++++
 remote.h              |  1 +
 repository.h          |  2 ++
 resolve-undo.h        |  2 ++
 revision.h            |  1 +
 send-pack.h           |  4 ++++
 sequencer.h           |  5 +++++
 sha1-lookup.h         |  2 ++
 shortlog.h            |  3 +++
 sideband.h            |  2 ++
 strbuf.h              |  2 ++
 submodule.h           | 10 ++++++++--
 tempfile.h            |  1 +
 trailer.h             |  3 +++
 tree-walk.h           |  2 ++
 unpack-trees.h        |  5 ++++-
 url.h                 |  2 ++
 urlmatch.h            |  1 +
 utf8.h                |  4 ++++
 varint.h              |  2 ++
 worktree.h            |  1 +
 72 files changed, 191 insertions(+), 4 deletions(-)

diff --git a/alloc.h b/alloc.h
index 3e4e828db4..7a41bb9eb3 100644
--- a/alloc.h
+++ b/alloc.h
@@ -1,9 +1,11 @@
 #ifndef ALLOC_H
 #define ALLOC_H
=20
+struct alloc_state;
 struct tree;
 struct commit;
 struct tag;
+struct repository;
=20
 void *alloc_blob_node(struct repository *r);
 void *alloc_tree_node(struct repository *r);
diff --git a/apply.h b/apply.h
index b80d8ba736..0b70e1f3f5 100644
--- a/apply.h
+++ b/apply.h
@@ -1,6 +1,9 @@
 #ifndef APPLY_H
 #define APPLY_H
=20
+#include "lockfile.h"
+#include "string-list.h"
+
 enum apply_ws_error_action {
 	nowarn_ws_error,
 	warn_on_ws_error,
diff --git a/archive.h b/archive.h
index 1f9954f7cd..3455dde54d 100644
--- a/archive.h
+++ b/archive.h
@@ -1,8 +1,12 @@
 #ifndef ARCHIVE_H
 #define ARCHIVE_H
=20
+#include "git-compat-util.h" /* For size_t, timestamp_t, etc. */
 #include "pathspec.h"
=20
+struct object_id;
+enum object_type;
+
 struct archiver_args {
 	const char *base;
 	size_t baselen;
diff --git a/argv-array.h b/argv-array.h
index a39ba43f57..c46238784c 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -1,6 +1,8 @@
 #ifndef ARGV_ARRAY_H
 #define ARGV_ARRAY_H
=20
+#include "git-compat-util.h"   /* for LAST_ARG_MUST_BE_NULL */
+
 extern const char *empty_argv[];
=20
 struct argv_array {
diff --git a/attr.h b/attr.h
index 442d464db6..3185538bda 100644
--- a/attr.h
+++ b/attr.h
@@ -7,6 +7,7 @@ struct git_attr;
 /* opaque structures used internally for attribute collection */
 struct all_attrs_item;
 struct attr_stack;
+struct index_state;
=20
 /*
  * Given a string, return the gitattribute object that
diff --git a/branch.h b/branch.h
index 473d0a93e9..7d9b330eba 100644
--- a/branch.h
+++ b/branch.h
@@ -1,6 +1,8 @@
 #ifndef BRANCH_H
 #define BRANCH_H
=20
+struct strbuf;
+
 /* Functions for acting on the information about branches. */
=20
 /*
diff --git a/bulk-checkin.h b/bulk-checkin.h
index a85527318b..e036231636 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -4,6 +4,8 @@
 #ifndef BULK_CHECKIN_H
 #define BULK_CHECKIN_H
=20
+#include "cache.h" /* for object_type */
+
 extern int index_bulk_checkin(struct object_id *oid,
 			      int fd, size_t size, enum object_type type,
 			      const char *path, unsigned flags);
diff --git a/color.h b/color.h
index 5b744e1bc6..74edbffc9d 100644
--- a/color.h
+++ b/color.h
@@ -1,6 +1,8 @@
 #ifndef COLOR_H
 #define COLOR_H
=20
+#include <stdio.h>
+
 struct strbuf;
=20
 /*
diff --git a/column.h b/column.h
index 0a61917fa7..2567a5cf4d 100644
--- a/column.h
+++ b/column.h
@@ -36,6 +36,7 @@ static inline int column_active(unsigned int colopts)
 	return (colopts & COL_ENABLE_MASK) =3D=3D COL_ENABLED;
 }
=20
+struct string_list;
 extern void print_columns(const struct string_list *list, unsigned int c=
olopts,
 			  const struct column_options *opts);
=20
diff --git a/commit-graph.h b/commit-graph.h
index 76e098934a..b006e1b415 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -4,6 +4,7 @@
 #include "git-compat-util.h"
 #include "repository.h"
 #include "string-list.h"
+#include "cache.h" /* for object_id */
=20
 struct commit;
=20
diff --git a/config.h b/config.h
index bb2f506b27..ff14cc5d1c 100644
--- a/config.h
+++ b/config.h
@@ -1,6 +1,12 @@
 #ifndef CONFIG_H
 #define CONFIG_H
=20
+#include "git-compat-util.h"  /* for size_t, off_t, timestamp_t, etc. */
+#include "hashmap.h"
+#include "string-list.h"
+
+struct object_id;
+
 /* git_config_parse_key() returns these negated: */
 #define CONFIG_INVALID_KEY 1
 #define CONFIG_NO_SECTION_OR_NAME 2
diff --git a/connected.h b/connected.h
index 322dc76372..e4c961817d 100644
--- a/connected.h
+++ b/connected.h
@@ -1,6 +1,7 @@
 #ifndef CONNECTED_H
 #define CONNECTED_H
=20
+struct object_id;
 struct transport;
=20
 /*
diff --git a/convert.h b/convert.h
index 01385d9288..b3b5a783b3 100644
--- a/convert.h
+++ b/convert.h
@@ -4,9 +4,12 @@
 #ifndef CONVERT_H
 #define CONVERT_H
=20
+#include <stdlib.h>  /* for size_t */
 #include "string-list.h"
=20
 struct index_state;
+struct object_id;
+struct strbuf;
=20
 #define CONV_EOL_RNDTRP_DIE   (1<<0) /* Die if CRLF to LF to CRLF is dif=
ferent */
 #define CONV_EOL_RNDTRP_WARN  (1<<1) /* Warn if CRLF to LF to CRLF is di=
fferent */
diff --git a/credential.h b/credential.h
index 6b0cd16be2..2b5ef76e43 100644
--- a/credential.h
+++ b/credential.h
@@ -1,6 +1,7 @@
 #ifndef CREDENTIAL_H
 #define CREDENTIAL_H
=20
+#include <stdio.h>
 #include "string-list.h"
=20
 struct credential {
diff --git a/csum-file.h b/csum-file.h
index c5a2e335e7..3bf7184736 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -1,6 +1,8 @@
 #ifndef CSUM_FILE_H
 #define CSUM_FILE_H
=20
+#include "hash.h"
+
 struct progress;
=20
 /* A SHA1-protected file */
diff --git a/delta.h b/delta.h
index 9b67531dfa..04ab4ba797 100644
--- a/delta.h
+++ b/delta.h
@@ -1,6 +1,8 @@
 #ifndef DELTA_H
 #define DELTA_H
=20
+#include <stdlib.h>  /* for NULL */
+
 /* opaque object for delta index */
 struct delta_index;
=20
diff --git a/diffcore.h b/diffcore.h
index a30da161da..5b9f80d1e6 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -4,6 +4,10 @@
 #ifndef DIFFCORE_H
 #define DIFFCORE_H
=20
+#include "cache.h" /* for object_id */
+
+struct diff_options;
+
 /* This header file is internal between diff.c and its diff transformers
  * (e.g. diffcore-rename, diffcore-pickaxe).  Never include this header
  * in anything else.
diff --git a/dir-iterator.h b/dir-iterator.h
index 27739e6c29..970793d07a 100644
--- a/dir-iterator.h
+++ b/dir-iterator.h
@@ -1,6 +1,8 @@
 #ifndef DIR_ITERATOR_H
 #define DIR_ITERATOR_H
=20
+#include "strbuf.h"
+
 /*
  * Iterate over a directory tree.
  *
diff --git a/exec-cmd.h b/exec-cmd.h
index 2522453cda..8737d84f3b 100644
--- a/exec-cmd.h
+++ b/exec-cmd.h
@@ -1,6 +1,8 @@
 #ifndef GIT_EXEC_CMD_H
 #define GIT_EXEC_CMD_H
=20
+#include "git-compat-util.h"   /* for LAST_ARG_MUST_BE_NULL */
+
 struct argv_array;
=20
 extern void git_set_exec_path(const char *exec_path);
diff --git a/fsck.h b/fsck.h
index c3cf5e0034..0c7e8c9428 100644
--- a/fsck.h
+++ b/fsck.h
@@ -6,6 +6,7 @@
 #define FSCK_IGNORE 3
=20
 struct fsck_options;
+struct object;
=20
 void fsck_set_msg_type(struct fsck_options *options,
 		const char *msg_id, const char *msg_type);
diff --git a/fsmonitor.h b/fsmonitor.h
index 65f3743636..09067abae5 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -1,6 +1,13 @@
 #ifndef FSMONITOR_H
 #define FSMONITOR_H
=20
+#include "cache.h" /* for core_fsmonitor */
+#include "dir.h"   /* for untracked_cache_invalidate_path */
+
+struct cache_entry;
+struct index_state;
+struct strbuf;
+
 extern struct trace_key trace_fsmonitor;
=20
 /*
diff --git a/gpg-interface.h b/gpg-interface.h
index 5ecff4aa0c..11e05e765b 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -1,6 +1,10 @@
 #ifndef GPG_INTERFACE_H
 #define GPG_INTERFACE_H
=20
+#include <stdlib.h>
+
+struct strbuf;
+
 #define GPG_VERIFY_VERBOSE		1
 #define GPG_VERIFY_RAW			2
 #define GPG_VERIFY_OMIT_STATUS	4
diff --git a/grep.h b/grep.h
index 0ba62a11c5..0167a1054a 100644
--- a/grep.h
+++ b/grep.h
@@ -35,6 +35,7 @@ typedef int pcre2_jit_stack;
 #include "kwset.h"
 #include "thread-utils.h"
 #include "userdiff.h"
+#include "git-compat-util.h" /* for regex_t and uint32_t */
=20
 enum grep_pat_token {
 	GREP_PATTERN,
diff --git a/hashmap.h b/hashmap.h
index d375d9cce7..855bbb5b5a 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -1,6 +1,8 @@
 #ifndef HASHMAP_H
 #define HASHMAP_H
=20
+#include "git-compat-util.h" /* for BUG, size_t, memcpy, etc. */
+
 /*
  * Generic implementation of hash-based key-value mappings.
  *
diff --git a/khash.h b/khash.h
index c0da40daa7..c7e37790bb 100644
--- a/khash.h
+++ b/khash.h
@@ -26,6 +26,10 @@
 #ifndef __AC_KHASH_H
 #define __AC_KHASH_H
=20
+#include "git-compat-util.h" /* for xcalloc, etc. */
+#include "hashmap.h" /* for sha1hash */
+#include "cache.h"   /* for hashcmp */
+
 #define AC_VERSION_KHASH_H "0.2.8"
=20
 typedef uint32_t khint32_t;
diff --git a/kwset.h b/kwset.h
index 583f6268ef..d1b1835095 100644
--- a/kwset.h
+++ b/kwset.h
@@ -3,6 +3,8 @@
  * Git.
  */
=20
+#include <stdlib.h>
+
 /* kwset.h - header declaring the keyword set library.
    Copyright (C) 1989, 1998, 2005 Free Software Foundation, Inc.
=20
diff --git a/list-objects-filter.h b/list-objects-filter.h
index a963d0274c..a6f6b4990b 100644
--- a/list-objects-filter.h
+++ b/list-objects-filter.h
@@ -1,6 +1,10 @@
 #ifndef LIST_OBJECTS_FILTER_H
 #define LIST_OBJECTS_FILTER_H
=20
+struct list_objects_filter_options;
+struct object;
+struct oidset;
+
 /*
  * During list-object traversal we allow certain objects to be
  * filtered (omitted) from the result.  The active filter uses
diff --git a/list-objects.h b/list-objects.h
index aa618d7f45..ad40762926 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -1,6 +1,10 @@
 #ifndef LIST_OBJECTS_H
 #define LIST_OBJECTS_H
=20
+struct commit;
+struct object;
+struct rev_info;
+
 typedef void (*show_commit_fn)(struct commit *, void *);
 typedef void (*show_object_fn)(struct object *, const char *, void *);
 void traverse_commit_list(struct rev_info *, show_commit_fn, show_object=
_fn, void *);
diff --git a/ll-merge.h b/ll-merge.h
index 244a31f55a..3535c543d7 100644
--- a/ll-merge.h
+++ b/ll-merge.h
@@ -5,6 +5,8 @@
 #ifndef LL_MERGE_H
 #define LL_MERGE_H
=20
+#include "xdiff/xdiff.h" /* for mmbuffer_t, mmfile_t */
+
 struct ll_merge_options {
 	unsigned virtual_ancestor : 1;
 	unsigned variant : 2;	/* favor ours, favor theirs, or union merge */
diff --git a/mailinfo.h b/mailinfo.h
index 04a25351d6..766c03dd1d 100644
--- a/mailinfo.h
+++ b/mailinfo.h
@@ -1,6 +1,8 @@
 #ifndef MAILINFO_H
 #define MAILINFO_H
=20
+#include "strbuf.h"
+
 #define MAX_BOUNDARIES 5
=20
 struct mailinfo {
diff --git a/mailmap.h b/mailmap.h
index ed7c93b05c..ce457858a7 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -1,6 +1,10 @@
 #ifndef MAILMAP_H
 #define MAILMAP_H
=20
+#include <stdlib.h>
+
+struct string_list;
+
 int read_mailmap(struct string_list *map, char **repo_abbrev);
 void clear_mailmap(struct string_list *map);
=20
diff --git a/mem-pool.h b/mem-pool.h
index 999d3c3a52..b055f602a1 100644
--- a/mem-pool.h
+++ b/mem-pool.h
@@ -1,6 +1,8 @@
 #ifndef MEM_POOL_H
 #define MEM_POOL_H
=20
+#include "git-compat-util.h" /* for FLEX_ARRAY, etc. */
+
 struct mp_block {
 	struct mp_block *next_block;
 	char *next_free;
diff --git a/merge-recursive.h b/merge-recursive.h
index fa7bc6b683..0c46a5a4ff 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -1,8 +1,10 @@
 #ifndef MERGE_RECURSIVE_H
 #define MERGE_RECURSIVE_H
=20
-#include "unpack-trees.h"
 #include "string-list.h"
+#include "unpack-trees.h"
+
+struct commit;
=20
 struct merge_options {
 	const char *ancestor;
diff --git a/notes-cache.h b/notes-cache.h
index aeeee8409d..5ad82d9031 100644
--- a/notes-cache.h
+++ b/notes-cache.h
@@ -2,6 +2,7 @@
 #define NOTES_CACHE_H
=20
 #include "notes.h"
+#include <stdlib.h>
=20
 struct notes_cache {
 	struct notes_tree tree;
diff --git a/notes-merge.h b/notes-merge.h
index f815f23451..6c74e9385b 100644
--- a/notes-merge.h
+++ b/notes-merge.h
@@ -2,6 +2,10 @@
 #define NOTES_MERGE_H
=20
 #include "notes-utils.h"
+#include "strbuf.h"
+
+struct commit;
+struct object_id;
=20
 #define NOTES_MERGE_WORKTREE "NOTES_MERGE_WORKTREE"
=20
diff --git a/notes-utils.h b/notes-utils.h
index 5d79cbef51..0476339677 100644
--- a/notes-utils.h
+++ b/notes-utils.h
@@ -2,6 +2,10 @@
 #define NOTES_UTILS_H
=20
 #include "notes.h"
+#include <stdlib.h>
+
+struct commit_list;
+struct object_id;
=20
 /*
  * Create new notes commit from the given notes tree
diff --git a/notes.h b/notes.h
index 0433f45db5..414bc6855a 100644
--- a/notes.h
+++ b/notes.h
@@ -3,6 +3,9 @@
=20
 #include "string-list.h"
=20
+struct object_id;
+struct strbuf;
+
 /*
  * Function type for combining two notes annotating the same object.
  *
diff --git a/object-store.h b/object-store.h
index e481f7ad41..05b962daba 100644
--- a/object-store.h
+++ b/object-store.h
@@ -1,6 +1,7 @@
 #ifndef OBJECT_STORE_H
 #define OBJECT_STORE_H
=20
+#include "cache.h" /* for object_id */
 #include "oidmap.h"
 #include "list.h"
 #include "sha1-array.h"
diff --git a/object.h b/object.h
index 177b1a4571..020315279d 100644
--- a/object.h
+++ b/object.h
@@ -1,6 +1,8 @@
 #ifndef OBJECT_H
 #define OBJECT_H
=20
+#include "cache.h"  /* For TYPE_BITS */
+
 struct buffer_slab;
=20
 struct parsed_object_pool {
diff --git a/oidmap.h b/oidmap.h
index d3cd2bb590..09bbbbb15e 100644
--- a/oidmap.h
+++ b/oidmap.h
@@ -1,6 +1,7 @@
 #ifndef OIDMAP_H
 #define OIDMAP_H
=20
+#include "cache.h" /* for object_id */
 #include "hashmap.h"
=20
 /*
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 4555907dee..8a04741e12 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -5,6 +5,9 @@
 #include "khash.h"
 #include "pack-objects.h"
=20
+struct commit;
+struct rev_info;
+
 struct bitmap_disk_header {
 	char magic[4];
 	uint16_t version;
diff --git a/pack-revindex.h b/pack-revindex.h
index e262f3efe8..9dde731a90 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -1,6 +1,8 @@
 #ifndef PACK_REVINDEX_H
 #define PACK_REVINDEX_H
=20
+#include "git-compat-util.h" /* for off_t */
+
 struct packed_git;
=20
 struct revindex_entry {
diff --git a/parse-options.h b/parse-options.h
index dd14911a29..1ea55cb85c 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -1,6 +1,8 @@
 #ifndef PARSE_OPTIONS_H
 #define PARSE_OPTIONS_H
=20
+#include "git-compat-util.h" /* for NORETURN, intptr_t */
+
 enum parse_opt_type {
 	/* special types */
 	OPTION_END,
diff --git a/patch-ids.h b/patch-ids.h
index bec0f727a7..79ac9a8498 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -1,6 +1,12 @@
 #ifndef PATCH_IDS_H
 #define PATCH_IDS_H
=20
+#include "diff.h"
+#include "hashmap.h"
+
+struct commit;
+struct object_id;
+
 struct patch_id {
 	struct hashmap_entry ent;
 	struct object_id patch_id;
diff --git a/path.h b/path.h
index ed6732e5a2..021c6d8153 100644
--- a/path.h
+++ b/path.h
@@ -1,7 +1,10 @@
 #ifndef PATH_H
 #define PATH_H
=20
+#include <stdlib.h>
+
 struct repository;
+struct strbuf;
=20
 /*
  * The result to all functions which return statically allocated memory =
may be
diff --git a/pathspec.h b/pathspec.h
index 099a170c2e..2a750d7472 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -1,6 +1,11 @@
 #ifndef PATHSPEC_H
 #define PATHSPEC_H
=20
+#include "string.h"   /* For str[n]cmp */
+#include "strings.h"  /* For str[n]casecmp */
+
+struct index_state;
+
 /* Pathspec magic */
 #define PATHSPEC_FROMTOP	(1<<0)
 #define PATHSPEC_MAXDEPTH	(1<<1)
diff --git a/pretty.h b/pretty.h
index 5c85d94e33..872c88d571 100644
--- a/pretty.h
+++ b/pretty.h
@@ -1,7 +1,11 @@
 #ifndef PRETTY_H
 #define PRETTY_H
=20
+#include "cache.h" /* for date_mode */
+#include "string-list.h"
+
 struct commit;
+struct strbuf;
=20
 /* Commit formats */
 enum cmit_fmt {
diff --git a/progress.h b/progress.h
index 70a4d4a0d6..9d80837f53 100644
--- a/progress.h
+++ b/progress.h
@@ -1,6 +1,8 @@
 #ifndef PROGRESS_H
 #define PROGRESS_H
=20
+#include "git-compat-util.h" /* for uint64_t */
+
 struct progress;
=20
 void display_throughput(struct progress *progress, uint64_t total);
diff --git a/quote.h b/quote.h
index ea992dcc91..407bf8a864 100644
--- a/quote.h
+++ b/quote.h
@@ -1,6 +1,8 @@
 #ifndef QUOTE_H
 #define QUOTE_H
=20
+#include <stdio.h>
+
 struct strbuf;
=20
 /* Help to copy the thing properly quoted for the shell safety.
diff --git a/reachable.h b/reachable.h
index 3c00fa0526..ef93f04911 100644
--- a/reachable.h
+++ b/reachable.h
@@ -1,7 +1,11 @@
 #ifndef REACHEABLE_H
 #define REACHEABLE_H
=20
+#include "git-compat-util.h" /* for timestamp_t */
+
 struct progress;
+struct rev_info;
+
 extern int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 						  timestamp_t timestamp);
 extern void mark_reachable_objects(struct rev_info *revs, int mark_reflo=
g,
diff --git a/reflog-walk.h b/reflog-walk.h
index 7553c448fe..cb3e73755d 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -3,6 +3,7 @@
=20
 #include "cache.h"
=20
+struct commit;
 struct reflog_walk_info;
=20
 extern void init_reflog_walk(struct reflog_walk_info **info);
diff --git a/refs.h b/refs.h
index cc2fb4c68c..ab53d72609 100644
--- a/refs.h
+++ b/refs.h
@@ -1,10 +1,14 @@
 #ifndef REFS_H
 #define REFS_H
=20
+#include "git-compat-util.h" /* for timestamp_t, strpbrk from string.h, =
etc. */
+
 struct object_id;
 struct ref_store;
+struct repository;
 struct strbuf;
 struct string_list;
+struct string_list_item;
 struct worktree;
=20
 /*
diff --git a/remote.h b/remote.h
index 976292152c..b4fc87770d 100644
--- a/remote.h
+++ b/remote.h
@@ -1,6 +1,7 @@
 #ifndef REMOTE_H
 #define REMOTE_H
=20
+#include "cache.h" /* for object_id */
 #include "parse-options.h"
 #include "hashmap.h"
 #include "refspec.h"
diff --git a/repository.h b/repository.h
index b9413be50c..112ae4c515 100644
--- a/repository.h
+++ b/repository.h
@@ -1,6 +1,8 @@
 #ifndef REPOSITORY_H
 #define REPOSITORY_H
=20
+#include "path.h"  /* for path_cache */
+
 struct config_set;
 struct git_hash_algo;
 struct index_state;
diff --git a/resolve-undo.h b/resolve-undo.h
index 87291904bd..f48e0358ed 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -1,6 +1,8 @@
 #ifndef RESOLVE_UNDO_H
 #define RESOLVE_UNDO_H
=20
+#include "cache.h" /* for object_id...and a bunch of other stuff */
+
 struct resolve_undo_info {
 	unsigned int mode[3];
 	struct object_id oid[3];
diff --git a/revision.h b/revision.h
index c599c34da9..7c88f9d8a4 100644
--- a/revision.h
+++ b/revision.h
@@ -1,6 +1,7 @@
 #ifndef REVISION_H
 #define REVISION_H
=20
+#include "commit.h" /* for rev_sort_order */
 #include "parse-options.h"
 #include "grep.h"
 #include "notes.h"
diff --git a/send-pack.h b/send-pack.h
index 6af71f7008..e148fcd960 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -3,6 +3,10 @@
=20
 #include "string-list.h"
=20
+struct child_process;
+struct oid_array;
+struct ref;
+
 /* Possible values for push_cert field in send_pack_args. */
 #define SEND_PACK_PUSH_CERT_NEVER 0
 #define SEND_PACK_PUSH_CERT_IF_ASKED 1
diff --git a/sequencer.h b/sequencer.h
index c5787c6b56..a152dd46c5 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -1,6 +1,11 @@
 #ifndef SEQUENCER_H
 #define SEQUENCER_H
=20
+#include "cache.h" /* for object_id */
+#include "strbuf.h"
+
+struct commit;
+
 const char *git_path_commit_editmsg(void);
 const char *git_path_seq_dir(void);
=20
diff --git a/sha1-lookup.h b/sha1-lookup.h
index 7678b23b36..d332662fe0 100644
--- a/sha1-lookup.h
+++ b/sha1-lookup.h
@@ -1,6 +1,8 @@
 #ifndef SHA1_LOOKUP_H
 #define SHA1_LOOKUP_H
=20
+#include "git-compat-util.h" /* for uint32_t, etc. */
+
 typedef const unsigned char *sha1_access_fn(size_t index, void *table);
=20
 extern int sha1_pos(const unsigned char *sha1,
diff --git a/shortlog.h b/shortlog.h
index 5d64cfe929..cf09c38c9c 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -2,6 +2,9 @@
 #define SHORTLOG_H
=20
 #include "string-list.h"
+#include <stdio.h>
+
+struct commit;
=20
 struct shortlog {
 	struct string_list list;
diff --git a/sideband.h b/sideband.h
index 7a8146f161..a5a32be7d8 100644
--- a/sideband.h
+++ b/sideband.h
@@ -1,6 +1,8 @@
 #ifndef SIDEBAND_H
 #define SIDEBAND_H
=20
+#include "git-compat-util.h" /* for ssize_t */
+
 #define SIDEBAND_PROTOCOL_ERROR -2
 #define SIDEBAND_REMOTE_ERROR -1
=20
diff --git a/strbuf.h b/strbuf.h
index 60a35aef16..7ff545fef4 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -1,6 +1,8 @@
 #ifndef STRBUF_H
 #define STRBUF_H
=20
+#include "git-compat-util.h"  /* for size_t, SWAP, strlen, off_t, etc. *=
/
+
 struct string_list;
=20
 /**
diff --git a/submodule.h b/submodule.h
index 4644683e6c..3adbc08915 100644
--- a/submodule.h
+++ b/submodule.h
@@ -1,11 +1,17 @@
 #ifndef SUBMODULE_H
 #define SUBMODULE_H
=20
-struct repository;
-struct diff_options;
 struct argv_array;
+struct cache_entry;
+struct diff_options;
+struct index_state;
+struct object_id;
 struct oid_array;
+struct pathspec;
 struct remote;
+struct repository;
+struct string_list;
+struct strbuf;
=20
 enum {
 	RECURSE_SUBMODULES_ONLY =3D -5,
diff --git a/tempfile.h b/tempfile.h
index 8959c5f1b5..36434eb6fa 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -2,6 +2,7 @@
 #define TEMPFILE_H
=20
 #include "list.h"
+#include "strbuf.h"
=20
 /*
  * Handle temporary files.
diff --git a/trailer.h b/trailer.h
index 6d7f8c2a52..1d05b9e625 100644
--- a/trailer.h
+++ b/trailer.h
@@ -2,6 +2,9 @@
 #define TRAILER_H
=20
 #include "list.h"
+#include <stdlib.h>
+
+struct strbuf;
=20
 enum trailer_where {
 	WHERE_DEFAULT,
diff --git a/tree-walk.h b/tree-walk.h
index 805f58f00f..196831007e 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -1,6 +1,8 @@
 #ifndef TREE_WALK_H
 #define TREE_WALK_H
=20
+struct strbuf;
+
 struct name_entry {
 	const struct object_id *oid;
 	const char *path;
diff --git a/unpack-trees.h b/unpack-trees.h
index c2b434c606..70ffcc350e 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -1,11 +1,14 @@
 #ifndef UNPACK_TREES_H
 #define UNPACK_TREES_H
=20
-#include "tree-walk.h"
 #include "argv-array.h"
+#include "cache.h"  /* for index_state */
+#include "string-list.h"
+#include "tree-walk.h"
=20
 #define MAX_UNPACK_TREES 8
=20
+struct cache_entry;
 struct unpack_trees_options;
 struct exclude_list;
=20
diff --git a/url.h b/url.h
index abdaf6fa30..f311c40a46 100644
--- a/url.h
+++ b/url.h
@@ -1,6 +1,8 @@
 #ifndef URL_H
 #define URL_H
=20
+struct strbuf;
+
 extern int is_url(const char *url);
 extern int is_urlschemechar(int first_flag, int ch);
 extern char *url_decode(const char *url);
diff --git a/urlmatch.h b/urlmatch.h
index 37ee5da85e..bb0f4dee8d 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -1,5 +1,6 @@
 #ifndef URL_MATCH_H
 #include "string-list.h"
+#include <stdlib.h>
=20
 struct url_info {
 	/* normalized url on success, must be freed, otherwise NULL */
diff --git a/utf8.h b/utf8.h
index db73a2d8d3..26ca079762 100644
--- a/utf8.h
+++ b/utf8.h
@@ -1,6 +1,10 @@
 #ifndef GIT_UTF8_H
 #define GIT_UTF8_H
=20
+#include "git-compat-util.h" /* for iconv_t */
+
+struct strbuf;
+
 typedef unsigned int ucs_char_t;  /* assuming 32bit int */
=20
 size_t display_mode_esc_sequence_len(const char *s);
diff --git a/varint.h b/varint.h
index c1c44d9a6b..8fc15a54c8 100644
--- a/varint.h
+++ b/varint.h
@@ -1,6 +1,8 @@
 #ifndef VARINT_H
 #define VARINT_H
=20
+#include "git-compat-util.h" /* for uintmax_t */
+
 extern int encode_varint(uintmax_t, unsigned char *);
 extern uintmax_t decode_varint(const unsigned char **);
=20
diff --git a/worktree.h b/worktree.h
index fe38ce10c3..e850457208 100644
--- a/worktree.h
+++ b/worktree.h
@@ -1,6 +1,7 @@
 #ifndef WORKTREE_H
 #define WORKTREE_H
=20
+#include "cache.h" /* for object_id */
 #include "refs.h"
=20
 struct strbuf;
--=20
2.18.0.549.gd4454f3f9b

