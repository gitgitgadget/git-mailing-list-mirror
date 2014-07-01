From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v7 02/16] trace: consistently name the format parameter
Date: Wed, 02 Jul 2014 00:56:00 +0200
Message-ID: <53B33C80.6040405@gmail.com>
References: <53B33C05.5090900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBAHZZSOQKGQE3S6Q7ZA@googlegroups.com Wed Jul 02 00:56:01 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBAHZZSOQKGQE3S6Q7ZA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f62.google.com ([209.85.215.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBAHZZSOQKGQE3S6Q7ZA@googlegroups.com>)
	id 1X26y1-0000tE-Gn
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2014 00:56:01 +0200
Received: by mail-la0-f62.google.com with SMTP id gf5sf975695lab.7
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 Jul 2014 15:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=M7k0oY+vsfUIRkFS1H6RuaG/hpj9sYf4JXWiQrtO6Ec=;
        b=GHWzUdNohlZc2/yXhgKWpSu56JiQHDszxZpMKDdulQ7yxLh/sx3DMSSHDP5z+LwZKN
         7IUtt20N4k/RNC65CVCLWcU1XXyefHyocnWpfR1WUhRqJZbvE71a+kUccKVqju+gHOls
         QLmv9aBpjqxNzg7dLRnAG++uY+tGafZ1fuCff/ozfVXOjzk2PQtFK3wkmiucakUOD/4d
         4xFRj3T+XnfaCzHhwuOVg+NOIwiCvY6GARsmEY+t8QSNf28dWnCFfW1XQEobPJOwFLcq
         hyzhhKFHeW1Njn3BHWxy7KQz0sw4J5F9E5TqxMFk7kSBz1kQiUfr1e4LjHjj5Rlmfrks
         S+Kg==
X-Received: by 10.180.73.112 with SMTP id k16mr2241wiv.5.1404255361129;
        Tue, 01 Jul 2014 15:56:01 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.186.8 with SMTP id fg8ls680212wic.7.gmail; Tue, 01 Jul
 2014 15:56:00 -0700 (PDT)
X-Received: by 10.180.87.71 with SMTP id v7mr3854285wiz.5.1404255360323;
        Tue, 01 Jul 2014 15:56:00 -0700 (PDT)
Received: from mail-wi0-x22b.google.com (mail-wi0-x22b.google.com [2a00:1450:400c:c05::22b])
        by gmr-mx.google.com with ESMTPS id cj4si810249wid.0.2014.07.01.15.56.00
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 15:56:00 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22b as permitted sender) client-ip=2a00:1450:400c:c05::22b;
Received: by mail-wi0-f171.google.com with SMTP id n15so8661902wiw.4
        for <msysgit@googlegroups.com>; Tue, 01 Jul 2014 15:56:00 -0700 (PDT)
X-Received: by 10.194.80.7 with SMTP id n7mr54974688wjx.8.1404255360253;
        Tue, 01 Jul 2014 15:56:00 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id d4sm30640056wik.20.2014.07.01.15.55.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 15:55:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B33C05.5090900@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22b
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252750>

The format parameter to trace_printf functions is sometimes abbreviated
'fmt'. Rename to 'format' everywhere (consistent with POSIX' printf
specification).

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trace.c | 22 +++++++++++-----------
 trace.h |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/trace.c b/trace.c
index 08180a9..37a7fa9 100644
--- a/trace.c
+++ b/trace.c
@@ -62,7 +62,7 @@ static int get_trace_fd(const char *key, int *need_close)
 static const char err_msg[] = "Could not trace into fd given by "
 	"GIT_TRACE environment variable";
 
-static void trace_vprintf(const char *key, const char *fmt, va_list ap)
+static void trace_vprintf(const char *key, const char *format, va_list ap)
 {
 	struct strbuf buf = STRBUF_INIT;
 
@@ -70,25 +70,25 @@ static void trace_vprintf(const char *key, const char *fmt, va_list ap)
 		return;
 
 	set_try_to_free_routine(NULL);	/* is never reset */
-	strbuf_vaddf(&buf, fmt, ap);
+	strbuf_vaddf(&buf, format, ap);
 	trace_strbuf(key, &buf);
 	strbuf_release(&buf);
 }
 
 __attribute__((format (printf, 2, 3)))
-void trace_printf_key(const char *key, const char *fmt, ...)
+void trace_printf_key(const char *key, const char *format, ...)
 {
 	va_list ap;
-	va_start(ap, fmt);
-	trace_vprintf(key, fmt, ap);
+	va_start(ap, format);
+	trace_vprintf(key, format, ap);
 	va_end(ap);
 }
 
-void trace_printf(const char *fmt, ...)
+void trace_printf(const char *format, ...)
 {
 	va_list ap;
-	va_start(ap, fmt);
-	trace_vprintf("GIT_TRACE", fmt, ap);
+	va_start(ap, format);
+	trace_vprintf("GIT_TRACE", format, ap);
 	va_end(ap);
 }
 
@@ -106,7 +106,7 @@ void trace_strbuf(const char *key, const struct strbuf *buf)
 		close(fd);
 }
 
-void trace_argv_printf(const char **argv, const char *fmt, ...)
+void trace_argv_printf(const char **argv, const char *format, ...)
 {
 	struct strbuf buf = STRBUF_INIT;
 	va_list ap;
@@ -117,8 +117,8 @@ void trace_argv_printf(const char **argv, const char *fmt, ...)
 		return;
 
 	set_try_to_free_routine(NULL);	/* is never reset */
-	va_start(ap, fmt);
-	strbuf_vaddf(&buf, fmt, ap);
+	va_start(ap, format);
+	strbuf_vaddf(&buf, format, ap);
 	va_end(ap);
 
 	sq_quote_argv(&buf, argv, 0);
diff --git a/trace.h b/trace.h
index 6cc4541..8fea50b 100644
--- a/trace.h
+++ b/trace.h
@@ -11,7 +11,7 @@ extern void trace_argv_printf(const char **argv, const char *format, ...);
 extern void trace_repo_setup(const char *prefix);
 extern int trace_want(const char *key);
 __attribute__((format (printf, 2, 3)))
-extern void trace_printf_key(const char *key, const char *fmt, ...);
+extern void trace_printf_key(const char *key, const char *format, ...);
 extern void trace_strbuf(const char *key, const struct strbuf *buf);
 
 #endif /* TRACE_H */
-- 
2.0.0.406.ge74f8ff

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
