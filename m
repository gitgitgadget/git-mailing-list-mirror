From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH] fixup! Win32: Unicode environment (outgoing)
Date: Sat, 19 Jul 2014 21:13:02 +0200
Message-ID: <53CAC33E.9000009@gmail.com>
References: <1405611486-10176-1-git-send-email-kasal@ucw.cz> <1405611486-10176-3-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>, Karsten Blees <blees@dcon.de>
To: Stepan Kasal <kasal@ucw.cz>, GIT Mailing-list <git@vger.kernel.org>, 
 Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCH3XYXLXQDBBPMGVOPAKGQEPSARNFY@googlegroups.com Sat Jul 19 21:13:04 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBPMGVOPAKGQEPSARNFY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f189.google.com ([209.85.217.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBPMGVOPAKGQEPSARNFY@googlegroups.com>)
	id 1X8a46-0008JQ-NI
	for gcvm-msysgit@m.gmane.org; Sat, 19 Jul 2014 21:13:02 +0200
Received: by mail-lb0-f189.google.com with SMTP id l4sf575981lbv.26
        for <gcvm-msysgit@m.gmane.org>; Sat, 19 Jul 2014 12:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=9Sg+b4QH+hK4/7YSpUaRyARLiP/IBShr7VwFu6dhQlE=;
        b=LYA5eOGlHuwmjvrS+KYdC+gl00xHehzGA1EP6qAcuNPfsD9IPkSrYPF8IlM9JcReHr
         V6U8wQ4JzELUinpEIf+kVYPcedpyy0qYTQN8loFqcbMdfEP/blF1Jr06YNv0X8AOsmKk
         CigbqNZYtSeeysyAnZjfCwuSlZ8a+iG4Ifn+Kc4PoBX1w+dIvFs7EWwBtHPYXAzcNjVg
         wcxhkG068CBemg22IlvwQQjeryWa3bumVXuXiQGG6cxbrNeJCHfGFZJdG6PtdWw2GvM7
         7xiqEkyNS+uLZZpOSXucpM73gmAuZzn//QtxKttCPg2RgdPpvhctFPrwO/pd/0aksGXQ
         oBOw==
X-Received: by 10.152.219.35 with SMTP id pl3mr348lac.7.1405797182518;
        Sat, 19 Jul 2014 12:13:02 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.219.165 with SMTP id pp5ls325211lac.36.gmail; Sat, 19 Jul
 2014 12:13:01 -0700 (PDT)
X-Received: by 10.112.145.233 with SMTP id sx9mr1124665lbb.2.1405797181167;
        Sat, 19 Jul 2014 12:13:01 -0700 (PDT)
Received: from mail-wg0-x232.google.com (mail-wg0-x232.google.com [2a00:1450:400c:c00::232])
        by gmr-mx.google.com with ESMTPS id x7si354872wiw.1.2014.07.19.12.13.01
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 19 Jul 2014 12:13:01 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::232 as permitted sender) client-ip=2a00:1450:400c:c00::232;
Received: by mail-wg0-x232.google.com with SMTP id n12so4782460wgh.33
        for <msysgit@googlegroups.com>; Sat, 19 Jul 2014 12:13:01 -0700 (PDT)
X-Received: by 10.180.24.66 with SMTP id s2mr42300643wif.33.1405797181065;
        Sat, 19 Jul 2014 12:13:01 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id h3sm23883608wjn.10.2014.07.19.12.12.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 19 Jul 2014 12:13:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1405611486-10176-3-git-send-email-kasal@ucw.cz>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::232
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253906>

compat/mingw.c needs to #include "cache.h" for ALLOC_GROW.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 compat/mingw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index bd45950..c725a3e 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -4,6 +4,7 @@
 #include <wchar.h>
 #include "../strbuf.h"
 #include "../run-command.h"
+#include "../cache.h"
 
 static const int delay[] = { 0, 1, 10, 20, 40 };
 
-- 
2.0.2.897.g7f80809.dirty

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
