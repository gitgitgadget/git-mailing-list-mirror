From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Same test-path-utils behaves differently on different
 Windows systems
Date: Thu, 10 Oct 2013 21:47:49 +0200
Message-ID: <CAHGBnuO8ATSQu6HpJTm8bBg0akm+LUsZGRFoZPhzs89q7gTWqQ@mail.gmail.com>
References: <CAHGBnuNaVWxa2kNqf3n9GmZZxFryLfJqKB5TxmDK5BiG5x53VQ@mail.gmail.com>
	<CAHGBnuORD-nTaYVVMt5WJhFnHU4oj0=5WiLXMAMa2Y4mz-vNXg@mail.gmail.com>
	<5256EA82.7020504@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: worldhello.net@gmail.com, Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
	Git Mailing List <git@vger.kernel.org>, msysGit Mailinglist <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBDZMLEGXWQLBBZMI3SJAKGQEVXJAVYI@googlegroups.com Thu Oct 10 21:47:50 2013
Return-path: <msysgit+bncBDZMLEGXWQLBBZMI3SJAKGQEVXJAVYI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ea0-f191.google.com ([209.85.215.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDZMLEGXWQLBBZMI3SJAKGQEVXJAVYI@googlegroups.com>)
	id 1VUMD8-0007rl-By
	for gcvm-msysgit@m.gmane.org; Thu, 10 Oct 2013 21:47:50 +0200
Received: by mail-ea0-f191.google.com with SMTP id o10sf277873eaj.18
        for <gcvm-msysgit@m.gmane.org>; Thu, 10 Oct 2013 12:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=ykUv7oCdSyKxJtaZB81pEPcdlrR0KvC+6x8lEP0Bfgc=;
        b=FOPvAzkwXZOyXw7XOtq1MOTAWBHw/XH74GdjCZb90fMyWKmsAZmYjbSSs/mNzwbzJc
         XPBitz4UAcxa3Kb5+eKtRh8BuQucQefW7PDeawxvQ08PxbXy1k4ETZ5U/+IeTLRsef9E
         nqFoK400fX0hU0U7UqWiPEYCTLBz2Y0TrM+53K+rflCkrKthZr2uxSqadPoypiDLTZbC
         mZAh3ByJrF/VgV4cA1bc8sxaydCuluKyVSkvYu65yPhlP4h8kWTKV+G6kVGpH9t2H3Hl
         7tNNFgFpnaP6D5XQeQ2J8B3PclF7ZERvqxCPk1A7MP8+54IrQK8EB6nfac24Fpx6rJJw
         mlow==
X-Received: by 10.152.23.3 with SMTP id i3mr76648laf.14.1381434470094;
        Thu, 10 Oct 2013 12:47:50 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.170.134 with SMTP id am6ls210133lac.22.gmail; Thu, 10 Oct
 2013 12:47:49 -0700 (PDT)
X-Received: by 10.112.50.175 with SMTP id d15mr5291005lbo.12.1381434469473;
        Thu, 10 Oct 2013 12:47:49 -0700 (PDT)
Received: from mail-lb0-x233.google.com (mail-lb0-x233.google.com [2a00:1450:4010:c04::233])
        by gmr-mx.google.com with ESMTPS id qy6si4055196bkb.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 12:47:49 -0700 (PDT)
Received-SPF: pass (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4010:c04::233 as permitted sender) client-ip=2a00:1450:4010:c04::233;
Received: by mail-lb0-x233.google.com with SMTP id x18so2600988lbi.10
        for <msysgit@googlegroups.com>; Thu, 10 Oct 2013 12:47:49 -0700 (PDT)
X-Received: by 10.152.243.42 with SMTP id wv10mr2968760lac.39.1381434469322;
 Thu, 10 Oct 2013 12:47:49 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Thu, 10 Oct 2013 12:47:49 -0700 (PDT)
In-Reply-To: <5256EA82.7020504@kdbg.org>
X-Original-Sender: sschuberth@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4010:c04::233
 as permitted sender) smtp.mail=sschuberth@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235877>

On Thu, Oct 10, 2013 at 7:57 PM, Johannes Sixt <j6t@kdbg.org> wrote:

>> test-path-utils I get this on Windows Server 2008 R2 64-bit:
>>
>> $ test-path-utils mingw_path /a/b/
>> a:/b/
>>
>> But if I install [1] on my local Windows 8 64-bit I get:
>>
>> $ test-path-utils mingw_path /a/b/
>> C:/msysgit/msysGit/a/b/
>
> Interesting. I guess that you get consistent behavior when the first
> path component is not merely a single letter, e.g., /foo/bar.

You're right! With /foo/bar on W2k8r2 I get

$ test-path-utils mingw_path /foo/bar/
C:/msysgit184/msysgit/foo/bar/

> Do you have a drive a: configured somewhere in your MSYS environment on
> the 2k8r2 machine? See /etc/fstab. Do you have a floppy drive in that
> machine?

Again you're correct. The W2k8r2 machine actually is a VM, providing a
floppy drive "A:". So the obvious thing would be to replace /a/b/ with
/foo/bar/ in the tests, but that just masks the problem, or?

PS: I'm also quite unhappy about naming the function "mingw_path". The
path mangling comes from MSYS, not MinGW, so if at all it should be
named msys_path. But as the code for the "mingw_path" function does
nothing either MSYS or MinGW related but just prints argv[2] as it was
passed to main() it should probably simply called "print_path".

-- 
Sebastian Schuberth

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
