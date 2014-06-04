From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: Re: [PATCH] t5000, t5003: do not use test_cmp to
 compare binary files
Date: Wed, 04 Jun 2014 14:59:44 +0200
Message-ID: <538F1840.7010803@virtuell-zuhause.de>
References: <20140604114252.GA22250@camelia.ucw.cz> <538F0D78.3020708@virtuell-zuhause.de> <20140604124257.GA22415@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>, msysgit@googlegroups.com
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCL7JHHTPAIMXMF4TQCRUBF33FD6Q@googlegroups.com Wed Jun 04 14:59:58 2014
Return-path: <msysgit+bncBCL7JHHTPAIMXMF4TQCRUBF33FD6Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f190.google.com ([209.85.217.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL7JHHTPAIMXMF4TQCRUBF33FD6Q@googlegroups.com>)
	id 1WsAnM-0000Ey-NA
	for gcvm-msysgit@m.gmane.org; Wed, 04 Jun 2014 14:59:56 +0200
Received: by mail-lb0-f190.google.com with SMTP id p9sf728323lbv.17
        for <gcvm-msysgit@m.gmane.org>; Wed, 04 Jun 2014 05:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=DOd6qQv0CMiEpuKVN73O621Ih+tXtRxwTxyGXtqJxn4=;
        b=FEgU6p+OyWM2GzBubagx/s46gn4emPcs14RV2heszOZvNn5YHulcnfjbdlp56C892a
         RwxDyrW3Q5ywPZU2dikt06Qw51AG3Q57WfofeyRU2Wd7+M43dSzYGdBImtUXyQeHjOmL
         4Rr2QoSb8pVblTsCKB/sOiTNQ8uOO1mt9uwaqMIcXzCDKlNeIQ6pCqXmGTdXaXnK+8SY
         FvJIqGLRGNixiZ3Uq+qz99lkjEoiTxLYkmhDxfLIW97O8o3l4vLCPZim2rqScM5PKUnh
         sqDupc2ID4PhD3HroWpNtnCzwKlwMFuEn+kh7He4mWeiPXg89zJXf5dYFVLO70a2GYjB
         J0NA==
X-Received: by 10.180.126.6 with SMTP id mu6mr9330wib.2.1401886795989;
        Wed, 04 Jun 2014 05:59:55 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.100.193 with SMTP id fa1ls275804wib.43.canary; Wed, 04 Jun
 2014 05:59:54 -0700 (PDT)
X-Received: by 10.14.29.71 with SMTP id h47mr444346eea.6.1401886794701;
        Wed, 04 Jun 2014 05:59:54 -0700 (PDT)
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de. [2a01:488:42::50ed:84a3])
        by gmr-mx.google.com with ESMTPS id m20si390605wij.1.2014.06.04.05.59.53
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 04 Jun 2014 05:59:53 -0700 (PDT)
Received-SPF: none (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted sender hosts) client-ip=2a01:488:42::50ed:84a3;
Received: from p5ddc323a.dip0.t-ipconnect.de ([93.220.50.58] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1WsAnC-0004Wc-FV; Wed, 04 Jun 2014 14:59:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140604124257.GA22415@camelia.ucw.cz>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1401886793;e5005a8a;
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
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250726>

Hi Stephan,

Am 04.06.2014 14:42, schrieb Stepan Kasal:
> On Wed, Jun 04, 2014 at 02:13:44PM +0200, Thomas Braun wrote:
>> Wouldn't a function like test_cmp_bin() be better suited for all?
>
> I also considered it.  The advantage is that is shows that
> this intentionally differs from test_cmp.
>
>> The windows folks can then use cmp inside test_cmp_bin() and all others
>
> ... would use cmp as well because it is better suited for the task
> than diff -u.  So test_cmp_bin would be just an alias for cmp, on all
> platforms.  Doesn't that sound weird?

I actually like the idea that the test assertions follow a common naming
scheme and can easily be overriden by $arbitrary-crazy-platform.

Using test_cmp_bin instead of cmp would result in then four assertions
for comparing arbitrary data
test_cmp
test_18ncmp
test_cmp_text
test_cmp_bin
where I think the purpose of each function is clear from its name.

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
