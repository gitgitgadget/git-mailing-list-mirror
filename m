From: Junio C Hamano <junkio@cox.net>
Subject: Re: Multiple pulls from the same branch in .git/remotes/origin
Date: Mon, 07 Aug 2006 15:04:52 -0700
Message-ID: <7vzmegyzgb.fsf@assigned-by-dhcp.cox.net>
References: <7vu04o1fwm.fsf@assigned-by-dhcp.cox.net>
	<20060807210545.GC24206@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 08 00:05:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GADDU-0003UY-Uq
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 00:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWHGWEy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 18:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWHGWEx
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 18:04:53 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:41634 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751004AbWHGWEx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 18:04:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060807220452.XZHC12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 7 Aug 2006 18:04:52 -0400
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20060807210545.GC24206@mellanox.co.il> (Michael S. Tsirkin's
	message of "Tue, 8 Aug 2006 00:05:45 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25045>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

> It seems that have to make path_match in connect.c return an array
> of indexes for that to work. Right?

I do not recall why Linus placed that "*s = 0" in there.  That
is the one that makes the same ref not match more than once.

It _could_ be that the fix is just the matter of removing that
line, but it may have interesting consequences; I dunno offhand.
