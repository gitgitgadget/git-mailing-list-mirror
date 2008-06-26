From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: how do I merge completely unrelated repositories ?
Date: Thu, 26 Jun 2008 12:25:54 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806261224020.9925@racer>
References: <46d6db660806260239xc57ffaag6469967ae2257cb1@mail.gmail.com> <20080626094522.GA29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian MICHON <christian.michon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 13:29:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBpem-0001fO-Qa
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 13:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498AbYFZL14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 07:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbYFZL14
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 07:27:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:42617 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753818AbYFZL1z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 07:27:55 -0400
Received: (qmail invoked by alias); 26 Jun 2008 11:27:54 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp062) with SMTP; 26 Jun 2008 13:27:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+kzgJ24UmkCnwVTxDCQGyh4YMbta+lVUkx2DTxkf
	Og2a5PU7ZMKXl2
X-X-Sender: gene099@racer
In-Reply-To: <20080626094522.GA29404@genesis.frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86434>

Hi,

On Thu, 26 Jun 2008, Miklos Vajna wrote:

> On Thu, Jun 26, 2008 at 11:39:37AM +0200, Christian MICHON <christian.michon@gmail.com> wrote:
> > How would you do it, since merge will not merge if it cannot find a
> > common ancestor ?
> 
> Did you try so?
> 
> If there are no conflicting paths then a simple
> 
> git pull /path/to/other/repo.git master
> 
> or similar should work.

FWIW this is how gitk got into git.git... See 5569bf9b(Do a cross-project 
merge of Paul Mackerras' gitk visualizer).  This also was often referred 
to as the "coolest merge ever".

Ciao,
Dscho
