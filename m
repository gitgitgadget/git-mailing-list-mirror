From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Should we discuss Windows-related changes on
 git@vger.kernel.org?
Date: Fri, 11 Jul 2008 20:40:46 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807112037220.8950@racer>
References: <DDFD7E3B-8401-4EA0-9BBA-C9D8E25998A3@zib.de> <alpine.DEB.1.00.0807111349470.3640@eeepc-johanness> <65365AC4-D7C9-462B-8239-F3B35F7ECBEF@zib.de> <alpine.DEB.1.00.0807111652170.8950@racer> <A065AF71-5685-423A-9F87-5349ADC6C9C9@zib.de> <alpine.DEB.1.00.0807111930160.8950@racer> <alpine.LFD.1.10.0807111159560.2936@woody.linux-foundation.org>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,  Johannes Sixt <johannes.sixt@telecom.at>,  Junio C Hamano <gitster@pobox.com>, msysGit <msysgit@googlegroups.com>,  Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Jul 11 21:42:04 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.246])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHOV3-0007jv-41
	for gcvm-msysgit@m.gmane.org; Fri, 11 Jul 2008 21:41:49 +0200
Received: by wa-out-0708.google.com with SMTP id n36so9868372wag.21
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2008 12:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        bh=3PHmNhC283VCN5BdqiP4QBLxcasnP55bSw8UwN1iS2U=;
        b=ybnlI/DJ56iQvM0NEysXoIS7MMQLts39qVApQLqvNF4zpnBU/sh/36m7aLuwCvz7lx
         Sb2/PgzBSnO67q+JLAqzRvrEHGCzsVX6d+fueFSAhXFXSpyyY3uxOhp2mXTzQXNihxGY
         WdfZGFqY3u4JNlTIHL8/2WpzRB24nEF1M2PPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=sEPYK87a8FgSS59p1Vr9pavDw9kHOWA1xVWzax/tIydu6dofEQ/kt8d4dqOAq4bS9/
         GK00RkMI6gc1gTsRthLbU/bwJ5pdIYWPlE0gZKsuCCmL6pmBbTMDCfzCrCJDHCFatB7I
         EHpxmd13d43O1JMtIlmvikyH3KQJ6zCxrTwAY=
Received: by 10.114.204.7 with SMTP id b7mr702012wag.2.1215805248777;
        Fri, 11 Jul 2008 12:40:48 -0700 (PDT)
Received: by 10.106.193.17 with SMTP id q17gr2679prf.0;
	Fri, 11 Jul 2008 12:40:48 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.111.1 with SMTP id j1mr6584478wac.0.1215805247905; Fri, 11 Jul 2008 12:40:47 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id 22si1143422yxr.2.2008.07.11.12.40.47; Fri, 11 Jul 2008 12:40:47 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 11 Jul 2008 19:40:46 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28] by mail.gmx.net (mp036) with SMTP; 11 Jul 2008 21:40:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+AtylMtT6ARyzpb+yRi1V4Xuvk8XawTlBWVOVEYk sTV6EoD+pPdTRQ
X-X-Sender: gene099@racer
In-Reply-To: <alpine.LFD.1.10.0807111159560.2936@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88163>


Hi,

On Fri, 11 Jul 2008, Linus Torvalds wrote:

>  - It may well be good to explain to the _real_ git people (eg me) what 
>    the problems in Windows land are, so that we get a first-hand view 
>    into hell, and can maybe take it into account when we make changes 
>    for other things.

Wow.  I did not think that you were a masochist.

> IOW, I think that since 1.6.0 is supposed to have native support for 
> windows, we should have patches discussed on the regular git list. The 
> ghetto that is windows can be useful for _user_ discussions, where a lot 
> of the core git people simply cannot help. But having development 
> discussions there is bad, I think.

We do have development discussions there that do not belong to git@vger.  
For example, when Hannes reimplemented the utterly broken spawn() 
implementation of Microsoft's "Run" time library.

That is not something you need to see, want to see, or can help with.

Likewise, I think it has nothing to do with the git@vger list when we add 
work-arounds until some better solution is found, and then discuss whether 
the workaround is still needed.

I cannot help to see the benefit, at least.

Once things are sorted out, I agree, it has to be sent to the git list.

Before that, however, allow us to work on another list.

Ciao,
Dscho
