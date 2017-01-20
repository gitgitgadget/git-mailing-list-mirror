Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC43A1F89C
	for <e@80x24.org>; Fri, 20 Jan 2017 10:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbdATKbS (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 05:31:18 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34655 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbdATKbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 05:31:16 -0500
Received: by mail-pf0-f193.google.com with SMTP id y143so5257127pfb.1
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 02:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aYonBqH+qB4MGLU8q1bVA38I2McZ9C2tLg9JUOkhOyQ=;
        b=JoT2QVdp4p8oUME8OIQjkyshURfKHRpbDN0N6Y9ilBKx/YmAwzYo5VOmeqHl3tWzcC
         skIB7byN0BvlitjojMmARtMy7t7BDS6HsCopQonrH6EGshG2ZhO2HLW7W6au4/QM8xyD
         qGG2vaQfvx1dgFVu5FMIZLQxpZzh3OwIa579vbpIliq8t5fpOWKJNqftazDOHI02iNzl
         01FV4q7OtERHrGGrY1bowD/2/ZkPq793wMTPzUQpIwmWPWH4UY60OC1TBOiYULYuwwzV
         UCdQAcjONJeM0stdnhTo4oGP7Kl+GM0rAx/NxC8r9x0iE8SbohWWYk4mDoquXjG6qBZ/
         RTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aYonBqH+qB4MGLU8q1bVA38I2McZ9C2tLg9JUOkhOyQ=;
        b=o0k8KZIInpfpSLHGyjkemZlof8tH8Yr76i8GP0wE4oZsJF/xxjN7uv2A1DeO/Lgbp4
         3CgrNE3jrG5RwHGcigZsYETVJjyfHArPBzoPdL/DfJ0JeUyWgtIrm7sbAY/kczQly2wv
         wR4kQFhvlSkwFZk+91oDxjvfngH1VqOZgSCkHPiwZYip+myZ6tcx8l2VM19HzFUiIENf
         lRdm/4l8w+QxwLQe3RWLIwtLNr9/UenFpOHfNKIVnYrejFLP+BscVZ47+zhp3an+KdZD
         rGvCqi92BWTgAPMuxuy6maOgOETHegq75AoRM9E/ewb1cVmkc6XjsDzDlMLd3JD60LjL
         gcaw==
X-Gm-Message-State: AIkVDXJG5s+wGLqRDNF6Nih3ILL/giUS2eMYEjTaKAdxn1V6lp9FqmB4gbTXtV5svHsClg==
X-Received: by 10.99.124.17 with SMTP id x17mr15953344pgc.25.1484907781588;
        Fri, 20 Jan 2017 02:23:01 -0800 (PST)
Received: from ash ([115.72.179.24])
        by smtp.gmail.com with ESMTPSA id t21sm15565591pfa.1.2017.01.20.02.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jan 2017 02:23:00 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 20 Jan 2017 17:22:55 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/TOY] Shortcuts to quickly refer to a commit name with keyboard
Date:   Fri, 20 Jan 2017 17:22:49 +0700
Message-Id: <20170120102249.15572-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OK This patch is horrible. Though the idea is cool and I've found it
very useful. So here it is. Perhaps the idea may be revised a bit
that's more suitable for more than one user.

The problem is old, SHA-1 name is not keyboard-friendly, even in
abbreviated form. And recent change has made abbrev form longer,
harder to type. Most of the time I just go with copy/paste with the
mouse, which I don't like. name-rev helps a bit, but it's still long
to type (especially with all the ^ and ~ that requires holding shift
down).

So, this patch adds an option --mark-commits to git-log. Whenever a
commit SHA-1 is printed on screen, it gets a new shortcut in form of
<at-sign><one-letter><number> e.g. @h2. The number keeps increasing
during one git-log, so you'll get @h1, @h2, @h3 and so on. Typing @h3
gets you back to the associated SHA-1.

Different git-log runs will change the <one-letter> part. So the
second git-log run may give you @j1, @j2, @j3... This is useful
because sometimes you want to run more than one command, then
reference back to commits from the first command.

There's a limited number of letters to be used here. I limit it to the
letters on the home row to avoid moving fingers too much. Which means
after like 9 runs, @h is recycled for something new. Not great if you
have "git blah blah @h2" in bash history and keep recalling it from
time to time.

