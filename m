From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix segfaults caused by invalid tags
Date: Wed, 2 Nov 2005 21:16:13 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511022115250.13746@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051102200751.26904.5780.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 21:16:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXP1z-0000tl-21
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 21:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965216AbVKBUQS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 15:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965218AbVKBUQR
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 15:16:17 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:1491 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965216AbVKBUQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2005 15:16:16 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A537B13F249; Wed,  2 Nov 2005 21:16:13 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 85FB4B4FCE; Wed,  2 Nov 2005 21:16:13 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 64A9C591CA; Wed,  2 Nov 2005 21:16:13 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0540F13F249; Wed,  2 Nov 2005 21:16:13 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051102200751.26904.5780.stgit@machine.or.cz>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11035>

Hi,

On Wed, 2 Nov 2005, Petr Baudis wrote:

> On many places, we didn't bother checking deref_tag() return value against
> NULL, causing GIT segfaulting e.g. on some old Cogito checkouts containing
> residual tags from GIT.

Shouldn't a warning be issued in every of those cases? I don't know, but 
those tags pointing nowhere don't seem useful to me.

Ciao,
Dscho
