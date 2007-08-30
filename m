From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Add --rebase option to git-pull?
Date: Thu, 30 Aug 2007 16:23:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708301622240.28586@racer.site>
References: <550f9510708300540u13c77201oe7cbe599c6773364@mail.gmail.com> 
 <Pine.LNX.4.64.0708301415150.28586@racer.site>
 <550f9510708300810y1ca84e8dt4d0bab8fc99deb3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tom Clarke <tom@u2i.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 17:23:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQlra-0001RJ-Rd
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 17:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757589AbXH3PXK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 11:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756827AbXH3PXJ
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 11:23:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:59213 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758014AbXH3PXI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 11:23:08 -0400
Received: (qmail invoked by alias); 30 Aug 2007 15:23:04 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp004) with SMTP; 30 Aug 2007 17:23:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Hw/cQl8CHU0zZC2uldPjHx6fgPPon2eEXvl6KS0
	Ta+sbXx4WW7+tf
X-X-Sender: gene099@racer.site
In-Reply-To: <550f9510708300810y1ca84e8dt4d0bab8fc99deb3c@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57046>

Hi,

On Thu, 30 Aug 2007, Tom Clarke wrote:

> On 8/30/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > In my TODO, there is "add the 'rebase' strategy".  It is definitely
> > something post-1.5.3, so I do not look into it.  But the most logical
> > place for me would be to have a strategy 'rebase'.  IOW a
> > git-merge-rebase.sh.
> 
> The following is my first naive attempt, is this the kind of thing you
> were thinking of?

Looks good to me except for:

> +git update-index --refresh 2>/dev/null

Maybe a test case would be in order, too...

Thanks,
Dscho
