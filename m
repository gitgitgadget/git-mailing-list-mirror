From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Git for Windows 1.9.4.msysgit.2
Date: Tue, 30 Sep 2014 00:38:53 +0200
Message-ID: <5429DF7D.3080609@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>
To: msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCL7JHHTPAIIBP5HUECRUBHQU73TG@googlegroups.com Tue Sep 30 00:39:01 2014
Return-path: <msysgit+bncBCL7JHHTPAIIBP5HUECRUBHQU73TG@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f187.google.com ([74.125.82.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL7JHHTPAIIBP5HUECRUBHQU73TG@googlegroups.com>)
	id 1XYjas-0006mg-2s
	for gcvm-msysgit@m.gmane.org; Tue, 30 Sep 2014 00:38:58 +0200
Received: by mail-we0-f187.google.com with SMTP id w62sf1210289wes.14
        for <gcvm-msysgit@m.gmane.org>; Mon, 29 Sep 2014 15:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=MwqCpPKyTrZznqBGRJ5I+eoZ+v0YOecXnuixIvmS/cI=;
        b=Kd4Uhgnm/xy3Y+cqKs2WOywN7N2K00pbZl3BrYo/EIETzCz4/oO7KWZB/mikKSwy0w
         d1sDoG46PJGAFiWIqY95bhOTYGb8KI0iZvzFYLtZJuAPCVdlIuC/44ojtYlzI5hWkHJ+
         oH0DdYXroCT5U5Uulv9LINQhLPVYHHaNOm/X5JgjpDGmzGElObF8ow9Yw5a/QwRwusRw
         6P1ZDfg7g2GroETTCEgT2WbzzbtZ67gGiMAQ9hf6K+vYcwwzud38NKQg+MT0eumeX4YI
         3jNXvYJLZaKVYO5Zd8uWllmWwz8ktiAdls3gubCtoO0rGS5Gfh11NZg5JsfGwMpdFYRO
         iZiA==
X-Received: by 10.152.28.66 with SMTP id z2mr806499lag.3.1412030337658;
        Mon, 29 Sep 2014 15:38:57 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.10.173 with SMTP id j13ls426257lab.82.gmail; Mon, 29 Sep
 2014 15:38:55 -0700 (PDT)
X-Received: by 10.152.42.229 with SMTP id r5mr5846lal.8.1412030335366;
        Mon, 29 Sep 2014 15:38:55 -0700 (PDT)
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de. [2a01:488:42::50ed:84a3])
        by gmr-mx.google.com with ESMTPS id us10si1065065lbc.1.2014.09.29.15.38.55
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 29 Sep 2014 15:38:55 -0700 (PDT)
Received-SPF: none (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted sender hosts) client-ip=2a01:488:42::50ed:84a3;
Received: from p5ddc2874.dip0.t-ipconnect.de ([93.220.40.116] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1XYjan-00039z-LT; Tue, 30 Sep 2014 00:38:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1412030335;245e0158;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257641>

Hi,

the Git for Windows team just released the third maintenance release of
the Windows-specific installers for git 1.9.4.

It can be downloaded from the usual place [1] and I also attached some
unsigned SHA sums [2].

New Features
- Comes with Git 1.9.4 plus Windows-specific patches.

Bugfixes
- Update bash to patchlevel 3.1.20(4) (msysgit PR#254, msysgit issue #253).
  Fixes CVE-2014-6271, CVE-2014-7169, CVE-2014-7186 and CVE-2014-7187.
- gitk.cmd now works when paths contain the ampersand (&) symbol (msysgit PR #252)
- Default to automatically close and restart applications in silent mode installation type
- Git svn is now usable again (regression in previous update, msysgit PR#245)

Have phun,
Thomas

[1]: https://github.com/msysgit/msysgit/releases/download/Git-1.9.4-preview20140929/Git-1.9.4-preview20140929.exe
[2]: SHA1(Git-1.9.4-preview20140929.exe)= a7a50a18992a56de193e048b0205bf21b6721554
     SHA1(PortableGit-1.9.4-preview20140929.7z)= 4b0698f2bf96b0dd64ecec477b3db9e3b3d46085
     SHA1(msysGit-netinstall-1.9.4-preview20140929.exe)= 73ad668013941863e80e74bcf853d53eeed69714

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
