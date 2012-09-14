From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Re: [PATCH/RFC] test-lib: add support for colors
 without tput
Date: Fri, 14 Sep 2012 21:15:45 +0200
Message-ID: <50538261.8060102@kdbg.org>
References: <1347640905-1400-1-git-send-email-kusmabite@gmail.com> <CABPQNSa1hEG_rB9hd8izW+iL1TQVAKu5W1=GbG20ROv-+DMgVg@mail.gmail.com> <CABPQNSaArMz8hTiNZyD__K8bjntUuFUvk7Ojpu6NeXWLkJSUiA@mail.gmail.com> <50536943.4030300@kdbg.org> <CABPQNSZeuG-J8nVH15hpsX+bkM3CPcUGBNgNOUp6AtTipSdVbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: kusmabite@gmail.com
X-From: msysgit+bncBCJYV6HBKQIOJBGOQICRUBCUESGU4@googlegroups.com Fri Sep 14 21:15:55 2012
Return-path: <msysgit+bncBCJYV6HBKQIOJBGOQICRUBCUESGU4@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-bk0-f58.google.com ([209.85.214.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIOJBGOQICRUBCUESGU4@googlegroups.com>)
	id 1TCbMn-0007aN-2p
	for gcvm-msysgit@m.gmane.org; Fri, 14 Sep 2012 21:15:53 +0200
Received: by bkcjf3 with SMTP id jf3sf792293bkc.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 14 Sep 2012 12:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=lR6GA6ID7AZWirbYeW9wrlhHagJLs71nAmLy8W0bh3M=;
        b=Xkbjkk9+oyfPx09H5thGfXJbObTgbKHdFkXnldgkacrPbWFOj0LiWJsNOVeHVRdelB
         x6pmqFIgjK3NKOY8mdcsfaG6+i4Qr7AAjywci5OX+gOkzxXrQpMDBxQIqE4iIzuKb/P0
         3/KfhLdKmFeBQOCDnOQCazt4mR+PHsh9AwoYjyw7uRYETkZXCSW8TH4hzEhDHi0G380N
         TbkfYJQuft0bu4/ktg5v2PohTHFz85PiAexyF1hgtMsg8KwtA4ehfJCbiBu1yo7qfbGB
         EWhG4voRgI1Qul7sDnxVCkTda/Sl8/PvjUtcZdcKHMs4XCxdY6sjclJRCTv58gEqu89p
         z3vg== 
Received: by 10.152.113.99 with SMTP id ix3mr96324lab.0.1347650149117;
        Fri, 14 Sep 2012 12:15:49 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.145.225 with SMTP id sx1ls697284lab.3.gmail; Fri, 14 Sep
 2012 12:15:47 -0700 (PDT)
Received: by 10.180.73.173 with SMTP id m13mr7479wiv.4.1347650147694;
        Fri, 14 Sep 2012 12:15:47 -0700 (PDT)
Received: by 10.180.73.173 with SMTP id m13mr7478wiv.4.1347650147686;
        Fri, 14 Sep 2012 12:15:47 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp4.bon.at. [195.3.86.186])
        by gmr-mx.google.com with ESMTPS id fb20si31447wid.3.2012.09.14.12.15.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Sep 2012 12:15:47 -0700 (PDT)
Received-SPF: neutral (google.com: 195.3.86.186 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.186;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D11162C4005;
	Fri, 14 Sep 2012 21:15:46 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 21B7A19F377;
	Fri, 14 Sep 2012 21:15:45 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120825 Thunderbird/15.0
In-Reply-To: <CABPQNSZeuG-J8nVH15hpsX+bkM3CPcUGBNgNOUp6AtTipSdVbQ@mail.gmail.com>
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com:
 195.3.86.186 is neither permitted nor denied by best guess record for domain
 of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205526>

Am 14.09.2012 20:11, schrieb Erik Faye-Lund:
> On Fri, Sep 14, 2012 at 7:28 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>>                         printf '\033[0;3%sm' "$2" ;;
> 
> Is there a reason for %s rather than %d? It seem it only takes
> integers,..

No reason. I just mechanically converted your original expression. But
there is no reason for my conversion, either, if it can be more or less
guaranteed that no arbitrary strings are passed in $2.

-- Hannes

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
