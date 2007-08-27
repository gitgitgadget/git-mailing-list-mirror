From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] [RED] git-init: Cannot setup bare repository
Date: Mon, 27 Aug 2007 11:55:23 +0200
Message-ID: <20070827095523.GQ1219@pasky.or.cz>
References: <20070826204531.11592.36481.stgit@rover> <Pine.LNX.4.64.0708270949590.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 27 11:55:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPbJi-00051b-Eq
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 11:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbXH0Jz0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 05:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753422AbXH0Jz0
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 05:55:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56907 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753349AbXH0JzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 05:55:25 -0400
Received: (qmail 19834 invoked by uid 2001); 27 Aug 2007 11:55:23 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708270949590.28586@racer.site>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56801>

  Hi,

On Mon, Aug 27, 2007 at 10:51:04AM CEST, Johannes Schindelin wrote:
> On Sun, 26 Aug 2007, Petr Baudis wrote:
> 
> > git-init is totally broken wrt. setting up bare repository - it thinks 
> > no repository is bare (maybe I could coerce it to think some 
> > repositories indeed are bare, but I have my doubts).
> 
> You were too busy playing Go, probably, so you missed my patch which tried 
> to fix this issue.  Alas, it broke more than it fixed, so it was just 
> worked around for git-clone --bare.

  AFAICS that patch is already applied as well; I tried to ask on IRC
for more fixes but seemed there is none and Junio almost threatened to
even release 1.5.3 with this bug. ;-) Well, I just needed something that
would fix this on repo.or.cz which totally broke after upgrade to new
Git version.

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
