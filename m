From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to clone-pack the HEAD?
Date: Wed, 14 Dec 2005 17:53:06 -0800
Message-ID: <7vlkynrurh.fsf@assigned-by-dhcp.cox.net>
References: <20051215004440.GM22159@pasky.or.cz>
	<7vfyovtaub.fsf@assigned-by-dhcp.cox.net>
	<20051215013201.GD10680@pasky.or.cz>
	<7vpsnzrv43.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Dec 15 02:54:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmiJA-0001Xw-6o
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 02:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVLOBxJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 20:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbVLOBxJ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 20:53:09 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:29149 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750786AbVLOBxH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 20:53:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051215015220.UWDJ20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Dec 2005 20:52:20 -0500
To: git@vger.kernel.org
In-Reply-To: <7vpsnzrv43.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 14 Dec 2005 17:45:32 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13673>

Junio C Hamano <junkio@cox.net> writes:

> Petr Baudis <pasky@suse.cz> writes:
>
>> Except that I cannot do the guessing git-clone-pack does (without
>> fetching all the branches)
>
> Exactly my point.  If you are not getting all the branches, you
> are not cloning but doing something else.

Not really.  I take this back.  What you want to do I did not
understand well enough.

HEAD is kinda special.  A hack I can think of is to do ls-remote
first and do the guess clone-pack does for full clone case, and
then give a specific branch name to clone.  That might work.
