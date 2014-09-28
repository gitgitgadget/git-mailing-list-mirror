From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 02/14] MSVC: config.mak.uname: drop
 -D__USE_MINGW_ACCESS from CFLAGS
Date: Sun, 28 Sep 2014 17:24:18 +0400
Message-ID: <1411910670-31285-3-git-send-email-marat@slonopotamus.org>
References: <1411910670-31285-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBYEYUCQQKGQEZOHTT6I@googlegroups.com Sun Sep 28 15:25:55 2014
Return-path: <msysgit+bncBCE7TAPITACRBYEYUCQQKGQEZOHTT6I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f56.google.com ([74.125.82.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBYEYUCQQKGQEZOHTT6I@googlegroups.com>)
	id 1XYEU5-0000Aq-4C
	for gcvm-msysgit@m.gmane.org; Sun, 28 Sep 2014 15:25:53 +0200
Received: by mail-wg0-f56.google.com with SMTP id m15sf135938wgh.21
        for <gcvm-msysgit@m.gmane.org>; Sun, 28 Sep 2014 06:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=jPGRf0ZTYyUquq6F2Dp3g8Qj6zQo8il8ttrOVx40Lr8=;
        b=J43yD9tl4dz/GJ0I4siMTd1FfJTi+Z2SLzeh71pLQZuaYNGbr9A8+O7f9jWQOXKjSw
         x3g+tn48QlJMdfzKfTvbUwor7ehzkHggpJtuhr6HVkdBVyqAXY5BnK3Gkr1zKoDDSXJv
         TrST2mI+IEbkkXQocD2Onmom8liOBKdEXbCX2HLXw3QRUHqIbJNN2hmmverc6ZEpe3WW
         KZKx7ETals7jHRRzsfIQCM5AlIZvEeiLkbfJlgsNgiAI1bxjkuy+e6tKoDX8ryAGK0rE
         Kv5z7VYqpYjSfSfD76jFJQrFeCJglZ2ycqyLhJBqiDZTg0mre7txhYFwzIOfEtW1wCDt
         J65Q==
X-Received: by 10.180.76.208 with SMTP id m16mr302732wiw.12.1411910752618;
        Sun, 28 Sep 2014 06:25:52 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.10.200 with SMTP id k8ls315128wib.24.canary; Sun, 28 Sep
 2014 06:25:51 -0700 (PDT)
X-Received: by 10.180.221.236 with SMTP id qh12mr821795wic.4.1411910751884;
        Sun, 28 Sep 2014 06:25:51 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id j12si422511wie.2.2014.09.28.06.25.51
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 06:25:51 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYEU1-0000Yl-Jx; Sun, 28 Sep 2014 17:25:49 +0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1411910670-31285-1-git-send-email-marat@slonopotamus.org>
X-Original-Sender: marat@slonopotamus.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: marat@slonopotamus.org does not designate permitted sender
 hosts) smtp.mail=marat@slonopotamus.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257598>

-D__USE_MINGW_ACCESS only affects MinGW and does nothing when
MSVC is used.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
Acked-by: Eric Faye-Lund <kusmabite@gmail.com>
---
 config.mak.uname | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index a2f380f..20cbdcf 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -368,7 +368,7 @@ ifeq ($(uname_S),Windows)
 	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/dirent.o
-	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
+	COMPAT_CFLAGS = -DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE
 	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib invalidcontinue.obj
 	PTHREAD_LIBS =
-- 
2.1.1

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
