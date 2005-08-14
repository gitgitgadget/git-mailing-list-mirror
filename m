From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Alternate object pool mechanism updates.
Date: Sun, 14 Aug 2005 16:46:31 -0700
Message-ID: <7v1x4wcca0.fsf@assigned-by-dhcp.cox.net>
References: <7vmznmp5ja.fsf@assigned-by-dhcp.cox.net>
	<20050813120815.GC5608@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 01:47:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4SBj-0000ix-Rn
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 01:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbVHNXqd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Aug 2005 19:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbVHNXqc
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Aug 2005 19:46:32 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:39082 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932355AbVHNXqc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2005 19:46:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050814234632.TYQV7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 14 Aug 2005 19:46:32 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> What about calling it rather info/alternates (or info/alternate)? It
> looks better, sounds better, is more namespace-ecological tab-completes
> fine and you don't type it that often anyway. :-)

Ok, so the one in the proposed updates branch says
info/alternates.

With this, your recent cg-clone -l can be made to still use
individual .git/object/??/ hierarchy to keep objects newly
created in each repository while sharing the inherited objects
from the parent repository, which would probably alleviate the
multi-user environment worries you express in the comments for
the option.  The git-clone-script in the proposed updates branch
has such a change.
