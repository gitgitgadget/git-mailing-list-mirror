From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] mingw: redefine the wrapper macro after the
 corresponding function
Date: Fri, 06 Jun 2014 00:00:51 +0200
Message-ID: <5390E893.9060600@gmail.com>
References: <20140605080519.GB28029@camelia.ucw.cz> <5390A139.2090406@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>, Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCH3XYXLXQDBBEWRYOOAKGQEDUAKKXI@googlegroups.com Fri Jun 06 00:00:51 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBEWRYOOAKGQEDUAKKXI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f61.google.com ([74.125.82.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBEWRYOOAKGQEDUAKKXI@googlegroups.com>)
	id 1WsfiN-0007hv-0J
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 00:00:51 +0200
Received: by mail-wg0-f61.google.com with SMTP id m15sf211190wgh.16
        for <gcvm-msysgit@m.gmane.org>; Thu, 05 Jun 2014 15:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=WnVHRsLlSwJf2Xu0c7OGlw81q3IU6vdZPfb/lviaIRA=;
        b=I3AdGeBmy2P/4VxwJw5SSre2FkoTiPjzG8tIprBYUMZklcqd1+H6qR7zGRjTKV+5h+
         9q5ztXOa5LgtROUIH5Nb2InZCRnb4AwyEvtuw85pqY2ehpIxFbSKILb5SCNLRib5xJst
         RCcK8JTuX3lDo/RcE0ZIICj+CvvaaJ3XDT/SgI7Jxyd3lxWLXenTE9Lj15cS1nMduf+S
         cod8NBud9Bs7/pt2Oa81kSVlcq8gcA7EAchIvrA+V0u7JqhehLiJMBt9pnu5dMpoEwZm
         cIg6+yqj/6tICfHAYfM1l2Mk+zSJaQ8n9cl74dMqIm0wv9OqTkZIDTKPJukebS9CD9Y2
         czbw==
X-Received: by 10.152.42.211 with SMTP id q19mr6779lal.6.1402005650752;
        Thu, 05 Jun 2014 15:00:50 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.28.101 with SMTP id a5ls82461lah.100.gmail; Thu, 05 Jun
 2014 15:00:49 -0700 (PDT)
X-Received: by 10.112.40.1 with SMTP id t1mr295957lbk.19.1402005649943;
        Thu, 05 Jun 2014 15:00:49 -0700 (PDT)
Received: from mail-wi0-x231.google.com (mail-wi0-x231.google.com [2a00:1450:400c:c05::231])
        by gmr-mx.google.com with ESMTPS id e12si1487716wiv.1.2014.06.05.15.00.49
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 15:00:49 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::231 as permitted sender) client-ip=2a00:1450:400c:c05::231;
Received: by mail-wi0-f177.google.com with SMTP id f8so4339174wiw.4
        for <msysgit@googlegroups.com>; Thu, 05 Jun 2014 15:00:49 -0700 (PDT)
X-Received: by 10.14.173.9 with SMTP id u9mr223465eel.39.1402005649847;
        Thu, 05 Jun 2014 15:00:49 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id i4sm17676735eeg.28.2014.06.05.15.00.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 15:00:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <5390A139.2090406@kdbg.org>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::231
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250869>

Am 05.06.2014 18:56, schrieb Johannes Sixt:
> Am 05.06.2014 10:05, schrieb Stepan Kasal:
>> mingw.c defines several wrapper functionsi, like mingw_unlink().
>> These wrappers are deployed by macros like this:
>> 	#define unlink mingw_unlink
>> The function itself is preceded by #undef, leaving the wrapper out
>> of the game for the rest of mingw.c.
>>
>> This was not probably intentional; for example, there are three
>> calls to open() below the definition mingw_open() that probably
>> have no reason to circumvent the wrapper.
>> OTOH, there is one call to gethostbyname() before it was undefined;
>> probably happy that it actually calls mingw_gethostbyname().
>>
>> This patch adds back the #define after each wrapper definition.
>>
>> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
>> ---
>>  compat/mingw.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/compat/mingw.c b/compat/mingw.c
>> index a0e13bc..e7193c0 100644
>> --- a/compat/mingw.c
>> +++ b/compat/mingw.c
>> @@ -224,6 +224,7 @@ int mingw_unlink(const char *pathname)
>>  	       ret = unlink(pathname);
>>  	return ret;
>>  }
>> +#define unlink mingw_unlink
> (etc...)
> 
> I don't particularly like this approach: It robs the precise control of
> which function we can invoke from other places in mingw.c.
> 
> Within mingw.c, if some other function inside mingw.c wants to use
> mingw_unlink, then it should be written as 'mingw_unlink(foo)', not
> 'unlink(foo)'.
> 

I very much like this approach. In fact, we already do this for e.g. mingw_raise.

> So, IMO the macros should be #undef'ed at the top of the file, and all
> users (like the open() and gethostbyname() invocations that you
> identified) should be audited and changed to call the function they
> actually need (i.e., the system open vs. mingw_open).
> 

I'm sceptical of moving all #undef's to the top. Other callers would typically want the wrapped version (i.e. mingw_*). At least I can't think of a scenario in which a higher level function would want to bypass the wrapper...

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
