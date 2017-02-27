Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D3911F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 23:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbdB0XxU (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 18:53:20 -0500
Received: from mout.gmx.net ([212.227.17.22]:50813 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751338AbdB0XxR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 18:53:17 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVayZ-1cos0l14Yx-00YyMC; Mon, 27
 Feb 2017 22:31:52 +0100
Date:   Mon, 27 Feb 2017 22:31:51 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/6] Use time_t where appropriate
In-Reply-To: <cover.1488231002.git.johannes.schindelin@gmx.de>
Message-ID: <75efe76cbb0636741a7c3aec9e21459bc1dc3cbe.1488231002.git.johannes.schindelin@gmx.de>
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qOji7Cs4I6sBAVR0jQgQpbOZ8NVC48/JOoyBsDN8qiu8IrkueAD
 b7kwn0b9uGqltOU1r2z0CmRErQGDt8emiaUv5mmQ4XiQ2pi+O+UGYPzBzEgwjhK9KZz0tWo
 nyij3WYxHZOAcJ3VB+a6yD7haLT1LwdKB5WX7uNxoQSgQAObMYquXXlL9hyS4jXZ+0Y4anf
 OvicR0pkmwd/sTE3JGBcw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jdhadXe6/h0=:Kuu090H9tmST66/nvGPJY3
 OxJGpYK1Z1gL/2No1wZzophZPqf2S0cOUi0j7KM8862Ra7oCKUGFbAtmZ5MaKBCIbB9LfVk0l
 QNsWcrfTTTtLWTxrurx0gFe0SAlDP89LJz4b8iFHcPA6ksKLwoZb9MgEB92ZqFKCyQYvzP4bt
 fLo/uSD0Cp1A3ldBTdkjMDS9JSvuH2D3MUjDyYWJ0z9HmTEs3umh18faTLmGdR094faCc4VJ6
 alinzcxsfazD9O8+SMtGyiBymy10Lx7kKMUGt8J/Pswbix6P9YWR7h68xxA8au3jjiaG7ZIYw
 3HPiJ5ATsaYrFRvRZPDaHf8PSZsX4xj4fzcdNJlU2CH6t4u8DQn7Cpg6Xa6WEJBfpSeviOWd3
 OSz+zw4QCirOXFKlZV1EXy8PzWcilUahp6cWz+zJzKyUE5CYmtPhFRfNWoHhK9GMgxZWPKoGB
 /po3Bedqys5Ku5bu1tayc2xnoaq1CPlDnoGH36qLGEFimwLSWHmKBDoBPdv+04sk/bQUtJMM6
 S4NUvZn7ikPM92nMORlkypHYM2SDsS6hGPoX9S8v7vO/ulu8vX44pxB/YQMw/hoceNv78Nu6V
 WdpDFPXR9tMQ2J5guV5aXCZl/AAV36ZOqPD/0XyARIRljEqw/CoE7q/gM0e4Iu5i+Vi97br82
 Ketc3R/L8UZm1IIN3tPY5RVv1pyeM/t1c9TdhZYhYdtMY/LnqSqVI5904XaJb3HbMmCRk5SzA
 0hyfn3fxOsARk5TxDcyDQEXXym56+Yi2i7RP7FtTxsPaLoggErbhKDlZmup3IzdxOhHoU15HB
 Tajd3W649QmeK5NLMYx7YUogqBt0MsSgEJZia5SVDcfPqUXtCQmPL8F+v4Xyr70Amsnsp/Tpt
 JJc4Q35lrm7XCohBo8yKzDR3EB168d7OtqL1KPUnRN5gF+subD3EX93/zBCqYD/Rdrf1qCLCn
 W6ApF3kRKqqk+uDxb2zYC8lC/sx9bbkdEt9C/OhNMLMInPeQIWkonNNpm8zj6GKl4UDL3uo86
 t93f/0/K3f3fzMoUPUuFgC+JTzZ5ZG2miCBTVksBtGjn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git's source code assumes that unsigned long is at least as precise as
time_t. That causes a lot of problems, in particular where unsigned long
is only 32-bit (notably on Windows, even in 64-bit versions).

So let's just use time_t instead.

Note that in some systems (most notably 32-bit Linux), time_t is *still*
only 32-bit.

Therefore, it might seem desirable to simply replace unsigned long by
int64_t when working with timestamps, but that comes with its own set of
problems, as we often interact with the system's date functions that
*do* use time_t.

So let's just stick with time_t.

By necessity, this is a very, very large patch, as it has to replace all
timestamps' data type in one go.

As `time_t` can be signed, we now have to switch to using LONG_MAX as
the maximum timestamp lest expressions like `timestamp < TIME_MAX`
evaluate to false. Technically, this introduces a limitation on
platforms where we used 64-bit unsigned longs to represent timestamps
before. Practically, however, this simply unifies the behavior with
platforms where `time_t` is signed (and where sending too large
timestamps to libc functions would fail).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/api-parse-options.txt |  8 ++---
 builtin/am.c                                  |  2 +-
 builtin/blame.c                               |  8 ++---
 builtin/fsck.c                                |  4 +--
 builtin/gc.c                                  |  2 +-
 builtin/log.c                                 |  2 +-
 builtin/merge-base.c                          |  2 +-
 builtin/name-rev.c                            |  6 ++--
 builtin/pack-objects.c                        |  4 +--
 builtin/prune.c                               |  2 +-
 builtin/receive-pack.c                        |  6 ++--
 builtin/reflog.c                              | 24 ++++++-------
 builtin/show-branch.c                         |  4 +--
 builtin/worktree.c                            |  2 +-
 bundle.c                                      |  2 +-
 cache.h                                       | 14 ++++----
 commit.c                                      | 12 +++----
 commit.h                                      |  2 +-
 config.mak.uname                              |  2 ++
 credential-cache--daemon.c                    | 12 +++----
 date.c                                        | 50 +++++++++++++--------------
 fetch-pack.c                                  |  6 ++--
 git-compat-util.h                             |  2 +-
 http-backend.c                                |  4 +--
 parse-options-cb.c                            |  4 +--
 pretty.c                                      |  2 +-
 reachable.c                                   | 10 +++---
 reachable.h                                   |  4 +--
 ref-filter.c                                  |  2 +-
 reflog-walk.c                                 |  8 ++---
 refs.c                                        | 14 ++++----
 refs.h                                        |  8 ++---
 refs/files-backend.c                          |  4 +--
 revision.c                                    |  6 ++--
 revision.h                                    |  4 +--
 sha1_name.c                                   |  6 ++--
 t/helper/test-date.c                          |  4 +--
 t/helper/test-parse-options.c                 |  2 +-
 tag.c                                         |  2 +-
 tag.h                                         |  2 +-
 upload-pack.c                                 |  4 +--
 vcs-svn/fast_export.c                         |  4 +--
 vcs-svn/fast_export.h                         |  4 +--
 vcs-svn/svndump.c                             |  2 +-
 wt-status.c                                   |  2 +-
 45 files changed, 140 insertions(+), 140 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 27bd701c0d6..28c9a64fc11 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -178,13 +178,13 @@ There are some macros to easily define options:
 	scale the provided value by 1024, 1024^2 or 1024^3 respectively.
 	The scaled value is put into `unsigned_long_var`.
 
-`OPT_DATE(short, long, &int_var, description)`::
+`OPT_DATE(short, long, &time_t_var, description)`::
 	Introduce an option with date argument, see `approxidate()`.
-	The timestamp is put into `int_var`.
+	The timestamp is put into `time_t_var`.
 
-`OPT_EXPIRY_DATE(short, long, &int_var, description)`::
+`OPT_EXPIRY_DATE(short, long, &time_t_var, description)`::
 	Introduce an option with expiry date argument, see `parse_expiry_date()`.
-	The timestamp is put into `int_var`.
+	The timestamp is put into `time_t_var`.
 
 `OPT_CALLBACK(short, long, &var, arg_str, description, func_ptr)`::
 	Introduce an option with argument.
diff --git a/builtin/am.c b/builtin/am.c
index 75e2d939036..c3e0a4816e4 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -877,7 +877,7 @@ static int hg_patch_to_mail(FILE *out, FILE *in, int keep_cr)
 		if (skip_prefix(sb.buf, "# User ", &str))
 			fprintf(out, "From: %s\n", str);
 		else if (skip_prefix(sb.buf, "# Date ", &str)) {
-			unsigned long timestamp;
+			time_t timestamp;
 			long tz, tz2;
 			char *end;
 
diff --git a/builtin/blame.c b/builtin/blame.c
index c9486dd580b..33701a1353e 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1570,13 +1570,13 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 struct commit_info {
 	struct strbuf author;
 	struct strbuf author_mail;
-	unsigned long author_time;
+	time_t author_time;
 	struct strbuf author_tz;
 
 	/* filled only when asked for details */
 	struct strbuf committer;
 	struct strbuf committer_mail;
-	unsigned long committer_time;
+	time_t committer_time;
 	struct strbuf committer_tz;
 
 	struct strbuf summary;
@@ -1587,7 +1587,7 @@ struct commit_info {
  */
 static void get_ac_line(const char *inbuf, const char *what,
 	struct strbuf *name, struct strbuf *mail,
-	unsigned long *time, struct strbuf *tz)
+	time_t *time, struct strbuf *tz)
 {
 	struct ident_split ident;
 	size_t len, maillen, namelen;
@@ -1846,7 +1846,7 @@ static void assign_blame(struct scoreboard *sb, int opt)
 	stop_progress(&pi.progress);
 }
 
-static const char *format_time(unsigned long time, const char *tz_str,
+static const char *format_time(time_t time, const char *tz_str,
 			       int show_raw_time)
 {
 	static struct strbuf time_buf = STRBUF_INIT;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 5413c76e7a6..42452744d67 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -397,7 +397,7 @@ static int fsck_obj_buffer(const unsigned char *sha1, enum object_type type,
 static int default_refs;
 
 static void fsck_handle_reflog_sha1(const char *refname, unsigned char *sha1,
-	unsigned long timestamp)
+	time_t timestamp)
 {
 	struct object *obj;
 
@@ -418,7 +418,7 @@ static void fsck_handle_reflog_sha1(const char *refname, unsigned char *sha1,
 }
 
 static int fsck_handle_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
+		const char *email, time_t timestamp, int tz,
 		const char *message, void *cb_data)
 {
 	const char *refname = cb_data;
diff --git a/builtin/gc.c b/builtin/gc.c
index 331f2192607..7be9d106c0b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -67,7 +67,7 @@ static void git_config_date_string(const char *key, const char **output)
 	if (git_config_get_string_const(key, output))
 		return;
 	if (strcmp(*output, "now")) {
-		unsigned long now = approxidate("now");
+		time_t now = approxidate("now");
 		if (approxidate(*output) >= now)
 			git_die_config(key, _("Invalid %s: '%s'"), key, *output);
 	}
diff --git a/builtin/log.c b/builtin/log.c
index 24612c2299a..c0d3143d0e3 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -904,7 +904,7 @@ static void gen_message_id(struct rev_info *info, char *base)
 {
 	struct strbuf buf = STRBUF_INIT;
 	strbuf_addf(&buf, "%s.%"PRItime".git.%s", base,
-		    (unsigned long) time(NULL),
+		    (time_t) time(NULL),
 		    git_committer_info(IDENT_NO_NAME|IDENT_NO_DATE|IDENT_STRICT));
 	info->message_id = strbuf_detach(&buf, NULL);
 }
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index b572a37c261..5a9580230c8 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -132,7 +132,7 @@ static void add_one_commit(unsigned char *sha1, struct rev_collect *revs)
 }
 
 static int collect_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-				  const char *ident, unsigned long timestamp,
+				  const char *ident, time_t timestamp,
 				  int tz, const char *message, void *cbdata)
 {
 	struct rev_collect *revs = cbdata;
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index a0f16407b93..5faafeda96f 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -10,7 +10,7 @@
 
 typedef struct rev_name {
 	const char *tip_name;
-	unsigned long taggerdate;
+	time_t taggerdate;
 	int generation;
 	int distance;
 } rev_name;
@@ -21,7 +21,7 @@ static long cutoff = LONG_MAX;
 #define MERGE_TRAVERSAL_WEIGHT 65535
 
 static void name_rev(struct commit *commit,
-		const char *tip_name, unsigned long taggerdate,
+		const char *tip_name, time_t taggerdate,
 		int generation, int distance,
 		int deref)
 {
@@ -145,7 +145,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 	struct name_ref_data *data = cb_data;
 	int can_abbreviate_output = data->tags_only && data->name_only;
 	int deref = 0;
-	unsigned long taggerdate = TIME_MAX;
+	time_t taggerdate = TIME_MAX;
 
 	if (data->tags_only && !starts_with(path, "refs/tags/"))
 		return 0;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8841f8b366b..e46ed73f51b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -44,7 +44,7 @@ static uint32_t nr_result, nr_written;
 static int non_empty;
 static int reuse_delta = 1, reuse_object = 1;
 static int keep_unreachable, unpack_unreachable, include_tag;
-static unsigned long unpack_unreachable_expiration;
+static time_t unpack_unreachable_expiration;
 static int pack_loose_unreachable;
 static int local;
 static int have_non_local_packs;
@@ -2593,7 +2593,7 @@ static int has_sha1_pack_kept_or_nonlocal(const unsigned char *sha1)
 static struct sha1_array recent_objects;
 
 static int loosened_object_can_be_discarded(const unsigned char *sha1,
-					    unsigned long mtime)
+					    time_t mtime)
 {
 	if (!unpack_unreachable_expiration)
 		return 0;
diff --git a/builtin/prune.c b/builtin/prune.c
index 1e5eb0292b1..a8babb1f201 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -13,7 +13,7 @@ static const char * const prune_usage[] = {
 };
 static int show_only;
 static int verbose;
-static unsigned long expire;
+static time_t expire;
 static int show_progress = -1;
 
 static int prune_tmp_file(const char *fullpath)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 4a878645847..1b21617c601 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -77,7 +77,7 @@ static const char *NONCE_OK = "OK";
 static const char *NONCE_SLOP = "SLOP";
 static const char *nonce_status;
 static long nonce_stamp_slop;
-static unsigned long nonce_stamp_slop_limit;
+static time_t nonce_stamp_slop_limit;
 static struct ref_transaction *transaction;
 
 static enum {
@@ -451,7 +451,7 @@ static void hmac_sha1(unsigned char *out,
 	git_SHA1_Final(out, &ctx);
 }
 
-static char *prepare_push_cert_nonce(const char *path, unsigned long stamp)
+static char *prepare_push_cert_nonce(const char *path, time_t stamp)
 {
 	struct strbuf buf = STRBUF_INIT;
 	unsigned char sha1[20];
@@ -493,7 +493,7 @@ static char *find_header(const char *msg, size_t len, const char *key)
 static const char *check_nonce(const char *buf, size_t len)
 {
 	char *nonce = find_header(buf, len, "nonce");
-	unsigned long stamp, ostamp;
+	time_t stamp, ostamp;
 	char *bohmac, *expect = NULL;
 	const char *retval = NONCE_BAD;
 
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 7a7136e53e2..331c874174e 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -16,14 +16,14 @@ static const char reflog_delete_usage[] =
 static const char reflog_exists_usage[] =
 "git reflog exists <ref>";
 
-static unsigned long default_reflog_expire;
-static unsigned long default_reflog_expire_unreachable;
+static time_t default_reflog_expire;
+static time_t default_reflog_expire_unreachable;
 
 struct cmd_reflog_expire_cb {
 	struct rev_info revs;
 	int stalefix;
-	unsigned long expire_total;
-	unsigned long expire_unreachable;
+	time_t expire_total;
+	time_t expire_unreachable;
 	int recno;
 };
 
@@ -219,7 +219,7 @@ static int keep_entry(struct commit **it, unsigned char *sha1)
 static void mark_reachable(struct expire_reflog_policy_cb *cb)
 {
 	struct commit_list *pending;
-	unsigned long expire_limit = cb->mark_limit;
+	time_t expire_limit = cb->mark_limit;
 	struct commit_list *leftover = NULL;
 
 	for (pending = cb->mark_list; pending; pending = pending->next)
@@ -284,7 +284,7 @@ static int unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit
  * Return true iff the specified reflog entry should be expired.
  */
 static int should_expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-				    const char *email, unsigned long timestamp, int tz,
+				    const char *email, time_t timestamp, int tz,
 				    const char *message, void *cb_data)
 {
 	struct expire_reflog_policy_cb *cb = cb_data;
@@ -392,8 +392,8 @@ static int collect_reflog(const char *ref, const struct object_id *oid, int unus
 
 static struct reflog_expire_cfg {
 	struct reflog_expire_cfg *next;
-	unsigned long expire_total;
-	unsigned long expire_unreachable;
+	time_t expire_total;
+	time_t expire_unreachable;
 	char pattern[FLEX_ARRAY];
 } *reflog_expire_cfg, **reflog_expire_cfg_tail;
 
@@ -415,7 +415,7 @@ static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
 	return ent;
 }
 
-static int parse_expire_cfg_value(const char *var, const char *value, unsigned long *expire)
+static int parse_expire_cfg_value(const char *var, const char *value, time_t *expire)
 {
 	if (!value)
 		return config_error_nonbool(var);
@@ -433,7 +433,7 @@ static int reflog_expire_config(const char *var, const char *value, void *cb)
 {
 	const char *pattern, *key;
 	int pattern_len;
-	unsigned long expire;
+	time_t expire;
 	int slot;
 	struct reflog_expire_cfg *ent;
 
@@ -515,7 +515,7 @@ static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, int slot, c
 static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 {
 	struct expire_reflog_policy_cb cb;
-	unsigned long now = time(NULL);
+	time_t now = time(NULL);
 	int i, status, do_all;
 	int explicit_expiry = 0;
 	unsigned int flags = 0;
@@ -616,7 +616,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 }
 
 static int count_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
+		const char *email, time_t timestamp, int tz,
 		const char *message, void *cb_data)
 {
 	struct expire_reflog_policy_cb *cb = cb_data;
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 974f3403abe..512b5e3db34 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -742,7 +742,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			base = strtoul(reflog_base, &ep, 10);
 			if (*ep) {
 				/* Ah, that is a date spec... */
-				unsigned long at;
+				time_t at;
 				at = approxidate(reflog_base);
 				read_ref_at(ref, flags, at, -1, oid.hash, NULL,
 					    NULL, NULL, &base);
@@ -753,7 +753,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			char *logmsg;
 			char *nth_desc;
 			const char *msg;
-			unsigned long timestamp;
+			time_t timestamp;
 			int tz;
 
 			if (read_ref_at(ref, flags, 0, base+i, oid.hash, &logmsg,
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 3df95e112e5..f12a0e4689c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -30,7 +30,7 @@ struct add_opts {
 
 static int show_only;
 static int verbose;
-static unsigned long expire;
+static time_t expire;
 
 static int prune_worktree(const char *id, struct strbuf *reason)
 {
diff --git a/bundle.c b/bundle.c
index f43bfcf5ff3..75b82e6b653 100644
--- a/bundle.c
+++ b/bundle.c
@@ -211,7 +211,7 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 	unsigned long size;
 	enum object_type type;
 	char *buf = NULL, *line, *lineend;
-	unsigned long date;
+	time_t date;
 	int result = 1;
 
 	if (revs->max_age == -1 && revs->min_age == -1)
diff --git a/cache.h b/cache.h
index 61fc86e6d71..a276d1ea1b0 100644
--- a/cache.h
+++ b/cache.h
@@ -1361,18 +1361,18 @@ struct date_mode {
 #define DATE_MODE(t) date_mode_from_type(DATE_##t)
 struct date_mode *date_mode_from_type(enum date_mode_type type);
 
-const char *show_date(unsigned long time, int timezone, const struct date_mode *mode);
-void show_date_relative(unsigned long time, int tz, const struct timeval *now,
+const char *show_date(time_t time, int timezone, const struct date_mode *mode);
+void show_date_relative(time_t time, int tz, const struct timeval *now,
 			struct strbuf *timebuf);
 int parse_date(const char *date, struct strbuf *out);
-int parse_date_basic(const char *date, unsigned long *timestamp, int *offset);
-int parse_expiry_date(const char *date, unsigned long *timestamp);
+int parse_date_basic(const char *date, time_t *timestamp, int *offset);
+int parse_expiry_date(const char *date, time_t *timestamp);
 void datestamp(struct strbuf *out);
 #define approxidate(s) approxidate_careful((s), NULL)
-unsigned long approxidate_careful(const char *, int *);
-unsigned long approxidate_relative(const char *date, const struct timeval *now);
+time_t approxidate_careful(const char *, int *);
+time_t approxidate_relative(const char *date, const struct timeval *now);
 void parse_date_format(const char *format, struct date_mode *mode);
-int date_overflows(unsigned long date);
+int date_overflows(time_t date);
 
 #define IDENT_STRICT	       1
 #define IDENT_NO_DATE	       2
diff --git a/commit.c b/commit.c
index 7f56b643704..ab379e9d6f4 100644
--- a/commit.c
+++ b/commit.c
@@ -66,7 +66,7 @@ struct commit *lookup_commit_reference_by_name(const char *name)
 	return commit;
 }
 
-static unsigned long parse_commit_date(const char *buf, const char *tail)
+static time_t parse_commit_date(const char *buf, const char *tail)
 {
 	const char *dateptr;
 
@@ -474,8 +474,8 @@ struct commit_list * commit_list_insert_by_date(struct commit *item, struct comm
 
 static int commit_list_compare_by_date(const void *a, const void *b)
 {
-	unsigned long a_date = ((const struct commit_list *)a)->item->date;
-	unsigned long b_date = ((const struct commit_list *)b)->item->date;
+	time_t a_date = ((const struct commit_list *)a)->item->date;
+	time_t b_date = ((const struct commit_list *)b)->item->date;
 	if (a_date < b_date)
 		return 1;
 	if (a_date > b_date)
@@ -599,7 +599,7 @@ static void record_author_date(struct author_date_slab *author_date,
 	const char *ident_line;
 	size_t ident_len;
 	char *date_end;
-	unsigned long date;
+	time_t date;
 
 	ident_line = find_commit_header(buffer, "author", &ident_len);
 	if (!ident_line)
@@ -622,8 +622,8 @@ static int compare_commits_by_author_date(const void *a_, const void *b_,
 {
 	const struct commit *a = a_, *b = b_;
 	struct author_date_slab *author_date = cb_data;
-	unsigned long a_date = *(author_date_slab_at(author_date, a));
-	unsigned long b_date = *(author_date_slab_at(author_date, b));
+	time_t a_date = *(author_date_slab_at(author_date, a));
+	time_t b_date = *(author_date_slab_at(author_date, b));
 
 	/* newer commits with larger date first */
 	if (a_date < b_date)
diff --git a/commit.h b/commit.h
index 9c12abb9111..7b2d3d0b8a8 100644
--- a/commit.h
+++ b/commit.h
@@ -17,7 +17,7 @@ struct commit {
 	struct object object;
 	void *util;
 	unsigned int index;
-	unsigned long date;
+	time_t date;
 	struct commit_list *parents;
 	struct tree *tree;
 };
diff --git a/config.mak.uname b/config.mak.uname
index 447f36ac2e3..ea1a71a936b 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -370,6 +370,7 @@ ifeq ($(uname_S),Windows)
 	NO_INET_PTON = YesPlease
 	NO_INET_NTOP = YesPlease
 	NO_POSIX_GOODIES = UnfortunatelyYes
+	TIME_T_IS_INT64 = YesItIs
 	NATIVE_CRLF = YesPlease
 	DEFAULT_HELP_FORMAT = html
 
@@ -520,6 +521,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_INET_PTON = YesPlease
 	NO_INET_NTOP = YesPlease
 	NO_POSIX_GOODIES = UnfortunatelyYes
+	TIME_T_IS_INT64 = YesItIs
 	DEFAULT_HELP_FORMAT = html
 	COMPAT_CFLAGS += -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index b298ac01e4f..364e5e0c5be 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -8,7 +8,7 @@ static struct tempfile socket_file;
 
 struct credential_cache_entry {
 	struct credential item;
-	unsigned long expiration;
+	time_t expiration;
 };
 static struct credential_cache_entry *entries;
 static int entries_nr;
@@ -47,12 +47,12 @@ static void remove_credential(const struct credential *c)
 		e->expiration = 0;
 }
 
-static int check_expirations(void)
+static time_t check_expirations(void)
 {
-	static unsigned long wait_for_entry_until;
+	static time_t wait_for_entry_until;
 	int i = 0;
-	unsigned long now = time(NULL);
-	unsigned long next = TIME_MAX;
+	time_t now = time(NULL);
+	time_t next = TIME_MAX;
 
 	/*
 	 * Initially give the client 30 seconds to actually contact us
@@ -159,7 +159,7 @@ static void serve_one_client(FILE *in, FILE *out)
 static int serve_cache_loop(int fd)
 {
 	struct pollfd pfd;
-	unsigned long wakeup;
+	time_t wakeup;
 
 	wakeup = check_expirations();
 	if (!wakeup)
diff --git a/date.c b/date.c
index 23dee2964c1..dad2d0c807e 100644
--- a/date.c
+++ b/date.c
@@ -39,7 +39,7 @@ static const char *weekday_names[] = {
 	"Sundays", "Mondays", "Tuesdays", "Wednesdays", "Thursdays", "Fridays", "Saturdays"
 };
 
-static time_t gm_time_t(unsigned long time, int tz)
+static time_t gm_time_t(time_t time, int tz)
 {
 	int minutes;
 
@@ -54,7 +54,7 @@ static time_t gm_time_t(unsigned long time, int tz)
  * thing, which means that tz -0100 is passed in as the integer -100,
  * even though it means "sixty minutes off"
  */
-static struct tm *time_to_tm(unsigned long time, int tz)
+static struct tm *time_to_tm(time_t time, int tz)
 {
 	time_t t = gm_time_t(time, tz);
 	return gmtime(&t);
@@ -64,7 +64,7 @@ static struct tm *time_to_tm(unsigned long time, int tz)
  * What value of "tz" was in effect back then at "time" in the
  * local timezone?
  */
-static int local_tzoffset(unsigned long time)
+static int local_tzoffset(time_t time)
 {
 	time_t t, t_local;
 	struct tm tm;
@@ -88,11 +88,11 @@ static int local_tzoffset(unsigned long time)
 	return offset * eastwest;
 }
 
-void show_date_relative(unsigned long time, int tz,
+void show_date_relative(time_t time, int tz,
 			       const struct timeval *now,
 			       struct strbuf *timebuf)
 {
-	unsigned long diff;
+	time_t diff;
 	if (now->tv_sec < time) {
 		strbuf_addstr(timebuf, _("in the future"));
 		return;
@@ -140,9 +140,9 @@ void show_date_relative(unsigned long time, int tz,
 	}
 	/* Give years and months for 5 years or so */
 	if (diff < 1825) {
-		unsigned long totalmonths = (diff * 12 * 2 + 365) / (365 * 2);
-		unsigned long years = totalmonths / 12;
-		unsigned long months = totalmonths % 12;
+		time_t totalmonths = (diff * 12 * 2 + 365) / (365 * 2);
+		time_t years = totalmonths / 12;
+		time_t months = totalmonths % 12;
 		if (months) {
 			struct strbuf sb = STRBUF_INIT;
 			strbuf_addf(&sb, Q_("%"PRItime" year", "%"PRItime" years", years), years);
@@ -172,7 +172,7 @@ struct date_mode *date_mode_from_type(enum date_mode_type type)
 	return &mode;
 }
 
-const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
+const char *show_date(time_t time, int tz, const struct date_mode *mode)
 {
 	struct tm *tm;
 	static struct strbuf timebuf = STRBUF_INIT;
@@ -425,7 +425,7 @@ static int is_date(int year, int month, int day, struct tm *now_tm, time_t now,
 	return 0;
 }
 
-static int match_multi_number(unsigned long num, char c, const char *date,
+static int match_multi_number(time_t num, char c, const char *date,
 			      char *end, struct tm *tm, time_t now)
 {
 	struct tm now_tm;
@@ -508,7 +508,7 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
 {
 	int n;
 	char *end;
-	unsigned long num;
+	time_t num;
 
 	num = parse_timestamp(date, &end, 10);
 
@@ -635,7 +635,7 @@ static int match_tz(const char *date, int *offp)
 	return end - date;
 }
 
-static void date_string(unsigned long date, int offset, struct strbuf *buf)
+static void date_string(time_t date, int offset, struct strbuf *buf)
 {
 	int sign = '+';
 
@@ -650,10 +650,10 @@ static void date_string(unsigned long date, int offset, struct strbuf *buf)
  * Parse a string like "0 +0000" as ancient timestamp near epoch, but
  * only when it appears not as part of any other string.
  */
-static int match_object_header_date(const char *date, unsigned long *timestamp, int *offset)
+static int match_object_header_date(const char *date, time_t *timestamp, int *offset)
 {
 	char *end;
-	unsigned long stamp;
+	time_t stamp;
 	int ofs;
 
 	if (*date < '0' || '9' < *date)
@@ -675,11 +675,11 @@ static int match_object_header_date(const char *date, unsigned long *timestamp,
 
 /* Gr. strptime is crap for this; it doesn't have a way to require RFC2822
    (i.e. English) day/month names, and it doesn't work correctly with %z. */
-int parse_date_basic(const char *date, unsigned long *timestamp, int *offset)
+int parse_date_basic(const char *date, time_t *timestamp, int *offset)
 {
 	struct tm tm;
 	int tm_gmt;
-	unsigned long dummy_timestamp;
+	time_t dummy_timestamp;
 	int dummy_offset;
 
 	if (!timestamp)
@@ -747,7 +747,7 @@ int parse_date_basic(const char *date, unsigned long *timestamp, int *offset)
 	return 0; /* success */
 }
 
-int parse_expiry_date(const char *date, unsigned long *timestamp)
+int parse_expiry_date(const char *date, time_t *timestamp)
 {
 	int errors = 0;
 
@@ -771,7 +771,7 @@ int parse_expiry_date(const char *date, unsigned long *timestamp)
 
 int parse_date(const char *date, struct strbuf *result)
 {
-	unsigned long timestamp;
+	time_t timestamp;
 	int offset;
 	if (parse_date_basic(date, &timestamp, &offset))
 		return -1;
@@ -845,7 +845,7 @@ void datestamp(struct strbuf *out)
  * Relative time update (eg "2 days ago").  If we haven't set the time
  * yet, we need to set it from current time.
  */
-static unsigned long update_tm(struct tm *tm, struct tm *now, unsigned long sec)
+static time_t update_tm(struct tm *tm, struct tm *now, time_t sec)
 {
 	time_t n;
 
@@ -1114,7 +1114,7 @@ static void pending_number(struct tm *tm, int *num)
 	}
 }
 
-static unsigned long approxidate_str(const char *date,
+static time_t approxidate_str(const char *date,
 				     const struct timeval *tv,
 				     int *error_ret)
 {
@@ -1151,9 +1151,9 @@ static unsigned long approxidate_str(const char *date,
 	return update_tm(&tm, &now, 0);
 }
 
-unsigned long approxidate_relative(const char *date, const struct timeval *tv)
+time_t approxidate_relative(const char *date, const struct timeval *tv)
 {
-	unsigned long timestamp;
+	time_t timestamp;
 	int offset;
 	int errors = 0;
 
@@ -1162,10 +1162,10 @@ unsigned long approxidate_relative(const char *date, const struct timeval *tv)
 	return approxidate_str(date, tv, &errors);
 }
 
-unsigned long approxidate_careful(const char *date, int *error_ret)
+time_t approxidate_careful(const char *date, int *error_ret)
 {
 	struct timeval tv;
-	unsigned long timestamp;
+	time_t timestamp;
 	int offset;
 	int dummy = 0;
 	if (!error_ret)
@@ -1180,7 +1180,7 @@ unsigned long approxidate_careful(const char *date, int *error_ret)
 	return approxidate_str(date, &tv, error_ret);
 }
 
-int date_overflows(unsigned long t)
+int date_overflows(time_t t)
 {
 	time_t sys;
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 54fb35e39c5..d3401733b05 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -356,7 +356,7 @@ static int find_common(struct fetch_pack_args *args,
 	if (args->depth > 0)
 		packet_buf_write(&req_buf, "deepen %d", args->depth);
 	if (args->deepen_since) {
-		unsigned long max_age = approxidate(args->deepen_since);
+		time_t max_age = approxidate(args->deepen_since);
 		packet_buf_write(&req_buf, "deepen-since %"PRItime, max_age);
 	}
 	if (args->deepen_not) {
@@ -545,7 +545,7 @@ static int mark_complete_oid(const char *refname, const struct object_id *oid,
 }
 
 static void mark_recent_complete_commits(struct fetch_pack_args *args,
-					 unsigned long cutoff)
+					 time_t cutoff)
 {
 	while (complete && cutoff <= complete->item->date) {
 		print_verbose(args, _("Marking %s as complete"),
@@ -630,7 +630,7 @@ static int everything_local(struct fetch_pack_args *args,
 {
 	struct ref *ref;
 	int retval;
-	unsigned long cutoff = 0;
+	time_t cutoff = 0;
 
 	save_commit_buffer = 0;
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 5cf1133532d..027f3b2f8eb 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -326,7 +326,7 @@ extern char *gitdirname(char *);
 #else
 #define PRItime "lu"
 #define parse_timestamp strtoul
-#define TIME_MAX ULONG_MAX
+#define TIME_MAX LONG_MAX
 #endif
 
 #ifndef PATH_SEP
diff --git a/http-backend.c b/http-backend.c
index eef0a361f4f..4e88735a9e3 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -90,7 +90,7 @@ static void hdr_int(struct strbuf *hdr, const char *name, uintmax_t value)
 	strbuf_addf(hdr, "%s: %" PRIuMAX "\r\n", name, value);
 }
 
-static void hdr_date(struct strbuf *hdr, const char *name, unsigned long when)
+static void hdr_date(struct strbuf *hdr, const char *name, time_t when)
 {
 	const char *value = show_date(when, 0, DATE_MODE(RFC2822));
 	hdr_str(hdr, name, value);
@@ -105,7 +105,7 @@ static void hdr_nocache(struct strbuf *hdr)
 
 static void hdr_cache_forever(struct strbuf *hdr)
 {
-	unsigned long now = time(NULL);
+	time_t now = time(NULL);
 	hdr_date(hdr, "Date", now);
 	hdr_date(hdr, "Expires", now + 31536000);
 	hdr_str(hdr, "Cache-Control", "public, max-age=31536000");
diff --git a/parse-options-cb.c b/parse-options-cb.c
index b7d8f7dcb2c..a560d8d0b8c 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -31,14 +31,14 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
 int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
 			     int unset)
 {
-	*(unsigned long *)(opt->value) = approxidate(arg);
+	*(time_t *)(opt->value) = approxidate(arg);
 	return 0;
 }
 
 int parse_opt_expiry_date_cb(const struct option *opt, const char *arg,
 			     int unset)
 {
-	return parse_expiry_date(arg, (unsigned long *)opt->value);
+	return parse_expiry_date(arg, (time_t *)opt->value);
 }
 
 int parse_opt_color_flag_cb(const struct option *opt, const char *arg,
diff --git a/pretty.c b/pretty.c
index 6d1e1e87e7d..ab689009536 100644
--- a/pretty.c
+++ b/pretty.c
@@ -405,7 +405,7 @@ static void add_rfc2047(struct strbuf *sb, const char *line, size_t len,
 const char *show_ident_date(const struct ident_split *ident,
 			    const struct date_mode *mode)
 {
-	unsigned long date = 0;
+	time_t date = 0;
 	long tz = 0;
 
 	if (ident->date_begin && ident->date_end)
diff --git a/reachable.c b/reachable.c
index d0199cace4a..f4d2be6beb7 100644
--- a/reachable.c
+++ b/reachable.c
@@ -55,12 +55,11 @@ static void mark_commit(struct commit *c, void *data)
 
 struct recent_data {
 	struct rev_info *revs;
-	unsigned long timestamp;
+	time_t timestamp;
 };
 
 static void add_recent_object(const unsigned char *sha1,
-			      unsigned long mtime,
-			      struct recent_data *data)
+			      time_t mtime, struct recent_data *data)
 {
 	struct object *obj;
 	enum object_type type;
@@ -139,7 +138,7 @@ static int add_recent_packed(const unsigned char *sha1,
 }
 
 int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
-					   unsigned long timestamp)
+					   time_t timestamp)
 {
 	struct recent_data data;
 	int r;
@@ -156,8 +155,7 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 }
 
 void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
-			    unsigned long mark_recent,
-			    struct progress *progress)
+			    time_t mark_recent, struct progress *progress)
 {
 	struct connectivity_progress cp;
 
diff --git a/reachable.h b/reachable.h
index d23efc36ec5..2a7f6588941 100644
--- a/reachable.h
+++ b/reachable.h
@@ -3,8 +3,8 @@
 
 struct progress;
 extern int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
-						  unsigned long timestamp);
+						  time_t timestamp);
 extern void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
-				   unsigned long mark_recent, struct progress *);
+				   time_t mark_recent, struct progress *);
 
 #endif
diff --git a/ref-filter.c b/ref-filter.c
index b8b34d4dd9e..265b7c03845 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -618,7 +618,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 {
 	const char *eoemail = strstr(buf, "> ");
 	char *zone;
-	unsigned long timestamp;
+	time_t timestamp;
 	long tz;
 	struct date_mode date_mode = { DATE_NORMAL };
 	const char *formatp;
diff --git a/reflog-walk.c b/reflog-walk.c
index a246af27678..d1a8673c348 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -12,7 +12,7 @@ struct complete_reflogs {
 	struct reflog_info {
 		unsigned char osha1[20], nsha1[20];
 		char *email;
-		unsigned long timestamp;
+		time_t timestamp;
 		int tz;
 		char *message;
 	} *items;
@@ -20,7 +20,7 @@ struct complete_reflogs {
 };
 
 static int read_one_reflog(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
+		const char *email, time_t timestamp, int tz,
 		const char *message, void *cb_data)
 {
 	struct complete_reflogs *array = cb_data;
@@ -69,7 +69,7 @@ static struct complete_reflogs *read_complete_reflog(const char *ref)
 }
 
 static int get_reflog_recno_by_time(struct complete_reflogs *array,
-	unsigned long timestamp)
+	time_t timestamp)
 {
 	int i;
 	for (i = array->nr - 1; i >= 0; i--)
@@ -141,7 +141,7 @@ void init_reflog_walk(struct reflog_walk_info **info)
 int add_reflog_for_walk(struct reflog_walk_info *info,
 		struct commit *commit, const char *name)
 {
-	unsigned long timestamp = 0;
+	time_t timestamp = 0;
 	int recno = -1;
 	struct string_list_item *item;
 	struct complete_reflogs *reflogs;
diff --git a/refs.c b/refs.c
index cd36b64ed93..546e9080555 100644
--- a/refs.c
+++ b/refs.c
@@ -658,7 +658,7 @@ int is_branch(const char *refname)
 
 struct read_ref_at_cb {
 	const char *refname;
-	unsigned long at_time;
+	time_t at_time;
 	int cnt;
 	int reccnt;
 	unsigned char *sha1;
@@ -667,15 +667,15 @@ struct read_ref_at_cb {
 	unsigned char osha1[20];
 	unsigned char nsha1[20];
 	int tz;
-	unsigned long date;
+	time_t date;
 	char **msg;
-	unsigned long *cutoff_time;
+	time_t *cutoff_time;
 	int *cutoff_tz;
 	int *cutoff_cnt;
 };
 
 static int read_ref_at_ent(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
+		const char *email, time_t timestamp, int tz,
 		const char *message, void *cb_data)
 {
 	struct read_ref_at_cb *cb = cb_data;
@@ -722,7 +722,7 @@ static int read_ref_at_ent(unsigned char *osha1, unsigned char *nsha1,
 }
 
 static int read_ref_at_ent_oldest(unsigned char *osha1, unsigned char *nsha1,
-				  const char *email, unsigned long timestamp,
+				  const char *email, time_t timestamp,
 				  int tz, const char *message, void *cb_data)
 {
 	struct read_ref_at_cb *cb = cb_data;
@@ -742,9 +742,9 @@ static int read_ref_at_ent_oldest(unsigned char *osha1, unsigned char *nsha1,
 	return 1;
 }
 
-int read_ref_at(const char *refname, unsigned int flags, unsigned long at_time, int cnt,
+int read_ref_at(const char *refname, unsigned int flags, time_t at_time, int cnt,
 		unsigned char *sha1, char **msg,
-		unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
+		time_t *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
 {
 	struct read_ref_at_cb cb;
 
diff --git a/refs.h b/refs.h
index 9fbff90e79b..1748827a7ba 100644
--- a/refs.h
+++ b/refs.h
@@ -262,9 +262,9 @@ int safe_create_reflog(const char *refname, int force_create, struct strbuf *err
 
 /** Reads log for the value of ref during at_time. **/
 int read_ref_at(const char *refname, unsigned int flags,
-		unsigned long at_time, int cnt,
+		time_t at_time, int cnt,
 		unsigned char *sha1, char **msg,
-		unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
+		time_t *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
 
 /** Check if a particular reflog exists */
 int reflog_exists(const char *refname);
@@ -293,7 +293,7 @@ int delete_reflog(const char *refname);
 /* iterate over reflog entries */
 typedef int each_reflog_ent_fn(
 		unsigned char *old_sha1, unsigned char *new_sha1,
-		const char *committer, unsigned long timestamp,
+		const char *committer, time_t timestamp,
 		int tz, const char *msg, void *cb_data);
 
 int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
@@ -536,7 +536,7 @@ typedef void reflog_expiry_prepare_fn(const char *refname,
 typedef int reflog_expiry_should_prune_fn(unsigned char *osha1,
 					  unsigned char *nsha1,
 					  const char *email,
-					  unsigned long timestamp, int tz,
+					  time_t timestamp, int tz,
 					  const char *message, void *cb_data);
 typedef void reflog_expiry_cleanup_fn(void *cb_data);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index c041d4ba21a..4316de3a692 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3115,7 +3115,7 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
 {
 	unsigned char osha1[20], nsha1[20];
 	char *email_end, *message;
-	unsigned long timestamp;
+	time_t timestamp;
 	int tz;
 
 	/* old SP new SP name <email> SP time TAB msg LF */
@@ -3940,7 +3940,7 @@ struct expire_reflog_cb {
 };
 
 static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-			     const char *email, unsigned long timestamp, int tz,
+			     const char *email, time_t timestamp, int tz,
 			     const char *message, void *cb_data)
 {
 	struct expire_reflog_cb *cb = cb_data;
diff --git a/revision.c b/revision.c
index b37dbec378f..419d5fa954e 100644
--- a/revision.c
+++ b/revision.c
@@ -884,7 +884,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 /* How many extra uninteresting commits we want to see.. */
 #define SLOP 5
 
-static int still_interesting(struct commit_list *src, unsigned long date, int slop,
+static int still_interesting(struct commit_list *src, time_t date, int slop,
 			     struct commit **interesting_cache)
 {
 	/*
@@ -1018,7 +1018,7 @@ static void limit_left_right(struct commit_list *list, struct rev_info *revs)
 static int limit_list(struct rev_info *revs)
 {
 	int slop = SLOP;
-	unsigned long date = ~0ul;
+	time_t date = ~0ul;
 	struct commit_list *list = revs->commits;
 	struct commit_list *newlist = NULL;
 	struct commit_list **p = &newlist;
@@ -1215,7 +1215,7 @@ static void handle_one_reflog_commit(unsigned char *sha1, void *cb_data)
 }
 
 static int handle_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
+		const char *email, time_t timestamp, int tz,
 		const char *message, void *cb_data)
 {
 	handle_one_reflog_commit(osha1, cb_data);
diff --git a/revision.h b/revision.h
index 9fac1a607de..e39e5b524bb 100644
--- a/revision.h
+++ b/revision.h
@@ -181,8 +181,8 @@ struct rev_info {
 	/* special limits */
 	int skip_count;
 	int max_count;
-	unsigned long max_age;
-	unsigned long min_age;
+	time_t max_age;
+	time_t min_age;
 	int min_parents;
 	int max_parents;
 	int (*include_check)(struct commit *, void *);
diff --git a/sha1_name.c b/sha1_name.c
index 73a915ff1b3..9520586139e 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -658,8 +658,8 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
 
 	if (reflog_len) {
 		int nth, i;
-		unsigned long at_time;
-		unsigned long co_time;
+		time_t at_time;
+		time_t co_time;
 		int co_tz, co_cnt;
 
 		/* Is it asking for N-th entry, or approxidate? */
@@ -1052,7 +1052,7 @@ struct grab_nth_branch_switch_cbdata {
 };
 
 static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
-				  const char *email, unsigned long timestamp, int tz,
+				  const char *email, time_t timestamp, int tz,
 				  const char *message, void *cb_data)
 {
 	struct grab_nth_branch_switch_cbdata *cb = cb_data;
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index ba309ec1760..371f9d259c6 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -47,7 +47,7 @@ static void parse_dates(const char **argv, struct timeval *now)
 	struct strbuf result = STRBUF_INIT;
 
 	for (; *argv; argv++) {
-		unsigned long t;
+		time_t t;
 		int tz;
 
 		strbuf_reset(&result);
@@ -95,7 +95,7 @@ int cmd_main(int argc, const char **argv)
 	else if (!strcmp(*argv, "approxidate"))
 		parse_approxidate(argv+1, &now);
 	else if (!strcmp(*argv, "is64bit"))
-		return sizeof(unsigned long) == 8 ? 0 : 1;
+		return sizeof(time_t) == 8 ? 0 : 1;
 	else
 		usage(usage_msg);
 	return 0;
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 7d93627e454..8af62dd7501 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -5,7 +5,7 @@
 static int boolean = 0;
 static int integer = 0;
 static unsigned long magnitude = 0;
-static unsigned long timestamp;
+static time_t timestamp;
 static int abbrev = 7;
 static int verbose = -1; /* unspecified */
 static int dry_run = 0, quiet = 0;
diff --git a/tag.c b/tag.c
index 55d07725777..a0b22c788b6 100644
--- a/tag.c
+++ b/tag.c
@@ -97,7 +97,7 @@ struct tag *lookup_tag(const unsigned char *sha1)
 	return object_as_type(obj, OBJ_TAG, 0);
 }
 
-static unsigned long parse_tag_date(const char *buf, const char *tail)
+static time_t parse_tag_date(const char *buf, const char *tail)
 {
 	const char *dateptr;
 
diff --git a/tag.h b/tag.h
index a5721b6731e..aaf56849de8 100644
--- a/tag.h
+++ b/tag.h
@@ -9,7 +9,7 @@ struct tag {
 	struct object object;
 	struct object *tagged;
 	char *tag;
-	unsigned long date;
+	time_t date;
 };
 
 extern struct tag *lookup_tag(const unsigned char *sha1);
diff --git a/upload-pack.c b/upload-pack.c
index c2be661f6d4..4dcc6aa8d95 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -35,7 +35,7 @@ static const char * const upload_pack_usage[] = {
 #define CLIENT_SHALLOW	(1u << 18)
 #define HIDDEN_REF	(1u << 19)
 
-static unsigned long oldest_have;
+static time_t oldest_have;
 
 static int deepen_relative;
 static int multi_ack;
@@ -735,7 +735,7 @@ static void receive_needs(void)
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
 	int depth = 0;
 	int has_non_tip = 0;
-	unsigned long deepen_since = 0;
+	time_t deepen_since = 0;
 	int deepen_rev_list = 0;
 
 	shallow_nr = 0;
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 6c9f2866d8b..5df87ce6bb4 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -68,7 +68,7 @@ void fast_export_modify(const char *path, uint32_t mode, const char *dataref)
 }
 
 void fast_export_begin_note(uint32_t revision, const char *author,
-		const char *log, unsigned long timestamp, const char *note_ref)
+		const char *log, time_t timestamp, const char *note_ref)
 {
 	static int firstnote = 1;
 	size_t loglen = strlen(log);
@@ -93,7 +93,7 @@ static char gitsvnline[MAX_GITSVN_LINE_LEN];
 void fast_export_begin_commit(uint32_t revision, const char *author,
 			const struct strbuf *log,
 			const char *uuid, const char *url,
-			unsigned long timestamp, const char *local_ref)
+			time_t timestamp, const char *local_ref)
 {
 	static const struct strbuf empty = STRBUF_INIT;
 	if (!log)
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index c8b5adb811c..864dada2b31 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -11,10 +11,10 @@ void fast_export_delete(const char *path);
 void fast_export_modify(const char *path, uint32_t mode, const char *dataref);
 void fast_export_note(const char *committish, const char *dataref);
 void fast_export_begin_note(uint32_t revision, const char *author,
-		const char *log, unsigned long timestamp, const char *note_ref);
+		const char *log, time_t timestamp, const char *note_ref);
 void fast_export_begin_commit(uint32_t revision, const char *author,
 			const struct strbuf *log, const char *uuid,const char *url,
-			unsigned long timestamp, const char *local_ref);
+			time_t timestamp, const char *local_ref);
 void fast_export_end_commit(uint32_t revision);
 void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input);
 void fast_export_buf_to_data(const struct strbuf *data);
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index e4b395963b9..9e1eb8d4176 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -47,7 +47,7 @@ static struct {
 
 static struct {
 	uint32_t revision;
-	unsigned long timestamp;
+	time_t timestamp;
 	struct strbuf log, author, note;
 } rev_ctx;
 
diff --git a/wt-status.c b/wt-status.c
index d47012048f8..da261363551 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1374,7 +1374,7 @@ struct grab_1st_switch_cbdata {
 };
 
 static int grab_1st_switch(unsigned char *osha1, unsigned char *nsha1,
-			   const char *email, unsigned long timestamp, int tz,
+			   const char *email, time_t timestamp, int tz,
 			   const char *message, void *cb_data)
 {
 	struct grab_1st_switch_cbdata *cb = cb_data;
-- 
2.11.1.windows.1.379.g44ae0bc
