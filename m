From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Git for Windows 1.9.4
Date: Thu, 12 Jun 2014 16:37:10 +0200
Message-ID: <5399BB16.9080207@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>
To: msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCL7JHHTPAIJX5XGTQCRUBAVMXDZS@googlegroups.com Thu Jun 12 16:37:16 2014
Return-path: <msysgit+bncBCL7JHHTPAIJX5XGTQCRUBAVMXDZS@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f189.google.com ([74.125.82.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL7JHHTPAIJX5XGTQCRUBAVMXDZS@googlegroups.com>)
	id 1Wv67v-0006S5-Rh
	for gcvm-msysgit@m.gmane.org; Thu, 12 Jun 2014 16:37:15 +0200
Received: by mail-we0-f189.google.com with SMTP id q58sf140329wes.16
        for <gcvm-msysgit@m.gmane.org>; Thu, 12 Jun 2014 07:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=3WOv1yQiqNNCFWl6IodA0Qs3ribyN+LQAfo1+dCYBlc=;
        b=zLb8x54iKjq/lST8PjUxfKOHvzoCe1E6CYveq2D8K7i5DDRwihQwjWJ5obhZgPH9I8
         kXJPmzjvrx0YA2RArQf9i1/6K9Qafp5qxVKey6i/xha5J2a7tz2b2BciPssDthw8ce8T
         OilnaSdUmk2YU0xMAqOXpdmJIgoE8oPXcyr7NswhhS43Wj2AfKyaAGKA7VXYrgvhR4LH
         eWD+GHooYqmE44DT2IoHY9sjuQyYHr2/3xeBzylytnKhxQgm5lo66cRsEAAN/qUuTyTF
         /Gle3Ic1gigwKuIY78wxeDEc2cTzJw+9MxeJIVnmpRRM7Qh7kX2ARV8SQgy6TB7fOPIP
         udpw==
X-Received: by 10.180.99.197 with SMTP id es5mr20111wib.9.1402583835517;
        Thu, 12 Jun 2014 07:37:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.182.130 with SMTP id ee2ls260653wic.48.gmail; Thu, 12 Jun
 2014 07:37:14 -0700 (PDT)
X-Received: by 10.180.206.33 with SMTP id ll1mr508046wic.5.1402583834677;
        Thu, 12 Jun 2014 07:37:14 -0700 (PDT)
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de. [2a01:488:42::50ed:84a3])
        by gmr-mx.google.com with ESMTPS id eh2si204689wib.2.2014.06.12.07.37.13
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 12 Jun 2014 07:37:13 -0700 (PDT)
Received-SPF: none (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted sender hosts) client-ip=2a01:488:42::50ed:84a3;
Received: from p5ddc3c49.dip0.t-ipconnect.de ([93.220.60.73] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1Wv67q-0000H4-FI; Thu, 12 Jun 2014 16:37:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1402583833;90b0f70e;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251409>

Hi,

the Git for Windows team just released version 1.9.4 of the
Windows-specific installers.

It can be downloaded from the usual place [1].

New Features
* Comes with Git 1.9.4 plus Windows-specific patches

Bugfixes
* Upgrade openssl to 0.9.8za [2]
* Config option to disable side-band-64k for transport [3]
* Make git-http-backend, git-http-push, git-http-fetch
  available again [4]

Have phun,
Thomas

[1]:
https://github.com/msysgit/msysgit/releases/download/Git-1.9.4-preview20140611/Git-1.9.4-preview20140611.exe
[2]: https://github.com/msysgit/msysgit/pull/212
[3]: https://github.com/msysgit/git/issues/101
[4]: https://github.com/msysgit/git/issues/174

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
