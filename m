From: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 8 Jan 2008 18:56:28 +0100
Message-ID: <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org>
Reply-To: prohaska-wjoc1KHpMeg@public.gmane.org
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>, Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Jan 08 18:55:59 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.251])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCIg8-0004sL-3X
	for gcvm-msysgit@m.gmane.org; Tue, 08 Jan 2008 18:55:56 +0100
Received: by wa-out-0708.google.com with SMTP id n36so1391713wag.21
        for <gcvm-msysgit@m.gmane.org>; Tue, 08 Jan 2008 09:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=1qRYrhZxNLga8PyKTsycoQH5iXafIG3A8ThDZMo5QMk=;
        b=cxEo9fyLelJ9HoyTOMByUvs7EdPA3c5gUylPPLBV6AkmdIt/IxcAbbiLjxmE00K7A0yPfs+WvI6ryw9cOoN0PzVfkM9jV/mq6ziShUSLDJQe16OZE2GQdxHDp0BksgJ0HsACTb0kd42SUk3G+MpkJH0kC2JBfZoY/XbHjLDvnVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=HycEJM7g7yhh+eQTwpqqPCu2+F9+t2Eb7IUpNAPt9Q0YFqVhkX13wkjYfMkcxz7fE2nzF0qZOgvH6/L2GRUsedoDk+pkAuFvpUp9EdHH4VIx2p6VUkDfmLDNGvoHGIvwwBxK0mGwRGIP668NVfQ9oxlCFXiM34A/kGwlir7Ds3o=
Received: by 10.114.81.1 with SMTP id e1mr814751wab.9.1199814928930;
        Tue, 08 Jan 2008 09:55:28 -0800 (PST)
Received: by 10.44.187.4 with SMTP id k4gr1321hsf;
	Tue, 08 Jan 2008 09:55:28 -0800 (PST)
X-Sender: prohaska-wjoc1KHpMeg@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.65.237.15 with SMTP id o15mr48105668qbr.3.1199814928627; Tue, 08 Jan 2008 09:55:28 -0800 (PST)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id h71si29066824nzf.3.2008.01.08.09.55.27; Tue, 08 Jan 2008 09:55:28 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) smtp.mail=prohaska-wjoc1KHpMeg@public.gmane.org
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m08HtNTl019970; Tue, 8 Jan 2008 18:55:23 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m08HtM5F008253 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Tue, 8 Jan 2008 18:55:22 +0100 (MET)
In-Reply-To: <20080108172957.GG22155-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69899>



On Jan 8, 2008, at 6:29 PM, J. Bruce Fields wrote:

> On Mon, Jan 07, 2008 at 10:40:56PM +0100, Steffen Prohaska wrote:
>> Eventually I gave in and even voted for "Git does not modify
>> content unless explicitly requested otherwise".
>>
>> Here's the full discussion:
>>
>> http://code.google.com/p/msysgit/issues/detail?id=21
>>
>> I believe the main question is which type of projects we would like
>> to support by our default.  For real cross-platform projects that  
>> will
>> be checked out on Windows and Unix we should choose
>> "core.autocrlf true" as our default.  But if our default are native
>> Windows projects that will never be checked out on Unix, then we
>> should not set core.autocrlf by default.
>
> If the policy really depends on the project, then surely the default
> behavior should be determined by information carried in the project
> itself (e.g., the .gitattributes)?

Unfortunately it depends on the project _and_ the platform.  A
cross-platform project should have core.autocrlf=input on Unix and
core.autocrlf=true on Windows.  I don't think I can represent this
with the current .gitattributes.

Do you suggest to add this kind of magic to .gitattributes? Such as
to have .gitattributes containing

--- SNIP ---
* crlf=autonative
--- SNIP ---

which would tell git to act as if core.autocrlf=input was set on Unix
and core.autocrlf=true was set on Windows.


> For that reason it strikes me as a mistake to ignore the crlf  
> attribute
> by default (assuming that is indeed the current behavior; apologies  
> for
> not checking).  If crlf is set then I think it should be assumed that
> crlf conversion should be done unless that has been explicitly turned
> off somehow.

I don't understand this comment.

msysgit installs plain git.  core.autocrlf is unset.  Whatever plain
git's default is, this is msysgit's default, too.

	Steffen
