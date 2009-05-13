From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: The 9th production of the msysGit Herald
Date: Wed, 13 May 2009 13:55:15 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905131234420.5046@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0905130225330.27348@pacific.mpi-cbg.de> <81b0412b0905130237h3bc29c80od4a8a8ad12a972a7@mail.gmail.com>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed May 13 13:55:30 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f143.google.com ([209.85.221.143])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4D3Y-0006Vj-Mx
	for gcvm-msysgit@m.gmane.org; Wed, 13 May 2009 13:55:28 +0200
Received: by qyk7 with SMTP id 7so1150157qyk.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 13 May 2009 04:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=0AeTkmDgrQXUcLDqlMedjswVcP85v2qX5hLR2rq0/8A=;
        b=jXcZOuUS1d/gpiorRz6yLfPeY0xr51e/+uXtbNN978ITFTrqrXqmvGwMajGG+Wvm2k
         FDu0o9Pai7Mw8NR69sM2SgPfReKXHqm6oFtKq2gJdDYHSiVuZtatXExtoeAaUIBjBr+m
         qhMcuh/5mAWRD39bLVrhIidA5zXLTJmDLx3sM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=RNEm2iEWIEV4OhUeSPCeVM1nqbkSRLBTez4bbQZ3p3+8WNcRGZPslwvHSR9+6K9/5W
         aJ+P40+28hr79/G5t+xhKp2vMUYeHSZgRbmaf9BJW83cTbkSZmmHPmSkTpr2bjBYWbio
         RvFbvj2U9HgZ28lo1PXJ32IJUlLK3t+4z3poI=
Received: by 10.224.19.205 with SMTP id c13mr164060qab.14.1242215717874;
        Wed, 13 May 2009 04:55:17 -0700 (PDT)
Received: by 10.230.6.42 with SMTP id 42gr5225vbx.0;
	Wed, 13 May 2009 04:55:17 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.103.175.9 with SMTP id c9mr9733mup.26.1242215717020; Wed, 13 May 2009 04:55:17 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 16si69952fxm.6.2009.05.13.04.55.16; Wed, 13 May 2009 04:55:17 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 13 May 2009 11:55:16 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5] by mail.gmx.net (mp007) with SMTP; 13 May 2009 13:55:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wAIB5U6owUCkN2/w5bqndXnhXJzxdFdDz9DOzfG G7PrJRttLp+A3f
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <81b0412b0905130237h3bc29c80od4a8a8ad12a972a7@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119038>


Hi,

On Wed, 13 May 2009, Alex Riesen wrote:

> 2009/5/13 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> > I will delete comments on the Wiki that do not contribute value, I 
> > will delete comments on the Wiki if they are just not comments but 
> > insults (and I will even delete commants that are useful after 
> > addressing their concerns), I will remove comments on the issue 
> > tracker that I do not like because they are abusive or just rantings, 
> > and I _will_ delete all mails in the Google Group that I find 
> > offensive.
> 
> You can try to setup bogofilter (the spam fitler) or spamassassin on
> the comments.

I could set up such a filter notifying me of potentially abusive comments, 
yes, but as I was pretty rigorous with deleting comments (either ignoring 
them or addressing their valid concerns), there are only a few coming in, 
and most of them are actually helpful.

Oh, and I am notified of them already ;-)

> IOW, I fully expect you to be overwhelmed with all that housekeeping one 
> day.

At the moment, it is fun...  I also see more things on the Wiki and the 
mailing list that I like these days, so I think I can cope.

What I would love, though, is having more people help with the issue 
tracker.  That is really taking a lot of time if only one person is doing 
most of it.

Ciao,
Dscho
