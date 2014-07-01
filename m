From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v7 03/16] trace: remove redundant printf format attribute
Date: Wed, 02 Jul 2014 00:56:34 +0200
Message-ID: <53B33CA2.3020405@gmail.com>
References: <53B33C05.5090900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBIXZZSOQKGQEKTGSN2Y@googlegroups.com Wed Jul 02 00:56:36 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBIXZZSOQKGQEKTGSN2Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f60.google.com ([74.125.82.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBIXZZSOQKGQEKTGSN2Y@googlegroups.com>)
	id 1X26yZ-0001GA-4Y
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2014 00:56:35 +0200
Received: by mail-wg0-f60.google.com with SMTP id n12sf1091131wgh.25
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 Jul 2014 15:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=676ONpt0EAsumYatI9egoqQvhfAlZxgygcKcTA+Z8r4=;
        b=T1fhubzCiEhS0N2BevmHJjoe94AqIyyomUmhPpP75AA3Cjaxx8HPRRX1LBWxqKKexz
         mE2wIvH0ZLQHX6sEpcrVo/NcUZlUDyOwtWifpdIzsWZqBzDhc2ifIMAQTJYv7wlm3AhF
         tmjwNIIOl83B5UV3ngH9ov+nOfDDhsJedKKnu3uofotKkwIp7aFHKehjdDWdw0X8Hx8C
         0h/xEJjwA1L30tn+M2bnVIbOBwfv4IsK69ehsg2vdWBrmTKDU/RUeKllZxRfPikPYSnH
         xYp0XCZjakXyka3F1BIoeZYHM0BB6l4xxq/96+vVJTKmtdG0dOnp25yMt2WncFA6ISVb
         kwLg==
X-Received: by 10.152.36.201 with SMTP id s9mr34066laj.32.1404255394797;
        Tue, 01 Jul 2014 15:56:34 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.4.194 with SMTP id m2ls404369lam.42.gmail; Tue, 01 Jul
 2014 15:56:33 -0700 (PDT)
X-Received: by 10.152.37.100 with SMTP id x4mr634886laj.6.1404255393863;
        Tue, 01 Jul 2014 15:56:33 -0700 (PDT)
Received: from mail-wg0-x231.google.com (mail-wg0-x231.google.com [2a00:1450:400c:c00::231])
        by gmr-mx.google.com with ESMTPS id b9si329137wic.2.2014.07.01.15.56.33
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 15:56:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::231 as permitted sender) client-ip=2a00:1450:400c:c00::231;
Received: by mail-wg0-f49.google.com with SMTP id y10so10326099wgg.8
        for <msysgit@googlegroups.com>; Tue, 01 Jul 2014 15:56:33 -0700 (PDT)
X-Received: by 10.180.97.195 with SMTP id ec3mr378467wib.13.1404255393783;
        Tue, 01 Jul 2014 15:56:33 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id oy4sm50976078wjb.41.2014.07.01.15.56.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 15:56:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B33C05.5090900@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::231
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252751>

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
2.0.0.406.ge74f8ff

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
