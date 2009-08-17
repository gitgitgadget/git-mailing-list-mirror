From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: CMake, was Re: [PATCH 09/11] Add MSVC porting header files.
Date: Mon, 17 Aug 2009 21:48:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908172147240.8306@pacific.mpi-cbg.de>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>  <1250525103-5184-2-git-send-email-lznuaa@gmail.com>  <1250525103-5184-3-git-send-email-lznuaa@gmail.com>  <1250525103-5184-4-git-send-email-lznuaa@gmail.com>  <alpine.DEB.1.00.0908171902300.4991@intel-tinevez-2-302> <3af572ac0908171231n30864c85ud67454a03ca08fbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org, msysgit@googlegroups.com
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Aug 17 21:48:08 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f162.google.com ([209.85.210.162])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md8Bb-00022c-B9
	for gcvm-msysgit@m.gmane.org; Mon, 17 Aug 2009 21:48:07 +0200
Received: by yxe34 with SMTP id 34so5177852yxe.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Aug 2009 12:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:received:x-authenticated:x-provags-id:date:from:x-x-sender
         :to:cc:subject:in-reply-to:message-id:references:user-agent
         :mime-version:content-type:x-y-gmx-trusted:x-fuhafi:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=pR8WPKvnY7luO/WRnyRKQHLYNCFQE3u/SgXyISCCxGw=;
        b=HRU4iO13DXsSkK24w2gCcVjDQ5OHVzTKMLYPJzJLQHTThNCV+gXuNw57YSJ13/I2fA
         c9EHgP7ehPnitdWIV+l8X3CKTF2cILVmPh+45yNHjE2E+SujprYJJxe5tnidbfKl6tEA
         0pKHWvFFXDdN8ujfW0AQAYHWZq2i15Jmj0TmY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=1MkpgEJewV1vFBP9fmRPEWb1XhXU22ZzXvNEfXYrjahUx3tJiLy55oS42o83HKQ8YF
         PXEEl3KUfflFb4jIU09T1UMlgPEUWQO9T3eEitxUEQkHPfPMJgDSXkyF6EvBHCge0gp4
         cgEnyZD7EqnFH9pNK06u4Hl1G2ooe3u7ile3A=
Received: by 10.150.129.23 with SMTP id b23mr1248066ybd.10.1250538481011;
        Mon, 17 Aug 2009 12:48:01 -0700 (PDT)
Received: by 10.177.102.22 with SMTP id e22gr6379yqm.0;
	Mon, 17 Aug 2009 12:47:59 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.32.134 with SMTP id c6mr209269bkd.13.1250538478798; Mon, 17 Aug 2009 12:47:58 -0700 (PDT)
Received: by 10.204.32.134 with SMTP id c6mr209268bkd.13.1250538478779; Mon, 17 Aug 2009 12:47:58 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 13si693028fxm.4.2009.08.17.12.47.58; Mon, 17 Aug 2009 12:47:58 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 17 Aug 2009 19:47:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38] by mail.gmx.net (mp065) with SMTP; 17 Aug 2009 21:47:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+5wYQYJSe5VTeqspBZJi3IibIuHKSt1Gxr7yxtfE XMEahEr3m3lII8
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <3af572ac0908171231n30864c85ud67454a03ca08fbe@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126262>


Hi,

On Mon, 17 Aug 2009, Pau Garcia i Quiles wrote:

> What about having a CMake build system, which would work on every
> platform (including cross-compiling), and would produce an appropriate
> config.h and makefiles/vcproj/Eclipse projects/XCode projects/whatever
> is fit for each platform? If it's OK to include such a build system
> upstream, I'm volunteering to implement it.

And reap in another dependency?

First Python, then CMake, what tomorrow?  Is it the month of adding 
dependencies?

Ciao,
Dscho
