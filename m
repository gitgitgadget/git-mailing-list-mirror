From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] compat/mingw: stubs for getpgid() and tcgetpgrp()
Date: Wed, 15 Apr 2015 22:34:41 +0200
Message-ID: <552ECB61.3020502@kdbg.org>
References: <20150413134850.GC23475@mewburn.net>	<alpine.LFD.2.11.1504130954420.5619@knanqh.ubzr>	<20150413144039.GD23475@mewburn.net>	<alpine.LFD.2.11.1504131052090.5619@knanqh.ubzr>	<20150414110312.GE23475@mewburn.net> <552EAE0A.3040208@kdbg.org> <xmqq3841kz32.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Luke Mewburn <luke@mewburn.net>, Nicolas Pitre <nico@fluxnic.net>, 
 git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCJYV6HBKQIOHFV3VECRUBFRW5J4Q@googlegroups.com Wed Apr 15 22:34:52 2015
Return-path: <msysgit+bncBCJYV6HBKQIOHFV3VECRUBFRW5J4Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f190.google.com ([209.85.217.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIOHFV3VECRUBFRW5J4Q@googlegroups.com>)
	id 1YiU1F-0002Ed-9D
	for gcvm-msysgit@m.gmane.org; Wed, 15 Apr 2015 22:34:45 +0200
Received: by lbiv13 with SMTP id v13sf18979012lbi.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 15 Apr 2015 13:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=xqjXf8yLvya7iM7Koglip0iN9MHaDjbnwlJK6lq3RYo=;
        b=Z9V9UaVXIJ4PoCUIMrLJqHeyNwVspn0oMo/FOpcCcZWAgoWc/tVBVNrjQIT3Z5f6qB
         pQbyQc1dw28KGYRdiUAO8fAE0FAaQvVGIr9JK//k8jnjBj3zRy1d9TkTA+sCzNGKJK1J
         ajG9ipXbI+oNZQler6SK6IPhWDHL/YAoaKDjJsaSY5gd2cF14R9Wb/Y62gKg9S0V7Shb
         JkLUZjmpC+P3yyGJ+1glpZ5BbvOGlkHIVlpunHNabyDb6+4Cxn64CRaB62olZsF+xUky
         ptFih62A0ujvK80NciuzTSILM9R2B8Suf+1BZq09S0RM499+7AVF0DfvKCBulzMy6fwv
         s86w==
X-Received: by 10.152.21.35 with SMTP id s3mr338052lae.1.1429130084533;
        Wed, 15 Apr 2015 13:34:44 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.28.100 with SMTP id a4ls250358lah.23.gmail; Wed, 15 Apr
 2015 13:34:43 -0700 (PDT)
X-Received: by 10.112.118.162 with SMTP id kn2mr6290839lbb.22.1429130083351;
        Wed, 15 Apr 2015 13:34:43 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp.bon.at. [213.33.87.14])
        by gmr-mx.google.com with ESMTPS id sf8si381147wic.2.2015.04.15.13.34.43
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2015 13:34:43 -0700 (PDT)
Received-SPF: none (google.com: j6t@kdbg.org does not designate permitted sender hosts) client-ip=213.33.87.14;
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3lRwQp224qz5tlH;
	Wed, 15 Apr 2015 22:34:42 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id BFF10522C;
	Wed, 15 Apr 2015 22:34:41 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqq3841kz32.fsf@gitster.dls.corp.google.com>
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=none
 (google.com: j6t@kdbg.org does not designate permitted sender hosts) smtp.mail=j6t@kdbg.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267238>

Am 15.04.2015 um 20:48 schrieb Junio C Hamano:
> The patch should do for now, but I suspect that it may give us a
> better abstraction to make the "is_foreground_fd(int fd)" or even
> "is_foreground(void)" the public API that would be implemented as
>
> 	int we_are_in_the_foreground(void)
>          {
> 		return getpgid(0) == tcgetpgrp(fileno(stderr));
> 	}
>
> in POSIX and Windows can implement entirely differently.
>
> Thoughts?

IMHO, this level of abstraction goes too far. It may be that I am not 
familiar with process groups, and I find the implementation of 
is_foreground_fd() in progress.c close to where it's used quite 
educating and enlightening. Hiding a similar implementation miles away 
in cache.h and/or compat/ would not pay off for me.

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
