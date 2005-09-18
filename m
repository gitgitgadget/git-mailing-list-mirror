From: Junio C Hamano <junkio@cox.net>
Subject: Re: Newbie falls at first hurdle
Date: Sun, 18 Sep 2005 10:35:00 -0700
Message-ID: <7virwy46uz.fsf@assigned-by-dhcp.cox.net>
References: <200509171309.46893.alan@chandlerfamily.org.uk>
	<20050918145958.GB22391@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 19:36:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH34F-0004LS-UR
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 19:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbVIRRfE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 13:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVIRRfE
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 13:35:04 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:28316 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932132AbVIRRfC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 13:35:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050918173502.ZKMC4028.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Sep 2005 13:35:02 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050918145958.GB22391@pasky.or.cz> (Petr Baudis's message of
	"Sun, 18 Sep 2005 16:59:58 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8794>

Petr Baudis <pasky@suse.cz> writes:

> Two reports about this error message in one day, and I've seen more in
> the past. Heh. ;-) I'd submit a patch, but I'm still staying at the last
> git release because of the command renames.

That should not be a reason to stay at the last release; the old
command names should be supported as well in the current
"master" branch -- unless something is broken (missing backward
compatible old-name symlinks, for example), which I hope is not
the case.
