From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/3] Support setting SymrefsOnly=true from scripts
Date: Thu, 17 Nov 2005 11:29:58 -0800
Message-ID: <7vpsozt6mh.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511152233430.2152@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfypxh5mn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511160127130.4334@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xvpe6vi.fsf@assigned-by-dhcp.cox.net>
	<20051117120909.GA30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 20:32:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcpSe-0006Om-Qh
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 20:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbVKQTaA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 14:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbVKQTaA
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 14:30:00 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:57244 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964796AbVKQT37 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 14:29:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051117192921.CQHP20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Nov 2005 14:29:21 -0500
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12141>

Petr Baudis <pasky@suse.cz> writes:

> The disadvantage is that I will have to maintain my own template for
> Cogito, which is silly - I would much rather just use GIT's default
> templates and only add the symrefonly option on behalf of Cogito.

That's very true.  However I suspect Cogito users are expected
to run cg-admin-init not git-init-db, so admin-init can do
whatever postprocessing necessary after calling init-db?  That
way would let you do more than what template would, I presume.
