From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 4/5] Win32 dirent: clarify #include directives
Date: Fri,  6 Jun 2014 22:15:43 +0200
Message-ID: <1402085744-15829-5-git-send-email-kasal@ucw.cz>
References: <5391ED57.1000601@gmail.com>
 <1402085744-15829-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB6OCZCOAKGQEVG45WZQ@googlegroups.com Fri Jun 06 22:16:02 2014
Return-path: <msysgit+bncBCU63DXMWULRB6OCZCOAKGQEVG45WZQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f57.google.com ([209.85.215.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB6OCZCOAKGQEVG45WZQ@googlegroups.com>)
	id 1Wt0YM-0005KG-1W
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 22:15:54 +0200
Received: by mail-la0-f57.google.com with SMTP id hr17sf408836lab.2
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 13:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=hrm4JGX65f71vbmkc3iRbG684lo4OwRFvfT/A3V7OhE=;
        b=aDJZp6wdEfQuXwu8aEMCOqymDqwEfeuK01IwVpGMHpf55SMJuB6KcGFYBg9kHywuWd
         l/jIRy0b+A9ydD0PfN/SxlrVo6GlNZBMMDiWCgbsfWTw/tsPYG8GUtssdw7aTbXZeB7+
         xEB7ZeummaUE4zcpRJYi2JIOkkwlYRRrdwVpCBohx0rk1BFeAQz9s+X+q0LBtgFoXgbN
         rMF8dFvyUFgUGYNc67rXafrcYI8abuOtXxUqt7F5pzLzRj3X94uVzAfngp44xg5LBZYJ
         Sv09AOwUa18pzh7RWwTzqVFTO8UoCS9rmhjFKA8ehbu/5q8D1+69Vy4R9+kStOE3qo+x
         EAnw==
X-Received: by 10.152.2.131 with SMTP id 3mr47900lau.18.1402085753866;
        Fri, 06 Jun 2014 13:15:53 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.43.228 with SMTP id z4ls161856lal.65.gmail; Fri, 06 Jun
 2014 13:15:52 -0700 (PDT)
X-Received: by 10.112.155.67 with SMTP id vu3mr2082134lbb.9.1402085752938;
        Fri, 06 Jun 2014 13:15:52 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id e12si1787922wiv.1.2014.06.06.13.15.52
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 13:15:52 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id BDE8F1C00AC; Fri,  6 Jun 2014 22:15:52 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402085744-15829-1-git-send-email-kasal@ucw.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250965>

From: Karsten Blees <blees@dcon.de>
Date: Fri, 7 Jan 2011 17:47:41 +0100

Git-compat-util.h is two dirs up, and already includes <dirent.h> (which
is the same as "dirent.h" due to -Icompat/win32 in the Makefile).

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/win32/dirent.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/compat/win32/dirent.c b/compat/win32/dirent.c
index 7a0debe..fac7f25 100644
--- a/compat/win32/dirent.c
+++ b/compat/win32/dirent.c
@@ -1,5 +1,4 @@
-#include "../git-compat-util.h"
-#include "dirent.h"
+#include "../../git-compat-util.h"
 
 struct DIR {
 	struct dirent dd_dir; /* includes d_type */
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
