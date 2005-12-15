From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to clone-pack the HEAD?
Date: Wed, 14 Dec 2005 17:45:32 -0800
Message-ID: <7vpsnzrv43.fsf@assigned-by-dhcp.cox.net>
References: <20051215004440.GM22159@pasky.or.cz>
	<7vfyovtaub.fsf@assigned-by-dhcp.cox.net>
	<20051215013201.GD10680@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 02:46:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmiBc-0007t9-Vx
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 02:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbVLOBpe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 20:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbVLOBpe
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 20:45:34 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:12497 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030289AbVLOBpe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 20:45:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051215014402.ZVOK26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Dec 2005 20:44:02 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051215013201.GD10680@pasky.or.cz> (Petr Baudis's message of
	"Thu, 15 Dec 2005 02:32:01 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13672>

Petr Baudis <pasky@suse.cz> writes:

> Except that I cannot do the guessing git-clone-pack does (without
> fetching all the branches)

Exactly my point.  If you are not getting all the branches, you
are not cloning but doing something else.

Extending git-fetch-pack would be the right approach if that is
what you are trying to do.