So, whenever you use a shortcut, the shortcut is kept in a "database"
and will not be recycled for quite some time. When @h is recycled,
you'll get @h1, then @h3 and so on if @h2 has just been used recently.
This makes sure recently used shortcuts live on.

That's it. I have to say typing 3-4 characters is really nice. I kinda
want to reduce the number of keystokes further down, but it's been good
enough that I'm not so pissed to spend time tuning it further.

This shortcut format violates the extended sha1 syntax, I think. In
order have any chance of entering git, we'll have to deal with that
first.

---
 Makefile            |   1 +
 commit.h            |   1 +
 log-tree.c          |   7 +++
 pretty.c            |   5 ++
 rev-counter.c (new) | 166 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 rev-counter.h (new) |  10 ++++
 revision.c          |   4 ++
 revision.h          |   1 +
 sha1_name.c         |   8 +++
 9 files changed, 203 insertions(+)
 create mode 100644 rev-counter.c
 create mode 100644 rev-counter.h

diff --git a/Makefile b/Makefile
index de5a030256..28948bd9eb 100644
--- a/Makefile
+++ b/Makefile
@@ -788,6 +788,7 @@ LIB_OBJS += replace_object.o
 LIB_OBJS += rerere.o
 LIB_OBJS += resolve-undo.o
 LIB_OBJS += revision.o
+LIB_OBJS += rev-counter.o
 LIB_OBJS += run-command.o
 LIB_OBJS += send-pack.o
 LIB_OBJS += sequencer.o
diff --git a/commit.h b/commit.h
index b06db4d5d9..8f67687208 100644
--- a/commit.h
+++ b/commit.h
@@ -155,6 +155,7 @@ struct pretty_print_context {
 	struct string_list *mailmap;
 	int color;
 	struct ident_split *from_ident;
+	int mark_commits;
 
 	/*
 	 * Fields below here are manipulated internally by pp_* functions and
diff --git a/log-tree.c b/log-tree.c
index 78a5381d0e..f49366b376 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -11,6 +11,7 @@
 #include "gpg-interface.h"
 #include "sequencer.h"
 #include "line-log.h"
+#include "rev-counter.h"
 
 static struct decoration name_decoration = { "object names" };
 static int decoration_loaded;
@@ -593,6 +594,9 @@ void show_log(struct rev_info *opt)
 	}
 	opt->shown_one = 1;
 
+	if (opt->mark_commits)
+		mark_commit(&commit->object.oid);
+
 	/*
 	 * If the history graph was requested,
 	 * print the graph, up to this commit's line
@@ -615,6 +619,8 @@ void show_log(struct rev_info *opt)
 			put_revision_mark(opt, commit);
 		fputs(find_unique_abbrev(commit->object.oid.hash, abbrev_commit),
 		      stdout);
+		if (opt->mark_commits)
+			printf(" @%s", oid_to_commit_mark(&commit->object.oid));
 		if (opt->print_parents)
 			show_parents(commit, abbrev_commit);
 		if (opt->children.name)
@@ -687,6 +693,7 @@ void show_log(struct rev_info *opt)
 	ctx.output_encoding = get_log_output_encoding();
 	if (opt->from_ident.mail_begin && opt->from_ident.name_begin)
 		ctx.from_ident = &opt->from_ident;
+	ctx.mark_commits = opt->mark_commits;
 	pretty_print_commit(&ctx, commit, &msgbuf);
 
 	if (opt->add_signoff)
diff --git a/pretty.c b/pretty.c
index c3ec430220..14e0022085 100644
--- a/pretty.c
+++ b/pretty.c
@@ -10,6 +10,7 @@
 #include "color.h"
 #include "reflog-walk.h"
 #include "gpg-interface.h"
+#include "rev-counter.h"
 
 static char *user_format;
 static struct cmt_fmt_map {
@@ -1127,6 +1128,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	case 'H':		/* commit hash */
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_COMMIT));
 		strbuf_addstr(sb, oid_to_hex(&commit->object.oid));
+		if (c->pretty_ctx->mark_commits)
+			strbuf_addf(sb, " @%s", oid_to_commit_mark(&commit->object.oid));
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_RESET));
 		return 1;
 	case 'h':		/* abbreviated commit hash */
