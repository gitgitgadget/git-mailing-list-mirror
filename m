From: Junio C Hamano <junkio@cox.net>
Subject: Re: Deprecation/Removal schedule
Date: Mon, 05 Feb 2007 09:56:06 -0800
Message-ID: <7vtzy0mqtl.fsf@assigned-by-dhcp.cox.net>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702050814380.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 05 18:56:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE84a-0004hU-Md
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 18:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbXBER4J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 12:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbXBER4I
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 12:56:08 -0500
Received: from fed1rmmtai15.cox.net ([68.230.241.44]:51660 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752626AbXBER4H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 12:56:07 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070205175607.IFLQ1306.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 5 Feb 2007 12:56:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Ktw61W0021kojtg0000000; Mon, 05 Feb 2007 12:56:06 -0500
In-Reply-To: <Pine.LNX.4.64.0702050814380.8424@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 5 Feb 2007 08:26:21 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38762>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Same goes for "git-am". I use "git-applymbox", and I'll happily switch to 
> git-am, but I'd like somebody who knows to document the differences when 
> it gets deprecated. I use "git-applymbox -u", and I guess I just should 
> change that to "git-am --utf8".

True; by the way, for "am", -u is the default these days by
popular demand.  I do not offhand remember if "applymbox" got
corresponding changes (I think it did).

>> * git-p4import, git-quiltimport and contrib/gitview
>> 
>>   These have seen almost no activity since their appearance.  It
>>   could be that they are already perfect and many people are
>>   using them happily, but I find it a bit hard to believe.
>
> I think they're useful to keep around, if for no other reason than as 
> starting points for others.

I strongly agree with the starting-points arguments.  I was
hoping to hear the list to form a consensus to move useful
starting-point examples to contrib/.
