From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 2/2] dir: remove PATH_MAX limitation
Date: Fri, 11 Jul 2014 21:11:09 +0200
Message-ID: <53C036CD.902@gmail.com>
References: <53B72DAA.5050007@gmail.com> <53B72DD5.6020603@gmail.com> <xmqqa98i7aqt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCH3XYXLXQDBBTXNQCPAKGQEC5P55OY@googlegroups.com Fri Jul 11 21:11:15 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBTXNQCPAKGQEC5P55OY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f191.google.com ([209.85.212.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBTXNQCPAKGQEC5P55OY@googlegroups.com>)
	id 1X5gDx-0004NR-Kr
	for gcvm-msysgit@m.gmane.org; Fri, 11 Jul 2014 21:11:13 +0200
Received: by mail-wi0-f191.google.com with SMTP id q5sf19964wiv.8
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2014 12:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=teYpbk9e2upQrFviLsN10TGK2spjMgl00CElKiVErUM=;
        b=yKsxk4rb9jPG7A1gEeINVyWLcsf1M2QOjuL0lIwPjAs3jpKfK2u+cy/cDnxtMQPu5M
         8GjxtaN/d6+08Z3ERjtwTYfL5mWT+lu4PPtVqyrCkMU9uJNjCiQ579hzZ7fs8zzlXjf+
         cWhxYiHrOJPfbgfbra7pZZ0r6nWbM6M0le89kkWroIyTQJrFUU7AxM3wGXEtCuOCdAQ1
         qZNF4MpXQcW4fwvLicxVDmU1MBRlizL/e8sMJu7LcOGtkXsNbIYn5n0QofRpp9qHMv0V
         QVA5bioNzM7jvjFa4ssoWoKU1jZ6sieRxwnfMqrzzmUcEIaXEBKJfVUo7St5SxYCo2O4
         kpmg==
X-Received: by 10.152.87.84 with SMTP id v20mr7676laz.8.1405105870653;
        Fri, 11 Jul 2014 12:11:10 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.238.9 with SMTP id vg9ls117129lac.104.gmail; Fri, 11 Jul
 2014 12:11:09 -0700 (PDT)
X-Received: by 10.112.27.210 with SMTP id v18mr87400lbg.4.1405105869382;
        Fri, 11 Jul 2014 12:11:09 -0700 (PDT)
Received: from mail-wi0-x22a.google.com (mail-wi0-x22a.google.com [2a00:1450:400c:c05::22a])
        by gmr-mx.google.com with ESMTPS id x7si250712wiw.1.2014.07.11.12.11.09
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 12:11:09 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22a as permitted sender) client-ip=2a00:1450:400c:c05::22a;
Received: by mail-wi0-f170.google.com with SMTP id cc10so1271928wib.1
        for <msysgit@googlegroups.com>; Fri, 11 Jul 2014 12:11:09 -0700 (PDT)
X-Received: by 10.194.184.200 with SMTP id ew8mr853507wjc.61.1405105869293;
        Fri, 11 Jul 2014 12:11:09 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id n2sm6869927wjf.40.2014.07.11.12.11.08
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 12:11:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqa98i7aqt.fsf@gitster.dls.corp.google.com>
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
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253316>

Am 09.07.2014 18:33, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> 'git status' segfaults if a directory is longer than PATH_MAX, because
>> processing .gitignore files in prep_exclude() writes past the end of a
>> PATH_MAX-bounded buffer.
>>
>> Remove the limitation by using strbuf instead.
>>
>> Note: this fix just 'abuses' strbuf as string allocator, len is always 0.
>> prep_exclude() can probably be simplified using more strbuf APIs.
> 
> In addition to what Jeff already said, I am afraid that this may
> make things a lot worse for normal case.  By sizing the strbuf to
> absolute minimum as you dig deeper at each level, wouldn't you copy
> and reallocate the buffer a lot more, compared to the case where
> everything fits in the original buffer?
> 

strbuf uses ALLOC_GROW, which resizes in (x+16)*1.5 steps (i.e. 24, 60, 114,
195, 316...). Max path len in git is 85, and linux and WebKit are 170ish. I
don't think three or four extra reallocs per directory traversal will be
noticeable.

Anyways, I'd like to kindly withdraw this patch in favor of Duy's version.

http://article.gmane.org/gmane.comp.version-control.git/248310

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
