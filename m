From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add help.autocorrect to enable/disable autocorrecting
Date: Wed, 23 Jul 2008 17:44:49 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807231743030.8986@racer>
References: <alpine.DEB.1.00.0807222100150.8986@racer> <20080722203730.GC5113@blimp.local> <20080722210354.GD5113@blimp.local> <alpine.DEB.1.00.0807222207110.8986@racer> <20080722212633.GF5113@blimp.local> <alpine.DEB.1.00.0807222242160.8986@racer>
 <20080722222510.GA4474@blimp.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 18:45:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLhTH-00043O-7A
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 18:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbYGWQou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 12:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754044AbYGWQou
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 12:44:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:36702 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753720AbYGWQos (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 12:44:48 -0400
Received: (qmail invoked by alias); 23 Jul 2008 16:44:46 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp056) with SMTP; 23 Jul 2008 18:44:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/dHdVdY4/OOYUcr0uwugAtQYVpPbwKFOu7Ft4rH
	44aPXjtzBixhxv
X-X-Sender: gene099@racer
In-Reply-To: <20080722222510.GA4474@blimp.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89706>

Hi,

On Wed, 23 Jul 2008, Alex Riesen wrote:

> Johannes Schindelin, Tue, Jul 22, 2008 23:44:50 +0200:
> > However, I think that the intention of this patch is too much DWIMery, 
> > which might be good for me (just like my "git add remote" patch), but 
> > not for the general audience.
> 
> Mustn't be good for all

You meant "needn't"?  It is good for me ;-)

> And thanks for sharing.

You're welcome.

> +	n = 1;
> +	while (n < main_cmds.cnt &&
> +		best_similarity == similarity(main_cmds.names[n]->name))
> +		++n;

Mini-nit: you never ask for the value of n, only if it is 1 or larger.  So 
you do not need to count...

Ciao,
Dscho
