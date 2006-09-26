From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] svnimport add support for parsing From lines for author
Date: Mon, 25 Sep 2006 22:08:11 -0700
Message-ID: <7v7izrtdtw.fsf@assigned-by-dhcp.cox.net>
References: <20060925110813.GA4419@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 07:08:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS5B2-0007Qo-Pw
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 07:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWIZFIN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 01:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWIZFIN
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 01:08:13 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:46279 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750978AbWIZFIM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 01:08:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060926050812.LVEN13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 Sep 2006 01:08:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id St891V00K1kojtg0000000
	Tue, 26 Sep 2006 01:08:09 -0400
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <20060925110813.GA4419@shadowen.org> (Andy Whitcroft's message of
	"Mon, 25 Sep 2006 12:08:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27772>

Andy Whitcroft <apw@shadowen.org> writes:

> svnimport: add support for parsing From: lines for author

Please do _not_ repeat the summary line in the message body.  It
is on the Subject: already.

> Now that we have support for parsing Signed-off-by: for author
> information it makes sense to handle From: as well.

I take that you are referring to Sasha's change in ae35b304; I
asked for actual svn users for ACK/NACK but I did not hear any.
Can I understand that you use svnimport for real projects and
are happy with Sasha's change? --- that would be an ack that
would help me sleep better ;-).

> adds a new -F which will handle From: lines in the comments.  It
> may be used in combination with -S.

This sort of makes sense but how common is this?

I also wonder instead of piling up custom flags if it is better
to let match-and-extract pattern be specified from the command
line.
