From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use "hash1..hash2" instead of "from hash1 to hash2"
Date: Thu, 28 Sep 2006 19:28:59 -0700
Message-ID: <7v7iznquc4.fsf@assigned-by-dhcp.cox.net>
References: <877iznbq0v.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 04:29:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT87s-0006bt-92
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 04:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbWI2C3I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 22:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbWI2C3G
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 22:29:06 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:60304 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030356AbWI2C3B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 22:29:01 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060929022900.BONA12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Sep 2006 22:29:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id U2V21V00f1kojtg0000000
	Thu, 28 Sep 2006 22:29:03 -0400
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28084>

This kind of "appearance only" change needs better
justification.  Not that I am saying "from .. to" is better for
such and such reasons, but that's how it's been, so if you are
proposing to change it, you need to defend why it would help
users (otherwise I would get hate mails that say "why did you
merge it -- it broke my work habit in such and such way").

You may be doing this for brevity.  In that case, it could
also be worth shortening them to n unique digits; do we have a
command to get "here is the SHA-1; give me its unique
abbreviation at least n letters long but make it longer as
needed to keep it unique"?

You may be doing this to help Cut & Paste.  Using A..B without
spaces in between makes it easy to grab both at the same time as
a range to give them to "git log".  At the same time it makes it
harder to pick only A or B, so this is two-edged.
