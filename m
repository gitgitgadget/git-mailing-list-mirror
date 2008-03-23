From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Store autocrlf during init-db (was [msysGit] autocrlf
 problems with Git-preview20080301.exe)
Date: Sun, 23 Mar 2008 12:01:08 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803231200010.4353@racer.site>
References: <f5d99ae7-e4b3-4632-ad86-8ebe0e683d49@d62g2000hsf.googlegroups.com> <alpine.LSU.1.00.0803101327390.3975@racer.site> <bdca99240803100611s3c8b3b9djb1b993c9fbad712@mail.gmail.com> <alpine.LSU.1.00.0803101448430.3975@racer.site> <cb8f4255-2bf8-4489-aeb0-c18d6e932342@s13g2000prd.googlegroups.com> <ab311292-809f-4e45-a19d-a600c2333ab6@a23g2000hsc.googlegroups.com> <alpine.OSX.1.00.0803221036230.7618@cougar> <7vzlsqfe2h.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803230310500.4353@racer.site> <alpine.OSX.1.00.0803230943500.7541@cougar>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junio@pobox.com>, tormod.hystad@gmail.com,  msysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Mar 23 12:02:02 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wr-out-0708.google.com ([64.233.184.240])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdNxV-0008MY-F9
	for gcvm-msysgit@m.gmane.org; Sun, 23 Mar 2008 12:01:49 +0100
Received: by wr-out-0708.google.com with SMTP id c3so325701wra.9
        for <gcvm-msysgit@m.gmane.org>; Sun, 23 Mar 2008 04:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=gamma;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=Wc5miHaFhdUUP8rtXoRT9dC+H6Gxj7RewSQuPWCtNnU=;
        b=ZiNZIKTxrVwREkB6CJ9kVhxfDmQ4cZHy1NVyM/4oJPKL8x9xjlOVGLZlUmPV3euWAkeEirQ+EjsPGy0sENPs3LLU8fJl2zgEW1eKGBbHPKz+H6anrXjPHPgIImHsS7kMrvjvGTqcQILL7NnYwrcdEH/70Gd6gVCgY0lHcYYlQeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=gamma;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=c4zmkOOAEN//FQlTbb7Ex4sLiUtGENdFErDV6GaHwCqEiNDjsRB7asoE7Jt3+Sd0wyjylpnT+WMwjq3qFWsFOicFfkdfBvn8hmWZb8eyJIfmMcFyp6Qj3Qypa0QOU+n8hvmeVYWCI9py6BtTDov3ZC/klUIDxSV9/Q1xOyW3uHM=
Received: by 10.100.46.10 with SMTP id t10mr1337455ant.12.1206270069619;
        Sun, 23 Mar 2008 04:01:09 -0700 (PDT)
Received: by 10.44.116.1 with SMTP id o1gr1995hsc.0;
	Sun, 23 Mar 2008 04:01:09 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.35.14.4 with SMTP id r4mr6296532pyi.2.1206270069076; Sun, 23 Mar 2008 04:01:09 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id a28si7443877pye.0.2008.03.23.04.01.08; Sun, 23 Mar 2008 04:01:09 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 23 Mar 2008 11:01:07 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43] by mail.gmx.net (mp049) with SMTP; 23 Mar 2008 12:01:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lErhiLoVlnpyNj+YbezTvw84sfWrA6ns+Kdt60Q HmGJ4bZqjHPTqa
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.OSX.1.00.0803230943500.7541@cougar>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77879>


Hi,

On Sun, 23 Mar 2008, Steffen Prohaska wrote:

> On Sun, 23 Mar 2008, Johannes Schindelin wrote:
> 
> > On Sat, 22 Mar 2008, Junio C Hamano wrote:
> > 
> > > 
> > > Steffen Prohaska <prohaska@zib.de> writes:
> > > 
> > > >> I suppose autocrlf enabled by default could be useful for new 
> > > >> repositories, but not for working with existing repositories.
> > > >
> > > > We changed the global default to a sane setting for cross-platform 
> > > > projects to avoid such problems in the future.  This means that 
> > > > from now on git will take care that any repository newly created 
> > > > will have sane line endings (LF in the repository; and CRLF in the 
> > > > work tree if checked out on Windows respectively LF if checked out 
> > > > on Unix).
> > > 
> > > I've always wondered why you guys used /etc/gitconfig instead of 
> > > setting it in the templates (or a patch to git-init).
> > > 
> > > I was against the idea of /etc/gitconfig from the very beginning 
> > > (even before msysgit existed) in git.git itself, but this is a very 
> > > good example why /etc/gitconfig is a bad idea.  It affects 
> > > _existing_ setups.
> > > 
> > > How about fixing msys port so that it sets the configuration when 
> > > the user initializes a _new_ repository, without breaking 
> > > repositories the user has been happily using?
> > 
> > Makes sense.
> 
> Hmm.  I am not convinced.
> 
> Setting autocrlf for every repository limits the user's options to
> override the default.

Then maybe a way for the user to override the global templates is what we 
need?  I can see that this would be useful outside of the crlf issue.

Ciao,
Dscho
