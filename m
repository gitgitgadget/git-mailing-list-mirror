From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improved hint on how to set identity
Date: Mon, 13 Aug 2007 16:36:53 -0700
Message-ID: <7vbqdbf1m2.fsf@assigned-by-dhcp.cox.net>
References: <1187042750257-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Aug 14 01:37:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKjT2-00064N-H6
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 01:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757095AbXHMXg4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 19:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757333AbXHMXg4
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 19:36:56 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39835 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757095AbXHMXgz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 19:36:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070813233653.SRLD1335.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 13 Aug 2007 19:36:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bbct1X00W1kojtg0000000; Mon, 13 Aug 2007 19:36:54 -0400
In-Reply-To: <1187042750257-git-send-email-prohaska@zib.de> (Steffen
	Prohaska's message of "Tue, 14 Aug 2007 00:05:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55794>

Steffen Prohaska <prohaska@zib.de> writes:

> Users typically want to set the default for their account. Thus,
> start the hint with how to achieve that; and only later explain
> how to restrict identity to a single repository.

If this were about the introductory part of the user manual, I
would definitely vote for suggesting the --global one first as
the baby steps will be done with one practice/sandbox repository
and then when the user graduates to work on other projects and
possibly under a different identity, it would make sense to
introduce the non global one as an advanced option.

> I watched someone setting up git, who never used it before.
> The hint was leading him into the wrong direction.

Real-life new user experience is a very valuable one.  Can you
elaborate how the hint led in a _wrong_ direction?  What is the
definition of "wrong" here?  It may be that not using --global
is perfectly the correct thing to do.  It really depends on the
project and the situation.

The condition to cause this error message to be shown is
probably a borderline, compared to the earlier "introductory
part of the manual" case.  You may have set an identity in one
repository without global, and then switched to another
repository and saw this message.  In which case you may want to
use a different identity or the same one and I would not say
which one is more common in the case for such a "second
repository".  When you work on two projects, managed by two
different organizations, it often is that you would want
per-repository identity.

Was this the first repository for this person to set up?
