From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH v2] mingw: redefine the wrapper macro after the
 corresponding function
Date: Fri, 6 Jun 2014 10:41:22 +0200
Organization: <)><
Message-ID: <20140606084122.GC1303@camelia.ucw.cz>
References: <20140605080519.GB28029@camelia.ucw.cz> <5390A139.2090406@kdbg.org> <5390E893.9060600@gmail.com> <20140606083233.GB1303@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>, GIT Mailing-list <git@vger.kernel.org>,
        msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCU63DXMWULRBNH5YWOAKGQE52IBIXY@googlegroups.com Fri Jun 06 10:41:27 2014
Return-path: <msysgit+bncBCU63DXMWULRBNH5YWOAKGQE52IBIXY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f56.google.com ([209.85.215.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBNH5YWOAKGQE52IBIXY@googlegroups.com>)
	id 1WspiG-0000uG-Uo
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 10:41:24 +0200
Received: by mail-la0-f56.google.com with SMTP id mc6sf251753lab.1
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 01:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=FMcsEt77p1orRpldtG5LMK13vxmyXphqSNHlfhvhMkY=;
        b=smxV4S+1wQWk6Z+efqwbYLkqGkKKObef8U1YLXW0QKhlAUohQCVwVqmWdqpZQMxCwr
         g29oNsguQu/NKVobgLBrXcU5yUdWo3+cHTXyJQ61tV+wuZdi1fSCTHLS3kfQXyh/dXyk
         mdrU0Bn6xPlM9V7DmefI76ZtBlZOe6z3LZl5h2BozuQkRjUYzCeyUy7OvBmtmADzaMCn
         YAftT5utMRJ9t5EgcmLRrEStGdwVtGYcFfdLXEeiskApVYV8ThBRGqe962G2RynBgOm5
         lhhdIt1ck6XDhS8lD2hySNApb7kf1McIrM0Gj/vlgkuC7viL4r+u+9uCh6UEZgPZ3jEP
         lQKg==
X-Received: by 10.152.88.65 with SMTP id be1mr2006lab.35.1402044084718;
        Fri, 06 Jun 2014 01:41:24 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.197.1 with SMTP id iq1ls91109lac.18.gmail; Fri, 06 Jun
 2014 01:41:23 -0700 (PDT)
X-Received: by 10.112.89.10 with SMTP id bk10mr1115774lbb.5.1402044083589;
        Fri, 06 Jun 2014 01:41:23 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id eh2si1227762wib.2.2014.06.06.01.41.23
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 01:41:23 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 2C3FA1C009B;
	Fri,  6 Jun 2014 10:41:23 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s568fMA1001524;
	Fri, 6 Jun 2014 10:41:22 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s568fMXD001523;
	Fri, 6 Jun 2014 10:41:22 +0200
In-Reply-To: <20140606083233.GB1303@camelia.ucw.cz>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250894>

>From 624d15bd5d2d06035abc17415127a7cf37b5f981 Mon Sep 17 00:00:00 2001
From: Stepan Kasal <kasal@ucw.cz>
Date: Thu, 5 Jun 2014 09:17:17 +0200

mingw.c defines several wrapper functions, e.g., mingw_unlink().
These wrappers are deployed by macros like this:
	#define unlink mingw_unlink
The mingw_foo() wrapper often calls the original function, so it has
to be #undef'ed at that place.

But for the rest of mingw.c, if the function is used, the user probably
meant the fixed functionality.  So it is safer to redefine the macro
back.

Nonetheless, it is preferable to call mingw_foo() explicitly throughout
mingw.c itself.

Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index a0e13bc..ee83211 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -224,6 +224,7 @@ int mingw_unlink(const char *pathname)
 	       ret = unlink(pathname);
 	return ret;
 }
+#define unlink mingw_unlink
 
 static int is_dir_empty(const char *path)
 {
@@ -279,6 +280,7 @@ int mingw_rmdir(const char *pathname)
 	       ret = rmdir(pathname);
 	return ret;
 }
+#define rmdir mingw_rmdir
 
 #undef open
 int mingw_open (const char *filename, int oflags, ...)
@@ -303,6 +305,7 @@ int mingw_open (const char *filename, int oflags, ...)
 	}
 	return fd;
 }
+#define open mingw_open
 
 static BOOL WINAPI ctrl_ignore(DWORD type)
 {
@@ -328,6 +331,7 @@ int mingw_fgetc(FILE *stream)
 	SetConsoleCtrlHandler(ctrl_ignore, FALSE);
 	return ch;
 }
+#define fgetc mingw_fgetc
 
 #undef fopen
 FILE *mingw_fopen (const char *filename, const char *otype)
@@ -336,6 +340,7 @@ FILE *mingw_fopen (const char *filename, const char *otype)
 		filename = "nul";
 	return fopen(filename, otype);
 }
+#define fopen mingw_fopen
 
 #undef freopen
 FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream)
@@ -344,6 +349,7 @@ FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream)
 		filename = "nul";
 	return freopen(filename, otype, stream);
 }
+#define freopen mingw_freopen
 
 #undef fflush
 int mingw_fflush(FILE *stream)
@@ -366,6 +372,7 @@ int mingw_fflush(FILE *stream)
 
 	return ret;
 }
