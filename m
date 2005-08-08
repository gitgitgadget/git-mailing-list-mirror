From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Stash away the original head in ORIG_HEAD when resetting.
Date: Mon, 8 Aug 2005 11:13:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508081111020.26210@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <7vy87dgdxb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Mon Aug 08 11:14:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E23hL-0002wR-9j
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 11:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVHHJN2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 05:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVHHJN2
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 05:13:28 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:1741 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750786AbVHHJN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 05:13:27 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C8D5FE24D3; Mon,  8 Aug 2005 11:13:26 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A80B8AC80C; Mon,  8 Aug 2005 11:13:26 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8C3B5AC806; Mon,  8 Aug 2005 11:13:26 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1F9CAE24D3; Mon,  8 Aug 2005 11:13:26 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy87dgdxb.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, 7 Aug 2005, Junio C Hamano wrote:

>     $ git commit -m ORIG_HEAD

Since there are not many users of git-commit's *-m* flag right now: Is it 
necessary to confuse CVS people, who expect to be able to write

	git commit -m "I did this and that"

I do not want to be too intrusive, but I think up to now there is just the 
mailbox tools which use this feature, and users of git-reset. Thoughts?

Ciao,
Dscho
