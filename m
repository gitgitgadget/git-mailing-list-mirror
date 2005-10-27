From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [TENTATIVE PATCH] Complain loudly, dying, when a ref is invalid
Date: Thu, 27 Oct 2005 21:28:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510272125580.28705@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510271936520.7518@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vacgu3hta.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 27 21:30:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVDQC-0001Lk-TC
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 21:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbVJ0T2G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 15:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbVJ0T2G
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 15:28:06 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:1189 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751225AbVJ0T2F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 15:28:05 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id ECAFD13F273; Thu, 27 Oct 2005 21:28:03 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D53AE9EFC2; Thu, 27 Oct 2005 21:28:03 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BE9389EF9B; Thu, 27 Oct 2005 21:28:03 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 99A5513F273; Thu, 27 Oct 2005 21:28:03 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacgu3hta.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10725>

Hi,

On Thu, 27 Oct 2005, Junio C Hamano wrote:

> Not that the current loop is any better for that purpose.  We
> silently ignore not just dangling ref and ref not storing
> 40-byte hex, but files starting with a period '.',  names longer
> than 255 bytes, and unreadable ones, all of which we would
> probably want to warn about in such a tool.

Okay, how about 'fprintf(stderr, "Warning: ...\n"); continue;' instead of 
'die("...");' then?

Ciao,
Dscho
