From: Junio C Hamano <junkio@cox.net>
Subject: Re: recur status on linux-2.6
Date: Sun, 13 Aug 2006 09:58:28 -0700
Message-ID: <7v64gwmv2j.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608131550290.10541@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 13 18:58:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCJIH-0000Xz-Kk
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 18:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWHMQ6b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 12:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWHMQ6b
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 12:58:31 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:58611 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751317AbWHMQ6a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 12:58:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060813165829.LOEQ554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 13 Aug 2006 12:58:29 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608131550290.10541@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 13 Aug 2006 15:54:19 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25285>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I tested git-merge-recur vs. git-merge-recursive on the linux-2.6 
> repository last night. It contains 2298 two-head merges. _All_ of them 
> come out identically with -recur as compared to -recursive (looking at 
> the resulting index only).

Nice.

> That was the good news. The bad news is: it _seems_, that -recur is only 
> about 6x faster than -recursive, not 10x, and this number becomes smaller, 
> the longer the merge takes. So I see a startup effect here, probably.

Recreating the tip of "next" (10a6653) might be fun.  I do not
know why, but it ended up having 14 merge bases.  The speed-up
is about 6x, and the resulting half-merge is worse than
recursive (not using rerere cache).
