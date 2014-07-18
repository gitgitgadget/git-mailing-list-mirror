From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: Re: [PATCH 00/13] mingw unicode environment
Date: Fri, 18 Jul 2014 20:51:34 +0200
Message-ID: <20140718185134.GA9280@ucw.cz>
References: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
 <53C8115D.8040505@gmail.com>
 <xmqqfvhzq22x.fsf@gitster.dls.corp.google.com>
 <20140717190000.GA18960@ucw.cz>
 <53C822E1.9020003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCU63DXMWULRBNWZUWPAKGQEZIRSCTI@googlegroups.com Fri Jul 18 20:51:36 2014
Return-path: <msysgit+bncBCU63DXMWULRBNWZUWPAKGQEZIRSCTI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f186.google.com ([209.85.212.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBNWZUWPAKGQEZIRSCTI@googlegroups.com>)
	id 1X8DFo-0007z9-JC
	for gcvm-msysgit@m.gmane.org; Fri, 18 Jul 2014 20:51:36 +0200
Received: by mail-wi0-f186.google.com with SMTP id bs8sf130164wib.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 18 Jul 2014 11:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=4rKYKJ93mTfeOcZaLCJrcBTQBAF6UDfJxzaVWarKbKk=;
        b=ReMtyo5R4fmhx7J0iJS8Quq9Yx+4pm91fj4bz2N1NfaZR7FxNnNk9mCNQy417OdONT
         HqTNTsax+RmHsqLraBonH8o6pNjsj75UrgTftAawvpqTacG062Lnbgi67iCCnfj+YrNP
         O6HvIL/aELrzRPoMJmO5aZqz5S0YKhoOnNMaZCagQSMLuZ+5mrBvh7vBLL82Hpp2oqH/
         I7tMKHTPTW7IyzbV3j6RqF3/iDIGpTClZotdDhbabxQ+qjyXpWIdf6bxzdMIra8CfB8s
         0ujUFH9V0dZ8YHP5ZE32J1D+eK/7OwDBWf6nqWkleVOp7LTk/sbooR/a2MFuJBfFlN5Z
         saxg==
X-Received: by 10.180.92.40 with SMTP id cj8mr29786wib.7.1405709495911;
        Fri, 18 Jul 2014 11:51:35 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.36.134 with SMTP id q6ls125991wij.16.canary; Fri, 18 Jul
 2014 11:51:34 -0700 (PDT)
X-Received: by 10.180.91.73 with SMTP id cc9mr2969417wib.4.1405709494556;
        Fri, 18 Jul 2014 11:51:34 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id m6si177471wik.2.2014.07.18.11.51.34
        for <msysgit@googlegroups.com>;
        Fri, 18 Jul 2014 11:51:34 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 556C71C014F; Fri, 18 Jul 2014 20:51:34 +0200 (CEST)
In-Reply-To: <53C822E1.9020003@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253837>

Hello Karsten,

you wrote:
> However, if it *did* compile for you, I wonder where ALLOC_GROW (as of #02/13)
> and alloc_nr (as of #10/13) came from? Or did we recently remove '#include "cache.h"'
> from upstream mingw.c?

you are right, the include needs to be added.

To test my modifications, I rebased all the rest of msysGit collection,
built and run the test suite.

As you pointed out, https://github.com/msysgit/git/commit/d85d2b75
adds the include.

Unfortunately, I won't get to this for several weeks.  Could you or Hannes
be so kind and post the fixup?

Thank you for this comment.  And big thanks for the orignal work.
(I was only moving it and even that took some time. ;-)

Stepan

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
