From: Pat Thoyts <patthoyts@gmail.com>
Subject: Re: [PATCH v2] Makefile: Fix compilation of Windows
 resource file
Date: Thu, 23 Jan 2014 15:19:18 +0000
Message-ID: <CABNJ2GKA5PhzTfrhSCOTWtWAKMdT8+Sn6_Q54z=Dc0UVWgdmZQ@mail.gmail.com>
References: <52DD857C.6060005@ramsay1.demon.co.uk>
	<xmqqy529t5bb.fsf@gitster.dls.corp.google.com>
	<xmqqppnlt3u3.fsf@gitster.dls.corp.google.com>
	<52DEF9F2.1000905@ramsay1.demon.co.uk>
	<xmqqk3dssxpb.fsf@gitster.dls.corp.google.com>
	<52DF6B6C.4020708@viscovery.net>
	<xmqq38kgyozt.fsf@gitster.dls.corp.google.com>
	<52DFF4E8.8060605@viscovery.net>
	<xmqqppnjyl10.fsf@gitster.dls.corp.google.com>
	<xmqqeh3zydrz.fsf@gitster.dls.corp.google.com>
	<52E0C4BA.4080405@viscovery.net>
	<CABNJ2GJRsqsr5+ga3-oKVU_H-HtsH+R14fBaVwV8jJcExkxr4g@mail.gmail.com>
	<52E1244E.4010503@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: msysGit <msysgit@googlegroups.com>, Junio C Hamano <gitster@pobox.com>, 
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, GIT Mailing-list <git@vger.kernel.org>, 
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: msysgit+bncBDRPLLPZ44IBB6PFQSLQKGQEGOCAADQ@googlegroups.com Thu Jan 23 16:19:25 2014
Return-path: <msysgit+bncBDRPLLPZ44IBB6PFQSLQKGQEGOCAADQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f185.google.com ([209.85.217.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDRPLLPZ44IBB6PFQSLQKGQEGOCAADQ@googlegroups.com>)
	id 1W6M3u-0001Ns-Ae
	for gcvm-msysgit@m.gmane.org; Thu, 23 Jan 2014 16:19:22 +0100
Received: by mail-lb0-f185.google.com with SMTP id u14sf195985lbd.12
        for <gcvm-msysgit@m.gmane.org>; Thu, 23 Jan 2014 07:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=EY+MUlh/coWc6mUTB13SHi702JrpKvU+jrrb08VBz2I=;
        b=SVaXYRYGsv+/WQNETZFT3r/ut6jOze1U0ceHGAxdtayizb10A8+l1gPM1eVwnaY1Fm
         Ptrg5pQ5SG29RBjaNR61kGwSB/eEu+Q3ljGe505TYrIIvHJPN/lDLC0eJRz6DV467H0T
         vWtv/4BkKCcUKwIyA4hUR41Scb/QIBpU6swTiXtQKMYPZrrTUjuyoxvDUhf2kGtZhgAa
         THVOqjanGXNDAUcWICJ/u01rrJfjWRlOjL+hw3UOBvJz5AkktvsjMIFdOeV/Vicz0H1X
         gOZDJiSXLp1vO9SoD1VYmLoNUHBJaCt40NlOBCTMQG+T78zBzz/AlOztQWBZ+USbUJb0
         wHkw==
X-Received: by 10.180.92.2 with SMTP id ci2mr216060wib.19.1390490362029;
        Thu, 23 Jan 2014 07:19:22 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.96.232 with SMTP id dv8ls138986wib.50.canary; Thu, 23 Jan
 2014 07:19:21 -0800 (PST)
X-Received: by 10.180.10.129 with SMTP id i1mr4219857wib.5.1390490360925;
        Thu, 23 Jan 2014 07:19:20 -0800 (PST)
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com [2607:f8b0:400e:c03::22d])
        by gmr-mx.google.com with ESMTPS id rk7si1923298bkb.2.2014.01.23.07.19.20
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 23 Jan 2014 07:19:20 -0800 (PST)
Received-SPF: pass (google.com: domain of patthoyts@gmail.com designates 2607:f8b0:400e:c03::22d as permitted sender) client-ip=2607:f8b0:400e:c03::22d;
Received: by mail-pa0-x22d.google.com with SMTP id lf10so1971692pab.4
        for <msysgit@googlegroups.com>; Thu, 23 Jan 2014 07:19:20 -0800 (PST)
X-Received: by 10.68.138.165 with SMTP id qr5mr8698919pbb.123.1390490358827;
 Thu, 23 Jan 2014 07:19:18 -0800 (PST)
Received: by 10.68.133.202 with HTTP; Thu, 23 Jan 2014 07:19:18 -0800 (PST)
In-Reply-To: <52E1244E.4010503@viscovery.net>
X-Original-Sender: patthoyts@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of patthoyts@gmail.com designates 2607:f8b0:400e:c03::22d
 as permitted sender) smtp.mail=patthoyts@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240916>

On 23 January 2014 14:16, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 1/23/2014 13:02, schrieb Pat Thoyts:
>> On 23 January 2014 07:28, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> @@ -1773,7 +1773,7 @@ $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
>>>
>>>  git.res: git.rc GIT-VERSION-FILE
>>>         $(QUIET_RC)$(RC) \
>>> -         $(join -DMAJOR= -DMINOR= -DPATCH=, $(wordlist 1,3,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
>>> +         $(join -DMAJOR= -DMINOR=, $(wordlist 1,2,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
>>>           -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" $< -o $@
>>>
>>>  ifndef NO_PERL
>>
>> This was put in as a response to
>> https://github.com/msysgit/git/issues/5 where a request was made to be
>> able to check the version without actually executing the file.
>
> If I understand the request correctly, it is about manual inspection. The
> correct version string for this purpose is recorded via -DGIT_VERSION.
>
>> Given
>> that the majority of versions has the same first two digits this
>> becomes fairly useless without the patchlevel digit. So it would be
>> preferable to try to maintain all three digits. The following should
>> do this:
>>
>> GIT_VERSION=1.9.rc0
>> all:
>>     echo $(join -DMAJOR= -DMINOR= -DPATCH=, \
>>         $(wordlist 1,3,$(filter-out rc%,$(subst -, ,$(subst .,
>> ,$(GIT_VERSION)))) 0 0))
>>
>> This removes any rc* parts and appends a couple of zeros so that all
>> missing elements should appear as 0 in the final list.
>
> As Junio already pointed out, this records the wrong number in the 1.9
> track before 1.9.1 is out because the third position is the commit count,
> not the patch level.
>
> -- Hannes

OK - I cehcked and you are right in that the GIT_VERSION value is the
one showing up the properties dialog at least under Windows 7. As this
is the most likely to be examined I agree that just taking the first
two digits is the simplest fix here. So, fine by me then.

Acked-by: Pat Thoyts <patthoyts@users.sourceforge.net>

Cheers,
Pat.

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
For more options, visit https://groups.google.com/groups/opt_out.
