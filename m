From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Working copy revision and push pain
Date: Mon, 24 Mar 2008 16:22:28 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803241621210.4353@racer.site>
References: <47E64F71.3020204@jwatt.org> <47E668E1.80804@jwatt.org> <alpine.LSU.1.00.0803231534050.4353@racer.site> <200803231720.44320.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jonathan Watt <jwatt@jwatt.org>,
	Elijah Newren <newren@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Mar 24 16:23:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdoVw-0000C4-Dv
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 16:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759609AbYCXPW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 11:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759689AbYCXPW0
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 11:22:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:46365 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759014AbYCXPW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 11:22:26 -0400
Received: (qmail invoked by alias); 24 Mar 2008 15:22:24 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 24 Mar 2008 16:22:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+bfgA4zzyb9mY6H5aSUciJM0mheJY4DZ5ivBPDi+
	ymiNTqMCCZFr7d
X-X-Sender: gene099@racer.site
In-Reply-To: <200803231720.44320.johan@herland.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78053>

Hi,

On Sun, 23 Mar 2008, Johan Herland wrote:

> I'm starting to think it's worth changing the default behaviour of push 
> as follows:
> 
> Upon receiving a push into a non-bare repository, if the working copy is 
> on the same branch as is being pushed, then refuse the push with a 
> helpful message describing why the push was refused, and how to resolve 
> this issue (i.e. referring to the tutorials you mention).
> 
> This would:
> - Not clobber the working copy
> - Tell newbies what happened and why
> - Hopefully make this issue pop up less frequently
> - Not affect you if you only push into bare repos
> - Not affect you if you take care to never push into a checked-out 
>   branch
> 
> Of course, you should be able to set a config option to get the old 
> behaviour, and from there you can write hooks to either update the 
> working copy, or detach HEAD, or whatever you please.

I think I sent out a sensible patch, which does not change the behaviour 
in existing repositories.  This should be safer (read: nicer) for 
Git old-timers.

Ciao,
Dscho
