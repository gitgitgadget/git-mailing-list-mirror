From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 02/14] MSVC: config.mak.uname: drop
 -D__USE_MINGW_ACCESS from CFLAGS
Date: Tue, 30 Sep 2014 11:02:31 +0400
Message-ID: <1412060563-22041-3-git-send-email-marat@slonopotamus.org>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBJ5LVGQQKGQEXPGURRA@googlegroups.com Tue Sep 30 09:03:04 2014
Return-path: <msysgit+bncBCE7TAPITACRBJ5LVGQQKGQEXPGURRA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f64.google.com ([74.125.83.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBJ5LVGQQKGQEXPGURRA@googlegroups.com>)
	id 1XYrSh-0008SX-Tr
	for gcvm-msysgit@m.gmane.org; Tue, 30 Sep 2014 09:03:03 +0200
Received: by mail-ee0-f64.google.com with SMTP id d49sf648250eek.19
        for <gcvm-msysgit@m.gmane.org>; Tue, 30 Sep 2014 00:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=jPGRf0ZTYyUquq6F2Dp3g8Qj6zQo8il8ttrOVx40Lr8=;
        b=bR/mFIDyozTQzCAVrNOaRmZowULc7Ye9PC9144t8Q2i6Mx87oxoFgahIFVskN6XL8F
         41CkEXwjcNDNsI8Bd3GleoiopJFDt9NGjG+qD6cBTp1bohpG1GtrQM9QdRH9lJCar2eq
         XDqGlnJn8cQQXDuJnVRMsu95qz5u2Mka5zrECUxs9b7XXrjFAFxEwClIglOgi/64aOIa
         PlMJqh3a9zSmGkkILghYoyAjdQfMnT5KG+MtprJCUpgdyOG7N0nL+Wfq8Vd3RwvIAgDW
         b+kdZQp41w3Ge1Y4gT1dRd+asjvXol/LHbooWlN6so5Eif3CxgAIQ7Re7IR3L1JGNvIz
         xmUg==
X-Received: by 10.180.85.6 with SMTP id d6mr17465wiz.6.1412060583640;
        Tue, 30 Sep 2014 00:03:03 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.103.228 with SMTP id fz4ls6700wib.11.gmail; Tue, 30 Sep
 2014 00:03:03 -0700 (PDT)
X-Received: by 10.180.109.67 with SMTP id hq3mr910176wib.1.1412060583179;
        Tue, 30 Sep 2014 00:03:03 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id n6si742307wiv.0.2014.09.30.00.03.03
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Sep 2014 00:03:03 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYrSb-0004X0-Pk; Tue, 30 Sep 2014 11:02:58 +0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257649>

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
