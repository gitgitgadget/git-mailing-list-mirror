From: Junio C Hamano <junkio@cox.net>
Subject: Re: resolve (merge) problems
Date: Thu, 01 Dec 2005 17:58:21 -0800
Message-ID: <7vpsog9s5e.fsf@assigned-by-dhcp.cox.net>
References: <7vhd9sb9ie.fsf@assigned-by-dhcp.cox.net>
	<20051202015039.93047.qmail@web31811.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 02:59:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ei0By-0007gv-HX
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 02:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbVLBB6Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 20:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbVLBB6Y
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 20:58:24 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:22411 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964776AbVLBB6X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 20:58:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051202015749.FFTA15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Dec 2005 20:57:49 -0500
To: ltuikov@yahoo.com
In-Reply-To: <20051202015039.93047.qmail@web31811.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Thu, 1 Dec 2005 17:50:39 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13098>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Ok, if your patch below resolves the bug (please see my
> other email just posted) please submit it.  (I'm hitting
> this bug everytime there's a file deleted from the
> kernel tree and I try to merge.)

Sorry to hear that.  The patch I sent you is already pushed out
and mirrored the public machines.

The failure from '-s recursive' (lack of heapq) makes me suspect
that your Python installation is too old.  The 'resolve' method
you've been using should work fine for this case; otherwise
replace '-s recursive' in the message from Linus with '-s
resolve' for the 'git merge' commandline, like this:

	$ git merge -s resolve "merge linus' tree" HEAD master
