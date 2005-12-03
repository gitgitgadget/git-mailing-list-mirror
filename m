From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Include Makefile.localdef in Makefile, if it exists.
Date: Sat, 3 Dec 2005 03:23:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512030322410.19086@wbgn013.biozentrum.uni-wuerzburg.de>
References: <28417.1133565102@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 03:24:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiN3a-0003Vi-38
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 03:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVLCCXT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 21:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVLCCXT
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 21:23:19 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:57500 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751162AbVLCCXS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2005 21:23:18 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9375E13FAB4; Sat,  3 Dec 2005 03:23:17 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 78E649F50E; Sat,  3 Dec 2005 03:23:17 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 581B59F4EA; Sat,  3 Dec 2005 03:23:17 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 126AD13FAB4; Sat,  3 Dec 2005 03:23:17 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <28417.1133565102@lotus.CS.Berkeley.EDU>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13140>

Hi,

On Fri, 2 Dec 2005, Jason Riedy wrote:

> Makefile.localdef is just a hook for local definitions.  Users
> can track their definitions in a branch and not worry about
> merge conflicts.

I wonder why you do not just override them in config.mak, which was 
introduced just for that purpose...

Hth,
Dscho
