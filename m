From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Same test-path-utils behaves differently on different
 Windows systems
Date: Thu, 10 Oct 2013 22:04:48 +0200
Message-ID: <52570860.3060503@kdbg.org>
References: <CAHGBnuNaVWxa2kNqf3n9GmZZxFryLfJqKB5TxmDK5BiG5x53VQ@mail.gmail.com> <CAHGBnuORD-nTaYVVMt5WJhFnHU4oj0=5WiLXMAMa2Y4mz-vNXg@mail.gmail.com> <5256EA82.7020504@kdbg.org> <CAHGBnuO8ATSQu6HpJTm8bBg0akm+LUsZGRFoZPhzs89q7gTWqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: worldhello.net@gmail.com, 
 Thomas Braun <thomas.braun@virtuell-zuhause.de>,
 Git Mailing List <git@vger.kernel.org>, 
 msysGit Mailinglist <msysgit@googlegroups.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: msysgit+bncBCJYV6HBKQIOHEG4SICRUBDWRYX3S@googlegroups.com Thu Oct 10 22:04:52 2013
Return-path: <msysgit+bncBCJYV6HBKQIOHEG4SICRUBDWRYX3S@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f62.google.com ([209.85.215.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIOHEG4SICRUBDWRYX3S@googlegroups.com>)
	id 1VUMTc-0001p1-HP
	for gcvm-msysgit@m.gmane.org; Thu, 10 Oct 2013 22:04:52 +0200
Received: by mail-la0-f62.google.com with SMTP id ep20sf288774lab.17
        for <gcvm-msysgit@m.gmane.org>; Thu, 10 Oct 2013 13:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=R4HKZqn/9rLtgwsAc8G5G4IxcMHWZ9fCMMmBcOZigFI=;
        b=MeUq/6TK4n9FoYZDim9HXP9KG3vIp4QqNF8T2uLanHGaIggfeQe1/ILf8lU5aKj/84
         20l/7xdI2fGU4a/kEQzf4BeiUbN04EtXqvMxBnmUxPjRu5o5oOWO+X/JB43gF/jPyyC1
         Bnlw/5y2UxhPscMcUrzzig3mBp2X8TrdKpW2MDKX7JZMvXYMEkuDkDrpP9LyAqoL2cGg
         XlvuWYLLwmrSEkY/orWKdnyu3R+crcWQ1ItVf5RjHFjch4Bq6Gws3KGf7mv8dTwar4ck
         GVjD/E0Dyu+6Idg22LkPn8IdgwIlMT+BRofmZveqWj7kWt3lVAbbYAnXHOQykkqzIgZE
         oaXw==
X-Received: by 10.180.19.100 with SMTP id d4mr1034wie.20.1381435492205;
        Thu, 10 Oct 2013 13:04:52 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.205.6 with SMTP id lc6ls29050wic.25.gmail; Thu, 10 Oct
 2013 13:04:51 -0700 (PDT)
X-Received: by 10.15.99.195 with SMTP id bl43mr10391020eeb.3.1381435491474;
        Thu, 10 Oct 2013 13:04:51 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp5.bon.at. [195.3.86.187])
        by gmr-mx.google.com with ESMTPS id a1si1341302ees.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 13:04:51 -0700 (PDT)
Received-SPF: neutral (google.com: 195.3.86.187 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.187;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3CBA2CDF8C;
	Thu, 10 Oct 2013 22:04:50 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 4E2CC19F646;
	Thu, 10 Oct 2013 22:04:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CAHGBnuO8ATSQu6HpJTm8bBg0akm+LUsZGRFoZPhzs89q7gTWqQ@mail.gmail.com>
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 195.3.86.187 is neither permitted nor denied by best guess
 record for domain of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235878>

Am 10.10.2013 21:47, schrieb Sebastian Schuberth:
> So the obvious thing would be to replace /a/b/ with
> /foo/bar/ in the tests, but that just masks the problem, or?

The strange behavior is not a problem in Git, it is a problem of MSYS.
Using /foo/bar instead of /a/b in Git's test suite is a reasonable
work-around.

If you mean that you get ../../C:/something from the relative_path
computation, that *is* a problem in Git, which is addressed by the topic
jx/relative-path-regression-fix.

> PS: I'm also quite unhappy about naming the function "mingw_path". The
> path mangling comes from MSYS, not MinGW, so if at all it should be
> named msys_path. But as the code for the "mingw_path" function does
> nothing either MSYS or MinGW related but just prints argv[2] as it was
> passed to main() it should probably simply called "print_path".

You have a point here. If it were to change, "echo_path" would be my
preference.

-- Hannes

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
For more options, visit https://groups.google.com/groups/opt_out.
