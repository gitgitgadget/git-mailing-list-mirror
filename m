From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Compiling git for Windows
Date: Wed, 26 Feb 2014 19:37:59 -0000
Organization: OPDS
Message-ID: <70BA74432D4449F2895535E6314C37A2@PhilipOakley>
References: <CAHd499Cr2g0MZs2XBCC-zZqjHeffqO0LXoP1ViaFOjQhTuPKzw@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1; reply-type=original
Cc: "Git MsysGit" <msysgit@googlegroups.com>
To: "Robert Dailey" <rcdailey.lists@gmail.com>,
	"Git" <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBDUFXGMAKGQE7EMU6BI@googlegroups.com Wed Feb 26 20:37:56 2014
Return-path: <msysgit+bncBDSOTWHYX4PBBDUFXGMAKGQE7EMU6BI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f184.google.com ([209.85.212.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBDUFXGMAKGQE7EMU6BI@googlegroups.com>)
	id 1WIkIh-0002bk-KM
	for gcvm-msysgit@m.gmane.org; Wed, 26 Feb 2014 20:37:51 +0100
Received: by mail-wi0-f184.google.com with SMTP id bs8sf190927wib.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 26 Feb 2014 11:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=h2T7nEb19LGaehwvctWkCRwSIgQZO0cfUw6zDO9qp2o=;
        b=yywh1wuzCkj6LFMBxYiZ14NiRiJxf9fOq5PcH0/35Fzqmk9NdIgsIl6103SsR3BeM6
         Zpr8HnGI0Z0JxMzUoQfT2Fj53FUKSlUlGgxhP0utS1ihbXxVyNZQWmHzcPfyvt8IDiw+
         sgHtVQelqs6Q+bwqe4LLukjNryQPzV6jn6BBbUwBQGI4J3QBr5nwHGogqIEcfwyhWBlt
         rfputpWjRktj3D+5f300vHJ1Y/lpqOVAjl4FRV/uP3gtk95zddOHhVH5+AcI0/UAMaqa
         zUlxsM1v+BdUetB2Zy5gCNxfZHVCWGCxsFimzfrCjF1Cy7Z+KDE6rkUB+jTlUpK5IvHM
         7hUA==
X-Received: by 10.180.84.229 with SMTP id c5mr48793wiz.4.1393443471275;
        Wed, 26 Feb 2014 11:37:51 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.36.138 with SMTP id q10ls153599wij.31.gmail; Wed, 26 Feb
 2014 11:37:50 -0800 (PST)
X-Received: by 10.180.82.35 with SMTP id f3mr17884919wiy.0.1393443470319;
        Wed, 26 Feb 2014 11:37:50 -0800 (PST)
Received: from out1.ip03ir2.opaltelecom.net (out1.ip03ir2.opaltelecom.net. [62.24.128.239])
        by gmr-mx.google.com with ESMTP id jb4si1058639wic.0.2014.02.26.11.37.50
        for <msysgit@googlegroups.com>;
        Wed, 26 Feb 2014 11:37:50 -0800 (PST)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.239 as permitted sender) client-ip=62.24.128.239;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah0YABxCDlNZ8Yi5/2dsb2JhbABagwY7iRi4JgUBAgEBgRkXdGkBAYEfAQEWAQQBAQEBAwECBQEBLh4BASELAgMFAgEDDgcMJRQBBAgHCwYHFwYBEggCAQIDAYU4BwGCBw0DFQnCBQ2HMxMEjD6CFoMqgRQEiRGGHIYzaY5OhUeDLTw
X-IPAS-Result: Ah0YABxCDlNZ8Yi5/2dsb2JhbABagwY7iRi4JgUBAgEBgRkXdGkBAYEfAQEWAQQBAQEBAwECBQEBLh4BASELAgMFAgEDDgcMJRQBBAgHCwYHFwYBEggCAQIDAYU4BwGCBw0DFQnCBQ2HMxMEjD6CFoMqgRQEiRGGHIYzaY5OhUeDLTw
X-IronPort-AV: E=Sophos;i="4.97,549,1389744000"; 
   d="scan'208";a="451029540"
Received: from host-89-241-136-185.as13285.net (HELO PhilipOakley) ([89.241.136.185])
  by out1.ip03ir2.opaltelecom.net with SMTP; 26 Feb 2014 19:37:49 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.239 as permitted sender) smtp.mail=philipoakley@iee.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242749>

From: "Robert Dailey" <rcdailey.lists@gmail.com>
> Oddly I'm not able to find any instructions on how to build Git for
> Windows. I've done a clone of the repository here:
>
> https://github.com/msysgit/git
>
> I did attempt to try doing it myself. I installed 'make' and mingw-gcc
> in Cygwin and attempted 'make' from the git directory but it fails
> immediately (I can post information on the failure if needed, but I'm
> assuming I'm not taking the correct approach).
>
> Can someone point me to some instructions on how to build Git for
> Windows? Thanks.
> --

Try the wiki  https://github.com/msysgit/msysgit/wiki

The dev list is at msysgit@googlegroups.com;

--

Philip 

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
