From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Windows & executable bit
Date: Tue, 18 Aug 2009 14:59:59 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908181459380.4680@intel-tinevez-2-302>
References: <45321.77.61.241.211.1250588523.squirrel@hupie.xs4all.nl>  <alpine.DEB.1.00.0908181213590.4680@intel-tinevez-2-302>  <200908181223.48291.trast@student.ethz.ch>  <alpine.DEB.1.00.0908181355090.4680@intel-tinevez-2-302> <40aa078e0908180519u41b28ce7oc851791db1d5f773@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>,  Ferry Huberts <ferry.huberts@pelagic.nl>, msysgit@googlegroups.com,  git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Aug 18 15:00:37 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f162.google.com ([209.85.210.162])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdOIh-0000Xb-Sq
	for gcvm-msysgit@m.gmane.org; Tue, 18 Aug 2009 15:00:32 +0200
Received: by mail-yx0-f162.google.com with SMTP id 34so6077360yxe.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 18 Aug 2009 06:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:received:x-authenticated:x-provags-id:date:from:x-x-sender
         :to:cc:subject:in-reply-to:message-id:references:user-agent
         :mime-version:content-type:x-y-gmx-trusted:x-fuhafi:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=gwoKAwFlX7+gQjbnKoJXIQBu4dYyiXlrROguvkoe9Dw=;
        b=CuQiTVVeW2WOWWdu4NxcUDt+MPAA17eXJWAvIPig8vzSWXKKrOHtVYwfBsjV3ZUjko
         0353bwCMGkynzY14cGW3WeT3XK+5IzrX/XcIuNF8qwD5nBQm7zGTMeeYDFVFWZJUsOLW
         2VNcb7gvkln3+lkHMf9tuTlWIWJmzW9h47nV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=wb5wKgsIc4xaQV27KM38GTjPf8CZ4Sicq2wf+Vmj5u1lCYNNroH5jIn2d/eBbXazwx
         NuFLE5R8aPyIZdyXkcepFhmGgEr9FMsqXKXO4twc8BuaY4bqZypeLsjFS+MA4wwcd9Be
         wlj5PiCwTBbF4Sm2QUmW9BR7VNy1MysZ1GrHE=
Received: by 10.100.55.24 with SMTP id d24mr1632835ana.27.1250600426240;
        Tue, 18 Aug 2009 06:00:26 -0700 (PDT)
Received: by 10.177.38.34 with SMTP id q34gr6465yqj.0;
	Tue, 18 Aug 2009 06:00:02 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.223.16.88 with SMTP id n24mr155278faa.28.1250600401558; Tue, 18 Aug 2009 06:00:01 -0700 (PDT)
Received: by 10.223.16.88 with SMTP id n24mr155277faa.28.1250600401527; Tue, 18 Aug 2009 06:00:01 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 16si782554bwz.0.2009.08.18.06.00.01; Tue, 18 Aug 2009 06:00:01 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 18 Aug 2009 13:00:00 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5] by mail.gmx.net (mp035) with SMTP; 18 Aug 2009 15:00:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19gZ+Am7yNgI5hYtDAw9VOu2MTFzxdMsb9+0PBUE3 MWFs7Rt4W0diSp
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <40aa078e0908180519u41b28ce7oc851791db1d5f773@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126392>


Hi,

On Tue, 18 Aug 2009, Erik Faye-Lund wrote:

> On Tue, Aug 18, 2009 at 1:55 PM, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
> >> > git config trust.fileMode false
> >>
> >> Isn't that core.filemode ?
> >
> > The matching is actually case-insensitive, but I prefer CamelCase here...
> 
> I believe the question was about it being in the trust vs the core 
> section...

Bah, you're right.  I let myself fool by the lowercase 'm'.  Sorry.

Ciao,
Dscho
