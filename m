From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Store autocrlf during init-db (was [msysGit] autocrlf
 problems with Git-preview20080301.exe)
Date: Sun, 23 Mar 2008 14:42:16 +0100 (CET)
Message-ID: <alpine.OSX.1.00.0803231428220.13789@cougar>
References: <f5d99ae7-e4b3-4632-ad86-8ebe0e683d49@d62g2000hsf.googlegroups.com> <alpine.LSU.1.00.0803101327390.3975@racer.site> <bdca99240803100611s3c8b3b9djb1b993c9fbad712@mail.gmail.com> <alpine.LSU.1.00.0803101448430.3975@racer.site> <cb8f4255-2bf8-4489-aeb0-c18d6e932342@s13g2000prd.googlegroups.com> <ab311292-809f-4e45-a19d-a600c2333ab6@a23g2000hsc.googlegroups.com> <alpine.OSX.1.00.0803221036230.7618@cougar> <7vzlsqfe2h.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803230310500.4353@racer.site> <alpine.OSX.1.00.0803230943500.7541@cougar> <alpine.LSU.1.00.0803231200010.4353@racer.site> <alpine.OSX.1.00.0803231326290.11994@cougar> <alpine.LSU.1.00.0803231404390.4353@racer.site>
Reply-To: prohaska@zib.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>, Junio C Hamano <junio@pobox.com>, tormod.hystad@gmail.com, msysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Mar 23 14:42:14 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wr-out-0708.google.com ([64.233.184.247])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdQSi-00080k-KV
	for gcvm-msysgit@m.gmane.org; Sun, 23 Mar 2008 14:42:12 +0100
Received: by wr-out-0708.google.com with SMTP id c3so446423wra.9
        for <gcvm-msysgit@m.gmane.org>; Sun, 23 Mar 2008 06:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=gamma;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=UGpGElBqil76mz/BMhe5/aoAdr7C04sjY9cZ+Q+6HXE=;
        b=eG9lTRYHo6Hi16ySxRE9dRlI8t2EJcSL7yKGe0C/iOwSgwVdwNVu9ctm3MkaHxKPs3yLICj6EYNCEvS9gi4q2bB0hMbWuxDrLA2LDuZ6eAnRJctcEZSZ9WESV3EQTkwFin0Q09y+UQDOM2Y3gYwwKA6wAvFhdGL3KygJzy/umkw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=gamma;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=Fg/HHZ3P+hAaWKw/InL6hQQYnYDZhMuxIJzr7xrvGuxXotuQLvcPNm7opf8G4FhCmAJnm81cr1ocMsby5lKcVDq7yCVzan0e5zrOdA0HwKBBKu5lWrRzi9cEzfNPDnoiIP/xUwhPs9T6QENw2QIRSMjqEcIqkjwJnoFenR7DVlQ=
Received: by 10.100.242.20 with SMTP id p20mr643600anh.27.1206279692332;
        Sun, 23 Mar 2008 06:41:32 -0700 (PDT)
Received: by 10.44.77.7 with SMTP id z7gr2001hsa.0;
	Sun, 23 Mar 2008 06:41:32 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.35.124.20 with SMTP id b20mr6419584pyn.5.1206279691631; Sun, 23 Mar 2008 06:41:31 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id z53si7610338pyg.1.2008.03.23.06.41.31; Sun, 23 Mar 2008 06:41:31 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.14.2/8.14.2) with ESMTP id m2NDfSSX003872; Sun, 23 Mar 2008 14:41:28 +0100 (CET)
Received: from cougar (brln-4db97827.pool.einsundeins.de [77.185.120.39]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m2NDfNRa017606 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Sun, 23 Mar 2008 14:41:27 +0100 (MET)
In-Reply-To: <alpine.LSU.1.00.0803231404390.4353@racer.site>
User-Agent: Alpine 1.00 (OSX 882 2007-12-20)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77893>


On Sun, 23 Mar 2008, Johannes Schindelin wrote:

> On Sun, 23 Mar 2008, Steffen Prohaska wrote:
> 
> > On Sun, 23 Mar 2008, Johannes Schindelin wrote:
> > 
> > > On Sun, 23 Mar 2008, Steffen Prohaska wrote:
> > > 
> > > > On Sun, 23 Mar 2008, Johannes Schindelin wrote:
> > > > 
> > > > Setting autocrlf for every repository limits the user's options to
> > > > override the default.
> > > 
> > > Then maybe a way for the user to override the global templates is what we 
> > > need?  I can see that this would be useful outside of the crlf issue.
> > 
> > I do not think we need this.  autocrlf is a configurable variable and we 
> > already have a mechanism for the user to override configuration 
> > variables.  The user can use "git config --global ..." to sets his 
> > preferences.  This mechanism is well established.  I do not see a reason 
> > not to use it.
> 
> The point is: if we use /etc/gitconfig, we also touch _existing_ setups 
> (as Junio pointed out).  Which, in the case of autocrlf, is not desirable.

I proposed a mechanism that would avoid such problems in the future.
Repositories that would copy the current setting of autocrlf to their
local .git/config would be shielded from future changes to the global
setup.


> And if we go the route via templates, $HOME/.gitconfig will do no good, as 
> the configuration in the repository trumps the --global configuration.

We have two conflicting objectives and I do not know how to meet them
the same time:

 1) Existing setups should not break.

 2) Users should have a way to set a global default for autocrlf that
    overrides our defaults.

If we store the new default in newly created repositories, (1) would be
met but (2) is not possible.  If we support ~/.gitconfig for overriding
the system-wide default, (2) is trivial but (1) is hard to meet.

I propose to break existing setup and provide a simple mechanism to
avoid such breakages in the future.  As you pointed out earlier we are
still only releasing "previews" on Windows and one reason for this
decision was the lacking support for autocrlf.  We always knew that some
work would be needed before we have a sane setup on Windows.

Maybe we can improve the installer to warn the users that the default
has changed and existing repositories must either be converted or the
global default must be overridden.  The installer could ask the user to
confirm this change.  Maybe this is sufficient to avoid further
complains about weird behavior after upgrading.

            Steffen
