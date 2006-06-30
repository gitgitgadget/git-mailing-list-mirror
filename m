From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-grep: --and to combine patterns with and instead of or
Date: Fri, 30 Jun 2006 12:57:32 +0200
Message-ID: <E1FwGgm-0006Nc-9a@moooo.ath.cx>
References: <20060625184757.f8273820.tihirvon@gmail.com> <E1FuX8l-0001H5-2z@moooo.ath.cx> <Pine.LNX.4.63.0606260108510.29667@wbgn013.biozentrum.uni-wuerzburg.de> <E1FueYh-0004XE-Fg@moooo.ath.cx> <20060629222009.GA9310@cip.informatik.uni-erlangen.de> <7vejx7oa3x.fsf@assigned-by-dhcp.cox.net> <E1Fw8hS-00023y-FY@moooo.ath.cx> <7v7j2zmgbu.fsf@assigned-by-dhcp.cox.net> <E1FwDiI-0007Xp-2s@moooo.ath.cx> <7v3bdnkrfb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 12:57:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwGgv-0002cZ-Ee
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 12:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWF3K5i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 06:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWF3K5i
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 06:57:38 -0400
Received: from moooo.ath.cx ([85.116.203.178]:65445 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1750779AbWF3K5h (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 06:57:37 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v3bdnkrfb.fsf@assigned-by-dhcp.cox.net>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22980>

Junio C Hamano wrote:
> I see you are trying hard to think of a way to justify your
> original prefix "--and" (or --FOO) implementation, but I simply
> do not see much point in that.  I doubt changing the default
> operator from --or to --and is less confusing than changing the
> precedence for the users, so you would hear the same "I
> personally feel FOO should not even exist" objection from me.

It just happens to make more sense to me and I don't see a reason not to
add this. If no one else is interested in this I'll just stop arguing :)
Here again an overview of the arguments if anyone is interested:
- Less to type for common searches using only AND (or more ANDs than
  ORs).
- Easy to implement (both with and without extended expressions).
- AND/* is the normal implicit operator in other contexts than grep
  (math).
- The high precedence operator (AND) should be implicit rather than
  the low precedence one (OR) (so this is only fulfilled when the
  option is used).
