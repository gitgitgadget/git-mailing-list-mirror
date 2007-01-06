From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Fri, 05 Jan 2007 17:17:33 -0800
Message-ID: <7v4pr5ar82.fsf@assigned-by-dhcp.cox.net>
References: <7vvejlcb6z.fsf@assigned-by-dhcp.cox.net>
	<594263.16987.qm@web31811.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 02:17:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H30Bn-0000lG-GS
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 02:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbXAFBRf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 20:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbXAFBRf
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 20:17:35 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:40334 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbXAFBRf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 20:17:35 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070106011734.KSLR15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Fri, 5 Jan 2007 20:17:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 7dGl1W00w1kojtg0000000; Fri, 05 Jan 2007 20:16:46 -0500
To: ltuikov@yahoo.com
In-Reply-To: <594263.16987.qm@web31811.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Fri, 5 Jan 2007 16:22:35 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36063>

Luben Tuikov <ltuikov@yahoo.com> writes:

>>         [remote "origin"]
>>                 url = http://blah/blah.git
>>                 fetch = refs/heads/master
>> 
>> is also fine.  The point is that you do not have to use tracking
>> branches.  ", and when you get it here, ..." part is optional.
>
> Ok. So then in this case "fetch = refs/heads/master" describes
> .git/refs/heads/master or something else?

It names http://blah/blah.git/refs/heads/master (unless blah.git
repository uses packed refs then has pruned the loose refs).

> If it does, then this is a local map.

No, it is just a list of remote refs (one element list because
there is only one "fetch =" line).

> Does this mean that "fetch = <remote>:" is legal?  Shouldn't the
> RHS always exist?

Documentation/pull-fetch-param.txt
