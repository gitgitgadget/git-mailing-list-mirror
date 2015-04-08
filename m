From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re:
Date: Wed, 08 Apr 2015 23:58:58 +0200
Message-ID: <5525A4A2.9080405@virtuell-zuhause.de>
References: <CAM9_S8jip3q-vUWFHCWP6ia2wrKOxDpxz2zLSQZPQvAQ0xmKrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mamta Upadhyay <mamta.upadhyay@gmail.com>, 
 msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCL7JHHTPAIKJSMWVECRUBG7TBUVO@googlegroups.com Wed Apr 08 23:59:02 2015
Return-path: <msysgit+bncBCL7JHHTPAIKJSMWVECRUBG7TBUVO@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f184.google.com ([209.85.212.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL7JHHTPAIKJSMWVECRUBG7TBUVO@googlegroups.com>)
	id 1Yfxzx-0008KU-B5
	for gcvm-msysgit@m.gmane.org; Wed, 08 Apr 2015 23:59:01 +0200
Received: by wivr20 with SMTP id r20sf20934915wiv.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Apr 2015 14:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=g1S/nQ+664OcSA4+fybtMaNvWk2rS+K8qok6Y36M/rA=;
        b=tn6wcE4F0B6IzqQghsckZJ1KnKQkFtZWjj3oK9vIVJ4/q/WqW9ezxe7oU6hBSbs+CQ
         p0AdhnUhXfK7hBP7VXcMz46usYmowu0OVQMdso4Ib5T2xrmN0LWgGOlMsGpcFUzHF5Hl
         CONgKnnHIeFcBs1cej7YPwIh9zYr6x235a2PxfWXyVz2tYpWlvmj2GU02M33cu6FaFEd
         SodWE9MbAZovxxaDtWNprtn3DA0iWTbxDZ1HPv+AVCSEFMt9LDun/ECUctl4CUmsLVdc
         RydrgeyPBnVBsZUmyb0MCvSqzu13+QkZYgd4JBmsKp4apviywLpAdMijXf+ALhJWS1jA
         DKfA==
X-Received: by 10.152.20.169 with SMTP id o9mr38279lae.6.1428530340902;
        Wed, 08 Apr 2015 14:59:00 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.163.36 with SMTP id yf4ls242189lab.43.gmail; Wed, 08 Apr
 2015 14:58:59 -0700 (PDT)
X-Received: by 10.113.11.3 with SMTP id ee3mr3228205lbd.9.1428530339513;
        Wed, 08 Apr 2015 14:58:59 -0700 (PDT)
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de. [80.237.132.163])
        by gmr-mx.google.com with ESMTPS id ec7si689269wib.3.2015.04.08.14.58.59
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 Apr 2015 14:58:59 -0700 (PDT)
Received-SPF: none (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted sender hosts) client-ip=80.237.132.163;
Received: from p5ddc2858.dip0.t-ipconnect.de ([93.220.40.88] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1Yfxzv-00022L-3B; Wed, 08 Apr 2015 23:58:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAM9_S8jip3q-vUWFHCWP6ia2wrKOxDpxz2zLSQZPQvAQ0xmKrw@mail.gmail.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1428530339;65010aba;
X-Original-Sender: thomas.braun@virtuell-zuhause.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=none
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266975>

Am 08.04.2015 um 22:44 schrieb Mamta Upadhyay:
> Hi git team,

(CC'ing msysgit as this is the git for windows list)

Hi Mamta,

> I tried to research everywhere on a issue I am facing and emailing you
> as the last resource. This is critical for me and I needed your help.
> 
> I am trying to run the latest git 1.9.5 installer on windows. When I
> run strings on libneon-25.dll it shows this:
> 
> ./libneon-25.dll:            OpenSSL 1.0.1h 5 Jun 2014
> 
> But when I load this dll in dependency walker, it picks up
> msys-openssl 1.0.1m and has no trace of openssl-1.0.1h. My questions
> to you:
> 
> 1. Is libneon-25.dll statically linked with openssl-1.0.1h?
> 2. If not, where is the reference to 1.0.1h coming from?

I would be suprised if we link openssl statically into libneon. I guess
libneon just reports against which openssl version it was *built*.

> I am asked to rebuild git with libneon-25.dll linked against
> openssl-1.0.1m. But I am having a feeling that this is not needed,
> since libneon is already picking the latest openssl version. Can you
> please confirm?

You can download the development enviroment for git for windows here
[1]. After installation, checkout the msys branch and then you can try
to recomplile libneon using /src/subversion/release.sh.

[1]:
https://github.com/msysgit/msysgit/releases/download/Git-1.9.5-preview20150319/msysGit-netinstall-1.9.5-preview20150319.exe

Hope that helps
Thomas

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
