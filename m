From: Junio C Hamano <junkio@cox.net>
Subject: Re: [DRAFT] Branching and merging with git
Date: Sun, 07 Jan 2007 16:24:08 -0800
Message-ID: <7vzm8uz7pz.fsf@assigned-by-dhcp.cox.net>
References: <20061116221701.4499.qmail@science.horizon.com>
	<20070103170411.GB5491@thunk.org>
	<20070107234411.GD18009@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux@horizon.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 01:24:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3iJC-0006sd-2u
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 01:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965261AbXAHAYL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 19:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965268AbXAHAYK
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 19:24:10 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:56904 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965261AbXAHAYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 19:24:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070108002408.LNFJ25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Sun, 7 Jan 2007 19:24:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8QPJ1W01P1kojtg0000000; Sun, 07 Jan 2007 19:23:19 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20070107234411.GD18009@fieldses.org> (J. Bruce Fields's message
	of "Sun, 7 Jan 2007 18:44:11 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36207>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> I do feel bad about adding yet another piece of documentation, but I we
> need something that goes through all the basics in a logical order, and
> I wasn't seeing how to grow the tutorials into that.
>
> Opinions?

I was having the feeling that we need to start over the
documentation from a clean slate by first coming up with a
coherent presentation order and then filling sections in it,
instead of tweaking existing documents here and there.  The
existing documents were written in different development stages
of git, and each document tries to be more or less independent
from others in the area it wants to talk about, and reading all
of them in _any_ order is not the best way to learn git because
of duplication.  Also I suspect some information in older
documents, while being still valid and technically correct,
predates invention of a better/simpler alternative.

In other words, I think we have enough information in the
tutorial documents, but the problem is not the lack of
information -- the problem is the lack of organization.

I think this effort of yours is wonderful because it directly
tackles that problem.
