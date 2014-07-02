From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v7 11/16] trace: add 'file:line' to all trace output
Date: Wed, 02 Jul 2014 21:05:52 +0200
Message-ID: <53B45810.9000806@gmail.com>
References: <53B33C05.5090900@gmail.com> <53B33DED.3030809@gmail.com> <xmqqionfh9lp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCH3XYXLXQDBBEFQ2GOQKGQERPEI5RA@googlegroups.com Wed Jul 02 21:05:59 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBEFQ2GOQKGQERPEI5RA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f183.google.com ([74.125.82.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBEFQ2GOQKGQERPEI5RA@googlegroups.com>)
	id 1X2Pqs-0002oX-9b
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2014 21:05:54 +0200
Received: by mail-we0-f183.google.com with SMTP id w61sf1219517wes.0
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2014 12:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=TdI0FFKo7rWNty7IJqLTLXJDwwM2br03zGS1tfT9MSI=;
        b=nm3G9Yf6PdVPrTG7wJJdegzgDs4gfSx91Qs47W2364Qbmzo7zY0i3IWQgFr2nK3979
         5a0kzG7U7Pgi+zSlT54ql+atOOgWd3OtsM/DVcyhfyWShFO56Y971nlZObCb6y1vNDgL
         9WTDUGJdFdRbYDIHzuONvyVgMaGaxFlf97x/KEPBOMBxiWbWlmXafcZVuNS01FaX546V
         u4WLEUFtK76UsHL5zLK2WnWE1JaLexWd8v0Zg7vyNxLbbNOta6QZ+lP3OxdD2k1H8vMV
         Kno6Im1YXuhAKqlXvbtI0K64mFOiN+xQttbXdx9oNE5eemNRvcFfVPhFFlgbWjLVkzYz
         EMXA==
X-Received: by 10.180.8.36 with SMTP id o4mr171726wia.3.1404327953903;
        Wed, 02 Jul 2014 12:05:53 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.79.4 with SMTP id f4ls810818wix.13.canary; Wed, 02 Jul
 2014 12:05:52 -0700 (PDT)
X-Received: by 10.180.212.12 with SMTP id ng12mr707644wic.7.1404327952438;
        Wed, 02 Jul 2014 12:05:52 -0700 (PDT)
Received: from mail-we0-x22e.google.com (mail-we0-x22e.google.com [2a00:1450:400c:c03::22e])
        by gmr-mx.google.com with ESMTPS id r13si983938wib.0.2014.07.02.12.05.52
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 02 Jul 2014 12:05:52 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22e as permitted sender) client-ip=2a00:1450:400c:c03::22e;
Received: by mail-we0-f174.google.com with SMTP id u57so11903342wes.33
        for <msysgit@googlegroups.com>; Wed, 02 Jul 2014 12:05:52 -0700 (PDT)
X-Received: by 10.180.73.106 with SMTP id k10mr44309943wiv.11.1404327952301;
        Wed, 02 Jul 2014 12:05:52 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id wz3sm56813886wjc.39.2014.07.02.12.05.51
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 02 Jul 2014 12:05:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqionfh9lp.fsf@gitster.dls.corp.google.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22e
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252831>

Am 02.07.2014 20:57, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> +#else
>> +
>> +/*
>> + * Macros to add file:line - see above for C-style declarations of how these
>> + * should be used.
>> + *
>> + * TRACE_CONTEXT may be set to __FUNCTION__ if the compiler supports it. The
>> + * default is __FILE__, as it is consistent with assert(), and static function
>> + * names are not necessarily unique.
>> + */
>> +#define TRACE_CONTEXT __FILE__
> 
> Hmph, seeing "may be set to" forces me to wonder how.  Perhaps #ifndef/#endif
> around it?
> 

Right, shame on me. I didn't think it would be important enough to warrant a
Makefile option, but #ifndef sure wouldn't hurt.

> Also, can it be set to something like __FILE__ ":" __FUNCTION__
> which may alleviate the alleged problem of "not necessarily unique"
> perhaps?
> 

Should work with MSVC. With GCC, however, __FUNCTION__ is a string constant
supplied by the compiler, so string literal concatenation doesn't work.

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
