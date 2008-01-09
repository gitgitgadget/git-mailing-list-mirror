From: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Wed, 9 Jan 2008 20:50:35 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801092047190.31053@racer.site>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de> <20080108190952.GK22155@fieldses.org> <7vir24rtfp.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801081232120.3148@woody.linux-foundation.org> <7vd4sbmnmz.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801091041570.31053@racer.site> <7vmyrehhkd.fsf@gitster.siamese.dyndns.org>
Reply-To: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,  "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>,  Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>,  Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>,  Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>,  Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Wed Jan 09 21:51:25 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.172])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JChtT-0004Tx-9q
	for gcvm-msysgit@m.gmane.org; Wed, 09 Jan 2008 21:51:23 +0100
Received: by py-out-1314.google.com with SMTP id b29so5751377pyh.0
        for <gcvm-msysgit@m.gmane.org>; Wed, 09 Jan 2008 12:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=wRIz0lBt/SJsGlPIJbF144XEEuAURzT8Tmys57NykwI=;
        b=61KG6nizWWWxDwQSff0bsFVX9X6iU1J503dWLF++IkP1m6Wlj+eVMXX1xoi91jw+T3Oxf21mXHi94CB7Q8zMAhmlSIu2Xa8+UiHx6ifcJwOmk4fo3QBzS179lukuFM0ueSiulYF5k9r/U8IdR3IxOKCEmfPOXpRWc7wsIkfDAOU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=4TwHRqJnKqEG6X0A7R3ONtKcnYNBXnfF2IWEo4wXA+ZEFq3piVBnO9zJRQkcPkUxfP+XvFsHcsgnO6HWQR3PxSGIVo8n8ENakM0fb1lqcxZV1Zppw/TZYZhyC8AG4PpJcXSA+NeLneSlvm46Gz9sUH1QIvJPr7/eFb9ibaL28qk=
Received: by 10.150.225.14 with SMTP id x14mr517963ybg.28.1199911841476;
        Wed, 09 Jan 2008 12:50:41 -0800 (PST)
Received: by 10.44.53.58 with SMTP id b58gr1350hsa;
	Wed, 09 Jan 2008 12:50:41 -0800 (PST)
X-Sender: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.13.4 with SMTP id q4mr54347354pyi.7.1199911840395; Wed, 09 Jan 2008 12:50:40 -0800 (PST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id x46si755826pyg.3.2008.01.09.12.50.39; Wed, 09 Jan 2008 12:50:40 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Received: (qmail invoked by alias); 09 Jan 2008 20:50:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74] by mail.gmx.net (mp033) with SMTP; 09 Jan 2008 21:50:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+9prxWSmu9vpqzCfVlfdi7wJvSh4TnchhQqcdkO+ HP+NqhwQ8OnYOm
X-X-Sender: gene099-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org
In-Reply-To: <7vmyrehhkd.fsf-jO8aZxhGsIagbBziECNbOZn29agUkmeCHZ5vskTnxNA@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70012>


Hi,

On Wed, 9 Jan 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org> writes:
> 
> > Junio wrote:
> >
> >> Perhaps we can do something similar to core.filemode?  Create a file 
> >> that we would need to create anyway in "text" mode, and read it back 
> >> in "binary" mode to see what stdio did?
> >
> > The problem is that MinGW behaves sanely, i.e. it does not output CRLF 
> > but only LF.
> 
> Won't that behaviour be viewed rather as "insanely" from majority of 
> Windows users?

I think the truth is that CRLF was a mistake.  Nobody wants to take the 
blame for it, obviously, but more and more Windows tools just grok LF-only 
text.

The question is: what to do with those that cannot grok LF-only text.  I 
imagine that the best compromise for now would be to have crlf=true, with 
poor souls like Steffen having to set the gitattributes accordingly.

Ciao,
Dscho
