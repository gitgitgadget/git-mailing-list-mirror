From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v5 02/11] trace: consistently name the format parameter
Date: Wed, 11 Jun 2014 09:57:23 +0200
Message-ID: <53980BE3.4090807@gmail.com>
References: <53980B83.9050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
 Jeff King <peff@peff.net>
X-From: msysgit+bncBCH3XYXLXQDBBY4X4COAKGQEEY745SQ@googlegroups.com Wed Jun 11 09:57:30 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBY4X4COAKGQEEY745SQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f60.google.com ([74.125.82.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBY4X4COAKGQEEY745SQ@googlegroups.com>)
	id 1WudPQ-0005EM-Mi
	for gcvm-msysgit@m.gmane.org; Wed, 11 Jun 2014 09:57:24 +0200
Received: by mail-wg0-f60.google.com with SMTP id n12sf961183wgh.25
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Jun 2014 00:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=aOhn3rEungWf4Ue0A2L5rJSdkJKQEa/X3baeeBOHPKE=;
        b=lzYq6wmC1Zaatza0AEp3+TjuPOG5DGj7mFdY7WzFZ85ylwchvJQMBoaOX3GBI7yJWu
         PG9+s2JA8aWdAzF79CvkdW4Ew+CC4YklQn3kFFsSBukNw3gdw+zklzBsFkSH5+lzy5BR
         o94h4P0NOFnqibeIgbGnpPRJqlUTGVihQMDTD++Qvrdw+hjnDRQxKKpZ5c1RWcJYEm2x
         1X8Md+1s/kSvKCt5R7fONV3YbVYx39NRQxH7qDmsNB1TWSwEa+314My+f2wM+JeNLtWg
         U/eNfl0oDd1Wt9Qh7B4YnOha5WGZ+tWdu0H/1n7xsSZ9d4og7WCCu8POR2Jm6IL6DD5H
         CE4w==
X-Received: by 10.152.43.16 with SMTP id s16mr4524lal.15.1402473444380;
        Wed, 11 Jun 2014 00:57:24 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.30.2 with SMTP id o2ls427030lah.40.gmail; Wed, 11 Jun 2014
 00:57:23 -0700 (PDT)
X-Received: by 10.152.6.97 with SMTP id z1mr4886517laz.0.1402473443329;
        Wed, 11 Jun 2014 00:57:23 -0700 (PDT)
Received: from mail-wi0-x233.google.com (mail-wi0-x233.google.com [2a00:1450:400c:c05::233])
        by gmr-mx.google.com with ESMTPS id e12si1260989wiv.1.2014.06.11.00.57.23
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 00:57:23 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::233 as permitted sender) client-ip=2a00:1450:400c:c05::233;
Received: by mail-wi0-x233.google.com with SMTP id cc10so556149wib.12
        for <msysgit@googlegroups.com>; Wed, 11 Jun 2014 00:57:23 -0700 (PDT)
X-Received: by 10.180.198.178 with SMTP id jd18mr44954874wic.24.1402473443240;
        Wed, 11 Jun 2014 00:57:23 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id cj41sm57937760eeb.34.2014.06.11.00.57.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 00:57:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <53980B83.9050409@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::233
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251331>

The format parameter to trace_printf functions is sometimes abbreviated
'fmt'. Rename to 'format' everywhere (consistent with POSIX' printf
specification).

Signed-off-by: Karsten Blees <blees@dcon.de>
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
1.9.2.msysgit.0.501.gaeecf09

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
