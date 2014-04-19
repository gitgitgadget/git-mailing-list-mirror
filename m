From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: Re: [ANNOUNCE] WinGit - native x86/x64 Git for Windows
Date: Sat, 19 Apr 2014 19:01:45 +0200
Message-ID: <5352ABF9.8080603@virtuell-zuhause.de>
References: <rfujmbew27f1gaa6dbk706li.1397911737867@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>, 
 Heiko Voigt <hvoigt@hvoigt.net>
X-From: msysgit+bncBCL7JHHTPAIIFWGKTICRUBGKMQ656@googlegroups.com Sat Apr 19 19:01:55 2014
Return-path: <msysgit+bncBCL7JHHTPAIIFWGKTICRUBGKMQ656@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f56.google.com ([209.85.215.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL7JHHTPAIIFWGKTICRUBGKMQ656@googlegroups.com>)
	id 1WbYeJ-0007LG-A5
	for gcvm-msysgit@m.gmane.org; Sat, 19 Apr 2014 19:01:55 +0200
Received: by mail-la0-f56.google.com with SMTP id hr17sf225163lab.11
        for <gcvm-msysgit@m.gmane.org>; Sat, 19 Apr 2014 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=pa8z77PEIGd5whpnBamekaiEf7PIvzf+zUBJgfLNtE4=;
        b=vkdzWxVSU2Tqg0+DqLFI4UxogCNPmNL6q7JDkpr7EnD9dja7NIBtPrtRsk9ylSl+SX
         4EYvNf3EntBgHU0h0pc6+99lwD72SEb2Bvy8BQ52jGFcWm58d+86YD1INyehFLBdPu9R
         yIyFaYfYwFzG5ysL4nw/IWtW04eD6LxC7iusSWTHbu4v7C0GUMYPl7uYpe0/Lztl4RX7
         lyhVVXyNX7KyKQrCVh6WpFJ6hVUCLu0SRMP9Vg2mFSXARpN0Z5qmOPdXBS5Wup8hcm0n
         fXX9ogcGue4UyiVDtaqcwZbTGSkYW24HtSrmnPwqkGi9LsQ4/VrN8ZvMfRDtov7PiBpZ
         8ZNQ==
X-Received: by 10.180.98.135 with SMTP id ei7mr45702wib.15.1397926914891;
        Sat, 19 Apr 2014 10:01:54 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.182.198 with SMTP id eg6ls196972wic.32.canary; Sat, 19 Apr
 2014 10:01:53 -0700 (PDT)
X-Received: by 10.180.37.203 with SMTP id a11mr648526wik.0.1397926913721;
        Sat, 19 Apr 2014 10:01:53 -0700 (PDT)
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de. [2a01:488:42::50ed:84a3])
        by gmr-mx.google.com with ESMTPS id u49si1854493eeo.1.2014.04.19.10.01.53
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 19 Apr 2014 10:01:53 -0700 (PDT)
Received-SPF: neutral (google.com: 2a01:488:42::50ed:84a3 is neither permitted nor denied by best guess record for domain of thomas.braun@virtuell-zuhause.de) client-ip=2a01:488:42::50ed:84a3;
Received: from p5ddc104b.dip0.t-ipconnect.de ([93.220.16.75] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1WbYeF-0002SE-Tq; Sat, 19 Apr 2014 19:01:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <rfujmbew27f1gaa6dbk706li.1397911737867@email.android.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1397926913;5dd681ad;
X-Original-Sender: thomas.braun@virtuell-zuhause.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 2a01:488:42::50ed:84a3 is neither permitted nor denied by best
 guess record for domain of thomas.braun@virtuell-zuhause.de) smtp.mail=thomas.braun@virtuell-zuhause.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246519>

Am 19.04.2014 15:35, schrieb Marat Radchenko:

>> So the reason for this new package is that you need 64bit
>> binaries?
> 
> That's the most important bit. Plus, weird ssh transfer speeds [1]
> caused by ansient openssh bundled in msysgit.

Yes the msysgit openssh is ancient and slow. Openssh in mingGitDevEnv
has proper speeds, see [1].

> 1) outdated msys that was patched in multiple ways without sending patches upstream
> 2) heavily patched git, again not upstreamed

You do realize how much work it is to send something upstream?
And in the case of mingw patches have been sent upstream which are still
either being reviewed or are just in a (presumably *very* long) queue.

>> Sorry if I am a little bit skeptic, but I am wondering whether it
>> does make sense for you to join forces with msysgit instead of
>> creating a fork?
> 
> 1) It makes sense to purge msysgit and start over. See mingwGitDevEnv
> [2] (by msysgit developer).

I would be happy to see you contributing to the mingGitDevEnv project.

> 2)  I only used msys due to my
> unawareness of msys2 at the time of  initial WinGit hacking. Due to
> massive Unicode-related msys troubles, ansient perl and svn, I plan
> to switch to msys2 soon.
> 
>> there are no 64 bit binaries shipped with msysgit is that nobody
>> needed them
> 
> That's wrong. Google for 'windows x64 git' or 'msysgit x64'. People
> need it. There's even an issue [3] (stalled several years ago) in
> msysgit tracker. After all, I needed it.
> 
> [1] https://github.com/msysgit/msysgit/issues/31 [2]:
> https://github.com/sschuberth/mingwGitDevEnv [3]:
> http://code.google.com/p/msysgit/issues/detail?id=396

Actually I would need a 64bit git for windows too. The problem here is
that of course everyone likes to have it, but nobody so desperatley what
he/she will start to make the test suite pass.
And before the test suite passes I don't think it is a good idea to use
it in production.
So for my part I decided to first get mingwGitDevEnv going and then
start thinking about a 64bit version.

[1]:
https://github.com/sschuberth/mingwGitDevEnv/pull/5#issuecomment-15128748

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
