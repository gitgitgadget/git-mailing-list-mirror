From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] gitweb: blame: Print just a single new line char per table row
Date: Wed, 04 Oct 2006 19:35:48 -0700
Message-ID: <7vejtnij5n.fsf@assigned-by-dhcp.cox.net>
References: <20061005005926.57010.qmail@web31808.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 05 04:35:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVJ5U-0003PU-PK
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 04:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWJECfu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 22:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWJECfu
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 22:35:50 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:27799 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751334AbWJECft (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Oct 2006 22:35:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061005023548.ISCA21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Oct 2006 22:35:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id WSbh1V00r1kojtg0000000
	Wed, 04 Oct 2006 22:35:42 -0400
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20061005005926.57010.qmail@web31808.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Wed, 4 Oct 2006 17:59:26 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28343>

Luben Tuikov <ltuikov@yahoo.com> writes:

> This makes cut-and-paste from blame legible, else after
> pasting it is broken into too many lines.
>
> Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>

I have to say the browser is seriously broken if whitespaces
between <tr> and <td>, </td> and next <td>, </td> and </tr>
makes a difference to its behaviour.  Aren't there a way to tell
the browser to cut "visually"?  E.g. "The area I want to cut is
from this data column, and lines from here to there.  I do not
want the leftmost two columns (commit-8 and lineno)".

I do not mind applying this, but that is only because it does
not make its source any less readable.  It does make things
harder to debug if somebody is debugging its output by reading
the generated raw HTML, so it is not like there is no downside.

You might want to run links (or lynx) in screen ;-).  Screen
supports left- (or right-, or both-sides) bounded cut which I
find extremely useful.
