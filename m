From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v8 03/17] trace: remove redundant printf format attribute
Date: Sat, 12 Jul 2014 01:59:21 +0200
Message-ID: <53C07A59.3020702@gmail.com>
References: <53C079C5.8090503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBVXUQGPAKGQEPVYKUBQ@googlegroups.com Sat Jul 12 01:59:22 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBVXUQGPAKGQEPVYKUBQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f187.google.com ([209.85.217.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBVXUQGPAKGQEPVYKUBQ@googlegroups.com>)
	id 1X5kik-0008MT-SG
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2014 01:59:18 +0200
Received: by mail-lb0-f187.google.com with SMTP id n15sf187975lbi.24
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2014 16:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=Vk7bgwziwpM6RF9Hn66VR8lgPzNXD/p/nma/p1caFQs=;
        b=GuwNmLfP2uxT/2S+wM1C5TV7fyPa9m+MpY8wIZhfGsXGljmq6LOPWDso0Nagx36pQL
         EYC85EnE5ANdj7tdDE3mVd9/RhFeBAdg+Buam605Pip7Q0FaocMCmDeekyxD1j/QTiAs
         aPm0mGOjZtUkTgVQLtmc8NJ3gslTLJ27vlwX3UK3YWznzQIvoJA+kFdO8LcGHa899E7R
         K2jKWKyjeSWJFq7TshqWZQx4gLavAw3GJYP/kZcJZFa2k005i7n2KQeoFYY5Rx5diE7A
         88KJaWS2U6PZqGNNC8QGDMzZefZ2fh3ebPoTfQXUHZfmuR4UYCQnv6R7smXo6x4gDv4/
         DeMg==
X-Received: by 10.152.20.162 with SMTP id o2mr16459lae.18.1405123158701;
        Fri, 11 Jul 2014 16:59:18 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.153.6.9 with SMTP id cq9ls136664lad.24.gmail; Fri, 11 Jul 2014
 16:59:17 -0700 (PDT)
X-Received: by 10.112.142.106 with SMTP id rv10mr203428lbb.5.1405123157507;
        Fri, 11 Jul 2014 16:59:17 -0700 (PDT)
Received: from mail-wi0-x230.google.com (mail-wi0-x230.google.com [2a00:1450:400c:c05::230])
        by gmr-mx.google.com with ESMTPS id b9si4798wic.2.2014.07.11.16.59.17
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 16:59:17 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::230 as permitted sender) client-ip=2a00:1450:400c:c05::230;
Received: by mail-wi0-f176.google.com with SMTP id bs8so18401wib.9
        for <msysgit@googlegroups.com>; Fri, 11 Jul 2014 16:59:17 -0700 (PDT)
X-Received: by 10.194.48.103 with SMTP id k7mr2785062wjn.68.1405123157422;
        Fri, 11 Jul 2014 16:59:17 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id gi15sm8195026wjc.20.2014.07.11.16.59.16
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 16:59:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C079C5.8090503@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::230
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253358>

trace_printf_key() is the only non-static function that duplicates the
printf format attribute in the .c file, remove it for consistency.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.0.0.406.g2e9ef9b

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
