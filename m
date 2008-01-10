From: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Thu, 10 Jan 2008 11:57:32 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801101155140.31053@racer.site>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de> <20080108190952.GK22155@fieldses.org> <7vir24rtfp.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801081232120.3148@woody.linux-foundation.org> <7vd4sbmnmz.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801091041570.31053@racer.site> <Pine.LNX.4.64.0801101023380.11922@ds9.cixit.se>
Reply-To: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>,  Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,  "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>,  Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>,  Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>,  Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,  msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Jan 10 12:58:09 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ag-out-0910.google.com ([72.14.246.184])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCw2y-0005nK-VZ
	for gcvm-msysgit@m.gmane.org; Thu, 10 Jan 2008 12:58:09 +0100
Received: by ag-out-0910.google.com with SMTP id 32so1139653agc.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 10 Jan 2008 03:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=MJDcmDIge6kOS20Vkmhs+fXgFC3GiN+HlfJkMQsg574=;
        b=BbIPdaa9Ce6C1b7suo5AHHUTFlbiHXLU1MwwMppst2sePz+i/G+QAhEdDSaunKRz94tXnh90BwHoX+5aG/LyUAcN4jbKNtyz/2ahdQLropN0GvWBtORtWvJstWRp7g+CR2wa1awAu0RoHvSodP2dPI39ol6ZJVn5tQtd61eWYfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=Byu5KZqXLctXMKNmkXEymhts/LNceMlG1lypHzTPLYSYcFayOn9mcPSqg+WFBgdMkID1eWS07JPwxwqTBpuUE753MZcKjcJaB8cM/8LPwD1KgTEwajo2FOikoSjJ4rsgjUAdu6bSpiu1aru9eLtgBRq106TCr9siW2d9J/anvV8=
Received: by 10.150.145.20 with SMTP id s20mr41941ybd.14.1199966259715;
        Thu, 10 Jan 2008 03:57:39 -0800 (PST)
Received: by 10.44.218.34 with SMTP id q34gr1353hsg;
	Thu, 10 Jan 2008 03:57:39 -0800 (PST)
X-Sender: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.37.18 with SMTP id p18mr1006383pyj.6.1199966259530; Thu, 10 Jan 2008 03:57:39 -0800 (PST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id v63si1174364pyh.2.2008.01.10.03.57.39; Thu, 10 Jan 2008 03:57:39 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Received: (qmail invoked by alias); 10 Jan 2008 11:57:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74] by mail.gmx.net (mp016) with SMTP; 10 Jan 2008 12:57:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX182n8kzOas2pznUqDVOcXLXf71OSJFp8UXQG8YSpX wcpIwA/MUm6vsS
X-X-Sender: gene099-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org
In-Reply-To: <Pine.LNX.4.64.0801101023380.11922-Hh8n7enkEC8qi7mQTfpNuw@public.gmane.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70061>


Hi,

On Thu, 10 Jan 2008, Peter Karlsson wrote:

> Johannes Schindelin:
> 
> > The problem is that MinGW behaves sanely, i.e. it does not output CRLF 
> > but only LF.
> 
> Well, that is broken, since the convention on Windows is to use CRLF.

I cannot help but wonder what exactly you wanted to achieve with this 
provably bogus statement, other than provoking flames.  I hereby refuse to 
insult you for it.

> > - Windows is already slow.  So slow that it is not even funny.  
> >   Granted, if you use Windows daily, git on MinGW seems snappy, but if 
> >   you come from Linux, it is slow as hell.
> 
> True. And I run git a lot on a Novell disk share, which doesn't exactly 
> help improve the speed either :-)

Don't do that, then.

I mean, git is _distributed_.  Not like there is no way out because your 
"server" is on a disk share.

> Windows has CRLF line endings. Just deal with it.

No, I will not just deal with it.

Ciao,
Dscho
