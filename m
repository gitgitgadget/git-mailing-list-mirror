From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: Possible Bug in git-http-push
Date: Fri, 10 Apr 2015 18:55:00 +0200
Message-ID: <55280064.5070909@virtuell-zuhause.de>
References: <5527B0D6.3010608@innuce.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: msysGit <msysgit@googlegroups.com>, bugs@innuce.ch
To: Stefan <bugs@innuce.ch>, git@vger.kernel.org
X-From: msysgit+bncBCL7JHHTPAIOXAFAVECRUBDYNQVMK@googlegroups.com Fri Apr 10 18:55:08 2015
Return-path: <msysgit+bncBCL7JHHTPAIOXAFAVECRUBDYNQVMK@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f56.google.com ([74.125.82.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL7JHHTPAIOXAFAVECRUBDYNQVMK@googlegroups.com>)
	id 1YgcCy-0005bV-HQ
	for gcvm-msysgit@m.gmane.org; Fri, 10 Apr 2015 18:55:08 +0200
Received: by wggz12 with SMTP id z12sf7041564wgg.0
        for <gcvm-msysgit@m.gmane.org>; Fri, 10 Apr 2015 09:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=1EgQDEYiqc7E4ISx+sT09I3giPmqvxaEgOBnFWKlH5w=;
        b=TmJZWuHOosD9fIga2aRtWvlGnjihnGUoYd43M3Tiq9rDkkD4I8dKjzpuAxEKNVqEft
         vTm1BMp01jtIbW5tVAHmE6RXkeoVn4ArYfBYhyZsihK5JKGWU64cdtKQESmSL6CbVdyd
         esLKNKFEepiULOrj+T4UbpYJhaP8DRnyYxcfI+z1X37Qoie9PA088aFfd6LFGYsg/fnM
         deaAZwtPZI4V/pjbZyIrmuUGAGyOgJ+p8uFKfktCQRuLIoBQN1R0eO8ZGIrhfoBsHTwu
         hQJcewQRiLk2FDccoeYdCIAluqYvixlkAbFp5bwYEGgPJ+sne5NV0Oa3iyhMh7C7zfQg
         ZUww==
X-Received: by 10.180.7.233 with SMTP id m9mr91988wia.2.1428684908100;
        Fri, 10 Apr 2015 09:55:08 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.20.37 with SMTP id k5ls19989wie.23.canary; Fri, 10 Apr
 2015 09:55:07 -0700 (PDT)
X-Received: by 10.180.106.136 with SMTP id gu8mr1670729wib.6.1428684907429;
        Fri, 10 Apr 2015 09:55:07 -0700 (PDT)
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de. [80.237.132.163])
        by gmr-mx.google.com with ESMTPS id ec7si14990wib.3.2015.04.10.09.55.07
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 10 Apr 2015 09:55:07 -0700 (PDT)
Received-SPF: none (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted sender hosts) client-ip=80.237.132.163;
Received: from pd9fadc8f.dip0.t-ipconnect.de ([217.250.220.143] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1YgcCu-0006Ex-Gq; Fri, 10 Apr 2015 18:55:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <5527B0D6.3010608@innuce.ch>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1428684907;786bd3fd;
X-Original-Sender: thomas.braun@virtuell-zuhause.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=none
 (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted
 sender hosts) smtp.mail=thomas.braun@virtuell-zuhause.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267018>

Am 10.04.2015 um 13:15 schrieb Stefan:
> Hello List
> 
> I possibly found a bug in git-http-push:
> 
> When I push my local repo via http secured with basic authorization,
> then i get:
> 
> error: Cannot access URL https://example.ch/example_repo/, return code 22
> fatal: git-http-push failed
> Pushing to https://example.ch/example_repo/
> 
> My server log gives PROPPFIND 401, so i seems that the PROPPFIND-sent
> by git-http-push does not use supplied username/pw via prompt
> 
> Pulling works without problems.
> 
> When I change remote URL to
> https://user:password@example.ch/example_repo, pushing works.
> 
> I'm using git version 1.9.5.msysgit.1

Hi Stefan (CC'ing the msysgit list as this might be windows specific),

can you determine the last version which worked?

And can you create a minimal working example for us to reproduce the
problem?

We already have a couple of problems with the new curl version together
with our ancient openssl.

Thomas


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
