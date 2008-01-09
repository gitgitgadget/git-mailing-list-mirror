From: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Wed, 9 Jan 2008 11:03:30 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801091100401.31053@racer.site>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de> <20080108190952.GK22155@fieldses.org> <7vir24rtfp.fsf@gitster.siamese.dyndns.org> <B655B6FF-9377-434A-A979-2E758771B0FA@zib.de>
Reply-To: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>,  "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>,  Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>,  Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>,  Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Wed Jan 09 12:04:27 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.171])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCYjQ-0001Mv-MI
	for gcvm-msysgit@m.gmane.org; Wed, 09 Jan 2008 12:04:25 +0100
Received: by py-out-1314.google.com with SMTP id p69so3731080pyb.2
        for <gcvm-msysgit@m.gmane.org>; Wed, 09 Jan 2008 03:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=BgNOQch7VvvkCW2P0m8pf2un7ACaZng8yHX9SQP86O0=;
        b=Wi/0CAW4DuHAKs2VzvUHxdCqsvl9KtAZ8fjcxmflqfCvxerluSzGe/8Lzjj4O3c2qUSinGDuYPit7ErkCBSDiG2n3YiDRndQZwNuw9NC2l1KFVgIMgEFIjsDOsMnbrocwvxeESComH0wqHNtAIBGhqyPg7+2BZzRaEjbYQexW70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=wdcvy02WEHWN29NoFqpzjctLpFLLNZZTYFbO1kAXFHlCuFol6km0o8q8gEgrVRHACo74M35Sy0V6OBd3AHSLBZHTmxjF4X1VQHg8StTzeGH5Y8P8O2HWfixI6d4T/n3YKC7RMUNLuJoQ1j4Zd9BTHXDuiSmhjwnr5jDFnXBQMIg=
Received: by 10.150.144.9 with SMTP id r9mr503045ybd.16.1199876625142;
        Wed, 09 Jan 2008 03:03:45 -0800 (PST)
Received: by 10.44.69.72 with SMTP id r72gr1344hsa;
	Wed, 09 Jan 2008 03:03:45 -0800 (PST)
X-Sender: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.124.20 with SMTP id b20mr52835864pyn.5.1199876624957; Wed, 09 Jan 2008 03:03:44 -0800 (PST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id v63si393125pyh.2.2008.01.09.03.03.44; Wed, 09 Jan 2008 03:03:44 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Received: (qmail invoked by alias); 09 Jan 2008 11:03:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74] by mail.gmx.net (mp046) with SMTP; 09 Jan 2008 12:03:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18GQnxeemgGLptQgKqW4t/N8GTcT6HGA4gqnMMi+e EeTpVNk9U/lksS
X-X-Sender: gene099-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org
In-Reply-To: <B655B6FF-9377-434A-A979-2E758771B0FA-wjoc1KHpMeg@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69982>


Hi,

On Tue, 8 Jan 2008, Steffen Prohaska wrote:

> On Jan 8, 2008, at 8:47 PM, Junio C Hamano wrote:
> 
> > I think the project can mark text files as text with attributes and if 
> > the port to the platform initialized core.autocrlf appropriately for 
> > the platform everything should work as you described.
> > 
> > At least that is how I read the description of `crlf` in 
> > gitattributes(5).
> 
> But we do not want to mark a file as text but tell git to run its 
> auto-detection and use the local default line endings.  But for 
> different projects we do not even want to run the auto-detection, but 
> leave the files as is.

Probably the best thing would be to default to crlf=true, and then have a 
.gitattributes file like this in your project:

-- snip --
*.am -crlf
-- snap --

(Did I guess right about the file extension? But why do you want to check 
in huge 3D stacks? Ah, of course, for test cases.)

Ciao,
Dscho
