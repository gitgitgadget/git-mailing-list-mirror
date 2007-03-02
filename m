From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Remove use of git-rev-parse and replace git-rev-list --pretty with git-log
Date: Fri, 02 Mar 2007 15:10:39 -0800
Message-ID: <7vbqjbdyxc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0703020839350.3953@woody.linux-foundation.org>
	<200703021929.20969.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 00:11:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNGuF-0007gD-6P
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 00:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992723AbXCBXK5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 18:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992722AbXCBXK5
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 18:10:57 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:54732 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992720AbXCBXKz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 18:10:55 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070302231055.MCHL1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Fri, 2 Mar 2007 18:10:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VzAp1W0051kojtg0000000; Fri, 02 Mar 2007 18:10:55 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41258>

Andy Parkins <andyparkins@gmail.com> writes:

> Linus noticed:
>
> --- >8 ---
> it should just avoid git-rev-parse these days and do
>
>   git rev-list --pretty $newrev --not --all
>
> instead. And quite frankly, rather than "git rev-list --pretty", there's
> no real reason not to do
>
>   git log $newrev --not --all
> --- 8< ---
>
> This patch makes those changes.
>
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>

Please look at your Subject: line above and ponder how it would
look in the next issue of "What's cooking in git.git".  Do I
have to spend extra brain cycles to go back to "git log --stat"
and realize that this one only updates a sample hook script?

Also, please don't do "--- >8 ---".  If you want to, please use
two dashes; this is purely for technical reasons.

I'll massage the log message and move "^$base --not" around as
Linus suggested, but next time please be a bit more careful.
