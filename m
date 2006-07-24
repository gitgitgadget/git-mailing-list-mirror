From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: check pack.window for default window size
Date: Sun, 23 Jul 2006 23:43:48 -0700
Message-ID: <7vac6zfqor.fsf@assigned-by-dhcp.cox.net>
References: <20060723055030.GA25790@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 24 08:43:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4uAT-0007Ph-To
	for gcvg-git@gmane.org; Mon, 24 Jul 2006 08:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWGXGnv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Jul 2006 02:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWGXGnv
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 02:43:51 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:39646 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751420AbWGXGnu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jul 2006 02:43:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060724064350.SUVN6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Jul 2006 02:43:50 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060723055030.GA25790@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 23 Jul 2006 01:50:30 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24125>

Jeff King <peff@peff.net> writes:

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> For some repositories, deltas simply don't make sense. One can disable
> them for git-repack by adding --window, but git-push insists on making
> the deltas which can be very CPU-intensive for little benefit.

Makes sense.  Will apply but with the above three lines as part
of the commit message.
