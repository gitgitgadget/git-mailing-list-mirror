From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How is working on arbitrary remote heads supposed to work in
 Cogito (+ PATCH)?
Date: Thu, 28 Jul 2005 20:51:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507282051290.30665@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <200507271458.43063.Josef.Weidendorfer@gmx.de>
 <7vll3rlnqm.fsf@assigned-by-dhcp.cox.net> <200507271458.43063.Josef.Weidendorfer@gmx.de>
 <20050728120806.GA2391@pasky.ji.cz> <Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de>
 <20050728153506.GL14229@pasky.ji.cz> <Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de>
 <20050728161815.GC17952@pasky.ji.cz> <7v1x5ic1pe.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507281931180.30371@wgmdd8.biozentrum.uni-wuerzburg.de>
 <20050728184525.GA3144@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 20:55:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyDWe-0008Kv-VA
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 20:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVG1Sxs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 14:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVG1SwQ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 14:52:16 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:32218 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S261529AbVG1Svw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 14:51:52 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8332DE2521; Thu, 28 Jul 2005 20:51:49 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 68C85913E1; Thu, 28 Jul 2005 20:51:49 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4D711913C0; Thu, 28 Jul 2005 20:51:49 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E68E9E25AB; Thu, 28 Jul 2005 20:51:48 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050728184525.GA3144@mythryan2.michonline.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 28 Jul 2005, Ryan Anderson wrote:

> On Thu, Jul 28, 2005 at 07:32:55PM +0200, Johannes Schindelin wrote:
> > Is it possible that those plans only mean to centralize .git/objects/ and
> > leave the rest in single repositories? Seems much more sensible to me.
>
> I think that's accurate.  It can be done without the repositories even
> really noticing if "git relink" is used aggressively to migrate
> hard links into the repository regularly.  (Though, "packs" cause some
> confusion in that scheme, I think.)

I guess that's where git-daemon comes into play.

Ciao,
Dscho
