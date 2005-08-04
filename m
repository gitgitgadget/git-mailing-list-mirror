From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use the template mechanism to set up refs/ hierarchy as
 well.
Date: Thu, 4 Aug 2005 23:13:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508042311370.24861@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <7v3bprjzzg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508042038200.23886@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vll3hxykj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508042215430.24657@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7v7jf1xw90.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 23:17:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0n5j-0006nR-0M
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 23:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbVHDVOc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 17:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbVHDVOY
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 17:14:24 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:48870 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S262689AbVHDVNs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 17:13:48 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C8B62E23DA; Thu,  4 Aug 2005 23:13:47 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AF49D9C6EC; Thu,  4 Aug 2005 23:13:47 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 99CDE93E22; Thu,  4 Aug 2005 23:13:47 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 862E6E23DA; Thu,  4 Aug 2005 23:13:47 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jf1xw90.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 4 Aug 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> I'd like to not being forced to install git. Scenario: I have an SSH
>> account on a remote machine. I am not root there, but I'd like to
>> synchronize my work with git. I can not install git.
>
> Sorry, but now you completely lost me.  You want git, you are
> not root, you cannot install git system wide, so you run git
> installed in your $HOME/bin somewhere instead.  I think I am
> following you correctly up to this point.
>
> But if that is the case, I do not see where your objections to
> the template directory installed somewhere under $HOME/etc comes
> from, which is what the default Makefile does, or at least
> attempts to.

Sorry, I am so used to not installing in my home because of small quotas 
:-(

Anyway, my usual setup is that I check git out from my private branch, add 
that directory to my path, and every once in a while do a "git pull origin 
&& make test". Right now, it works.

Ciao,
Dscho
