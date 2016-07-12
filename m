Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1F952018E
	for <e@80x24.org>; Tue, 12 Jul 2016 07:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbcGLHar (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 03:30:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:56749 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816AbcGLHap (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 03:30:45 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LsChr-1bFxBg0vOx-013tOl; Tue, 12 Jul 2016 09:30:31
 +0200
Date:	Tue, 12 Jul 2016 09:30:28 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Jeff King <peff@peff.net>, Andreas Schwab <schwab@linux-m68k.org>,
	git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
In-Reply-To: <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607120927410.6426@virtualbox>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com> <87lh17kgdy.fsf@linux-m68k.org> <20160711235417.GA26163@sigill.intra.peff.net> <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cgSHwb8FTLAmL+V3mPLCSbvWofXK8PVnwH84jYeTql424FqQnCl
 gDrYEZHnfzX543Hva3Dz/4SsytA729+dNI6tuLR/kszEixgn4uMqxqQ73GLLcjusLCC3xV6
 bLJtczYxcl0QNKjGkQKUrWAw+3OdxLhGSzUxXrC8E8GLPkRj+8bF+MvHYk0X70+th6p2UmU
 VkPMqOpS4Ui89621PD0lA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:7XEShsYC8jw=:n1JOwQU9uZymQQwxDqedrj
 YkPkUSHZHqL8W4ssIC+hUdNK3g8/W08STbK7cq6xLU2YpOdjFXCywEwWwVkcZzolxq6kBSXrb
 U4qjwdpmJl4+d6liNk9Kf2ZHpuZZEbRIK/3PiGI7Kww/cAYLApvtyRHcRtV4qEiiwiDMSj4ND
 ayF/sBnS4kBTKgyfzgenc9mnQbhfqM6CeLR/bipnZOAiVrSwBscYXSLyq7edftlRJBXWf6g9y
 rP3acOQNERozF86RMNIN5MkVpKC/Ykt+zSh8qaMtYNZQ5ZRYmnA6IKdV7RG6veOL1freDqead
 gNVoGDOgBmouqLTVdAJZuif7+A4Y4DvTtivFlZ2wQksSPltn8hivGWeKiB4Ymc7nxu+kLsi9Q
 eogJpZSEzIocxgyM4N4lnlz3S3VaCS0zRjts6qN59P6QxwZzLs+QHL2oT0Za2ZaQy1L+F1xH3
 chdEjeontLwwQK+aRov+7WFxMwTFyVz6gFRdk5mWfzVsoOFGzT9XCbepd0HOGGA4wNmX22c5L
 If+lKasf092hZOJyh56KcN8VlwLij00UE6ZiyWNzh1izdMbnwL/aBXApqawzr/z1E4q4hC49p
 yjFGGxE/E8y/XWunVs9IGxnMTyRDXGTfphqm1qlLF9YKcnVErIWd8nWRGax8/6IXenr03mqal
 d25vu+wcHs+UjJL4QTDjrVvxXeRP7AmiLzn8UkiOV1M7pgDnUkTBuFPKhHy0Sl1MTxChUX59g
 v0VfYwYsRKwOS2B4Nll/Ft6qkhe4gZLOSgbRBnZPYQV+56tCUdIGUuubb3V38MFmom+kRA0in
 4/Bwldz
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio & Peff,

On Mon, 11 Jul 2016, Junio C Hamano wrote:

> Those who care about 32-bit builds need to start building and
> testing 'next' and 'master' regularly, or similar breakages are
> bound to continue happening X-<.

Please note that "unsigned long" is 32-bit even on 64-bit Windows.

FWIW I have this monster patch as a starting point (I plan to work more on
this today):

-- snipsnap --
From b65de5a56e18b038d432ba828d7714880b8e285c Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Tue, 12 Jul 2016 09:09:07 +0200
Subject: [PATCH] HOTFIX: use time_t wherever appropriate

Git's source code assumes that unsigned long is at least as precise as
time_t. Well, Git's source code is wrong.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/api-parse-options.txt |  4 +-
 builtin/fsck.c                                |  2 +-
 builtin/merge-base.c                          |  2 +-
 builtin/prune.c                               |  2 +-
 builtin/reflog.c                              | 24 +++----
 builtin/show-branch.c                         |  4 +-
 builtin/worktree.c                            |  2 +-
 cache.h                                       | 14 ++---
 date.c                                        | 90 +++++++++++++++------------
 parse-options-cb.c                            |  4 +-
 reflog-walk.c                                 |  8 +--
 refs.c                                        | 14 ++---
 refs.h                                        |  8 +--
 refs/files-backend.c                          |  4 +-
 revision.c                                    |  6 +-
 sha1_name.c                                   |  6 +-
 t/helper/test-date.c                          |  2 +-
 t/helper/test-parse-options.c                 |  4 +-
 vcs-svn/svndump.c                             |  2 +-
 wt-status.c                                   |  2 +-
 20 files changed, 106 insertions(+), 98 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 27bd701..6801aad 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -178,11 +178,11 @@ There are some macros to easily define options:
 	scale the provided value by 1024, 1024^2 or 1024^3 respectively.
 	The scaled value is put into `unsigned_long_var`.
 
-`OPT_DATE(short, long, &int_var, description)`::
+`OPT_DATE(short, long, &time_t_var, description)`::
 	Introduce an option with date argument, see `approxidate()`.
 	The timestamp is put into `int_var`.
 
-`OPT_EXPIRY_DATE(short, long, &int_var, description)`::
+`OPT_EXPIRY_DATE(short, long, &time_t_var, description)`::
 	Introduce an option with expiry date argument, see `parse_expiry_date()`.
 	The timestamp is put into `int_var`.
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 3f27456..3dfa32b 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -385,7 +385,7 @@ static void fsck_handle_reflog_sha1(const char *refname, unsigned char *sha1)
 }
 
 static int fsck_handle_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
+		const char *email, time_t timestamp, int tz,
 		const char *message, void *cb_data)
 {
 	const char *refname = cb_data;
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index c0d1822..85ba332 100644
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
diff --git a/builtin/prune.c b/builtin/prune.c
index 8f4f052..5219504 100644
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
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 7a7136e..331c874 100644
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
index 2566935..56dd9d2 100644
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
index 96a2834..d81857e 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -28,7 +28,7 @@ struct add_opts {
 
 static int show_only;
 static int verbose;
-static unsigned long expire;
+static time_t expire;
 
 static int prune_worktree(const char *id, struct strbuf *reason)
 {
diff --git a/cache.h b/cache.h
index 1537c00..b972659 100644
--- a/cache.h
+++ b/cache.h
@@ -1241,18 +1241,18 @@ struct date_mode {
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
diff --git a/date.c b/date.c
index 4c7aa9b..7584a78 100644
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
@@ -100,65 +100,65 @@ void show_date_relative(unsigned long time, int tz,
 	diff = now->tv_sec - time;
 	if (diff < 90) {
 		strbuf_addf(timebuf,
-			 Q_("%lu second ago", "%lu seconds ago", diff), diff);
+			 Q_("%" PRIuMAX " second ago", "%" PRIuMAX " seconds ago", diff), diff);
 		return;
 	}
 	/* Turn it into minutes */
 	diff = (diff + 30) / 60;
 	if (diff < 90) {
 		strbuf_addf(timebuf,
-			 Q_("%lu minute ago", "%lu minutes ago", diff), diff);
+			 Q_("%" PRIuMAX " minute ago", "%" PRIuMAX " minutes ago", diff), diff);
 		return;
 	}
 	/* Turn it into hours */
 	diff = (diff + 30) / 60;
 	if (diff < 36) {
 		strbuf_addf(timebuf,
-			 Q_("%lu hour ago", "%lu hours ago", diff), diff);
+			 Q_("%" PRIuMAX " hour ago", "%" PRIuMAX " hours ago", diff), diff);
 		return;
 	}
 	/* We deal with number of days from here on */
 	diff = (diff + 12) / 24;
 	if (diff < 14) {
 		strbuf_addf(timebuf,
-			 Q_("%lu day ago", "%lu days ago", diff), diff);
+			 Q_("%" PRIuMAX " day ago", "%" PRIuMAX " days ago", diff), diff);
 		return;
 	}
 	/* Say weeks for the past 10 weeks or so */
 	if (diff < 70) {
 		strbuf_addf(timebuf,
-			 Q_("%lu week ago", "%lu weeks ago", (diff + 3) / 7),
+			 Q_("%" PRIuMAX " week ago", "%" PRIuMAX " weeks ago", (diff + 3) / 7),
 			 (diff + 3) / 7);
 		return;
 	}
 	/* Say months for the past 12 months or so */
 	if (diff < 365) {
 		strbuf_addf(timebuf,
-			 Q_("%lu month ago", "%lu months ago", (diff + 15) / 30),
+			 Q_("%" PRIuMAX " month ago", "%" PRIuMAX " months ago", (diff + 15) / 30),
 			 (diff + 15) / 30);
 		return;
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
-			strbuf_addf(&sb, Q_("%lu year", "%lu years", years), years);
+			strbuf_addf(&sb, Q_("%" PRIuMAX " year", "%" PRIuMAX " years", years), years);
 			strbuf_addf(timebuf,
 				 /* TRANSLATORS: "%s" is "<n> years" */
-				 Q_("%s, %lu month ago", "%s, %lu months ago", months),
+				 Q_("%s, %" PRIuMAX " month ago", "%s, %" PRIuMAX " months ago", months),
 				 sb.buf, months);
 			strbuf_release(&sb);
 		} else
 			strbuf_addf(timebuf,
-				 Q_("%lu year ago", "%lu years ago", years), years);
+				 Q_("%" PRIuMAX " year ago", "%" PRIuMAX " years ago", years), years);
 		return;
 	}
 	/* Otherwise, just years. Centuries is probably overkill. */
 	strbuf_addf(timebuf,
-		 Q_("%lu year ago", "%lu years ago", (diff + 183) / 365),
+		 Q_("%" PRIuMAX " year ago", "%" PRIuMAX " years ago", (diff + 183) / 365),
 		 (diff + 183) / 365);
 }
 
