From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Announce: Git for Windows 1.6.3
Date: Thu, 7 May 2009 23:43:07 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905072341550.18521@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0905071554070.16585@intel-tinevez-2-302> <46d6db660905071359l66ff81afkc442f435edadb07f@mail.gmail.com>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Christian MICHON <christian.michon@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu May 07 23:42:52 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f143.google.com ([209.85.221.143])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2BMa-00016F-SB
	for gcvm-msysgit@m.gmane.org; Thu, 07 May 2009 23:42:45 +0200
Received: by qyk7 with SMTP id 7so1605987qyk.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 May 2009 14:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=BF/nLkeS0qn3QU+66PN7AOwbtRjh2MXUB6pnzQYe7t8=;
        b=sMzfUdMGhBvGn7Y3CcXgTrBN59dXeDD6i7usBNXaoihborXxy9KXQPZQPA9z3V9K6T
         cxsBWmk1/Me4g/Wfu9gnVZi6yWFbcZpOv7Xth2s7D6CZzRtCAEl7HgrBJA1152waK3f1
         ZTIOYdGlCbEvOiES321YxmnksydgbqRz5+FKs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=Otsy3uY9uH1jUQhcA6qa7bFKmpc4lOey9g1RFgPecjIh84ULPU9e5NSz1kV+9Gpp4q
         zAVd78gDcS0hJtaU9V1qB3g8wFywdK5TRSPV8A2bxTHFmP2v+FhWsLr9fpPtdE+NmAa1
         pH25HwixZLTTQhT2ORvWYQ5Kv+MKcPLyVgFLs=
Received: by 10.224.19.198 with SMTP id c6mr554442qab.19.1241732554428;
        Thu, 07 May 2009 14:42:34 -0700 (PDT)
Received: by 10.106.168.10 with SMTP id q10gr5098pre.0;
	Thu, 07 May 2009 14:42:34 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.77.78 with SMTP id f14mr82806bkk.20.1241732554059; Thu, 07 May 2009 14:42:34 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 13si68047fxm.0.2009.05.07.14.42.33; Thu, 07 May 2009 14:42:34 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 07 May 2009 21:42:33 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38] by mail.gmx.net (mp026) with SMTP; 07 May 2009 23:42:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+EHUAg/GqE0f+3W6AjGIl/ZnUeyDbtXM/t8G60DL gR63ivl+sI83sZ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <46d6db660905071359l66ff81afkc442f435edadb07f@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118527>


Hi,

On Thu, 7 May 2009, Christian MICHON wrote:

> on my vista system (family premium sp1, French edition), I get a git 
> setup window towards the end of setup saying
> 
> Line 620: Unable to read file "etc\fileList-builtins.txt"
> 
> Beyond this setup hickup, all seems to be in order and working locally
> (I have not tried pushing stuff yet).

Thanks!  Your feedback is really appreciated (and of course, the praise, 
too).

In response to Bernt's report, I uploaded a new Git installer which does 
not have that problem (and this time I actually tested it again).

Ciao,
Dscho
