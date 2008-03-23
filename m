From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Store autocrlf during init-db (was [msysGit] autocrlf
 problems with Git-preview20080301.exe)
Date: Sun, 23 Mar 2008 23:53:13 +0100 (CET)
Message-ID: <alpine.OSX.1.00.0803232237400.19285@cougar>
References: <f5d99ae7-e4b3-4632-ad86-8ebe0e683d49@d62g2000hsf.googlegroups.com> <alpine.LSU.1.00.0803101327390.3975@racer.site> <bdca99240803100611s3c8b3b9djb1b993c9fbad712@mail.gmail.com> <alpine.LSU.1.00.0803101448430.3975@racer.site> <cb8f4255-2bf8-4489-aeb0-c18d6e932342@s13g2000prd.googlegroups.com> <ab311292-809f-4e45-a19d-a600c2333ab6@a23g2000hsc.googlegroups.com> <alpine.OSX.1.00.0803221036230.7618@cougar> <7vzlsqfe2h.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803230310500.4353@racer.site> <alpine.OSX.1.00.0803230943500.7541@cougar> <alpine.LSU.1.00.0803231200010.4353@racer.site> <alpine.OSX.1.00.0803231326290.11994@cougar> <alpine.LSU.1.00.0803231404390.4353@racer.site> <alpine.OSX.1.00.0803231428220.13789@cougar> <alpine.LSU.1.00.0803231506000.4353@racer.site> <alpine.OSX.1
 .00.0803231643040.16879@cougar> <alpine.LSU.1.00.0803231734190.4353@racer.site>
Reply-To: prohaska@zib.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junio@pobox.com>, tormod.hystad@gmail.com, msysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Mar 23 23:53:15 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ag-out-0910.google.com ([72.14.246.191])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdZ3r-0000rx-Qw
	for gcvm-msysgit@m.gmane.org; Sun, 23 Mar 2008 23:53:08 +0100
Received: by ag-out-0910.google.com with SMTP id 32so2739492agc.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 23 Mar 2008 15:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=gamma;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=T+9wbHuuS5CeYc9tjvthCW00Ush9MwHUK9nZIeJyWXE=;
        b=58deveGlRMKySj9Ty2DjHfFxMORJzlz841k2pU5kQmeRZhvupJknVkKyxXqP/wgQRBvW/v4oQh6TCMNHc7tzH4CfLBJ3KrcQ0k6Js2ZS32R/so0kfP6ItrqaGzNepSuCUaH8WEn8qqlh+Ecz1lLLAI/xXURmMPl9o/bMv9jtElI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=gamma;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=CtKQxaL2ZPmunwBjDxx/m6SO+64yGvi1CueJjqhFNK0BNli6QzqQsQQBoDCi3aHTP+nLkmbsrQOW7snjUoua0fj2/i99D8Uej6n82mml3gykgvJKf4kSVygL5PV04vZmf9uoYsRWZqHzOTXxxfVzvvFC9pzSo6sQLe1ODy3Htqc=
Received: by 10.100.136.15 with SMTP id j15mr670480and.21.1206312747864;
        Sun, 23 Mar 2008 15:52:27 -0700 (PDT)
Received: by 10.44.74.68 with SMTP id w68gr2006hsa.0;
	Sun, 23 Mar 2008 15:52:27 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.35.14.4 with SMTP id r4mr6985512pyi.2.1206312746975; Sun, 23 Mar 2008 15:52:26 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id z53si8271926pyg.1.2008.03.23.15.52.26; Sun, 23 Mar 2008 15:52:26 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.14.2/8.14.2) with ESMTP id m2NMqNJU022848; Sun, 23 Mar 2008 23:52:23 +0100 (CET)
