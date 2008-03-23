From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: Store autocrlf during init-db (was [msysGit]
 autocrlf problems with Git-preview20080301.exe)
Date: Mon, 24 Mar 2008 00:39:27 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803240038180.4353@racer.site>
References: <f5d99ae7-e4b3-4632-ad86-8ebe0e683d49@d62g2000hsf.googlegroups.com> <alpine.LSU.1.00.0803101327390.3975@racer.site> <bdca99240803100611s3c8b3b9djb1b993c9fbad712@mail.gmail.com> <alpine.LSU.1.00.0803101448430.3975@racer.site>
 <cb8f4255-2bf8-4489-aeb0-c18d6e932342@s13g2000prd.googlegroups.com> <ab311292-809f-4e45-a19d-a600c2333ab6@a23g2000hsc.googlegroups.com> <alpine.OSX.1.00.0803221036230.7618@cougar> <7vzlsqfe2h.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803230310500.4353@racer.site>
 <alpine.OSX.1.00.0803230943500.7541@cougar> <alpine.LSU.1.00.0803231200010.4353@racer.site> <alpine.OSX.1.00.0803231326290.11994@cougar> <alpine.LSU.1.00.0803231404390.4353@racer.site> <alpine.OSX.1.00.0803231428220.13789@cougar> <alpine.LSU.1.00.0803231506000.4353@racer.site>
 <alpine.OSX.1.00.0803231643040.16879@cougar> <alpine.LSU.1.00.0803231734190.4353@racer.site> <alpine.OSX.1.00.0803232237400.19285@cougar>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junio@pobox.com>, tormod.hystad@gmail.com,
	msysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 00:40:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdZnT-00052j-PN
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 00:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756909AbYCWXj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 19:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756864AbYCWXj1
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 19:39:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:52915 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756771AbYCWXj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 19:39:27 -0400
Received: (qmail invoked by alias); 23 Mar 2008 23:39:25 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp022) with SMTP; 24 Mar 2008 00:39:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX185rZNHsMU56aDqZlyINQ39RivPAi666qME+Qh7Hf
	0oPlOAeaRtbeKK
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.OSX.1.00.0803232237400.19285@cougar>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77976>

Hi,

On Sun, 23 Mar 2008, Steffen Prohaska wrote:

> On Sun, 23 Mar 2008, Johannes Schindelin wrote:
> 
> > I have the impression that a problem just like this will arise again, 
> > just not with corelf, but with another setting that the admin might 
> > want to set per default in git-init, but the user might want to 
> > override.
> 
> My patch does not set the default in git-init, but only stores the
> current choice of autocrlf in the repository's config.  autocrlf is
> special because it cannot be easily changed after the initial checkout.

But basically all clean/smudge filters have exactly the same problem!  And 
core.ignorecase, too!

There must be a way to do it elegantly, without catering just for 
autocrlf.

Ciao,
Dscho
