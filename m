From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How is working on arbitrary remote heads supposed to work in
 Cogito (+ PATCH)?
Date: Fri, 29 Jul 2005 14:26:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507291424070.6247@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <20050728161815.GC17952@pasky.ji.cz> <7v1x5ic1pe.fsf@assigned-by-dhcp.cox.net>
 <20050728183904.GA24948@pasky.ji.cz> <7v4qaeqrh3.fsf@assigned-by-dhcp.cox.net>
 <20050729070628.GA24895@pasky.ji.cz> <7vmzo6jbme.fsf@assigned-by-dhcp.cox.net>
 <20050729081051.GH24895@pasky.ji.cz> <7vek9igfgw.fsf@assigned-by-dhcp.cox.net>
 <20050729094046.GO24895@pasky.ji.cz> <Pine.LNX.4.58.0507291254100.5849@wgmdd8.biozentrum.uni-wuerzburg.de>
 <20050729111304.GS24895@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 14:27:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyTx9-0002Ne-Eh
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 14:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbVG2M0x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 08:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbVG2M0x
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 08:26:53 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:39828 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S262568AbVG2M0w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 08:26:52 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6CA70E25C5; Fri, 29 Jul 2005 14:26:51 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4CEDDA8732; Fri, 29 Jul 2005 14:26:51 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2DBB5A871A; Fri, 29 Jul 2005 14:26:51 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0DE19E25C5; Fri, 29 Jul 2005 14:26:51 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050729111304.GS24895@pasky.ji.cz>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 29 Jul 2005, Petr Baudis wrote:

> Dear diary, on Fri, Jul 29, 2005 at 12:57:50PM CEST, I got a letter
> where Johannes Schindelin <Johannes.Schindelin@gmx.de> told me that...
>
> > 	git-switch-tree remotehead
> > 	git-merge master
> > 	git-push remoteside remotehead
> >
> > which would have the further advantage of documenting what you really did
> > in the history.
>
> How would that document anything normal push wouldn't?

git-merge?

> > And if you really want to be able to spread chaos in your own head, you
> > can do something like
> >
> > 	ln -s master .git/refs/heads/remotehead
> > 	git-push remoteside remotehead
>
> I'd argue that's much more messy and evil than pushing to heads with
> different names. If you compare what you just proposed with pushing to
> heads with different names, what's the advantage?

It makes it hard. It tells you to be real careful here. It tells you that
you are not babysitted from here on.

Ciao,
Dscho
