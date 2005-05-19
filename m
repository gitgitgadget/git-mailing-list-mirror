From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detect renames in diff family.
Date: Thu, 19 May 2005 13:36:05 -0700
Message-ID: <7vy8abx8ay.fsf@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
	<7v4qcz16n6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0505191426000.20274@localhost.localdomain>
	<7vsm0jyryf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0505191456040.20274@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 22:37:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYrjp-00089h-9g
	for gcvg-git@gmane.org; Thu, 19 May 2005 22:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVESUgL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 16:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVESUgL
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 16:36:11 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:27885 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261247AbVESUgH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 16:36:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050519203604.CZMV23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 May 2005 16:36:04 -0400
To: Nicolas Pitre <nico@cam.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "NP" == Nicolas Pitre <nico@cam.org> writes:

NP> Yes, but 0-9 is putting a bound on the accuracy.  What if someone wants 
NP> not more than 2% difference?

That statement is correct, but I think you are looking at it
from a developer perspective.

I suspect people would not want to pay the price of having
always to type many digits for the benefit of being able to
specify differences of 2% and 5%.  Would you also complain gzip
only lets you say -1 .. -9 and not -1.63 ;-)?

