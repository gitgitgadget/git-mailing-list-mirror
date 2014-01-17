From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 2/2] mingw: remove mingw_write
Date: Fri, 17 Jan 2014 15:17:10 +0100
Message-ID: <1389968230-1224-2-git-send-email-kusmabite@gmail.com>
References: <1389968230-1224-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: msysgit+bncBDR53PPJ7YHRB47W4SLAKGQEHZZOU4I@googlegroups.com Fri Jan 17 15:17:24 2014
Return-path: <msysgit+bncBDR53PPJ7YHRB47W4SLAKGQEHZZOU4I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f57.google.com ([74.125.82.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB47W4SLAKGQEHZZOU4I@googlegroups.com>)
	id 1W4AEe-0002sw-HR
	for gcvm-msysgit@m.gmane.org; Fri, 17 Jan 2014 15:17:24 +0100
Received: by mail-wg0-f57.google.com with SMTP id l18sf546869wgh.2
        for <gcvm-msysgit@m.gmane.org>; Fri, 17 Jan 2014 06:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=9RuKKa62FzrfCdK5zDFIdC7+mWOJrX1na8CugNhhmdw=;
        b=ulULzW36J/FhxAXb7zbq2uF1xXBzJRhPUCqMLeUL1Al45pghwTWkNUYUnxYq4Kxub3
         ny49Y4XbGiiqYjc0Rq+avCn2PU3tDYkaJrKDioPy6cIrr4d4gRD2m05S3Afcq2gM3YWK
         V86bcT+kqJksaMN15//hfHwFoLmIqd5ZaIfC+Dadt+SsZD4vPcLZ/u5vaJhQtVWXLj/b
         jeGcWVKmlC8zjF1XThpNU2y1O86fbS02CCGvtNWyCRGznnVc2exBO3pxyPfsyIN7cE93
         ZuH/FDccCYyHQ3jvkT8UnyyIHM/lpBfAAkrvLsSmDfJfagfrHNS2CMhmrYI7V2gHN6ei
         PlfQ==
X-Received: by 10.152.3.67 with SMTP id a3mr18729laa.33.1389968244225;
        Fri, 17 Jan 2014 06:17:24 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.19.194 with SMTP id h2ls267002lae.43.gmail; Fri, 17 Jan
 2014 06:17:23 -0800 (PST)
X-Received: by 10.112.90.38 with SMTP id bt6mr975772lbb.1.1389968243352;
        Fri, 17 Jan 2014 06:17:23 -0800 (PST)
Received: from mail-la0-x22a.google.com (mail-la0-x22a.google.com [2a00:1450:4010:c03::22a])
        by gmr-mx.google.com with ESMTPS id rk7si1408919bkb.2.2014.01.17.06.17.23
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 06:17:23 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2a00:1450:4010:c03::22a as permitted sender) client-ip=2a00:1450:4010:c03::22a;
Received: by mail-la0-x22a.google.com with SMTP id hr13so1622141lab.29
        for <msysgit@googlegroups.com>; Fri, 17 Jan 2014 06:17:23 -0800 (PST)
X-Received: by 10.152.36.8 with SMTP id m8mr1243159laj.24.1389968243145;
        Fri, 17 Jan 2014 06:17:23 -0800 (PST)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPSA id mv9sm6872795lbc.0.2014.01.17.06.17.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 06:17:22 -0800 (PST)
X-Mailer: git-send-email 1.8.4.msysgit.0
In-Reply-To: <1389968230-1224-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2a00:1450:4010:c03::22a
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240598>

Since 0b6806b9 ("xread, xwrite: limit size of IO to 8MB"), this
wrapper is no longer needed, as read and write are already split
into small chunks.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c | 17 -----------------
 compat/mingw.h |  3 ---
 2 files changed, 20 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index fecb98b..e9892f8 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -304,23 +304,6 @@ int mingw_open (const char *filename, int oflags, ...)
 	return fd;
 }
 
-#undef write
-ssize_t mingw_write(int fd, const void *buf, size_t count)
-{
-	/*
-	 * While write() calls to a file on a local disk are translated
-	 * into WriteFile() calls with a maximum size of 64KB on Windows
-	 * XP and 256KB on Vista, no such cap is placed on writes to
-	 * files over the network on Windows XP.  Unfortunately, there
-	 * seems to be a limit of 32MB-28KB on X64 and 64MB-32KB on x86;
-	 * bigger writes fail on Windows XP.
-	 * So we cap to a nice 31MB here to avoid write failures over
-	 * the net without changing the number of WriteFile() calls in
-	 * the local case.
-	 */
-	return write(fd, buf, min(count, 31 * 1024 * 1024));
-}
-
 static BOOL WINAPI ctrl_ignore(DWORD type)
 {
 	return TRUE;
diff --git a/compat/mingw.h b/compat/mingw.h
index 92cd728..e033e72 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -180,9 +180,6 @@ int mingw_rmdir(const char *path);
 int mingw_open (const char *filename, int oflags, ...);
 #define open mingw_open
 
-ssize_t mingw_write(int fd, const void *buf, size_t count);
-#define write mingw_write
-
 int mingw_fgetc(FILE *stream);
 #define fgetc mingw_fgetc
 
-- 
1.8.4.msysgit.0

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
For more options, visit https://groups.google.com/groups/opt_out.
