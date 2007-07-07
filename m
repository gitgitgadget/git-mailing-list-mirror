From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Per-path attribute based hunk header selection.
Date: Sat, 07 Jul 2007 13:36:17 -0700
Message-ID: <7vsl806jem.fsf@assigned-by-dhcp.cox.net>
References: <7v8x9tdlbv.fsf@assigned-by-dhcp.cox.net>
	<200707071011.l67AB9rg005792@mi0.bluebottle.com>
	<7vabu88qem.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707071317060.4093@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 07 22:36:23 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7H0w-0008R4-LR
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 22:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbXGGUgU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 16:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbXGGUgT
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 16:36:19 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39450 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbXGGUgT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 16:36:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070707203618.QUWK3098.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 7 Jul 2007 16:36:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id LkcH1X00F1kojtg0000000; Sat, 07 Jul 2007 16:36:18 -0400
In-Reply-To: <Pine.LNX.4.64.0707071317060.4093@racer.site> (Johannes
	Schindelin's message of "Sat, 7 Jul 2007 13:17:11 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51842>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Johannes, it strikes me that it is very odd having to add ".*$" at the 
>> end and to surround the whole thing in a parentheses. Shouldn't the 
>> ff_regexp() grabber simply pick the whole line? After all, that is what 
>> GNU "diff -p -F RE" does.
>
> Yes, but then you can forget about your hierarchical idea.

Yeah, I've brought it up just for discussion, but I no longer
think the multi-line pattern that picks pieces and paste them
together is worth it.
