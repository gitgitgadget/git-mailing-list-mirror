From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fetch-pack should not ask for a ref which is already
 there
Date: Thu, 29 Sep 2005 21:28:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509292124190.8668@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0509290149230.19126@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509291120170.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509292058020.8413@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 29 21:30:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL45S-0002h3-0N
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 21:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbVI2T2z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 15:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbVI2T2z
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 15:28:55 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:61655 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932418AbVI2T2y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 15:28:54 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2EF8813E650; Thu, 29 Sep 2005 21:28:53 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1424D9DB34; Thu, 29 Sep 2005 21:28:53 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E87E59DB32; Thu, 29 Sep 2005 21:28:52 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CB10613E650; Thu, 29 Sep 2005 21:28:52 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0509292058020.8413@wgmdd8.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9498>

Hi,

On Thu, 29 Sep 2005, Johannes Schindelin wrote:

> Hi,
> 
> On Thu, 29 Sep 2005, Linus Torvalds wrote:
> 
> > On Thu, 29 Sep 2005, Johannes Schindelin wrote:
> > >
> > > With this patch, instead of blindly asking for every remote ref, 
> > > fetch-pack first looks in the local repository if that ref is 
> > > already there.
> > 
> > No. This is WRONG.

Following up on the "I'd rather download twice than have a corrupt 
repository":

Wouldn't it make much more sense to add a flag which repairs an incomplete 
fetch? After all, not every day you fsck up a fetch, right? So, be nice to 
the server, the network and all the rest, in most cases, and be not so 
nice if you know something went wrong and you want to fix it.

Ciao,
Dscho