@@ -172,7 +172,7 @@ struct date_mode *date_mode_from_type(enum date_mode_type type)
 	return &mode;
 }
 
-const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
+const char *show_date(time_t time, int tz, const struct date_mode *mode)
 {
 	struct tm *tm;
 	static struct strbuf timebuf = STRBUF_INIT;
@@ -182,7 +182,7 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
 
 	if (mode->type == DATE_RAW) {
 		strbuf_reset(&timebuf);
-		strbuf_addf(&timebuf, "%lu %+05d", time, tz);
+		strbuf_addf(&timebuf, "%" PRIuMAX " %+05d", time, tz);
 		return timebuf.buf;
 	}
 
@@ -419,7 +419,7 @@ static int is_date(int year, int month, int day, struct tm *now_tm, time_t now,
 	return 0;
 }
 
-static int match_multi_number(unsigned long num, char c, const char *date,
+static int match_multi_number(time_t num, char c, const char *date,
 			      char *end, struct tm *tm, time_t now)
 {
 	struct tm now_tm;
@@ -495,6 +495,12 @@ static inline int nodate(struct tm *tm)
 		tm->tm_sec) < 0;
 }
 
+#if 0 /* sizeof(time_t) <= sizeof(unsigned long) */
+#define parse_time_t strtoul
+#else
+#define parse_time_t strtoull
+#endif
+
 /*
  * We've seen a digit. Time? Year? Date?
  */
@@ -502,9 +508,9 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
 {
 	int n;
 	char *end;
-	unsigned long num;
+	time_t num;
 
-	num = strtoul(date, &end, 10);
+	num = parse_time_t(date, &end, 10);
 
 	/*
 	 * Seconds since 1970? We trigger on that for any numbers with
@@ -629,7 +635,7 @@ static int match_tz(const char *date, int *offp)
 	return end - date;
 }
 
-static void date_string(unsigned long date, int offset, struct strbuf *buf)
+static void date_string(time_t date, int offset, struct strbuf *buf)
 {
 	int sign = '+';
 
@@ -637,22 +643,22 @@ static void date_string(unsigned long date, int offset, struct strbuf *buf)
 		offset = -offset;
 		sign = '-';
 	}
-	strbuf_addf(buf, "%lu %c%02d%02d", date, sign, offset / 60, offset % 60);
+	strbuf_addf(buf, "%" PRIuMAX " %c%02d%02d", date, sign, offset / 60, offset % 60);
 }
 
 /*
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
 		return -1;
-	stamp = strtoul(date, &end, 10);
+	stamp = parse_time_t(date, &end, 10);
 	if (*end != ' ' || stamp == ULONG_MAX || (end[1] != '+' && end[1] != '-'))
 		return -1;
 	date = end + 2;
@@ -669,11 +675,11 @@ static int match_object_header_date(const char *date, unsigned long *timestamp,
 
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
@@ -741,7 +747,7 @@ int parse_date_basic(const char *date, unsigned long *timestamp, int *offset)
 	return 0; /* success */
 }
 
-int parse_expiry_date(const char *date, unsigned long *timestamp)
+int parse_expiry_date(const char *date, time_t *timestamp)
 {
 	int errors = 0;
 
@@ -765,7 +771,7 @@ int parse_expiry_date(const char *date, unsigned long *timestamp)
 
 int parse_date(const char *date, struct strbuf *result)
 {
-	unsigned long timestamp;
+	time_t timestamp;
 	int offset;
 	if (parse_date_basic(date, &timestamp, &offset))
 		return -1;
@@ -837,7 +843,7 @@ void datestamp(struct strbuf *out)
  * Relative time update (eg "2 days ago").  If we haven't set the time
  * yet, we need to set it from current time.
  */
-static unsigned long update_tm(struct tm *tm, struct tm *now, unsigned long sec)
+static time_t update_tm(struct tm *tm, struct tm *now, time_t sec)
 {
 	time_t n;
 
@@ -1058,7 +1064,7 @@ static const char *approxidate_digit(const char *date, struct tm *tm, int *num,
 				     time_t now)
 {
 	char *end;
-	unsigned long number = strtoul(date, &end, 10);
+	time_t number = parse_time_t(date, &end, 10);
 
 	switch (*end) {
 	case ':':
@@ -1106,7 +1112,7 @@ static void pending_number(struct tm *tm, int *num)
 	}
 }
 
-static unsigned long approxidate_str(const char *date,
+static time_t approxidate_str(const char *date,
 				     const struct timeval *tv,
 				     int *error_ret)
 {
@@ -1143,9 +1149,9 @@ static unsigned long approxidate_str(const char *date,
 	return update_tm(&tm, &now, 0);
 }
 
-unsigned long approxidate_relative(const char *date, const struct timeval *tv)
+time_t approxidate_relative(const char *date, const struct timeval *tv)
 {
-	unsigned long timestamp;
+	time_t timestamp;
 	int offset;
 	int errors = 0;
 
@@ -1154,10 +1160,10 @@ unsigned long approxidate_relative(const char *date, const struct timeval *tv)
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
@@ -1172,13 +1178,15 @@ unsigned long approxidate_careful(const char *date, int *error_ret)
 	return approxidate_str(date, &tv, error_ret);
 }
 
-int date_overflows(unsigned long t)
+int date_overflows(time_t t)
 {
 	time_t sys;
 
-	/* If we overflowed our unsigned long, that's bad... */
+#if 0 /* sizeof(time_t) <= sizeof(unsigned long) */
+	/* If we overflowed our time_t, that's bad... */
 	if (t == ULONG_MAX)
 		return 1;
+#endif
 
 	/*
 	 * ...but we also are going to feed the result to system
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 239898d..9940e68 100644
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
diff --git a/reflog-walk.c b/reflog-walk.c
index a246af2..d1a8673 100644
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
index 87dc82f..ed1970f 100644
--- a/refs.c
+++ b/refs.c
@@ -620,7 +620,7 @@ int is_branch(const char *refname)
 
 struct read_ref_at_cb {
 	const char *refname;
-	unsigned long at_time;
+	time_t at_time;
 	int cnt;
 	int reccnt;
 	unsigned char *sha1;
@@ -629,15 +629,15 @@ struct read_ref_at_cb {
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
@@ -684,7 +684,7 @@ static int read_ref_at_ent(unsigned char *osha1, unsigned char *nsha1,
 }
 
 static int read_ref_at_ent_oldest(unsigned char *osha1, unsigned char *nsha1,
-				  const char *email, unsigned long timestamp,
+				  const char *email, time_t timestamp,
 				  int tz, const char *message, void *cb_data)
 {
 	struct read_ref_at_cb *cb = cb_data;
@@ -704,9 +704,9 @@ static int read_ref_at_ent_oldest(unsigned char *osha1, unsigned char *nsha1,
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
index 56089d5..cac8fbf 100644
--- a/refs.h
+++ b/refs.h
@@ -246,9 +246,9 @@ int safe_create_reflog(const char *refname, int force_create, struct strbuf *err
 
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *refname, unsigned int flags,
-		       unsigned long at_time, int cnt,
+		       time_t at_time, int cnt,
 		       unsigned char *sha1, char **msg,
-		       unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
+		       time_t *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
 
 /** Check if a particular reflog exists */
 extern int reflog_exists(const char *refname);
@@ -274,7 +274,7 @@ extern int delete_refs(struct string_list *refnames);
 extern int delete_reflog(const char *refname);
 
 /* iterate over reflog entries */
-typedef int each_reflog_ent_fn(unsigned char *osha1, unsigned char *nsha1, const char *, unsigned long, int, const char *, void *);
+typedef int each_reflog_ent_fn(unsigned char *osha1, unsigned char *nsha1, const char *, time_t, int, const char *, void *);
 int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
 int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data);
 
@@ -512,7 +512,7 @@ typedef void reflog_expiry_prepare_fn(const char *refname,
 typedef int reflog_expiry_should_prune_fn(unsigned char *osha1,
 					  unsigned char *nsha1,
 					  const char *email,
-					  unsigned long timestamp, int tz,
+					  time_t timestamp, int tz,
 					  const char *message, void *cb_data);
 typedef void reflog_expiry_cleanup_fn(void *cb_data);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1f38076..d809c92 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2816,7 +2816,7 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
 {
 	unsigned char osha1[20], nsha1[20];
 	char *email_end, *message;
-	unsigned long timestamp;
+	time_t timestamp;
 	int tz;
 
 	/* old SP new SP name <email> SP time TAB msg LF */
@@ -3297,7 +3297,7 @@ struct expire_reflog_cb {
 };
 
 static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-			     const char *email, unsigned long timestamp, int tz,
+			     const char *email, time_t timestamp, int tz,
 			     const char *message, void *cb_data)
 {
 	struct expire_reflog_cb *cb = cb_data;
diff --git a/revision.c b/revision.c
index d30d1c4..7b7b353 100644
--- a/revision.c
+++ b/revision.c
@@ -896,7 +896,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 /* How many extra uninteresting commits we want to see.. */
 #define SLOP 5
 
-static int still_interesting(struct commit_list *src, unsigned long date, int slop,
+static int still_interesting(struct commit_list *src, time_t date, int slop,
 			     struct commit **interesting_cache)
 {
 	/*
@@ -1030,7 +1030,7 @@ static void limit_left_right(struct commit_list *list, struct rev_info *revs)
 static int limit_list(struct rev_info *revs)
 {
 	int slop = SLOP;
-	unsigned long date = ~0ul;
+	time_t date = ~0ul;
 	struct commit_list *list = revs->commits;
 	struct commit_list *newlist = NULL;
 	struct commit_list **p = &newlist;
@@ -1227,7 +1227,7 @@ static void handle_one_reflog_commit(unsigned char *sha1, void *cb_data)
 }
 
 static int handle_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
+		const char *email, time_t timestamp, int tz,
 		const char *message, void *cb_data)
 {
 	handle_one_reflog_commit(osha1, cb_data);
diff --git a/sha1_name.c b/sha1_name.c
index ca7ddd6..7d25734 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -542,8 +542,8 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
 
 	if (reflog_len) {
 		int nth, i;
-		unsigned long at_time;
-		unsigned long co_time;
+		time_t at_time;
+		time_t co_time;
 		int co_tz, co_cnt;
 
 		/* Is it asking for N-th entry, or approxidate? */
@@ -935,7 +935,7 @@ struct grab_nth_branch_switch_cbdata {
 };
 
 static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
-				  const char *email, unsigned long timestamp, int tz,
+				  const char *email, time_t timestamp, int tz,
 				  const char *message, void *cb_data)
 {
 	struct grab_nth_branch_switch_cbdata *cb = cb_data;
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index d9ab360..be45d3b 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -32,7 +32,7 @@ static void show_dates(char **argv, const char *format)
 		 * Do not use our normal timestamp parsing here, as the point
 		 * is to test the formatting code in isolation.
 		 */
-		t = strtol(arg, &arg, 10);
+		t = strtoull(arg, &arg, 10);
 		while (*arg == ' ')
 			arg++;
 		tz = atoi(arg);
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 8a1235d..14cecf4 100644
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
@@ -161,7 +161,7 @@ int main(int argc, char **argv)
 	show(&expect, &ret, "boolean: %d", boolean);
 	show(&expect, &ret, "integer: %d", integer);
 	show(&expect, &ret, "magnitude: %lu", magnitude);
-	show(&expect, &ret, "timestamp: %lu", timestamp);
+	show(&expect, &ret, "timestamp: %" PRIuMAX, timestamp);
 	show(&expect, &ret, "string: %s", string ? string : "(not set)");
 	show(&expect, &ret, "abbrev: %d", abbrev);
 	show(&expect, &ret, "verbose: %d", verbose);
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index e4b3959..9e1eb8d 100644
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
index 4ce4e35..67858ad 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1303,7 +1303,7 @@ struct grab_1st_switch_cbdata {
 };
 
 static int grab_1st_switch(unsigned char *osha1, unsigned char *nsha1,
-			   const char *email, unsigned long timestamp, int tz,
+			   const char *email, time_t timestamp, int tz,
 			   const char *message, void *cb_data)
 {
 	struct grab_1st_switch_cbdata *cb = cb_data;
-- 
2.9.0.278.g1caae67

