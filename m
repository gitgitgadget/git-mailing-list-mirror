From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How is working on arbitrary remote heads supposed to work in
 Cogito (+ PATCH)?
Date: Fri, 29 Jul 2005 12:57:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507291254100.5849@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <20050728153506.GL14229@pasky.ji.cz>
 <Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de>
 <20050728161815.GC17952@pasky.ji.cz> <7v1x5ic1pe.fsf@assigned-by-dhcp.cox.net>
 <20050728183904.GA24948@pasky.ji.cz> <7v4qaeqrh3.fsf@assigned-by-dhcp.cox.net>
 <20050729070628.GA24895@pasky.ji.cz> <7vmzo6jbme.fsf@assigned-by-dhcp.cox.net>
 <20050729081051.GH24895@pasky.ji.cz> <7vek9igfgw.fsf@assigned-by-dhcp.cox.net>
 <20050729094046.GO24895@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 13:01:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyScW-0001XO-SJ
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 13:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbVG2LA6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 07:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVG2K6l
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 06:58:41 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:21633 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S262596AbVG2K5u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 06:57:50 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3EEEAE2497; Fri, 29 Jul 2005 12:57:50 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1936DA8721; Fri, 29 Jul 2005 12:57:50 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id EE357A86F6; Fri, 29 Jul 2005 12:57:49 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CDC7DE2497; Fri, 29 Jul 2005 12:57:49 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050729094046.GO24895@pasky.ji.cz>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 29 Jul 2005, Petr Baudis wrote:

> You might get the push access rather lately in the process (this "lazy
> development privileges granting" is one of the point of distributed
> VCSes), at point where other people are used to pull from you and
> renaming your branch locally might mean some trouble.

I still do not get it. What is so wrong with

	git-switch-tree remotehead
	git-merge master
	git-push remoteside remotehead

which would have the further advantage of documenting what you really did
in the history.

And if you really want to be able to spread chaos in your own head, you
can do something like

	ln -s master .git/refs/heads/remotehead
	git-push remoteside remotehead

A change in the protocol is not needed IMHO, and the protocol itself
suggests that you rather use a simple setup. After all, Murphy is lurking
behind every bash script!

Ciao,
Dscho
