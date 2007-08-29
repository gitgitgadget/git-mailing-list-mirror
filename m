From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Mixing cherry-pick and merge
Date: Wed, 29 Aug 2007 14:22:32 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708291422020.28586@racer.site>
References: <46D56123.4030307@objectxp.com> <20070829131439.GA31212@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michel Marti <mma@objectxp.com>,
	Git Mailing List <git@vger.kernel.org>
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 15:22:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQNVH-0005jG-Ga
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 15:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757192AbXH2NWh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 09:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756896AbXH2NWg
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 09:22:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:54534 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757063AbXH2NWg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 09:22:36 -0400
Received: (qmail invoked by alias); 29 Aug 2007 13:22:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 29 Aug 2007 15:22:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18nZAwhQaEnsLQJh2lSndvibczSF05oesPRkA+PoH
	zPRpEA5IhY3Hz1
X-X-Sender: gene099@racer.site
In-Reply-To: <20070829131439.GA31212@diana.vm.bytemark.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56946>

Hi,

On Wed, 29 Aug 2007, Karl Hasselstr?m wrote:

> On 2007-08-29 14:05:55 +0200, Michel Marti wrote:
> 
> > I just merged from a branch from which I previously cherry-picked some 
> > commits and now the log contains the already cherry-picked commits 
> > twice (which is rather confusing). Is this a bug or a feature?
> 
> It's an inevitable consequence of git's design. When you cherry-pick a 
> commit, you create a (maybe slightly modified) copy of it with different 
> ancestry. If you then merge a branch that contains the original commit, 
> you will get both the original and the copy as ancestors of your new 
> merge commit.

I guess that people are not even aware that they can rebase with Git.  
Sounds like a perfect use case to me.

Ciao,
Dscho
