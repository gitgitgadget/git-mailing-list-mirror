From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in gitk: can't unset "idinlist(...) ..."
Date: Sun, 12 Aug 2007 10:22:11 -0700
Message-ID: <7veji8k6rg.fsf@assigned-by-dhcp.cox.net>
References: <20070810154108.GA779@ruiner>
	<20070810173242.GA23628@coredump.intra.peff.net>
	<alpine.LFD.0.999.0708101109310.30176@woody.linux-foundation.org>
	<18109.21984.26228.849806@cargo.ozlabs.ibm.com>
	<20070811134927.GA2411@coredump.intra.peff.net>
	<18110.63328.644861.651934@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Brian Hetro <whee@smaertness.net>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 19:22:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKH8z-0005j6-Va
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 19:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbXHLRWP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 13:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbXHLRWP
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 13:22:15 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:62051 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765655AbXHLRWN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 13:22:13 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070812172211.SJY7193.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 12 Aug 2007 13:22:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id b5NB1X00g1kojtg0000000; Sun, 12 Aug 2007 13:22:12 -0400
In-Reply-To: <18110.63328.644861.651934@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Sun, 12 Aug 2007 22:04:48 +1000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55692>

Paul Mackerras <paulus@samba.org> writes:

> Jeff King writes:
>
>> gitk fails with this test script, which creates two commits, the second
>> one referencing the first as a duplicate:
>
> Thanks, that shows the problem nicely.  I've pushed out a fix.

Thanks; pulled.
