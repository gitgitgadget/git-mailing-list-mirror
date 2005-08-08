From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Stash away the original head in ORIG_HEAD when resetting.
Date: Mon, 8 Aug 2005 11:22:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508081122030.31438@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <7vy87dgdxb.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508081111020.26210@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Mon Aug 08 11:25:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E23qB-0004EZ-2B
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 11:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVHHJW3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 05:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVHHJW3
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 05:22:29 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:54736 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750767AbVHHJW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 05:22:28 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 72DC7E2DB9; Mon,  8 Aug 2005 11:22:27 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 538519C7D5; Mon,  8 Aug 2005 11:22:27 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3A311990D0; Mon,  8 Aug 2005 11:22:27 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2917EE2DB9; Mon,  8 Aug 2005 11:22:27 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0508081111020.26210@wgmdd8.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 8 Aug 2005, Johannes Schindelin wrote:

> Hi,
> 
> On Sun, 7 Aug 2005, Junio C Hamano wrote:
> 
> >     $ git commit -m ORIG_HEAD
> 
> Since there are not many users of git-commit's *-m* flag right now: Is it 
> necessary to confuse CVS people, who expect to be able to write
> 
> 	git commit -m "I did this and that"
> 
> I do not want to be too intrusive, but I think up to now there is just the 
> mailbox tools which use this feature, and users of git-reset. Thoughts?

Sorry, forgot -rebase and -cherry.

Ciao,
Dscho
