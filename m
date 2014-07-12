From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v8 17/17] api-trace.txt: add trace API documentation
Date: Sat, 12 Jul 2014 02:08:48 +0200
Message-ID: <53C07C90.8080309@gmail.com>
References: <53C079C5.8090503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBDPZQGPAKGQE5VVJ7WA@googlegroups.com Sat Jul 12 02:08:46 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBDPZQGPAKGQE5VVJ7WA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f189.google.com ([209.85.217.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBDPZQGPAKGQE5VVJ7WA@googlegroups.com>)
	id 1X5kru-0000Sv-CG
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2014 02:08:46 +0200
Received: by mail-lb0-f189.google.com with SMTP id v6sf162808lbi.6
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2014 17:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=ukyy3kucYChT40GWEvGEvOBs80jKBYM4nDzLJecHHrs=;
        b=Tdm1+zQGfg60AeYx+3YqGkWBUyFbtyr8XI93VE0U177rnnFbRK2yfEYZlq8MepRyn4
         9mXSJ2hgFdCUVwYvBDxGlx4jVZCy1fFU8BZkj4ZXhb54fA6BFMGpCFR8zu77L4TNzF6s
         9Tup0BFv50EpbeR2M+ZM5ps11jN0GM5yysRc9Pa7o8uv0jPLaGHf2luSzorZYgu/qW3D
         u5659gQUyM6ngU3LXZgACEvNsi4TE9LdsqEUvjdcpgQuFESKxVCXpKleYxBu6+so13Gc
         9wlf6R21ESC9T/2u6y0m6F9KXAJiOBuFS1UQqaeEiBlLQDCH/gnAXZkDF0aY3EJPt/6I
         vf0g==
X-Received: by 10.152.43.68 with SMTP id u4mr17605lal.12.1405123726218;
        Fri, 11 Jul 2014 17:08:46 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.3.229 with SMTP id f5ls122870laf.26.gmail; Fri, 11 Jul
 2014 17:08:44 -0700 (PDT)
X-Received: by 10.152.203.199 with SMTP id ks7mr218004lac.0.1405123724821;
        Fri, 11 Jul 2014 17:08:44 -0700 (PDT)
Received: from mail-we0-x235.google.com (mail-we0-x235.google.com [2a00:1450:400c:c03::235])
        by gmr-mx.google.com with ESMTPS id gg16si3721wic.2.2014.07.11.17.08.44
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 17:08:44 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::235 as permitted sender) client-ip=2a00:1450:400c:c03::235;
Received: by mail-we0-f181.google.com with SMTP id q59so1745679wes.26
        for <msysgit@googlegroups.com>; Fri, 11 Jul 2014 17:08:44 -0700 (PDT)
X-Received: by 10.194.205.65 with SMTP id le1mr2691331wjc.67.1405123724741;
        Fri, 11 Jul 2014 17:08:44 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id lk5sm348898wic.18.2014.07.11.17.08.43
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 17:08:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C079C5.8090503@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::235
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253372>

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 Documentation/technical/api-trace.txt | 97 +++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/technical/api-trace.txt

diff --git a/Documentation/technical/api-trace.txt b/Documentation/technical/api-trace.txt
new file mode 100644
index 0000000..097a651
--- /dev/null
+++ b/Documentation/technical/api-trace.txt
@@ -0,0 +1,97 @@
+trace API
+=========
+
+The trace API can be used to print debug messages to stderr or a file. Trace
+code is inactive unless explicitly enabled by setting `GIT_TRACE*` environment
+variables.
+
+The trace implementation automatically adds `timestamp file:line ... \n` to
+all trace messages. E.g.:
+
+------------
+23:59:59.123456 git.c:312               trace: built-in: git 'foo'
+00:00:00.000001 builtin/foo.c:99        foo: some message
+------------
+
+Data Structures
+---------------
+
+`struct trace_key`::
+
+	Defines a trace key (or category). The default (for API functions that
+	don't take a key) is `GIT_TRACE`.
++
+E.g. to define a trace key controlled by environment variable `GIT_TRACE_FOO`:
++
+------------
+static struct trace_key trace_foo = TRACE_KEY_INIT(FOO);
+
+static void trace_print_foo(const char *message)
+{
+	trace_print_key(&trace_foo, message);
+}
+------------
++
+Note: don't use `const` as the trace implementation stores internal state in
+the `trace_key` structure.
+
+Functions
+---------
+
+`int trace_want(struct trace_key *key)`::
+
+	Checks whether the trace key is enabled. Used to prevent expensive
+	string formatting before calling one of the printing APIs.
+
+`void trace_disable(struct trace_key *key)`::
+
+	Disables tracing for the specified key, even if the environment
+	variable was set.
+
+`void trace_printf(const char *format, ...)`::
+`void trace_printf_key(struct trace_key *key, const char *format, ...)`::
+
+	Prints a formatted message, similar to printf.
+
+`void trace_argv_printf(const char **argv, const char *format, ...)``::
+
+	Prints a formatted message, followed by a quoted list of arguments.
+
+`void trace_strbuf(struct trace_key *key, const struct strbuf *data)`::
+
+	Prints the strbuf, without additional formatting (i.e. doesn't
+	choke on `%` or even `\0`).
+
+`uint64_t getnanotime(void)`::
+
+	Returns nanoseconds since the epoch (01/01/1970), typically used
+	for performance measurements.
++
+Currently there are high precision timer implementations for Linux (using
+`clock_gettime(CLOCK_MONOTONIC)`) and Windows (`QueryPerformanceCounter`).
+Other platforms use `gettimeofday` as time source.
+
+`void trace_performance(uint64_t nanos, const char *format, ...)`::
+`void trace_performance_since(uint64_t start, const char *format, ...)`::
+
+	Prints the elapsed time (in nanoseconds), or elapsed time since
+	`start`, followed by a formatted message. Enabled via environment
+	variable `GIT_TRACE_PERFORMANCE`. Used for manual profiling, e.g.:
++
+------------
+uint64_t start = getnanotime();
+/* code section to measure */
+trace_performance_since(start, "foobar");
+------------
++
+------------
+uint64_t t = 0;
+for (;;) {
+	/* ignore */
+	t -= getnanotime();
+	/* code section to measure */
+	t += getnanotime();
+	/* ignore */
+}
+trace_performance(t, "frotz");
+------------
-- 
2.0.0.406.g2e9ef9b

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
