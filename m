From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git for Windows 1.6.2.1-preview20090322
Date: Mon, 23 Mar 2009 11:59:52 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903231157270.6659@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903222149330.10279@pacific.mpi-cbg.de> <20090322225315.GC22428@sigill.intra.peff.net> <alpine.DEB.1.00.0903230015020.10279@pacific.mpi-cbg.de> <20090323025358.GA19717@coredump.intra.peff.net>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,  msysgit@googlegroups.com
To: Jeff King <peff@peff.net>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Mar 23 12:01:29 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yx-out-2122.google.com ([74.125.44.24])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlhuK-0004Sh-9E
	for gcvm-msysgit@m.gmane.org; Mon, 23 Mar 2009 12:01:28 +0100
Received: by yx-out-2122.google.com with SMTP id 22so810654yxm.63
        for <gcvm-msysgit@m.gmane.org>; Mon, 23 Mar 2009 04:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=wekRKH+9qlzWvcfJZPkZAwhiIqH7XC1KgiBYXZQl2lg=;
        b=YiCGNH5A5DBMpcGqfCLYR7xgAdjobGEJp41E5JlAlkqedJ+dXYsNJTMy/KZl25xx+2
         Vhiob0EoQGGzf4V4CysZgA/CgQ7YNX2qbRkj+mIf8woIBhNLh6lXA9klpAuJLb4TytUY
         OD+JD1nyi0x8jLmlLImzApffZfpWdjHB54Hy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=a26lTii6UGMMISisQavefrXFsxob0eZQENXbA5qSVTGv6OdkVig4V+KeSlGmiHaapg
         RH8uu97apfuQn3NeaOqdVrZhR7aq7rrVPGFb1cDPFpPJQPDB1fLuLOLpV7zPCE9ltcKQ
         Y+NJCGzcp1bLQTTw06j3RL5ff3yiKVYBbwjoA=
Received: by 10.150.11.14 with SMTP id 14mr1140494ybk.13.1237805993969;
        Mon, 23 Mar 2009 03:59:53 -0700 (PDT)
Received: by 10.177.2.5 with SMTP id e5gr4362yqi.0;
	Mon, 23 Mar 2009 03:59:53 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.86.89.20 with SMTP id m20mr45354fgb.26.1237805993343; Mon, 23 Mar 2009 03:59:53 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 5si271243fge.7.2009.03.23.03.59.53; Mon, 23 Mar 2009 03:59:53 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 23 Mar 2009 10:59:52 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5] by mail.gmx.net (mp071) with SMTP; 23 Mar 2009 11:59:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18a6WYKp6Ua1fyF6C4f/08teqtxc0tNSvFDrJq/0q 3v9Eu45ZNDl4a7
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090323025358.GA19717@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114286>


Hi,

On Sun, 22 Mar 2009, Jeff King wrote:

> On Mon, Mar 23, 2009 at 12:25:57AM +0100, Johannes Schindelin wrote:
> 
> > > A few people have asked about filter-branch on Windows recently;
> > 
> > I am not aware of any.  But then, I think nobody mentioned it on the 
> > msysgit list (which would be the correct place), and I am likely to 
> > have missed it if it was sent elsewhere.
> 
> They were less feature request and more mentioned in the middle of other 
> discussions. I am thinking specifically of:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/112253/focus=112439
>   http://thread.gmane.org/gmane.comp.version-control.git/111722/focus=112103

Well, I will miss such in-the-middle-of-unrelated-discussions remarks.  
Even if some people think I ridicule them when I say that I do not have 
much time, it is a fact.  If I did not like Git as much as I do, I would 
have stopped long time ago for sanity reasons.

> > Actually, not only Hannes' version runs the test t7003 okay, but also 
> > 4msysgit's version.
> > 
> > But let's reduce the differences between git.git and 4msysgit.git 
> > further first.
> 
> OK. I just wanted to make you aware of the existing threads and Hannes' 
> message, since as you mentioned they _weren't_ on the msysgit list.

FWIW I ran the test while replying to your mail yesterday, and created the 
'filter-branch' branch in msysgit.git.  I'll probably just merge it into 
our 'master' later today.

Ciao,
Dscho