+#define fflush mingw_fflush
 
 /*
  * The unit of FILETIME is 100-nanoseconds since January 1, 1601, UTC.
@@ -525,7 +532,7 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
 		SetFileAttributes(file_name, attrs & ~FILE_ATTRIBUTE_READONLY);
 	}
 
-	if ((fh = open(file_name, O_RDWR | O_BINARY)) < 0) {
+	if ((fh = mingw_open(file_name, O_RDWR | O_BINARY)) < 0) {
 		rc = -1;
 		goto revert_attrs;
 	}
@@ -564,7 +571,7 @@ int mkstemp(char *template)
 	char *filename = mktemp(template);
 	if (filename == NULL)
 		return -1;
-	return open(filename, O_RDWR | O_CREAT, 0600);
+	return mingw_open(filename, O_RDWR | O_CREAT, 0600);
 }
 
 int gettimeofday(struct timeval *tv, void *tz)
@@ -629,6 +636,7 @@ char *mingw_getcwd(char *pointer, int len)
 			pointer[i] = '/';
 	return ret;
 }
+#define getcwd mingw_getcwd
 
 /*
  * See http://msdn2.microsoft.com/en-us/library/17w5ykft(vs.71).aspx
@@ -700,7 +708,7 @@ static const char *parse_interpreter(const char *cmd)
 	if (n >= 4 && !strcasecmp(cmd+n-4, ".exe"))
 		return NULL;
 
-	fd = open(cmd, O_RDONLY);
+	fd = mingw_open(cmd, O_RDONLY);
 	if (fd < 0)
 		return NULL;
 	n = read(fd, buf, sizeof(buf)-1);
@@ -1183,6 +1191,7 @@ char *mingw_getenv(const char *name)
 	}
 	return result;
 }
+#define getenv mingw_getenv
 
 /*
  * Note, this isn't a complete replacement for getaddrinfo. It assumes
@@ -1199,7 +1208,7 @@ static int WSAAPI getaddrinfo_stub(const char *node, const char *service,
 	struct sockaddr_in *sin;
 
 	if (node) {
-		h = gethostbyname(node);
+		h = mingw_gethostbyname(node);
 		if (!h)
 			return WSAGetLastError();
 	}
@@ -1366,6 +1375,7 @@ int mingw_gethostname(char *name, int namelen)
     ensure_socket_initialization();
     return gethostname(name, namelen);
 }
+#define gethostname mingw_gethostname
 
 #undef gethostbyname
 struct hostent *mingw_gethostbyname(const char *host)
@@ -1373,6 +1383,7 @@ struct hostent *mingw_gethostbyname(const char *host)
 	ensure_socket_initialization();
 	return gethostbyname(host);
 }
+#define gethostbyname mingw_gethostbyname
 
 void mingw_freeaddrinfo(struct addrinfo *res)
 {
@@ -1429,6 +1440,7 @@ int mingw_connect(int sockfd, struct sockaddr *sa, size_t sz)
 	SOCKET s = (SOCKET)_get_osfhandle(sockfd);
 	return connect(s, sa, sz);
 }
+#define connect mingw_connect
 
 #undef bind
 int mingw_bind(int sockfd, struct sockaddr *sa, size_t sz)
@@ -1436,6 +1448,7 @@ int mingw_bind(int sockfd, struct sockaddr *sa, size_t sz)
 	SOCKET s = (SOCKET)_get_osfhandle(sockfd);
 	return bind(s, sa, sz);
 }
+#define bind mingw_bind
 
 #undef setsockopt
 int mingw_setsockopt(int sockfd, int lvl, int optname, void *optval, int optlen)
@@ -1443,6 +1456,7 @@ int mingw_setsockopt(int sockfd, int lvl, int optname, void *optval, int optlen)
 	SOCKET s = (SOCKET)_get_osfhandle(sockfd);
 	return setsockopt(s, lvl, optname, (const char*)optval, optlen);
 }
+#define setsockopt mingw_setsockopt
 
 #undef shutdown
 int mingw_shutdown(int sockfd, int how)
@@ -1450,6 +1464,7 @@ int mingw_shutdown(int sockfd, int how)
 	SOCKET s = (SOCKET)_get_osfhandle(sockfd);
 	return shutdown(s, how);
 }
+#define shutdown mingw_shutdown
 
 #undef listen
 int mingw_listen(int sockfd, int backlog)
@@ -1457,6 +1472,7 @@ int mingw_listen(int sockfd, int backlog)
 	SOCKET s = (SOCKET)_get_osfhandle(sockfd);
 	return listen(s, backlog);
 }
+#define listen mingw_listen
 
 #undef accept
 int mingw_accept(int sockfd1, struct sockaddr *sa, socklen_t *sz)
@@ -1475,6 +1491,7 @@ int mingw_accept(int sockfd1, struct sockaddr *sa, socklen_t *sz)
 	}
 	return sockfd2;
 }
+#define accept mingw_accept
 
 #undef rename
 int mingw_rename(const char *pold, const char *pnew)
@@ -1530,6 +1547,7 @@ repeat:
 	errno = EACCES;
 	return -1;
 }
+#define rename mingw_rename
 
 /*
  * Note that this doesn't return the actual pagesize, but
@@ -1684,6 +1702,7 @@ sig_handler_t mingw_signal(int sig, sig_handler_t handler)
 
 	return old;
 }
+#define signal mingw_signal
 
 #undef raise
 int mingw_raise(int sig)
@@ -1709,6 +1728,7 @@ int mingw_raise(int sig)
 		return raise(sig);
 	}
 }
+#define raise mingw_raise
 
 
 static const char *make_backslash_path(const char *path)
-- 
2.0.0.9635.g0be03cb

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
