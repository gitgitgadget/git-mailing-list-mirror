From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 00/13] mingw unicode environment
Date: Thu, 17 Jul 2014 21:24:17 +0200
Message-ID: <53C822E1.9020003@gmail.com>
References: <1405611486-10176-1-git-send-email-kasal@ucw.cz> <53C8115D.8040505@gmail.com> <xmqqfvhzq22x.fsf@gitster.dls.corp.google.com> <20140717190000.GA18960@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>, Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCH3XYXLXQDBBX6FUCPAKGQEHFWMXHA@googlegroups.com Thu Jul 17 21:24:18 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBX6FUCPAKGQEHFWMXHA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f55.google.com ([74.125.82.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBX6FUCPAKGQEHFWMXHA@googlegroups.com>)
	id 1X7rHs-0008WT-RG
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 21:24:16 +0200
Received: by mail-wg0-f55.google.com with SMTP id b13sf309690wgh.10
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 12:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=ma4aDLr9Re03Lq+pLiHbkFCQ81r9vxCcwrGDxtQgSCU=;
        b=i1XO6X6fLeuZ3kCkKgWY8J0W7ErcFPcQrbytv1bwxPyHjTbA3fP18TjaAlTNIHHT2e
         X2AjOdjJvfVSKWoticAY5qiGkxXrSRFAqVVvW5EXpGlkSi+osMob7nvpMn3anLT+aF/o
         TYMezXuCnuaAcO60oS0+KLjL5GPDQ0IEu7EMAeBaSFA5SN5URREbrTY6IVgMypyeDbNX
         4WAxQuaVHl3zTP4loUdBqOwkJ/5cUTe4NmAXxfV6oyuNio/Bf+YqVDWjWzVmmYhEBQzS
         Wl/nwJYIrxwW6byu0BTTkIJS1ut0bwAZzCQl7J81AvZzRLIrZDG1aZ26PM7TxYl9cifU
         nkrw==
X-Received: by 10.152.5.168 with SMTP id t8mr21716lat.37.1405625056496;
        Thu, 17 Jul 2014 12:24:16 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.26.130 with SMTP id l2ls177244lag.6.gmail; Thu, 17 Jul
 2014 12:24:15 -0700 (PDT)
X-Received: by 10.112.60.36 with SMTP id e4mr4008210lbr.9.1405625055284;
        Thu, 17 Jul 2014 12:24:15 -0700 (PDT)
Received: from mail-we0-x22f.google.com (mail-we0-x22f.google.com [2a00:1450:400c:c03::22f])
        by gmr-mx.google.com with ESMTPS id x7si411910wiw.1.2014.07.17.12.24.15
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Jul 2014 12:24:15 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22f as permitted sender) client-ip=2a00:1450:400c:c03::22f;
Received: by mail-we0-f175.google.com with SMTP id t60so3605301wes.34
        for <msysgit@googlegroups.com>; Thu, 17 Jul 2014 12:24:15 -0700 (PDT)
X-Received: by 10.180.211.71 with SMTP id na7mr23121608wic.55.1405625055148;
        Thu, 17 Jul 2014 12:24:15 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id n2sm8230378wjf.40.2014.07.17.12.24.13
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Jul 2014 12:24:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140717190000.GA18960@ucw.cz>
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
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253773>

Am 17.07.2014 21:00, schrieb Stepan Kasal:
> Hi,
> 
>> Karsten Blees <karsten.blees@gmail.com> writes:
>>> I believe we prefer moving code to the right place over forward
>>> declarations (IIRC I got bashed for the latter in one of the first rounds
>>> of this patch series). If only to justify 'git-blame -M' :-D
> 
> indeed, my position is the same, generally.
> 
> But it turned out that the current ordering is sane, mostly works as it is,
> and I needed _only one_ fwd decl to make things compile.  This is why I
> decided to have things arranged this way.
> 

Fine with me.

However, if it *did* compile for you, I wonder where ALLOC_GROW (as of #02/13)
and alloc_nr (as of #10/13) came from? Or did we recently remove '#include "cache.h"'
from upstream mingw.c?

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
