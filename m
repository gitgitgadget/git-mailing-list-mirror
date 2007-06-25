From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: most commonly used git commands?
Date: Mon, 25 Jun 2007 08:51:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706250846200.4059@racer.site>
References: <20070625064017.GA2839@mellanox.co.il> <7vlke833wr.fsf@assigned-by-dhcp.pobox.com>
 <20070625071752.GB15343@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Mon Jun 25 09:51:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2jM3-00051k-0l
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 09:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbXFYHvW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 03:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbXFYHvV
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 03:51:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:43737 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750853AbXFYHvV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 03:51:21 -0400
Received: (qmail invoked by alias); 25 Jun 2007 07:51:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp009) with SMTP; 25 Jun 2007 09:51:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lzzgagonlN1m5DnmHcZoD4ykUFsIxW5aX62t56G
	/gJ1wlslCbAbcN
X-X-Sender: gene099@racer.site
In-Reply-To: <20070625071752.GB15343@mellanox.co.il>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50877>

Hi,

On Mon, 25 Jun 2007, Michael S. Tsirkin wrote:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
> > I think "add" deserves to be there, I am not sure "apply" is.
> 
> git add is supposed to be rare, no?

No.

> That's why git commit lists file additions/removals ...
> 
> My list is typically
> git checkout
> git commit
> git pull
> git push
> git rebase
> git reset
> git update-index

git update-index is really not user-friendly. That is why we have "git 
add". It is commonly used as a porcelain _instead of_ update-index.

FWIW your list is lacking log and diff, the two commands which are my top 
two. I do not use rebase all that often (before --interactive, that is). 
status, grep, mv, gc, show and branch are others I use quite often 
(although not as much as log and diff)

Ciao,
Dscho
