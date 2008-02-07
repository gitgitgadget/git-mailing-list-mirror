From: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 7 Feb 2008 16:53:43 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802071651440.8543@racer.site>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <20080207130715.GA14000@bit.office.eurotux.com> <alpine.LFD.1.00.0802070949460.2732@xanadu.home> <20080207155946.GA20459@bit.office.eurotux.com> <alpine.LFD.1.00.0802071133230.2732@xanadu.home>
Reply-To: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Luciano Rocha <luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org>, Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>,  Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,  Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
To: Nicolas Pitre <nico-mo2vmkxb4K0@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 17:55:22 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.248])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNA1f-0004M2-4L
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 17:55:03 +0100
Received: by wa-out-0708.google.com with SMTP id n36so6520677wag.21
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 08:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=XKmosWpGg6i0FLEYFhfLBp/1jCRkeJfvoAUgivzAjz4=;
        b=6WfQaDFHMMLO2oXoQCHiRSs4s/cUb0aSVJ7WKXVv8ThdY1LzVLsrEL4kSlIyMR84gDpfhYBOi36jvG03yUAYuiGOZ/wde1jr/dq9b8qgbY9w0wkUGkQDXrZAZqtMPLMmGP89SDAyPas/6DQFvHOjJe+khbWelLSa4+e8z0hPt2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=FXCaa/TyCG6URijk+8VJQRoak0G3U59DTz52kRTIr5PpVLHnVfVv6Hei+ZqJWELSdkVf9dH+ICeXJuTsjsS/DzCAPleAdzBGBdXceqcggT73nB+jhO1AGEuIkNthHFOv+LOpT8dHkXDB6TAiJ9K7CYZY/t5plSpumoUQmotKeHw=
Received: by 10.114.37.1 with SMTP id k1mr814843wak.0.1202403270817;
        Thu, 07 Feb 2008 08:54:30 -0800 (PST)
Received: by 10.106.159.22 with SMTP id h22gr1653pre;
	Thu, 07 Feb 2008 08:54:30 -0800 (PST)
X-Sender: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.59.5 with SMTP id m5mr25339123pyk.0.1202403270382; Thu, 07 Feb 2008 08:54:30 -0800 (PST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id v63si6960783pyh.2.2008.02.07.08.54.29; Thu, 07 Feb 2008 08:54:30 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Received: (qmail invoked by alias); 07 Feb 2008 16:54:28 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74] by mail.gmx.net (mp058) with SMTP; 07 Feb 2008 17:54:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+6pspHc4W6SijhW89RjwIJvYoMd8RQKsF917Vsk7 7M+FpmS+pOHFFO
X-X-Sender: gene099-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org
In-Reply-To: <alpine.LFD.1.00.0802071133230.2732-QuJgVwGFrdf/9pzu0YdTqQ@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72977>


Hi,

On Thu, 7 Feb 2008, Nicolas Pitre wrote:

> Then, simply changing the button text from "I accept" to "Continue" 
> should be OK?

I consider this bike-shedding, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org being the wrong mailing 
list to discuss this (and as a matter of fact, the msysgit list is also 
not the correct forum for discussing such legal/personal issues), and 
besides, the msysgit installer will not be changed in this respect.

Hth,
Dscho
