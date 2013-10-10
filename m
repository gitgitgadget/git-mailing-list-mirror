From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Same test-path-utils behaves differently on different
 Windows systems
Date: Thu, 10 Oct 2013 19:57:22 +0200
Message-ID: <5256EA82.7020504@kdbg.org>
References: <CAHGBnuNaVWxa2kNqf3n9GmZZxFryLfJqKB5TxmDK5BiG5x53VQ@mail.gmail.com> <CAHGBnuORD-nTaYVVMt5WJhFnHU4oj0=5WiLXMAMa2Y4mz-vNXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: worldhello.net@gmail.com, 
 Thomas Braun <thomas.braun@virtuell-zuhause.de>,
 Git Mailing List <git@vger.kernel.org>, 
 msysGit Mailinglist <msysgit@googlegroups.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: msysgit+bncBCJYV6HBKQIIJVO3SICRUBG5IBS64@googlegroups.com Thu Oct 10 19:57:27 2013
Return-path: <msysgit+bncBCJYV6HBKQIIJVO3SICRUBG5IBS64@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f56.google.com ([209.85.215.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIIJVO3SICRUBG5IBS64@googlegroups.com>)
	id 1VUKUH-0003NJ-9A
	for gcvm-msysgit@m.gmane.org; Thu, 10 Oct 2013 19:57:25 +0200
Received: by mail-la0-f56.google.com with SMTP id ep20sf265390lab.1
        for <gcvm-msysgit@m.gmane.org>; Thu, 10 Oct 2013 10:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=ooeCmDpAYR8VWYlgT4mhBYCWfQSHK6nsv0Xrln0ez8I=;
        b=NmnRAEzdDfyMstvYlrSWKgm+7/V9c9UT+5k2fppaJPuFrJsg7xjHoV1ETPPtC64Nzb
         yXNCfYaV1tlb3IGHFlhqLn0VUpONYxRtku3aI2iVWPwCEbwpl5aHN2ak0E4DIS/Z15R6
         p+ID15eRSOEgY8NvkK+i9H7Qn5F+eOMQSVJawqlMdDkPxwmGu1VZT1puR+ZV4YaUqU2V
         VOlzMXTT5czTwgKqwvzf7Sby4ZyWRxElOcsWPo2umKmcSldDqdDfAbzjM+hoose9FwB5
         lKcNNwdYm1LD+y5tVGoWe6D6m4+Ufbht+huKWpqbW1bHMnMFAGaizIOIPKkLZgZoIvXV
         QqVg==
X-Received: by 10.152.4.41 with SMTP id h9mr68147lah.8.1381427844974;
        Thu, 10 Oct 2013 10:57:24 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.115.177 with SMTP id jp17ls174927lab.66.gmail; Thu, 10 Oct
 2013 10:57:24 -0700 (PDT)
X-Received: by 10.152.26.201 with SMTP id n9mr2041862lag.8.1381427844242;
        Thu, 10 Oct 2013 10:57:24 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp5.bon.at. [195.3.86.187])
        by gmr-mx.google.com with ESMTP id a1si1232962ees.1.1969.12.31.16.00.00;
        Thu, 10 Oct 2013 10:57:24 -0700 (PDT)
Received-SPF: neutral (google.com: 195.3.86.187 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.187;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9D54D130050;
	Thu, 10 Oct 2013 19:57:23 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 6BCCE19F646;
	Thu, 10 Oct 2013 19:57:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CAHGBnuORD-nTaYVVMt5WJhFnHU4oj0=5WiLXMAMa2Y4mz-vNXg@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235873>

Am 10.10.2013 17:52, schrieb Sebastian Schuberth:
> Hi again,
> 
> the problem can also be reproduced in an easier way, independently of
> mingwGitDevEnv and using the mingw_path function instead of
> relative_path. If I install msysGit 1.8.4 from [1] and run
> test-path-utils I get this on Windows Server 2008 R2 64-bit:
> 
> $ test-path-utils mingw_path /a/b/
> a:/b/
> 
> But if I install [1] on my local Windows 8 64-bit I get:
> 
> $ test-path-utils mingw_path /a/b/
> C:/msysgit/msysGit/a/b/

Interesting. I guess that you get consistent behavior when the first
path component is not merely a single letter, e.g., /foo/bar.

Do you have a drive a: configured somewhere in your MSYS environment on
the 2k8r2 machine? See /etc/fstab. Do you have a floppy drive in that
machine?

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
