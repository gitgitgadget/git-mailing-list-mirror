From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v6 03/11] trace: remove redundant printf format attribute
Date: Fri, 20 Jun 2014 23:05:10 +0200
Message-ID: <53A4A206.8070905@gmail.com>
References: <53A4A195.1070502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBBGESKOQKGQEKGEMFEA@googlegroups.com Fri Jun 20 23:05:10 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBBGESKOQKGQEKGEMFEA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f189.google.com ([209.85.217.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBBGESKOQKGQEKGEMFEA@googlegroups.com>)
	id 1Wy5zh-00045k-TM
	for gcvm-msysgit@m.gmane.org; Fri, 20 Jun 2014 23:05:09 +0200
Received: by mail-lb0-f189.google.com with SMTP id s7sf450329lbd.26
        for <gcvm-msysgit@m.gmane.org>; Fri, 20 Jun 2014 14:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=q5htMi6UxP9VlL8DwKX9os/jw/0VVx2l5VA74Vw6dRg=;
        b=gmyvwGwtxjoEO4pJEyncN0L28br8kogHAU+zhuxb4XfW7EJfAOMJCotRTwGuCy5YUh
         UpSIr4ApUDyVTt+VIUWYRXqa1gZaXER86mDk+iDQWRE+TRNVcdWtavLpmdnYzkWOTlBg
         k8espCFoS+u7dFDXO8e5Kdp3gglh680vje0DHUCRJiKks0aXr4aI86rp4euBedn1mPZn
         JAUN5dEuMqf6Sthd7gLuB50aA49YNS5CidycqSujSgjcFjP6lDEO9STmMVVVQetkaHRN
         kkpLRtcWJBSE73J4lZUlKEZE3Wn4xN2EkakTwSbFFGDt4J5sqeWVclSCp0D2Mc79dveC
         DXZA==
X-Received: by 10.152.2.228 with SMTP id 4mr20428lax.37.1403298309732;
        Fri, 20 Jun 2014 14:05:09 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.9.202 with SMTP id c10ls186965lab.16.gmail; Fri, 20 Jun
 2014 14:05:08 -0700 (PDT)
X-Received: by 10.112.149.162 with SMTP id ub2mr25013lbb.18.1403298308349;
        Fri, 20 Jun 2014 14:05:08 -0700 (PDT)
Received: from mail-we0-x234.google.com (mail-we0-x234.google.com [2a00:1450:400c:c03::234])
        by gmr-mx.google.com with ESMTPS id r13si226445wib.0.2014.06.20.14.05.08
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 14:05:08 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::234 as permitted sender) client-ip=2a00:1450:400c:c03::234;
Received: by mail-we0-f180.google.com with SMTP id x48so4382095wes.11
        for <msysgit@googlegroups.com>; Fri, 20 Jun 2014 14:05:08 -0700 (PDT)
X-Received: by 10.180.38.38 with SMTP id d6mr7002601wik.12.1403298308269;
        Fri, 20 Jun 2014 14:05:08 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id p3sm17899799wjw.13.2014.06.20.14.05.07
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 14:05:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53A4A195.1070502@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::234
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252282>

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
2.0.0.402.g13b8b25

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
