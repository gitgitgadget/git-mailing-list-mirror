From: Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Thu, 10 Jan 2008 10:25:00 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0801101023380.11922@ds9.cixit.se>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de> <20080108190952.GK22155@fieldses.org> <7vir24rtfp.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801081232120.3148@woody.linux-foundation.org> <7vd4sbmnmz.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801091041570.31053@racer.site>
Reply-To: peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>, Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>, Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Jan 10 10:26:24 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.171])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCtg4-0001mn-W6
	for gcvm-msysgit@m.gmane.org; Thu, 10 Jan 2008 10:26:23 +0100
Received: by py-out-1314.google.com with SMTP id b29so7459738pyh.0
        for <gcvm-msysgit@m.gmane.org>; Thu, 10 Jan 2008 01:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authentication-warning:date:from:to:cc:subject:in-reply-to:message-id:references:accept:x-warning:x-rating:organization:mime-version:content-type:x-greylist:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=JLr1jPLDtAlyerNkO24AB1seOnANAwJjF8ZWHzPg+p4=;
        b=2RVl7f9m2gOaWbDVXNla/vi2LYRaE8TXxl/vvoWSi5weeaswuGsOL88oH6zBIhzGjr9HK/4SKecN9ipdZhEhcj77mIH/8HOTKId1ijWLkZL8IjCpOqGj2qwFP6zdv+txUFPQBbohZmnUXR58Sxr1oB39YIwxeeKr4KiTKEjNq2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authentication-warning:date:from:to:cc:subject:in-reply-to:message-id:references:accept:x-warning:x-rating:organization:mime-version:content-type:x-greylist:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=KDAWqoXJHLPxtDNAu+Uol5EgvhKnV0aDJ6C2o0kXqTZx+Uryy89+6E85e3QIovg4+ect9MUKieqpQkXYRRncN5hoKuPUpIBQNVxHgcLioC1B92hyiDbJLb4J/E0xNF1GMxFVCZ/sp3npacj7YWoQgAHsnxarl4Fhtl8MFrDG7og=
Received: by 10.140.82.35 with SMTP id f35mr5645rvb.10.1199957136906;
        Thu, 10 Jan 2008 01:25:36 -0800 (PST)
Received: by 10.44.69.72 with SMTP id r72gr1352hsa;
	Thu, 10 Jan 2008 01:25:36 -0800 (PST)
X-Sender: peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.13.4 with SMTP id q4mr779735pyi.7.1199957136216; Thu, 10 Jan 2008 01:25:36 -0800 (PST)
Received: from ds9.cixit.se (ds9.cixit.se [193.15.169.228]) by mx.google.com with ESMTP id x35si200291nzg.2.2008.01.10.01.25.35; Thu, 10 Jan 2008 01:25:36 -0800 (PST)
Received-SPF: pass (google.com: domain of peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org designates 193.15.169.228 as permitted sender) client-ip=193.15.169.228;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org designates 193.15.169.228 as permitted sender) smtp.mail=peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org
Received: from ds9.cixit.se (peter@localhost [127.0.0.1]) by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m0A9P2ZZ026710 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 10 Jan 2008 10:25:03 +0100
Received: from localhost (peter@localhost) by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m0A9P0cX026697; Thu, 10 Jan 2008 10:25:01 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.LSU.1.00.0801091041570.31053-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Thu, 10 Jan 2008 10:25:03 +0100 (CET)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70056>


Johannes Schindelin:

> The problem is that MinGW behaves sanely, i.e. it does not output
> CRLF but only LF.

Well, that is broken, since the convention on Windows is to use CRLF.

> - Windows is already slow.  So slow that it is not even funny.  Granted, 
>   if you use Windows daily, git on MinGW seems snappy, but if you come 
>   from Linux, it is slow as hell.

True. And I run git a lot on a Novell disk share, which doesn't exactly
help improve the speed either :-)

> - Some tools ported to Windows from Unix do not like CRs.

Those tools are broken, for the same reason as above.


Windows has CRLF line endings. Just deal with it.

-- 
\\// Peter - http://www.softwolves.pp.se/
