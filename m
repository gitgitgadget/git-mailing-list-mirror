From: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 8 Jan 2008 08:02:47 +0100
Message-ID: <5310CD2F-C3B4-404A-9C2E-1D3084B5CC96@zib.de>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <7vzlvhxpda.fsf@gitster.siamese.dyndns.org>
Reply-To: prohaska-wjoc1KHpMeg@public.gmane.org
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>, Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Jan 08 08:06:20 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ug-out-1516.google.com ([66.249.92.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC8XT-0003k6-4h
	for gcvm-msysgit@m.gmane.org; Tue, 08 Jan 2008 08:06:19 +0100
Received: by ug-out-1516.google.com with SMTP id 1so378843uga.9
        for <gcvm-msysgit@m.gmane.org>; Mon, 07 Jan 2008 23:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=96uBuuqJ7cmUu3kHC5LGj5+OugwbdpyknV4zbboWNCI=;
        b=Q5+LOAEyYW3tMA5TS5uC5nlhold5/6K7LZ8GLkinczUFVWWmfNaydsj5GZew8Em7uI+xBj1B+awJKQ3xoCvSmqfQUyCiJhaa2NH+Lg7bgpCbexJS2dGb8+/zqK0rLR37NAwp2GGcfxS/UgGFJ6fH0Sfnn/GdQKrxgt1Q0PejGQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=bP/PfWyc4SlrhG6g5q14mPk3C+fPiSwXVSoB+QtYMkGUHCfoQBW1uFst77MgMBsBP7nesihn0NUog/q1QWD6mxS3nQKY0/6ph6H9mjIG7nipDkG+Vcv6C45K7dOEM1aMtQPkWBw/tSsJVFHFcoT7XgCYLkH/MTmaRfTlobohwVs=
Received: by 10.86.66.1 with SMTP id o1mr250882fga.8.1199775952885;
        Mon, 07 Jan 2008 23:05:52 -0800 (PST)
Received: by 10.44.112.30 with SMTP id k30gr1315hsc;
	Mon, 07 Jan 2008 23:05:52 -0800 (PST)
X-Sender: prohaska-wjoc1KHpMeg@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.124.20 with SMTP id b20mr49995574pyn.5.1199775952238; Mon, 07 Jan 2008 23:05:52 -0800 (PST)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id h49si28547728nzf.5.2008.01.07.23.05.51; Mon, 07 Jan 2008 23:05:52 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) smtp.mail=prohaska-wjoc1KHpMeg@public.gmane.org
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0871o7r017154; Tue, 8 Jan 2008 08:05:45 +0100 (CET)
Received: from [192.168.178.21] (brln-4db95a4c.pool.einsundeins.de [77.185.90.76]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0871fYT028351 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Tue, 8 Jan 2008 08:01:46 +0100 (MET)
In-Reply-To: <7vzlvhxpda.fsf-jO8aZxhGsIagbBziECNbOZn29agUkmeCHZ5vskTnxNA@public.gmane.org>
X-Mailer: Apple Mail (2.753)
Sender: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact msysgit-owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:msysgit-help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69845>



On Jan 7, 2008, at 11:06 PM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org> writes:
>
>> I believe the main question is which type of projects we would like
>> to support by our default.  For real cross-platform projects that  
>> will
>> be checked out on Windows and Unix we should choose
>> "core.autocrlf true" as our default.  But if our default are native
>> Windows projects that will never be checked out on Unix, then we
>> should not set core.autocrlf by default.
>
> If the primary target is native Windows projects that wants CRLF
> in the work tree, you could still set core.autocrlf.  Your
> checkouts will be with CRLF.  And someday perhaps somebody may
> offer porting that to UNIX and his checkout will be without CR.
>
> So wouldn't the categorization be more like this?
>
>  - "real cross-platform" would want core.autocrlf = true;
>
>  - "native Windows" can work either way;

But core.autocrlf  = true has a slight danger of data corruption.
AFAIK, git's binary detection checks the first "few" bytes (with
few = 8000).  This may be sufficient in most case, but I already
met a file that was wrongly classified.  (A File format that
starts with a large ASCII header and has chunks of binary data
attached later.)


>  - "originated from UNIX" would be helped with core.autocrlf = true;

I'd say "could be helped".  For the msysgit development, for
example, we do _not_ want to have core.autocrlf = true but
prefer to preserve the Unix line ending even when working on
Windows.  We have only few Windows-specific files that are
committed with CRLF.  We _know_ the problem and we explicitly
handle it.


I believe, best would be if a line ending policy could be
configured for a project.  Then, the decision could be made once
for the project and should be enforced on all clones.  But
currently git has no concept for this.

A sound policy for "real cross-platform" is that CRLF must never
enter the repository unless git detects a file as binary, or a
file is explicitly listed in .gitattributes.  It doesn't really
matter if Windows users check out files with CRLF or LF.  It only
matters that they'll never commit a file with CRLF.  Note, the
same is true for Unix users.  People could send code by email or
copy source files from Windows to Unix machines.  Then, CRLF
would enter the repo on Unix.  So the least that should be set
for this type of projects on any OS is core.autocrlf = input.
On Windows, core.autocrlf = true is probably more natural.

I like Linus' idea of "warn" or Gregory's "fail".

Would "warn/fail" be the default on Unix, too?  Then Unix users
would also be forced to make an explicit choice.  Maybe some day
they want to check out their project on Windows and they should
be prepared now.  For typical files, the warning (or error) would
never trigger.  But maybe one day they copy a file from a Windows
machine and forget to run dos2unix.  In this case, git would warn
them unless they set "core.autocrlf = false".

I'm asking the last question because every Unix developer should
think about the option, too.  Neither Unix or Windows are causing
the problem alone.  It's the combination in a cross-platform
project.  Git could ensure that any repository is in principal
prepared for cross-platform, unless explicitly told not to do so.

So, would you, as Linux developers, like to have (or accept)
"warn/fail" as your default?

This would make things easy for the msysgit project:  No Windows
specific configuration; just official git.

	Steffen
