From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] Makefile: Fix compilation of Windows
 resource file
Date: Thu, 23 Jan 2014 15:16:46 +0100
Message-ID: <52E1244E.4010503@viscovery.net>
References: <52DD857C.6060005@ramsay1.demon.co.uk>	<xmqqy529t5bb.fsf@gitster.dls.corp.google.com>	<xmqqppnlt3u3.fsf@gitster.dls.corp.google.com>	<52DEF9F2.1000905@ramsay1.demon.co.uk>	<xmqqk3dssxpb.fsf@gitster.dls.corp.google.com>	<52DF6B6C.4020708@viscovery.net>	<xmqq38kgyozt.fsf@gitster.dls.corp.google.com>	<52DFF4E8.8060605@viscovery.net>	<xmqqppnjyl10.fsf@gitster.dls.corp.google.com>	<xmqqeh3zydrz.fsf@gitster.dls.corp.google.com>	<52E0C4BA.4080405@viscovery.net> <CABNJ2GJRsqsr5+ga3-oKVU_H-HtsH+R14fBaVwV8jJcExkxr4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: msysGit <msysgit@googlegroups.com>, 
 Junio C Hamano <gitster@pobox.com>,
 Ramsay Jones <ramsay@ramsay1.demon.co.uk>, 
 GIT Mailing-list <git@vger.kernel.org>,
 Pat Thoyts <patthoyts@users.sourceforge.net>
To: Pat Thoyts <patthoyts@gmail.com>
X-From: msysgit+bncBCJYV6HBKQINHSEES4CRUBCBXDHEM@googlegroups.com Thu Jan 23 15:16:53 2014
Return-path: <msysgit+bncBCJYV6HBKQINHSEES4CRUBCBXDHEM@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f61.google.com ([74.125.83.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQINHSEES4CRUBCBXDHEM@googlegroups.com>)
	id 1W6L5P-00069I-Uf
	for gcvm-msysgit@m.gmane.org; Thu, 23 Jan 2014 15:16:52 +0100
Received: by mail-ee0-f61.google.com with SMTP id b15sf80192eek.26
        for <gcvm-msysgit@m.gmane.org>; Thu, 23 Jan 2014 06:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=6J2kCFbZO0y0GoBBZbBLLbkY9WHp5UZRFkoeelEdhNM=;
        b=IH5CdVa/8VGdg65cekowbHTmWhs7OzG8jwqtw6zr+v+UyeWuvD6aTLp+J6Jv444FBk
         bfrlRMzzkWrEmBGtjaVG9mAhLRomRkhBk8LUUGB75v/HJXgJK8j5zJvS/8qGF0mnNELI
         5TbDZlydU31Pw1ysbQvTAs2zeyHTJfkhlh3eT77TFDUd2TSyGLsjApV2a+MtIh3JI4qf
         eRdzGwx+jfSvM9O7g6eB4kxDJGLK2QND2hwscYBqitZEbhVjlztjMBJsdts1YWLGpbHa
         fKWvnHDpOVzm8wrd/4mVrRy6oNPHBD9m00lPffgAVi60G42zrg2aJzWohE0lUnZDNNaW
         cMIw==
X-Received: by 10.152.10.1 with SMTP id e1mr1347lab.41.1390486611690;
        Thu, 23 Jan 2014 06:16:51 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.225.170 with SMTP id rl10ls123194lac.1.gmail; Thu, 23 Jan
 2014 06:16:50 -0800 (PST)
X-Received: by 10.152.26.72 with SMTP id j8mr3599002lag.7.1390486610803;
        Thu, 23 Jan 2014 06:16:50 -0800 (PST)
Received: from so.liwest.at (so.liwest.at. [212.33.55.18])
        by gmr-mx.google.com with ESMTPS id f47si429437eem.0.2014.01.23.06.16.50
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jan 2014 06:16:50 -0800 (PST)
Received-SPF: neutral (google.com: 212.33.55.18 is neither permitted nor denied by best guess record for domain of j.sixt@viscovery.net) client-ip=212.33.55.18;
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1W6L5L-0004xq-5L; Thu, 23 Jan 2014 15:16:47 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D88DC16613;
	Thu, 23 Jan 2014 15:16:46 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CABNJ2GJRsqsr5+ga3-oKVU_H-HtsH+R14fBaVwV8jJcExkxr4g@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Spam-Score: -1.0 (-)
X-Original-Sender: j.sixt@viscovery.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 212.33.55.18 is neither permitted nor denied by best guess
 record for domain of j.sixt@viscovery.net) smtp.mail=j.sixt@viscovery.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240914>

Am 1/23/2014 13:02, schrieb Pat Thoyts:
> On 23 January 2014 07:28, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> @@ -1773,7 +1773,7 @@ $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
>>
>>  git.res: git.rc GIT-VERSION-FILE
>>         $(QUIET_RC)$(RC) \
>> -         $(join -DMAJOR= -DMINOR= -DPATCH=, $(wordlist 1,3,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
>> +         $(join -DMAJOR= -DMINOR=, $(wordlist 1,2,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
>>           -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" $< -o $@
>>
>>  ifndef NO_PERL
>
> This was put in as a response to
> https://github.com/msysgit/git/issues/5 where a request was made to be
> able to check the version without actually executing the file.

If I understand the request correctly, it is about manual inspection. The
correct version string for this purpose is recorded via -DGIT_VERSION.

> Given
> that the majority of versions has the same first two digits this
> becomes fairly useless without the patchlevel digit. So it would be
> preferable to try to maintain all three digits. The following should
> do this:
> 
> GIT_VERSION=1.9.rc0
> all:
>     echo $(join -DMAJOR= -DMINOR= -DPATCH=, \
>         $(wordlist 1,3,$(filter-out rc%,$(subst -, ,$(subst .,
> ,$(GIT_VERSION)))) 0 0))
> 
> This removes any rc* parts and appends a couple of zeros so that all
> missing elements should appear as 0 in the final list.

As Junio already pointed out, this records the wrong number in the 1.9
track before 1.9.1 is out because the third position is the commit count,
not the patch level.

-- Hannes

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
