From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5] MinGW(-W64) compilation
Date: Thu, 9 Oct 2014 12:59:28 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1410091258110.990@s15462909.onlinehome-server.info>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org> <alpine.DEB.1.00.1410091205560.990@s15462909.onlinehome-server.info> <20141009103921.GA18641@seldon>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org, gister@pobox.com, msysGit <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBCZPH74Q5YNRBL6V3GQQKGQESE54XRA@googlegroups.com Thu Oct 09 13:00:01 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBL6V3GQQKGQESE54XRA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f192.google.com ([209.85.217.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBL6V3GQQKGQESE54XRA@googlegroups.com>)
	id 1XcBRw-0005pq-My
	for gcvm-msysgit@m.gmane.org; Thu, 09 Oct 2014 13:00:00 +0200
Received: by mail-lb0-f192.google.com with SMTP id n15sf91041lbi.9
        for <gcvm-msysgit@m.gmane.org>; Thu, 09 Oct 2014 04:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=q7jYQ3kk9hMhDVffvuFwBZWGO5em2ZX5t/JSTHggbW4=;
        b=A0MuLxhCR+5wYchOPKg7IsnQDoIG7TezS1bi+iRW1mQI9oN2maMFflFn15VaZpVkSY
         f1OHBDBm7qhyMllWoqh9q4rIdV0Ym1J95B3Obu/hB8dXsM076LsJXmapFngUDbhidCZm
         QbpctYmQiYqMNgVOPqyZd8hqZNkJJSmgM0T77qEYt9027cyNt7lSjtrWOpYGrQ0lR0vi
         hvZ/PdoWJPJxKdzyQeatNBbP2QoZy95T04T7psWL2XATwzUtM/f9E33SuPoMPNImRUGk
         DRRfQqmJ/2qEJJAOrU/J6KrhqPEFYi23k1CUYtH5g9CgFB6oxaqP7Bw6vWZ5YS2DonuG
         ddCw==
X-Received: by 10.180.85.6 with SMTP id d6mr23010wiz.6.1412852400130;
        Thu, 09 Oct 2014 04:00:00 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.109.200 with SMTP id hu8ls247136wib.21.gmail; Thu, 09 Oct
 2014 03:59:59 -0700 (PDT)
X-Received: by 10.180.76.230 with SMTP id n6mr5450723wiw.0.1412852399533;
        Thu, 09 Oct 2014 03:59:59 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.22])
        by gmr-mx.google.com with ESMTPS id us10si416310lbc.1.2014.10.09.03.59.59
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Oct 2014 03:59:59 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.22 as permitted sender) client-ip=212.227.17.22;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0LnPnu-1Y7gAp1mzW-00hbIz;
 Thu, 09 Oct 2014 12:59:29 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20141009103921.GA18641@seldon>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:7SHG6OMOY8VlKhFHddxsedRZGjivLc5qjHBhbO85M+oknTn7wMA
 apGRLAbJ68Ikn1871owGttifc+7CsZul8mb0VvPhrCeOUz84/9eOiPzrD8aDUZ9nvieIlLe
 bTnyXAckK/tVFD+ZG5o7i/HZmoSzIhlNCX4oOnQQau68iEi0oA36Xke75qOdA4wca+wpO0R
 yyLqQYSFqPMk9SUB7tidQ==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.22 as
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

Hi Marat,

On Thu, 9 Oct 2014, Marat Radchenko wrote:

> On Thu, Oct 09, 2014 at 12:11:01PM +0200, Johannes Schindelin wrote:
> > I also added one patch I find highly convenient:
> > 
> > https://github.com/dscho/git/commit/29749c7d7b4638c63369d6cf067f5d524d0092f9
> 
> There already were two attempts to this issue:
> 
>  1. http://www.spinics.net/lists/git/msg230028.html
>  2. http://www.spinics.net/lists/git/msg229822.html
> 
> Neither of them was accepted to git.git. I doubt your one will be.

I would guess that they were not accepted mostly because they were not
coordinated with the Windows developers on the msysGit mailing list.

Let's fix the rest of the issues, and then we can always carry this patch
in Git for Windows until MinGW-w64 3.1.1 (or 3.2.0) is released.

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
