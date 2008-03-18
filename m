From: Jens Axboe <jens.axboe@oracle.com>
Subject: auto gc again
Date: Tue, 18 Mar 2008 19:01:18 +0100
Message-ID: <20080318180118.GC17940@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 20:45:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc4Ce-0002JK-Qd
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 20:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757932AbYCSTmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757906AbYCSTmG
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:42:06 -0400
Received: from brick.kernel.dk ([87.55.233.238]:26259 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757872AbYCSTl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 15:41:59 -0400
Received: by kernel.dk (Postfix, from userid 51)
	id 45A27257FA2; Wed, 19 Mar 2008 20:41:08 +0100 (CET)
Received: by kernel.dk (Postfix, from userid 500)
	id D9E8C258778; Tue, 18 Mar 2008 19:01:18 +0100 (CET)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77520>

Hi,

Could we please PLEASE kill this auto gc thing? I've complained about
this in the past and disabled it through the gc.auto config entry,
however now git seems to be happily auto running gc even with gc.auto=0.
So there's probably some new magic I need to know.

But the new magic is really beside the point. Doing this 'for you' is
extremely annoying behaviour. I often work on my notebook, so disk is
both slow and battery is precious. I DON'T want gc to run automatically,
EVER. Not on repos I have had going for ages, not on ones I just cloned.
Please bury this silly policy and replace it with a printf() telling me
that I may increase my performance by running git gc. Don't just do it.
git does not know better.

 
-- 
Jens Axboe
