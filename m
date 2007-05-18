From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge summaries
Date: Fri, 18 May 2007 11:47:38 -0700
Message-ID: <7vodki55px.fsf@assigned-by-dhcp.cox.net>
References: <25A3C618-8D12-42A8-9478-D3A4E7633CE7@zib.de>
	<alpine.LFD.0.98.0705181130580.3890@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 18 20:47:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp7UQ-0002kJ-8C
	for gcvg-git@gmane.org; Fri, 18 May 2007 20:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357AbXERSrj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 14:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755736AbXERSrj
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 14:47:39 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:55711 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754357AbXERSrj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 14:47:39 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070518184739.CWCE6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 18 May 2007 14:47:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 0ind1X00Q1kojtg0000000; Fri, 18 May 2007 14:47:38 -0400
In-Reply-To: <alpine.LFD.0.98.0705181130580.3890@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 18 May 2007 11:33:57 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47630>

Linus Torvalds <torvalds@linux-foundation.org> writes:

>> I have two questions:
>> 1) Why isn't 'true' the default setting? The two probably most prominent git
>> repositories, git and kernel, both use merge summaries.
>
> Think about _who_ uses it for those two prominent repositories for a while.
>
> [ pause, ponder here ]
>
> In other words, "merge.summary" should be true ONLY FOR TOP-LEVEL 
> MAINTAINERS.
>
> Making it true for anybody else is almost always a bug. Yes, I and Junio 
> have it enabled, but pretty much nobody else should, because if they pull 
> from me or Junio in order to merge, their merge summaries would be exactly 
> the wrong way around!

This does not necessarily mean that your lieutenants should not
use merge.summary when they pull from other trees (or inside
their own repository to merge in the topics).  They need to
however disable it with --no-summary when they pull from you
when they choose to merge instead of rebase to adjust to the
updated infrastructure in your tree.
