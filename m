From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Preferring shallower deltas on repack
Date: Sun, 08 Jul 2007 22:43:26 -0700
Message-ID: <7vsl7yw2rl.fsf@assigned-by-dhcp.cox.net>
References: <20070709044326.GH4087@lavos.net>
	<7v1wfixhvk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bdowning@lavos.net (Brian Downing)
X-From: git-owner@vger.kernel.org Mon Jul 09 07:43:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7m1y-0001OH-Qt
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 07:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbXGIFn2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 01:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbXGIFn2
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 01:43:28 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:65300 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbXGIFn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 01:43:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070709054326.EAIM22777.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 9 Jul 2007 01:43:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MHjS1X0071kojtg0000000; Mon, 09 Jul 2007 01:43:27 -0400
In-Reply-To: <7v1wfixhvk.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 08 Jul 2007 22:31:43 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51959>

Junio C Hamano <gitster@pobox.com> writes:

> It would become worrysome (*BUT* infinitely more interesting)
> once you start talking about a tradeoff between slightly larger
> delta and much shorter delta.  Such a tradeoff, if done right,

s/and much shorter delta/and much shallower depth/.

Should be obvious from the context, but just in case -- without
the above correction what I said does not make any sense ;-).

> would make a lot of sense, but I do not offhand think of a way
> to strike a proper balance between them efficiently.
