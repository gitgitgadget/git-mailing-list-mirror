From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] mingw: redefine the wrapper macro after the
 corresponding function
Date: Fri, 06 Jun 2014 20:20:05 +0200
Message-ID: <53920655.6070207@gmail.com>
References: <20140605080519.GB28029@camelia.ucw.cz> <5390A139.2090406@kdbg.org> <5390E893.9060600@gmail.com> <20140606083233.GB1303@camelia.ucw.cz> <53918D27.7060604@gmail.com> <20140606111028.GA1909@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>, GIT Mailing-list <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCH3XYXLXQDBBU4MZCOAKGQESOIT4VY@googlegroups.com Fri Jun 06 20:20:05 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBU4MZCOAKGQESOIT4VY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f63.google.com ([74.125.82.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBU4MZCOAKGQESOIT4VY@googlegroups.com>)
	id 1WsykG-00029P-7m
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 20:20:04 +0200
Received: by mail-wg0-f63.google.com with SMTP id x12sf75975wgg.18
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 11:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=/viQYxD5Y+Uibw/t5wN1UgB90fEHzLT0/W6ID3NVbsE=;
        b=LLO7icAGVWxznBs4kofNWg69wUMOeTwPImVjTMKBvGHYNT2IRcWYM1lZRaCz0n3Qeg
         LORPSYz0mhXJEAQMYOrlYPNzF6+kvIbT+/Zi6IkqewuTlRGOLNPpQZVgGP8luxdBMbwo
         awXEZDuidSorqVpBPRY0tmz5yW81qs1JVtEEJLufmVP8b9Txz1Bh/2JKhfg7TuRZrg0x
         cGuJL7w+6UegZOAACUucK/rLPxY4x2HYLG8gdR4RaLOm0jzipI+nEh3+agy43ll/k/Q1
         9/HgoJfQ+7Ufpbkl1wvTuFOPIMLK6FbZq35MZ0e0tooH39TMp4nLRR3+zQZYdw4qlJTW
         5YFQ==
X-Received: by 10.180.89.99 with SMTP id bn3mr31758wib.11.1402078803952;
        Fri, 06 Jun 2014 11:20:03 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.182.198 with SMTP id eg6ls146112wic.32.canary; Fri, 06 Jun
 2014 11:20:02 -0700 (PDT)
X-Received: by 10.14.218.9 with SMTP id j9mr2107570eep.2.1402078802895;
        Fri, 06 Jun 2014 11:20:02 -0700 (PDT)
Received: from mail-wi0-x22a.google.com (mail-wi0-x22a.google.com [2a00:1450:400c:c05::22a])
        by gmr-mx.google.com with ESMTPS id e12si1759196wiv.1.2014.06.06.11.20.02
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 11:20:02 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22a as permitted sender) client-ip=2a00:1450:400c:c05::22a;
Received: by mail-wi0-x22a.google.com with SMTP id bs8so1452046wib.1
        for <msysgit@googlegroups.com>; Fri, 06 Jun 2014 11:20:02 -0700 (PDT)
X-Received: by 10.14.4.199 with SMTP id 47mr1524331eej.9.1402078802786;
        Fri, 06 Jun 2014 11:20:02 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id l49sm24441626eef.27.2014.06.06.11.20.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 11:20:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140606111028.GA1909@camelia.ucw.cz>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22a
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250955>

Am 06.06.2014 13:10, schrieb Stepan Kasal:
> Hi Karsten,
> 
> On Fri, Jun 06, 2014 at 11:43:03AM +0200, Karsten Blees wrote:
>> Thinking about this some more, the best solution is probably to
>> eliminate the problem altogether by adding inline-wrappers for
>> required CRT-functions, e.g.:
> 
> Yes, this is acceptable.  But I wouldn't pollute mingw.h.  You can do
> it on top of mingw.c like this:

But having it in the .h file may come in handy if we want to split the overlong mingw.c into several compilation units...

> 
> #undef gethostname
> static inline int crt_gethostname(char *host, int namelen)
> {
> 	return gethostname(host, namelen);
> }
> #define gethostname please_call_the_mingw_or_crt_version
> 

Now you're mixing all three variants...note that with my suggestion to #define crt_foo in mingw.h, you don't need '#undef foo', nor redefine foo (your variant), nor rename other callers in mingw.c to 'mingw_foo' (Hannes' variant).

Callers of foo() would simply write "foo()", no matter whether in mingw.c or anywhere else. In the special case that you really want the CRT version, you'd write crt_foo(). This works everywhere, even in core-git code wrapped in #ifdef GIT_WINDOWS_NATIVE.

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
