From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 33/40] When installing, be prepared that template_dir
 may be relative.
Date: Fri, 29 Feb 2008 01:21:17 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802290119340.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-34-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281542000.22527@racer.site> <200802282212.02683.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Feb 29 02:22:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUtxN-0003Lt-TT
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 02:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169AbYB2BV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 20:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbYB2BV7
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 20:21:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:38400 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751112AbYB2BV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 20:21:58 -0500
Received: (qmail invoked by alias); 29 Feb 2008 01:21:55 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp040) with SMTP; 29 Feb 2008 02:21:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18OS4ZQ7jUOT7aM9jBB3Bg1Yu25F+vUj0KIAP6MOp
	9lEldwSwRl1oWi
X-X-Sender: gene099@racer.site
In-Reply-To: <200802282212.02683.johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75484>

Hi,

On Thu, 28 Feb 2008, Johannes Sixt wrote:

> On Thursday 28 February 2008 16:45, Johannes Schindelin wrote:
>
> > On Wed, 27 Feb 2008, Johannes Sixt wrote:
> > > @@ -1094,6 +1094,13 @@ remove-dashes:
> > >
> > >  ### Installation rules
> > >
> > > +ifeq ($(firstword $(subst /, ,$(template_dir))),..)
> >
> > How portable is "firstword"?  Would it not be better to use
> 
> How portable is "patsubst"? ;)
> 
> > ifneq ($(patsubst ../%,,$(template_dir)),)
> 
> This programming language is sort of write-only, so I don't know because 
> I can't read it ;) If you have tested your version and it works and you 
> have thought through all consequences (like how does it work if 
> template_dir=/a/../b), why not?

I did not think through all consequences, but hoped that some knowledgable 
person could tell me that/if I am wrong in my assumption that patsubst is 
older than firstword.

Since I encountered "firstword" for the very first time today, I thought 
it might be younger than "patsubst", which I met plenty a times.

Ciao,
Dscho