Received: from cougar (brln-4db9383b.pool.einsundeins.de [77.185.56.59]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m2NMqL2d020040 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Sun, 23 Mar 2008 23:52:22 +0100 (MET)
In-Reply-To: <alpine.LSU.1.00.0803231734190.4353@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77974>


On Sun, 23 Mar 2008, Johannes Schindelin wrote:

> On Sun, 23 Mar 2008, Steffen Prohaska wrote:
> 
> > On Sun, 23 Mar 2008, Johannes Schindelin wrote:
> > 
> > > On Sun, 23 Mar 2008, Steffen Prohaska wrote:
> > > 
> > > > On Sun, 23 Mar 2008, Johannes Schindelin wrote:
> > > > 
> > > > > The point is: if we use /etc/gitconfig, we also touch _existing_ 
> > > > > setups (as Junio pointed out).  Which, in the case of autocrlf, is 
> > > > > not desirable.
> > > > 
> > > > I proposed a mechanism that would avoid such problems in the future.
> > > 
> > > Yes, but your solution feels a bit limited and "hot-needled" for just 
> > > one purpose.
> > 
> > What limits do you mean (except that it does still break existing 
> > msysgit setups; but would avoid this problem in the future)?
> 
> I have the impression that a problem just like this will arise again, just 
> not with corelf, but with another setting that the admin might want to 
> set per default in git-init, but the user might want to override.

My patch does not set the default in git-init, but only stores the
current choice of autocrlf in the repository's config.  autocrlf is
special because it cannot be easily changed after the initial checkout.
Changing autocrlf might require converting the line endings of all files
in the work tree.  This is very different from most other configuration
variables, which can be changed without requiring any modifications to
the work tree.

In some sense you cannot change autocrlf at all after a repository is
initialized.  At least you need a deep understanding of the autocrlf
mechanism to avoid unexpected behavior.  Once you checked out files,
these files might 'preserve' the setting of autocrlf during the
checkout.  For example if you use autocrlf=true during checkout and
later change to autocrlf=false, git will detect all files as changed
because they contain CRLF in the workspace but LF in the repository.

The situation is even worse, because the choice of autocrlf is not
a purely local one, but depends on the project you are cloning.  A sane
policy is to have only LF line-endings in the repository and use native
line-endings in the work tree.  This can be guaranteed with
autocrlf=input on Unix and autocrlf=true on Windows.  Another possible
choice is to tell git to not modify any content at all, which
autocrlf=false would give you.  Personally, I do not think the latter is
a reasonable choice, but other might have a different opinion.  My point
is that it is the choice of the project: Either *all* repositories that
clone the project should set autocrlf=input|true or *all* repositories
should set autocrlf=false.  It is neither the choice of the local admin,
nor the local user, nor the default of git.  You need to have
project-specific knowledge to make the right choice.

I suspect that a lot of projects implicitly chose autocrlf=false because
of lacking autocrlf support in the past.  The default of git was to not
touch the content at all; and still this is the default on Unix.  Only
lately we tried to provide a more sensible default on Windows.

All projects that implicitly assume autocrlf=false might get into
trouble if we change the default, no matter which way we do this.  For
example we could use the templates to provide a new default.  The
existing repository's settings would not change.  But the next time the
user clones such a repository the clone would have the new settings and
this would cause trouble if the project contains files with mixed
line-endings.  The same happens if we directly modify git's default.
The only difference is that the trouble surfaces immediately because the
new default affects existing repositories.

A possible solution would be if a project (not a single repository)
could specify autocrlf and the choice was preserved across cloning.
I do not advocate this solution.  Such a mechanism is not available and
I personally do not know why it should be added.  As I pointed out above
I believe that autocrlf=input|true is the only sane way of handling
cross-platform projects and if git's binary auto-detection fails to
detect a file you should by all means add it to .gitattributes.  This is
the only way to guarantee that the file will be properly handled with
any autocrlf settings.

The solution I propose is to change the default now; tell the users
about the change; explain again and again why it is good to enforce LF
line-endings in the repository; and fix all repositories that contain
CRLF line-endings ASAP.

But even if all repositories contained only LF, the original problem
would remain.  The work tree depends on the choice of autocrlf during
checkout and cannot be easily modified later.  Not only the admin or the
maintainer of git can cause trouble by changing the default.  The user
himself can cause trouble by modifying the setup with "git config
--global".

This is where my proposed patch kicks in.  I propose to modify init-db
to store the choice of autocrlf in the repository to preserve it for
this repository, no matter who made this choice and no matter who
decides to change the setup later.  Only if the user deliberately
chooses to modify the local setting of the repository he might get into
trouble; but git always gives you this kind of freedom, no?

Yet the patch does not protect you from all trouble.  It only works well
in all cases if you have a repository that contains only LF.  If this is
the case you are free to choose autocrlf=input or autocrlf=true.  Both
will give you work trees without unexpected diffs right after checkout;
and both choices will guarantee that CRLFs will never enter the
repository.  Still you must not thoughtlessly change autocrlf without
fixing the line endings of the checked out files.

            Steffen
