From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fixes for option parsing
Date: Sun, 16 Apr 2006 20:36:36 -0700
Message-ID: <7vu08soou3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604161433000.3701@g5.osdl.org>
	<7vbqv1oxie.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604161938070.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 17 05:36:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVKXk-0001Rv-Kq
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 05:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWDQDgk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 23:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWDQDgk
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 23:36:40 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:55757 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750983AbWDQDgk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Apr 2006 23:36:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060417033639.JHQQ20694.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 16 Apr 2006 23:36:39 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604161938070.3701@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 16 Apr 2006 19:42:30 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18816>

Linus Torvalds <torvalds@osdl.org> writes:

> Also, I think the "---" printing should be removed, and moved into the 
> "diffstat" flushing code.

I am not sure if that belongs to diffstat flush.  I was instead
planning to  move it to diff-flush code, and show it only when we
actually show any diffs.  IOW, I think we would want it even
when we are doing "--pretty -p", not "--pretty --patch-with-stat".
