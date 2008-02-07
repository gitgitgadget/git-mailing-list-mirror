From: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 7 Feb 2008 18:40:28 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802071831520.8543@racer.site>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <20080207130715.GA14000@bit.office.eurotux.com> <alpine.LSU.1.00.0802071324460.8543@racer.site> <7v1w7ooes3.fsf@gitster.siamese.dyndns.org>
Reply-To: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Luciano Rocha <luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org>, Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>,  Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 19:41:53 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNBgy-0005tu-Rq
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 19:41:49 +0100
Received: by yw-out-2122.google.com with SMTP id 4so5138475ywc.37
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 10:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=SOgF+SizFzZka3mO9TiWHqO28DNs+Dik94hJLZJtf9A=;
        b=ZuD8bqu0JfeSpaF8ayFKgd/aKvSSsMO0Z3211xxiZ7SLQLn8SNBEJOw687FLwrvZdX91G+/qq/UBIinrV1zx1E/TmN+63/0+BthEzJiX3YVcAaMv7IodNjf70NQGm/maViHYOYjCJuHSPzs/odjG4KZsDu4wscm8r5L/Z3vk+Jo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=YBhmLGQNlm1O81qGB0EJFh/2jy7RtvRr9CRWM28WKA1hRh7QHPXkqOpWoyCSjDaJ6Qq3ZWLo9UVmWlizY/FkIbKFoSClaCelXlJ8h1LDPNFLfZoosg/YAf2vvaUvg2ldacgm4Z4wNNEgnBb/poaaIuBqHfzFGRxkEshZu34uhP4=
Received: by 10.142.254.8 with SMTP id b8mr224352wfi.29.1202409676023;
        Thu, 07 Feb 2008 10:41:16 -0800 (PST)
Received: by 10.106.243.37 with SMTP id q37gr1658prh;
	Thu, 07 Feb 2008 10:41:16 -0800 (PST)
X-Sender: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.108.12 with SMTP id k12mr25549354pym.3.1202409675636; Thu, 07 Feb 2008 10:41:15 -0800 (PST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id a28si7171767pye.0.2008.02.07.10.41.15; Thu, 07 Feb 2008 10:41:15 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Received: (qmail invoked by alias); 07 Feb 2008 18:41:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74] by mail.gmx.net (mp013) with SMTP; 07 Feb 2008 19:41:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18aNb5MsZ4albG5JMAB+EB69FpDTJwGUk1/ckuQck ypG+elY8hXD9mw
X-X-Sender: gene099-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org
In-Reply-To: <7v1w7ooes3.fsf-jO8aZxhGsIagbBziECNbOZn29agUkmeCHZ5vskTnxNA@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72984>


Hi,

On Thu, 7 Feb 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org> writes:
> 
> > Besides, if you do not like that our installer shows the GPL, just go and 
> > make your own (but be sure to shell out money to your lawyer of choice to 
> > confirm that the GPL allows you to do that).
> >
> > The Git installer of msysGit will always show the GPL, and have the user 
> > accept it.
> 
> I may be missing the details because I do not do Windows myself,
> but if you are discussing the "end user binary distribution"
> one, then I think:
> 
>  * It is a mistake if you do not to show GPL, as you are
>    redistributing GPL code in a binary form and you need to tell
>    the end user his rights (e.g. he can request source for it,
>    the source is found at a well known location, etc.)
> 
>  * The restriction on redistribution of modified program would
>    probably not apply (unless the receiver hacks binary) to most
>    casual users, so making the label say "I Accept" feels a bit
>    silly (but still is technically correct).  As Nico suggested,
>    "Continue" may be fine here, as long as the message already
>    says "this program is distributed under this license you are
>    looking at".
> 
> I recall you had another installer that gives the full
> development environment for hack on "git" with a clone of the
> git repository.  I do not know if you still offer that
> installer, but "I Accept" would be very appropriate for that
> one.

Yes, the full installer does not (yet) ask for acceptance of the GPL, 
basically because I am too lazy, and also because I expect developers to 
actually read the notices in the copyright section in the source code, 
should they modify the source.

The reasoning for showing the GPL in the Git installer I cannot explain, 
because I was not part of it.  However, I am very much in favour, for two 
reasons:

- the end users should really know that the software is licensed in a 
  pretty free way.  Most of the users will have read about "the GPL", and 
  know what it says without reading it.  Others may see it for the first 
  time, and be astonished that such a license exists, and actually covers 
  a useful program.

- _every_ serious Windows program comes with a click-through license.  We 
  just don't want to be left behind.

- even if it would be not necessary to accept the license (which I am not 
  at all sure about, but do not care enough to learn about it, either), I 
  am not amused by somebody I do not know of, and who did not share 
  anything with me that I know of, asking me to remove that license 
  dialog.

  If you are not okay with accepting a tit-for-tat license, well... I'll 
  not give you "tat".

So there is really nothing that I can think of, which would change my mind 
about that "issue".

Ciao,
Dscho
