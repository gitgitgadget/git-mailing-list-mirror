From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Properly git-bisect reset after bisecting from non-master head
Date: Sun, 12 Feb 2006 12:35:29 -0800
Message-ID: <7vd5hs9uy6.fsf@assigned-by-dhcp.cox.net>
References: <20060212160614.GV31278@pasky.or.cz>
	<7vhd749xtl.fsf@assigned-by-dhcp.cox.net>
	<20060212194146.GX31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 21:36:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8Nwp-0000QG-HM
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 21:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWBLUfg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 15:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWBLUfg
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 15:35:36 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:56824 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750913AbWBLUff (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 15:35:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060212203249.KRDQ26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Feb 2006 15:32:49 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060212194146.GX31278@pasky.or.cz> (Petr Baudis's message of
	"Sun, 12 Feb 2006 20:41:46 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16018>

Petr Baudis <pasky@suse.cz> writes:

>> Hmph.  It seems that $GIT_DIR/head-name might want to be a
>> symbolic ref?
>
> That probably isn't a bad idea per se, but I can't think of anything
> which that would improve either, and this has the plus of being
> compatible with Cogito.

Ah, I missed that part, that "head-name" is being used by Cogito
and you used that format.
