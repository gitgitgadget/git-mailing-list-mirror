From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [FYI][PATCH] Customizing the WinGit installer
Date: Mon, 6 Oct 2008 20:01:38 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810061959280.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20081003122727.GE10360@machine.or.cz> <alpine.DEB.1.00.0810061621110.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081006141840.GO10360@machine.or.cz> <alpine.DEB.1.00.0810061718240.22125@pacific.mpi-cbg.de.mpi-cbg.de> <m3zllhpvby.fsf@localhost.localdomain> <alpine.DEB.1.00.0810061810360.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LFD.2.00.0810061031380.3208@nehalem.linux-foundation.org>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,  msysgit@googlegroups.com, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Oct 06 19:56:36 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wf-out-1516.google.com ([209.85.200.160])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmuJl-0001lu-KI
	for gcvm-msysgit@m.gmane.org; Mon, 06 Oct 2008 19:56:25 +0200
Received: by wf-out-1516.google.com with SMTP id q26so1653195wfc.33
        for <gcvm-msysgit@m.gmane.org>; Mon, 06 Oct 2008 10:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=md7mSl8K9hgzLqAdhPUNH6YiHocp4QdJ4PzRsfZzYPs=;
        b=P3J8eJzTdzAcUo4kH93ZIF8mm4XnTYAaBap+c3h/Oxhj2mp+jphCWMBNTFJ0Jw4cMA
         nLbrua/WhWsNBJniffh0wQq7t99aKq6LUbDsv298Qup6LjlY4DLkcBnrkqrjz769btwC
         kGLrC9Nz5+H4x/RIIVvCwecHc1q2/tkFjoNLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=Hb1AntTaap4lWwXSgzBfFlxjbNAmJL3a6qfUBLHHRQLEJecQamKKBr+y2EBWSvUyft
         JCBfFLh/p7dZD8mSvfgXdfNSbb6F2k2SzBvSEGwosnxGNX3/DyjAmrCyhTTauRsHFI6i
         uvxyY4XztORmglTL5id75hdv3mU9jHGOruNRw=
Received: by 10.141.12.18 with SMTP id p18mr284313rvi.18.1223315714077;
        Mon, 06 Oct 2008 10:55:14 -0700 (PDT)
Received: by 10.106.151.34 with SMTP id y34gr3004prd.0;
	Mon, 06 Oct 2008 10:55:14 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.151.156.6 with SMTP id i6mr3397678ybo.29.1223315713492; Mon, 06 Oct 2008 10:55:13 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id 39si11252283yxd.2.2008.10.06.10.55.13; Mon, 06 Oct 2008 10:55:13 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 06 Oct 2008 17:55:12 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38] by mail.gmx.net (mp061) with SMTP; 06 Oct 2008 19:55:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18rxSpn32wr1VEgZIgDWTLq/9obzYVQiBRyLF++eW 5SvvdBwfUOMiH7
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.00.0810061031380.3208@nehalem.linux-foundation.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97615>


Hi,

On Mon, 6 Oct 2008, Linus Torvalds wrote:

> On Mon, 6 Oct 2008, Johannes Schindelin wrote:
> > 
> > Well, I consider it a courtesy to the msysGit people to leave it where 
> > it is.
> 
> Umm. I consider it to be UNACCEPTABLY STUPID to claim "courtesy" if it 
> actually makes something just more irritating to users.
> 
> I absolutely detest clicking through EULA's or other self-serving crap. 
> I hate software that bothers me with their license details. Nobody reads 
> those things anyway, and an extra click or an extra window I didn't ask 
> for - _especially_ in open source software - is just a bug.
> 
> Bugs aren't "courtesy". Not to the user, and certainly not to the 
> developer.

It is not a bug.  It is a message that tells the Windows user that this is 
GPLed software, and that they are free to copy it.  Windows users (and 
developers on Windows are more of users than developers) are often not 
aware of that fact.

That is the reason why many Open Source projects do not bother on Linux, 
but do bother on Windows.

So I guess we simply disagree here.

Ciao,
Dscho
