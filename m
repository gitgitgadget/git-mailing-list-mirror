From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Define a few built-in attribute rules.
Date: Sun, 15 Apr 2007 12:58:14 -0700
Message-ID: <7vwt0d2yw9.fsf@assigned-by-dhcp.cox.net>
References: <7vr6qod4wh.fsf@assigned-by-dhcp.cox.net>
	<200704131033.15751.andyparkins@gmail.com>
	<7vejmm78qp.fsf@assigned-by-dhcp.cox.net>
	<7vvefy5tzo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704141839030.5473@woody.linux-foundation.org>
	<7vr6qm5r73.fsf@assigned-by-dhcp.cox.net>
	<7v8xcu5ps7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704151819390.18846@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Apr 15 22:00:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdAtE-0004QQ-LK
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 22:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554AbXDOT6s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 15:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753577AbXDOT6q
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 15:58:46 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:43994 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554AbXDOT6P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 15:58:15 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070415195816.INWR1266.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Apr 2007 15:58:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id nXyE1W00i1kojtg0000000; Sun, 15 Apr 2007 15:58:15 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44510>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 14 Apr 2007, Junio C Hamano wrote:
>
>> [...] if we really wanted to, we could introduce a way to explicitly say 
>> "Even if the contents do not look like text, apply line ending 
>> conversion, always", by redefining the meaning of 'crlf' attribute.
>
> I think it might make more sense to introduce a way to say "do not even 
> check; I _know_ that I want crlf on these".

You said I wanted to say in the message in clearer words.  We
are in agreement.

Also the comments to the two patches in this series you sent are
valid; I reworked them before merging to 'next' and pushing them
out yesterday, but I think the Makefile thing still remains.
Will fix up.