@@ -1137,6 +1140,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		}
 		strbuf_addstr(sb, find_unique_abbrev(commit->object.oid.hash,
 						     c->pretty_ctx->abbrev));
+		if (c->pretty_ctx->mark_commits)
+			strbuf_addf(sb, " @%s", oid_to_commit_mark(&commit->object.oid));
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_RESET));
 		c->abbrev_commit_hash.len = sb->len - c->abbrev_commit_hash.off;
 		return 1;
diff --git a/rev-counter.c b/rev-counter.c
new file mode 100644
index 0000000000..60ab991fe1
--- /dev/null
+++ b/rev-counter.c
@@ -0,0 +1,166 @@
+#include "cache.h"
+#include "strbuf.h"
+#include "commit.h"
+#include "commit-slab.h"
+
+define_commit_slab(counter, char *);
+struct counter counter = COMMIT_SLAB_INIT(1, counter);
+
+static unsigned commit_counter;
+static int run_counter;
+int latest_fd = -1;
+struct strbuf recent = STRBUF_INIT;
+
+/* home row, except 'l' which looks too much like '1' */
+const char *starter = "asdfghjk";
+
+static void start_marking(void)
+{
+	char buf[64];
+	ssize_t len;
+
+	len = readlink(git_path("rev-counter/latest"), buf, sizeof(buf));
+	if (len == -1) {
+		if (errno != ENOENT)
+			die_errno("failed to open rev-counter/latest");
+	} else {
+		char ch, *p;
+		sscanf(buf, "%c", &ch);
+		p = strchrnul(starter, ch);
+		run_counter = ((p - starter) + 1) % strlen(starter);
+	}
+
+	if (!is_directory(git_path("rev-counter")))
+		mkdir(git_path("rev-counter"), 0755);
+	latest_fd = open(git_path("rev-counter/%c", starter[run_counter]),
+			 O_RDWR | O_CREAT | O_TRUNC, 0644);
+	if (latest_fd == -1)
+		die_errno("failed to create new rev-counter");
+
+	sprintf(buf, "%c", starter[run_counter]);
+	(void)unlink(git_path("rev-counter/latest"));
+	if (symlink(buf, git_path("rev-counter/latest")))
+		die_errno("failed to update rev-counter/latest");
+}
+
+static int strbuf_find_commit_mark(const struct strbuf *sb,
+				   const char *mark,
+				   struct object_id *oid)
+{
+	const char *p, *end;
+	int ret = -1;
+
+	end = sb->buf + sb->len;
+	p = sb->buf;
+	while (p < end && ret < 0) {
+		const char *next = strchrnul(p, '\n');
+
+		if (next - p > 41 &&
+		    p[40] == ' ' &&
+		    p + 41 + strlen(mark) == next &&
+		    !strncmp(p + 41, mark, strlen(mark)) &&
+		    !get_oid_hex(p, oid))
+			ret = 0;
+
+		p = next;
+		if (*p == '\n')
+			p++;
+	}
+	return ret;
+}
+
+void update_commit_counter(void)
+{
+	static int read_recent;
+	struct object_id oid;
+	char buf[16];
+
+	if (!read_recent) {
+		strbuf_read_file(&recent, git_path("rev-counter/recent"), 0);
+		read_recent = 1;
+
+		if (recent.len > 1000 * 45) { /* prune time? */
+			int fd;
+			const char *p = strchr(recent.buf + 1000 * 45, '\n');
+			strbuf_remove(&recent, 0, p + 1 - recent.buf);
+			if (!is_directory(git_path("rev-counter")))
+				mkdir(git_path("rev-counter"), 0755);
+			fd = open(git_path("rev-counter/recent"),
+				  O_CREAT | O_TRUNC | O_RDWR, 0644);
+			write_or_die(fd, recent.buf, recent.len);
+			close(fd);
+		}
+	}
+
+	do {
+		commit_counter++;
+		sprintf(buf, "%c%u", starter[run_counter], commit_counter);
+	} while (!strbuf_find_commit_mark(&recent, buf, &oid));
+}
+
+void mark_commit(const struct object_id *oid)
+{
+	struct commit *c;
+	char buf[64];
+	char **val;
+
+	if (latest_fd < 0)
+		start_marking();
+
+	if (!(c = lookup_commit(oid->hash)))
+		return;
+
+	update_commit_counter();
+	sprintf(buf, "%s %u\n", oid_to_hex(oid), commit_counter);
+	write_or_die(latest_fd, buf, strlen(buf));
+
+	sprintf(buf, "%c%u", starter[run_counter], commit_counter);
+	val = counter_at(&counter, c);
+	*val = xstrdup(buf);
+}
+
+const char *oid_to_commit_mark(const struct object_id *oid)
+{
+	struct commit *c;
+	char **val;
+
+	if (!(c = lookup_commit(oid->hash)) ||
+	    !(val = counter_peek(&counter, c)))
+		return NULL;
+
+	return *val;
+}
+
+int commit_mark_to_oid(const char *mark, struct object_id *oid)
+{
+	char buf[16];
+	int ret, c;
+	char r_ch;
+	struct strbuf sb = STRBUF_INIT;
+
+	if (sscanf(mark, "%c%u", &r_ch, &c) != 2 ||
+	    !strchr(starter, r_ch) ||
+	    strbuf_read_file(&sb, git_path("rev-counter/%c", r_ch), 0) < 0)
+		return -1;
+
+	sprintf(buf, "%u", c);
+	ret = strbuf_find_commit_mark(&sb, buf, oid);
+	strbuf_release(&sb);
+
+	if (!ret) {
+		char line[80];
+		static int fd;
+
+		if (!fd) {
+			if (!is_directory(git_path("rev-counter")))
+				mkdir(git_path("rev-counter"), 0755);
+			fd = open(git_path("rev-counter/recent"),
+				  O_CREAT | O_RDWR | O_APPEND, 0644);
+			if (fd == -1)
+				die("failed to open rev-counter/recent");
+		}
+		sprintf(line, "%s %s\n", oid_to_hex(oid), mark);
+		write_or_die(fd, line, strlen(line));
+	}
+	return ret;
+}
diff --git a/rev-counter.h b/rev-counter.h
new file mode 100644
index 0000000000..ab2e8d8803
--- /dev/null
+++ b/rev-counter.h
@@ -0,0 +1,10 @@
+#ifndef __REV_COUNTER_H__
+#define __REV_COUNTER_H__
+
+struct object_id;
+
+void mark_commit(const struct object_id *oid);
+const char *oid_to_commit_mark(const struct object_id *oid);
+int commit_mark_to_oid(const char *mark, struct object_id *oid);
+
+#endif
diff --git a/revision.c b/revision.c
index 2f60062876..1e32e91b9f 100644
--- a/revision.c
+++ b/revision.c
@@ -1998,6 +1998,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->limited = 1;
 	} else if (!strcmp(arg, "--ignore-missing")) {
 		revs->ignore_missing = 1;
+	} else if (!strcmp(arg, "--mark-commits")) {
+		revs->mark_commits = 1;
+	} else if (!strcmp(arg, "--no-mark-commits")) {
+		revs->mark_commits = 0;
 	} else {
 		int opts = diff_opt_parse(&revs->diffopt, argv, argc, revs->prefix);
 		if (!opts)
diff --git a/revision.h b/revision.h
index 9fac1a607d..94e5b70ff5 100644
--- a/revision.h
+++ b/revision.h
@@ -146,6 +146,7 @@ struct rev_info {
 	unsigned int	track_linear:1,
 			track_first_time:1,
 			linear:1;
+	unsigned int	mark_commits:1;
 
 	struct date_mode date_mode;
 	int		expand_tabs_in_log; /* unset if negative */
diff --git a/sha1_name.c b/sha1_name.c
index ca7ddd6f2c..d3e1ff3921 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -7,6 +7,7 @@
 #include "refs.h"
 #include "remote.h"
 #include "dir.h"
+#include "rev-counter.h"
 
 static int get_sha1_oneline(const char *, unsigned char *, struct commit_list *);
 
@@ -485,6 +486,13 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
 		}
 		return 0;
 	}
+	if (len > 2 && str[0] == '@' && isalpha(str[1]) && isdigit(str[2])) {
+		struct object_id oid;
+		if (!commit_mark_to_oid(str + 1, &oid)) {
+			hashcpy(sha1, oid.hash);
+			return 0;
+		}
+	}
 
 	/* basic@{time or number or -number} format to query ref-log */
 	reflog_len = at = 0;
-- 
2.11.0.157.gd943d85

