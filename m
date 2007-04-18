From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-format-patch for binary files / merges [Re: Expose subprojects as special files to "git diff" machinery]
Date: Wed, 18 Apr 2007 09:08:01 -0700
Message-ID: <7vlkgpis2m.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704151100550.5473@woody.linux-foundation.org>
	<200704152116.26773.andyparkins@gmail.com>
	<Pine.LNX.4.64.0704151402130.5473@woody.linux-foundation.org>
	<4625DAEE.3090702@vilain.net>
	<alpine.LFD.0.98.0704180831330.2828@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, Andy Parkins <andyparkins@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 18:08:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeChv-00029p-Og
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 18:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbXDRQIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 12:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754118AbXDRQIG
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 12:08:06 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:65460 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113AbXDRQIE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 12:08:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418160802.CEQP1226.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Apr 2007 12:08:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id og811W01d1kojtg0000000; Wed, 18 Apr 2007 12:08:02 -0400
In-Reply-To: <alpine.LFD.0.98.0704180831330.2828@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 18 Apr 2007 08:47:39 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44906>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> We do already support binary patches, so those can be represented well in 
> a patch (but you need "git-apply" to apply them, so they are disabled by 
> default.. And while we have tests for them, I suspect not a lot of people 
> really use them widely, so who knows how complete the coverage is. For 
> example, will "git rebase" really work? Probably. Do I know for sure? No).

I've seen it in action for at least a few times in my day-job,
so it appears to work ;-)

>    I used "bundles" once or twice under BK (it was called "bk send" and 
>    "bk receive + bk resolve" or something like that), and I hated them. It 
>    wasn't BK's fault: I just found the workflow annoying. So I haven't 
>    even tested the git bundles, but if what you were looking for was to do 
>    a "git push/pull" by email, they are what you'd be using.

I've send a bundle over e-mail exactly once; it appears to work,
too.
