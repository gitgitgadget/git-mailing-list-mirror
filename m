From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] add --remote option to git-clone.
Date: Fri, 2 Feb 2007 00:53:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702020050190.18870@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702020028540.18776@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070201234706.GP17617@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Fri Feb 02 00:53:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCljz-0003gI-1b
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 00:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933149AbXBAXxQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 18:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933203AbXBAXxQ
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 18:53:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:53822 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933149AbXBAXxP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 18:53:15 -0500
Received: (qmail invoked by alias); 01 Feb 2007 23:53:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp051) with SMTP; 02 Feb 2007 00:53:14 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070201234706.GP17617@mellanox.co.il>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38438>

Hi,

On Fri, 2 Feb 2007, Michael S. Tsirkin wrote:

> > Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> > Subject: Re: [PATCH] add --remote option to git-clone.
> > 
> > Of course, you'd have to 
> > support this, too:
> > 
> > 	$ git clone --branch topic1 --branch topic2 git://...
> 
> Why is this useful?

For the same reasons it might be useful to track _all_ branches.

> and which branch to check out?

I'd say the first, but that's just my opinion.

> One can always get more branches later, is my approach.

Yes. But in the same vein, one can add _one_ branch to an empty repo 
either. So, with your reasoning, your patch wouldn't be needed to begin 
with.

But I find it useful. Even the version where you are not limited to one 
branch.

Ciao,
Dscho
