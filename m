From: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] gitk: make Ctrl "+" really increase the font
 size
Date: Mon, 14 Jan 2008 15:57:52 +0000 (GMT)
Message-ID: <alpine.DEB.1.00.0801141555100.23987@eeepc-johanness>
References: <fm5oln$ahq$1@ger.gmane.org> <alpine.LSU.1.00.0801111238150.31053@racer.site> <fmft8d$kuv$2@ger.gmane.org>
Reply-To: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephan Hennig <mailing_list-KvP5wT2u2U0@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Jan 14 16:58:28 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.169])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JERhf-0003D2-Sg
	for gcvm-msysgit@m.gmane.org; Mon, 14 Jan 2008 16:58:24 +0100
Received: by py-out-1314.google.com with SMTP id b29so8544656pyh.0
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Jan 2008 07:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=7AJUhuecDMFRM0mIFOPIt0/yCvYzge1mZ2o2Z419zUg=;
        b=v/JYFdPpWUIk9XuPVt/xlKVFOWwZTWIeQMF/5zjLIVrJQ3UqnFB6piaTKCYmLUKlLblTQNRvfNlfxdkqqyEGoSa5ddVgiKP8P5En8zWPTgIjRu+bD4P5/xbQuIRtQ+YQusLWzFZebsJK7cOVkgq7UQIr6TcCKT8ER7Smwl1Gsz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=ilYshNPf26qL2HufeYsdvxweaMJVq/FlH1ao8ACp52tFwt191VInIkoyf1X7H8JhwMiEMs51URNOHUK8Pji7xEQkdngh03G4UHNcoCxZWckISbwEQwppTRDlFq+hpfSrahCS9eZehWu0cKBDtwVJu2iFEPOF3zxxCzriJH33Na0=
Received: by 10.150.97.20 with SMTP id u20mr309088ybb.19.1200326274205;
        Mon, 14 Jan 2008 07:57:54 -0800 (PST)
Received: by 10.44.112.30 with SMTP id k30gr1401hsc;
	Mon, 14 Jan 2008 07:57:54 -0800 (PST)
X-Sender: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.131.9 with SMTP id e9mr1188961wad.5.1200326273841; Mon, 14 Jan 2008 07:57:53 -0800 (PST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id v28si2716103nzb.4.2008.01.14.07.57.53; Mon, 14 Jan 2008 07:57:53 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Received: (qmail invoked by alias); 14 Jan 2008 15:57:52 -0000
Received: from unknown (EHLO eeepc-johanness.st-andrews.ac.uk) [138.251.11.75] by mail.gmx.net (mp046) with SMTP; 14 Jan 2008 16:57:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/w/z8GX0DwX+4FuI6NGJwfx1BY8AB0me2hFx8PxQ vDkQ4ChI5WqdC8
X-X-Sender: user@eeepc-johanness
In-Reply-To: <fmft8d$kuv$2@ger.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70462>


Hi,

[please do not cull me from the Cc' list.  It's like answering to what I 
 said while looking at someone else.]

On Mon, 14 Jan 2008, Stephan Hennig wrote:

> Johannes Schindelin schrieb:
> > 
> > Only Ctrl "=" was bound to increase the font size, probably because
> > English keyboards have the plus on the same key as the equal sign.
> > However, not the whole world is English, and at least with some
> > other keyboard layouts, Ctrl "+" did not work as documented.
> > 
> > Noticed by Stephan Hennig.
> > 
> > Signed-off-by: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
> > 
> > ---
> > 
> > 	On Thu, 10 Jan 2008, Stephan Hennig wrote:
> > 
> > 	> 
> > 	> Hi,
> > 	> 
> > 	> reducing font size in gitk with CTRL-- works, but enlarging font 
> > 	> size fails.  Typing CTRL-+ just doesn't have any effect here.
> > 
> > 	This is no bug in msysgit, but in gitk.
> > 
> > 	Paul, please apply.
> 
> The bug is still present in gitk that comes with Msysgit

If you are complaining about msysgit, please do not flood the git list 
with your response.

Besides, it is asking a little much after just 4 days for a patch to come 
through no less than 4 different repositories: gitk -> git.git -> 
mingw.git -> 4msysgit.git.

A patch that you could apply yourself easily, with the further benefit of 
being able to added your "Tested-by:" line.

After all, I just worked for you, for free, and I expect something back.

Hth,
Dscho
