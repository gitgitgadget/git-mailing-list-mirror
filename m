From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/3] Somebody updated my branch tip underneath me.
Date: Thu, 29 Mar 2007 13:20:32 -0700
Message-ID: <7vwt0z3ipb.fsf@assigned-by-dhcp.cox.net>
References: <7vslbo4fwx.fsf@assigned-by-dhcp.cox.net>
	<loom.20070329T133700-713@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergio Callegari <scallegari@arces.unibo.it>
X-From: git-owner@vger.kernel.org Thu Mar 29 22:20:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX16q-0000a8-Mb
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 22:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030660AbXC2UUd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 16:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030667AbXC2UUd
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 16:20:33 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:42995 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030660AbXC2UUd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 16:20:33 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070329202032.ZGCL25613.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 29 Mar 2007 16:20:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id gkLX1W00i1kojtg0000000; Thu, 29 Mar 2007 16:20:32 -0400
In-Reply-To: <loom.20070329T133700-713@post.gmane.org> (Sergio Callegari's
	message of "Thu, 29 Mar 2007 11:55:36 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43467>

Sergio Callegari <scallegari@arces.unibo.it> writes:

> Junio C Hamano <junkio <at> cox.net> writes:
>
>> With this series, I am taking hints from Linus and trying to
>> illustrate a problem, show an approach to its solution and code
>> minimally to get others interested enough to follow through.
>> 
>> [PATCH 1/3] Add BASE index extension.
>> [PATCH 2/3] update-index --{set,get}-base
>> [PATCH 3/3] Use BASE index extension in git-commit and git-merge.
>> 
>> The problem description and the strategy to solve it are in the
>> commit log message of [PATCH 3/3].  There I only talk about
>> git-push from elsewhere while we are looking the other way, but
>> the same situation can also happen when you use a lightweight
>> shared working tree (i.e. Julian phillips's git-new-workdir) and
>> make a commit on a branch in one working tree while the other
>> working tree has a checkout of the same branch.
>> 
>> Let's see who are motivated enough to bite.
>> ...
> If (as I am guessing) head detaching is the /only/ possible
> path to recovery, wouldn't it make sense to do it
> automatically, storing somewhere the latest branch one was on
> (e.g. to be used for subsequent merge)?

Answering that is part of "let's see who are motivated enough"
area ;-).  Are you?
