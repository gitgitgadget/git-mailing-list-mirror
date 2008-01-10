From: Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Thu, 10 Jan 2008 14:28:13 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0801101424580.11922@ds9.cixit.se>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de> <20080108190952.GK22155@fieldses.org> <7vir24rtfp.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801081232120.3148@woody.linux-foundation.org> <7vd4sbmnmz.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801091041570.31053@racer.site> <Pine.LNX.4.64.0801101023380.11922@ds9.cixit.se> <alpine.LSU.1.00.080110115
 5140.31053@racer.site>
Reply-To: peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>, Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>, Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Jan 10 14:29:55 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.249])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCxTl-0003dc-J8
	for gcvm-msysgit@m.gmane.org; Thu, 10 Jan 2008 14:29:54 +0100
Received: by wa-out-0708.google.com with SMTP id n36so308728wag.21
        for <gcvm-msysgit@m.gmane.org>; Thu, 10 Jan 2008 05:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authentication-warning:date:from:to:cc:subject:in-reply-to:message-id:references:accept:x-warning:x-rating:organization:mime-version:content-type:x-greylist:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=YIx9Q8cl/MuBt76VNKSqv9yIZwRwOFH+M1v2UfpcJMc=;
        b=agIZFPNI5fLrDZDOQKveNtPeg2PGryUzWEv+dS7mGHC/FNhmQDsRHdgKGeM6lMKI69KyxpwnXADt0byb1GCr1iYiylNhpUQlB9OTKSeLZppZAs0IJ0Z1Pklrkx5osVfPubB6yCYGnxlwrwCOeLKf1yY5/m9UjaIhoLAtpwLwKMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authentication-warning:date:from:to:cc:subject:in-reply-to:message-id:references:accept:x-warning:x-rating:organization:mime-version:content-type:x-greylist:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=GCJ4dzw1VQYO/doThlkxqNYGeVDJjC/lmTCTWwDTSHEClI/mfT+mfbOJ2U6tX3M5Sk+07HUm5QEDFVtWVyRebMpNV0i4ttxobxJbPc16CcMWE1qwPkuL4JTE1ckWCNHi7Ks1uOGFj89HWqizRU6WuR3SbOi8pt7o9NoeyolzNPI=
Received: by 10.114.136.1 with SMTP id j1mr25014wad.20.1199971765172;
        Thu, 10 Jan 2008 05:29:25 -0800 (PST)
Received: by 10.44.53.58 with SMTP id b58gr1354hsa;
	Thu, 10 Jan 2008 05:29:25 -0800 (PST)
X-Sender: peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.65.75.2 with SMTP id c2mr559754qbl.5.1199971764757; Thu, 10 Jan 2008 05:29:24 -0800 (PST)
Received: from ds9.cixit.se (ds9.cixit.se [193.15.169.228]) by mx.google.com with ESMTP id h49si328437nzf.5.2008.01.10.05.29.23; Thu, 10 Jan 2008 05:29:24 -0800 (PST)
Received-SPF: pass (google.com: domain of peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org designates 193.15.169.228 as permitted sender) client-ip=193.15.169.228;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org designates 193.15.169.228 as permitted sender) smtp.mail=peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org
Received: from ds9.cixit.se (peter@localhost [127.0.0.1]) by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m0ADSuZZ024145 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 10 Jan 2008 14:28:56 +0100
Received: from localhost (peter@localhost) by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m0ADSD7B024048; Thu, 10 Jan 2008 14:28:13 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.LSU.1.00.0801101155140.31053-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Thu, 10 Jan 2008 14:28:56 +0100 (CET)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70070>


Johannes Schindelin:

> I cannot help but wonder what exactly you wanted to achieve with this
> provably bogus statement, other than provoking flames. I hereby
> refuse to insult you for it.

I meant to say that any software that claims to be Windows software
should handle, and produce, CRLF line breaks in text files. Whether it
also supports Unix (LF) or old Mac (CR) line breaks is up to it, but if
it is a Windows program, it should do CRLF, as that is the convention
(inherited from MS-DOS, which inherited it from CP/M).

> > True. And I run git a lot on a Novell disk share, which doesn't exactly 
> > help improve the speed either :-)
> Don't do that, then.

I have to. Otherwise the compile server can't see the files (this is
not for the project that at in the start of the thread, this is what I
use to work around that my employer's choice of version control systems
could be better).

> > Windows has CRLF line endings. Just deal with it.
> No, I will not just deal with it.

Me neither, that is why I expect the software to do it for me.

Thinking of text files as a stream of bytes is so 1900s. In the 2000s
we should think of text files as a stream of characters. How these
characters are represented is up to each system that wants it. I see no
problem with storing text files as UTF-32 internally (disk is cheap).

-- 
\\// Peter - http://www.softwolves.pp.se/
