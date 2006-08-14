From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Compression and dictionaries
Date: Mon, 14 Aug 2006 17:26:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608141724140.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910608132037t4297c3bbq9b0cd6ebaa03b979@mail.gmail.com> 
 <Pine.LNX.4.63.0608141415560.10541@wbgn013.biozentrum.uni-wuerzburg.de> 
 <9e4733910608140708i45e3d6day6b87676783fd6511@mail.gmail.com>
 <81b0412b0608140814h227517a0l5857389c84ef8ff8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 14 17:27:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCeLO-0003QB-G8
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 17:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWHNP0e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 11:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWHNP0e
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 11:26:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:10119 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750943AbWHNP0d (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Aug 2006 11:26:33 -0400
Received: (qmail invoked by alias); 14 Aug 2006 15:26:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 14 Aug 2006 17:26:31 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0608140814h227517a0l5857389c84ef8ff8@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25360>

Hi,

On Mon, 14 Aug 2006, Alex Riesen wrote:

> On 8/14/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> > Changing the probabilities probably won't help much, but there may be
> > good gains from partially eliminating 1M encoding maps.
> 
> will the old git installations, without the maps, still be able to decode the
> pack created this way?

Probably not. But then, I would _not_ want this in upload-pack, so it is a 
strictly local thing -- either you repacked with a dictionary yourself, or 
there would be no explicit dictionary.

However, as I said, I _think_ this discussion is moot. You'd probably be 
better off making the windows wider, activating stronger compression, 
basically investing more time for the repacker. Plus, this would benefit 
cloned repos as well.

Ciao,
Dscho
