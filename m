From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Tue, 03 Apr 2007 23:09:52 -0700
Message-ID: <7vircc8ybz.fsf@assigned-by-dhcp.cox.net>
References: <20070322104021.GJ29341@mellanox.co.il>
	<7v7it7kkl9.fsf@assigned-by-dhcp.cox.net>
	<20070404060213.GB31984@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Wed Apr 04 08:10:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYygx-0003R6-Oi
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 08:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992678AbXDDGJz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 02:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992683AbXDDGJz
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 02:09:55 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:58909 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992678AbXDDGJy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 02:09:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070404060953.PRQO28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Apr 2007 02:09:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id iu9t1W0031kojtg0000000; Wed, 04 Apr 2007 02:09:53 -0400
In-Reply-To: <20070404060213.GB31984@mellanox.co.il> (Michael S. Tsirkin's
	message of "Wed, 4 Apr 2007 09:02:13 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43709>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

>> When e-mailed message has garbage at the beginning (e.g. "Hi!"),
>> git users can either run "commit --amend" immiediately after
>> "git am",
>
> This one would overwrite the authorship information though,
> would it not? I actually wished several times for an --amend-message
> commit flag that would only edit the message, preserving the author
> (and possibly date?) metadata.
> Of course, I simply copy the author and pass it in --author,
> but it's somewhat awkward to do. Do others notice this?
>
> *Maybe* git can be even smarter, and notice that only
> commit message has changed, and preserve the author automatically
> in this case? I haven't looked at how hard that would be to do.

Maybe you can try what you complain about out before you rant?
I amend other people's commit messages after the fact almost
*every* *day*.
