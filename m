From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH] mingw: redefine the wrapper macro after the
 corresponding function
Date: Thu, 5 Jun 2014 10:05:19 +0200
Organization: <)><
Message-ID: <20140605080519.GB28029@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBQGJYCOAKGQEDFAL3XA@googlegroups.com Thu Jun 05 10:05:22 2014
Return-path: <msysgit+bncBCU63DXMWULRBQGJYCOAKGQEDFAL3XA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f187.google.com ([209.85.217.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBQGJYCOAKGQEDFAL3XA@googlegroups.com>)
	id 1WsSfp-0004w3-1B
	for gcvm-msysgit@m.gmane.org; Thu, 05 Jun 2014 10:05:21 +0200
Received: by mail-lb0-f187.google.com with SMTP id z11sf60484lbi.4
        for <gcvm-msysgit@m.gmane.org>; Thu, 05 Jun 2014 01:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:mime-version:organization
         :user-agent:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=QDNrHTcgYBmfyrgfjkPeNwjE8VzQl13rnNKxw9rkZ60=;
        b=gWs6yxXPhRSrT9399opr6HTyREC5tXvhgGOyMOfUR320tYMs+gK0E2rmMtO38wljAS
         AMONK8BRdE1RgIYax0OmsTTALifmwXv3rWmikBLmwMvHjDk2OggOjfAhPzm5tmB7prwZ
         /Ew7bAuo2oZQ69lp88dCXL1Kq6WytN2EHtnoq8UqD8udFsTmmbOEqEswfzQym8hD57Ey
         AxkyreyuWeaLi2xAPDoRsg1nakyEgO+s2jXYIuUV3zAGivNOksNbI7RvNBAvArzymU5+
         aB4/AVlFf0ct5lodx2spEPZhx6GgKmSGepdapNLySKSsADTXcm5U+qVft87YhFFKIghj
         TqBw==
X-Received: by 10.152.2.40 with SMTP id 8mr41930lar.12.1401955520802;
        Thu, 05 Jun 2014 01:05:20 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.36.227 with SMTP id t3ls21893laj.11.gmail; Thu, 05 Jun
 2014 01:05:19 -0700 (PDT)
X-Received: by 10.112.73.232 with SMTP id o8mr6448077lbv.0.1401955519769;
        Thu, 05 Jun 2014 01:05:19 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id e12si1194589wiv.1.2014.06.05.01.05.19
        for <msysgit@googlegroups.com>;
        Thu, 05 Jun 2014 01:05:19 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 773681C009E;
	Thu,  5 Jun 2014 10:05:19 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s5585JZC028100;
	Thu, 5 Jun 2014 10:05:19 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s5585JAW028098;
	Thu, 5 Jun 2014 10:05:19 +0200
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250823>

mingw.c defines several wrapper functionsi, like mingw_unlink().
These wrappers are deployed by macros like this:
	#define unlink mingw_unlink
The function itself is preceded by #undef, leaving the wrapper out
of the game for the rest of mingw.c.

This was not probably intentional; for example, there are three
calls to open() below the definition mingw_open() that probably
have no reason to circumvent the wrapper.
OTOH, there is one call to gethostbyname() before it was undefined;
probably happy that it actually calls mingw_gethostbyname().

This patch adds back the #define after each wrapper definition.

Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index a0e13bc..e7193c0 100644
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
@@ -629,6 +636,7 @@ char *mingw_getcwd(char *pointer, int len)
 			pointer[i] = '/';
 	return ret;
 }
+#define getcwd mingw_getcwd
 
 /*
  * See http://msdn2.microsoft.com/en-us/library/17w5ykft(vs.71).aspx
@@ -1183,6 +1191,7 @@ char *mingw_getenv(const char *name)
 	}
 	return result;
 }
+#define getenv mingw_getenv
 
 /*
  * Note, this isn't a complete replacement for getaddrinfo. It assumes
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
