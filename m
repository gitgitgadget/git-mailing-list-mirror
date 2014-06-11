From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v5 03/11] trace: remove redundant printf format attribute
Date: Wed, 11 Jun 2014 09:57:59 +0200
Message-ID: <53980C07.60406@gmail.com>
References: <53980B83.9050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
 Jeff King <peff@peff.net>
X-From: msysgit+bncBCH3XYXLXQDBBB4Y4COAKGQENRX4WSQ@googlegroups.com Wed Jun 11 09:58:03 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBB4Y4COAKGQENRX4WSQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f55.google.com ([209.85.215.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBB4Y4COAKGQENRX4WSQ@googlegroups.com>)
	id 1WudQ0-0005n5-KJ
	for gcvm-msysgit@m.gmane.org; Wed, 11 Jun 2014 09:58:00 +0200
Received: by mail-la0-f55.google.com with SMTP id el20sf976474lab.0
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Jun 2014 00:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=QUuqRmMYmzwdURrCr/njFn8Vzf/uUHk5+8KVzhnbRkc=;
        b=jDTa2P28viSngERq04B/O1IOiefVk2AuuiL15k+A0jJgoS2r78vM0NphdHeonBy3dt
         XjPuKHQ0RvFpF0Z9XKM+6tz67J/OgFhO7Ym64PVeQ1s3QnpfR27azjFKixZ+k8qBtD2C
         uJafyeLjyiEOBlZej98x9x/KuwrXrGWX/SGCx+ijKRkzhVz9nhfKVGGzTLFlGVw773Wm
         GF5ImEHVatvzMhhq4LkoLW+szq9q7UF4aAVUKFzqxu8OTKPzhPyfzJyevuc7f1buIVZC
         bjlToHvjeD89DU4BMJYsQhGH472HkqQcPEq4VZh+cqDARTwkpsYkzPinWznalsCnFvH6
         OHeg==
X-Received: by 10.180.95.98 with SMTP id dj2mr129187wib.3.1402473480391;
        Wed, 11 Jun 2014 00:58:00 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.91.225 with SMTP id ch1ls228877wib.25.gmail; Wed, 11 Jun
 2014 00:57:59 -0700 (PDT)
X-Received: by 10.181.13.133 with SMTP id ey5mr74947wid.0.1402473479461;
        Wed, 11 Jun 2014 00:57:59 -0700 (PDT)
Received: from mail-we0-x229.google.com (mail-we0-x229.google.com [2a00:1450:400c:c03::229])
        by gmr-mx.google.com with ESMTPS id h4si1257317wib.2.2014.06.11.00.57.59
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 00:57:59 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::229 as permitted sender) client-ip=2a00:1450:400c:c03::229;
Received: by mail-we0-f169.google.com with SMTP id t60so3421491wes.0
        for <msysgit@googlegroups.com>; Wed, 11 Jun 2014 00:57:59 -0700 (PDT)
X-Received: by 10.180.100.41 with SMTP id ev9mr45473457wib.22.1402473479356;
        Wed, 11 Jun 2014 00:57:59 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id 4sm57937045eeu.16.2014.06.11.00.57.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 00:57:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <53980B83.9050409@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::229
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251332>

trace_printf_key() is the only non-static function that duplicates the
printf format attribute in the .c file, remove it for consistency.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 trace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/trace.c b/trace.c
index 37a7fa9..3e31558 100644
--- a/trace.c
+++ b/trace.c
@@ -75,7 +75,6 @@ static void trace_vprintf(const char *key, const char *format, va_list ap)
 	strbuf_release(&buf);
 }
 
-__attribute__((format (printf, 2, 3)))
 void trace_printf_key(const char *key, const char *format, ...)
 {
 	va_list ap;
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
