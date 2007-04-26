From: Junio C Hamano <junkio@cox.net>
Subject: Re: suggested feature: completely expunge a file (or just a delta) a la rebase
Date: Wed, 25 Apr 2007 22:57:54 -0700
Message-ID: <7virbju17h.fsf@assigned-by-dhcp.cox.net>
References: <3c6c07c20704252248q3cd82d4cgcffb9852fa261a70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Mike Coleman" <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 07:59:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgx0O-0002BC-5k
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 07:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbXDZF55 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 01:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754752AbXDZF55
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 01:57:57 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39961 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750AbXDZF5z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 01:57:55 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070426055755.WCPE1218.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 26 Apr 2007 01:57:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id rhxu1W00e1kojtg0000000; Thu, 26 Apr 2007 01:57:55 -0400
In-Reply-To: <3c6c07c20704252248q3cd82d4cgcffb9852fa261a70@mail.gmail.com>
	(Mike Coleman's message of "Thu, 26 Apr 2007 00:48:28 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45613>

"Mike Coleman" <tutufan@gmail.com> writes:

> Here's an idea for a git feature.  (Or perhaps this is already
> possible and I just don't see it.)
> ...
> Anyway, I realized that hacking the archive this way isn't very
> elegant, but maybe others would find it useful.  It seems like the
> basic technique of git-rebase could be applied here.

There have been talks about polishing cg-rewritehist into a
shape suitable for inclusion in core git.git, now Cogito is not
actively developed anymore.

I think the first thing to fix is its name "rewritehist", which
may technically be correct, feels a bit too ugly ;-)
