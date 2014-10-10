From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: msysgit works on wine
Date: Fri, 10 Oct 2014 14:02:52 +0200
Message-ID: <5437CAEC.1020902@virtuell-zuhause.de>
References: <CACsJy8BAv9Bv_jFgW3L3+WYQMUOwRCFQ0sdAxWWwC_TnzesBBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Duy Nguyen <pclouds@gmail.com>, 
 Git Mailing List <git@vger.kernel.org>,
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCL7JHHTPAIPPFO7UECRUBATOVITQ@googlegroups.com Fri Oct 10 14:03:10 2014
Return-path: <msysgit+bncBCL7JHHTPAIPPFO7UECRUBATOVITQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f190.google.com ([209.85.212.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL7JHHTPAIPPFO7UECRUBATOVITQ@googlegroups.com>)
	id 1XcYuX-00048k-Bh
	for gcvm-msysgit@m.gmane.org; Fri, 10 Oct 2014 14:03:05 +0200
Received: by mail-wi0-f190.google.com with SMTP id ho1sf136573wib.17
        for <gcvm-msysgit@m.gmane.org>; Fri, 10 Oct 2014 05:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=TGgbN1DalnBHHrQKL4Wzt2KW/xCvfkjwKKA1DItS3tg=;
        b=NGoerQrIPJuOLmRFawX8iX83J5t/IggrPtSQEukDLcrMXYRSbeQ+AO6WLg+1OAr6rj
         9CIjUaGrOMwV/Q3YFuiroSLoP3QVEPMCnOz7KO9Uo3F6fLAh5JCtzS3NYoERLaBQeOsH
         X7Nm7Al7w8YdM/jUF2iPeTBVmUzspQ3qtJmbt0WxbPqZak5JBw7bJ4XiwQVQuAY04fL6
         3O3ncbPN0BIHSxGEY1dpD1SblKEXYODRWiyZtYe+KjG59ZGU6TuQlefYhOqQg34YQdDw
         qQE5dyl6tzkmdh0SsAfY1s35yusgVa/9m2CLDkGZPmw8ZI0r3hUXjD1W/8tk2g19ZLMZ
         OLpQ==
X-Received: by 10.152.28.66 with SMTP id z2mr74580lag.3.1412942584524;
        Fri, 10 Oct 2014 05:03:04 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.197.68 with SMTP id is4ls288004lac.6.gmail; Fri, 10 Oct
 2014 05:03:02 -0700 (PDT)
X-Received: by 10.112.52.165 with SMTP id u5mr533613lbo.12.1412942582628;
        Fri, 10 Oct 2014 05:03:02 -0700 (PDT)
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de. [2a01:488:42::50ed:84a3])
        by gmr-mx.google.com with ESMTPS id rb5si280160lbb.0.2014.10.10.05.02.59
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 10 Oct 2014 05:02:59 -0700 (PDT)
Received-SPF: temperror (google.com: error in processing during lookup of thomas.braun@virtuell-zuhause.de: DNS timeout) client-ip=2a01:488:42::50ed:84a3;
Received: from p3ee2fddc.dip0.t-ipconnect.de ([62.226.253.220] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1XcYuP-000447-RU; Fri, 10 Oct 2014 14:02:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <CACsJy8BAv9Bv_jFgW3L3+WYQMUOwRCFQ0sdAxWWwC_TnzesBBQ@mail.gmail.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1412942579;1a95d142;
X-Original-Sender: thomas.braun@virtuell-zuhause.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=temperror
 (google.com: error in processing during lookup of thomas.braun@virtuell-zuhause.de:
 DNS timeout) smtp.mail=thomas.braun@virtuell-zuhause.de
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

Am 10.10.2014 um 13:58 schrieb Duy Nguyen:
> Just wanted to share that with at least wine 1.7.23 I can install
> msysgit using the netboot method, clone and build git ok. I had to do
> this to make gcc works actually, but it's probably no big deal
> 
> $ mkdir -p ~/.wine/drive_c/usr/libexec/gcc/mingw32 -p
> $ cp ~/.wine/drive_c/msysgit/mingw/bin/as.exe
> ~/.wine/drive_c/usr/libexec/gcc/mingw32/
> $ cp ~/.wine/drive_c/msysgit/mingw/bin/ld.exe
> ~/.wine/drive_c/usr/libexec/gcc/mingw32/
> 
> This may open a door for many people like me, who are interested in
> Windows support, but don't own a Windows license (and probably don't
> want to dual boot anyway). Of course tricky stuff would require real
> Windows, but this would help with most "standard" windows stuff.

Are you compiling git.git or msysgit.git?
And how about the test suite?

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
