From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: 3rd release candidate of Git for Windows 2.x, was Re:
 Release candidate of Git for Windows 2.x is out
Date: Sat, 20 Jun 2015 16:16:03 +0200
Organization: gmx
Message-ID: <b085dab2e617742b690ccb99ba4a3076@www.dscho.org>
References: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>, msysgit@googlegroups.com,
 git-for-windows@googlegroups.com
X-From: msysgit+bncBCZPH74Q5YNRBJ7LSWWAKGQE5CS3Z4Q@googlegroups.com Sat Jun 20 16:16:09 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBJ7LSWWAKGQE5CS3Z4Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f188.google.com ([209.85.217.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBJ7LSWWAKGQE5CS3Z4Q@googlegroups.com>)
	id 1Z6JZ2-0001D9-Nd
	for gcvm-msysgit@m.gmane.org; Sat, 20 Jun 2015 16:16:08 +0200
Received: by lbiv13 with SMTP id v13sf38391850lbi.1
        for <gcvm-msysgit@m.gmane.org>; Sat, 20 Jun 2015 07:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:date:from:to:subject:organization
         :in-reply-to:references:message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=BpvvVMdliLODe6ejsr8EA7iqAw+njpAw1VzdFvAyrkk=;
        b=Bckd+rVsRz2P56UDfSNdvdkM+ww6cxke7WuELcR2avaS4vcn1Y9HgNxi7b9wr3tbxH
         QE4GQF3QDMs3sJ4WIamYTeAgeHRZLFKi/12rVYisYjtZncZoyWsUPkxisLEJZ+GyiPhT
         tGLT2M4wxkhZgjkb2QafsNgGFeJ1DvpcYdCcax1bkd1vHdWe4+Wz6jv3qttCZUvhpThz
         pa0H3ckrn+0a1J6/rMai6gNIVN0EyubJ0PZj4pGesQZg68GYtIUWrgubcjR2ibSAN5N8
         +fWQJ1Xo37nvRd4S+uESX16LRIEOdEejykCpLYn8tDpkTNdA7qdZzO3a7QDTNK3Q+Uiz
         y0Rw==
X-Received: by 10.180.8.73 with SMTP id p9mr52786wia.18.1434809768391;
        Sat, 20 Jun 2015 07:16:08 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.37.177 with SMTP id z17ls390460wij.6.canary; Sat, 20 Jun
 2015 07:16:07 -0700 (PDT)
X-Received: by 10.180.97.9 with SMTP id dw9mr8025671wib.2.1434809767565;
        Sat, 20 Jun 2015 07:16:07 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTPS id wf6si596678lbb.2.2015.06.20.07.16.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jun 2015 07:16:07 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.15 as permitted sender) client-ip=212.227.15.15;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MYwyp-1ZbGi036EF-00VkNj; Sat, 20 Jun 2015 16:16:03
 +0200
In-Reply-To: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:MFlDhWEIw18LtNAlOP0rjpSpCD/IUiFcRFaBpYqoNHpIBbW2EDA
 YQ1I1Y+/nM1lb20TI8VDuyClVYzfJI7U1u5vuoxtYUayTW/In3Y8U/6ygv/zQneMH31bcD8
 Gc3+smO46U5IOTciwaDHnSRttlMHIJK6BaoK2Ncv7oksMXctWCWwNtDgnlg/m24zq2T4tpK
 vw6c7S74pL882ZWSawPOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nl16Qo6CL1w=:JSHWphxZUqWf2JGUyM7eP9
 xiGbTQxkQIle70CVkginePNY7adjF12yMyjskhBJ6YgmPmPhxc3dnDT9/QwEaV5G18qbEOpFn
 MqD8k+1J9WFOgPuL8wm+Bt0xHG+VR2YUDwvxToBWqV1G5c6LjuYdRDVdhWIDHBbG4JTbmUbV8
 Ng2vb7f03iN5zSudxnYf6mRo0XSr757gfyzQ5SkR4PoNlxff35OtulParXPlbiN481ud7PR6Y
 86k5BGQ7YURVkkbTCImqj7VbvvthverXb2qotPPYOeLegq86YVX8aZfeOxlmizncPcT1OgiI4
 umi4HTfc/KatqhDuYn9Pqau5krwbBluwwOwVLGxjrdP1Yw7vnCyY6i3U76IYdZNG299jqfRBj
 8o/1e8arIlUD3+/kp8o4plRo3M3pbkxU9VITXIfwQeMmjTsJieCM+6YogGWDHzQxDnZaxVCvH
 Wn8rPO3Yct6cZ5U9ALvEOjUPURqbl0wWcYLD6CivPPDNGqaL0RuiFk/06AUHNEff9sbqsLAx+
 KxU6DTWbdwqNIjtkzMGgbM3zjhqPscnmE7IHolzlNjSwpoNkB9ogEG9sVUT5upRJ4u/ih+r5e
 ZnjMxeuwNflKgSHbN0kTnFh2ywvz+kYC8I+Pkq53Z291yxqGm0eRngdaGMzg7ATNrpm6nW9q2
 PGfrL7LDAxTdxf21UwU+GFjTvf9+LQGEbbQnpkz6kJGe41Jwjb/Gh5G9t9/gpfnf0/jw=
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.15 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272228>

Hi all,

I just uploaded the 3rd release candidate for the upcoming Git for Windows 2.x release. Please find the download link here:

https://git-for-windows.github.io/#download

Lots of changes since the first release candidate (v2.4.2, I was too swamped to announce the second release candidate -- v2.4.3 -- I published Friday last week, my apologies). Please find them in the release notes:

https://github.com/git-for-windows/build-extra/blob/master/installer/ReleaseNotes.md

We're getting closer!
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
