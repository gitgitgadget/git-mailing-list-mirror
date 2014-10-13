From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: msysgit works on wine
Date: Mon, 13 Oct 2014 23:17:45 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1410132241590.990@s15462909.onlinehome-server.info>
References: <CACsJy8BAv9Bv_jFgW3L3+WYQMUOwRCFQ0sdAxWWwC_TnzesBBQ@mail.gmail.com> <5437CAEC.1020902@virtuell-zuhause.de> <CACsJy8DJ6SwHujLNx9fj2WazJk2E6HOhfpL60AY3QtMDx7200A@mail.gmail.com> <543BA350.2020503@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Duy Nguyen <pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>, 
    msysGit <msysgit@googlegroups.com>
To: Michael Stefaniuc <mstefani@redhat.com>
X-From: msysgit+bncBCZPH74Q5YNRBAED6GQQKGQENQOW3PA@googlegroups.com Mon Oct 13 23:17:54 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBAED6GQQKGQENQOW3PA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yh0-f57.google.com ([209.85.213.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBAED6GQQKGQENQOW3PA@googlegroups.com>)
	id 1Xdn05-0004Ez-PA
	for gcvm-msysgit@m.gmane.org; Mon, 13 Oct 2014 23:17:53 +0200
Received: by mail-yh0-f57.google.com with SMTP id f73sf1661618yha.12
        for <gcvm-msysgit@m.gmane.org>; Mon, 13 Oct 2014 14:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=lMgWZ+TKxpjd7YZpukDC0DZPReQ5BYtCUirbq1SQOqo=;
        b=mddBKcJbWR1jpXJ66hiMe1/xqt6jpPsf23ACHhuL0+kXQ/gXH++gyl225EerkLphok
         htrQt6bpjb+IPCJFGQSsZzjVwBeEM8jDlyY4/VDsYWgv6S4XioQR3vFbT4F9V2iuaLNj
         1nee0yVXQF2eW3w3Td8VSNu74N7ptx9LKrm0wYHUKdT2NvxdBVDMSptdTcCjknyjYcSy
         tO4y++xsnF0VaR+Ph6Z78dms+4mrZxB7hzf9+z24xWCiKjPc/25K51qfKstT0x58vcOv
         fHWwBTRgM4hkiZBSZDeXsl4JWFUgY/bOsEh4Cjq1tBVGpDIp8ZDzi+FCSU9m061hsQZU
         QbHA==
X-Received: by 10.140.20.175 with SMTP id 44mr15004qgj.4.1413235073017;
        Mon, 13 Oct 2014 14:17:53 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.105.227 with SMTP id c90ls1950763qgf.52.gmail; Mon, 13 Oct
 2014 14:17:52 -0700 (PDT)
X-Received: by 10.236.29.74 with SMTP id h50mr859744yha.8.1413235072534;
        Mon, 13 Oct 2014 14:17:52 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.18])
        by gmr-mx.google.com with ESMTPS id pk7si1624586pbc.2.2014.10.13.14.17.52
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Oct 2014 14:17:52 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.18 as permitted sender) client-ip=212.227.15.18;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MaqqY-1XtgDj2vEI-00KTpA;
 Mon, 13 Oct 2014 23:17:45 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <543BA350.2020503@redhat.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:ICIX/3MvAHBl9DXe5whhVMqlMNPUMzrNqTILe7VtctkwsxiHDW3
 6EMlOpwtOJZi+nfv34Ya0pKm9xe99rVnEX5OwUb/pyXknnNbyn65m+o8dPaWTFzH136eHdH
 zxSqtj4NDKDeVgpxgEwMyNHA90WZojp7WqFIqyP3Yk8oOfbREedIADSuD6vlVJYEJF/NoXZ
 WVYen1v6TUfvhG+lnYedg==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.18 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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

Hi Michael,

On Mon, 13 Oct 2014, Michael Stefaniuc wrote:

> On 10/10/2014 02:04 PM, Duy Nguyen wrote:
> > On Fri, Oct 10, 2014 at 7:02 PM, Thomas Braun
> >
> >> Are you compiling git.git or msysgit.git?
> > 
> > git.git
> > 
> >> And how about the test suite?
> > 
> > running right now, fingers crossed.. kinda slow, not sure if it's wine
> > or it's the msys thing.
>
> We (Wine) are interested in bug reports for git tests failing on Wine
> that succeed on Windows/Linux. Performance issues compared to Windows
> are highly desired too.

Awesome, thank you for the offer!

I haven't tried this in a long time, mainly because at some stage Wine
required a separate console from my terminal to run command-line programs.
And it seemed to me as if in particular process-spawning and heavy-duty
file system operations were the bottleneck.

Hopefully I will find some time soon to perform those tests again.

Ciao,
Johannes

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
