From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git for Windows 1.6.3.2
Date: Mon, 8 Jun 2009 14:03:58 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906081403390.4461@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0906071629460.26154@pacific.mpi-cbg.de>    <26984.77.61.241.211.1244457815.squirrel@hupie.xs4all.nl>    <fabb9a1e0906080351hbfe7ab7w2016a030ef1bde7@mail.gmail.com>    <alpine.DEB.1.00.0906081255530.4461@intel-tinevez-2-302> <34357.77.61.241.211.1244459143.squirrel@hupie.xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>, msysgit@googlegroups.com,  git@vger.kernel.org
To: Ferry Huberts <ferry.huberts@pelagic.nl>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Jun 08 14:04:23 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f187.google.com ([209.85.217.187])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDdaM-0004wL-Tp
	for gcvm-msysgit@m.gmane.org; Mon, 08 Jun 2009 14:04:19 +0200
Received: by mail-gx0-f187.google.com with SMTP id 7so3391604gxk.21
        for <gcvm-msysgit@m.gmane.org>; Mon, 08 Jun 2009 05:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=jtif0VpUFbTd18xb2Q62el6Ti77Rjm8y6V3dsTSffSU=;
        b=3CC3RCq9hZbkAX26BrWodUxPkhIBak3LTQuxl1+Z0MzsVAW45x0BkWO5ChGAJe59U5
         vtLJ7RtR8d0T5Z3DzuEyIU8f7DUN6+KI4ReDrSiEnaADTr8z2Yi0MMxJtBq6+gPB9jEO
         l/kZyEgvTwJGAyZbLxeoyQicqiQUfN5oHg8K4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=NmALibWQ/IHgE6AE7e4GJcUrwJYSdMYtAZURYS3Vug6X1LvjlDEqG92+PMTQa8qKwi
         4JU7twwF+TjoS1V1zzkK38rYke6pT+DitgtrModjxvryiOJ+yRSKVooES5uZCVq71tj/
         kGUXWhusbDwZicsaZrVUjokSRGBttJ0123Sv4=
Received: by 10.220.99.12 with SMTP id s12mr2237036vcn.11.1244462640666;
        Mon, 08 Jun 2009 05:04:00 -0700 (PDT)
Received: by 10.230.110.28 with SMTP id l28gr5511vbp.0;
	Mon, 08 Jun 2009 05:04:00 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.86.68.10 with SMTP id q10mr108777fga.4.1244462639694; Mon, 08 Jun 2009 05:03:59 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id d8si156101fga.0.2009.06.08.05.03.59; Mon, 08 Jun 2009 05:03:59 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 08 Jun 2009 12:03:59 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5] by mail.gmx.net (mp008) with SMTP; 08 Jun 2009 14:03:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19x2EMfGmNxwKanRWGpYJCf52wlbTcvtMAzw9NRYC qkAv593axGu/EU
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <34357.77.61.241.211.1244459143.squirrel@hupie.xs4all.nl>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121066>


Hi,

On Mon, 8 Jun 2009, Ferry Huberts wrote:

> > The original fix was indeed done for a reason.
> >
> > My best guess (as I said in another email on the msysgit list today, 
> > where Ferry probably did not expect helpful information): msys-1.0.dll 
> > was not properly updated.
> 
> sorry for that, I am subscribed to git.devel only. probably should have 
> checked the msysgit list
> 
> > I worked on a check for this some time ago, but I forgot to finish and 
> > include it in our official 'devel'.
> 
> does this mean that we can expect a '-2' msysgit release soon?

No.

Ciao,
Dscho
