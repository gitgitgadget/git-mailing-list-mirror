From: Junio C Hamano <junkio@cox.net>
Subject: Re: Some index-base bug in "next" branch ("git-applymbox"-related?)..
Date: Thu, 12 Apr 2007 16:07:24 -0700
Message-ID: <7virc1i443.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704121533560.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 01:07:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc8O9-0000FP-U7
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 01:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbXDLXH1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 19:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbXDLXH1
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 19:07:27 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:51378 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbXDLXH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 19:07:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070412230726.JIMC1271.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Thu, 12 Apr 2007 19:07:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id mP7Q1W01B1kojtg0000000; Thu, 12 Apr 2007 19:07:25 -0400
In-Reply-To: <Pine.LNX.4.64.0704121533560.4061@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 12 Apr 2007 15:43:23 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44365>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> That index base thing is definitely *not* ready for merging into master 
> yet!

Heh, I know, as I even left applymbox unpatched (there is a
trivial change made to git-am which should be portable to
applymbox) more or less on purpose to see if anybody noticed
;-).

I've sent messages to the list asking for help in testing and
fixing for a handful times already, and, if we do not count
Shawn mentioning one glitch on #git, this is the first time
anybody said anything about the series.  I am kind of depressed
that you are bringing it up now.
