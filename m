From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 2/2] dir: remove PATH_MAX limitation
Date: Sat, 12 Jul 2014 01:43:52 +0200
Message-ID: <53C076B8.9030209@gmail.com>
References: <53B72DAA.5050007@gmail.com> <53B72DD5.6020603@gmail.com>	<xmqqa98i7aqt.fsf@gitster.dls.corp.google.com>	<53C036CD.902@gmail.com> <xmqq4myn34xo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
X-From: msysgit+bncBCH3XYXLXQDBBNXNQGPAKGQEFRTPWVQ@googlegroups.com Sat Jul 12 01:43:57 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBNXNQGPAKGQEFRTPWVQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f183.google.com ([209.85.212.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBNXNQGPAKGQEFRTPWVQ@googlegroups.com>)
	id 1X5kTr-00028M-LB
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2014 01:43:55 +0200
Received: by mail-wi0-f183.google.com with SMTP id q5sf494wiv.10
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2014 16:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=XY3xWv+4mLh7Y/iACIrfej/B0keiZ+aBvR4AEe+C+Ok=;
        b=FxSaBW3J3WXjOAL8X+OcAUV8X2mlSBZY5fyH+hlAu95E9kvDam4hPzR5t8jdAMSjA2
         A/yH8me3Ojh5MmZ1Es/1FEgVRoJ1WoHgGBbt8G8i5DHaoVWsACRYdo12r8Z1iGGwUkmV
         S2eQV+3K3z6nGWYuvn9CuO0uqr5ZGEokDYtUcsMAzO7zcuTJmNfNmI0RzLWUubYBO2Wf
         9kgJHTPSaRsjkSCdenYCn1lsz6ezCQu+zVh60587arrsZt59gYyCWTbcptpyU7CnIfPo
         jbxDHN4A+cOBGhyfhG1WQEY/NL9aDR3RM/Oi4kt5neDbhD2PTIb3OW+stXTpRfGoe+qc
         ddsA==
X-Received: by 10.180.13.139 with SMTP id h11mr30413wic.21.1405122231380;
        Fri, 11 Jul 2014 16:43:51 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.95.194 with SMTP id dm2ls158130wib.53.gmail; Fri, 11 Jul
 2014 16:43:50 -0700 (PDT)
X-Received: by 10.194.92.167 with SMTP id cn7mr207770wjb.1.1405122230549;
        Fri, 11 Jul 2014 16:43:50 -0700 (PDT)
Received: from mail-we0-x22b.google.com (mail-we0-x22b.google.com [2a00:1450:400c:c03::22b])
        by gmr-mx.google.com with ESMTPS id d9si2406wie.3.2014.07.11.16.43.50
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 16:43:50 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22b as permitted sender) client-ip=2a00:1450:400c:c03::22b;
Received: by mail-we0-f171.google.com with SMTP id q58so1781649wes.30
        for <msysgit@googlegroups.com>; Fri, 11 Jul 2014 16:43:50 -0700 (PDT)
X-Received: by 10.194.120.35 with SMTP id kz3mr2794408wjb.38.1405122230467;
        Fri, 11 Jul 2014 16:43:50 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id v17sm8114706wjr.33.2014.07.11.16.43.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 16:43:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqq4myn34xo.fsf@gitster.dls.corp.google.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22b
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253353>

Am 12.07.2014 00:29, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> Anyways, I'd like to kindly withdraw this patch in favor of Duy's version.
>>
>> http://article.gmane.org/gmane.comp.version-control.git/248310
> 
> Thanks; I've already reverted it from 'next'.
> 
> Is Duy's patch still viable?
> 

I think so. It fixes the segfault with long paths on Windows as well
(Tested-by: <me>), uses strbuf APIs as Peff suggested, and initializes the
strbuf with PATH_MAX (i.e. no reallocs in the common case either ;-) ).

AFAICT the first two patches of that series are also completely unrelated
to the untracked-cache, so we may want to fast-track these?

[01/20] dir.c: coding style fix
[02/20] dir.h: move struct exclude declaration to top level
[03/20] prep_exclude: remove the artificial PATH_MAX limit

...perhaps with s/if (!dir->basebuf.alloc)/if (!dir->basebuf.buf)/

@Duy any reason for not signing off that series?

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
