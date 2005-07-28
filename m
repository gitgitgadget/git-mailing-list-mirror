From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How is working on arbitrary remote heads supposed to work in
 Cogito (+ PATCH)?
Date: Thu, 28 Jul 2005 19:32:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507281931180.30371@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <200507271458.43063.Josef.Weidendorfer@gmx.de>
 <7vll3rlnqm.fsf@assigned-by-dhcp.cox.net> <200507271458.43063.Josef.Weidendorfer@gmx.de>
 <20050728120806.GA2391@pasky.ji.cz> <Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de>
 <20050728153506.GL14229@pasky.ji.cz> <Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de>
 <20050728161815.GC17952@pasky.ji.cz> <7v1x5ic1pe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 19:34:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyCGB-0003Y0-JY
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 19:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVG1RdF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 13:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVG1RdC
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 13:33:02 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:34256 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S261936AbVG1Rc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 13:32:56 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 88BA6E24CD; Thu, 28 Jul 2005 19:32:55 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6E22C913DD; Thu, 28 Jul 2005 19:32:55 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 58DB391396; Thu, 28 Jul 2005 19:32:55 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 31FB6E24CD; Thu, 28 Jul 2005 19:32:55 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x5ic1pe.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 28 Jul 2005, Junio C Hamano wrote:

> Petr Baudis <pasky@suse.cz> writes:
>
> > AFAIK the plan is to centralize all the kernel repositories to a single
> > one. For that, developers would generally push into branches with name
> > different that "master".
>
> I did not know about that plan, but that is interesting and now
> I understand why you think it is important to be able for more
> than one person to push into a single repository.

Is it possible that those plans only mean to centralize .git/objects/ and
leave the rest in single repositories? Seems much more sensible to me.

Ciao,
Dscho
