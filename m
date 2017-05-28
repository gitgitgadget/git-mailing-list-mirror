Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8904220D0A
	for <e@80x24.org>; Sun, 28 May 2017 11:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751033AbdE1Lnp (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 07:43:45 -0400
Received: from mout.web.de ([212.227.15.14]:55205 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750979AbdE1Lnp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 07:43:45 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LwI74-1dzZXm47na-01815T; Sun, 28
 May 2017 13:43:25 +0200
Subject: Re: git-2.13.0: log --date=format:%z not working
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     Ulrich Mueller <ulm@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>
References: <22824.29946.305300.380299@a1i15.kph.uni-mainz.de>
 <CACBZZX6t0Q9AJ4cpnG298tf5Las-YpmvvJXgLNNYMszikLvtMQ@mail.gmail.com>
 <20170527214611.suohggo226tvmbgt@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0a56f99e-aaa4-17ea-245a-12897ba08dbb@web.de>
Date:   Sun, 28 May 2017 13:43:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170527214611.suohggo226tvmbgt@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ZxKZ9npdarKfC2P+fFwkwB0MQ5mT4KF7pU608wOJtfg9mp7MebX
 h4EZPNn8ZxsmVh4LTAhcZ2abVHKTanlws0Mn3M20nOz4q8oVWzCXZ1IVStclwY4fEAL0LZR
 f9og0QGixbZdIUHvDD4qRWppDKy6eHqrXN0XFCSRYGwbBm/zpb5aGo0g6iYIqRqvVOiObdR
 ZAmijsXC+fHSeLMu7pQdQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VuEMu1vTAUI=:QCyvhVOa/u0TByIsX7r/tX
 Bfnc0uMs02fKgqrzlBG/b4WXpey0AMHV8tGa+uqyn6uwR23+mv5EOSLIMliMqb8O1fVGL8eZ7
 kbckmNck8bFiBGazMIjw8Q/VxMz/yyjgeVOB1KsZ6O83cbexKkMMaBAGIDXz1firA7GJ6WHii
 PGEjD6k/x6xUqPlWbNgp8lHQjpI9/VLndGeXixQbo4WIBR7kPrc2YstB5qZdNmutSusCIKUBY
 fhPLdPFKXX9B9qonHh0RsTKF/kwwjmJzSoiJh+3BFVF20de8BrMaGMjpDypgXo58Q4Oxn+rRE
 opY95WCm3nD8kF+SQqo+NHTEWyhjRD2F3qP+IebWJ6XuLFBb8IgywBtXp55jb5dTJ6sarU43e
 YS0Y/3RAevG3K7bGNyhSc891ChvpOZ6EblLnUncKOCkaVuKmrxHoTaWi4lx5HDJABSfqI4jbi
 pbYG/rkTTTa6dB0TYAMhjI7Na2wypC0W5RBvlc64lKCSDt1UIkd+bMmVbPcH94MslJwa8ZZtz
 H8pdxeH1JdX74t5axSjRfRekuISSBW7XWVSPhxq5pFdhwKdkDvaYAedpZqA6JdlDlPh+VuwNz
 PMYKwzDq3RdKaDX6HO7uQpyosOYN0tKHryF5O8IyHIFImyNbWQOv7BMBh0HkqeG6IUN/ARcg8
 ULbNxgSSbCb0S4D0DD9bd5brvjDrwsGKOYCFltUy22lix8kkTJJVcoH2hT/rvxjPNqRiu41HQ
 EwpN0W09DS3Ab/+cmVsQH+MHxyita/8j4eCCQ3SMCSGrhYvtv5UBaU8w9fa+WDoi/6iV+e/tY
 FYAebeI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.05.2017 um 23:46 schrieb Jeff King:
> On Sat, May 27, 2017 at 06:57:08PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
>> There's another test which breaks if we just s/gmtime/localtime/g. As
>> far as I can tell to make the non-local case work we'd need to do a
>> whole dance where we set the TZ variable to e.g. UTC$offset, then call
>> strftime(), then call it again. Maybe there's some way to just specify
>> the tz offset, but I didn't find any in a quick skimming of time.h.
> 
> There isn't.
Right.  We could handle %z internally, though.  %Z would be harder (left
as an exercise for readers..).

First we'd have to undo 0a0416a3 (strbuf_expand: convert "%%" to "%"),
though, in order to give full control back to strbuf_expand callbacks.

2-pack patch:

--- >8 ---
 builtin/cat-file.c         |  5 +++++
 convert.c                  |  1 +
 daemon.c                   |  3 +++
 date.c                     |  2 +-
 ll-merge.c                 |  5 +++--
 pretty.c                   |  3 +++
 strbuf.c                   | 39 ++++++++++++++++++++++++++++++---------
 strbuf.h                   | 11 +++++------
 t/t6006-rev-list-format.sh | 12 ++++++++++++
 9 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1890d7a639..9cf2e4291d 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -252,6 +252,11 @@ static size_t expand_format(struct strbuf *sb, const char *start, void *data)
 {
 	const char *end;
 
+	if (*start == '%') {
+		strbuf_addch(sb, '%');
+		return 1;
+	}
+
 	if (*start != '(')
 		return 0;
 	end = strchr(start + 1, ')');
diff --git a/convert.c b/convert.c
index 8d652bf27c..8336fff694 100644
--- a/convert.c
+++ b/convert.c
@@ -399,6 +399,7 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf_expand_dict_entry dict[] = {
 		{ "f", NULL, },
+		{ "%", "%" },
 		{ NULL, NULL, },
 	};
 
diff --git a/daemon.c b/daemon.c
index ac7181a483..191fac2716 100644
--- a/daemon.c
+++ b/daemon.c
@@ -148,6 +148,9 @@ static size_t expand_path(struct strbuf *sb, const char *placeholder, void *ctx)
 	case 'D':
 		strbuf_addstr(sb, context->directory);
 		return 1;
+	case '%':
+		strbuf_addch(sb, '%');
+		return 1;
 	}
 	return 0;
 }
diff --git a/date.c b/date.c
index 63fa99685e..d16a88eea5 100644
--- a/date.c
+++ b/date.c
@@ -246,7 +246,7 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 			month_names[tm->tm_mon], tm->tm_year + 1900,
 			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
 	else if (mode->type == DATE_STRFTIME)
-		strbuf_addftime(&timebuf, mode->strftime_fmt, tm);
+		strbuf_addftime(&timebuf, mode->strftime_fmt, tm, tz);
 	else
 		strbuf_addf(&timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
 				weekday_names[tm->tm_wday],
diff --git a/ll-merge.c b/ll-merge.c
index ac0d4a5d78..e6202c7397 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -172,7 +172,7 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 {
 	char temp[4][50];
 	struct strbuf cmd = STRBUF_INIT;
-	struct strbuf_expand_dict_entry dict[6];
+	struct strbuf_expand_dict_entry dict[7];
 	struct strbuf path_sq = STRBUF_INIT;
 	const char *args[] = { NULL, NULL };
 	int status, fd, i;
@@ -185,7 +185,8 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 	dict[2].placeholder = "B"; dict[2].value = temp[2];
 	dict[3].placeholder = "L"; dict[3].value = temp[3];
 	dict[4].placeholder = "P"; dict[4].value = path_sq.buf;
-	dict[5].placeholder = NULL; dict[5].value = NULL;
+	dict[5].placeholder = "%"; dict[5].value = "%";
+	dict[6].placeholder = NULL; dict[6].value = NULL;
 
 	if (fn->cmdline == NULL)
 		die("custom merge driver %s lacks command line.", fn->name);
diff --git a/pretty.c b/pretty.c
index 587d48371b..56872bfa25 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1428,6 +1428,9 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
 	} magic = NO_MAGIC;
 
 	switch (placeholder[0]) {
+	case '%':
+		strbuf_addch(sb, '%');
+		return 1;
 	case '-':
 		magic = DEL_LF_BEFORE_EMPTY;
 		break;
diff --git a/strbuf.c b/strbuf.c
index 00457940cf..206dff6037 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -309,12 +309,6 @@ void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn,
 			break;
 		format = percent + 1;
 
-		if (*format == '%') {
-			strbuf_addch(sb, '%');
-			format++;
-			continue;
-		}
-
 		consumed = fn(sb, format, context);
 		if (consumed)
 			format += consumed;
@@ -785,7 +779,28 @@ char *xstrfmt(const char *fmt, ...)
 	return ret;
 }
 
-void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm)
+struct date_format_context {
+	int tz;
+};
+
+static size_t expand_date_format(struct strbuf *sb, const char *placeholder,
+				 void *ctx)
+{
+	struct date_format_context *c = ctx;
+
+	switch (placeholder[0]) {
+	case '%':
+		strbuf_addstr(sb, "%%");
+		return 1;
+	case 'z':
+		strbuf_addf(sb, "%+05d", c->tz);
+		return 1;
+	}
+	return 0;
+}
+
+void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
+		     int tz)
 {
 	size_t hint = 128;
 	size_t len;
@@ -794,7 +809,10 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm)
 		return;
 
 	strbuf_grow(sb, hint);
