From: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Wed, 9 Jan 2008 10:48:47 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801091041570.31053@racer.site>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de> <20080108190952.GK22155@fieldses.org> <7vir24rtfp.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801081232120.3148@woody.linux-foundation.org> <7vd4sbmnmz.fsf@gitster.siamese.dyndns.org>
Reply-To: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,  "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>,  Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>,  Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>,  Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>,  Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Wed Jan 09 11:49:34 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.241])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCYV0-0004MQ-Vp
	for gcvm-msysgit@m.gmane.org; Wed, 09 Jan 2008 11:49:32 +0100
Received: by wa-out-0708.google.com with SMTP id n36so1906176wag.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 09 Jan 2008 02:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=SkhlAZEjcAu6j29Qjd3HtpUD6JfkTeE2ZSMR66/F45w=;
        b=dT8u3ekHehBtxL1dSDKpS4C/DBVhqCiawcrI2CP2hnD7tiFRNmHeEQy3cd5UqWNOrFlFK5uw2jo9YANxkGGYfxZbSalukuDaup0S+sjnhFTbxgjB+R4SLaV0I5PRUcXJ0akpUza00gC0c6f2GDsu1TJBlRRM0IuIMGh6WOgUUS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=PaASW1SFJE7CneWk36nrkGZdbXOXWNeY6XNmd3nwx/OjzvprKVEdb0kw87WpquZjcXvMy4TOuQHFbr8h5XQZ/gzxQoI8ge0k9Q+XJv6DT8pDCVHFvBmXMCrEXQc0sf7BqLTQcxZ33utsL5Yy82lbcbtzkqnZo7UI5UQuiek12wQ=
Received: by 10.140.82.38 with SMTP id f38mr790229rvb.3.1199875742457;
        Wed, 09 Jan 2008 02:49:02 -0800 (PST)
Received: by 10.44.218.34 with SMTP id q34gr1343hsg;
	Wed, 09 Jan 2008 02:49:02 -0800 (PST)
X-Sender: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.37.18 with SMTP id p18mr52840903pyj.6.1199875742111; Wed, 09 Jan 2008 02:49:02 -0800 (PST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id y6si29552012nzg.1.2008.01.09.02.49.01; Wed, 09 Jan 2008 02:49:02 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Received: (qmail invoked by alias); 09 Jan 2008 10:49:01 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74] by mail.gmx.net (mp031) with SMTP; 09 Jan 2008 11:49:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/SYMsK4EDSfHleahS00u+3XeO69RC+NtlaUWrWVF OhNQEPT0tTcrly
X-X-Sender: gene099-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org
In-Reply-To: <7vd4sbmnmz.fsf-jO8aZxhGsIagbBziECNbOZn29agUkmeCHZ5vskTnxNA@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69980>


Hi,

On Wed, 9 Jan 2008, Junio C Hamano wrote:

> Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> writes:
> 
> > On Tue, 8 Jan 2008, Junio C Hamano wrote:
> >>
> >> I think the project can mark text files as text with attributes and 
> >> if the port to the platform initialized core.autocrlf appropriately 
> >> for the platform everything should work as you described.
> >
> > Yes, I think core.autocrlf should default to "true" on Windows, since 
> > that is what it's about. The alternative is to have "fail"/"warn", to 
> > just make sure that nobody can do the wrong thing by mistake.
> >
> > We could just do something like this, although that probably does mean 
> > that the whole test-suite needs to be double-checked (ie now we really 
> > do behave differently on windows outside of any config options!))
> >
> > People who really dislike it can always do the
> >
> > 	git config --global core.autocrlf false
> >
> > thing.
> >
> > (And no, I don't know if "#ifdef __WINDOWS__" is the right thing to 
> > do, it's almost certainly not. This is just a draft.)

IMHO this is really not good.  Better do it in the global /etc/gitconfig 
we install _anyway_ (it says core.symlinks=false).

> Perhaps we can do something similar to core.filemode?  Create a file 
> that we would need to create anyway in "text" mode, and read it back in 
> "binary" mode to see what stdio did?

The problem is that MinGW behaves sanely, i.e. it does not output CRLF but 
only LF.

Besides, as I stated several times already, there _are_ projects on 
Windows where you do _not_ want crlf=true:

- Windows is already slow.  So slow that it is not even funny.  Granted, 
  if you use Windows daily, git on MinGW seems snappy, but if you come 
  from Linux, it is slow as hell.

  And CRLF conversion does not help that impression at all.

- Some tools ported to Windows from Unix do not like CRs.

- For git itself, I prefer to work without CRLF just because I do not need 
  it.

But maybe I am the minority here, and we really should default to 
crlf=true on Windows, and provide a way to unset that.

My preference would be to have Peff's -c switch to clone, but 
_additionally_ a way to force a full re-checkout of files (for example 
after "git config core.crlf false").

Ciao,
Dscho
