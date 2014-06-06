From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 0/5] Windows dirent patches
Date: Fri, 06 Jun 2014 18:33:27 +0200
Message-ID: <5391ED57.1000601@gmail.com>
References: <1402062201-9709-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>, GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCH3XYXLXQDBBVO2Y6OAKGQEKS5PIKQ@googlegroups.com Fri Jun 06 18:33:26 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBVO2Y6OAKGQEKS5PIKQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f190.google.com ([209.85.212.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBVO2Y6OAKGQEKS5PIKQ@googlegroups.com>)
	id 1Wsx53-0004mj-PK
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 18:33:25 +0200
Received: by mail-wi0-f190.google.com with SMTP id q5sf152297wiv.27
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=H22mCaVKvaDwhxjql3Xz5d9Cr/9269gKPL2BosGyRBQ=;
        b=BKtU2CejICMncy5DpCm/DtEoHOOyWBniscUEoGdxweyAIqTTNCm/vwsUlFmc2pGopH
         8gNBid4lC5+TWD5dBf4cwoSDXNm2M07mTv/tx0X+kuImVob/JUrVmooTn2q6vCQ4+Dyt
         ynnBuXC+HMHGNWtMCApz+rYiBcKjtRYBGg22Oky/COg/K1FZu3K/sVjintK2o61/RNGY
         oipO1BThWeUk6xl9iAvDo56Pp8ksHUtFa0NYc3LfIG3ZAV9zWWlCiedz3DiRJOZI2yt1
         FII5jf9zGEGj3IXCSUmWyCIsSwi+YG0QsQiVpubki56pNjmtpCGp4UJbmNMJZZMResp0
         7dMg==
X-Received: by 10.152.115.146 with SMTP id jo18mr32387lab.16.1402072405538;
        Fri, 06 Jun 2014 09:33:25 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.170.165 with SMTP id an5ls152794lac.19.gmail; Fri, 06 Jun
 2014 09:33:24 -0700 (PDT)
X-Received: by 10.112.155.67 with SMTP id vu3mr1678501lbb.9.1402072404505;
        Fri, 06 Jun 2014 09:33:24 -0700 (PDT)
Received: from mail-we0-x22b.google.com (mail-we0-x22b.google.com [2a00:1450:400c:c03::22b])
        by gmr-mx.google.com with ESMTPS id eh2si1364880wib.2.2014.06.06.09.33.24
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 09:33:24 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22b as permitted sender) client-ip=2a00:1450:400c:c03::22b;
Received: by mail-we0-f171.google.com with SMTP id w62so3084192wes.2
        for <msysgit@googlegroups.com>; Fri, 06 Jun 2014 09:33:24 -0700 (PDT)
X-Received: by 10.14.10.5 with SMTP id 5mr460963eeu.78.1402072404373;
        Fri, 06 Jun 2014 09:33:24 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id w9sm23846627eev.4.2014.06.06.09.33.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 09:33:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1402062201-9709-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22b
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250946>

Am 06.06.2014 15:43, schrieb Stepan Kasal:
> Hello,
> 
> This is a series of dirent modifications, 4 tiny ones and one bigger.
> As the date indicates, these are battle tested in mysgit for several years.
> 

The dates are actually missing from the patches, otherwise full ack from me. Thanks!

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
