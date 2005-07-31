From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Added hook in git-receive-pack
Date: Mon, 1 Aug 2005 01:31:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0508010130490.8410@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <200507312117.43957.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.58.0507311305170.29650@g5.osdl.org> <7vr7ded8ax.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507311549300.14342@g5.osdl.org> <7viryqd0eo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 01:39:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzNPD-0005tg-5S
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 01:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVGaXgY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 19:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVGaXdf
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 19:33:35 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:4492 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S262066AbVGaXbo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2005 19:31:44 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DF4FCE1B1A; Mon,  1 Aug 2005 01:31:43 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BFA03AC974; Mon,  1 Aug 2005 01:31:43 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A3B7EA8700; Mon,  1 Aug 2005 01:31:43 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 403F0E1B1A; Mon,  1 Aug 2005 01:31:43 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7viryqd0eo.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, 31 Jul 2005, Junio C Hamano wrote:

> Let's yank out the update_server_info() call when Josef's patch
> can handle a single hook call at the end of the run, in addition
> to one call per each ref getting updated.

How about executing update_server_info() if no hook was found? That way,
it can be turned off by an empty hook, but is enabled in standard
settings.

Ciao,
Dscho
