From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: make leftmost column of blame less cluttered.
Date: Wed, 04 Oct 2006 18:03:02 -0700
Message-ID: <7v1wpnk20p.fsf@assigned-by-dhcp.cox.net>
References: <20061004155928.57310.qmail@web31809.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 05 03:08:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVHdj-0001nE-Na
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 03:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWJEBDE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 21:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWJEBDE
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 21:03:04 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:30955 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751296AbWJEBDD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Oct 2006 21:03:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061005010303.OWEQ18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Oct 2006 21:03:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id WR2w1V00J1kojtg0000000
	Wed, 04 Oct 2006 21:02:56 -0400
To: ltuikov@yahoo.com
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28337>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Yes, I completely understand the problem you're describing
> here and have seen even more extreme examples of it.

I agree with your conclusion.  More than one commit-8 placed in
a large group end up visually suggesting that they are
separating the group into multiple pieces that have some
meaning, which is not, because the contrast of zebra shading
between groups is very subtle and is much weaker than commit-8
"clickable handles".

I am not suggesting to make the contrast of shading stronger;
that would make things harder to read, and readability matters
more on that page.

Will revert mine from "next" (along with the mistakenly dropped
executable bit) and replace with your patch 1 and 2.
