From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use a hashtable for objects instead of a sorted list
Date: Sun, 12 Feb 2006 04:11:03 -0800
Message-ID: <7vaccwdbfs.fsf@assigned-by-dhcp.cox.net>
References: <87slqpg11q.fsf@wine.dyndns.org>
	<Pine.LNX.4.63.0602120254260.10235@wbgn013.biozentrum.uni-wuerzburg.de>
	<7virrli9am.fsf@assigned-by-dhcp.cox.net>
	<87oe1dez7k.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Feb 12 13:11:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8G4N-00007d-Df
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 13:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWBLMLH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 07:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWBLMLG
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 07:11:06 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:48098 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750713AbWBLMLF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 07:11:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060212120928.OMNY20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Feb 2006 07:09:28 -0500
To: Alexandre Julliard <julliard@winehq.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15994>

Alexandre Julliard <julliard@winehq.org> writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>> Alexandle, if you have a chance, could you try Johannes' patch
>> on your workload to see if it works OK for you?
>
> It works great for me, CPU time is down to 15 sec instead of 20 sec
> with my patch.

Thanks.  Now we have three independent numbers to back up that
Johannes is the winner....

Grrrrrrr.  Please, DO NOT USE THIS ONE YET.

At least, not with your production repository.

I am trying to nail it down but it appears at least fsck-objects
using this version gives bogus results.  I am first trying to
see if my primary working repository is sane.

Oh, and thanks again for your initial patch, which was what
started this drastic improvement.
