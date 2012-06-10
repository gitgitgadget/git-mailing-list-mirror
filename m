From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [PATCH] t0020: make sure the test file is lf to start with
Date: Sun, 10 Jun 2012 13:01:45 +0200
Message-ID: <4FD47E99.2000004@lyx.org>
References: <1339324352-7376-1-git-send-email-vfr@lyx.org> <alpine.DEB.1.00.1206101145550.16012@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncCKSyzO6oChCd_dH-BBoE48AqAQ@googlegroups.com Sun Jun 10 13:01:53 2012
Return-path: <msysgit+bncCKSyzO6oChCd_dH-BBoE48AqAQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f186.google.com ([74.125.82.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCKSyzO6oChCd_dH-BBoE48AqAQ@googlegroups.com>)
	id 1Sdfu4-0006op-Mp
	for gcvm-msysgit@m.gmane.org; Sun, 10 Jun 2012 13:01:52 +0200
Received: by wefh52 with SMTP id h52sf1578722wef.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 10 Jun 2012 04:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=rSp5i2orEqudLu8IgHJz3bG4Eg4p0AIj6ySpDOhWhi0=;
        b=ahq3oUauxmJSt6sQba17LEobB1FSQ2C3gdSiL0dKeFlxjD5OmoFX98NqbzQVZqGWkf
         nsVoLjU2NuCiXt2ruxyNL6URdSnR5L2/yZorg/s6XRiK+4l2MACpIUH56Z6oq8vhsVRB
         xky2mqNwJfVRoX9k0lZd9xlV2xb8WbsI4Ziqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-beenthere:received-spf:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to
         :x-gm-message-state:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=rSp5i2orEqudLu8IgHJz3bG4Eg4p0AIj6ySpDOhWhi0=;
        b=O5URlqF85vnvEf16qb4SOSFy8s6yDnzm2hfjSFHZlJIbZ+1cPl88glSok7edwPIoqd
         Ty+R/SIUTkxnrjp861KT8ZMfUGiSyxKUcCiLNsN6rY0s0uE1S0+zo2nYB2YYTVYDnool
         Z2pddYnVEQaWmAcw+oBda/HhE+1leM9R6eZHCJgEi3vICWdK4hQutDR9CaPa74TB5ZpV
         NCqYRBO4usMnD7+4NqeP4Qkh5d4hxKAWw0WyqhzqdaFUVqQVt6DoiFt7wWTZ4YSCDIMV
         mQzPx8CMCQ55mcXaZi4c3eABK6Ggs0BveTPjeFlz0skwvMdDlV0x 
Received: by 10.216.141.150 with SMTP id g22mr358412wej.25.1339326109232;
        Sun, 10 Jun 2012 04:01:49 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.37.139 with SMTP id y11ls1485642eea.4.gmail; Sun, 10 Jun
 2012 04:01:47 -0700 (PDT)
Received: by 10.14.101.2 with SMTP id a2mr3797642eeg.6.1339326107492;
        Sun, 10 Jun 2012 04:01:47 -0700 (PDT)
Received: by 10.14.101.2 with SMTP id a2mr3797641eeg.6.1339326107476;
        Sun, 10 Jun 2012 04:01:47 -0700 (PDT)
Received: from mail-ey0-f176.google.com (mail-ey0-f176.google.com [209.85.215.176])
        by gmr-mx.google.com with ESMTPS id b16si12134948eeg.3.2012.06.10.04.01.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Jun 2012 04:01:47 -0700 (PDT)
Received-SPF: neutral (google.com: 209.85.215.176 is neither permitted nor denied by best guess record for domain of vfr@lyx.org) client-ip=209.85.215.176;
Received: by eaab16 with SMTP id b16so1771986eaa.35
        for <msysgit@googlegroups.com>; Sun, 10 Jun 2012 04:01:47 -0700 (PDT)
Received: by 10.14.94.142 with SMTP id n14mr5404336eef.147.1339326107020;
        Sun, 10 Jun 2012 04:01:47 -0700 (PDT)
Received: from [192.168.1.6] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id c13sm40889191eeb.7.2012.06.10.04.01.45
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Jun 2012 04:01:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <alpine.DEB.1.00.1206101145550.16012@bonsai2>
X-Gm-Message-State: ALoCoQmIE5wmXe0j3CWfHo6aUbjWUPGigiIumZs+VYMqQUs5+wqwGgPZIUlj6vHjqcSbRDWlRxKs
X-Original-Sender: vfr@lyx.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com:
 209.85.215.176 is neither permitted nor denied by best guess record for
 domain of vfr@lyx.org) smtp.mail=vfr@lyx.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199586>

Op 10-6-2012 12:47, Johannes Schindelin schreef:
> Hi Vincent,
>
>> Because the eol-style is now wrong from the beginning, the later tests
>> '.gitattributes says two is binary' and 'checkout with existing
>> .gitattributes' fail.
> I wonder why it does not fail here:
>
> 	https://qa.nest-initiative.org/job/msysgit-test/24/console
>
> IOW I think there is a difference between the msysGit setup and your
> setup...

I compiled git using MSVC and try to run it in the Windows cmd prompt. 
Consequently it doesn't use the perl that is distributed with msysgit, 
but it uses the perl that I've installed on my Windows system 
(Strawberry Perl; http://strawberryperl.com/).

When I modify the paths such that git uses the perl.exe distributed with 
msysgit the tests run ok.

Vincent

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
