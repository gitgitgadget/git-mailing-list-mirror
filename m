From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Store autocrlf during init-db (was [msysGit] autocrlf
 problems with Git-preview20080301.exe)
Date: Sun, 23 Mar 2008 17:35:13 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803231734190.4353@racer.site>
References: <f5d99ae7-e4b3-4632-ad86-8ebe0e683d49@d62g2000hsf.googlegroups.com> <alpine.LSU.1.00.0803101327390.3975@racer.site> <bdca99240803100611s3c8b3b9djb1b993c9fbad712@mail.gmail.com> <alpine.LSU.1.00.0803101448430.3975@racer.site> <cb8f4255-2bf8-4489-aeb0-c18d6e932342@s13g2000prd.googlegroups.com> <ab311292-809f-4e45-a19d-a600c2333ab6@a23g2000hsc.googlegroups.com> <alpine.OSX.1.00.0803221036230.7618@cougar> <7vzlsqfe2h.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803230310500.4353@racer.site> <alpine.OSX.1.00.0803230943500.7541@cougar> <alpine.LSU.1.00.0803231200010.4353@racer.site> <alpine.OSX.1.00.0803231326290.11994@cougar> <alpine.LSU.1.00.0803231404390.4353@racer.site> <alpine.OSX.1.00.0803231428220.13789@cougar> <alpine.LSU.1.00.0803231506000.4353@racer.site> <alpine.OSX.1
 .00.0803231643040.16879@cougar>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junio@pobox.com>, tormod.hystad@gmail.com,  msysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Mar 23 17:35:57 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wr-out-0708.google.com ([64.233.184.250])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdTAq-0006Gx-1G
	for gcvm-msysgit@m.gmane.org; Sun, 23 Mar 2008 17:35:56 +0100
Received: by wr-out-0708.google.com with SMTP id c3so586531wra.9
        for <gcvm-msysgit@m.gmane.org>; Sun, 23 Mar 2008 09:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=gamma;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=FKB3hDO2a1FLbJl209A/V689jNS2pbJm6/Ls+V8mOVA=;
        b=wIC6yrbL2fu3G75+y86bi1D5P74/lIncNoLsMpu5n5gDfuYo7cfU2MI0z/gx6nBJx4x4axq2RADxOCNKiyiIg/ZSrbRzCFdpfHUBFF+hD+mN4eB44oErjyX4HH2ZNDOEGYoZPMyMaB4m27Nt60kqlOaL4gwF+PyjJmsdYXmjCwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=gamma;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=1t1Cj5cCh65cppIawD+CIOtie7aSAa/2h+3uYlgUcrz2SuZeQHTn5m6lRojZA0mkTydbQVld94g4uc/3efX66S3UrLNlme8VgEiz4flkz4eHbO5dNuYFyo7WeMtyIYO2VxKt06GcVL8Rh0FabOumEeUP5PAKCmuYyutHyMs89As=
Received: by 10.100.144.18 with SMTP id r18mr1351091and.14.1206290115610;
        Sun, 23 Mar 2008 09:35:15 -0700 (PDT)
Received: by 10.44.74.68 with SMTP id w68gr2005hsa.0;
	Sun, 23 Mar 2008 09:35:15 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.35.13.4 with SMTP id q4mr6617310pyi.7.1206290114122; Sun, 23 Mar 2008 09:35:14 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id a28si7852569pye.0.2008.03.23.09.35.13; Sun, 23 Mar 2008 09:35:14 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 23 Mar 2008 16:35:12 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43] by mail.gmx.net (mp035) with SMTP; 23 Mar 2008 17:35:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2428rn222k3U8OtRXqe1kByT2jQvuicBH9S4HYE JLAW5iJayK7Kty
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.OSX.1.00.0803231643040.16879@cougar>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77924>


Hi,

On Sun, 23 Mar 2008, Steffen Prohaska wrote:

> On Sun, 23 Mar 2008, Johannes Schindelin wrote:
> 
> > On Sun, 23 Mar 2008, Steffen Prohaska wrote:
> > 
> > > On Sun, 23 Mar 2008, Johannes Schindelin wrote:
> > > 
> > > > The point is: if we use /etc/gitconfig, we also touch _existing_ 
> > > > setups (as Junio pointed out).  Which, in the case of autocrlf, is 
> > > > not desirable.
> > > 
> > > I proposed a mechanism that would avoid such problems in the future.
> > 
> > Yes, but your solution feels a bit limited and "hot-needled" for just 
> > one purpose.
> 
> What limits do you mean (except that it does still break existing 
> msysgit setups; but would avoid this problem in the future)?

I have the impression that a problem just like this will arise again, just 
not with corelf, but with another setting that the admin might want to 
set per default in git-init, but the user might want to override.

Ciao,
Dscho
