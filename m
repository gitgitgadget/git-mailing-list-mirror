From: Junio C Hamano <junkio@cox.net>
Subject: Re: blame now knows -S
Date: Sat, 08 Apr 2006 13:39:04 -0700
Message-ID: <7vwtdzer9z.fsf@assigned-by-dhcp.cox.net>
References: <7v1ww9loon.fsf@assigned-by-dhcp.cox.net>
	<20060408114240.GA10137@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@catalyst.net.nz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 08 22:39:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSKDB-0001Km-Gh
	for gcvg-git@gmane.org; Sat, 08 Apr 2006 22:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWDHUjJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 16:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWDHUjJ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 16:39:09 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:48051 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751417AbWDHUjI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Apr 2006 16:39:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060408203906.NTIF15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 8 Apr 2006 16:39:06 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060408114240.GA10137@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Sat, 8 Apr 2006 13:42:40 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18527>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> There is another possible optimisation with respect to xdiff. Instead
> of producing the diff on the xdiff side and parsing the diff in
> blame.c, we could add another call back which just gets the relevant
> information from the hunk header. I don't know how much we would gain
> from this, but it might be worth a try.

I've tried and then it turned out it did not make much of a
difference.
