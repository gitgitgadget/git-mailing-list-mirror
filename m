From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] display shortlog after git-commit
Date: Sun, 15 Apr 2007 12:57:02 -0700
Message-ID: <7v4pnh4dip.fsf@assigned-by-dhcp.cox.net>
References: <20070404070135.GF31984@mellanox.co.il>
	<7vd52k7dxi.fsf@assigned-by-dhcp.cox.net>
	<20070415103355.GA12126@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Sun Apr 15 21:57:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdAqV-0003QQ-Gq
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 21:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521AbXDOT5G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 15:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbXDOT5G
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 15:57:06 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:41201 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbXDOT5F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 15:57:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070415195702.HKUV1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Apr 2007 15:57:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id nXx21W00a1kojtg0000000; Sun, 15 Apr 2007 15:57:03 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44509>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

>> I think a much better thing you could do is to have a mode that
>> the commit log message editor is started with something like
>> this...
>
> This would work well for author information, but less well for shortlog.
>
>> 	----------------------------------------------------------------
>> 	From: A U Thor <au.thor@example.com>
>>      Subject: << one line summary of the commit comes here >>
>>         
>> 	<< more detailed explanations come here >>
>> 	# Please enter the commit message for your changes.
>>      # (comment lines starting with '#' will not be included)

Care to share your reasoning behind "less well for shortlog" part?

I think a template like the above makes absolutely clear that
your log would look like a single summary line, and a separate
body of text that explains your change fully, and I do not
understand your concern.
