From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: Topic sk/mingw-unicode-spawn-args breaks tests
Date: Sat, 12 Jul 2014 09:50:35 +0200
Message-ID: <20140712075035.GA12400@ucw.cz>
References: <53BEF21E.9090007@kdbg.org>
 <53C03FBB.1080807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>, Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCU63DXMWULRBTGRQOPAKGQESJ2UQQA@googlegroups.com Sat Jul 12 09:50:37 2014
Return-path: <msysgit+bncBCU63DXMWULRBTGRQOPAKGQESJ2UQQA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f55.google.com ([209.85.215.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBTGRQOPAKGQESJ2UQQA@googlegroups.com>)
	id 1X5s4q-0008Ah-W1
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2014 09:50:37 +0200
Received: by mail-la0-f55.google.com with SMTP id pn19sf206973lab.0
        for <gcvm-msysgit@m.gmane.org>; Sat, 12 Jul 2014 00:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=dJviMCuu6o+brgsufVzqJ95oq8E6gL3zcz1W/VREqAA=;
        b=wghBQcgSCUIk1mPNIQSA+1shhIitj3KE05JiS+c7xPr9hrrf3E3oF0QN0LAoEn/OJh
         lwgX7cZM4DmdN98sLH9lwnPcmds9aDQFAtf57Dq5IXPOK243UaR/Nw3C2BEVOqPgG53g
         /lCLk6zJkLEP5FlEfDPkWHUaEEFlfR1i3rdCC2YOOm1iM0Y7W5G/VZFsiHF4nzfkEFAX
         ylUu8hTAkaOZXWqVg+ZsFoA2S/ketCWk2j7uO9uU1x6x7Xvl29AV2Pk6Ge0DMBo8h3MQ
         GKlonPNiSAQsOxJL6Vd9m1c2pMOiKOz0hYDp/014jeQLG4PSyBdZ/tbFtlChWWThAUe0
         tgkw==
X-Received: by 10.180.207.5 with SMTP id ls5mr34017wic.8.1405151436827;
        Sat, 12 Jul 2014 00:50:36 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.19.137 with SMTP id f9ls192216wie.52.canary; Sat, 12 Jul
 2014 00:50:35 -0700 (PDT)
X-Received: by 10.180.77.202 with SMTP id u10mr982161wiw.3.1405151435808;
        Sat, 12 Jul 2014 00:50:35 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id iz18si59501wic.3.2014.07.12.00.50.35
        for <msysgit@googlegroups.com>;
        Sat, 12 Jul 2014 00:50:35 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 9476F1C0136; Sat, 12 Jul 2014 09:50:35 +0200 (CEST)
In-Reply-To: <53C03FBB.1080807@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253384>

Hello Hannes,

> Am 10.07.2014 22:05, schrieb Johannes Sixt:
> > It looks like I totally missed the topic sk/mingw-unicode-spawn-args.
...
> > Am I doing something wrong? Does the topic depend on a particular
> > version of MSYS (or DLL)?

unfortunately, I paused my submissions at random point.

I'm sorry for breaking your setup.  I was not aware there is any
working Windows setup beyond msysGit.  Thus I did not object when the
half-done work was going to be moved ot master.

I'll try to submit the patches needed so that your setup works again.

Karsten writes:
> At first glance, t0050 seems to fail because the unicode file
> name patches are still missing.

Indeed, this is a pair of patches on the tip of my queue.

> t4041 tries to pass ISO-8859-1 encoded bytes on the command line,
> which simply doesn't work on Windows (all OS APIs 'talk' UTF-16).
> We have a fix for this in the msysgit fork [1] (but unfortunately
> in another branch, so Stepan couldn't know the patch is related).

There is a whole branch named win-tests or some such.  I remember I
was hunting for not-yet resolved instances of this bug.  This
convinced me that the test suite of vanilla git cannot work on
Windows.  I was not aware about the fact that this problem was masked
in the versions before Karsten's unicode patches.

Hannes, I'd like to submit the patches mentioned here during the
following week and I'd be glad to hear from you.

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
