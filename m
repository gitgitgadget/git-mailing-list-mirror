From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] mergetool-lib: make (g)vimdiff workable under
 Windows
Date: Sun, 5 Apr 2009 12:32:19 +0200
Message-ID: <200904051232.19939.markus.heidelberg@web.de>
References: <200904041517.55890.markus.heidelberg@web.de> <alpine.DEB.1.00.0904051134210.10279@pacific.mpi-cbg.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>, Charles Bailey <charles@hashpling.org>, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Apr 05 12:33:54 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqPfl-0007kH-N9
	for gcvm-msysgit@m.gmane.org; Sun, 05 Apr 2009 12:33:53 +0200
Received: by yw-out-2122.google.com with SMTP id 1so598307ywp.63
        for <gcvm-msysgit@m.gmane.org>; Sun, 05 Apr 2009 03:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:jabber-id:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:x-sender
         :x-provags-id:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=ZjNk12rLG5WpXdEzKHo2ie8KKptcKRHZPtbKCUXMk0M=;
        b=cjWIlrD5iko/IuI+va4d3H+Yo/UH1A4S9zArQPqLZoNTNxbTQYEvOAU8OxbcALUtPb
         9fA/m57wsjeP5Z+4Tum0V2zEuY7hxTGztaW6GSoBDly/1bZm2lV2cq6UFscqc4oETnVK
         w818RDWRi0LZy8Y5Rnw3BEGG7pBC3L0KvOQ4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :reply-to:to:subject:date:user-agent:cc:references:in-reply-to
         :jabber-id:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:x-provags-id:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=k9b8gUYzncfU9Qw5LA4rV87uTFhpdzfrdW0pmM0zgiAlykS8Tc5jouGrUsnuFyJBNB
         nBNj1k7YIj0Alq1Su+O3Mhx8n8AnY3IxA+evXRPKKz8lNbJDgNhUUpDVm1H1eTv/mVJm
         8jh0thaJYPNLBpIkBQgR8+p+TCzrFfMgAagls=
Received: by 10.150.212.16 with SMTP id k16mr493005ybg.14.1238927537022;
        Sun, 05 Apr 2009 03:32:17 -0700 (PDT)
Received: by 10.177.68.38 with SMTP id v38gr4645yqk.0;
	Sun, 05 Apr 2009 03:32:17 -0700 (PDT)
X-Sender: markus.heidelberg@web.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.91.9 with SMTP id o9mr1548844agb.18.1238927535980; Sun, 05 Apr 2009 03:32:15 -0700 (PDT)
Received: from fmmailgate02.web.de (fmmailgate02.web.de [217.72.192.227]) by gmr-mx.google.com with ESMTP id 15si502071gxk.4.2009.04.05.03.32.15; Sun, 05 Apr 2009 03:32:15 -0700 (PDT)
Received-SPF: pass (google.com: domain of markus.heidelberg@web.de designates 217.72.192.227 as permitted sender) client-ip=217.72.192.227;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of markus.heidelberg@web.de designates 217.72.192.227 as permitted sender) smtp.mail=markus.heidelberg@web.de
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216]) by fmmailgate02.web.de (Postfix) with ESMTP id 3AA04FC7D54B; Sun,  5 Apr 2009 12:32:15 +0200 (CEST)
Received: from [89.59.118.104] (helo=.) by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256) (WEB.DE 4.110 #277) id 1LqPeA-0000BB-00; Sun, 05 Apr 2009 12:32:15 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0904051134210.10279@pacific.mpi-cbg.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18Y9+CNbmUF8iBQhgRmVlGVRkAodAfxyXTXeeen fy3L60HUCiw83JeF4TNG92l7YtvCRCsP/9bn+fO3vykb6FaTD0 IsyIwYjciinQwo+9SwlQ==
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115654>


Johannes Schindelin, 05.04.2009:
> Hi,
> 
> On Sat, 4 Apr 2009, Markus Heidelberg wrote:
> 
> > Under Windows vimdiff and gvimdiff are not available as symbolic links, 
> > but as batch files vimdiff.bat and gvimdiff.bat. These files weren't 
> > found by 'type vimdiff' which led to the following error:
> > 
> >     The merge tool vimdiff is not available as 'vimdiff'
> > 
> > Even if they were found, it wouldn't work to invoke these batch files
> > from git-mergetool.
> > 
> > To solve this, use vim and gvim (vim.exe and gvim.exe) and pass the -d
> > command line switch over to them.
> > 
> > Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
> > ---
> > 
> > This patch goes on top of the current difftool/mergetool patches from David.
> 
> ,.. which is a pity, because I could have applied them directly to 
> msysGit's 'devel' branch otherwise.

There is currently a lot of refactoring going on in difftool/mergetool,
so of course I didn't send this to Junio against 'master'. But if you
want I can send it for you based on 'master' (or 4msysgit.git 'devel').

Junio, is this something for maint? I'm not sure, since this problem
only occurs on Windows and 'maint' isn't interesting for msysgit ATM.

Markus
