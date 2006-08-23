From: Jon Loeliger <jdl@jdl.com>
Subject: Proposal for new git Merge Strategy
Date: Wed, 23 Aug 2006 13:40:39 -0500
Message-ID: <E1GFxeZ-0000Nw-ED@jdl.com>
Cc: mwm@mired.org
X-From: git-owner@vger.kernel.org Wed Aug 23 20:41:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFxep-0003Mp-2J
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 20:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbWHWSkq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 14:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWHWSkp
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 14:40:45 -0400
Received: from jdl.com ([66.118.10.122]:7581 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S965092AbWHWSkp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Aug 2006 14:40:45 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1GFxeZ-0000Nw-ED; Wed, 23 Aug 2006 13:40:40 -0500
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25922>

Folks,

The other day, I was talking to some other folks else-list
about git's approach to merges and mentioned that there was
some structure in place to handle different merge strategies.

One person observed that Perforce had a really good
approach to merging and conflict resolution that allowed
user interaction during the process specifically to
help select the individual files and hunks that contributed
to the final result.  I confess that I have never used
Perforce, so this is all hear-say and interpretation. :-)

However, it does seem like an approach that we could
easily add to git -- not as the default of course.
(Just think how dead we'd all be if Linus had to manually
interact with every merge he performed at the tip of the
Linux Pyramid. :-)

But for complex or critical merges, a "guided merge"
strategy seems like it might be a useful tool.  Basically,
it would offer options to select Stage 1 or Stage 2
revisions, or step in and offer hunks from Stage 1 and 2,
revert to "ours" or "theirs", or "revert to 'ours' or 'theirs'
for all remaining files".  Things like that maybe.

Any thoughts down this line?  Good idea?  Bad idea?

Thanks,
jdl

PS -- Please keep mwm on the CC: list as he doesn't
      directly subscribe to the git list, but would
      like to participate in the thread.  Thanks!
