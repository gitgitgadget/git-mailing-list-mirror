From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: BUG I can't start git on Windows 7
Date: Mon, 08 Sep 2014 18:02:35 +0200
Message-ID: <540DD31B.20404@virtuell-zuhause.de>
References: <CA+4EQ5eXQTVPz-20Y-k-sJMyVcvAeUXBm44LGYFuqmaEwgB3Rg@mail.gmail.com> <20140908193402.c755f942853c278c10b75c7d@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>, 
 Petr Bena <benapetr@gmail.com>
X-From: msysgit+bncBCL7JHHTPAIKBJVXUACRUBDBLBX6O@googlegroups.com Mon Sep 08 18:02:45 2014
Return-path: <msysgit+bncBCL7JHHTPAIKBJVXUACRUBDBLBX6O@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f57.google.com ([74.125.82.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL7JHHTPAIKBJVXUACRUBDBLBX6O@googlegroups.com>)
	id 1XR1Or-00009k-Ul
	for gcvm-msysgit@m.gmane.org; Mon, 08 Sep 2014 18:02:41 +0200
Received: by mail-wg0-f57.google.com with SMTP id m15sf181319wgh.12
        for <gcvm-msysgit@m.gmane.org>; Mon, 08 Sep 2014 09:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=mEpFDeVeHHwooIinDr73k0jr8PnuSCF9cBTpyPKWsDs=;
        b=QL/baxC7Nd5x85T6WeUXHmJmUkEidmQ0u9omAzcSQPT4vyzh9dH9GWvXT/ssoU3O/c
         ggGEhjNvr/riqnQ/e2X7kojwv+xbomWCHHAOo1r5UzgkZ/b15CvgPT6TKu1UCJeStoer
         mmvMMT/lJinEq6fqba7mxZwn2qDknuBkQeoxT1SOEmwoRWnURw9DOerwKhYyFQWdi3sW
         wOdWRbAMvQgdK94dp1N9bq1aF39O+EY1kiTEgFwB8OPxJW3bv0GWLOIMbZIzniWSe4um
         nMOEtZrETm4yWCSkX5F4YdfxnYBkYauwyufvoENPvWFcYuvq7GN2Ar32Zw/iOH4i/fyV
         Agfg==
X-Received: by 10.152.8.11 with SMTP id n11mr393366laa.2.1410192161150;
        Mon, 08 Sep 2014 09:02:41 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.205.68 with SMTP id le4ls339029lac.87.gmail; Mon, 08 Sep
 2014 09:02:39 -0700 (PDT)
X-Received: by 10.112.182.8 with SMTP id ea8mr429062lbc.11.1410192159373;
        Mon, 08 Sep 2014 09:02:39 -0700 (PDT)
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de. [2a01:488:42::50ed:84a3])
        by gmr-mx.google.com with ESMTPS id b6si1257443lbd.1.2014.09.08.09.02.39
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 08 Sep 2014 09:02:39 -0700 (PDT)
Received-SPF: none (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted sender hosts) client-ip=2a01:488:42::50ed:84a3;
Received: from p5ddc3a6f.dip0.t-ipconnect.de ([93.220.58.111] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1XR1Ol-00014G-Gr; Mon, 08 Sep 2014 18:02:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <20140908193402.c755f942853c278c10b75c7d@domain007.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1410192159;a29ba86a;
X-Original-Sender: thomas.braun@virtuell-zuhause.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256657>

Am 08.09.2014 um 17:34 schrieb Konstantin Khomoutov:
> I wonder, why the error message mentions Cygwin though.

This is a leftover. Msys was forked from cygwin some time ago.

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
