From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Alternate object pool mechanism updates.
Date: Tue, 16 Aug 2005 14:47:25 -0700
Message-ID: <7vek8t8sgi.fsf@assigned-by-dhcp.cox.net>
References: <7vmznmp5ja.fsf@assigned-by-dhcp.cox.net>
	<20050813120815.GC5608@pasky.ji.cz>
	<7v1x4wcca0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508141726390.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 23:48:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E59I0-00022j-MM
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 23:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbVHPVr3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 17:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVHPVr2
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 17:47:28 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:3268 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932485AbVHPVr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 17:47:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050816214724.VNWN8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 Aug 2005 17:47:24 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508141726390.3553@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 14 Aug 2005 17:29:05 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> We've got a "git prune-packed", it would be good to have a "git
> prune-alternate" or something equivalent.

If you have GIT_ALTERNATE_DIRECTORIES environment variable, git
prune-packed will remove objects from your repository if it is
found in somebody else's pack.  I am not sure if this is the
behaviour we would want.
