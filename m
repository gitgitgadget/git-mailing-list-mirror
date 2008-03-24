From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Store autocrlf during init-db (was [msysGit] autocrlf
 problems with Git-preview20080301.exe)
Date: Mon, 24 Mar 2008 11:57:19 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803241155300.4353@racer.site>
References: <alpine.OSX.1.00.0803221036230.7618@cougar> <7vzlsqfe2h.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803230310500.4353@racer.site> <alpine.OSX.1.00.0803230943500.7541@cougar> <alpine.LSU.1.00.0803231200010.4353@racer.site> <alpine.OSX.1.00.0803231326290.11994@cougar> <alpine.LSU.1.00.0803231404390.4353@racer.site> <alpine.OSX.1.00.0803231428220.13789@cougar> <20080323235610.GB25381@dpotapov.dyndns.org> <alpine.LSU.1.00.0803240101220.4353@racer.site> <20080324002302.GD25381@dpotapov.dyndns.org>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>, Junio C Hamano <junio@pobox.com>,  tormod.hystad@gmail.com, msysGit <msysgit@googlegroups.com>,  git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Mar 24 11:58:01 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wr-out-0708.google.com ([64.233.184.242])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdkNN-0003sn-72
	for gcvm-msysgit@m.gmane.org; Mon, 24 Mar 2008 11:58:01 +0100
Received: by wr-out-0708.google.com with SMTP id c3so1386689wra.9
        for <gcvm-msysgit@m.gmane.org>; Mon, 24 Mar 2008 03:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=gamma;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=3FV8g9zHA8Jycjr28FeeR6Lc9pfJ4jGmBkMLXOtHkMQ=;
        b=DZAGDtzPmHAfzivD7z9jZOsN5eJWE8+C019M8LnYz8/A2RFpwbQ56v1dVI4eZOqIisq6reP+LSJZ2cY4g+XPWDwxkpXxNq7ZK40NxvNdCSjPg6NK7Ux3qW8K/AR/vKlVOZIP3so1vKp3iur4SqThFSnl31NELp9c0DVSsOJnp2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=gamma;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=23EA344dR2r2M5VO8nzOxzx0+iru7UOWYaH6qXAwTgMtQx8LLpK6qW4tF3hrZQJTeuIymp4DRyxFC4M2JZtbxdDB3axuAxZwAYrFSyCWZ9ONN7Gc+gtr4pDo2rQu+0EwtZN+MOODjMiS2Gvpt9tdT+q3pdKpT+cdoDzeRIcnltI=
Received: by 10.100.96.9 with SMTP id t9mr1407873anb.10.1206356238830;
        Mon, 24 Mar 2008 03:57:18 -0700 (PDT)
Received: by 10.44.116.1 with SMTP id o1gr2012hsc.0;
	Mon, 24 Mar 2008 03:57:18 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.35.126.2 with SMTP id d2mr7655828pyn.1.1206356237969; Mon, 24 Mar 2008 03:57:17 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id z53si9034643pyg.1.2008.03.24.03.57.17; Mon, 24 Mar 2008 03:57:17 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 24 Mar 2008 10:57:16 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43] by mail.gmx.net (mp011) with SMTP; 24 Mar 2008 11:57:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX184cf9JW904cWXmemQ4vW0pc2vd7vIPBLUxLzOk2y A5iGoKCJJ9XbW8
X-X-Sender: gene099@racer.site
In-Reply-To: <20080324002302.GD25381@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78018>


Hi,

On Mon, 24 Mar 2008, Dmitry Potapov wrote:

> On Mon, Mar 24, 2008 at 01:01:54AM +0100, Johannes Schindelin wrote:
> > 
> > On Mon, 24 Mar 2008, Dmitry Potapov wrote:
> > 
> > > We already have templates for different hooks, info/exclude, etc. 
> > > So, instead of placing autocrlf in /etc/gitconfig, you should place 
> > > this variable to /usr/share/git/templates/config and this file 
> > > should be copied by git init or git clone as any other file in 
> > > templates.
> > 
> > I thought we discussed that already?  And the consensus was that this 
> > does not allow for per-user overriding.
> 
> I am sorry I missed this discussion. In this case, I believe that the 
> idea of templates should be extended, so any user may have his/her own 
> templates in $HOME/.gittemplates. IMHO, it makes much more sense than 
> making an exception for autocrlf in builtin-init-db.c and breaking 
> existing repositories...

I think I actually suggested something like that.  But that gets only even 
more complicated: if you have a template for .git/config in 
$HOME/.gittemplates/, then the global template will be _disregarded_, even 
if the administrator puts something vital in there.

Maybe the best idea would be an "init" hook, settable from the config, 
after all.

Ciao,
Dscho
