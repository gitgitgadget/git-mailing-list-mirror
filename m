From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/3] gitweb: blame: print commit8 on the leading row of a commit-block
Date: Wed, 04 Oct 2006 01:18:52 -0700
Message-ID: <7vk63gjxxv.fsf@assigned-by-dhcp.cox.net>
References: <20061004071041.60663.qmail@web31807.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 04 10:19:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GV1xx-0005f7-ME
	for gcvg-git@gmane.org; Wed, 04 Oct 2006 10:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030641AbWJDISy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 04:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030666AbWJDISy
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 04:18:54 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:65205 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030641AbWJDISx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Oct 2006 04:18:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061004081853.XYGF21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Wed, 4 Oct 2006 04:18:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id W8Jv1V00S1kojtg0000000
	Wed, 04 Oct 2006 04:18:56 -0400
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20061004071041.60663.qmail@web31807.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Wed, 4 Oct 2006 00:10:41 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28324>

Luben Tuikov <ltuikov@yahoo.com> writes:

> The following set of patches implements Junio's excellent
> idea of printing the commit-8 only on the leading row of
> a commit block, as well as implementing mouse-over title of
> the author and the date of the commit.

By the way, by definition any idea by me on UI is sucky, not
excellent.

I think this patch gives title= only to rows that happen to be
at the beginning of a block, as opposed to what I placed in
"next" which does it for the whole commit-8 column (and I did
not have to do that for N lines because it uses rowspan to
extend that column over multiple rows), so I suspect it makes
"mouse-over" less useful.
