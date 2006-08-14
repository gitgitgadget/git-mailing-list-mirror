From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Multiple refs from the same remote in one git fetch
Date: Sun, 13 Aug 2006 22:53:38 -0700
Message-ID: <7vzme7g8wt.fsf@assigned-by-dhcp.cox.net>
References: <7vac68i2wv.fsf@assigned-by-dhcp.cox.net>
	<20060814051302.GB21963@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 07:53:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCVOV-0008Cn-Tf
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 07:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbWHNFxk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 01:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbWHNFxk
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 01:53:40 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:15585 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751570AbWHNFxj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 01:53:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060814055339.CIMB12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Aug 2006 01:53:39 -0400
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20060814051302.GB21963@mellanox.co.il> (Michael S. Tsirkin's
	message of "Mon, 14 Aug 2006 08:13:02 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25319>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

> BTW, does it still look like it's worth it the effort to lift the restriction,
> or does fixing the error message to something like
> "no such remote or duplicate ref %s"
> make more sense to you?

I have been hesitant to claim that it does not make any sense to
use more than one tracking branch for the same remote branch,
because the only reason I might say so is because I haven't
thought of a good usage pattern to do so.

But apparently you do use more than one local branch to keep
track of one remote branch.  How do you use it for?  Do you feel
it is a good feature to be able to do that, or do you think it
is just a mistake and more sensible error message is what we
would really want?
