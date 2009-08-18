From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Windows & executable bit
Date: Tue, 18 Aug 2009 13:55:34 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908181355090.4680@intel-tinevez-2-302>
References: <45321.77.61.241.211.1250588523.squirrel@hupie.xs4all.nl> <alpine.DEB.1.00.0908181213590.4680@intel-tinevez-2-302> <200908181223.48291.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ferry Huberts <ferry.huberts@pelagic.nl>, msysgit@googlegroups.com,  git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Aug 18 13:55:53 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f162.google.com ([209.85.210.162])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdNI9-0008RC-7O
	for gcvm-msysgit@m.gmane.org; Tue, 18 Aug 2009 13:55:53 +0200
Received: by yxe34 with SMTP id 34so6020207yxe.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 18 Aug 2009 04:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:authentication-results
         :received:received:x-authenticated:x-provags-id:date:from:x-x-sender
         :to:cc:subject:in-reply-to:message-id:references:user-agent
         :mime-version:content-type:x-y-gmx-trusted:x-fuhafi:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=zaQ7ZFHJVxjD+mZPdzUSRgX9VOGYkhVUPpva1jZ7jmM=;
        b=CO5YTNM7BmhRJxjQA5j3AHykT4qYrkOTovfvy37S4UIQZk4QuA/11+2JJXY3ZKMrL5
         5ho+BtCIgWCD0UHiHCos3nrR8rpeOJ0IqdCUWniMjwX4fLMq1Vxph9Wa3fWnSqUUpw5l
         En+2O9A7KYn4gmkP07rlZlB63tZgq/gky/qDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=sQ/HYpEXYCMVYTI7QobTqomZWKm5Z8ru+DZCI3U7hspeuCY70mXEGHrAw/+tg7raYR
         Mtvei7/KxEMbgiEuYZgyI8NLFS2GigYQwHvOUIfn5i96+y1lK4RSFn8gfpWRvgVSxXRE
         80JcskTzSfoqgS1cKMJvqK2eK26jw8IKAoGRk=
Received: by 10.101.29.27 with SMTP id g27mr1609197anj.4.1250596546215;
        Tue, 18 Aug 2009 04:55:46 -0700 (PDT)
Received: by 10.176.94.14 with SMTP id r14gr6459yqb.0;
	Tue, 18 Aug 2009 04:55:37 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.103.202.3 with SMTP id e3mr156168muq.12.1250596536327; Tue, 18 Aug 2009 04:55:36 -0700 (PDT)
Received: by 10.103.202.3 with SMTP id e3mr156167muq.12.1250596536309; Tue, 18 Aug 2009 04:55:36 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 15si774549bwz.6.2009.08.18.04.55.36; Tue, 18 Aug 2009 04:55:36 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 18 Aug 2009 11:55:35 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5] by mail.gmx.net (mp039) with SMTP; 18 Aug 2009 13:55:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18KrYx3QhsKOYJljAQCr0QJHHgnQoZ5RSVc5jKQ2l cUCxwkr5cgJQmz
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200908181223.48291.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126385>


Hi,

On Tue, 18 Aug 2009, Thomas Rast wrote:

> Johannes Schindelin wrote:
> > 
> > git config trust.fileMode false
> 
> Isn't that core.filemode ?

The matching is actually case-insensitive, but I prefer CamelCase here...

Ciao,
Dscho