-	len = strftime(sb->buf + sb->len, sb->alloc - sb->len, fmt, tm);
+	if (strstr(fmt, "%z"))
+		len = 0;
+	else
+		len = strftime(sb->buf + sb->len, sb->alloc - sb->len, fmt, tm);
 
 	if (!len) {
 		/*
@@ -805,7 +823,10 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm)
 		 * character before returning.
 		 */
 		struct strbuf munged_fmt = STRBUF_INIT;
-		strbuf_addf(&munged_fmt, "%s ", fmt);
+		struct date_format_context ctx;
+		ctx.tz = tz;
+		strbuf_expand(&munged_fmt, fmt, expand_date_format, &ctx);
+		strbuf_addch(&munged_fmt, ' ');
 		while (!len) {
 			hint *= 2;
 			strbuf_grow(sb, hint);
diff --git a/strbuf.h b/strbuf.h
index 80047b1bb7..fc4c796a2b 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -281,10 +281,6 @@ extern void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len);
  * the length of the placeholder recognized and `strbuf_expand()` skips
  * over it.
  *
- * The format `%%` is automatically expanded to a single `%` as a quoting
- * mechanism; callers do not need to handle the `%` placeholder themselves,
- * and the callback function will not be invoked for this placeholder.
- *
  * All other characters (non-percent and not skipped ones) are copied
  * verbatim to the strbuf.  If the callback returned zero, meaning that the
  * placeholder is unknown, then the percent sign is copied, too.
@@ -339,9 +335,12 @@ __attribute__((format (printf,2,0)))
 extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
 
 /**
- * Add the time specified by `tm`, as formatted by `strftime`.
+ * Add the time specified by `tm` and `tz`, as formatted by `strftime`.
+ * The time zone offset is specified like hhmm, so e.g. -600 means six
+ * hours west of Greenwich.
  */
-extern void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm);
+extern void strbuf_addftime(struct strbuf *sb, const char *fmt,
+			    const struct tm *tm, int tz);
 
 /**
  * Read a given size of data from a FILE* pointer to the buffer.
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index a1dcdb81d7..dc0bed8d90 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -483,4 +483,16 @@ test_expect_success 'unused %G placeholders are passed through' '
 	test_cmp expect actual
 '
 
+test_expect_success 'date format "%F %T %z" is the same as iso' '
+	git log -1 --format="%ad" --date=iso >expect &&
+	git log -1 --format="%ad" --date="format:%F %T %z" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'date format "%%z" expands to percent zed' '
+	echo "%z" >expect &&
+	git log -1 --format="%ad" --date="format:%%z" >actual &&
+	test_cmp expect actual
+'
+
 test_done
