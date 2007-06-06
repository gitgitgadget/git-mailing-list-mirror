From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: merging two repositories
Date: Wed, 6 Jun 2007 19:01:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706061859520.4046@racer.site>
References: <4666CB31.9070007@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: joel reed <joelwreed@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 20:03:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvzr0-0006Gp-Rs
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 20:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbXFFSDU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 14:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754698AbXFFSDU
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 14:03:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:58405 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751310AbXFFSDU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 14:03:20 -0400
Received: (qmail invoked by alias); 06 Jun 2007 18:03:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 06 Jun 2007 20:03:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xHP4yyOPxGDblSv+IhYQl9F4ydjpECoZWf+lHKX
	Ft7M97bL2LACB3
X-X-Sender: gene099@racer.site
In-Reply-To: <4666CB31.9070007@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49301>

Hi,

On Wed, 6 Jun 2007, joel reed wrote:

> So now I have two trees, one pure git using repo.or.cz, and the other 
> made by git-svn against Google' subversion.

I'd merge them by fetching the pure-git one into the git-svn'ed. Or vice 
versa. Then, you can say "git merge <other-branch>". If the revisions are 
similiar (or identical), it will succeed even if they do not have any 
common ancestor.

Ciao,
Dscho
