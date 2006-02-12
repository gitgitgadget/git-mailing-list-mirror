From: Junio C Hamano <junkio@cox.net>
Subject: ***DONTUSE*** Re: [PATCH] Use a hashtable for objects instead of a sorted list
Date: Sun, 12 Feb 2006 04:08:25 -0800
Message-ID: <7vlkwgdbk6.fsf_-_@assigned-by-dhcp.cox.net>
References: <87slqpg11q.fsf@wine.dyndns.org>
	<Pine.LNX.4.63.0602120254260.10235@wbgn013.biozentrum.uni-wuerzburg.de>
	<7virrli9am.fsf@assigned-by-dhcp.cox.net>
	<87accwlt8k.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 13:08:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8G1m-0008CZ-ED
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 13:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWBLMI1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 07:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWBLMI1
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 07:08:27 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:35000 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932399AbWBLMI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 07:08:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060212120706.DTVO20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Feb 2006 07:07:06 -0500
To: Florian Weimer <fw@deneb.enyo.de>
In-Reply-To: <87accwlt8k.fsf@mid.deneb.enyo.de> (Florian Weimer's message of
	"Sun, 12 Feb 2006 12:19:23 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15993>

Florian Weimer <fw@deneb.enyo.de> writes:

> (GCC should do the rest.)
>...
> AFAICS, obj_allocs is a power of two.

Yes, I already have something like these in my tree (the latter
did not help much as far as I could tell, though).

****HOWEVER****

Do not use this (not just my patch but with the whole hashtable
version) in your production repository yet.

I've got a mysterious corruption and bogus output from
fsck-objects, and have been tracking it (see the timestamp of
this message).

1.2.0 will most likely to be be *delayed*.  I have to first make
sure my private repository is sane.  Grrrrrrrr.
