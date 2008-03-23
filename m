From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: Store autocrlf during init-db (was [msysGit]
 autocrlf problems with Git-preview20080301.exe)
Date: Sun, 23 Mar 2008 15:07:28 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803231506000.4353@racer.site>
References: <f5d99ae7-e4b3-4632-ad86-8ebe0e683d49@d62g2000hsf.googlegroups.com> <alpine.LSU.1.00.0803101327390.3975@racer.site> <bdca99240803100611s3c8b3b9djb1b993c9fbad712@mail.gmail.com> <alpine.LSU.1.00.0803101448430.3975@racer.site>
 <cb8f4255-2bf8-4489-aeb0-c18d6e932342@s13g2000prd.googlegroups.com> <ab311292-809f-4e45-a19d-a600c2333ab6@a23g2000hsc.googlegroups.com> <alpine.OSX.1.00.0803221036230.7618@cougar> <7vzlsqfe2h.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803230310500.4353@racer.site>
 <alpine.OSX.1.00.0803230943500.7541@cougar> <alpine.LSU.1.00.0803231200010.4353@racer.site> <alpine.OSX.1.00.0803231326290.11994@cougar> <alpine.LSU.1.00.0803231404390.4353@racer.site> <alpine.OSX.1.00.0803231428220.13789@cougar>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junio@pobox.com>, tormod.hystad@gmail.com,
	msysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Mar 23 15:08:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdQrq-0006Fr-DI
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 15:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758611AbYCWOH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 10:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756439AbYCWOH3
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 10:07:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:60434 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756027AbYCWOH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 10:07:29 -0400
Received: (qmail invoked by alias); 23 Mar 2008 14:07:27 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp004) with SMTP; 23 Mar 2008 15:07:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+SzUxpyrWSEZC5RlJcXtjYVwvcuY6EYW6rctAzaR
	7ltVkwBOeNlPAi
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.OSX.1.00.0803231428220.13789@cougar>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77901>

Hi,

On Sun, 23 Mar 2008, Steffen Prohaska wrote:

> On Sun, 23 Mar 2008, Johannes Schindelin wrote:
> 
> > The point is: if we use /etc/gitconfig, we also touch _existing_ 
> > setups (as Junio pointed out).  Which, in the case of autocrlf, is not 
> > desirable.
> 
> I proposed a mechanism that would avoid such problems in the future.

Yes, but your solution feels a bit limited and "hot-needled" for just one 
purpose.

> Maybe we can improve the installer to warn the users that the default 
> has changed and existing repositories must either be converted or the 
> global default must be overridden.  The installer could ask the user to 
> confirm this change.  Maybe this is sufficient to avoid further 
> complains about weird behavior after upgrading.

Maybe.  My experience is that people do not even read the big red warnings 
in the installer.  Whatever.

Ciao,
Dscho
