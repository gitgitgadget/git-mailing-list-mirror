From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Add --rebase option to git-pull?
Date: Thu, 30 Aug 2007 14:16:34 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708301415150.28586@racer.site>
References: <550f9510708300540u13c77201oe7cbe599c6773364@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tom Clarke <tom@u2i.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 15:17:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQjt9-0005eX-1K
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 15:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756732AbXH3NQl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 09:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756038AbXH3NQk
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 09:16:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:51761 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756226AbXH3NQk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 09:16:40 -0400
Received: (qmail invoked by alias); 30 Aug 2007 13:16:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp037) with SMTP; 30 Aug 2007 15:16:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+VMf4qDdWVxUMrqXRlPN3FuniJtfaiH89azKzyQI
	w7RypT7bpZ+uPO
X-X-Sender: gene099@racer.site
In-Reply-To: <550f9510708300540u13c77201oe7cbe599c6773364@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57040>

Hi,

On Thu, 30 Aug 2007, Tom Clarke wrote:

> I'm in the process of setting up a git environment with a number of 
> shared branches. To avoid putting unnecessary merges into the trunk, 
> we'd like to normally use rebase when updating private branches. I 
> wondered if it would be possible to automatically determine the correct 
> remote branch to rebase against.
> 
> The most logical place to do this seemed to be in git-pull, so I 
> experimented with adding a '--rebase' option, per the (rough) diff 
> below.

In my TODO, there is "add the 'rebase' strategy".  It is definitely 
something post-1.5.3, so I do not look into it.  But the most logical 
place for me would be to have a strategy 'rebase'.  IOW a 
git-merge-rebase.sh.

Ciao,
Dscho
