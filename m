From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-svnimport
Date: Thu, 25 Oct 2007 23:22:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710252322320.4362@racer.site>
References: <31e679430710250225w39a876d0w738d819245e514e@mail.gmail.com>
 <Pine.LNX.4.64.0710251132580.25221@racer.site>
 <31e679430710250408g679538e7ha9e1e75507c2aac5@mail.gmail.com>
 <Pine.LNX.4.64.0710251403160.25221@racer.site> <20071025222029.GA11677@dervierte>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Felipe Balbi <felipebalbi@users.sourceforge.net>,
	git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 00:23:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlB6z-00078M-Qb
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 00:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468AbXJYWXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 18:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753250AbXJYWXU
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 18:23:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:58593 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752835AbXJYWXU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 18:23:20 -0400
Received: (qmail invoked by alias); 25 Oct 2007 22:23:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 26 Oct 2007 00:23:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18NBxlv+BINIy4NH7448GszMSUEN2Vx7HV15l04a5
	/6aVSa7KXWY2fx
X-X-Sender: gene099@racer.site
In-Reply-To: <20071025222029.GA11677@dervierte>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62381>

Hi,

On Thu, 25 Oct 2007, Steven Walter wrote:

> On Thu, Oct 25, 2007 at 02:04:29PM +0100, Johannes Schindelin wrote:
> > FYI you'll have to do something like this:
> > 
> > 	git svn init svn://busybox.net/trunk/busybox
> > 	git svn fetch
> > 
> > to merge with current busybox (although I updated before I pushed).
> 
> More than that, you'll want to:
> 
>     git svn init <foo>
>     cp .git/refs/remotes/origin/master .git/refs/remotes/git-svn
>     git svn fetch
> 
> If git-svn doesn't find a remote named "git-svn" it will assume that it
> has no information about the repository and starting doing a full
> checkout.  By copying the ref, git-svn will see that there are already
> commits with git-svn-id lines and rebuild its "rev-db".  After that, it
> will incrementally update for newer revisions.
> 
> That ought to save you a few precious minutes :)

Good catch.  Thanks.

Ciao,
Dscho
