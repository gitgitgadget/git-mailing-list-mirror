From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-send-pack: broken handling of ref specs with wildcards
Date: Thu, 7 Jun 2007 23:56:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706072356220.4046@racer.site>
References: <20070607225302.GA10633@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 00:59:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwQwm-0001tw-6Y
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 00:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966283AbXFGW7K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 18:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966255AbXFGW7J
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 18:59:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:41270 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S966165AbXFGW7I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 18:59:08 -0400
Received: (qmail invoked by alias); 07 Jun 2007 22:59:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 08 Jun 2007 00:59:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/W0vZYYfTWalA35830OrnH/iXUqVlQdcueXXYMx7
	3n9oOBQUMDRkrF
X-X-Sender: gene099@racer.site
In-Reply-To: <20070607225302.GA10633@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49404>

Hi,

On Fri, 8 Jun 2007, Alex Riesen wrote:

> Try something like this:
> 
>     git-send-pack --remote=origin --thin /some/other/repo \
>     'refs/heads/*:refs/remotes/child/*'
> 
> The result looks broken: the sent reference are created not in
> refs/remotes/child/ but just in refs/heads/ of /some/other/repo.

I had the impression that it was git-push, a porcelain, which handles 
refspec wildcards, not send-pack, which is plumbing.

Ciao,
Dscho
