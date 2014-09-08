From: Petr Bena <benapetr@gmail.com>
Subject: Re: BUG I can't start git on Windows 7
Date: Mon, 8 Sep 2014 17:56:29 +0200
Message-ID: <CA+4EQ5cHx2Gz8CB_bCLrVNRpYEEr+vdJa5omgh1_5_3jj_q_sw@mail.gmail.com>
References: <CA+4EQ5eXQTVPz-20Y-k-sJMyVcvAeUXBm44LGYFuqmaEwgB3Rg@mail.gmail.com>
	<20140908193402.c755f942853c278c10b75c7d@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: msysgit+bncBCLOXUXL2AFRBLVDW6QAKGQEQADHYMQ@googlegroups.com Mon Sep 08 17:56:32 2014
Return-path: <msysgit+bncBCLOXUXL2AFRBLVDW6QAKGQEQADHYMQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f189.google.com ([209.85.216.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCLOXUXL2AFRBLVDW6QAKGQEQADHYMQ@googlegroups.com>)
	id 1XR1It-0006EV-MP
	for gcvm-msysgit@m.gmane.org; Mon, 08 Sep 2014 17:56:31 +0200
Received: by mail-qc0-f189.google.com with SMTP id w7sf3254664qcr.6
        for <gcvm-msysgit@m.gmane.org>; Mon, 08 Sep 2014 08:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=cNeCZu5VYCNKXzFm46Wh6PsHDe8bosvuHCrYqJo6VSU=;
        b=Wf6gn0XserwpWXZaKR8ksmfa3CihehT/TpO2QI3pjb0sPXnuaaEZgVpLV1tkWYIV9v
         2NfBRqASjyGAEmpZ4RIaiARV0sqxc0FwEWiKAFn0PQq3qyPbYUIXrxaPPThKbWVd9Wxf
         FrNe8/ah/bU/JWiggC7c0oyuhKsC3OoMx4sHvXfdrjV3FWLu83sZPlWjt9IqY+puANbc
         wp7OhMbhLgv9cK8CxzCOhfIQDMGXFjHnC7yGREnJLCRoXlFjKFWPR4zh9nnnm4rmGSGp
         4hsjZ+MN2oLZQ6xMG7hVjaN9anXjccAdl+yXPmG9rfgk4zWejAfpCsM1Dbs74BGtLVL5
         Z+VQ==
X-Received: by 10.182.131.166 with SMTP id on6mr21355obb.24.1410191790867;
        Mon, 08 Sep 2014 08:56:30 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.209.97 with SMTP id ml1ls656065obc.74.gmail; Mon, 08 Sep
 2014 08:56:29 -0700 (PDT)
X-Received: by 10.182.28.102 with SMTP id a6mr4989360obh.44.1410191789854;
        Mon, 08 Sep 2014 08:56:29 -0700 (PDT)
Received: from mail-vc0-x22e.google.com (mail-vc0-x22e.google.com [2607:f8b0:400c:c03::22e])
        by gmr-mx.google.com with ESMTPS id ew8si343704vdb.1.2014.09.08.08.56.29
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 08 Sep 2014 08:56:29 -0700 (PDT)
Received-SPF: pass (google.com: domain of benapetr@gmail.com designates 2607:f8b0:400c:c03::22e as permitted sender) client-ip=2607:f8b0:400c:c03::22e;
Received: by mail-vc0-f174.google.com with SMTP id hy10so1292502vcb.5
        for <msysgit@googlegroups.com>; Mon, 08 Sep 2014 08:56:29 -0700 (PDT)
X-Received: by 10.52.0.132 with SMTP id 4mr21757458vde.10.1410191789632; Mon,
 08 Sep 2014 08:56:29 -0700 (PDT)
Received: by 10.221.10.69 with HTTP; Mon, 8 Sep 2014 08:56:29 -0700 (PDT)
In-Reply-To: <20140908193402.c755f942853c278c10b75c7d@domain007.com>
X-Original-Sender: benapetr@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of benapetr@gmail.com designates 2607:f8b0:400c:c03::22e
 as permitted sender) smtp.mail=benapetr@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256655>

Yes that fixed it, thanks :)

On Mon, Sep 8, 2014 at 5:34 PM, Konstantin Khomoutov
<flatworm@users.sourceforge.net> wrote:
> On Mon, 8 Sep 2014 11:15:44 +0200
> Petr Bena <benapetr@gmail.com> wrote:
>
>> I installed git on my system using official package from git-scm.com
>> but I can't launch it, I am always getting this error:
>>
>> C:\Users\petr.bena>"C:\Program Files (x86)\Git\bin\sh.exe" --login -i
>>       0 [main] us 0 init_cheap: VirtualAlloc pointer is null, Win32
>> error 487 AllocationBase 0x0, BaseAddress 0x68570000, RegionSize
>> 0x40000, State 0x10000 C:\Program Files (x86)\Git\bin\sh.exe: ***
>> Couldn't reserve space for cygwin's heap, Win32 error 0
>>
>>
>> At some point this could be an issue with cygwin, but I am not sure.
>> Did anyone had similar issue?
>
> Does [1] help?
>
> I wonder, why the error message mentions Cygwin though.
> One reason might be is that MinGW is originally a fork of some very
> early Cygwin release so may be some error message is lingering there,
> unmodified.
>
> 1. http://stackoverflow.com/a/24406417/720999

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
