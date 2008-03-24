From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: Store autocrlf during init-db (was [msysGit]
 autocrlf problems with Git-preview20080301.exe)
Date: Mon, 24 Mar 2008 01:01:54 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803240101220.4353@racer.site>
References: <cb8f4255-2bf8-4489-aeb0-c18d6e932342@s13g2000prd.googlegroups.com> <ab311292-809f-4e45-a19d-a600c2333ab6@a23g2000hsc.googlegroups.com> <alpine.OSX.1.00.0803221036230.7618@cougar> <7vzlsqfe2h.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803230310500.4353@racer.site> <alpine.OSX.1.00.0803230943500.7541@cougar> <alpine.LSU.1.00.0803231200010.4353@racer.site> <alpine.OSX.1.00.0803231326290.11994@cougar> <alpine.LSU.1.00.0803231404390.4353@racer.site> <alpine.OSX.1.00.0803231428220.13789@cougar>
 <20080323235610.GB25381@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <junio@pobox.com>, tormod.hystad@gmail.com,
	msysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 01:02:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jda9P-0002FU-4H
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 01:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757363AbYCXACN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 20:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757332AbYCXACN
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 20:02:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:56228 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757292AbYCXACM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 20:02:12 -0400
Received: (qmail invoked by alias); 24 Mar 2008 00:02:09 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp022) with SMTP; 24 Mar 2008 01:02:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18rJz0RFDorh8QqC93PUdCr8C3CNC6rAG+fbgzbRA
	JAx7Q+7CxwD9uI
X-X-Sender: gene099@racer.site
In-Reply-To: <20080323235610.GB25381@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77978>

Hi,

On Mon, 24 Mar 2008, Dmitry Potapov wrote:

> We already have templates for different hooks, info/exclude, etc. So, 
> instead of placing autocrlf in /etc/gitconfig, you should place this 
> variable to /usr/share/git/templates/config and this file should be 
> copied by git init or git clone as any other file in templates.

I thought we discussed that already?  And the consensus was that this does 
not allow for per-user overriding.

Ciao,
Dscho
