From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fetch-pack should not ask for a ref which is already
 there
Date: Fri, 30 Sep 2005 14:20:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509301418380.15604@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0509290149230.19126@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509291120170.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509292058020.8413@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0509292124190.8668@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0509291403050.5362@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 30 14:24:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELJtE-0004lE-7K
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 14:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbVI3MU7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 08:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030284AbVI3MU7
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 08:20:59 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:40334 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030274AbVI3MU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 08:20:58 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5123313E6DF; Fri, 30 Sep 2005 14:20:55 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 36C239DB62; Fri, 30 Sep 2005 14:20:55 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 23DF89DB60; Fri, 30 Sep 2005 14:20:55 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C544613E6DF; Fri, 30 Sep 2005 14:20:54 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0509291403050.5362@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9558>

Hi,

On Thu, 29 Sep 2005, Linus Torvalds wrote:

> On Thu, 29 Sep 2005, Johannes Schindelin wrote:
> > 
> > Wouldn't it make much more sense to add a flag which repairs an 
> > incomplete fetch?
> 
> No.
> 
> We've seen crap. We've _seen_ people use the old git-ssh-pull etc that 
> would result in incomplete repositories, and having people use the 
> "--recover" flag.
> 
> THAT KIND OF CRAP IS UNACCEPTABLE! I had to walk Andrew through a broken 
> repository because he had used those unreliable fetch methods. I was 
> ashamed of git at that point.
> 
> If a ^C results in a repository that needs to be fixed up, the "source 
> control management" is BROKEN. It's not source control, it's a buggy 
> mess.

Okay, fair enough, I had that coming. But how about the opposite? A flag, 
that says "I want to take the fast path, and if I fsck up, it is my fault 
alone", just like "-f" to git-checkout?

Ciao,
Dscho
