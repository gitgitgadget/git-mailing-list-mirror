From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge summaries
Date: Sat, 19 May 2007 12:24:53 -0700
Message-ID: <7vy7jkwr96.fsf@assigned-by-dhcp.cox.net>
References: <25A3C618-8D12-42A8-9478-D3A4E7633CE7@zib.de>
	<alpine.LFD.0.98.0705181130580.3890@woody.linux-foundation.org>
	<7vodki55px.fsf@assigned-by-dhcp.cox.net>
	<73A1C4C5-50E9-4844-85F8-00D99682B6D4@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat May 19 21:25:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpUY0-0002EL-WF
	for gcvg-git@gmane.org; Sat, 19 May 2007 21:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757414AbXESTYz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 15:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764274AbXESTYz
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 15:24:55 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:60208 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764159AbXESTYy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 15:24:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519192455.MSLP13995.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 19 May 2007 15:24:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 17Qt1X00D1kojtg0000000; Sat, 19 May 2007 15:24:53 -0400
In-Reply-To: <73A1C4C5-50E9-4844-85F8-00D99682B6D4@zib.de> (Steffen Prohaska's
	message of "Sat, 19 May 2007 11:35:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47765>

Steffen Prohaska <prohaska@zib.de> writes:

> What is so wrong if merge summaries of pulls from you were committed
> to topic branches. Later when you pull such branches the summaries
> shouldn't be a problem. A short-log of the topic branch wouldn't
> contain the summaries.
>
> Probably I do not fully understand what "the wrong way around" means.

I think you understand it very well.

As long as you stay as a "pull-only" person, and will never ask
the upstream to pull back from you, what first parent log would
show would make perfectly good sense.  However, once a pull from
you by the upstream happens, the resulting history would get the
summary in the merge you did, which is totally unwanted --- the
upstream already had those summarized commits long time ago in
its history.
