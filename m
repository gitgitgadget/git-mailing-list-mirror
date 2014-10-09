From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5] MinGW(-W64) compilation
Date: Thu, 9 Oct 2014 12:11:01 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1410091205560.990@s15462909.onlinehome-server.info>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org, gister@pobox.com, msysGit <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBCZPH74Q5YNRBON63GQQKGQEBBXZEQQ@googlegroups.com Thu Oct 09 12:11:08 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBON63GQQKGQEBBXZEQQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f59.google.com ([74.125.82.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBON63GQQKGQEBBXZEQQ@googlegroups.com>)
	id 1XcAgc-0001BD-Se
	for gcvm-msysgit@m.gmane.org; Thu, 09 Oct 2014 12:11:06 +0200
Received: by mail-wg0-f59.google.com with SMTP id m15sf84125wgh.14
        for <gcvm-msysgit@m.gmane.org>; Thu, 09 Oct 2014 03:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=FzE2G/lGNvlxosRaAP5cei1KV96QpMJC6x3pVtZ53Vk=;
        b=EreyYSB9uhC1ZLJwbdcMys/IeKF2xhTXK1WQM/OWOL7x7NbBLkG9l0Nnb5ZFlbW5We
         wrX6A21IYjbkysGzPfa2Dm2ioPscEH8qy3E0wzf5S8yVOdQ1/nn5WpoFCnx1c0tdRXnX
         FH/r9cckG5QwSZLC7PS9va3djjodNZIunzmU1fkttRArIxvvj+wFk2RblNK//lg/ji7B
         zcgTHrLwU/Xd9y5KGxEOXqxp5Iw+W86bzFSiqCaxez/HJUQVDSptEHbuCncdVR6np/XC
         EAJrvHetWXM6aJYjNDt8/20elz/jcJzEYVs3gUXRJKrlBw6/2WbPjz2SbN6EuSTuRCqI
         PgKw==
X-Received: by 10.152.197.5 with SMTP id iq5mr502lac.36.1412849466585;
        Thu, 09 Oct 2014 03:11:06 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.3.132 with SMTP id c4ls138283lac.88.gmail; Thu, 09 Oct
 2014 03:11:04 -0700 (PDT)
X-Received: by 10.152.1.136 with SMTP id 8mr1329058lam.5.1412849464763;
        Thu, 09 Oct 2014 03:11:04 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.21])
        by gmr-mx.google.com with ESMTPS id rb5si428099lbb.0.2014.10.09.03.11.04
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Oct 2014 03:11:04 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as permitted sender) client-ip=212.227.17.21;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0MVrQS-1Xii8U1oiG-00WzxC;
 Thu, 09 Oct 2014 12:11:02 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:M2r4FvBae0nBop1HLD71ha4eQAGII27WOhIGDLT0pmWEs3GUXBS
 d2RRBZA8qllofTrBrsmzyFnKGB1cjg2Vl6yOWlQa9iRSinihVOGVQj7sCqffiUzrbn61OO1
 3hHq2XF/3fIoY1XMz6Gp7qmVp1b2OviizvkVm2w0UDM1yD/hLfKMbPBimN+6fOtSESYZu4V
 G/Sn/PVTyqcuKVPfjcRFA==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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

Hi all,

On Wed, 8 Oct 2014, Marat Radchenko wrote:

> This patch series fixes building on modern MinGW and MinGW-W64
> (including x86_64).

To make it more convenient to work on this patch series using Git, I
pushed this branch to

	https://github.com/dscho/git/compare/git:master...w64-slonopotamus

I also added one patch I find highly convenient:

https://github.com/dscho/git/commit/29749c7d7b4638c63369d6cf067f5d524d0092f9

-- snipsnap --
Subject: [PATCH] MinGW-w64: Work around bug in MinGW-w64's winuser.h

This allows contributors to compile 64-bit Windows builds of Git without
forcing them to use an unstable version of MinGW-w64.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/poll/poll.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index 8941249..dcbcbaf 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -76,6 +76,18 @@
 
 #ifdef WIN32_NATIVE
 
+/*
+ * Work around https://sourceforge.net/p/mingw-w64/bugs/397. In short, some
+ * definitions were put into the GUI-only section of winuser.h by mistake
+ * in MinGW-w64 versions up to 3.1.0.
+ */
+#ifndef QS_ALLINPUT
+#define QS_ALLINPUT 0xff
+extern WINUSERAPI DWORD WINAPI MsgWaitForMultipleObjects(DWORD nCount,
+	CONST HANDLE *pHandles, WINBOOL fWaitAll, DWORD dwMilliseconds,
+	DWORD dwWakeMask);
+#endif
+
 #define IsConsoleHandle(h) (((intptr_t) (h) & 3) == 3)
 
 static BOOL
-- 
2.0.0.rc3.9669.g840d1f9


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
