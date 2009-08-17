From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Mon, 17 Aug 2009 22:54:59 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908172252370.8306@pacific.mpi-cbg.de>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>  <1250525103-5184-2-git-send-email-lznuaa@gmail.com>  <1250525103-5184-3-git-send-email-lznuaa@gmail.com>  <1250525103-5184-4-git-send-email-lznuaa@gmail.com>  <1250525103-5184-5-git-send-email-lznuaa@gmail.com> <4A899495.8050902@gnu.org> <40aa078e0908171040g5718a809o88b093fe5a4a0e28@mail.gmail.com> <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de> <4A89B772.8060307@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Erik Faye-Lund <kusmabite@googlemail.com>, Frank Li <lznuaa@gmail.com>,  git@vger.kernel.org, msysgit@googlegroups.com
To: Paolo Bonzini <bonzini@gnu.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Aug 17 22:54:24 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f140.google.com ([209.85.211.140])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md9Dh-0005vZ-7m
	for gcvm-msysgit@m.gmane.org; Mon, 17 Aug 2009 22:54:21 +0200
Received: by ywh4 with SMTP id 4so5179522ywh.22
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Aug 2009 13:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:received:x-authenticated:x-provags-id:date:from:x-x-sender
         :to:cc:subject:in-reply-to:message-id:references:user-agent
         :mime-version:content-type:x-y-gmx-trusted:x-fuhafi:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=g+d/tDe3670PSOtNvNRWsDbQOWoPx9Jr5xZhSS+Qa/o=;
        b=eci9WONQLsGNGC2hSV3XQ0oHNyUvpJM0n2hcoIs1m6fddYcj+1z6gJgpPMj07PokfQ
         Kjwj0y/liMasVh8GLdarw5T2c/yzXnVRkjrUT892Bl5cvoxNYXE5j9j/7pXKwI8hKDS7
         GO2OedhXYPZU7GQkt8GptmMafpUIfEydfB7so=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=TkG5sD/f1sAYRUYE1vbEveSMPJp36u7Vib5NXJiifH2rgI0/tfWu0YFWzE20vajEwt
         +qQw4RInMDdUdA87qN6QEh7yrbrqp4KSH8T7vGzAxeDtsLx/qPCLq/jxfOSR4+HdCzcF
         1HynMMVEJ5rhAHYi5xTaAeAk+clmKSfVCKUNM=
Received: by 10.150.129.23 with SMTP id b23mr1266201ybd.10.1250542454656;
        Mon, 17 Aug 2009 13:54:14 -0700 (PDT)
Received: by 10.176.48.40 with SMTP id v40gr6386yqv.0;
	Mon, 17 Aug 2009 13:54:13 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.24.75 with SMTP id u11mr211608bkb.0.1250542451216; Mon, 17 Aug 2009 13:54:11 -0700 (PDT)
Received: by 10.204.24.75 with SMTP id u11mr211607bkb.0.1250542451197; Mon, 17 Aug 2009 13:54:11 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 16si706235fxm.6.2009.08.17.13.54.11; Mon, 17 Aug 2009 13:54:11 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 17 Aug 2009 20:54:10 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38] by mail.gmx.net (mp069) with SMTP; 17 Aug 2009 22:54:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+dTBAmeQ+d9LXqL53US6DcpcZj4B4iHW6XaXtx8A NgNELPZhneNAz3
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4A89B772.8060307@gnu.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126277>


Hi,

On Mon, 17 Aug 2009, Paolo Bonzini wrote:

> > I think the killer argument against such a script (I actually though 
> > of that myself, but decided against it for that very reason) is that 
> > the result is to be used by Microsoft Visual Studio users, who do not 
> > typically have a scripting language, and who would not want to use it 
> > anyway.
> 
> But the script could run whenever the Makefile is updated, even under 
> Unix.

But that would have to be kept in mind by the maintainer, and he could not 
test it.

Besides, IIUC you were proposing a generator, while I suggested a 
rewriter.  My idea would require much less work, as the changes to the 
original, known good, .vcproj are minimal.

So let's have a script (if anybody feels compelled enough) that we can run 
from time to time and when it updates at least one of the .vcproj file, we 
throw the result at Frank Li for testing.

Ciao,
Dscho
