From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Re: [PATCH] mingw: redefine the wrapper macro after the
 corresponding function
Date: Fri, 06 Jun 2014 00:12:12 +0200
Message-ID: <5390EB3C.1070202@gmail.com>
References: <20140605080519.GB28029@camelia.ucw.cz> <539083FB.6040707@gmail.com> <20140605151338.GA29385@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCH3XYXLXQDBBOWWYOOAKGQENGSYSEI@googlegroups.com Fri Jun 06 00:12:12 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBOWWYOOAKGQENGSYSEI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f188.google.com ([209.85.212.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBOWWYOOAKGQENGSYSEI@googlegroups.com>)
	id 1WsftL-0007SZ-O2
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 00:12:11 +0200
Received: by mail-wi0-f188.google.com with SMTP id bs8sf319826wib.15
        for <gcvm-msysgit@m.gmane.org>; Thu, 05 Jun 2014 15:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=SD9wMB2ErXjZ/x1LhBNqCJfRJPfwjQwm26o0nlnuFcM=;
        b=gCVC78UCy0OcBj4xp9o8xBS+KqRy48yfqRxfLmbDl14HGGY+9b9r31NC2KiCUsOBaY
         haAK+wtDZRh6NaSglc4cwg1Qy5RC0wjckZ8GlMfx7g14aH/z1QfOScbCw+O8fU0Imcg/
         pSaXCHkeVWpZt7WXVAaGwjZdIJznI+smcXgxyFTOGOJW/s+GfcSzSCXmU47v/TAlEJjn
         NmBu3jg6rpV35aUrK7E1a8vrTnAEfV0HUx5InJ2Ti9558ns9/bCSDUWDP+OuQ72k92Ce
         pEFaiLuTEV+UYuyzX6/earNaJ7ygYnL44KvP6oRLJtHkBa1p3su8yu13n35xK3XqSthx
         n/Fw==
X-Received: by 10.152.42.225 with SMTP id r1mr5909lal.13.1402006331310;
        Thu, 05 Jun 2014 15:12:11 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.9.163 with SMTP id a3ls73876lab.55.gmail; Thu, 05 Jun 2014
 15:12:10 -0700 (PDT)
X-Received: by 10.112.50.203 with SMTP id e11mr307290lbo.23.1402006330390;
        Thu, 05 Jun 2014 15:12:10 -0700 (PDT)
Received: from mail-we0-x22f.google.com (mail-we0-x22f.google.com [2a00:1450:400c:c03::22f])
        by gmr-mx.google.com with ESMTPS id ck3si425119wib.0.2014.06.05.15.12.10
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 15:12:10 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22f as permitted sender) client-ip=2a00:1450:400c:c03::22f;
Received: by mail-we0-f175.google.com with SMTP id p10so1899518wes.20
        for <msysgit@googlegroups.com>; Thu, 05 Jun 2014 15:12:10 -0700 (PDT)
X-Received: by 10.14.5.71 with SMTP id 47mr225561eek.101.1402006330280;
        Thu, 05 Jun 2014 15:12:10 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id cj41sm17743585eeb.34.2014.06.05.15.12.08
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 15:12:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140605151338.GA29385@camelia.ucw.cz>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22f
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250871>

Am 05.06.2014 17:13, schrieb Stepan Kasal:
> Hello Karsten,
> 
> On Thu, Jun 05, 2014 at 04:51:39PM +0200, Karsten Blees wrote:
>> In the current msysgit HEAD, most of these #undef's can simply be
>> removed or have already been removed [...]
> 
> not "most of."  According to my quick count, 6 of 20 have been removed,
> 2 more can be removed.  The remaining 12 do play their role.
> (The point you overlooked is that there are several socket related,
> like bind().)
> 

Right, premature generalization on my part from looking at the first two or so entries.

However, I suspect some of the remaining 12 could be improved so that no #undef is necessary. E.g. gethostbyname could probably be implemented using GetAddrInfoW (supports non-ASCII names and IPv6).


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
