From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 4/5] Win32 dirent: clarify #include directives
Date: Fri,  6 Jun 2014 15:43:20 +0200
Message-ID: <1402062201-9709-5-git-send-email-kasal@ucw.cz>
References: <1402062201-9709-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBAMLY6OAKGQE5IXTXZI@googlegroups.com Fri Jun 06 15:43:40 2014
Return-path: <msysgit+bncBCU63DXMWULRBAMLY6OAKGQE5IXTXZI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f184.google.com ([209.85.212.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBAMLY6OAKGQE5IXTXZI@googlegroups.com>)
	id 1WsuQc-0000pB-Iy
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 15:43:30 +0200
Received: by mail-wi0-f184.google.com with SMTP id hi2sf17940wib.1
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 06:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=+5BTychrptt6wUWlNSsDo1Y5uXEV3tM9nEqnK6Sm9u8=;
        b=jg8cM0poqdWX0Exl/Qu1bCt1pq7mxPyczqDizFO3yyllCu4JSJb1dlUYwEWYYi/MRW
         ww5Px5RTl8uch7/lPHVl0FS1m9H7JMsz9NmKUytOlDhQX9VpzFkoAxcRKp7Z6KCYx3TF
         Anm3IKIlgFG7NLt85fTTHlJFe4m0En/zfz7ua5/nReJUqC/Oj8e0OSzKkYs6qfxmNoyN
         O6MjkL6N9u9tGPNtIOj4syjsdFHS+OEEtc5MlCt3Q1w/PLuu+ugUVK86G9tKlGlFONxf
         M9SMzPPq3//DFMQh5OQCOynWOgH7ppOTejP3ADVwX/mXX0SIzQ5+AIXNFvJ7O01A5wq/
         C1Lg==
X-Received: by 10.152.87.105 with SMTP id w9mr7633laz.31.1402062210279;
        Fri, 06 Jun 2014 06:43:30 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.19.166 with SMTP id g6ls118112lae.48.gmail; Fri, 06 Jun
 2014 06:43:29 -0700 (PDT)
X-Received: by 10.112.157.129 with SMTP id wm1mr1298353lbb.17.1402062209329;
        Fri, 06 Jun 2014 06:43:29 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id h4si1912407wib.2.2014.06.06.06.43.29
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 06:43:29 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 2CBE51C00A8; Fri,  6 Jun 2014 15:43:29 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402062201-9709-1-git-send-email-kasal@ucw.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250912>

From: Karsten Blees <blees@dcon.de>

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
