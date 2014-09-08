From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: BUG I can't start git on Windows 7
Date: Mon, 08 Sep 2014 15:21:15 +0200
Message-ID: <540DAD4B.9000208@virtuell-zuhause.de>
References: <CA+4EQ5eXQTVPz-20Y-k-sJMyVcvAeUXBm44LGYFuqmaEwgB3Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Petr Bena <benapetr@gmail.com>, git@vger.kernel.org, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCL7JHHTPAINFWVWUACRUBBHG3JJK@googlegroups.com Mon Sep 08 15:21:27 2014
Return-path: <msysgit+bncBCL7JHHTPAINFWVWUACRUBBHG3JJK@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f183.google.com ([74.125.82.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL7JHHTPAINFWVWUACRUBBHG3JJK@googlegroups.com>)
	id 1XQysn-0003ZF-Kt
	for gcvm-msysgit@m.gmane.org; Mon, 08 Sep 2014 15:21:25 +0200
Received: by mail-we0-f183.google.com with SMTP id w62sf1430367wes.20
        for <gcvm-msysgit@m.gmane.org>; Mon, 08 Sep 2014 06:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=X5EHysz7nnyRWDHX6MvceCg6iqu1uA0tSO8xO/PL3cA=;
        b=V+5MbbIns2vS+9OWdBRS8USPQ+Wni+TzB2cUkOYkBqPe42R3blJ+SWzrye04+LHZ/o
         CKwBGGTdC5bUj5/eD1UoVTdBsx37eF3kdakkMcCXPe9FpRVSo+t9lIEoE6yp6vRr7HN0
         nvhQNMFWnGA7HLghUFGsnfR1HGfIWERjR+vDEwc4dD54gjAMMfBsbqKWfH2yl6KebovG
         SWLUb0OZtYf0XMsyRMUkgC5hpusf+TDrshAVcwc0HMPct8gUBdErRTTBzi4GS7PXRUqH
         nHTAoPxHIzKIgDu9JFEz18A9ka3Db/rM8zBbIPC2WI8SJx60UeIYT2Hq2SoldGx+RAe6
         Y4Uw==
X-Received: by 10.153.7.72 with SMTP id da8mr2064lad.14.1410182484032;
        Mon, 08 Sep 2014 06:21:24 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.25.134 with SMTP id c6ls332408lag.37.gmail; Mon, 08 Sep
 2014 06:21:22 -0700 (PDT)
X-Received: by 10.112.190.102 with SMTP id gp6mr312549lbc.10.1410182482425;
        Mon, 08 Sep 2014 06:21:22 -0700 (PDT)
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de. [2a01:488:42::50ed:84a3])
        by gmr-mx.google.com with ESMTPS id pw5si1612396lbb.0.2014.09.08.06.21.20
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 08 Sep 2014 06:21:20 -0700 (PDT)
Received-SPF: none (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted sender hosts) client-ip=2a01:488:42::50ed:84a3;
Received: from p5ddc3a6f.dip0.t-ipconnect.de ([93.220.58.111] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1XQyse-000171-5D; Mon, 08 Sep 2014 15:21:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <CA+4EQ5eXQTVPz-20Y-k-sJMyVcvAeUXBm44LGYFuqmaEwgB3Rg@mail.gmail.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1410182480;af555fb9;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256644>

Am 08.09.2014 um 11:15 schrieb Petr Bena:
> I installed git on my system using official package from git-scm.com
> but I can't launch it, I am always getting this error:
> 
> C:\Users\petr.bena>"C:\Program Files (x86)\Git\bin\sh.exe" --login -i
>       0 [main] us 0 init_cheap: VirtualAlloc pointer is null, Win32 error 487
> AllocationBase 0x0, BaseAddress 0x68570000, RegionSize 0x40000, State 0x10000
> C:\Program Files (x86)\Git\bin\sh.exe: *** Couldn't reserve space for
> cygwin's heap, Win32 error 0
> 
> 
> At some point this could be an issue with cygwin, but I am not sure.
> Did anyone had similar issue?

[CC'ing msysgit]

Do you have cygwin installed, or why do you mention cygwin?
What windows are you running?


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
