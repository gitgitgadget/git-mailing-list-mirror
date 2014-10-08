From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [PATCH v4] MinGW(-W64) compilation
Date: Wed, 8 Oct 2014 12:52:41 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1410081251450.990@s15462909.onlinehome-server.info>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org> <543472A0.3020401@virtuell-zuhause.de> <20141008045330.GA5672@seldon> <alpine.DEB.1.00.1410081055320.990@s15462909.onlinehome-server.info> <20141008093258.GA6393@seldon>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Thomas Braun <thomas.braun@virtuell-zuhause.de>, git@vger.kernel.org, 
    msysGit <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBCZPH74Q5YNRB65O2SQQKGQEHJA3DOY@googlegroups.com Wed Oct 08 12:52:45 2014
Return-path: <msysgit+bncBCZPH74Q5YNRB65O2SQQKGQEHJA3DOY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f191.google.com ([209.85.212.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRB65O2SQQKGQEHJA3DOY@googlegroups.com>)
	id 1XborN-0001m9-9Y
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 12:52:45 +0200
Received: by mail-wi0-f191.google.com with SMTP id hi2sf558426wib.18
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 03:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=64DtZasZFxgfEeF4U7jOlUF7U1ly6Mewrm52Q16/dDQ=;
        b=JwKsZZHXm+yuaGTd1YRScuHI2FcCHgGzBcAMGTVPNzShBU6XI3PJn6anVGTEJOVMo+
         NCOen/3O4PaI8JuXSsBte3F/nU2Z2wiQG6pb3tRrVi3w4U9reiIxnrA85hdrpgmzChi9
         Xe/QHJqY3y0rB/lbnMV3//Ci7Vxj68HdoAWor9r60XE4n6xDGq8taV78HOCGh0nWuHXv
         40gPQTwYyzNDvcNYRKkg86T9WFBjER9AZ68d9ac7ITNvc0OgjMpV/bm98NsIdRHIiW0O
         +W5JaqXWsIz/A5X4xXo/iugWOaovu/2gCLALJxo6endmcSeemrnbsRcN5XYGMhjpwub3
         blyg==
X-Received: by 10.152.19.97 with SMTP id d1mr137633lae.1.1412765565033;
        Wed, 08 Oct 2014 03:52:45 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.29.8 with SMTP id f8ls44432lah.85.gmail; Wed, 08 Oct 2014
 03:52:43 -0700 (PDT)
X-Received: by 10.152.2.97 with SMTP id 1mr287751lat.6.1412765563128;
        Wed, 08 Oct 2014 03:52:43 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTPS id rb5si2348812lbb.0.2014.10.08.03.52.43
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2014 03:52:43 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as permitted sender) client-ip=212.227.15.15;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0MBmvH-1XSDnx148l-00AqkB;
 Wed, 08 Oct 2014 12:52:42 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20141008093258.GA6393@seldon>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:JY68fC/GZce2/Q/yPT0w2rAlY8yT5sV4UPEnrRY6QS9H99KMSUM
 kgIQkd5WN+EhcjxZ4HaaKilujTnkJGhUyhOK9ITxR/Yk1YmEsZnthQp7uxgLj+EhSr4wAoQ
 QtdaAiE5qHkVgyYmf6MdZM8ojdqNEbQTmm7U95J6L9CTQhQxAJYWicSnKYvOFwdQ7RpW1+m
 DFZdH1koF8PpJ8NyQFUdA==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as
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

On Wed, 8 Oct 2014, Marat Radchenko wrote:

> On Wed, Oct 08, 2014 at 10:59:57AM +0200, Johannes Schindelin wrote:
>
> > So the idea would be to rebase from git/git/master onto
> > msysgit/git/master. Did you do that yet?
> 
> No, what for?

To work together?

If you are not interested in working together to make Git on 64-bit
Windows kick-ass, just say so.

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
